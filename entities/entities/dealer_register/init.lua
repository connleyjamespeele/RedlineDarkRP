AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:Initialize()
    self:SetModel("models/props_c17/cashregister01a.mdl")
    DarkRP.ValidatedPhysicsInit(self, SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)

    local phys = self:GetPhysicsObject()

    if phys:IsValid() then
        phys:Wake()
    end

    self:SetStoredMoney(0)
    self.npcUpgrade = 1
end

function ENT:Use(activator, caller)
    -- Open register menu to manage store and collect money
    net.Start("OpenDealerRegisterMenu")
    net.WriteInt(self:GetStoredMoney(), 32)
    net.Send(caller)
end

function ENT:CollectMoney(caller)
    caller:addMoney(self:GetStoredMoney())
    self:SetStoredMoney(0)
end

function ENT:UpgradeNPCs()
    self.npcUpgrade = self.npcUpgrade + 1
    -- Increase NPC customer rate
end