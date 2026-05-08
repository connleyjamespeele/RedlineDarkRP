ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Test Entity"
ENT.Author = "Carlos"

ENT.Spawnable = true

function ENT:SetupDataTables()
    self:NetworkVar("Int", 0, "MoneyGiveAmount")
    self:NetworkVar("Int", 1, "Money")
    self:NetworkVar("Int", 2, "DelayBeforeIncome")
end