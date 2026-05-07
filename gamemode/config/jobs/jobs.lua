-- People often copy jobs. When they do, the GM table does not exist anymore.
-- This line makes the job code work both inside and outside of gamemode files.
-- You should not copy this line into your code.
local GAMEMODE = GAMEMODE or GM

TEAM_CIVILIAN = DarkRP.createJob("Civilian", {
    color = Color(200, 50, 50, 255),
    model = {
        "models/player/Group01/Female_01.mdl",
        "models/player/Group01/Female_02.mdl",
        "models/player/Group01/Female_03.mdl",
        "models/player/Group01/Female_04.mdl",
        "models/player/Group01/Female_06.mdl",
        "models/player/Group01/Male_01.mdl",
        "models/player/Group01/Male_02.mdl",
        "models/player/Group01/Male_03.mdl",
        "models/player/Group01/Male_04.mdl",
        "models/player/Group01/Male_05.mdl",
        "models/player/Group01/Male_06.mdl",
        "models/player/Group01/Male_07.mdl",
        "models/player/Group01/Male_08.mdl",
        "models/player/Group01/Male_09.mdl",
    },
    description = [[A resilient civilian role that can access basic city equipment and delivery contracts.

Available features:
- Delivery Terminal access for short, medium, and large deliveries.
- Suit and inventory management through /inventory.
- Bar access, drink crafting, and service upgrades.]],
    weapons = {},
    command = "civilian",
    max = 0,
    salary = 70,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    category = "Citizens",
})

TEAM_NUCLEAR_WORKER = DarkRP.createJob("Nuclear Worker", {
    color = Color(255, 0, 0, 255),
    model = "models/player/breen.mdl",
    description = [[Manage nuclear reactors, keep plant heat under control, and handle waste disposal.

Use reactor terminals and worker automation to protect the facility.]],
    weapons = {},
    command = "nuclearworker",
    max = 2,
    salary = 220,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    category = "Citizens",
})

TEAM_BARTENDER = DarkRP.createJob("Bartender", {
    color = Color(180, 30, 30, 255),
    model = {
        "models/player/group03/female_04.mdl",
        "models/player/group03/male_04.mdl",
    },
    description = [[Run the Redline bar and serve drinks to customers.

Buy and upgrade a bar counter, sell cocktails, and earn service bonuses. Use /bar to access the nearest bar counter.]],
    weapons = {},
    command = "bartender",
    max = 2,
    salary = 160,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    category = "Citizens",
})

TEAM_CHEF = DarkRP.createJob("Chef", {
    color = Color(255, 165, 0, 255),
    model = "models/player/chef.mdl",
    description = [[Run a restaurant and manage the kitchen, staff, and service.

Use the Freezer, Cooker, Preparation Table, Cash Register, and Chef NPC to prepare meals and serve NPC customers. Upgrade cooking speed, seating, and service systems to grow your restaurant.]],
    weapons = {},
    command = "chef",
    max = 2,
    salary = 60,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    category = "Citizens",
})

TEAM_MINER = DarkRP.createJob("Miner", {
    color = Color(139, 69, 19, 255),
    model = "models/player/engineer.mdl",
    description = [[Extract ore and process it into refined products.

Use a Pickaxe, mining nodes, Workers, Refiner, and Smelter to mine, refine, and craft items to sell.]],
    weapons = {"pickaxe"},
    command = "miner",
    max = 4,
    salary = 65,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    category = "Citizens",
})

TEAM_CLUB_OWNER = DarkRP.createJob("Club Owner", {
    color = Color(255, 20, 147, 255),
    model = "models/player/gman_high.mdl",
    description = [[Run a nightclub with performers, customers, and VIP upgrades.

Use the Manager Computer to buy upgrades for performers, bartenders, bouncers, VIP areas, and customer flow.]],
    weapons = {},
    command = "clubowner",
    max = 2,
    salary = 60,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    category = "Citizens",
})

TEAM_THRAGG = DarkRP.createJob("Thragg", {
    color = Color(0, 0, 0, 255),
    model = "models/player/superhero.mdl",
    description = [[Lead the Viltrum Empire by growing Vat Suits and managing colonies.

Use vats to grow powerful suits and collect passive income from Colonies. Unlock economic and military upgrades to expand your power over time.]],
    weapons = {},
    command = "thragg",
    max = 1,
    salary = 0,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    category = "Citizens",
})

TEAM_GUN_DEALER = DarkRP.createJob("Gun Dealer", {
    color = Color(128, 128, 128, 255),
    model = "models/player/gman_high.mdl",
    description = [[Operate a gun dealership and weapon business.

Use the Gun Lab to buy and sell shipments or singles, and manage NPC customer income with your Register. Craft armor suits in the Suit Lab to offer stronger gear.]],
    weapons = {},
    command = "gundealer",
    max = 2,
    salary = 55,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    category = "Citizens",
})

TEAM_BLACK_MARKET_DEALER = DarkRP.createJob("Black Market Dealer", {
    color = Color(0, 0, 0, 255),
    model = "models/player/eli.mdl",
    description = [[Operate in the shadows as a Black Market Dealer.

Use the Black Market Lab to buy supplies, craft powerful suits, and trade in rare gear. Suppliers spawn in hidden areas and provide stock for your illegal operations.]],
    weapons = {},
    command = "blackmarketdealer",
    max = 1,
    salary = 0,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    category = "Citizens",
})

