local FindMetaTable = FindMetaTable
local net = net
local hook = hook
local table = table
local math = math
local DarkRP = DarkRP

util.AddNetworkString("Redline_InventoryOpen")
util.AddNetworkString("Redline_InventorySync")
util.AddNetworkString("Redline_InventoryAction")
util.AddNetworkString("Redline_BarMenuOpen")
util.AddNetworkString("Redline_BarAction")

local PLAYER = FindMetaTable("Player")

local function createDefaultInventory()
    return {
        items = {},
        capacity = DarkRP.InventorySlots,
    }
end

local function sendInventoryOpen(ply)
    net.Start("Redline_InventoryOpen")
        net.WriteTable({
            items = ply.RedlineInventory.items,
            capacity = ply.RedlineInventory.capacity,
            suit = ply.RedlineSuit,
        })
    net.Send(ply)
end

local function sendInventorySync(ply)
    net.Start("Redline_InventorySync")
        net.WriteTable({
            items = ply.RedlineInventory.items,
            capacity = ply.RedlineInventory.capacity,
            suit = ply.RedlineSuit,
        })
    net.Send(ply)
end

function PLAYER:RedlineInitInventory()
    if self.RedlineInventory then return end
    self.RedlineInventory = createDefaultInventory()
    self.RedlineSuit = nil
end

function PLAYER:HasInventorySpace()
    return #self.RedlineInventory.items < self.RedlineInventory.capacity
end

function PLAYER:FindRedlineItem(itemID)
    for k, item in ipairs(self.RedlineInventory.items) do
        if item.id == itemID then
            return k, item
        end
    end
end

function PLAYER:AddRedlineItem(itemID, customData)
    local definition = DarkRP.getInventoryItem(itemID)
    if not definition then return false end
    if not self:HasInventorySpace() then return false end

    local entry = {
        id = definition.id,
        name = definition.name,
        type = definition.type,
        rarity = definition.rarity or "common",
    }
    if customData then
        for k, v in pairs(customData) do
            entry[k] = v
        end
    end
    table.insert(self.RedlineInventory.items, entry)
    return true
end

function PLAYER:RemoveRedlineItemByIndex(index)
    table.remove(self.RedlineInventory.items, index)
end

function PLAYER:EquipRedlineSuit(itemID)
    local index, entry = self:FindRedlineItem(itemID)
    local definition = DarkRP.getInventoryItem(itemID)
    if not index or not definition or definition.type ~= "suit" then return false end

    if self.RedlineSuit then
        if not self:UnequipRedlineSuit() then return false end
    end

    local rarity = definition.rarity or "common"
    local bonus = DarkRP.getInventoryRarity(rarity).bonus
    local armor = math.max(0, math.ceil((definition.armor or 0) * bonus))
    local durability = entry.durability or math.max(1, math.ceil((definition.durability or 0) * bonus))

    self:RemoveRedlineItemByIndex(index)
    self.RedlineSuit = {
        id = definition.id,
        name = definition.name,
        armor = armor,
        durability = durability,
        tier = definition.tier,
        nextTier = definition.nextTier,
        rarity = rarity,
    }
    self:SetArmor(armor)
    return true
end

function PLAYER:UnequipRedlineSuit()
    if not self.RedlineSuit then return false end
    if not self:HasInventorySpace() then return false end

    local suitID = self.RedlineSuit.id
    local durability = self.RedlineSuit.durability
    self.RedlineSuit = nil
    self:SetArmor(0)

    self:AddRedlineItem(suitID, {durability = durability})
    return true
end

function PLAYER:UpgradeRedlineSuit()
    if not self.RedlineSuit then return false, "No suit is equipped." end

    local current = DarkRP.getInventoryItem(self.RedlineSuit.id)
    if not current or not current.nextTier then return false, "That suit cannot be upgraded further." end

    local nextTier = DarkRP.getInventoryItem(current.nextTier)
    if not nextTier or not nextTier.upgradeCost then return false, "Unable to locate upgraded suit." end
    if not self:canAfford(nextTier.upgradeCost) then return false, "You cannot afford this upgrade." end

    self:addMoney(-nextTier.upgradeCost)
    self.RedlineSuit.id = nextTier.id
    self.RedlineSuit.name = nextTier.name
    self.RedlineSuit.armor = nextTier.armor
    self.RedlineSuit.durability = math.max(self.RedlineSuit.durability, nextTier.durability)
    self.RedlineSuit.tier = nextTier.tier
    self.RedlineSuit.nextTier = nextTier.nextTier
    self:SetArmor(nextTier.armor)
    return true
end

