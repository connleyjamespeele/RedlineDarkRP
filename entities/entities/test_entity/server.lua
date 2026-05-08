include("shared.lua")

function ENT:Initialize()
    self:SetModel("models/props_c17/consolebox01a.mdl")
    DarkRP.ValidatedPhysicsInit(self, SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)

    self:SetMoney(0)
    self:SetDelayBeforeIncome(30) 
    self:SetMoneyGiveAmount(0) -- Set the default money give amount to 0
end

function ENT:Use(activator, caller)
    print("Entity used by: " .. tostring(activator))
    print("MoneyGiveAmount: " .. tostring(self:GetMoneyGiveAmount()))
    print("caller: " .. tostring(caller))

    if CLIENT then return end
    if not IsValid(activator) or not activator:IsPlayer() then return end

    local moneyAmount = self:GetMoney()
    if moneyAmount > 0 then
        self:SetMoney(0)
        activator:addMoney(moneyAmount)
        DarkRP.notify(activator, 0, 4, "You received $" .. moneyAmount .. " from the money box!")
    else
        DarkRP.notify(activator, 1, 4, "This money box is empty.")
    end
end

function ENT:Think()
    timer.Create("MoneyBoxIncome_" .. self:EntIndex(), self:GetDelayBeforeIncome(), 0, function()
        if not IsValid(self) then return end
        local CheckAround = ents.FindInSphere(self:GetPos(), 45)
        local Income = self:GetMoneyGiveAmount() -- Start with the base money give amount
        for _, ent in ipairs(CheckAround) do
            if ent then
                print("Found entity: " .. tostring(ent))
                if ent:GetClass() == "test_entity2" then
                    Income = Income + 500
                end
            end
        end

        self:SetMoney(self:GetMoney() + Income) -- Add the calculated income to the current money amount
    end)
end 