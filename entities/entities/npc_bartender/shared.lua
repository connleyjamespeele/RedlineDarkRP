ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "NPC Bartender"
ENT.Author = "AI"
ENT.Spawnable = false

function ENT:Initialize()
    self:SetModel("models/player/group03/male_04.mdl")
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
    local phys = self:GetPhysicsObject()
    if phys:IsValid() then
        phys:Wake()
    end
    timer.Create("BartenderServe_" .. self:EntIndex(), 10, 0, function()
        if not IsValid(self) then return end
        for _, ply in ipairs(ents.FindInSphere(self:GetPos(), 150)) do
            if ply:IsPlayer() and ply:canAfford(80) then
                ply:addMoney(-80)
                local owner = self:Getowning_ent()
                if IsValid(owner) then
                    owner:addMoney(80)
                end
                ply:ChatPrint("Bought a drink! $80")
            end
        end
    end)
end

function ENT:OnRemove()
    timer.Remove("BartenderServe_" .. self:EntIndex())
end

function ENT:SetupDataTables()
    self:NetworkVar("Entity", 0, "owning_ent")
end