AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:Initialize()
    self:SetModel("models/props_c17/furnitureStove001a.mdl")
    DarkRP.ValidatedPhysicsInit(self, SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)

    local phys = self:GetPhysicsObject()

    if phys:IsValid() then
        phys:Wake()
    end

    self.smelting = false
    self.smeltTime = 0
end

function ENT:Use(activator, caller)
    if not self.smelting then
        self:StartSmelting()
    end
end

function ENT:StartSmelting()
    self.smelting = true
    self.smeltTime = CurTime() + 45 -- 45 seconds
end

function ENT:Think()
    if self.smelting and CurTime() > self.smeltTime then
        self:FinishSmelting()
    end
end

function ENT:FinishSmelting()
    self.smelting = false
    -- Spawn ingot
    local ingot = ents.Create("ingot")
    ingot:SetPos(self:GetPos() + Vector(0,0,50))
    ingot:Spawn()
end