AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:Initialize()
    self:SetModel("models/props_c17/consolebox01a.mdl")
    DarkRP.ValidatedPhysicsInit(self, SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)

    local phys = self:GetPhysicsObject()

    if phys:IsValid() then
        phys:Wake()
    end

    self:SetSupplies(0)
end

function ENT:Use(activator, caller)
    -- Open black market menu
    net.Start("OpenBlackMarketMenu")
    net.WriteInt(self:GetSupplies(), 32)
    net.Send(caller)
end

function ENT:AddSupplies(amount)
    self:SetSupplies(self:GetSupplies() + amount)
end