AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:Initialize()
    self:SetModel("models/player/group03/male_04.mdl")
    self:SetHullType(HULL_HUMAN)
    self:SetHullSizeNormal()
    self:SetNPCState(NPC_STATE_SCRIPT)
    self:SetSolid(SOLID_BBOX)
    self:CapabilitiesAdd(CAP_ANIMATEDFACE)
    self:SetUseType(SIMPLE_USE)
    self:DropToFloor()

    self.customers = {} -- Queue of customers waiting for drinks
    self.serving = false
    self.serveTimer = 0
end

function ENT:Use(activator, caller)
    -- Serve drink to player or NPC
end

function ENT:Think()
    self:UpdateAI()
end

function ENT:UpdateAI()
    if not self.serving and #self.customers > 0 then
        self:StartServing()
    elseif self.serving then
        self.serveTimer = self.serveTimer + FrameTime()
        if self.serveTimer > 10 then -- Serve for 10 seconds
            self:FinishServing()
        end
    end
end

function ENT:ReceiveDrinkOrder(customer)
    table.insert(self.customers, customer)
end

function ENT:StartServing()
    self.serving = true
    self.serveTimer = 0
    -- Animation
end

function ENT:FinishServing()
    self.serving = false
    local customer = table.remove(self.customers, 1)
    if customer then
        -- Give drink, customer pays
        local owner = self:Getowning_ent()
        if IsValid(owner) then
            owner:addMoney(20) -- Drink price
        end
    end
end