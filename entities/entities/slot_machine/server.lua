include("shared.lua")

function ENT:Initialize()
    self:SetModel("models/props_c17/consolebox01a.mdl")
    DarkRP.ValidatedPhysicsInit(self, SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)

    self.using = false
    self.playersUsing = {}
end

function ENT:Use(activator, caller)
    if not activator:IsPlayer() then return end
    if self.playersUsing[activator:SteamID()] then return DarkRP.notify(activator, 1, 4, "You are already using this machine!") end 
    if self.using == true then return DarkRP.notify(activator, 1, 4, "Someone is already using this machine!") end
    self.playersUsing[activator:SteamID()] = true
    self.using = true

    local RandomSpin = math.random(1, 3)
    if RandomSpin > 2 then
        print("You win!")
    end

    timer.Simple(3, function()
        self.using = false
        self.playersUsing[activator:SteamID()] = nil
    end)
end