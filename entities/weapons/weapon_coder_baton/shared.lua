SWEP.PrintName = "Coder Baton"
SWEP.Author = "AI"
SWEP.Instructions = "Hit players for random effects"
SWEP.Spawnable = false
SWEP.AdminOnly = false

SWEP.ViewModel = "models/weapons/v_stunbaton.mdl"
SWEP.WorldModel = "models/weapons/w_stunbaton.mdl"

SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "none"

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"

function SWEP:PrimaryAttack()
    self:SetNextPrimaryFire(CurTime() + 1)
    local tr = self.Owner:GetEyeTrace()
    if tr.Entity:IsPlayer() then
        local effects = {
            function(ply) ply:SetHealth(ply:Health() + 50) end, -- Good: heal
            function(ply) ply:addMoney(1000) end, -- Good: money
            function(ply) ply:SetHealth(1) end, -- Bad: low health
            function(ply) ply:addMoney(-1000) end, -- Bad: lose money
            function(ply) ply:Ignite(10) end, -- Bad: burn
        }
        effects[math.random(#effects)](tr.Entity)
    end
end