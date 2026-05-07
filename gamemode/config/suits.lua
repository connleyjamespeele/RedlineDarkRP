-- Centralized suit definitions for DarkRP
-- This file contains all suit configurations for easy management

DarkRP.Suits = {
    -- Viltrum Empire Suits
    ["Peon Suit"] = {
        health = 150000,
        armor = 100,
        description = "Basic Viltrum suit with moderate protection.",
        cost = 100000000, -- 100m
        model = "models/player/superhero.mdl",
        abilities = {}
    },
    ["Warrior Suit"] = {
        health = 250000,
        armor = 200,
        description = "Advanced suit with better health and armor.",
        cost = 200000000,
        model = "models/player/superhero.mdl",
        abilities = {}
    },
    ["Conqueror Suit"] = {
        health = 400000,
        armor = 300,
        description = "Elite suit with flight capability.",
        cost = 500000000,
        model = "models/player/superhero.mdl",
        abilities = {flight = true}
    },

    -- Gun Dealer Suits
    ["Tier 1 Suit"] = {
        health = 15000,
        armor = 25,
        description = "Basic protective suit.",
        cost = 50000,
        model = "models/player/gman_high.mdl",
        abilities = {}
    },
    ["Tier 2 Suit"] = {
        health = 30000,
        armor = 50,
        description = "Improved suit with more armor.",
        cost = 100000,
        model = "models/player/gman_high.mdl",
        abilities = {}
    },
    ["Tier 3 Suit"] = {
        health = 55000,
        armor = 75,
        description = "Advanced suit.",
        cost = 200000,
        model = "models/player/gman_high.mdl",
        abilities = {}
    },
    ["Tier 4 Suit"] = {
        health = 75000,
        armor = 100,
        description = "High-tier suit.",
        cost = 350000,
        model = "models/player/gman_high.mdl",
        abilities = {}
    },
    ["God Suit"] = {
        health = 125000,
        armor = 125,
        description = "God-like protection.",
        cost = 500000,
        model = "models/player/gman_high.mdl",
        abilities = {}
    },
    ["Ultra God Suit"] = {
        health = 160000,
        armor = 150,
        description = "Ultimate suit.",
        cost = 750000,
        model = "models/player/gman_high.mdl",
        abilities = {}
    },
    ["Admin Suit"] = {
        health = 200000,
        armor = 350,
        description = "Admin-level suit.",
        cost = 1000000,
        model = "models/player/gman_high.mdl",
        abilities = {}
    },

    -- Black Market Suits
    ["Flash Suit"] = {
        health = 30000,
        armor = 100,
        description = "Speed boost suit.",
        cost = 150000,
        model = "models/player/eli.mdl",
        abilities = {speed = 3}
    },
    ["Carl Suit"] = {
        health = 800,
        armor = 10,
        description = "Random effect suit.",
        cost = 50000,
        model = "models/player/eli.mdl",
        abilities = {random_effect = true}
    },
    ["Sans Suit"] = {
        health = 1,
        armor = 1000,
        description = "Teleport suit.",
        cost = 100000,
        model = "models/player/eli.mdl",
        abilities = {teleport = true}
    },
    ["Jugger Suit"] = {
        health = 500000,
        armor = 150,
        description = "Hammer attack suit.",
        cost = 300000,
        model = "models/player/eli.mdl",
        abilities = {hammer = true}
    }
}

-- Function to get suit data
function DarkRP.GetSuitData(name)
    return DarkRP.Suits[name]
end

-- Function to apply suit to player
function DarkRP.ApplySuit(ply, suitName)
    local data = DarkRP.GetSuitData(suitName)
    if not data then return end
    ply:SetMaxHealth(data.health)
    ply:SetHealth(data.health)
    ply:SetArmor(data.armor)
    ply:SetModel(data.model)
    ply.SuitData = data
end