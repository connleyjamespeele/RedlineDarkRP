ENT.Type = "anim"
ENT.Base = "base_gmodentity"

ENT.PrintName = "Waste Barrel"
ENT.Author = "AI"
ENT.Category = "Nuclear"
ENT.Spawnable = true

function ENT:SetupDataTables()
    self:NetworkVar("Int", 0, "WasteAmount")
end

if SERVER then
    function ENT:Initialize()
        self:SetModel("models/props_c17/oildrum001_explosive.mdl")
        self:PhysicsInit(SOLID_VPHYSICS)
        self:SetMoveType(MOVETYPE_VPHYSICS)
        self:SetSolid(SOLID_VPHYSICS)
        self:SetUseType(SIMPLE_USE)

        self:SetWasteAmount(10)

        local phys = self:GetPhysicsObject()
        if phys:IsValid() then
            phys:Wake()
        end
    end

    function ENT:Use(activator, caller)
        if activator:IsPlayer() then
            net.Start("WasteBarrelMenu")
            net.WriteEntity(self)
            net.Send(activator)
        end
    end
else
    function ENT:Draw()
        self:DrawModel()
    end
end