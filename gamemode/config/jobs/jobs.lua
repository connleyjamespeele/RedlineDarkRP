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
    category = "Citizen",
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
    salary = 160,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    category = "Citizen",
})

TEAM_CHEF = DarkRP.createJob("Chef", {
    color = Color(255, 165, 0, 255),
    model = "models/player/chef.mdl",
    description = [[Run a restaurant as a Chef.

Entities/Weapons

Freezer: Where ingredients are stored, each ingredient costs a little money.

Cooker: Where cold ingredients go to get cooked.

Preparation Table: Where cooked ingredients get put on plates and it gives the plate to the nearest customer who ordered that.

Cash Register: Where customers get processed; they pay for a table then go sit down then they will order from the player selected menu.

Table: A table with 4 chairs; 4 NPCs can sit and they will order food.

Chef NPC: Automates the entire thing.

Management Console: A computer to get upgrades and do stuff from there.

Upgrades:

1. Ingredient & Freezer Upgrades

Wholesale Contract: A permanent upgrade that reduces the cost of taking ingredients from the Freezer by 20%.

Flash Freezer: Ingredients no longer have a "thaw" time (if your game has one), or it simply allows the Chef NPC to carry 2x the ingredients at once.

Premium Garnish: An upgrade that adds a small cost to each dish but increases the final payout from the customer by 50%.

2. Cooking & Prep Upgrades

Industrial Stove: Allows the Cooker to process two or three meals at the same time instead of one by one.

Auto-Plater: The Preparation Table automatically adds "Sides" (like fries or salad) to every plate, increasing the XP or money gained per order.

Heat Lamps: Allows plates to sit on the Prep Table indefinitely without losing value or "getting cold," giving your Chef NPC more time to manage a crowded room.

3. Dining Area & Table Upgrades

Luxury Seating: Upgrades the Tables so NPCs finish eating faster, freeing up the chairs for the next group of 4.

Condiment Caddy: A passive upgrade for every table that grants a small "tip" ($5–$10) every time an NPC finishes a meal.

Expediter Station: A small bell on the Prep Table that, when rung, makes the Chef NPC move 25% faster for 60 seconds.

4. Cash Register & Management Upgrades

Digital Menu: An upgrade for the Register that lets you swap between "Fast Food" (low cost, high speed) and "Fine Dining" (high cost, slow speed) modes.

Reservation System: Increases the rate at which NPCs spawn and enter the building so you never have empty tables.

Self-Service Kiosk: Handles the "Processing" at the Cash Register automatically, so the player or Chef NPC can focus entirely on the food.

5. Chef NPC Specialization

Sous Chef Training: Upgrades the Chef NPC’s AI so they prioritize the "oldest" orders first, preventing customers from getting angry and leaving.

Master Plating: A high-level upgrade that gives a 10% chance for a meal to be "Perfect," doubling the money received at the table.

Special things:

NPCs: NPC customers will come and order then sit and get their food and eat and then pay.]],
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
    description = [[Extract and process ores as a Miner.

Entities/Weapons

Pickaxe: Can be leveled up to get faster and provide more yield.

Worker: Can be placed and will mine with a level 1 pickaxe but can be upgraded to be faster and get more yield. Max 2.

Refiner: Turns the raw ore into refined ore; it can take batches but takes a minute to refine. Max 2.

Smelter: Turns refined ore into ingots that can be used to craft items and sell for cash.

Special Things

Mining NPC: Opens the Miner menu; the Mining NPC will be near the house in the Mining area and if you click E on him it shows you the crafting menu where it shows you all the items you can craft with your ingots and you can sell them.

Mining Nodes: These are inside the mine; everytime you click on one you tick it down 1 and a normal node is about 10 and when it hits 0 then you get a ore.]],
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
    description = [[Run a nightclub as the Club Owner.

Entities/Weapons

Manager Computer: Allows to manage the club and buy upgrades.

Upgrades:

Amount of performers: You start with only 1 slot but with this upgrade you can get up to 5.

Advertisement: How many customers come.

Tips: How much customers pay.

VIP area: Allows you to get the VIP area; further upgrades will increase the rating which increases High roller spending.

Amount of Bartenders: You start with only 1 but you can get up to 3.

NPC Performer: Lets you buy a NPC performer; you need to have the upgrade though to get more than 1. NPCs will surround and watch the show delivering tips occasionally; it also lets you set where they will perform if you have things enabled in the manager computer.

NPC Bartender: Lines of people will come and order a drink.

NPC Bouncer: Throws out trouble makers that arrive.

VIP area: This will give an area; one performer will be in there and performers will rotate; high rollers will arrive here. There is a rating system here that must be fulfilled.

Booth: A NPC will come here and pay premium; by booth I mean like lap dance booth; a girl gives a player or a NPC a lap dance; all of this should be either player or NPC accessible.]],
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
    description = [[Leader of the Viltrum Empire.

Entities/Weapons

Vat Suits: Grows Viltrumite Suits. This Entity Grows suits players can wear that provide more health and Armor. Each suit takes a lot of money (at least 100m or more) and takes a bit of time to grow. If a vat is destroyed when growing, the money drops on the floor and no suit.

Peon Suit: 150k Health, 100 Armor

Warrior Suit: 250k Health, 200 Armor

Conqueror Suit: 400k Health, 300 Armor, Gives Flight (Not No Clip)

Conqueror: This is a prop of a globe. When you click E on it you get a "Colony". Colonies pay over time and you can do upgrades. You can have a max of 5 Colonies. Each has their own values like population, how economically good they are etc. You can add upgrades like donate to make the economy better etc and industry and more.

Upgrades:

1. Economic & Industry Upgrades

Industrial Infrastructure: Increases the "Industrial" value of a colony. This boosts the amount of money paid out every cycle but slightly slows down population growth.

Direct Economic Stimulus (Donate): Use your own money to "inject" cash into a colony. This provides a permanent multiplier to its economic grade, making it more profitable for the rest of the game.

Trade Hub Establishment: A high-level upgrade that links two of your colonies. Both colonies gain a 15% bonus to their economy based on the other's population size.

Resource Extraction: Dramatically increases immediate payout for 10 minutes, but permanently lowers the "Economic Goodness" of the colony afterward.

2. Population & Growth Upgrades

Cloning Facilities: Forces the "Population" stat to grow 2x faster. Higher population means a higher base for taxes and tithes.

Public Health Initiative: A donation-based upgrade that prevents population "crashes" or deaths during rebellion events or attacks.

Propaganda Broadcast: Increases "Loyalty." A loyal population pays their taxes on time and reduces the cooldown between when you can collect money from the globe.

3. Specialized Colony "Types"

Through the globe, you can spend money to specialize one of your 5 slots into a specific role:

The Forge World: Converts a colony to focus entirely on Industry. It provides a 25% discount on all Vat Suit costs but generates 50% less money.

The Agri-World: Focuses on Population and Health. It generates moderate money but acts as a "backup"—if another colony rebels, the Agri-World sends "supplies" to end the rebellion faster.

The Tax Haven: A colony with no industry and low population, but a massive "Economic Goodness" multiplier. It turns small amounts of growth into huge payouts.

The Worlds should be in a menu.

4. Advanced Features

Rebellion Management: Some colonies might rebel if loyalty is too low. Suppress with military upgrades.

Conquest Expansion: Once you have 5 colonies, unlock the ability to conquer new worlds (new map regions).

Military Upgrades: Build armies, fleets, and defense systems for your colonies.

Research Labs: Unlock new suit tiers and technologies.

Diplomacy: Trade resources with other Thragg players or NPCs for mutual benefit.

Asteroid Mining: Extract resources from space to boost economy.]],
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
    description = [[Operate a gun dealership.

Entities/Weapons

Gun Lab: Gives options for shipments or singles that the dealer can buy and sell to NPC customers and Players alike.

Suit Lab: Gives options to craft suits; they are weaker than the Viltrumite but they are much cheaper and weaker but later ones do get better.

Tier 1: Basic suit with only 15k Health and 25 Armor.

Tier 2: A slightly more advanced suit with 30k health and 50 armor.

Tier 3: A pretty advanced suit with 55k Health and 75 Armor.

Tier 4: A Good armor with 75k Health and 100 Armor.

God: A Good armor with 125k Health and 125 Armor.

Ultra God: A very good armor with 160k health and 150 armor.

Admin Suit: A Good suit with 200k Health and 350 Armor.

Register: A place where you manage your store and upgrade how many NPC customers come; the register is also where NPC spawn money is stored here until collected.]],
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

Entities/Weapons

Black Market Lab: It has a percentage called supplies; this along with money is what you spend on things. Supplies can be attained from a Black Market Supplier.

Suits:

Flash Suit: Health: 30k, Armor: 100, Speed: Triples Speed, Special Ability: when pressing G you go super fast.

Carl Suit: Health: 800, Armor: 10, Speed: slows by 0.5x, Special Ability: when pressing G you get the coder baton and 100k; the coder baton lets you hit players and give them a random effect (could be good or bad).

Sans Suit: Health: 1, Armor: 1000, Speed: adds 0.5x, Special Ability: When pressing G you teleport a good bit in front of you.

Jugger Suit: Health: 500k, Armor: 150, Special Ability: when pressing G you get a hammer that does 5k damage but you can't switch and it goes away after a bit.

Special things:

Supplier: They appear around the map in dark areas and Black Market Dealers can buy supplies from them but they are pricey.]],
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