function PLAYER:UseRedlineItem(itemID)
    local index, entry = self:FindRedlineItem(itemID)
    if not index or not entry then return false, "Item not found." end

    local definition = DarkRP.getInventoryItem(entry.id)
    if not definition then return false, "Invalid item." end

    local rarity = entry.rarity or definition.rarity or "common"
    local bonus = DarkRP.getInventoryRarity(rarity).bonus

    if definition.type == "consumable" then
        if definition.heal then
            local heal = math.ceil((definition.heal + (entry.bonus or 0)) * bonus)
            self:SetHealth(math.min(self:GetMaxHealth(), self:Health() + heal))
        end
        if definition.armor then
            local armor = math.ceil((definition.armor + (entry.bonus or 0)) * bonus)
            self:SetArmor(math.min(100, self:Armor() + armor))
        end
        DarkRP.notify(self, 0, 4, "You used " .. definition.name .. " [" .. DarkRP.getInventoryRarityName(rarity) .. "].")
    elseif definition.type == "upgrade" then
        self.RedlineInventory.capacity = self.RedlineInventory.capacity + 2
        DarkRP.notify(self, 0, 5, "Inventory capacity increased to " .. self.RedlineInventory.capacity .. ".")
    else
        return false, "This item cannot be used directly."
    end

    self:RemoveRedlineItemByIndex(index)
    return true
end

local function applyRedlineSuit(ply)
    if ply.RedlineSuit and ply.RedlineSuit.armor then
        ply:SetArmor(ply.RedlineSuit.armor)
    end
end

local function openNearestBar(ply)
    local nearest
    local dist = 325
    for _, ent in ipairs(ents.FindByClass("bartender_bar")) do
        if not IsValid(ent) then continue end
        local d = ent:GetPos():Distance(ply:GetPos())
        if d < dist then
            dist = d
            nearest = ent
        end
    end
    if not IsValid(nearest) then
        DarkRP.notify(ply, 1, 4, "No bar counter is nearby.")
        return ""
    end

    local owner = IsValid(nearest:Getowning_ent()) and nearest:Getowning_ent():Nick() or "No owner"
    net.Start("Redline_BarMenuOpen")
        net.WriteEntity(nearest)
        net.WriteTable({
            ownerName = owner,
            isOwner = nearest:Getowning_ent() == ply,
            priceModifier = nearest:GetPriceModifier(),
            premiumBonus = nearest:GetPremiumBonus(),
            serviceBonus = nearest:GetServiceBonus(),
        })
    net.Send(ply)
    return ""
end

local function openInventoryMenu(ply)
    ply:RedlineInitInventory()
    sendInventoryOpen(ply)
    return ""
end

DarkRP.defineChatCommand("inventory", openInventoryMenu)
DarkRP.defineChatCommand("suit", openInventoryMenu)
DarkRP.defineChatCommand("bar", openNearestBar)

net.Receive("Redline_InventoryAction", function(len, ply)
    local action = net.ReadString()
    local itemID = net.ReadString()
    local success, reason

    if action == "equip" then
        success = ply:EquipRedlineSuit(itemID)
        if success then
            DarkRP.notify(ply, 0, 4, "Suit equipped: " .. itemID)
        else
            DarkRP.notify(ply, 1, 4, "Unable to equip that suit.")
        end
    elseif action == "unequip" then
        success = ply:UnequipRedlineSuit()
        if success then
            DarkRP.notify(ply, 0, 4, "Suit unequipped.")
        else
            DarkRP.notify(ply, 1, 4, "Cannot unequip right now; inventory is full.")
        end
    elseif action == "use" then
        success, reason = ply:UseRedlineItem(itemID)
        if success then
            DarkRP.notify(ply, 0, 4, "Item used.")
        else
            DarkRP.notify(ply, 1, 4, reason or "Unable to use item.")
        end
    elseif action == "purchase" then
        local definition = DarkRP.getInventoryItem(itemID)
        if not definition then
            DarkRP.notify(ply, 1, 4, "Invalid item.")
            success = false
        elseif not ply:canAfford(definition.price) then
            DarkRP.notify(ply, 1, 4, "You cannot afford " .. definition.name .. ".")
            success = false
        elseif not ply:HasInventorySpace() then
            DarkRP.notify(ply, 1, 4, "Not enough inventory space.")
            success = false
        else
            ply:addMoney(-definition.price)
            ply:AddRedlineItem(itemID)
            DarkRP.notify(ply, 0, 4, "Purchased " .. definition.name .. ".")
            success = true
        end
    elseif action == "upgradeSuit" then
        success, reason = ply:UpgradeRedlineSuit()
        if success then
            DarkRP.notify(ply, 0, 4, "Suit upgraded to a higher tier.")
        else
            DarkRP.notify(ply, 1, 4, reason or "Unable to upgrade suit.")
        end
    else
        DarkRP.notify(ply, 1, 4, "Unknown inventory action.")
    end

    sendInventorySync(ply)
end)

