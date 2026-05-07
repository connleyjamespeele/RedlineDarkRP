ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Solar Recharger"
ENT.Author = "AI"
ENT.Spawnable = false

function ENT:Initialize()
    self:SetModel("models/props_lab/electric_charger.mdl")
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
    local phys = self:GetPhysicsObject()
    if phys:IsValid() then
        phys:Wake()
    end
    self:SetNWInt("BatteriesStored", 0)
    self:SetNWInt("MaxBatteries", 5)
    self.Batteries = {}
end

function ENT:AddBattery(battery)
    if not IsValid(battery) or battery:GetClass() ~= "battery" then return false end
    if self:GetNWInt("BatteriesStored") >= self:GetNWInt("MaxBatteries") then return false end
    
    table.insert(self.Batteries, battery)
    self:SetNWInt("BatteriesStored", #self.Batteries)
    battery:SetParent(self)
    return true
end

function ENT:RemoveBattery()
    if #self.Batteries == 0 then return nil end
    local battery = table.remove(self.Batteries)
    self:SetNWInt("BatteriesStored", #self.Batteries)
    battery:SetParent()
    return battery
end

function ENT:Use(activator, caller)
    if not activator:IsPlayer() then return end
    net.Start("OpenRechargerMenu")
    net.WriteEntity(self)
    net.Send(activator)
end

if SERVER then
    util.AddNetworkString("OpenRechargerMenu")
    
    function ENT:Think()
        if #self.Batteries > 0 then
            for _, battery in ipairs(self.Batteries) do
                if IsValid(battery) then
                    battery:Charge(5) -- Charge rate
                end
            end
        end
        return true
    end
end

function ENT:SetupDataTables()
    self:NetworkVar("Entity", 0, "owning_ent")
end