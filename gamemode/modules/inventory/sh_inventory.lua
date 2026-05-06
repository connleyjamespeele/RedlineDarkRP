DarkRP.InventoryItems = DarkRP.InventoryItems or {
    suit_redline = {
        id = "suit_redline",
        name = "Redline Suit",
        description = "A crimson protective suit built for frontline operators.",
        type = "suit",
        armor = 25,
        durability = 100,
        tier = 1,
        nextTier = "suit_reinforced",
        price = 750,
        upgradeCost = 1200,
    },
    suit_reinforced = {
        id = "suit_reinforced",
        name = "Reinforced Redline Suit",
        description = "A stronger suit that slows damage and holds up longer.",
        type = "suit",
        armor = 40,
        durability = 150,
        tier = 2,
        nextTier = "suit_advanced",
        price = 2000,
        upgradeCost = 2200,
    },
    suit_advanced = {
        id = "suit_advanced",
        name = "Advanced Redline Armor",
        description = "A top-tier protective suit tuned for nuclear plant operations.",
        type = "suit",
        armor = 55,
        durability = 220,
        tier = 3,
        nextTier = nil,
        price = 4500,
    },
    energy_drink = {
        id = "energy_drink",
        name = "Energy Drink",
        description = "A stimulant that restores health instantly.",
        type = "consumable",
        heal = 30,
        price = 150,
    },
    redline_cocktail = {
        id = "redline_cocktail",
        name = "Redline Cocktail",
        description = "A bar specialty that restores health and adds a burst of armor.",
        type = "consumable",
        heal = 20,
        armor = 10,
        price = 100,
    },
    backpack_expansion = {
        id = "backpack_expansion",
        name = "Backpack Expansion",
        description = "Install this to add two extra inventory slots.",
        type = "upgrade",
        price = 400,
    },
}

DarkRP.BarUpgrades = DarkRP.BarUpgrades or {
    happy_hour = {
        id = "happy_hour",
        name = "Happy Hour",
        description = "Increase bar drink revenue by 20%.",
        price = 1000,
        bonus = 0.20,
    },
    premium_spirits = {
        id = "premium_spirits",
        name = "Premium Spirits",
        description = "Serve higher quality drinks that grant extra healing.",
        price = 2000,
        bonus = 0.15,
    },
    service_robot = {
        id = "service_robot",
        name = "Service Robot",
        description = "Your bar earns an additional tip bonus from each sale.",
        price = 3000,
        bonus = 0.10,
    },
}

DarkRP.InventorySlots = DarkRP.InventorySlots or 8

function DarkRP.getInventoryItem(id)
    return DarkRP.InventoryItems and DarkRP.InventoryItems[id]
end

function DarkRP.getBarUpgrade(id)
    return DarkRP.BarUpgrades and DarkRP.BarUpgrades[id]
end
