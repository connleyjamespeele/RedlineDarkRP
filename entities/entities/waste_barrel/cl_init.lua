include("shared.lua")

net.Receive("WasteBarrelMenu", function()
    local ent = net.ReadEntity()
    local frame = vgui.Create("DFrame")
    frame:SetSize(300, 150)
    frame:SetTitle("Waste Disposal")
    frame:Center()
    frame:MakePopup()
    frame.Paint = function(self, w, h)
        draw.RoundedBox(0, 0, 0, w, h, Color(30, 30, 30, 250))
        draw.RoundedBox(0, 0, 0, w, 30, Color(150, 0, 0, 255))
    end

    local legalBtn = vgui.Create("DButton", frame)
    legalBtn:SetText("Legal Disposal ($500)")
    legalBtn:SetPos(50, 50)
    legalBtn:SetSize(200, 30)
    legalBtn.DoClick = function()
        net.Start("DisposeWaste")
        net.WriteEntity(ent)
        net.WriteBool(true)
        net.SendToServer()
        frame:Close()
    end
    legalBtn.Paint = function(self, w, h)
        draw.RoundedBox(0, 0, 0, w, h, Color(100, 0, 0, 200))
    end

    local illegalBtn = vgui.Create("DButton", frame)
    illegalBtn:SetText("Illegal Disposal")
    illegalBtn:SetPos(50, 90)
    illegalBtn:SetSize(200, 30)
    illegalBtn.DoClick = function()
        net.Start("DisposeWaste")
        net.WriteEntity(ent)
        net.WriteBool(false)
        net.SendToServer()
        frame:Close()
    end
    illegalBtn.Paint = function(self, w, h)
        draw.RoundedBox(0, 0, 0, w, h, Color(100, 0, 0, 200))
    end
end)