local function sendBarMenu(ply, ent)
    if not IsValid(ent) then return end
    local owner = IsValid(ent:Getowning_ent()) and ent:Getowning_ent():Nick() or "No owner"
    net.Start("Redline_BarMenuOpen")
        net.WriteEntity(ent)
        net.WriteTable({
            ownerName = owner,
            isOwner = ent:Getowning_ent() == ply,
            priceModifier = ent:GetPriceModifier(),
            premiumBonus = ent:GetPremiumBonus(),
            serviceBonus = ent:GetServiceBonus(),
        })
    net.Send(ply)
end

net.Receive("Redline_BarAction", function(len, ply)
    local action = net.ReadString()
    local ent = net.ReadEntity()
    if not IsValid(ent) or ent:GetClass() ~= "bartender_bar" then return end

    if action == "buyDrink" then
        local price = math.max(1, math.ceil(100 * (1 + ent:GetPriceModifier())))
        if not ply:canAfford(price) then
            DarkRP.notify(ply, 1, 4, "You cannot afford a drink.")
            return
        end
        if not ply:HasInventorySpace() then
            DarkRP.notify(ply, 1, 4, "Your inventory is full.")
            return
        end
        ply:addMoney(-price)
        local owner = ent:Getowning_ent()
        if IsValid(owner) and owner ~= ply then
            local revenue = math.ceil(price * 0.80) + math.ceil(price * ent:GetServiceBonus())
            owner:addMoney(revenue)
            DarkRP.notify(owner, 0, 4, ply:Nick() .. " bought a drink from your bar.")
        end
        ply:AddRedlineItem("redline_cocktail", {bonus = math.floor(ent:GetPremiumBonus() * 10)})
        DarkRP.notify(ply, 0, 4, "You bought a drink and added it to your inventory.")
        sendInventorySync(ply)
        return
    elseif action == "buyUpgrade" then
        local upgradeID = net.ReadString()
        local upgrade = DarkRP.getBarUpgrade(upgradeID)
        if not upgrade then return end
        if ent:Getowning_ent() ~= ply then
            DarkRP.notify(ply, 1, 4, "Only the owner can upgrade this bar.")
            return
        end
        if not ply:canAfford(upgrade.price) then
            DarkRP.notify(ply, 1, 4, "You cannot afford that upgrade.")
            return
        end
        if upgradeID == "happy_hour" and ent:GetPriceModifier() > 0 then
            DarkRP.notify(ply, 1, 4, "This upgrade has already been purchased.")
            return
        elseif upgradeID == "premium_spirits" and ent:GetPremiumBonus() > 0 then
            DarkRP.notify(ply, 1, 4, "This upgrade has already been purchased.")
            return
        elseif upgradeID == "service_robot" and ent:GetServiceBonus() > 0 then
            DarkRP.notify(ply, 1, 4, "This upgrade has already been purchased.")
            return
        end
        ply:addMoney(-upgrade.price)
        if upgradeID == "happy_hour" then
            ent:SetPriceModifier(ent:GetPriceModifier() + upgrade.bonus)
        elseif upgradeID == "premium_spirits" then
            ent:SetPremiumBonus(ent:GetPremiumBonus() + upgrade.bonus)
        elseif upgradeID == "service_robot" then
            ent:SetServiceBonus(ent:GetServiceBonus() + upgrade.bonus)
        end
        DarkRP.notify(ply, 0, 4, "Bar upgraded: " .. upgrade.name)
        sendBarMenu(ply, ent)
        return
    end
end)

hook.Add("PlayerInitialSpawn", "RedlineInventoryInit", function(ply)
    ply:RedlineInitInventory()
    sendInventorySync(ply)
end)

hook.Add("PlayerSpawn", "RedlineInventorySpawn", function(ply)
    ply:RedlineInitInventory()
    applyRedlineSuit(ply)
    sendInventorySync(ply)
end)

hook.Add("EntityTakeDamage", "RedlineSuitDamage", function(target, dmginfo)
    if not target:IsPlayer() or not target.RedlineSuit then return end

    local suit = target.RedlineSuit
    local damage = dmginfo:GetDamage()
    local loss = math.max(1, math.ceil(damage * 0.6))
    suit.durability = suit.durability - loss

    if suit.durability <= 0 then
        target:ChatPrint("Your Redline Suit shattered under the attack!")
        target:UnequipRedlineSuit()
        sendInventorySync(target)
    else
        target:ChatPrint("Suit durability " .. suit.durability .. " remaining.")
    end
end)
