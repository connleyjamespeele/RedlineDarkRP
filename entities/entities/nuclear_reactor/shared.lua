ENT.Type = "anim"
ENT.Base = "base_gmodentity"

ENT.PrintName = "Nuclear Reactor"
ENT.Author = "AI"
ENT.Category = "Nuclear"
ENT.Spawnable = true

function ENT:SetupDataTables()
    self:NetworkVar("Int", 0, "Heat")
    self:NetworkVar("Int", 1, "Waste")
    self:NetworkVar("Int", 2, "CoolingBarrels")
    self:NetworkVar("Int", 3, "MoneyStored")
    self:NetworkVar("Int", 4, "MaxCoolingBarrels")
    self:NetworkVar("Int", 5, "HeatRate")
    self:NetworkVar("Int", 6, "WasteRate")
    self:NetworkVar("Int", 7, "BankedMoney")
    self:NetworkVar("Int", 8, "LaunderPercent")
    self:NetworkVar("Int", 9, "CleanEnergyLevel")
    self:NetworkVar("Bool", 0, "RemoteAlarm")
    self:NetworkVar("Bool", 1, "LeadLined")
    self:NetworkVar("Bool", 2, "HeatSinkInstalled")
    self:NetworkVar("Bool", 3, "MoneyLaundered")
end

local function GetEntityOwner(ent)
    if not IsValid(ent) then return nil end
    if ent.Getowning_ent then
        local owner = ent:Getowning_ent()
        if IsValid(owner) then return owner end
    end
    if ent.GetOwner then
        local owner = ent:GetOwner()
        if IsValid(owner) then return owner end
    end
    return nil
end

if SERVER then
    function ENT:Initialize()
        self:SetModel("models/props_c17/consolebox01a.mdl")
        self:PhysicsInit(SOLID_VPHYSICS)
        self:SetMoveType(MOVETYPE_VPHYSICS)
        self:SetSolid(SOLID_VPHYSICS)
        self:SetUseType(SIMPLE_USE)

        self:SetHeat(0)
        self:SetWaste(0)
        self:SetCoolingBarrels(0)
        self:SetMoneyStored(0)
        self:SetMaxCoolingBarrels(4)
        self:SetHeatRate(5)
        self:SetWasteRate(2)
        self:SetBankedMoney(0)
        self:SetLaunderPercent(0)
        self:SetCleanEnergyLevel(0)
        self:SetRemoteAlarm(false)
        self:SetLeadLined(false)
        self:SetHeatSinkInstalled(false)
        self:SetMoneyLaundered(false)

        local phys = self:GetPhysicsObject()
        if phys:IsValid() then
            phys:Wake()
        end

        timer.Create("ReactorUpdate_" .. self:EntIndex(), 10, 0, function()
            if not IsValid(self) then return end
            local heatGain = self:GetHeatRate()
            if self:GetHeatSinkInstalled() then
                heatGain = math.max(1, heatGain - 2)
            end

            local wasteGain = self:GetWasteRate()
            local energyBonus = 1 + (self:GetCleanEnergyLevel() * 0.1)
            local baseRevenue = 10
            local revenue = math.ceil(baseRevenue * energyBonus)
            local laundered = math.floor(baseRevenue * self:GetLaunderPercent() / 100)
            local storedRevenue = revenue - laundered

            self:SetHeat(self:GetHeat() + heatGain)
            self:SetWaste(self:GetWaste() + wasteGain)
            self:SetMoneyStored(self:GetMoneyStored() + storedRevenue)
            self:SetBankedMoney(self:GetBankedMoney() + laundered)

            if self:GetHeat() >= 100 then
                self:Explode()
            end

            if self:GetRemoteAlarm() then
                local owner = GetEntityOwner(self)
                if IsValid(owner) and owner:IsPlayer() then
                    if self:GetHeat() >= 75 then
                        net.Start("NuclearReactorAlert")
                        net.WriteString("Heat critical: " .. self:GetHeat() .. "%")
                        net.WriteInt(5, 8)
                        net.Send(owner)
                    end
                    if self:GetWaste() >= 40 then
                        net.Start("NuclearReactorAlert")
                        net.WriteString("Waste high: " .. self:GetWaste() .. " units")
                        net.WriteInt(5, 8)
                        net.Send(owner)
                    end
                end
            end
        end)
    end

    function ENT:Explode()
        local owner = GetEntityOwner(self)
        if IsValid(owner) and owner:IsPlayer() and self:GetBankedMoney() > 0 then
            owner:addMoney(self:GetBankedMoney())
            owner:ChatPrint("Your laundered funds were saved from the reactor explosion.")
            self:SetBankedMoney(0)
        end

        local explosion = ents.Create("env_explosion")
        explosion:SetPos(self:GetPos())
        explosion:SetOwner(owner or self)
        explosion:Spawn()
        explosion:SetKeyValue("iMagnitude", "100")
        explosion:Fire("Explode", 0, 0)

        self:Remove()
    end

    function ENT:AddCoolingBarrel()
        if self:GetCoolingBarrels() < self:GetMaxCoolingBarrels() then
            self:SetCoolingBarrels(self:GetCoolingBarrels() + 1)
            timer.Create("Cooling_" .. self:EntIndex() .. "_" .. self:GetCoolingBarrels(), 30, 1, function()
                if IsValid(self) then
                    self:SetHeat(math.max(0, self:GetHeat() - 20))
                    self:SetCoolingBarrels(self:GetCoolingBarrels() - 1)
                end
            end)
        end
    end

    function ENT:EmergencyFlush(ply)
        local cost = 2000
        if not IsValid(ply) or not ply:canAfford(cost) then return false end
        ply:addMoney(-cost)
        self:SetHeat(0)
        return true
    end

    function ENT:OnRemove()
        timer.Remove("ReactorUpdate_" .. self:EntIndex())
        for i = 1, 8 do
            timer.Remove("Cooling_" .. self:EntIndex() .. "_" .. i)
        end
    end
else
    function ENT:Draw()
        self:DrawModel()

        local pos = self:GetPos() + Vector(0, 0, 50)
        local ang = self:GetAngles()
        ang:RotateAroundAxis(ang:Up(), 90)
        ang:RotateAroundAxis(ang:Forward(), 90)

        cam.Start3D2D(pos, ang, 0.1)
            draw.RoundedBox(0, -100, -60, 200, 120, Color(30, 30, 30, 220))
            draw.SimpleText("Heat: " .. self:GetHeat() .. "/100", "DermaDefaultBold", 0, -35, Color(255, 80, 80), TEXT_ALIGN_CENTER)
            draw.SimpleText("Waste: " .. self:GetWaste(), "DermaDefaultBold", 0, -10, Color(255, 200, 0), TEXT_ALIGN_CENTER)
            draw.SimpleText("Cooling Barrels: " .. self:GetCoolingBarrels() .. "/" .. self:GetMaxCoolingBarrels(), "DermaDefaultBold", 0, 15, Color(200, 200, 200), TEXT_ALIGN_CENTER)
            draw.SimpleText("Banked: $" .. self:GetBankedMoney(), "DermaDefaultBold", 0, 40, Color(0, 255, 0), TEXT_ALIGN_CENTER)
        cam.End3D2D()
    end
end