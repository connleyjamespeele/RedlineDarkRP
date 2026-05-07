SWEP.PrintName = "Wires"
SWEP.Author = "AI"
SWEP.Instructions = "Link solar panels, converters, and rechargers"
SWEP.Spawnable = false
SWEP.AdminOnly = false

SWEP.ViewModel = "models/weapons/v_hands.mdl"
SWEP.WorldModel = "models/weapons/w_hands.mdl"

SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "none"

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"

if SERVER then
    function SWEP:PrimaryAttack()
        self:SetNextPrimaryFire(CurTime() + 0.5)
        local tr = self.Owner:GetEyeTrace()
        local ent = tr.Entity
        
        if not IsValid(ent) then return end
        
        -- Store first entity
        if not self.Owner.WireFirst then
            if ent:GetClass() == "solar_panel" or ent:GetClass() == "solar_converter" or ent:GetClass() == "solar_recharger" then
                self.Owner.WireFirst = ent
                self.Owner:ChatPrint("First entity marked. Click another to link.")
            end
        else
            -- Connect second entity
            local first = self.Owner.WireFirst
            if first:GetClass() == "solar_panel" and ent:GetClass() == "solar_converter" then
                ent:ConnectPanel(first)
                self.Owner:ChatPrint("Panel connected to converter!")
            elseif first:GetClass() == "solar_converter" and ent:GetClass() == "solar_recharger" then
                ent:SetNWEntity("Converter", first)
                self.Owner:ChatPrint("Converter connected to recharger!")
            end
            self.Owner.WireFirst = nil
        end
    end
    
    function SWEP:SecondaryAttack()
        self:SetNextSecondaryFire(CurTime() + 0.5)
        self.Owner.WireFirst = nil
        self.Owner:ChatPrint("Wire linking cancelled.")
    end
end