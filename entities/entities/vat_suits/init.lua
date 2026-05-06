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

    self.growing = false
    self.moneyInvested = 0
end

function ENT:Use(activator, caller)
    if not self.growing then
        -- Open menu to select suit and invest money
        net.Start("OpenVatMenu")
        net.Send(caller)
    end
end

function ENT:StartGrowing(suitType, money)
    self.growing = true
    self:SetSuitType(suitType)
    self.moneyInvested = money
    self:SetGrowTime(CurTime() + 300) -- 5 minutes
end

function ENT:Think()
    if self.growing and CurTime() > self:GetGrowTime() then
        self:FinishGrowing()
    end
end

function ENT:FinishGrowing()
    self.growing = false
    -- Spawn suit
    local suit = ents.Create("viltrum_suit")
    suit:SetSuitType(self:GetSuitType())
    suit:SetPos(self:GetPos() + Vector(0,0,50))
    suit:Spawn()
end

function ENT:OnRemove()
    if self.growing then
        -- Drop money
        local money = ents.Create("spawned_money")
        money:SetPos(self:GetPos())
        money:Setamount(self.moneyInvested)
        money:Spawn()
    end
end