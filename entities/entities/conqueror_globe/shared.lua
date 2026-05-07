ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Conqueror Globe"
ENT.Author = "AI"
ENT.Spawnable = false

function ENT:SetupDataTables()
    self:NetworkVar("Entity", 0, "owning_ent")
end