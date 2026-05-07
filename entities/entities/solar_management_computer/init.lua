include("shared.lua")

if SERVER then
    function ENT:Initialize()
        self:SetModel("models/props_lab/monitor01a.mdl")
        self:PhysicsInit(SOLID_VPHYSICS)
        self:SetMoveType(MOVETYPE_VPHYSICS)
        self:SetSolid(SOLID_VPHYSICS)
        local phys = self:GetPhysicsObject()
        if phys:IsValid() then
            phys:Wake()
        end
        self:SetNWInt("TotalOutput", 0)
        self:SetNWInt("TotalStored", 0)
        self:SetNWInt("PanelCount", 0)
        self:SetNWInt("BatteryCount", 0)
    end

    function ENT:Use(activator, caller)
        if activator ~= self:Getowning_ent() then return end
        net.Start("OpenSolarMenu")
        net.WriteEntity(self)
        net.Send(activator)
    end

    util.AddNetworkString("OpenSolarMenu")
    util.AddNetworkString("UpgradeBattery")
    
    net.Receive("UpgradeBattery", function(len, ply)
        local computer = net.ReadEntity()
        if not IsValid(computer) or computer:Getowning_ent() ~= ply then return end
        if ply:canAfford(50000) then
            ply:addMoney(-50000)
            ply:ChatPrint("Battery upgraded!")
        end
    end)

    function ENT:Think()
        -- Calculate total output from panels
        local panels = ents.FindByClass("solar_panel")
        local totalOutput = 0
        for _, panel in ipairs(panels) do
            if IsValid(panel) and panel:Getowning_ent() == self:Getowning_ent() then
                totalOutput = totalOutput + panel:GetNWInt("Output")
            end
        end
        self:SetNWInt("TotalOutput", totalOutput)
        
        -- Count entities
        local batCount = 0
        local panCount = 0
        for _, ent in ipairs(ents.FindByClass("battery")) do
            if IsValid(ent) and ent:Getowning_ent() == self:Getowning_ent() then
                batCount = batCount + 1
            end
        end
        for _, ent in ipairs(panels) do
            if IsValid(ent) and ent:Getowning_ent() == self:Getowning_ent() then
                panCount = panCount + 1
            end
        end
        self:SetNWInt("BatteryCount", batCount)
        self:SetNWInt("PanelCount", panCount)
        
        return true
    end

    function ENT:SetupDataTables()
        self:NetworkVar("Entity", 0, "owning_ent")
    end
end