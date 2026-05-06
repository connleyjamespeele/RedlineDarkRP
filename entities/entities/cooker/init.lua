AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:Initialize()
    self:SetModel("models/props_c17/furnitureStove001a.mdl")
    DarkRP.ValidatedPhysicsInit(self, SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)

    local phys = self:GetPhysicsObject()

    if phys:IsValid() then
        phys:Wake()
    end

    self.cooking = false
    self.cookTime = 0
end

function ENT:Use(activator, caller)
    local canUse, reason = hook.Call("canDarkRPUse", nil, activator, self, caller)
    if canUse == false then
        if reason then DarkRP.notify(activator, 1, 4, reason) end
        return
    end

    -- Open cooker menu or start cooking if ingredients are placed
    if not self.cooking then
        -- Assume ingredients are placed somehow, start cooking
        self:StartCooking()
    end
end

function ENT:StartCooking()
    self.cooking = true
    self.cookTime = CurTime() + 30 -- 30 seconds to cook
    self:EmitSound("ambient/fire/fire_small_loop1.wav")
end

function ENT:Think()
    if self.cooking and CurTime() > self.cookTime then
        self:FinishCooking()
    end
end

function ENT:FinishCooking()
    self.cooking = false
    self:StopSound("ambient/fire/fire_small_loop1.wav")
    -- Spawn cooked food or something
    local cooked = ents.Create("cooked_food") -- Assume we have a cooked_food entity
    cooked:SetPos(self:GetPos() + Vector(0,0,50))
    cooked:Spawn()
end