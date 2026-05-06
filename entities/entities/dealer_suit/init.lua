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
    local tier = self:GetTier()
    local stats = {
        [1] = {hp = 15000, armor = 25},
        [2] = {hp = 30000, armor = 50},
        [3] = {hp = 55000, armor = 75},
        [4] = {hp = 75000, armor = 100},
        [5] = {hp = 125000, armor = 125}, -- God
        [6] = {hp = 160000, armor = 150}, -- Ultra God
        [7] = {hp = 200000, armor = 350}, -- Admin Suit
    }
    local s = stats[tier]
    if s then
        caller:SetMaxHealth(s.hp)
        caller:SetHealth(s.hp)
        caller:SetArmor(s.armor)
    end
    self:Remove()
end