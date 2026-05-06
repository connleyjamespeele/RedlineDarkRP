AddCSLuaFile("shared.lua")
include("shared.lua")

if SERVER then
    function ENT:Initialize()
        self:SetModel("models/props_wasteland/kitchen_counter001b.mdl")
        self:PhysicsInit(SOLID_VPHYSICS)
        self:SetMoveType(MOVETYPE_VPHYSICS)
        self:SetSolid(SOLID_VPHYSICS)
        self:SetUseType(SIMPLE_USE)

        self:SetPriceModifier(0)
        self:SetPremiumBonus(0)
        self:SetServiceBonus(0)

        local phys = self:GetPhysicsObject()
        if phys:IsValid() then
            phys:Wake()
        end
    end
end
