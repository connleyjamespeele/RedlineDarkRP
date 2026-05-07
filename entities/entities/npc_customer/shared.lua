ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "NPC Customer"
ENT.Author = "AI"
ENT.Spawnable = false

function ENT:Initialize()
    local type = self:GetNWString("CustomerType", "regular")
    local models = {
        regular = "models/player/Group01/Male_01.mdl",
        tourist = "models/player/Group01/Female_01.mdl",
        vip = "models/player/gman_high.mdl",
        troublemaker = "models/player/combine_soldier.mdl",
        party_group = "models/player/Group01/Male_02.mdl",
        businessperson = "models/player/group03/male_04.mdl"
    }
    
    local stats = {
        regular = {spend = 5500, tip = 30, bartime = 20, watchtime = 60},
        tourist = {spend = 3000, tip = 80, bartime = 30, watchtime = 90},
        vip = {spend = 8500, tip = 250, bartime = 40, watchtime = 120},
        troublemaker = {spend = 50, tip = -20, bartime = 15, watchtime = 30},
        party_group = {spend = 4500, tip = 150, bartime = 35, watchtime = 100},
        businessperson = {spend = 7000, tip = 200, bartime = 45, watchtime = 110}
    }
    
    self:SetModel(models[type] or models.regular)
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
    local phys = self:GetPhysicsObject()
    if phys:IsValid() then
        phys:Wake()
    end
    self:SetSchedule(SCHED_IDLE_WANDER)
    
    self.Stats = stats[type] or stats.regular
    self.CurrentState = "arriving" -- arriving, at_bar, watching, leaving
    self.StateTimer = 0
    
    -- Behavior loop
    timer.Create("CustomerBehavior_" .. self:EntIndex(), 1, 0, function()
        if not IsValid(self) then return end
        self:UpdateBehavior()
    end)
end

function ENT:UpdateBehavior()
    if self.CurrentState == "arriving" then
        self.StateTimer = self.StateTimer + 1
        if self.StateTimer > 5 then
            self.CurrentState = "at_bar"
            self.StateTimer = 0
            self:SpendAtBar()
        end
    elseif self.CurrentState == "at_bar" then
        self.StateTimer = self.StateTimer + 1
        if self.StateTimer > self.Stats.bartime then
            self.CurrentState = "watching"
            self.StateTimer = 0
        end
    elseif self.CurrentState == "watching" then
        self.StateTimer = self.StateTimer + 1
        if self.StateTimer > self.Stats.watchtime then
            self.CurrentState = "leaving"
            self.StateTimer = 0
        else
            if self.StateTimer == 1 then
                self:WatchPerformance()
            end
        end
    elseif self.CurrentState == "leaving" then
        self:Remove()
    end
end

function ENT:SpendAtBar()
    local club = self:GetNWEntity("Club")
    if not IsValid(club) then return end
    local owner = club:Getowning_ent()
    if not IsValid(owner) then return end
    
    owner:addMoney(self.Stats.spend)
    club:SetNWInt("PerformerIncome", club:GetNWInt("PerformerIncome") + self.Stats.spend)
    
    if self:GetNWString("CustomerType") == "troublemaker" then
        -- Troublemakers might cause problems
        if math.random(100) > 70 then
            owner:ChatPrint("A troublemaker started a problem!")
        end
    end
end

function ENT:WatchPerformance()
    local club = self:GetNWEntity("Club")
    if not IsValid(club) then return end
    local owner = club:Getowning_ent()
    if not IsValid(owner) then return end
    
    owner:addMoney(self.Stats.tip)
    club:SetNWInt("PerformerIncome", club:GetNWInt("PerformerIncome") + self.Stats.tip)
end

function ENT:OnRemove()
    timer.Remove("CustomerBehavior_" .. self:EntIndex())
end

function ENT:SetupDataTables()
    self:NetworkVar("Entity", 0, "owning_ent")
end