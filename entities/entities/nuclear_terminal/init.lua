include("shared.lua")

util.AddNetworkString("NuclearTerminalMenu")
util.AddNetworkString("NuclearTerminalAction")
util.AddNetworkString("NuclearReactorAlert")

local function GetEntityOwner(ent)
    if not IsValid(ent) then return nil end
    if ent.Getowning_ent then
        local owner = ent:Getowning_ent()
        if IsValid(owner) then return owner end
    end
    if ent.GetOwner then
        local owner = ent:GetOwner()
        if IsValid(owner) then return owner end
    end
    return nil
end

local function FindReactorForTerminal(term)
    for _, reactor in ipairs(ents.FindByClass("nuclear_reactor")) do
        if reactor:GetPos():Distance(term:GetPos()) < 500 then
            return reactor
        end
    end
    return nil
end

local function FindOwnerWorker(owner)
    for _, worker in ipairs(ents.FindByClass("nuclear_worker")) do
        if IsValid(worker) then
            local workerOwner = GetEntityOwner(worker)
            if workerOwner == owner then
                return worker
            end
        end
    end
    return nil
end

function ENT:Use(activator, caller)
    if not activator:IsPlayer() or activator:Team() ~= TEAM_NUCLEAR_WORKER then return end

    local reactor = FindReactorForTerminal(self)
    local worker = FindOwnerWorker(activator)

    net.Start("NuclearTerminalMenu")
    net.WriteEntity(self)
    net.WriteBool(IsValid(reactor))
    if IsValid(reactor) then
        net.WriteInt(reactor:GetHeat(), 16)
        net.WriteInt(reactor:GetWaste(), 16)
        net.WriteInt(reactor:GetCoolingBarrels(), 8)
        net.WriteInt(reactor:GetMaxCoolingBarrels(), 8)
        net.WriteInt(reactor:GetHeatRate(), 8)
        net.WriteInt(reactor:GetWasteRate(), 8)
        net.WriteInt(reactor:GetBankedMoney(), 32)
        net.WriteInt(reactor:GetLaunderPercent(), 8)
        net.WriteInt(reactor:GetCleanEnergyLevel(), 8)
        net.WriteBool(reactor:GetRemoteAlarm())
        net.WriteBool(reactor:GetHeatSinkInstalled())
        net.WriteBool(reactor:GetMoneyLaundered())
        net.WriteBool(reactor:GetLeadLined())
    end
    net.WriteBool(IsValid(worker))
    if IsValid(worker) then
        net.WriteBool(worker:GetAutoRefill())
        net.WriteInt(worker:GetPriorityMode(), 4)
        net.WriteBool(worker:GetBribeInspector())
        net.WriteBool(worker:GetLegalDisposal())
    end
    net.Send(activator)
end

local function CreateWasteBarrel(reactor, term)
    local waste = ents.Create("waste_barrel")
    if not IsValid(waste) then return end
    waste:SetPos(term:GetPos() + Vector(0, 50, 0))
    waste:Spawn()
    if waste.SetWasteAmount then
        waste:SetWasteAmount(reactor:GetWaste())
    end
    if waste.SetLeadLined then
        waste:SetLeadLined(reactor:GetLeadLined())
    end
    reactor:SetWaste(0)
end

