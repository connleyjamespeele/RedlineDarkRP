include("shared.lua")

function ENT:Draw()
    self:DrawModel()

    if self:GetChatMessage() != "" then
        local pos = self:GetPos() + Vector(0, 0, 80)
        local ang = self:GetAngles()
        ang:RotateAroundAxis(ang:Up(), 90)
        ang:RotateAroundAxis(ang:Forward(), 90)

        cam.Start3D2D(pos, ang, 0.1)
            draw.SimpleText(self:GetChatMessage(), "DermaDefault", 0, 0, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        cam.End3D2D()
    end
end