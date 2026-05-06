ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Vat Suits"
ENT.Author = "AI"
ENT.Spawnable = false

function ENT:SetupDataTables()
    self:NetworkVar("Entity", 1, "owning_ent")
    self:NetworkVar("String", 0, "SuitType")
    self:NetworkVar("Int", 1, "GrowTime")
end