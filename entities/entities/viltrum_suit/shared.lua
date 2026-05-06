ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Viltrum Suit"
ENT.Author = "AI"
ENT.Spawnable = false

function ENT:SetupDataTables()
    self:NetworkVar("Entity", 1, "owning_ent")
    self:NetworkVar("String", 0, "SuitType")
end