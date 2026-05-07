ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Bank Register"
ENT.Author = "AI"
ENT.Spawnable = false

function ENT:Initialize()
    self:SetModel("models/props_c17/cashregister01a.mdl")
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
    local phys = self:GetPhysicsObject()
    if phys:IsValid() then
        phys:Wake()
    end
    -- Spawn NPCs periodically
    timer.Create("BankNPC_" .. self:EntIndex(), 60, 0, function()
        if not IsValid(self) then return end
        local npc = ents.Create("npc_citizen")
        npc:SetPos(self:GetPos() + Vector(math.random(-50,50), math.random(-50,50), 0))
        npc:Spawn()
        npc:SetSchedule(SCHED_IDLE_WANDER)
        -- Add AI for transactions
    end)
end

function ENT:OnRemove()
    timer.Remove("BankNPC_" .. self:EntIndex())
end

function ENT:SetupDataTables()
    self:NetworkVar("Entity", 0, "owning_ent")
end