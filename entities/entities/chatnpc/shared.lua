ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Chat NPC"
ENT.Author = "AI"
ENT.Spawnable = true

function ENT:SetupDataTables()
    self:NetworkVar("String", 0, "ChatMessage")
    self:NetworkVar("Int", 0, "ChatType") -- 0: greeting, 1: random, 2: quest, etc.
end