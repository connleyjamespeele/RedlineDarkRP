ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Stage"
ENT.Author = "AI"
ENT.Spawnable = true
ENT.AdminOnly = false

function ENT:Initialize()
    self:SetModel("models/props_c17/FurnitureTable001a.mdl") -- Placeholder model
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
    local phys = self:GetPhysicsObject()
    if phys:IsValid() then
        phys:Wake()
    end
end

function ENT:Use(activator, caller)
    if not activator:IsPlayer() then return end
    if activator:GetNWBool("OnStage", false) then
        -- Dismount
        activator:SetPos(self:GetPos() + Vector(0,0,50))
        activator:SetNWBool("OnStage", false)
        activator:ResetSequence("idle")
    else
        -- Mount
        activator:SetPos(self:GetPos() + Vector(0,0,20))
        activator:SetNWBool("OnStage", true)
        activator:ResetSequence("muscle") -- Play muscle animation
        -- Start tipping timer or something
        timer.Create("StageTips_" .. activator:SteamID(), 10, 0, function()
            if not IsValid(activator) or not activator:GetNWBool("OnStage") then return end
            activator:addMoney(50) -- Tip
            activator:ChatPrint("You got a tip!")
        end)
    end
end

function ENT:OnRemove()
    for _, ply in ipairs(player.GetAll()) do
        if ply:GetNWBool("OnStage") then
            ply:SetNWBool("OnStage", false)
            timer.Remove("StageTips_" .. ply:SteamID())
        end
    end
end