ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Management Console"
ENT.Author = "AI"
ENT.Spawnable = false

function ENT:Initialize()
    self:SetModel("models/props_lab/monitor01a.mdl")
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
    local phys = self:GetPhysicsObject()
    if phys:IsValid() then
        phys:Wake()
    end
    self:SetNWBool("WholesaleContract", false)
    self:SetNWBool("FlashFreezer", false)
    self:SetNWBool("PremiumGarnish", false)
    self:SetNWBool("IndustrialStove", false)
    self:SetNWBool("AutoPlater", false)
    self:SetNWBool("HeatLamps", false)
    self:SetNWBool("LuxurySeating", false)
    self:SetNWBool("CondimentCaddy", false)
    self:SetNWBool("ExpediterStation", false)
    self:SetNWBool("DigitalMenu", false)
    self:SetNWBool("ReservationSystem", false)
    self:SetNWBool("SelfServiceKiosk", false)
    self:SetNWBool("SousChefTraining", false)
    self:SetNWBool("MasterPlating", false)
end

function ENT:Use(activator, caller)
    if activator ~= self:Getowning_ent() then return end
    net.Start("OpenChefManagementMenu")
    net.WriteEntity(self)
    net.Send(activator)
end

if SERVER then
    util.AddNetworkString("OpenChefManagementMenu")
    util.AddNetworkString("ChefUpgrade")
    net.Receive("ChefUpgrade", function(len, ply)
        local ent = net.ReadEntity()
        local upgrade = net.ReadString()
        if not IsValid(ent) or ent:Getowning_ent() ~= ply then return end
        local cost = 500 -- Example cost
        if ply:canAfford(cost) then
            ply:addMoney(-cost)
            ent:SetNWBool(upgrade, true)
            ply:ChatPrint("Upgrade purchased!")
        end
    end)
end

function ENT:SetupDataTables()
    self:NetworkVar("Entity", 0, "owning_ent")
end