AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:Initialize()
    self:SetModel("models/props_interiors/Furniture_Couch01a.mdl")
    DarkRP.ValidatedPhysicsInit(self, SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)

    local phys = self:GetPhysicsObject()

    if phys:IsValid() then
        phys:Wake()
    end

    self.inUse = false
end

function ENT:Use(activator, caller)
    if not self.inUse then
        self:StartLapDance(caller)
    end
end

function ENT:StartLapDance(customer)
    self.inUse = true
    -- Spawn performer, animation, pay premium
    timer.Simple(60, function() self:EndLapDance() end)
end

function ENT:EndLapDance()
    self.inUse = false
end