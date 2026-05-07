ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Bank Computer"
ENT.Author = "AI"
ENT.Spawnable = false

function ENT:Use(activator, caller)
    if activator ~= self:Getowning_ent() then return end
    -- Open menu for stock market and upgrades
    net.Start("OpenBankMenu")
    net.Send(activator)
end

if SERVER then
    util.AddNetworkString("OpenBankMenu")
end

function ENT:SetupDataTables()
    self:NetworkVar("Entity", 0, "owning_ent")
end