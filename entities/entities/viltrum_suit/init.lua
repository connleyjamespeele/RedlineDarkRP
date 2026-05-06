AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:Initialize()
    self:SetModel("models/player/superhero.mdl")
    DarkRP.ValidatedPhysicsInit(self, SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)

    local phys = self:GetPhysicsObject()

    if phys:IsValid() then
        phys:Wake()
    end
end

function ENT:Use(activator, caller)
    local suitType = self:GetSuitType()
    if suitType == "peon" then
        caller:SetMaxHealth(150000)
        caller:SetHealth(150000)
        caller:SetArmor(100)
    elseif suitType == "warrior" then
        caller:SetMaxHealth(250000)
        caller:SetHealth(250000)
        caller:SetArmor(200)
    elseif suitType == "conqueror" then
        caller:SetMaxHealth(400000)
        caller:SetHealth(400000)
        caller:SetArmor(300)
        -- Add flight
        caller:SetMoveType(MOVETYPE_FLY)
    end
    self:Remove()
end