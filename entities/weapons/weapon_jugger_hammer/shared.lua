SWEP.PrintName = "Jugger Hammer"
SWEP.Author = "AI"
SWEP.Instructions = "Massive damage hammer"
SWEP.Spawnable = false
SWEP.AdminOnly = false

SWEP.ViewModel = "models/weapons/v_hammer.mdl"
SWEP.WorldModel = "models/weapons/w_hammer.mdl"

SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "none"

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"

function SWEP:PrimaryAttack()
    self:SetNextPrimaryFire(CurTime() + 2)
    local tr = self.Owner:GetEyeTrace()
    if tr.Entity:IsPlayer() then
        tr.Entity:TakeDamage(5000, self.Owner, self)
    end
end

function SWEP:CanSwitchTo()
    return false -- Can't switch away
end