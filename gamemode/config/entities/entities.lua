-- Entities
-- General citizen entities
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

DarkRP.createEntity("Bar Counter", {
    ent = "bartender_bar",
    model = "models/props_wasteland/kitchen_counter001b.mdl",
    price = 1200,
    max = 2,
    cmd = "buybarcounter",
    allowed = {TEAM_BARTENDER},
    category = "Service",
})

-- Nuclear facility entities
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

-- Restaurant / Chef entities
DarkRP.createEntity("Freezer", {
    ent = "freezer",
    model = "models/props_c17/FurnitureFridge001a.mdl",
    price = 500,
    max = 2,
    cmd = "buyfreezer",
    allowed = {TEAM_CHEF},
    category = "Citizens",
})

DarkRP.createEntity("Cooker", {
    ent = "cooker",
    model = "models/props_c17/furnitureStove001a.mdl",
    price = 600,
    max = 2,
    cmd = "buycooker",
    allowed = {TEAM_CHEF},
    category = "Citizens",
})

DarkRP.createEntity("Preparation Table", {
    ent = "preparation_table",
    model = "models/props_interiors/Furniture_Desk01a.mdl",
    price = 400,
    max = 2,
    cmd = "buypreptable",
    allowed = {TEAM_CHEF},
    category = "Citizens",
})

DarkRP.createEntity("Cash Register", {
    ent = "cash_register",
    model = "models/props_c17/cashregister01a.mdl",
    price = 300,
    max = 2,
    cmd = "buycashregister",
    allowed = {TEAM_CHEF},
    category = "Citizens",
})

DarkRP.createEntity("Restaurant Table", {
    ent = "restaurant_table",
    model = "models/props_interiors/Furniture_Desk01a.mdl",
    price = 200,
    max = 10,
    cmd = "buyrestauranttable",
    allowed = {TEAM_CHEF},
    category = "Citizens",
})

DarkRP.createEntity("Chef NPC", {
    ent = "chef_npc",
    model = "models/player/chef.mdl",
    price = 1000,
    max = 1,
    cmd = "buychefnpc",
    allowed = {TEAM_CHEF},
    category = "Citizens",
})

DarkRP.createEntity("Management Console", {
    ent = "management_console",
    model = "models/props_lab/monitor01a.mdl",
    price = 800,
    max = 1,
    cmd = "buymanagementconsole",
    allowed = {TEAM_CHEF},
    category = "Citizens",
})

DarkRP.createWeapon("Umbrella", {
    model = "models/weapons/w_knife_t.mdl",
    price = 100,
    category = "Citizens",
})

DarkRP.createWeapon("Pickaxe", {
    model = "models/weapons/w_crowbar.mdl",
    price = 200,
    allowed = {TEAM_MINER},
    category = "Citizens",
})

DarkRP.createEntity("Miner Worker", {
    ent = "miner_worker",
    model = "models/player/engineer.mdl",
    price = 800,
    max = 2,
    cmd = "buyminerworker",
    allowed = {TEAM_MINER},
    category = "Citizens",
})

DarkRP.createEntity("Refiner", {
    ent = "refiner",
    model = "models/props_c17/consolebox01a.mdl",
    price = 600,
    max = 2,
    cmd = "buyrefiner",
    allowed = {TEAM_MINER},
    category = "Citizens",
})

DarkRP.createEntity("Smelter", {
    ent = "smelter",
    model = "models/props_c17/furnitureStove001a.mdl",
    price = 700,
    max = 2,
    cmd = "buysmelter",
    allowed = {TEAM_MINER},
    category = "Citizens",
})

DarkRP.createEntity("Mining NPC", {
    ent = "mining_npc",
    model = "models/player/engineer.mdl",
    price = 500,
    max = 1,
    cmd = "buyminingnpc",
    allowed = {TEAM_MINER},
    category = "Citizens",
})

DarkRP.createEntity("Mining Node", {
    ent = "mining_node",
    model = "models/props_wasteland/rockgranite02a.mdl",
    price = 100,
    max = 20,
    cmd = "buyminingnode",
    allowed = {TEAM_MINER},
    category = "Citizens",
})

-- Club owner entities
DarkRP.createEntity("Manager Computer", {
    ent = "manager_computer",
    model = "models/props_lab/monitor01a.mdl",
    price = 500,
    max = 1,
    cmd = "buymanagercomputer",
    allowed = {TEAM_CLUB_OWNER},
    category = "Citizens",
})

DarkRP.createEntity("NPC Performer", {
    ent = "npc_performer",
    model = "models/player/alyx.mdl",
    price = 300,
    max = 5,
    cmd = "buynpcperformer",
    allowed = {TEAM_CLUB_OWNER},
    category = "Citizens",
})

DarkRP.createEntity("NPC Bartender", {
    ent = "npc_bartender",
    model = "models/player/group03/male_04.mdl",
    price = 250,
    max = 3,
    cmd = "buynpcbartender",
    allowed = {TEAM_CLUB_OWNER},
    category = "Citizens",
})

DarkRP.createEntity("NPC Bouncer", {
    ent = "npc_bouncer",
    model = "models/player/combine_soldier.mdl",
    price = 400,
    max = 2,
    cmd = "buynpcbouncer",
    allowed = {TEAM_CLUB_OWNER},
    category = "Citizens",
})

