ENT.Type = "anim"
ENT.Base = "base_gmodentity"

ENT.PrintName = "Bar Counter"
ENT.Author = "AI"
ENT.Category = "Service"
ENT.Spawnable = true

function ENT:SetupDataTables()
    self:NetworkVar("Float", 0, "PriceModifier")
    self:NetworkVar("Float", 1, "PremiumBonus")
    self:NetworkVar("Float", 2, "ServiceBonus")
end

if SERVER then
    function ENT:Use(activator, caller)
        if activator:IsPlayer() then
            net.Start("Redline_BarMenuOpen")
                net.WriteEntity(self)
                net.WriteTable({
                    ownerName = IsValid(self:GetOwning_ent()) and self:GetOwning_ent():Nick() or "No owner",
                    isOwner = self:GetOwning_ent() == activator,
                    priceModifier = self:GetPriceModifier(),
                    premiumBonus = self:GetPremiumBonus(),
                    serviceBonus = self:GetServiceBonus(),
                })
            net.Send(activator)
        end
    end
else
    function ENT:Draw()
        self:DrawModel()
    end
end
