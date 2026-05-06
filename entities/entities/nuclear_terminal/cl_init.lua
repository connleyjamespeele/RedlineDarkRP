include("shared.lua")

net.Receive("NuclearTerminalMenu", function()
    local ent = net.ReadEntity()
    local frame = vgui.Create("DFrame")
    frame:SetSize(400, 300)
    frame:SetTitle("Nuclear Facility Terminal")
    frame:Center()
    frame:MakePopup()
    frame.Paint = function(self, w, h)
        draw.RoundedBox(0, 0, 0, w, h, Color(30, 30, 30, 250))
        draw.RoundedBox(0, 0, 0, w, 30, Color(150, 0, 0, 255))
    end

    local withdrawBtn = vgui.Create("DButton", frame)
    withdrawBtn:SetText("Withdraw Waste")
    withdrawBtn:SetPos(50, 50)
    withdrawBtn:SetSize(150, 30)
    withdrawBtn.DoClick = function()
        net.Start("WithdrawWaste")
        net.WriteEntity(ent)
        net.SendToServer()
        frame:Close()
    end
    withdrawBtn.Paint = function(self, w, h)
        draw.RoundedBox(0, 0, 0, w, h, Color(100, 0, 0, 200))
    end

    local upgradeBtn = vgui.Create("DButton", frame)
    upgradeBtn:SetText("Purchase Upgrade")
    upgradeBtn:SetPos(50, 100)
    upgradeBtn:SetSize(150, 30)
    upgradeBtn.DoClick = function()
        -- Placeholder for upgrades
        LocalPlayer():ChatPrint("Upgrades not implemented yet")
    end
    upgradeBtn.Paint = function(self, w, h)
        draw.RoundedBox(0, 0, 0, w, h, Color(100, 0, 0, 200))
    end
end)