net.Receive("NuclearTerminalAction", function(len, ply)
    local action = net.ReadString()
    local ent = net.ReadEntity()
    if not IsValid(ent) or ent:GetClass() ~= "nuclear_terminal" then return end
    local reactor = FindReactorForTerminal(ent)
    local worker = FindOwnerWorker(ply)

    if action == "withdraw_waste" then
        if IsValid(reactor) and reactor:GetWaste() > 0 then
            CreateWasteBarrel(reactor, ent)
            ply:ChatPrint("Waste withdrawn from reactor.")
        else
            ply:ChatPrint("No waste available to withdraw.")
        end
        return
    end

    if action == "emergency_flush" then
        if not IsValid(reactor) then return end
        if reactor:EmergencyFlush(ply) then
            ply:ChatPrint("Emergency coolant flush activated.")
        else
            ply:ChatPrint("Not enough money for emergency flush.")
        end
        return
    end

    if action == "set_priority" and IsValid(worker) then
        local mode = net.ReadInt(4)
        worker:SetPriorityMode(mode)
        local label = mode == 0 and "heat" or "waste"
        ply:ChatPrint("Worker priority set to " .. label .. ".")
        return
    end

    if action == "toggle_auto_refill" and IsValid(worker) then
        if worker:GetAutoRefill() then
            ply:ChatPrint("Auto-Refill already installed.")
            return
        end
        local cost = 2500
        if not ply:canAfford(cost) then
            ply:ChatPrint("Not enough money for Auto-Refill Station.")
            return
        end
        ply:addMoney(-cost)
        worker:SetAutoRefill(true)
        ply:ChatPrint("Auto-Refill Station installed.")
        return
    end

    if action == "purchase_bribe_inspector" and IsValid(worker) then
        if worker:GetBribeInspector() then
            ply:ChatPrint("Inspector already bribed.")
            return
        end
        local cost = 5000
        if not ply:canAfford(cost) then
            ply:ChatPrint("Not enough money to bribe the inspector.")
            return
        end
        ply:addMoney(-cost)
        worker:SetBribeInspector(true)
        ply:ChatPrint("Inspector bribed. Waste disposal risk reduced.")
        return
    end

    if action == "purchase_heat_sink" and IsValid(reactor) then
        if reactor:GetHeatSinkInstalled() then
            ply:ChatPrint("Heat sink already installed.")
            return
        end
        local cost = 4000
        if not ply:canAfford(cost) then
            ply:ChatPrint("Not enough money for heat sink installation.")
            return
        end
        ply:addMoney(-cost)
        reactor:SetHeatSinkInstalled(true)
        ply:ChatPrint("Heat sink installed. Heat accumulation slowed.")
        return
    end

    if action == "purchase_expansion" and IsValid(reactor) then
        local target = net.ReadInt(4)
        local cost = target == 6 and 3000 or 5000
        if reactor:GetMaxCoolingBarrels() >= target then
            ply:ChatPrint("Reactor already has that capacity.")
            return
        end
        if not ply:canAfford(cost) then
            ply:ChatPrint("Not enough money for reactor expansion.")
            return
        end
        ply:addMoney(-cost)
        reactor:SetMaxCoolingBarrels(target)
        ply:ChatPrint("Reactor capacity expanded to " .. target .. " barrels.")
        return
    end

    if action == "purchase_money_laundering" and IsValid(reactor) then
        if reactor:GetMoneyLaundered() then
            ply:ChatPrint("Money laundering already active.")
            return
        end
        local cost = 4500
        if not ply:canAfford(cost) then
            ply:ChatPrint("Not enough money for money laundering terminal.")
            return
        end
        ply:addMoney(-cost)
        reactor:SetLaunderPercent(20)
        reactor:SetMoneyLaundered(true)
        ply:ChatPrint("Money laundering terminal active.")
        return
    end

    if action == "purchase_lead_lining" and IsValid(reactor) then
        if reactor:GetLeadLined() then
            ply:ChatPrint("Lead lining already applied.")
            return
        end
        local cost = 3500
        if not ply:canAfford(cost) then
            ply:ChatPrint("Not enough money for advanced lead lining.")
            return
        end
        ply:addMoney(-cost)
        reactor:SetLeadLined(true)
        ply:ChatPrint("Waste barrels now have advanced lead lining.")
        return
    end

    if action == "purchase_research" and IsValid(reactor) then
        local cost = 5000
        if not ply:canAfford(cost) then
            ply:ChatPrint("Not enough money for research upgrade.")
            return
        end
        ply:addMoney(-cost)
        reactor:SetCleanEnergyLevel(reactor:GetCleanEnergyLevel() + 1)
        ply:ChatPrint("Research Center upgraded. Energy efficiency improved.")
        return
    end

    if action == "purchase_remote_alarm" and IsValid(reactor) then
        if reactor:GetRemoteAlarm() then
            ply:ChatPrint("Remote alarm already active.")
            return
        end
        local cost = 1500
        if not ply:canAfford(cost) then
            ply:ChatPrint("Not enough money for remote alarm system.")
            return
        end
        ply:addMoney(-cost)
        reactor:SetRemoteAlarm(true)
        ply:ChatPrint("Remote alarm system enabled.")
        return
    end
end)