AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")

include("shared.lua")

util.AddNetworkString("OpenGlobeMenu")
util.AddNetworkString("CreateColony")
util.AddNetworkString("UpgradeColony")

function ENT:Initialize()
    self:SetModel("models/props_phx/misc/smallcannonball.mdl")
    DarkRP.ValidatedPhysicsInit(self, SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)

    local phys = self:GetPhysicsObject()
    if phys:IsValid() then
        phys:Wake()
    end

    self:SetNWInt("ColonyCount", 0)
    self:SetNWInt("TotalIncome", 0)
    self:SetNWInt("MilitaryPower", 0)
    self:SetNWBool("CanConquer", false)
    
    timer.Create("GlobeIncome_" .. self:EntIndex(), 300, 0, function()
        if not IsValid(self) then return end
        local owner = self:Getowning_ent()
        if IsValid(owner) and owner:IsPlayer() then
            local income = 1000 * self:GetNWInt("ColonyCount")
            owner:addMoney(income)
            self:SetNWInt("TotalIncome", self:GetNWInt("TotalIncome") + income)
        end
    end)
end

function ENT:Use(activator, caller)
    if activator ~= self:Getowning_ent() then return end
    net.Start("OpenGlobeMenu")
    net.WriteEntity(self)
    net.Send(activator)
end

net.Receive("CreateColony", function(len, ply)
    local globe = net.ReadEntity()
    if not IsValid(globe) or globe:Getowning_ent() ~= ply then return end
    if globe:GetNWInt("ColonyCount") >= 5 then
        ply:ChatPrint("Maximum colonies reached!")
        return
    end
    if not ply:canAfford(100000000) then
        ply:ChatPrint("Not enough money!")
        return
    end
    ply:addMoney(-100000000)
    globe:SetNWInt("ColonyCount", globe:GetNWInt("ColonyCount") + 1)
    ply:ChatPrint("New colony established!")
end)

net.Receive("UpgradeColony", function(len, ply)
    local globe = net.ReadEntity()
    local upgrade = net.ReadString()
    if not IsValid(globe) or globe:Getowning_ent() ~= ply then return end
    
    local costs = {
        industry = 50000,
        donate = 100000,
        trade = 200000,
        military = 150000,
        research = 300000,
        diplomacy = 100000
    }
    
    local cost = costs[upgrade] or 50000
    if ply:canAfford(cost) then
        ply:addMoney(-cost)
        ply:ChatPrint("Colony upgrade purchased!")
    end
end)

function ENT:OnRemove()
    timer.Remove("GlobeIncome_" .. self:EntIndex())
end