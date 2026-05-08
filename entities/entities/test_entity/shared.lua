ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Test Entity"
ENT.Author = "Carlos"
ENT.Category = "DarkRP"
ENT.Spawnable = true
ENT.AdminOnly = false

function ENT:SetupDataTables()
    self:NetworkVar("Int", 0, "MoneyGiveAmount")
    self:NetworkVar("Int", 1, "Money")
    self:NetworkVar("Int", 2, "DelayBeforeIncome")
    self:NetworkVar("Int", 3, "Income")
end

if CLIENT then
    function ENT:Draw()
        self:DrawModel()
        local Pos = self:GetPos()
        local Ang = self:GetAngles()
        Ang:RotateAroundAxis(Ang:Up(), 90)
        Ang:RotateAroundAxis(Ang:Forward(), 90)

        cam.Start3D2D(Pos + Ang:Up() * 10, Ang, 0.1)
            draw.SimpleText("Money: $" .. self:GetMoney(), "DermaLarge", 0, 0, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
            draw.SimpleText("Income Delay: " .. self:GetDelayBeforeIncome() .. "s", "DermaLarge", 0, 50, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
            draw.SimpleText("Money Give Amount: $" .. self:GetMoneyGiveAmount(), "DermaLarge", 0, 100, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        cam.End3D2D()
    end
end