ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Battery"
ENT.Author = "AI"
ENT.Spawnable = false

function ENT:Initialize()
    self:SetModel("models/props_c17/oildrum001.mdl")
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
    local phys = self:GetPhysicsObject()
    if phys:IsValid() then
        phys:Wake()
    end
    
    -- Upgrade 0 = 75, Upgrade 1 = 125, Upgrade 2 = 190
    self:SetNWInt("Upgrade", 0)
    self:SetNWInt("Capacity", 75)
    self:SetNWInt("Current", 0)
    self:SetNWBool("Charged", false)
end

function ENT:Charge(amount)
    local current = self:GetNWInt("Current")
    local cap = self:GetNWInt("Capacity")
    self:SetNWInt("Current", math.min(current + amount, cap))
    if self:GetNWInt("Current") >= cap then
        self:SetNWBool("Charged", true)
    end
end

function ENT:Discharge(amount)
    local current = self:GetNWInt("Current")
    self:SetNWInt("Current", math.max(current - amount, 0))
end

function ENT:Upgrade()
    local upgrade = self:GetNWInt("Upgrade")
    if upgrade == 0 then
        self:SetNWInt("Upgrade", 1)
        self:SetNWInt("Capacity", 125)
    elseif upgrade == 1 then
        self:SetNWInt("Upgrade", 2)
        self:SetNWInt("Capacity", 190)
    end
end

function ENT:SetupDataTables()
    self:NetworkVar("Entity", 0, "owning_ent")
end