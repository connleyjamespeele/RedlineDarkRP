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

    self.refining = false
    self.refineTime = 0
end

function ENT:Use(activator, caller)
    if not self.refining then
        -- Start refining raw ore
        self:StartRefining()
    end
end

function ENT:StartRefining()
    self.refining = true
    self.refineTime = CurTime() + 60 -- 1 minute
end

function ENT:Think()
    if self.refining and CurTime() > self.refineTime then
        self:FinishRefining()
    end
end

function ENT:FinishRefining()
    self.refining = false
    -- Spawn refined ore
    local refined = ents.Create("refined_ore")
    refined:SetPos(self:GetPos() + Vector(0,0,50))
    refined:Spawn()
end