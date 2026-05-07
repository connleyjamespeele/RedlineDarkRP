ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Booth"
ENT.Author = "AI"
ENT.Spawnable = false

function ENT:Initialize()
    self:SetModel("models/props_interiors/Furniture_Couch02a.mdl")
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
    local phys = self:GetPhysicsObject()
    if phys:IsValid() then
        phys:Wake()
    end
end

function ENT:Use(activator, caller)
    if not activator:IsPlayer() then return end
    -- Start lap dance
    activator:SetPos(self:GetPos() + Vector(0,0,10))
    activator:ResetSequence("dance") -- Placeholder animation
    timer.Create("LapDance_" .. activator:SteamID(), 30, 1, function()
        if IsValid(activator) then
            activator:addMoney(100) -- Payment
            activator:ChatPrint("Lap dance complete! Earned $100")
        end
    end)
end

function ENT:SetupDataTables()
    self:NetworkVar("Entity", 0, "owning_ent")
end