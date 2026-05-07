AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:Initialize()
    self:SetModel("models/player/combine_soldier.mdl")
    self:SetHullType(HULL_HUMAN)
    self:SetHullSizeNormal()
    self:SetNPCState(NPC_STATE_SCRIPT)
    self:SetSolid(SOLID_BBOX)
    self:CapabilitiesAdd(CAP_ANIMATEDFACE)
    self:SetUseType(SIMPLE_USE)
    self:DropToFloor()

    self.patrolPoints = {} -- Define patrol points
    self.currentPatrolIndex = 1
    self.patrolTimer = 0
    self.alertLevel = 0 -- 0: normal, 1: suspicious, 2: alert
end

function ENT:Think()
    self:UpdateAI()
end

function ENT:UpdateAI()
    self.patrolTimer = self.patrolTimer + FrameTime()

    if self.alertLevel == 0 then
        -- Normal patrol
        if self.patrolTimer > 10 then -- Move every 10 seconds
            self:MoveToNextPatrolPoint()
            self.patrolTimer = 0
        end
    elseif self.alertLevel == 1 then
        -- Look around suspiciously
        self:SetNPCState(NPC_STATE_ALERT)
    elseif self.alertLevel == 2 then
        -- Chase troublemaker
        local troublemakers = ents.FindByClass("npc_customer") -- Assuming troublemakers are customers
        for _, tm in ipairs(troublemakers) do
            if tm:GetNWString("CustomerType") == "troublemaker" and self:GetPos():Distance(tm:GetPos()) < 300 then
                self:Chase(tm)
                break
            end
        end
    end

    -- Check for trouble
    self:CheckForTrouble()
end

function ENT:MoveToNextPatrolPoint()
    if #self.patrolPoints == 0 then
        -- Define some default patrol points around the entity
        self.patrolPoints = {
            self:GetPos() + Vector(100, 0, 0),
            self:GetPos() + Vector(0, 100, 0),
            self:GetPos() + Vector(-100, 0, 0),
            self:GetPos() + Vector(0, -100, 0)
        }
    end
    self.currentPatrolIndex = self.currentPatrolIndex % #self.patrolPoints + 1
    self:MoveToPos(self.patrolPoints[self.currentPatrolIndex])
end

function ENT:CheckForTrouble()
    local ents_near = ents.FindInSphere(self:GetPos(), 200)
    for _, ent in ipairs(ents_near) do
        if ent:GetClass() == "npc_customer" and ent:GetNWString("CustomerType") == "troublemaker" then
            self.alertLevel = 2
            return
        end
    end
    self.alertLevel = 0
end

function ENT:Chase(target)
    if IsValid(target) then
        self:MoveToPos(target:GetPos())
        if self:GetPos():Distance(target:GetPos()) < 50 then
            target:Remove() -- Remove troublemaker
            self.alertLevel = 0
        end
    end
end

function ENT:MoveToPos(pos)
    self:SetLastPosition(pos)
    self:SetSchedule(SCHED_FORCED_GO_RUN)
end