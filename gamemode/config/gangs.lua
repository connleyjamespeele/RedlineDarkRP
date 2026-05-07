-- Centralized gang definitions for DarkRP
-- Define gang colors, characteristics, and restrictions

DarkRP.Gangs = {
    ["Grove Street Gangsters"] = {
        color = Color(0, 200, 0, 255),
        description = "The Grove Street Gangsters protect their community and focus on legitimate and semi-legitimate businesses. They STRONGLY oppose meth and hard drugs in their territory.",
        model = "models/player/group01/male_01.mdl",
        salary = 100,
        max = 8,
        command = "grovestreet",
        rules = {
            allow_meth = false,
            allow_drugs = false,
            allow_guns = true,
            allow_protection = true,
            territorial = true
        },
        territories = {"Grove Street"},
        businesses = {"protection", "clubowner", "bartender", "dealer_register"},
        features = {
            "Protection racket ($$$+)",
            "Community businesses",
            "Territory control",
            "Rival gang warfare",
            "Custom gang vehicle"
        }
    },
    ["Ballas"] = {
        color = Color(200, 0, 200, 255),
        description = "The Ballas are hardened gangsters who profit from EVERYTHING - meth labs, protection, weapons. Ruthless and driven by profit.",
        model = "models/player/group01/male_04.mdl",
        salary = 150,
        max = 10,
        command = "ballas",
        rules = {
            allow_meth = true,
            allow_drugs = true,
            allow_guns = true,
            allow_protection = true,
            territorial = true
        },
        territories = {"Ballas Territory"},
        businesses = {"meth_lab", "protection", "gundealer", "blackmarketdealer"},
        features = {
            "Meth Production ($$$$$)",
            "Protection services",
            "Gun trafficking",
            "Drug distribution",
            "Gang wars",
            "Custom weapons"
        }
    },
    ["The Vagos"] = {
        color = Color(150, 150, 0, 255),
        description = "The Vagos control drug distribution and protection. Street-level operations with big money through volume.",
        model = "models/player/group01/male_02.mdl",
        salary = 130,
        max = 9,
        command = "vagos",
        rules = {
            allow_meth = true,
            allow_drugs = true,
            allow_guns = true,
            allow_protection = true,
            territorial = true
        },
        territories = {"Vagos Territory"},
        businesses = {"drug_lab", "protection", "gundealer", "clubowner"},
        features = {
            "Drug Distribution ($$$$$)",
            "Street-level protection",
            "Drug cartel operations",
            "Territory expansion",
            "High-volume earnings",
            "Drug house warfare"
        }
    },
    ["The Triads"] = {
        color = Color(200, 100, 0, 255),
        description = "The Triads are a sophisticated crime organization specializing in money laundering, counterfeiting, and underground casinos.",
        model = "models/player/combine_soldier.mdl",
        salary = 180,
        max = 7,
        command = "triads",
        rules = {
            allow_meth = true,
            allow_drugs = true,
            allow_guns = true,
            allow_protection = true,
            allow_counterfeiting = true,
            allow_gambling = true,
            territorial = false
        },
        territories = {"Downtown"},
        businesses = {"money_printer", "counterfeiter", "casino", "protection"},
        features = {
            "Money Laundering ($$$$$)",
            "Counterfeiting ($$$$$)",
            "Underground Gambling ($$$$)",
            "Protection services",
            "International trade",
            "High-stakes games"
        }
    }
}

-- Function to get gang data
function DarkRP.GetGangData(name)
    return DarkRP.Gangs[name]
end

-- Function to check if gang allows activity
function DarkRP.GangAllows(gangName, activity)
    local gang = DarkRP.GetGangData(gangName)
    if not gang then return false end
    return gang.rules[activity] or false
end

-- Function to list all gangs
function DarkRP.GetGangList()
    local list = {}
    for name, _ in pairs(DarkRP.Gangs) do
        table.insert(list, name)
    end
    return list
end