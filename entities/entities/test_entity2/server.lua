include("shared.lua")

function ENT:Initialize()
    self:SetModel("models/props_c17/consolebox01a.mdl")
    DarkRP.ValidatedPhysicsInit(self, SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
end

--[[function ENT:Think()
    timer.Create("MoneyBoxIncome_" .. self:EntIndex(), self:GetDelayBeforeIncome(), 0, function()
        if not IsValid(self) then return end
        local CheckAround = ents.FindInSphere(self:GetPos(), 45)
        local Income = 1000
        for _, ent in ipairs(CheckAround) do
            if ent then
                print("Found entity: " .. tostring(ent))
                if ent:GetClass() == "test_entity2" then
                    Income = Income + 500
                end
            end
        end

        self:SetMoney(self:GetMoney() + Income) 
    end)
end]]