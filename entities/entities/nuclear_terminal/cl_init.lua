include("shared.lua")

local alerts = {}

local function CreateButton(parent, text, x, y, w, h, action, value)
    local btn = vgui.Create("DButton", parent)
    btn:SetText(text)
    btn:SetPos(x, y)
    btn:SetSize(w, h)
    btn.DoClick = function()
        net.Start("NuclearTerminalAction")
        net.WriteString(action)
        net.WriteEntity(parent.TerminalEnt)
        if value ~= nil then
            if type(value) == "boolean" then
                net.WriteBool(value)
            else
                net.WriteInt(value, 4)
            end
        end
        net.SendToServer()
    end
    btn.Paint = function(self, bw, bh)
        draw.RoundedBox(0, 0, 0, bw, bh, Color(100, 0, 0, 200))
    end
    return btn
end

local function CreateLabel(parent, text, x, y)
    local label = vgui.Create("DLabel", parent)
    label:SetText(text)
    label:SetTextColor(Color(255, 255, 255))
    label:SetFont("DermaDefaultBold")
    label:SizeToContents()
    label:SetPos(x, y)
    return label
end

net.Receive("NuclearTerminalMenu", function()
    local ent = net.ReadEntity()
    local hasReactor = net.ReadBool()
    local data = {}
    if hasReactor then
        data.heat = net.ReadInt(16)
        data.waste = net.ReadInt(16)
        data.cooling = net.ReadInt(8)
        data.maxCooling = net.ReadInt(8)
        data.heatRate = net.ReadInt(8)
        data.wasteRate = net.ReadInt(8)
        data.banked = net.ReadInt(32)
        data.launder = net.ReadInt(8)
        data.research = net.ReadInt(8)
        data.remoteAlarm = net.ReadBool()
        data.heatSink = net.ReadBool()
        data.moneyLaundered = net.ReadBool()
        data.leadLined = net.ReadBool()
    end
    local hasWorker = net.ReadBool()
    if hasWorker then
        data.autoRefill = net.ReadBool()
        data.priorityMode = net.ReadInt(4)
        data.bribeInspector = net.ReadBool()
        data.legalDisposal = net.ReadBool()
    end

    local frame = vgui.Create("DFrame")
    frame:SetSize(520, 420)
    frame:SetTitle("Nuclear Facility Terminal")
    frame:Center()
    frame:MakePopup()
    frame.TerminalEnt = ent
    frame.Paint = function(self, w, h)
        draw.RoundedBox(0, 0, 0, w, h, Color(20, 20, 20, 240))
        draw.RoundedBox(0, 0, 0, w, 32, Color(180, 15, 15, 255))
    end

    if hasReactor then
        CreateLabel(frame, "Reactor Status", 20, 40)
        CreateLabel(frame, "Heat: " .. data.heat .. "/100", 20, 65)
        CreateLabel(frame, "Waste: " .. data.waste, 20, 85)
        CreateLabel(frame, "Cooling Barrels: " .. data.cooling .. "/" .. data.maxCooling, 20, 105)
        CreateLabel(frame, "Banked Funds: $" .. data.banked, 20, 125)
        CreateLabel(frame, "Launder Rate: " .. data.launder .. "%", 20, 145)
        CreateLabel(frame, "Research Level: " .. data.research, 20, 165)
        CreateLabel(frame, "Remote Alarm: " .. (data.remoteAlarm and "ON" or "OFF"), 20, 185)
        CreateLabel(frame, "Heat Sink: " .. (data.heatSink and "Installed" or "None"), 20, 205)
        CreateLabel(frame, "Lead Lining: " .. (data.leadLined and "Active" or "None"), 20, 225)

        CreateButton(frame, "Withdraw Waste", 320, 45, 170, 30, "withdraw_waste")
        CreateButton(frame, "Emergency Flush ($2000)", 320, 85, 170, 30, "emergency_flush")
        CreateButton(frame, "Remote Alarm ($1500)", 320, 125, 170, 30, "purchase_remote_alarm")
        CreateButton(frame, "Heat Sink ($4000)", 320, 165, 170, 30, "purchase_heat_sink")
        CreateButton(frame, "Expand to 6", 320, 205, 80, 30, "purchase_expansion", 6)
        CreateButton(frame, "Expand to 8", 410, 205, 80, 30, "purchase_expansion", 8)
        CreateButton(frame, "Money Laundering ($4500)", 320, 245, 170, 30, "purchase_money_laundering")
        CreateButton(frame, "Lead Lining ($3500)", 320, 285, 170, 30, "purchase_lead_lining")
        CreateButton(frame, "Research Upgrade ($5000)", 320, 325, 170, 30, "purchase_research")
    else
        CreateLabel(frame, "Error: No reactor found within range.", 20, 45)
    end

    if hasWorker then
        CreateLabel(frame, "Worker Settings", 20, 260)
        CreateLabel(frame, "Auto-Refill: " .. (data.autoRefill and "Installed" or "None"), 20, 285)
        CreateLabel(frame, "Priority: " .. (data.priorityMode == 0 and "Heat" or "Waste"), 20, 305)
        CreateLabel(frame, "Bribe Inspector: " .. (data.bribeInspector and "Active" or "None"), 20, 325)
        CreateLabel(frame, "Current Mode: " .. (data.legalDisposal and "Legal" or "Illegal"), 20, 345)

        CreateButton(frame, "Auto-Refill Station ($2500)", 20, 370, 220, 30, "toggle_auto_refill")
        CreateButton(frame, "Priority: Heat", 250, 370, 120, 30, "set_priority", 0)
        CreateButton(frame, "Priority: Waste", 380, 370, 120, 30, "set_priority", 1)
        CreateButton(frame, "Bribe Inspector ($5000)", 20, 410, 220, 30, "purchase_bribe_inspector")
    else
        CreateLabel(frame, "Error: No assigned worker found.", 20, 260)
    end
end)

net.Receive("NuclearReactorAlert", function()
    local msg = net.ReadString()
    local duration = net.ReadInt(8)
    table.insert(alerts, {text = msg, expire = CurTime() + duration})
end)

hook.Add("HUDPaint", "NuclearReactorAlertHUD", function()
    for i = #alerts, 1, -1 do
        local alert = alerts[i]
        if CurTime() > alert.expire then
            table.remove(alerts, i)
        else
            draw.RoundedBox(0, 20, 20 + (i - 1) * 30, 400, 26, Color(180, 0, 0, 220))
            draw.SimpleText(alert.text, "DermaDefaultBold", 30, 25 + (i - 1) * 30, Color(255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        end
    end
end)