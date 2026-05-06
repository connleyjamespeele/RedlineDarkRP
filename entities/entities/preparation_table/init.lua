AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:Initialize()
    self:SetModel("models/props_interiors/Furniture_Desk01a.mdl")
    DarkRP.ValidatedPhysicsInit(self, SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)

    local phys = self:GetPhysicsObject()

    if phys:IsValid() then
        phys:Wake()
    end
end

function ENT:Use(activator, caller)
    local canUse, reason = hook.Call("canDarkRPUse", nil, activator, self, caller)
    if canUse == false then
        if reason then DarkRP.notify(activator, 1, 4, reason) end
        return
    end

    -- Place cooked food on plate and serve to customer
    -- Find nearest customer NPC and give plate
    local customers = ents.FindInSphere(self:GetPos(), 500)
    for _, ent in ipairs(customers) do
        if ent:GetClass() == "npc_customer" and ent.order then
            -- Give plate to customer
            ent:ReceivePlate()
            break
        end
    end
end