ENT.Type = "anim"
ENT.Base = "base_gmodentity"

ENT.PrintName = "Cooling Barrel"
ENT.Author = "AI"
ENT.Category = "Nuclear"
ENT.Spawnable = true

if SERVER then
    function ENT:Initialize()
        self:SetModel("models/props_c17/oildrum001.mdl")
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
            local reactors = ents.FindInSphere(self:GetPos(), 100)
            for _, reactor in ipairs(reactors) do
                if reactor:GetClass() == "nuclear_reactor" then
                    reactor:AddCoolingBarrel()
                    self:Remove()
                    break
                end
            end
        end
    end
else
    function ENT:Draw()
        self:DrawModel()
    end
end