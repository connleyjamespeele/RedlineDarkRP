ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Black Market Lab"
ENT.Author = "AI"
ENT.Spawnable = false

function ENT:SetupDataTables()
    self:NetworkVar("Entity", 1, "owning_ent")
    self:NetworkVar("Int", 0, "Supplies")
end