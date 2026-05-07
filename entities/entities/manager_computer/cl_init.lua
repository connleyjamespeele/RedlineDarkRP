include("shared.lua")

if CLIENT then
    net.Receive("OpenClubManagerMenu", function()
        local ent = net.ReadEntity()
        local frame = vgui.Create("DFrame")
        frame:SetTitle("Club Manager Dashboard")
        frame:SetSize(600, 500)
        frame:Center()
        frame:MakePopup()
        frame:SetDraggable(true)
        frame:SetSizable(false)

        local scroll = vgui.Create("DScrollPanel", frame)
        scroll:Dock(FILL)

        -- Stats Panel
        local stats = vgui.Create("DPanel", scroll)
        stats:Dock(TOP)
        stats:SetTall(100)
        stats:DockMargin(5,5,5,5)
        stats.Paint = function(self, w, h)
            draw.RoundedBox(4, 0, 0, w, h, Color(50,50,50))
        end

        local incomeLabel = vgui.Create("DLabel", stats)
        incomeLabel:SetText("Performer Income: $" .. ent:GetNWInt("PerformerIncome"))
        incomeLabel:SetFont("DermaLarge")
        incomeLabel:SetColor(Color(0,255,0))
        incomeLabel:Dock(TOP)
        incomeLabel:DockMargin(10,10,10,0)

        local customerLabel = vgui.Create("DLabel", stats)
        customerLabel:SetText("Current Customers: " .. ent:GetNWInt("CustomerCount"))
        customerLabel:SetFont("DermaDefaultBold")
        customerLabel:Dock(TOP)
        customerLabel:DockMargin(10,5,10,10)

        -- Upgrades Panel
        local upgrades = vgui.Create("DPanel", scroll)
        upgrades:Dock(TOP)
        upgrades:SetTall(350)
        upgrades:DockMargin(5,5,5,5)
        upgrades.Paint = function(self, w, h)
            draw.RoundedBox(4, 0, 0, w, h, Color(70,70,70))
        end

        local upgradeList = vgui.Create("DListLayout", upgrades)
        upgradeList:Dock(FILL)
        upgradeList:DockMargin(10,10,10,10)

        local function AddUpgradeButton(name, desc, cost, level)
            local btn = vgui.Create("DButton")
            btn:SetText(name .. " ($" .. cost .. ") - " .. desc)
            btn:SetTall(40)
            if level then
                btn:SetText(btn:GetText() .. " Level: " .. level)
            end
            btn.DoClick = function()
                net.Start("ClubUpgrade")
                net.WriteEntity(ent)
                net.WriteString(string.lower(string.gsub(name, " ", "")))
                net.SendToServer()
            end
            upgradeList:Add(btn)
        end

        AddUpgradeButton("Performer", "Increase max performers", 1000, ent:GetNWInt("Performers") .. "/5")
        AddUpgradeButton("Bartender", "Increase max bartenders", 800, ent:GetNWInt("Bartenders") .. "/3")
        AddUpgradeButton("Advertisement", "Attract more customers", 500, ent:GetNWInt("Advertisement"))
        AddUpgradeButton("Tips", "Increase tip amounts", 600, ent:GetNWInt("Tips"))
        AddUpgradeButton("VIP Area", "Unlock VIP section", 2000)
        AddUpgradeButton("VIP Rating", "Improve VIP experience", 1500, ent:GetNWInt("VIPRating"))
        AddUpgradeButton("Lighting", "Better club lighting", 700, ent:GetNWInt("Lighting"))
        AddUpgradeButton("Music", "Upgrade sound system", 900, ent:GetNWInt("Music"))
        AddUpgradeButton("Security", "Enhanced security", 1200, ent:GetNWInt("Security"))
    end)
end