DarkRP.createEntity("VIP Area", {
    ent = "vip_area",
    model = "models/props_interiors/Furniture_Couch01a.mdl",
    price = 1000,
    max = 1,
    cmd = "buyviparea",
    allowed = {TEAM_CLUB_OWNER},
    category = "Citizens",
})

DarkRP.createEntity("Booth", {
    ent = "booth",
    model = "models/props_interiors/Furniture_Couch01a.mdl",
    price = 800,
    max = 5,
    cmd = "buybooth",
    allowed = {TEAM_CLUB_OWNER},
    category = "Citizens",
})

-- Thragg entities
DarkRP.createEntity("Vat Suits", {
    ent = "vat_suits",
    model = "models/props_c17/consolebox01a.mdl",
    price = 1000000,
    max = 3,
    cmd = "buyvatsuits",
    allowed = {TEAM_THRAGG},
    category = "Citizens",
})

DarkRP.createEntity("Conqueror Globe", {
    ent = "conqueror_globe",
    model = "models/props_phx/misc/smallcannonball.mdl",
    price = 500000,
    max = 1,
    cmd = "buyconquerorglobe",
    allowed = {TEAM_THRAGG},
    category = "Citizens",
})

-- Gun dealer entities
DarkRP.createEntity("Gun Lab", {
    ent = "gun_lab",
    model = "models/props_c17/TrapPropeller_Engine.mdl",
    price = 50000,
    max = 2,
    cmd = "buygunlab",
    allowed = {TEAM_GUN_DEALER},
    category = "Gangs",
})

DarkRP.createEntity("Suit Lab", {
    ent = "suit_lab",
    model = "models/props_c17/consolebox01a.mdl",
    price = 30000,
    max = 2,
    cmd = "buysuitlab",
    allowed = {TEAM_GUN_DEALER},
    category = "Gangs",
})

DarkRP.createEntity("Dealer Register", {
    ent = "dealer_register",
    model = "models/props_c17/cashregister01a.mdl",
    price = 20000,
    max = 1,
    cmd = "buydealerregister",
    allowed = {TEAM_GUN_DEALER},
    category = "Gangs",
})

-- Black Market entities
DarkRP.createEntity("Black Market Lab", {
    ent = "black_market_lab",
    model = "models/props_c17/consolebox01a.mdl",
    price = 100000,
    max = 1,
    cmd = "buyblackmarketlab",
    allowed = {TEAM_BLACK_MARKET_DEALER},
    category = "Gangs",
})

-- Drug manufacturer entities
DarkRP.createEntity("Drug Pot", {
    ent = "drug_pot",
    model = "models/props_junk/garbage_metalcan002a.mdl",
    price = 120,
    max = 12,
    cmd = "buydrugpot",
    allowed = {TEAM_DRUG_MANUFACTURER},
    category = "Drug Manufacture",
})

DarkRP.createEntity("Drug Storage Locker", {
    ent = "drug_storage_locker",
    model = "models/props_junk/wood_crate001a.mdl",
    price = 1500,
    max = 2,
    cmd = "buydrugstoragelocker",
    allowed = {TEAM_DRUG_MANUFACTURER},
    category = "Drug Manufacture",
})

DarkRP.createEntity("Drying Rack", {
    ent = "drying_rack",
    model = "models/props_wasteland/kitchen_shelf001a.mdl",
    price = 300,
    max = 4,
    cmd = "buydryingrack",
    allowed = {TEAM_DRUG_MANUFACTURER},
    category = "Drug Manufacture",
})

DarkRP.createEntity("Combiner", {
    ent = "drug_combiner",
    model = "models/props_lab/reciever01b.mdl",
    price = 900,
    max = 2,
    cmd = "buydrugcombiner",
    allowed = {TEAM_DRUG_MANUFACTURER},
    category = "Drug Manufacture",
})

-- Gang money-making entities
DarkRP.createEntity("Protection Rack", {
    ent = "protection_rack",
    model = "models/props_wasteland/laundry_washer002.mdl",
    price = 800,
    max = 1,
    cmd = "buyprotectionsrack",
    allowed = {TEAM_GROVESTREET},
    category = "Gangs",
})

DarkRP.createEntity("Ballas Control Hub", {
    ent = "ballas_control_hub",
    model = "models/props_c17/consolebox01a.mdl",
    price = 1500,
    max = 1,
    cmd = "buyballascontrolhub",
    allowed = {TEAM_BALLAS},
    category = "Gangs",
})

DarkRP.createEntity("Street Tax Station", {
    ent = "vagos_tax_station",
    model = "models/props_lab/noticeboard.mdl",
    price = 700,
    max = 2,
    cmd = "buyvagostaxstation",
    allowed = {TEAM_VAGOS},
    category = "Gangs",
})

DarkRP.createEntity("Laundering Terminal", {
    ent = "triads_laundering_terminal",
    model = "models/props_lab/reciever01b.mdl",
    price = 1200,
    max = 1,
    cmd = "buylaunderingterminal",
    allowed = {TEAM_TRIADS},
    category = "Gangs",
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

DarkRP.createCategory{
    name = "Gangs",
    categorises = "entities",
    startExpanded = true,
    color = Color(150, 0, 150, 255),
    canSee = fp{fn.Id, true},
    sortOrder = 2,
}

DarkRP.createCategory{
    name = "Drug Manufacture",
    categorises = "entities",
    startExpanded = true,
    color = Color(80, 80, 80, 255),
    canSee = fp{fn.Id, true},
    sortOrder = 3,
}