Entities/Weapons

Solar Panel: Generates electricity during daylight hours. Place multiple panels for better output.

Battery: Stores generated electricity. Upgradeable:
- Base: 75 watts capacity
- Upgrade 1: +50 watts (125 total)
- Upgrade 2: +65 watts (190 total)

Solar Converter: Links solar panels to rechargers. Must be placed between them or explodes.

Recharger: Charging station where batteries are inserted to store electricity from panels.

Management Computer: Manage your system, purchase upgrades, and monitor energy output.

Wires: Connect solar panels, converters, and rechargers to create an energy network.

Special Features:
- Sell charged batteries to the Eco-Friend NPC for profit.
- Energy generation is weather and time-dependent.
- Upgrades improve efficiency and storage capacity.
- Build networks to maximize energy output.]],
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

Entities/Weapons

Computer: Management console for a mini stock market and bank upgrades.

Register: NPCs spawn and request services - Withdrawals (from vault), Deposits (into vault), and Loans (borrow with 10% interest, repaid over 6 minutes).

Vault: Stores bank money. You earn 10% of vault value every 5 minutes (non-subtractive). Starts with $5000; rejuvenates to $5000 if emptied. Drops money if destroyed.

Clerk: NPC assistant that processes NPC orders.]],
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
    description = [[Join the Grove Street Gangsters - a community-focused gang.

You protect your territory and run legitimate businesses. You are STRONGLY against meth and hard drugs in your area.

Features:
- Protection racket income
- Community businesses (clubs, bars)
- Territory control and expansion
- Gang wars with rival gangs
- Gang vehicle access
- Custom gang apparel
- Community investments

Rules:
- NO meth production
- NO hard drugs
- Protection and enforcement allowed
- Territory wars with Ballas, Vagos, Triads
- Honor the code or face consequences]],
    weapons = {},
    command = "grovestreet",
    max = 8,
    salary = 100,
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

