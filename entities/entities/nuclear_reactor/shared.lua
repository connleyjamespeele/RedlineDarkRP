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

        local phys = self:GetPhysicsObject()
        if phys:IsValid() then
            phys:Wake()
        end

        timer.Create("ReactorUpdate_" .. self:EntIndex(), 10, 0, function()
            if not IsValid(self) then return end
            self:SetHeat(self:GetHeat() + 5)
            self:SetWaste(self:GetWaste() + 2)
            self:SetMoneyStored(self:GetMoneyStored() + 10)

            if self:GetHeat() >= 100 then
                self:Explode()
            end
        end)
    end

    function ENT:Explode()
        local explosion = ents.Create("env_explosion")
        explosion:SetPos(self:GetPos())
        explosion:SetOwner(self:GetOwner())
        explosion:Spawn()
        explosion:SetKeyValue("iMagnitude", "100")
        explosion:Fire("Explode", 0, 0)

        self:Remove()
    end

    function ENT:AddCoolingBarrel()
        if self:GetCoolingBarrels() < 4 then
            self:SetCoolingBarrels(self:GetCoolingBarrels() + 1)
            timer.Create("Cooling_" .. self:EntIndex() .. "_" .. self:GetCoolingBarrels(), 30, 1, function()
                if IsValid(self) then
                    self:SetHeat(math.max(0, self:GetHeat() - 20))
                    self:SetCoolingBarrels(self:GetCoolingBarrels() - 1)
                end
            end)
        end
    end

    function ENT:OnRemove()
        timer.Remove("ReactorUpdate_" .. self:EntIndex())
        for i = 1, 4 do
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
            draw.RoundedBox(0, -100, -50, 200, 100, Color(50, 50, 50, 200))
            draw.SimpleText("Heat: " .. self:GetHeat() .. "/100", "DermaDefault", 0, -20, Color(255, 0, 0), TEXT_ALIGN_CENTER)
            draw.SimpleText("Waste: " .. self:GetWaste(), "DermaDefault", 0, 0, Color(255, 255, 0), TEXT_ALIGN_CENTER)
            draw.SimpleText("Money: $" .. self:GetMoneyStored(), "DermaDefault", 0, 20, Color(0, 255, 0), TEXT_ALIGN_CENTER)
        cam.End3D2D()
    end
end