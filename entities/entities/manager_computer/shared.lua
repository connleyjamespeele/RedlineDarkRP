ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Manager Computer"
ENT.Author = "AI"
ENT.Spawnable = false

function ENT:Initialize()
    self:SetModel("models/props_lab/monitor01a.mdl")
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
    local phys = self:GetPhysicsObject()
    if phys:IsValid() then
        phys:Wake()
    end
    self:SetNWInt("Performers", 1)
    self:SetNWInt("Bartenders", 1)
    self:SetNWInt("Advertisement", 0)
    self:SetNWInt("Tips", 0)
    self:SetNWBool("VIPArea", false)
    self:SetNWInt("VIPRating", 0)
    self:SetNWInt("Lighting", 0)
    self:SetNWInt("SecurityLevel", 0)
    -- Spawn customers
    timer.Create("CustomerSpawn_" .. self:EntIndex(), 60 - self:GetNWInt("Advertisement") * 10, 0, function()
        if not IsValid(self) then return end
        local types = {"regular", "tourist", "vip", "troublemaker", "party_group", "businessperson"}
        local type = types[math.random(#types)]
        local npc = ents.Create("npc_customer")
        npc:SetPos(self:GetPos() + Vector(math.random(-200,200), math.random(-200,200), 0))
        npc:Spawn()
        npc:SetNWString("CustomerType", type)
        npc:SetNWEntity("Club", self)
        self:SetNWInt("CustomerCount", self:GetNWInt("CustomerCount") + 1)
        timer.Simple(300 + math.random(120), function() if IsValid(npc) then npc:Remove() self:SetNWInt("CustomerCount", math.max(0, self:GetNWInt("CustomerCount") - 1)) end end)
    end)
end

function ENT:Use(activator, caller)
    if activator ~= self:Getowning_ent() then return end
    net.Start("OpenClubManagerMenu")
    net.WriteEntity(self)
    net.Send(activator)
end

if SERVER then
    util.AddNetworkString("OpenClubManagerMenu")
    util.AddNetworkString("ClubUpgrade")
    net.Receive("ClubUpgrade", function(len, ply)
        local ent = net.ReadEntity()
        local upgrade = net.ReadString()
        if not IsValid(ent) or ent:Getowning_ent() ~= ply then return end
        local cost = 0
        if upgrade == "performer" and ent:GetNWInt("Performers") < 5 then
            cost = 1000
            ent:SetNWInt("Performers", ent:GetNWInt("Performers") + 1)
        elseif upgrade == "bartender" and ent:GetNWInt("Bartenders") < 3 then
            cost = 800
            ent:SetNWInt("Bartenders", ent:GetNWInt("Bartenders") + 1)
        elseif upgrade == "advertisement" then
            cost = 500
            ent:SetNWInt("Advertisement", ent:GetNWInt("Advertisement") + 1)
        elseif upgrade == "tips" then
            cost = 600
            ent:SetNWInt("Tips", ent:GetNWInt("Tips") + 1)
        elseif upgrade == "vip" and not ent:GetNWBool("VIPArea") then
            cost = 2000
            ent:SetNWBool("VIPArea", true)
        elseif upgrade == "viprating" and ent:GetNWBool("VIPArea") then
            cost = 1500
            ent:SetNWInt("VIPRating", ent:GetNWInt("VIPRating") + 1)
        elseif upgrade == "lighting" then
            cost = 700
            ent:SetNWInt("Lighting", ent:GetNWInt("Lighting") + 1)
        elseif upgrade == "music" then
            cost = 900
            ent:SetNWInt("Music", ent:GetNWInt("Music") + 1)
        elseif upgrade == "security" then
            cost = 1200
            ent:SetNWInt("Security", ent:GetNWInt("Security") + 1)
        end
        if cost > 0 and ply:canAfford(cost) then
            ply:addMoney(-cost)
            ply:ChatPrint("Upgrade purchased!")
        end
    end)
end

function ENT:SetupDataTables()
    self:NetworkVar("Entity", 0, "owning_ent")
end