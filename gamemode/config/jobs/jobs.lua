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
    salary = 50,
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
    salary = 150,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    category = "Nuclear",
})

TEAM_BARTENDER = DarkRP.createJob("Bartender", {
    color = Color(180, 30, 30, 255),
    model = {
        "models/player/group03/female_04.mdl",
        "models/player/group03/male_04.mdl",
    },
    description = [[Run the Redline bar and serve drinks to customers.

Buy and upgrade a bar counter, sell cocktails, and earn service bonuses.
Use /bar to access the nearest bar counter.]],
    weapons = {},
    command = "bartender",
    max = 2,
    salary = 100,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    category = "Service",
})

TEAM_CIVILIAN = TEAM_CIVILIAN or -1
TEAM_CITIZEN = TEAM_CIVILIAN
TEAM_NUCLEAR_WORKER = TEAM_NUCLEAR_WORKER or -1
TEAM_BARTENDER = TEAM_BARTENDER or -1

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
    name = "Service",
    categorises = "jobs",
    startExpanded = true,
    color = Color(180, 50, 50, 255),
    canSee = function() return true end,
    sortOrder = 105,
})

DarkRP.createCategory({
    name = "Nuclear",
    categorises = "jobs",
    startExpanded = true,
    color = Color(255, 20, 20, 255),
    canSee = function() return true end,
    sortOrder = 110,
})
