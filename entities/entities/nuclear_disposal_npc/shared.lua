ENT.Type = "ai"
ENT.Base = "base_ai"

ENT.PrintName = "Nuclear Waste Disposal NPC"
ENT.Author = "AI"
ENT.Category = "Nuclear"
ENT.Spawnable = true

if SERVER then
    function ENT:Initialize()
        self:SetModel("models/player/breen.mdl")
        self:SetHullType(HULL_HUMAN)
        self:SetHullSizeNormal()
        self:SetNPCState(NPC_STATE_SCRIPT)
        self:SetSolid(SOLID_BBOX)
        self:CapabilitiesAdd(CAP_ANIMATEDFACE)
        self:SetUseType(SIMPLE_USE)
        self:DropToFloor()
    end

    function ENT:Use(activator, caller)
        if activator:IsPlayer() then
            net.Start("DisposalNPCMenu")
            net.WriteEntity(self)
            net.Send(activator)
        end
    end
else
    function ENT:Draw()
        self:DrawModel()
    end
end