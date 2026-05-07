ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Eco-Friend NPC"
ENT.Author = "AI"
ENT.Spawnable = false

function ENT:Initialize()
    self:SetModel("models/player/Group01/Female_04.mdl")
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
    net.Start("OpenEcoFriendMenu")
    net.WriteEntity(self)
    net.Send(activator)
end

if SERVER then
    util.AddNetworkString("OpenEcoFriendMenu")
    util.AddNetworkString("SellBattery")
    
    net.Receive("SellBattery", function(len, ply)
        local npc = net.ReadEntity()
        if not IsValid(npc) or npc:GetClass() ~= "eco_friend_npc" then return end
        
        -- Price based on charge level (placeholder)
        local price = 500 -- Base price
        ply:addMoney(price)
        ply:ChatPrint("Sold battery for $" .. price .. "!")
    end)
end

function ENT:SetupDataTables()
    self:NetworkVar("Entity", 0, "owning_ent")
end