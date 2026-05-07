util.AddNetworkString("DarkRP_OpenFlipsMenu")
util.AddNetworkString("DarkRP_FlipsAction")

local pendingFlips = {}
local minFlipAmount = 10
local maxFlipAmount = 1000000
local flipTimeout = 300

local function isValidFlipChoice(choice)
    choice = string.lower(choice or "")
    return choice == "heads" or choice == "tails"
end

local function flipCoin()
    return math.random(2) == 1 and "heads" or "tails"
end

local function cleanupPendingFlips()
    for steamID, challenge in pairs(pendingFlips) do
        local creator = challenge.creator
        if not IsValid(creator) or not creator:IsPlayer() or creator:SteamID() ~= steamID or CurTime() - challenge.createdAt > flipTimeout then
            if IsValid(creator) and creator:IsPlayer() then
                creator:addMoney(challenge.amount)
                DarkRP.notify(creator, 0, 4, "Your pending flip challenge was cancelled and your money was refunded.")
            end
            pendingFlips[steamID] = nil
        end
    end
end

local function getPendingFlipList(ply)
    cleanupPendingFlips()
    local list = {}

    for steamID, challenge in pairs(pendingFlips) do
        if challenge.creator ~= ply and IsValid(challenge.creator) then
            table.insert(list, {
                creatorName = challenge.creatorName,
                creatorSteamID = steamID,
                amount = challenge.amount,
                choice = challenge.choice,
                age = math.floor(CurTime() - challenge.createdAt),
            })
        end
    end

    table.sort(list, function(a, b)
        return a.amount > b.amount
    end)

    return list
end

local function sendFlipsMenu(ply, defaultAmount)
    net.Start("DarkRP_OpenFlipsMenu")
        net.WriteUInt(math.Clamp(defaultAmount or 100, minFlipAmount, maxFlipAmount), 32)
        net.WriteTable(getPendingFlipList(ply))

        local own = pendingFlips[ply:SteamID()]
        net.WriteBool(own ~= nil)
        if own then
            net.WriteString(own.choice)
            net.WriteUInt(own.amount, 32)
            net.WriteUInt(math.floor(CurTime() - own.createdAt), 32)
        end
    net.Send(ply)
end

local function createFlipChallenge(ply, amount, choice)
    amount = math.floor(amount or 0)
    choice = string.lower(choice or "")

    if not isValidFlipChoice(choice) then
        choice = "heads"
    end
    if amount < minFlipAmount or amount > maxFlipAmount then
        DarkRP.notify(ply, 1, 4, "Flip bets must be between " .. minFlipAmount .. " and " .. DarkRP.formatMoney(maxFlipAmount) .. ".")
        return
    end
    if pendingFlips[ply:SteamID()] then
        DarkRP.notify(ply, 1, 4, "You already have a pending flip challenge.")
        return
    end
    if not ply:canAfford(amount) then
        DarkRP.notify(ply, 1, 4, "You cannot afford that flip.")
        return
    end

    ply:addMoney(-amount)
    pendingFlips[ply:SteamID()] = {
        creator = ply,
        creatorName = ply:Nick(),
        amount = amount,
        choice = choice,
        createdAt = CurTime(),
    }

    DarkRP.notifyAll(0, 5, ply:Nick() .. " opened a flip challenge for " .. DarkRP.formatMoney(amount) .. ". Type /acceptflip " .. ply:Nick() .. " to take the wager.")
end

local function resolveFlip(challenge, accepter)
    if not IsValid(challenge.creator) or not challenge.creator:IsPlayer() or not IsValid(accepter) or not accepter:IsPlayer() then
        if IsValid(challenge.creator) and challenge.creator:IsPlayer() then
            challenge.creator:addMoney(challenge.amount)
            DarkRP.notify(challenge.creator, 0, 4, "Your flip was refunded because the opponent was unavailable.")
        end
        return
    end

    local result = flipCoin()
    local winner = result == challenge.choice and challenge.creator or accepter
    local payout = challenge.amount * 2
    winner:addMoney(payout)

    DarkRP.notifyAll(0, 6, string.format("%s accepted %s's flip for %s. Coin shows %s. %s wins %s!",
        accepter:Nick(), challenge.creatorName, DarkRP.formatMoney(payout), result, winner:Nick(), DarkRP.formatMoney(payout)))
end

local function acceptFlipChallenge(ply, targetName)
    if not targetName or targetName == "" then
        DarkRP.notify(ply, 1, 4, "Specify the challenge creator you want to accept, for example /acceptflip John.")
        return
    end

    cleanupPendingFlips()

    local targetKey, challenge
    local normalized = string.lower(targetName)
    for steamID, pending in pairs(pendingFlips) do
        local creatorName = string.lower(pending.creatorName)
        if creatorName == normalized or string.find(creatorName, normalized, 1, true) or steamID == targetName then
            targetKey = steamID
            challenge = pending
            break
        end
    end

    if not challenge then
        DarkRP.notify(ply, 1, 4, "No open flip challenge found for '" .. targetName .. "'.")
        return
    end
    if challenge.creator == ply then
        DarkRP.notify(ply, 1, 4, "You cannot accept your own flip challenge.")
        return
    end
    if not ply:canAfford(challenge.amount) then
        DarkRP.notify(ply, 1, 4, "You cannot afford that challenge.")
        return
    end

    pendingFlips[targetKey] = nil
    ply:addMoney(-challenge.amount)
    resolveFlip(challenge, ply)
end

local function cancelFlipChallenge(ply)
    local existing = pendingFlips[ply:SteamID()]
    if not existing then
        DarkRP.notify(ply, 1, 4, "You have no active flip challenge to cancel.")
        return
    end

    pendingFlips[ply:SteamID()] = nil
    ply:addMoney(existing.amount)
    DarkRP.notify(ply, 0, 4, "Your flip challenge has been cancelled and your money was returned.")
end

DarkRP.defineChatCommand("flips", function(ply, args)
    if args and string.find(args:lower(), "cancel") then
        cancelFlipChallenge(ply)
        return ""
    end

    local amount = tonumber(string.match(args or "", "%d+")) or 100
    amount = math.Clamp(amount, minFlipAmount, maxFlipAmount)
    sendFlipsMenu(ply, amount)
    return ""
end)

DarkRP.defineChatCommand("flip", function(ply, args)
    local amount = tonumber(string.match(args or "", "%d+")) or 100
    amount = math.Clamp(amount, minFlipAmount, maxFlipAmount)
    sendFlipsMenu(ply, amount)
    return ""
end)

DarkRP.defineChatCommand("acceptflip", function(ply, args)
    acceptFlipChallenge(ply, args or "")
    return ""
end)

net.Receive("DarkRP_FlipsAction", function(len, ply)
    local action = net.ReadString()
    if action == "create" then
        createFlipChallenge(ply, net.ReadUInt(32), net.ReadString())
    elseif action == "accept" then
        acceptFlipChallenge(ply, net.ReadString())
    elseif action == "cancel" then
        cancelFlipChallenge(ply)
    else
        sendFlipsMenu(ply, net.ReadUInt(32))
    end
end)
