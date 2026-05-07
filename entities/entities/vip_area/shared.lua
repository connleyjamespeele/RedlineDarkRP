ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "VIP Area"
ENT.Author = "AI"
ENT.Spawnable = false

function ENT:Initialize()
    self:SetModel("models/props_c17/FurnitureTable001a.mdl")
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
    local phys = self:GetPhysicsObject()
    if phys:IsValid() then
        phys:Wake()
    end
    self:SetRating(0)
    timer.Create("VIPSpawn_" .. self:EntIndex(), 120, 0, function()
        if not IsValid(self) then return end
        -- Spawn high roller NPC
        local npc = ents.Create("npc_citizen")
        npc:SetPos(self:GetPos() + Vector(math.random(-50,50), math.random(-50,50), 0))
        npc:Spawn()
        npc:SetNWBool("HighRoller", true)
        timer.Simple(60, function() if IsValid(npc) then npc:Remove() end end)
    end)
end

function ENT:OnRemove()
    timer.Remove("VIPSpawn_" .. self:EntIndex())
end

function ENT:SetupDataTables()
    self:NetworkVar("Entity", 0, "owning_ent")
    self:NetworkVar("Int", 0, "Rating")
end