TEAM_SOLAR_TECHNICIAN = DarkRP.createJob("Solar Technician", {
    color = Color(255, 200, 0, 255),
    model = "models/player/magnusson.mdl",
    description = [[Harness solar energy and generate electricity.

Build Solar Panels, Batteries, Converters, Rechargers, and wiring networks. Upgrade capacity and sell charged batteries for profit.]],
    weapons = {"wires"},
    command = "solartechnician",
    max = 3,
    salary = 75,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    category = "Citizens",
})

TEAM_BANK_MANAGER = DarkRP.createJob("Bank Manager", {
    color = Color(0, 100, 200, 255),
    model = "models/player/magnusson.mdl",
    description = [[Manage a bank, handle customer transactions, loans, and investments.

Use the bank Computer to upgrade services, process NPC Deposits, Withdrawals, and Loans, and earn from Vault growth and fees.]],
    weapons = {},
    command = "bankmanager",
    max = 2,
    salary = 80,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    category = "Citizens",
})

TEAM_PERFORMER = DarkRP.createJob("Performer", {
    color = Color(255, 20, 147, 255),
    model = "models/player/alyx.mdl",
    description = [[Entertain customers as a Performer.

Entities/Weapons

Stage: Place this entity, press E to mount and perform the 'muscle' animation. Press E again to dismount. NPCs tip while performing.

Performer SWEP: Target players/NPCs to offer a 'dance' for $500. If accepted, plays sound, black screen effect, and you get paid.]],
    weapons = {"weapon_performer"},
    command = "performer",
    max = 4,
    salary = 50,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    category = "Citizens",
})

TEAM_GROVESTREET = DarkRP.createJob("Grove Street Gangster", {
    color = Color(0, 200, 0, 255),
    model = "models/player/group01/male_01.mdl",
    description = [[Join Grove Street - a neighborhood-focused gang with a strict code.

Use Protection Rack income, community investments, and territory control to earn cash while keeping hard drugs out of the area.]],
    weapons = {},
    command = "grovestreet",
    max = 8,
    salary = 0,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    category = "Gangs",
})

TEAM_BALLAS = DarkRP.createJob("Ballas", {
    color = Color(200, 0, 200, 255),
    model = "models/player/group01/male_04.mdl",
    description = [[Join the Ballas - ruthless and profit-driven.

Use the Ballas Control Hub to run meth operations, drug distribution, and protection rackets for high illegal income.]],
    weapons = {},
    command = "ballas",
    max = 10,
    salary = 0,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    category = "Gangs",
})

TEAM_VAGOS = DarkRP.createJob("Vagos", {
    color = Color(150, 150, 0, 255),
    model = "models/player/group01/male_02.mdl",
    description = [[Join the Vagos - street-level hustlers with fast money.

Collect income from Street Tax Stations, drug shipments, and protection fees as you expand territory.]],
    weapons = {},
    command = "vagos",
    max = 9,
    salary = 0,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    category = "Gangs",
})

TEAM_TRIADS = DarkRP.createJob("Triads", {
    color = Color(200, 100, 0, 255),
    model = "models/player/combine_soldier.mdl",
    description = [[Join the Triads - elite organized crime for top payouts.

Use the Laundering Terminal and underground networks to turn illegal profits into clean money and control high-stakes operations.]],
    weapons = {},
    command = "triads",
    max = 7,
    salary = 0,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    category = "Gangs",
})

TEAM_DRUG_MANUFACTURER = DarkRP.createJob("Drug Manufacturer", {
    color = Color(40, 40, 40, 255),
    model = "models/player/leet.mdl",
    description = [[Produce illegal drugs and control a dangerous multi-path supply chain.

The workflow is split into strands and stages:
- Grow default strains like Blu NTS or Weds in Drug Pots.
- Dry the harvest on Drying Racks, then combine and refine it in the Combiner.
- Send product through the Freezer, break it up, and package it for sale.
- Higher-tier strands require extra growth, enhancers, rolling, and different refinement workflows.
- Choose your path: cheap street clips, hard crystal, or premium packaged exports.

This is a zero-salary criminal job built around progression, rare recipes, and risk.]],
    weapons = {},
    command = "drugmanufacturer",
    max = 2,
    salary = 0,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    category = "Gangs",
})

TEAM_CIVILIAN = TEAM_CIVILIAN or -1
TEAM_CITIZEN = TEAM_CIVILIAN
TEAM_NUCLEAR_WORKER = TEAM_NUCLEAR_WORKER or -1
TEAM_BARTENDER = TEAM_BARTENDER or -1
TEAM_CHEF = TEAM_CHEF or -1
TEAM_MINER = TEAM_MINER or -1
TEAM_CLUB_OWNER = TEAM_CLUB_OWNER or -1
TEAM_THRAGG = TEAM_THRAGG or -1
TEAM_GUN_DEALER = TEAM_GUN_DEALER or -1
TEAM_BLACK_MARKET_DEALER = TEAM_BLACK_MARKET_DEALER or -1

TEAM_SOLAR_TECHNICIAN = TEAM_SOLAR_TECHNICIAN or -1
TEAM_BANK_MANAGER = TEAM_BANK_MANAGER or -1
TEAM_PERFORMER = TEAM_PERFORMER or -1
TEAM_DRUG_MANUFACTURER = TEAM_DRUG_MANUFACTURER or -1

GAMEMODE.DefaultTeam = TEAM_CIVILIAN

DarkRP.createCategory({
    name = "Citizens",
    categorises = "jobs",
    startExpanded = true,
    color = Color(200, 30, 30, 255),
    canSee = function() return true end,
    sortOrder = 100,
})

DarkRP.createCategory({
    name = "Gangs",
    categorises = "jobs",
    startExpanded = true,
    color = Color(150, 0, 150, 255),
    canSee = function() return true end,
    sortOrder = 200,
})



