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
    if suitType == "flash" then
        caller:SetMaxHealth(30000)
        caller:SetHealth(30000)
        caller:SetArmor(100)
        caller:SetWalkSpeed(caller:GetWalkSpeed() * 3)
        caller:SetRunSpeed(caller:GetRunSpeed() * 3)
        caller.flashSuit = true
    elseif suitType == "carl" then
        caller:SetMaxHealth(800)
        caller:SetHealth(800)
        caller:SetArmor(10)
        caller:SetWalkSpeed(caller:GetWalkSpeed() * 0.5)
        caller:SetRunSpeed(caller:GetRunSpeed() * 0.5)
        caller.carlSuit = true
    elseif suitType == "sans" then
        caller:SetMaxHealth(1)
        caller:SetHealth(1)
        caller:SetArmor(1000)
        caller:SetWalkSpeed(caller:GetWalkSpeed() * 1.5)
        caller:SetRunSpeed(caller:GetRunSpeed() * 1.5)
        caller.sansSuit = true
    elseif suitType == "jugger" then
        caller:SetMaxHealth(500000)
        caller:SetHealth(500000)
        caller:SetArmor(150)
        caller.juggerSuit = true
    end
    self:Remove()
end

-- Hook for G key abilities
hook.Add("KeyPress", "BlackMarketSuitAbilities", function(ply, key)
    if key == IN_RELOAD then -- G key
        if ply.flashSuit then
            ply:SetVelocity(ply:GetForward() * 1000) -- Super fast dash
        elseif ply.carlSuit then
            ply:Give("weapon_coder_baton")
            ply:addMoney(100000)
        elseif ply.sansSuit then
            ply:SetPos(ply:GetPos() + ply:GetForward() * 500) -- Teleport
        elseif ply.juggerSuit then
            ply:Give("weapon_jugger_hammer")
            timer.Simple(30, function() ply:StripWeapon("weapon_jugger_hammer") end)
        end
    end
end)