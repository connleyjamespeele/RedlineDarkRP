AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:Initialize()
    self:SetModel("models/props_wasteland/rockgranite02a.mdl")
    DarkRP.ValidatedPhysicsInit(self, SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)

    local phys = self:GetPhysicsObject()

    if phys:IsValid() then
        phys:Wake()
    end

    self:SetHealth(10)
end

function ENT:Mine(miner)
    self:SetHealth(self:GetHealth() - 1)
    if self:GetHealth() <= 0 then
        -- Spawn ore
        local ore = ents.Create("raw_ore")
        ore:SetPos(self:GetPos() + Vector(0,0,20))
        ore:Spawn()
        self:Remove()
    end
end