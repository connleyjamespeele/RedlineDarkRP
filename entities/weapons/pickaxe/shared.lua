SWEP.PrintName = "Pickaxe"
SWEP.Author = "AI"
SWEP.Instructions = "Left click to mine nodes"
SWEP.Spawnable = false
SWEP.AdminOnly = false

SWEP.ViewModel = "models/weapons/v_crowbar.mdl"
SWEP.WorldModel = "models/weapons/w_crowbar.mdl"

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
    if tr.Entity:GetClass() == "mining_node" then
        tr.Entity:Mine(self.Owner)
    end
end

function SWEP:SecondaryAttack()
    -- Upgrade or something
end