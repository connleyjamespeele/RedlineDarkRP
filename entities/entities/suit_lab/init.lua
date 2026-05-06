AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:Initialize()
    self:SetModel("models/props_c17/consolebox01a.mdl")
    DarkRP.ValidatedPhysicsInit(self, SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)

    local phys = self:GetPhysicsObject()

    if phys:IsValid() then
        phys:Wake()
    end
end

function ENT:Use(activator, caller)
    -- Open suit crafting menu
    net.Start("OpenSuitLabMenu")
    net.Send(caller)
end

-- Function to craft suit
function ENT:CraftSuit(tier)
    local cost = 1000 * tier -- Example cost
    if self:Getowning_ent():canAfford(cost) then
        self:Getowning_ent():addMoney(-cost)
        local suit = ents.Create("dealer_suit")
        suit:SetTier(tier)
        suit:SetPos(self:GetPos() + Vector(0,0,50))
        suit:Spawn()
    end
end