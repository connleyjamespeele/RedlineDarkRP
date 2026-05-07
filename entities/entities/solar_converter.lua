ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Solar Converter"
ENT.Author = "AI"
ENT.Spawnable = false

function ENT:Initialize()
    self:SetModel("models/props_lab/electric_box01.mdl")
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
    local phys = self:GetPhysicsObject()
    if phys:IsValid() then
        phys:Wake()
    end
    self:SetNWInt("InputPower", 0)
    self:SetNWInt("OutputPower", 0)
    self:SetNWBool("HasPanel", false)
    self:SetNWBool("HasRecharger", false)
end

function ENT:ConnectPanel(panel)
    if not IsValid(panel) or panel:GetClass() ~= "solar_panel" then
        self:Explode()
        return
    end
    self:SetNWBool("HasPanel", true)
    self:SetNWEntity("Panel", panel)
end

function ENT:ConnectRecharger(recharger)
    if not IsValid(recharger) or recharger:GetClass() ~= "solar_recharger" then
        self:Explode()
        return
    end
    self:SetNWBool("HasRecharger", true)
    self:SetNWEntity("Recharger", recharger)
end

function ENT:Explode()
    local explosion = ents.Create("env_explosion")
    explosion:SetPos(self:GetPos())
    explosion:SetKeyValue("iMagnitude", "200")
    explosion:Spawn()
    self:Remove()
end

function ENT:Think()
    if self:GetNWBool("HasPanel") and self:GetNWBool("HasRecharger") then
        local panel = self:GetNWEntity("Panel")
        local recharger = self:GetNWEntity("Recharger")
        if IsValid(panel) and IsValid(recharger) then
            local power = panel:GetNWInt("Output")
            self:SetNWInt("InputPower", power)
            self:SetNWInt("OutputPower", power)
        end
    end
    return true
end

function ENT:SetupDataTables()
    self:NetworkVar("Entity", 0, "owning_ent")
end