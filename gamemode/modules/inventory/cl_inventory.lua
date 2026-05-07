local net = net
local vgui = vgui
local surface = surface
local draw = draw
local math = math
local LocalPlayer = LocalPlayer

local inventoryFrame

local function sendInventoryAction(action, itemID)
    net.Start("Redline_InventoryAction")
        net.WriteString(action)
        net.WriteString(itemID or "")
    net.SendToServer()
end

local function sendBarAction(ent, action, extra)
    net.Start("Redline_BarAction")
        net.WriteString(action)
        net.WriteEntity(ent)
        if extra then net.WriteString(extra) end
    net.SendToServer()
end

local function formatItemRow(panel, label, value)
    local text = vgui.Create("DLabel", panel)
    text:SetText(label .. value)
    text:SetTextColor(Color(255, 255, 255))
    text:SetFont("DermaDefaultBold")
    text:SizeToContents()
    return text
end

local function BuildInventoryMenu(data)
    if IsValid(inventoryFrame) then inventoryFrame:Remove() end

    inventoryFrame = vgui.Create("DFrame")
    inventoryFrame:SetTitle("Redline Inventory")
    inventoryFrame:SetSize(580, 460)
    inventoryFrame:Center()
    inventoryFrame:MakePopup()
    inventoryFrame.Paint = function(self, w, h)
        draw.RoundedBox(8, 0, 0, w, h, Color(20, 0, 0, 220))
        draw.RoundedBox(8, 0, 0, w, 24, Color(160, 0, 0, 220))
    end

    local title = inventoryFrame:GetLabel()
    if title then inventoryFrame:SetTitle("Redline Inventory") end

    local infoLabel = vgui.Create("DLabel", inventoryFrame)
    infoLabel:SetPos(16, 34)
    infoLabel:SetText(string.format("Slots: %d / %d", #data.items, data.capacity))
    infoLabel:SetTextColor(Color(255, 255, 255))
    infoLabel:SetFont("DermaLarge")
    infoLabel:SizeToContents()

    local y = 70
    if data.suit then
        local suitRarity = data.suit.rarity and string.upper(data.suit.rarity:gsub("_", " ")) or "COMMON"
        local suitLabel = vgui.Create("DLabel", inventoryFrame)
        suitLabel:SetPos(16, y)
        suitLabel:SetText(string.format("Equipped Suit: %s (%s) - Durability %d", data.suit.name, suitRarity, data.suit.durability))
        suitLabel:SetTextColor(Color(255, 200, 0))
        suitLabel:SetFont("DermaDefaultBold")
        suitLabel:SizeToContents()
        y = y + 24

        local upgradeButton = vgui.Create("DButton", inventoryFrame)
        upgradeButton:SetPos(16, y)
        upgradeButton:SetSize(200, 24)
        upgradeButton:SetText("Upgrade Suit")
        upgradeButton.DoClick = function()
            sendInventoryAction("upgradeSuit", "")
        end
        local unequipButton = vgui.Create("DButton", inventoryFrame)
        unequipButton:SetPos(230, y)
        unequipButton:SetSize(200, 28)
        unequipButton:SetText("Unequip Suit")
        unequipButton.DoClick = function()
            sendInventoryAction("unequip", "")
        end
        y = y + 34
    end

    local scroll = vgui.Create("DScrollPanel", inventoryFrame)
    scroll:SetPos(16, y)
    scroll:SetSize(548, 260)

    local layout = vgui.Create("DIconLayout", scroll)
    layout:Dock(FILL)
    layout:SetSpaceY(8)
    layout:SetSpaceX(8)

    for _, item in ipairs(data.items) do
        local panel = vgui.Create("DPanel")
        panel:SetSize(260, 100)
        panel.Paint = function(self, w, h)
            draw.RoundedBox(8, 0, 0, w, h, Color(45, 0, 0, 190))
        end

        local name = vgui.Create("DLabel", panel)
        name:SetPos(8, 8)
        name:SetText(item.name)
        name:SetTextColor(Color(255, 255, 255))
        name:SetFont("DermaDefaultBold")
        name:SizeToContents()

        local details = vgui.Create("DLabel", panel)
        details:SetPos(8, 28)
        details:SetText(string.format("Type: %s", item.type or "Unknown"))
        details:SetTextColor(Color(200, 200, 200))
        details:SizeToContents()

        local rarityText = item.rarity and string.upper(item.rarity:gsub("_", " ")) or "COMMON"
        local rarityColor = Color(200, 200, 200)
        if item.rarity == "uncommon" then rarityColor = Color(100, 220, 100)
        elseif item.rarity == "rare" then rarityColor = Color(100, 180, 255)
        elseif item.rarity == "legendary" then rarityColor = Color(200, 120, 255)
        elseif item.rarity == "god" then rarityColor = Color(255, 200, 60)
        elseif item.rarity == "ultra_god" then rarityColor = Color(255, 120, 180)
        elseif item.rarity == "admin" then rarityColor = Color(255, 60, 60)
        end

        local rarityLabel = vgui.Create("DLabel", panel)
        rarityLabel:SetPos(8, 44)
        rarityLabel:SetText("Rarity: " .. rarityText)
        rarityLabel:SetTextColor(rarityColor)
        rarityLabel:SizeToContents()

        if item.durability then
            local dur = vgui.Create("DLabel", panel)
            dur:SetPos(8, 60)
            dur:SetText("Durability: " .. item.durability)
            dur:SetTextColor(Color(200, 200, 200))
            dur:SizeToContents()
        end

        local button = vgui.Create("DButton", panel)
        button:SetPos(8, item.durability and 84 or 60)
        button:SetSize(120, 24)
        button:SetText(item.type == "suit" and "Equip" or "Use")
        button.DoClick = function()
            if item.type == "suit" then
                sendInventoryAction("equip", item.id)
            else
                sendInventoryAction("use", item.id)
            end
        end

        local removeButton = vgui.Create("DButton", panel)
        removeButton:SetPos(136, 60)
        removeButton:SetSize(120, 24)
        removeButton:SetText("Drop")
        removeButton.DoClick = function()
            -- Dropping is not supported yet
            LocalPlayer():ChatPrint("Use is the only supported inventory action for now.")
        end

        layout:Add(panel)
    end

    local buttonWidth = 160
    local buyY = y + 270

    local purchaseSuit = vgui.Create("DButton", inventoryFrame)
    purchaseSuit:SetPos(16, buyY)
    purchaseSuit:SetSize(buttonWidth, 28)
    purchaseSuit:SetText("Buy Redline Suit ($750)")
    purchaseSuit.DoClick = function()
        sendInventoryAction("purchase", "suit_redline")
    end

    local purchaseDrink = vgui.Create("DButton", inventoryFrame)
    purchaseDrink:SetPos(16 + buttonWidth + 10, buyY)
    purchaseDrink:SetSize(buttonWidth, 28)
    purchaseDrink:SetText("Buy Energy Drink ($150)")
    purchaseDrink.DoClick = function()
        sendInventoryAction("purchase", "energy_drink")
    end

    local purchaseExpansion = vgui.Create("DButton", inventoryFrame)
    purchaseExpansion:SetPos(16 + (buttonWidth + 10) * 2, buyY)
    purchaseExpansion:SetSize(buttonWidth, 28)
    purchaseExpansion:SetText("Buy Backpack Expansion ($400)")
    purchaseExpansion.DoClick = function()
        sendInventoryAction("purchase", "backpack_expansion")
    end
end

local function BuildBarMenu(ent, data)
    if IsValid(inventoryFrame) then inventoryFrame:Remove() end

    inventoryFrame = vgui.Create("DFrame")
    inventoryFrame:SetTitle("Redline Bar")
    inventoryFrame:SetSize(520, 380)
    inventoryFrame:Center()
    inventoryFrame:MakePopup()
    inventoryFrame.Paint = function(self, w, h)
        draw.RoundedBox(8, 0, 0, w, h, Color(20, 0, 0, 220))
        draw.RoundedBox(8, 0, 0, w, 24, Color(160, 0, 0, 220))
    end

    local ownerLabel = vgui.Create("DLabel", inventoryFrame)
    ownerLabel:SetPos(16, 34)
    ownerLabel:SetText("Bar owner: " .. data.ownerName)
    ownerLabel:SetTextColor(Color(255, 255, 255))
    ownerLabel:SetFont("DermaLarge")
    ownerLabel:SizeToContents()

    local priceLabel = vgui.Create("DLabel", inventoryFrame)
    priceLabel:SetPos(16, 68)
    priceLabel:SetText("Drink price: $" .. math.max(1, math.ceil(100 * (1 + data.priceModifier))))
    priceLabel:SetTextColor(Color(255, 200, 200))
    priceLabel:SizeToContents()

    local bonusLabel = vgui.Create("DLabel", inventoryFrame)
    bonusLabel:SetPos(16, 92)
    bonusLabel:SetText(string.format("Premium quality: %d%%  Tip bonus: %d%%", math.floor(data.premiumBonus * 100), math.floor(data.serviceBonus * 100)))
    bonusLabel:SetTextColor(Color(200, 200, 255))
    bonusLabel:SizeToContents()

    local buyButton = vgui.Create("DButton", inventoryFrame)
    buyButton:SetPos(16, 130)
    buyButton:SetSize(200, 28)
    buyButton:SetText("Buy Drink")
    buyButton.DoClick = function()
        sendBarAction(ent, "buyDrink")
    end

    if data.isOwner then
        local upgradeY = 170
        local upgrades = {
            {id = "happy_hour", text = "Happy Hour ($1000)", disabled = data.priceModifier > 0},
            {id = "premium_spirits", text = "Premium Spirits ($2000)", disabled = data.premiumBonus > 0},
            {id = "service_robot", text = "Service Robot ($3000)", disabled = data.serviceBonus > 0},
        }

        for _, upgrade in ipairs(upgrades) do
            local btn = vgui.Create("DButton", inventoryFrame)
            btn:SetPos(16, upgradeY)
            btn:SetSize(380, 28)
            btn:SetText(upgrade.text)
            btn:SetDisabled(upgrade.disabled)
            btn.DoClick = function()
                sendBarAction(ent, "buyUpgrade", upgrade.id)
            end
            upgradeY = upgradeY + 36
        end
    end
end

net.Receive("Redline_InventoryOpen", function()
    local data = net.ReadTable()
    BuildInventoryMenu(data)
end)

net.Receive("Redline_InventorySync", function()
    local data = net.ReadTable()
    LocalPlayer().RedlineInventory = data
    if IsValid(inventoryFrame) and inventoryFrame:GetTitle() == "Redline Inventory" then
        BuildInventoryMenu(data)
    end
end)

net.Receive("Redline_BarMenuOpen", function()
    local ent = net.ReadEntity()
    local data = net.ReadTable()
    BuildBarMenu(ent, data)
end)
