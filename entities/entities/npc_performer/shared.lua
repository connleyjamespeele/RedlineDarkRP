ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "NPC Performer"
ENT.Author = "AI"
ENT.Spawnable = false

function ENT:Initialize()
    self:SetModel("models/player/alyx.mdl")
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
    local phys = self:GetPhysicsObject()
    if phys:IsValid() then
        phys:Wake()
    end
    self:ResetSequence("dance")
    timer.Create("PerformerTip_" .. self:EntIndex(), 15, 0, function()
        if not IsValid(self) then return end
        local owner = self:Getowning_ent()
        if IsValid(owner) then
            local tip = 250
            owner:addMoney(tip)
            -- Find club manager and add to income
            for _, ent in ipairs(ents.FindByClass("manager_computer")) do
                if ent:Getowning_ent() == owner then
                    ent:SetNWInt("PerformerIncome", ent:GetNWInt("PerformerIncome") + tip)
                    break
                end
            end
        end
    end)
end

function ENT:OnRemove()
    timer.Remove("PerformerTip_" .. self:EntIndex())
end

function ENT:SetupDataTables()
    self:NetworkVar("Entity", 0, "owning_ent")
end