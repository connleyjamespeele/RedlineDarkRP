local function formatAmount(amount)
    return DarkRP.formatMoney(amount)
end

local function makeRarityLabel(text, rarity)
    local color = Color(200, 200, 200)
    if rarity == "uncommon" then color = Color(100, 220, 100)
    elseif rarity == "rare" then color = Color(100, 180, 255)
    elseif rarity == "legendary" then color = Color(200, 120, 255)
    elseif rarity == "god" then color = Color(255, 200, 60)
    elseif rarity == "ultra_god" then color = Color(255, 120, 180)
    elseif rarity == "admin" then color = Color(255, 60, 60)
    end
    return text, color
end

net.Receive("DarkRP_OpenFlipsMenu", function()
    local defaultAmount = net.ReadUInt(32)
    local challenges = net.ReadTable()
    local hasOwn = net.ReadBool()
    local ownChoice, ownAmount, ownAge

    if hasOwn then
        ownChoice = net.ReadString()
        ownAmount = net.ReadUInt(32)
        ownAge = net.ReadUInt(32)
    end

    local frame = vgui.Create("DFrame")
    frame:SetTitle("Coin Flip Challenges")
    frame:SetSize(520, 420)
    frame:Center()
    frame:MakePopup()

    local helpLabel = vgui.Create("DLabel", frame)
    helpLabel:SetText("Create a flip challenge or accept an open challenge from another player.")
    helpLabel:SetPos(16, 34)
    helpLabel:SetTextColor(Color(255, 255, 255))
    helpLabel:SizeToContents()

    local amountLabel = vgui.Create("DLabel", frame)
    amountLabel:SetText("Wager amount:")
    amountLabel:SetPos(16, 70)
    amountLabel:SizeToContents()

    local amountEntry = vgui.Create("DTextEntry", frame)
    amountEntry:SetNumeric(true)
    amountEntry:SetText(tostring(defaultAmount))
    amountEntry:SetPos(110, 68)
    amountEntry:SetSize(180, 24)

    local choiceLabel = vgui.Create("DLabel", frame)
    choiceLabel:SetText("Your call:")
    choiceLabel:SetPos(16, 104)
    choiceLabel:SizeToContents()

    local choiceBox = vgui.Create("DComboBox", frame)
    choiceBox:SetPos(110, 100)
    choiceBox:SetSize(180, 24)
    choiceBox:SetValue("Heads")
    choiceBox:AddChoice("Heads")
    choiceBox:AddChoice("Tails")

    local createButton = vgui.Create("DButton", frame)
    createButton:SetText("Open Challenge")
    createButton:SetPos(16, 136)
    createButton:SetSize(274, 28)
    createButton.DoClick = function()
        local amount = tonumber(amountEntry:GetText())
        if not amount or amount < 1 then
            LocalPlayer():ChatPrint("Enter a valid bet amount.")
            return
        end

        net.Start("DarkRP_FlipsAction")
            net.WriteString("create")
            net.WriteUInt(math.Clamp(amount, 1, 1000000), 32)
            net.WriteString(string.lower(choiceBox:GetValue()))
        net.SendToServer()
        frame:Close()
    end

    if hasOwn then
        local ownLabel = vgui.Create("DLabel", frame)
        ownLabel:SetPos(16, 174)
        ownLabel:SetText(string.format("Your open challenge: %s for %s (called %s, %ss old)", formatAmount(ownAmount), ownChoice, ownChoice, tostring(ownAge)))
        ownLabel:SetTextColor(Color(220, 220, 100))
        ownLabel:SizeToContents()

        local cancelButton = vgui.Create("DButton", frame)
        cancelButton:SetText("Cancel My Challenge")
        cancelButton:SetPos(16, 200)
        cancelButton:SetSize(274, 28)
        cancelButton.DoClick = function()
            net.Start("DarkRP_FlipsAction")
                net.WriteString("cancel")
            net.SendToServer()
            frame:Close()
        end
    end

    local listLabel = vgui.Create("DLabel", frame)
    listLabel:SetText("Open challenges:")
    listLabel:SetPos(16, hasOwn and 240 or 174)
    listLabel:SizeToContents()

    local listY = hasOwn and 268 or 202
    local scroll = vgui.Create("DScrollPanel", frame)
    scroll:SetPos(16, listY)
    scroll:SetSize(488, 140)

    if #challenges == 0 then
        local noneLabel = vgui.Create("DLabel", scroll)
        noneLabel:SetText("No open flips yet. Create one and wait for another player!")
        noneLabel:SetPos(4, 4)
        noneLabel:SetTextColor(Color(200, 200, 200))
        noneLabel:SizeToContents()
    else
        local layout = vgui.Create("DIconLayout", scroll)
        layout:Dock(FILL)
        layout:SetSpaceY(8)
        layout:SetSpaceX(8)

        for _, challenge in ipairs(challenges) do
            local panel = vgui.Create("DPanel")
            panel:SetSize(230, 100)
            panel.Paint = function(self, w, h)
                draw.RoundedBox(8, 0, 0, w, h, Color(35, 35, 35, 220))
                draw.RoundedBox(8, 0, 0, w, 4, Color(180, 100, 255))
            end

            local name = vgui.Create("DLabel", panel)
            name:SetPos(8, 8)
            name:SetText(challenge.creatorName)
            name:SetTextColor(Color(255, 255, 255))
            name:SetFont("DermaDefaultBold")
            name:SizeToContents()

            local amount = vgui.Create("DLabel", panel)
            amount:SetPos(8, 28)
            amount:SetText("Wager: " .. formatAmount(challenge.amount))
            amount:SetTextColor(Color(200, 200, 200))
            amount:SizeToContents()

            local choice = vgui.Create("DLabel", panel)
            choice:SetPos(8, 44)
            choice:SetText("Creator calls: " .. string.upper(challenge.choice))
            choice:SetTextColor(Color(200, 200, 255))
            choice:SizeToContents()

            local accept = vgui.Create("DButton", panel)
            accept:SetPos(8, 68)
            accept:SetSize(214, 24)
            accept:SetText("Accept Challenge")
            accept.DoClick = function()
                net.Start("DarkRP_FlipsAction")
                    net.WriteString("accept")
                    net.WriteString(challenge.creatorSteamID)
                net.SendToServer()
                frame:Close()
            end

            layout:Add(panel)
        end
    end
end)
