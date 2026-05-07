if CLIENT then
    net.Receive("OpenSolarMenu", function()
        local computer = net.ReadEntity()
        local frame = vgui.Create("DFrame")
        frame:SetTitle("Solar Energy Management System")
        frame:SetSize(600, 500)
        frame:Center()
        frame:MakePopup()
        frame:SetDraggable(true)

        local scroll = vgui.Create("DScrollPanel", frame)
        scroll:Dock(FILL)
        scroll:DockMargin(10,10,10,10)

        -- System Status
        local statusLabel = vgui.Create("DLabel", scroll)
        statusLabel:SetText("Total Output: " .. computer:GetNWInt("TotalOutput") .. " W")
        statusLabel:SetFont("DermaLarge")
        statusLabel:SetColor(Color(255, 200, 0))
        scroll:AddItem(statusLabel)

        local panelLabel = vgui.Create("DLabel", scroll)
        panelLabel:SetText("Solar Panels: " .. computer:GetNWInt("PanelCount"))
        panelLabel:SetFont("DermaDefaultBold")
        scroll:AddItem(panelLabel)

        local batchLabel = vgui.Create("DLabel", scroll)
        batchLabel:SetText("Batteries: " .. computer:GetNWInt("BatteryCount"))
        batchLabel:SetFont("DermaDefaultBold")
        scroll:AddItem(batchLabel)

        -- Battery Upgrades
        local upgradeLabel = vgui.Create("DLabel", scroll)
        upgradeLabel:SetText("Battery Upgrades ($50K each):")
        upgradeLabel:SetFont("DermaDefaultBold")
        scroll:AddItem(upgradeLabel)

        local upgrades = {
            "Upgrade 1: +50W capacity (75 → 125 W)",
            "Upgrade 2: +65W capacity (125 → 190 W)",
            "Enhanced Charging: +20% charge speed",
            "Smart Balancing: Auto-distribute power",
            "Energy Storage Boost: +25% efficiency"
        }

        for _, upg in ipairs(upgrades) do
            local btn = vgui.Create("DButton", scroll)
            btn:SetText(upg)
            btn:SetTall(35)
            btn.DoClick = function()
                net.Start("UpgradeBattery")
                net.WriteEntity(computer)
                net.SendToServer()
            end
            scroll:AddItem(btn)
        end

        -- System Info
        local infoLabel = vgui.Create("DLabel", scroll)
        infoLabel:SetText("System Information:")
        infoLabel:SetFont("DermaDefaultBold")
        scroll:AddItem(infoLabel)

        local info = {
            "• Panels generate power during day (6 AM - 6 PM)",
            "• Converters must link panels to rechargers",
            "• Batteries store power for later use",
            "• Sell charged batteries to Eco-Friend NPCs",
            "• Use Wires weapon to connect entities",
            "• Destroyed equipment drops stored power"
        }

        for _, line in ipairs(info) do
            local label = vgui.Create("DLabel", scroll)
            label:SetText(line)
            label:SetAutoStretchVertical(true)
            scroll:AddItem(label)
        end
    end)
end