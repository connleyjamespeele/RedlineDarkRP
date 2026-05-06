AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:Initialize()
    self:SetModel("models/player/engineer.mdl")
    self:SetHullType(HULL_HUMAN)
    self:SetHullSizeNormal()
    self:SetNPCState(NPC_STATE_SCRIPT)
    self:SetSolid(SOLID_BBOX)
    self:CapabilitiesAdd(CAP_ANIMATEDFACE)
    self:SetUseType(SIMPLE_USE)
    self:DropToFloor()

    self.level = 1
    self.mining = false
end

function ENT:Use(activator, caller)
    -- Upgrade level
    if caller == self:Getowning_ent() then
        self.level = self.level + 1
    end
end

function ENT:Think()
    -- Auto mine nearby nodes
    if not self.mining then
        local nodes = ents.FindInSphere(self:GetPos(), 200)
        for _, node in ipairs(nodes) do
            if node:GetClass() == "mining_node" and node.health > 0 then
                self:MineNode(node)
                break
            end
        end
    end
end

function ENT:MineNode(node)
    self.mining = true
    timer.Simple(5 / self.level, function() -- Faster with higher level
        if IsValid(node) then
            node:Mine(self:Getowning_ent())
        end
        self.mining = false
    end)
end