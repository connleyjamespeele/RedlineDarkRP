ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "NPC Bouncer"
ENT.Author = "AI"
ENT.Spawnable = false

function ENT:Initialize()
    self:SetModel("models/player/combine_soldier.mdl")
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
    local phys = self:GetPhysicsObject()
    if phys:IsValid() then
        phys:Wake()
    end
    timer.Create("BouncerCheck_" .. self:EntIndex(), 10, 0, function()
        if not IsValid(self) then return end
        for _, ply in ipairs(ents.FindInSphere(self:GetPos(), 500)) do
            if ply:IsPlayer() and ply:isArrested() then
                ply:SetPos(ply:GetPos() + Vector(0,0,100)) -- Throw out
                ply:ChatPrint("Bouncer threw you out!")
            end
        end
    end)
end

function ENT:OnRemove()
    timer.Remove("BouncerCheck_" .. self:EntIndex())
end

function ENT:SetupDataTables()
    self:NetworkVar("Entity", 0, "owning_ent")
end