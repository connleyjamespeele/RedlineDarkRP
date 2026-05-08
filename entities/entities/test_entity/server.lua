include("shared.lua")

function ENT:Initialize()
    self:SetModel("models/props_c17/consolebox01a.mdl")
    DarkRP.ValidatedPhysicsInit(self, SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)

    self:SetDelayBeforeIncome(30) 
    self:SetMoneyGiveAmount(100) -- Set the default money give amount to 100
end

function ENT:Use(activator, caller)
    print("Entity used by: " .. tostring(activator))
    print("MoneyGiveAmount: " .. tostring(self:GetMoneyGiveAmount()))
    print(caller)

    if CLIENT then return end
    if not IsValid(activator) or not activator:IsPlayer() then return end

    local moneyAmount = self:GetMoneyGiveAmount()
    if moneyAmount > 0 then
        self:SetMoneyGiveAmount(0)
        activator:addMoney(moneyAmount)
        DarkRP.notify(activator, 0, 4, "You received $" .. moneyAmount .. " from the money box!")
    else
        DarkRP.notify(activator, 1, 4, "This money box is empty.")
    end
end

function ENT:Think()
    timer.Create("MoneyBoxIncome_" .. self:EntIndex(), self:GetDelayBeforeIncome(), 0, function()
        if not IsValid(self) then return end
        self:SetMoneyGiveAmount(self:GetMoneyGiveAmount() + 100) 
    end)
end 