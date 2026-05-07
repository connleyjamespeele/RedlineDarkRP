ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Solar Panel"
ENT.Author = "AI"
ENT.Spawnable = false

function ENT:Initialize()
    self:SetModel("models/props_lab/solar_panel.mdl")
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
    local phys = self:GetPhysicsObject()
    if phys:IsValid() then
        phys:Wake()
    end
    self:SetNWInt("Output", 0)
    self:SetNWBool("Active", false)
    self:RotateToSun()
end

function ENT:RotateToSun()
    -- Simple day/night cycle check
    local isDay = true -- Placeholder, check real time
    self:SetNWBool("Active", isDay)
end

function ENT:Think()
    self:RotateToSun()
    
    if self:GetNWBool("Active") then
        -- Generate power (simple version)
        self:SetNWInt("Output", 50)
    else
        self:SetNWInt("Output", 0)
    end
    
    return true
end

function ENT:SetupDataTables()
    self:NetworkVar("Entity", 0, "owning_ent")
end