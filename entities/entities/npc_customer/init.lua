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
    self.state = "idle" -- idle, ordering, waiting, eating, paying, leaving
    self.stateTimer = 0
    self.targetTable = nil
    self.targetChef = nil
    self.targetBartender = nil
end

function ENT:Use(activator, caller)
    -- Perhaps interact with player
end

function ENT:Think()
    self:UpdateAI()
end

function ENT:UpdateAI()
    self.stateTimer = self.stateTimer + FrameTime()

    if self.state == "idle" then
        -- Look for a table or bar
        local tables = ents.FindByClass("restaurant_table")
        if #tables > 0 then
            self.targetTable = tables[math.random(#tables)]
            self.state = "moving_to_table"
function ENT:MoveToPos(pos)
    self:SetLastPosition(pos)
    self:SetSchedule(SCHED_FORCED_GO)
end
        end
    elseif self.state == "moving_to_table" then
        if self:GetPos():Distance(self.targetTable:GetPos()) < 100 then
            self.state = "ordering"
            self.stateTimer = 0
        end
    elseif self.state == "ordering" then
        if self.stateTimer > 5 then -- Wait 5 seconds
            self:OrderFood()
            self.state = "waiting"
            self.stateTimer = 0
        end
    elseif self.state == "waiting" then
        -- Wait for food
        if self.eating then
            self.state = "eating"
            self.stateTimer = 0
        elseif self.stateTimer > 30 then -- Timeout
            self.state = "leaving"
        end
    elseif self.state == "eating" then
        if self.stateTimer > 60 then -- Eat for 1 minute
            self:FinishEating()
            self.state = "paying"
            self.stateTimer = 0
        end
    elseif self.state == "paying" then
        if self.stateTimer > 5 then
            self.state = "leaving"
            self.stateTimer = 0
        end
    elseif self.state == "leaving" then
        if self.stateTimer > 10 then
            self:Remove()
        end
    end
end

function ENT:OrderFood()
    local chefs = ents.FindByClass("chef_npc")
    if #chefs > 0 then
        self.targetChef = chefs[math.random(#chefs)]
        self.targetChef:ReceiveOrder(self, "random_food")
        self.order = "random_food"
    end
end

function ENT:ReceivePlate()
    self.eating = true
end

function ENT:FinishEating()
    self.eating = false
    -- Pay
    local owner = self:Getowning_ent()
    if IsValid(owner) then
        owner:addMoney(50)
    end
end

function ENT:MoveToPos(pos)
    self:SetLastPosition(pos)
    self:SetSchedule(SCHED_FORCED_GO)
end