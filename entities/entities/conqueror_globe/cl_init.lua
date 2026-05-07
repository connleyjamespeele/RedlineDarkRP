include("shared.lua")

if CLIENT then
    net.Receive("OpenGlobeMenu", function()
        local globe = net.ReadEntity()
        local frame = vgui.Create("DFrame")
        frame:SetTitle("Conqueror Globe - Empire Management")
        frame:SetSize(700, 600)
        frame:Center()
        frame:MakePopup()
        frame:SetDraggable(true)

        local scroll = vgui.Create("DScrollPanel", frame)
        scroll:Dock(FILL)
        scroll:DockMargin(10,10,10,10)

        -- Stats Panel
        local statsLabel = vgui.Create("DLabel", scroll)
        statsLabel:SetText("Colonies: " .. globe:GetNWInt("ColonyCount") .. "/5 | Total Income: $" .. globe:GetNWInt("TotalIncome") .. " | Military Power: " .. globe:GetNWInt("MilitaryPower"))
        statsLabel:SetFont("DermaLarge")
        statsLabel:SetColor(Color(255, 0, 0))
        scroll:AddItem(statsLabel)

        -- Create Colony Button
        local createBtn = vgui.Create("DButton", scroll)
        createBtn:SetText("Establish New Colony ($100M)")
        createBtn:SetTall(40)
        createBtn.DoClick = function()
            net.Start("CreateColony")
            net.WriteEntity(globe)
            net.SendToServer()
        end
        scroll:AddItem(createBtn)

        -- Upgrades Section
        local upgradeLabel = vgui.Create("DLabel", scroll)
        upgradeLabel:SetText("Advanced Upgrades:")
        upgradeLabel:SetFont("DermaDefaultBold")
        scroll:AddItem(upgradeLabel)

        local upgrades = {
            {name = "Industrial Infrastructure", desc = "Boost colony production", cost = 50000, id = "industry"},
            {name = "Direct Economic Stimulus", desc = "Donate to improve economy", cost = 100000, id = "donate"},
            {name = "Trade Hub", desc = "Link colonies for bonuses", cost = 200000, id = "trade"},
            {name = "Military Upgrades", desc = "Increase military power", cost = 150000, id = "military"},
            {name = "Research Labs", desc = "Unlock new technologies", cost = 300000, id = "research"},
            {name = "Diplomacy", desc = "Trade with NPCs", cost = 100000, id = "diplomacy"}
        }

        for _, upg in ipairs(upgrades) do
            local btn = vgui.Create("DButton", scroll)
            btn:SetText(upg.name .. " - " .. upg.desc .. " ($" .. upg.cost .. ")")
            btn:SetTall(35)
            btn.DoClick = function()
                net.Start("UpgradeColony")
                net.WriteEntity(globe)
                net.WriteString(upg.id)
                net.SendToServer()
            end
            scroll:AddItem(btn)
        end

        -- Colony Type Section
        local typeLabel = vgui.Create("DLabel", scroll)
        typeLabel:SetText("Colony Specializations:")
        typeLabel:SetFont("DermaDefaultBold")
        scroll:AddItem(typeLabel)

        local types = {
            "The Forge World (Industry focus, suit discounts)",
            "The Agri-World (Population focus, rebellion backup)",
            "The Tax Haven (Economy multiplier)"
        }

        for _, type in ipairs(types) do
            local label = vgui.Create("DLabel", scroll)
            label:SetText("• " .. type)
            label:SetAutoStretchVertical(true)
            scroll:AddItem(label)
        end
    end)
end