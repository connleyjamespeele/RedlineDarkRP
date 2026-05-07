AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:Initialize()
    self:SetModel("models/player/chef.mdl")
    self:SetHullType(HULL_HUMAN)
    self:SetHullSizeNormal()
    self:SetNPCState(NPC_STATE_SCRIPT)
    self:SetSolid(SOLID_BBOX)
    self:CapabilitiesAdd(CAP_ANIMATEDFACE)
    self:SetUseType(SIMPLE_USE)
    self:DropToFloor()

    self.orders = {} -- Queue of orders
    self.cooking = false
    self.cookTimer = 0
end

function ENT:Use(activator, caller)
    -- Open menu or something
end

function ENT:Think()
    self:UpdateAI()
end

function ENT:UpdateAI()
    if not self.cooking and #self.orders > 0 then
        self:StartCooking()
    elseif self.cooking then
        self.cookTimer = self.cookTimer + FrameTime()
        if self.cookTimer > 30 then -- Cook for 30 seconds
            self:FinishCooking()
        end
    end
end

function ENT:ReceiveOrder(customer, order)
    table.insert(self.orders, {customer = customer, order = order})
end

function ENT:StartCooking()
    self.cooking = true
    self.cookTimer = 0
    -- Animation or effect
end

function ENT:FinishCooking()
    self.cooking = false
    local order = table.remove(self.orders, 1)
    if order then
        order.customer:ReceivePlate()
    end
end