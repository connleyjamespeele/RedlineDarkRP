include("shared.lua")

util.AddNetworkString("DeliveryTerminalMenu")
util.AddNetworkString("StartDelivery")

local activeDeliveries = {}

net.Receive("StartDelivery", function(len, ply)
    local type = net.ReadString()
    if activeDeliveries[ply] then return end

    activeDeliveries[ply] = {
        type = type,
        startTime = CurTime(),
        reward = type == "short" and 10000 or type == "medium" and 15000 or 20000,
        npcs = {},
        currentNPC = 1
    }

    local delivery = activeDeliveries[ply]

    if type == "short" then
        -- Short: timer ticking down
        timer.Create("DeliveryTimer_" .. ply:SteamID(), 3, 0, function()
            if not IsValid(ply) or not activeDeliveries[ply] then return end
            delivery.reward = math.max(0, delivery.reward - 250)
            if delivery.reward <= 0 then
                ply:addMoney(0)
                ply:ChatPrint("Delivery failed! Time ran out.")
                activeDeliveries[ply] = nil
                timer.Remove("DeliveryTimer_" .. ply:SteamID())
            end
        end)
    elseif type == "medium" then
        -- Medium: deliver to one NPC, then another spawns
        SpawnDeliveryNPC(ply, delivery)
    elseif type == "large" then
        -- Large: 3 NPCs
        for i = 1, 3 do
            SpawnDeliveryNPC(ply, delivery)
        end
    end
end)

function SpawnDeliveryNPC(ply, delivery)
    local npc = ents.Create("npc_citizen")
    npc:SetPos(ply:GetPos() + Vector(math.random(-500, 500), math.random(-500, 500), 0))
    npc:Spawn()
    npc:SetNPCState(NPC_STATE_IDLE)
    npc:SetSchedule(SCHED_IDLE_STAND)
    npc.deliveryPlayer = ply
    table.insert(delivery.npcs, npc)

    -- Indicator (simple chat message for now)
    ply:ChatPrint("Deliver to NPC at " .. tostring(npc:GetPos()))
end

hook.Add("PlayerUse", "DeliveryNPCUse", function(ply, ent)
    if ent:GetClass() == "npc_citizen" and ent.deliveryPlayer == ply then
        local delivery = activeDeliveries[ply]
        if delivery then
            table.RemoveByValue(delivery.npcs, ent)
            ent:Remove()

            if delivery.type == "medium" and #delivery.npcs == 0 then
                -- Spawn another
                SpawnDeliveryNPC(ply, delivery)
            elseif delivery.type == "large" and #delivery.npcs == 0 then
                -- All delivered
                ply:addMoney(delivery.reward)
                ply:ChatPrint("Delivery completed! Earned $" .. delivery.reward)
                activeDeliveries[ply] = nil
            elseif delivery.type == "short" then
                ply:addMoney(delivery.reward)
                ply:ChatPrint("Delivery completed! Earned $" .. delivery.reward)
                activeDeliveries[ply] = nil
                timer.Remove("DeliveryTimer_" .. ply:SteamID())
            end
        end
    end
end)