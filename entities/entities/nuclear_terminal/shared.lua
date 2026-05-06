ENT.Type = "anim"
ENT.Base = "base_gmodentity"

ENT.PrintName = "Nuclear Terminal"
ENT.Author = "AI"
ENT.Category = "Nuclear"
ENT.Spawnable = true

if SERVER then
    function ENT:Initialize()
        self:SetModel("models/props_lab/monitor01b.mdl")
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
        if activator:IsPlayer() and activator:Team() == TEAM_NUCLEAR_WORKER then
            net.Start("NuclearTerminalMenu")
            net.WriteEntity(self)
            net.Send(activator)
        end
    end
else
    function ENT:Draw()
        self:DrawModel()
    end
end