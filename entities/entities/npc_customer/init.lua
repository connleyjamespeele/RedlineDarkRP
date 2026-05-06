AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:Initialize()
    self:SetModel("models/player/Group01/Male_01.mdl")
    self:SetHullType(HULL_HUMAN)
    self:SetHullSizeNormal()
    self:SetNPCState(NPC_STATE_SCRIPT)
    self:SetSolid(SOLID_BBOX)
    self:CapabilitiesAdd(CAP_ANIMATEDFACE)
    self:SetUseType(SIMPLE_USE)
    self:DropToFloor()

    self.order = nil
    self.eating = false
end

function ENT:Use(activator, caller)
    -- Perhaps interact
end

function ENT:Think()
    -- AI for ordering, eating, paying
end

function ENT:ReceivePlate()
    self.eating = true
    timer.Simple(60, function() self:FinishEating() end) -- 1 minute to eat
end

function ENT:FinishEating()
    self.eating = false
    -- Pay and leave
    local owner = self:Getowning_ent()
    if IsValid(owner) then
        owner:addMoney(50) -- Example payout
    end
    self:Remove()
end