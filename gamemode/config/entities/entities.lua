-- Entities
DarkRP.createEntity("Money printer", {
    ent = "money_printer",
    model = "models/props_c17/consolebox01a.mdl",
    price = 1000,
    max = 2,
    cmd = "buymoneyprinter",
    category = "Citizens",
})

DarkRP.createEntity("Tip Jar", {
    ent = "darkrp_tip_jar",
    model = "models/props_lab/jar01a.mdl",
    price = 0,
    max = 2,
    cmd = "tipjar",
    allowTools = true,
    category = "Citizens",
})

DarkRP.createEntity("Delivery Terminal", {
    ent = "delivery_terminal",
    model = "models/props_lab/monitor01a.mdl",
    price = 500,
    max = 5,
    cmd = "buydeliveryterminal",
    category = "Citizens",
})

DarkRP.createEntity("Reactor", {
    ent = "nuclear_reactor",
    model = "models/props_c17/consolebox01a.mdl",
    price = 5000,
    max = 1,
    cmd = "buyreactor",
    allowed = {TEAM_NUCLEAR_WORKER},
    category = "Citizens",
})

DarkRP.createEntity("Nuclear Terminal", {
    ent = "nuclear_terminal",
    model = "models/props_lab/monitor01b.mdl",
    price = 1000,
    max = 2,
    cmd = "buynuclearterminal",
    allowed = {TEAM_NUCLEAR_WORKER},
    category = "Citizens",
})

DarkRP.createEntity("Cooling Barrel", {
    ent = "cooling_barrel",
    model = "models/props_c17/oildrum001.mdl",
    price = 200,
    max = 10,
    cmd = "buycoolingbarrel",
    allowed = {TEAM_NUCLEAR_WORKER},
    category = "Citizens",
})

DarkRP.createEntity("Waste Barrel", {
    ent = "waste_barrel",
    model = "models/props_c17/oildrum001_explosive.mdl",
    price = 300,
    max = 10,
    cmd = "buywastebarrel",
    allowed = {TEAM_NUCLEAR_WORKER},
    category = "Citizens",
})

DarkRP.createEntity("Nuclear Worker", {
    ent = "nuclear_worker",
    model = "models/player/breen.mdl",
    price = 1500,
    max = 3,
    cmd = "buynuclearworker",
    allowed = {TEAM_NUCLEAR_WORKER},
    category = "Citizens",
})

DarkRP.createEntity("Nuclear Disposal NPC", {
    ent = "nuclear_disposal_npc",
    model = "models/player/breen.mdl",
    price = 2000,
    max = 2,
    cmd = "buydisposalnpc",
    allowed = {TEAM_NUCLEAR_WORKER},
    category = "Citizens",
})

DarkRP.createWeapon("Umbrella", {
    model = "models/weapons/w_knife_t.mdl",
    price = 100,
    category = "Citizens",
})

DarkRP.createEntity("Gun lab", {
    ent = "gunlab",
    model = "models/props_c17/TrapPropeller_Engine.mdl",
    price = 500,
    max = 1,
    cmd = "buygunlab",
    allowed = TEAM_GUN
})

if not DarkRP.disabledDefaults["modules"]["hungermod"] then
    DarkRP.createEntity("Microwave", {
        ent = "microwave",
        model = "models/props/cs_office/microwave.mdl",
        price = 400,
        max = 1,
        cmd = "buymicrowave",
        allowed = TEAM_COOK
    })

    -- Food Shipments
    DarkRP.createShipment("Banana", {
        model = "models/props/cs_italy/bananna.mdl",
        entity = "spawned_food",
        price = 10,
        amount = 10,
        separate = false,
        pricesep = 0,
        noship = false,
        allowed = TEAM_COOK,
        category = "Food",
        customCheck = function(ply) return ply:IsCook() end,
    })

    DarkRP.createShipment("Melon", {
        model = "models/props_junk/watermelon01.mdl",
        entity = "spawned_food",
        price = 20,
        amount = 10,
        separate = false,
        pricesep = 0,
        noship = false,
        allowed = TEAM_COOK,
        category = "Food",
        customCheck = function(ply) return ply:IsCook() end,
    })
end

-- Categories
DarkRP.createCategory{
    name = "Citizens",
    categorises = "jobs",
    startExpanded = true,
    color = Color(0, 107, 0, 255),
    canSee = fp{fn.Id, true},
    sortOrder = 1,
}

DarkRP.createCategory{
    name = "Emergency Services",
    categorises = "jobs",
    startExpanded = true,
    color = Color(255, 0, 0, 255),
    canSee = fp{fn.Id, true},
    sortOrder = 2,
}

DarkRP.createCategory{
    name = "Criminal",
    categorises = "jobs",
    startExpanded = true,
    color = Color(255, 0, 0, 255),
    canSee = fp{fn.Id, true},
    sortOrder = 3,
}

DarkRP.createCategory{
    name = "Government",
    categorises = "jobs",
    startExpanded = true,
    color = Color(0, 0, 255, 255),
    canSee = fp{fn.Id, true},
    sortOrder = 4,
}

DarkRP.createCategory{
    name = "Admin",
    categorises = "jobs",
    startExpanded = true,
    color = Color(255, 255, 0, 255),
    canSee = fp{fn.Id, true},
    sortOrder = 5,
}

DarkRP.createCategory{
    name = "Citizens",
    categorises = "shipments",
    startExpanded = true,
    color = Color(0, 107, 0, 255),
    canSee = fp{fn.Id, true},
    sortOrder = 1,
}

DarkRP.createCategory{
    name = "Citizens",
    categorises = "entities",
    startExpanded = true,
    color = Color(0, 107, 0, 255),
    canSee = fp{fn.Id, true},
    sortOrder = 1,
}
