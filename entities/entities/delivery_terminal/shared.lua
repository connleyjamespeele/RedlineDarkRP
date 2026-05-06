ENT.Type = "anim"
ENT.Base = "base_gmodentity"

ENT.PrintName = "Delivery Terminal"
ENT.Author = "Your Name"
ENT.Category = "DarkRP"
ENT.Spawnable = true

function ENT:SetupDataTables()
end

if SERVER then
    function ENT:Initialize()
        self:SetModel("models/props_lab/monitor01a.mdl")
        self:PhysicsInit(SOLID_VPHYSICS)
        self:SetMoveType(MOVETYPE_VPHYSICS)
        self:SetSolid(SOLID_VPHYSICS)
        self:SetUseType(SIMPLE_USE)

        local phys = self:GetPhysicsObject()
        if phys:IsValid() then
            phys:Wake()
        end
    end

    function ENT:Use(activator, caller)
        if activator:IsPlayer() then
            net.Start("DeliveryTerminalMenu")
            net.Send(activator)
        end
    end
else
    function ENT:Draw()
        self:DrawModel()
    end
end