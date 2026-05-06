include("shared.lua")

net.Receive("DisposalNPCMenu", function()
    local ent = net.ReadEntity()
    local frame = vgui.Create("DFrame")
    frame:SetSize(300, 100)
    frame:SetTitle("Waste Disposal")
    frame:Center()
    frame:MakePopup()
    frame.Paint = function(self, w, h)
        draw.RoundedBox(0, 0, 0, w, h, Color(30, 30, 30, 250))
        draw.RoundedBox(0, 0, 0, w, 30, Color(150, 0, 0, 255))
    end

    local disposeBtn = vgui.Create("DButton", frame)
    disposeBtn:SetText("Dispose Waste ($500)")
    disposeBtn:SetPos(50, 40)
    disposeBtn:SetSize(200, 30)
    disposeBtn.DoClick = function()
        net.Start("DisposeWasteNPC")
        net.WriteEntity(ent)
        net.SendToServer()
        frame:Close()
    end
    disposeBtn.Paint = function(self, w, h)
        draw.RoundedBox(0, 0, 0, w, h, Color(100, 0, 0, 200))
    end
end)