You profit from EVERYTHING - meth, drugs, guns, protection. No moral code, pure profit.

Features:
- Meth lab ownership
- Drug distribution network (HIGH INCOME)
- Gun trafficking
- Protection racket ($$$) 
- Territory control
- Gang wars and turf expansion
- Underground casino operations

Business Operations:
- Meth production ($$$$$)
- Drug dealing (continuous income)
- Gun running (bulk sales)
- Protection (aggressive pricing)
- Turf control bonuses
- Alliance system]],
    weapons = {},
    command = "ballas",
    max = 10,
    salary = 150,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    category = "Gangs",
})

TEAM_VAGOS = DarkRP.createJob("Vagos", {
    color = Color(150, 150, 0, 255),
    model = "models/player/group01/male_02.mdl",
    description = [[Join the Vagos - street-level hustlers with big money.

You focus on high-volume drug distribution and street protection. Fast money through constant operations.

Features:
- Drug distribution network (VERY HIGH INCOME)
- Street-level protection
- Drug cartel operations
- Turf wars
- High-volume earning potential
- Underground network

Core Operations:
- Drug labs and distribution ($$$$$)
- Street tax (every player pays in territory)
- Protection services
- Territory expansion wars
- Gang hideouts
- Resource trafficking]],
    weapons = {},
    command = "vagos",
    max = 9,
    salary = 130,
    admin = 0,
    vote = false,
    hasLicense = false,
    candemote = false,
    category = "Gangs",
})

TEAM_TRIADS = DarkRP.createJob("Triads", {
    color = Color(200, 100, 0, 255),
    model = "models/player/combine_soldier.mdl",
    description = [[Join the Triads - sophisticated organized crime.

You specialize in money laundering, counterfeiting, and underground gambling. High-stakes operations with MASSIVE payouts.

Features:
- Money laundering ($$$$$)
- Counterfeiting operations ($$$$$)
- Underground casinos and gambling
- International smuggling
- Protection services (premium)
- White-collar crime

Elite Operations:
- Counterfeit currency production (VERY HIGH INCOME)
- Money laundering network (continuous passive income)
- High-stakes gambling operations (weekly tournaments)
- Diplomatic immunity through power
- Legitimate front businesses
- Shadow economy control]],
    weapons = {},
    command = "triads",
    max = 7,
    salary = 180,
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

GAMEMODE.DefaultTeam = TEAM_CIVILIAN

DarkRP.createCategory({
    name = "Citizens",
    categorises = "jobs",
    startExpanded = true,
    color = Color(200, 30, 30, 255),
    canSee = function() return true end,
    sortOrder = 100,
})



