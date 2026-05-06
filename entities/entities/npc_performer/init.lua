AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:Initialize()
    self:SetModel("models/player/alyx.mdl")
    self:SetHullType(HULL_HUMAN)
    self:SetHullSizeNormal()
    self:SetNPCState(NPC_STATE_SCRIPT)
    self:SetSolid(SOLID_BBOX)
    self:CapabilitiesAdd(CAP_ANIMATEDFACE)
    self:SetUseType(SIMPLE_USE)
    self:DropToFloor()

    self.performing = false
    self.animIndex = 1
    self.animations = {"dance", "muscle"}
end

function ENT:Use(activator, caller)
    -- Set performance location or something
end

function ENT:Think()
    -- Perform, tip customers
    if not self.performing then
        self:StartPerforming()
    end
end

function ENT:StartPerforming()
    self.performing = true
    self:SetSequence(self.animations[self.animIndex])
    self.animIndex = self.animIndex % #self.animations + 1
    -- Animation, tip logic
    timer.Simple(30, function() self:StopPerforming() end)
end

function ENT:StopPerforming()
    self.performing = false
    -- Give tips to nearby customers
    local customers = ents.FindInSphere(self:GetPos(), 300)
    for _, ent in ipairs(customers) do
        if ent:IsPlayer() then
            ent:addMoney(50) -- Tip
        end
    end
end