include("shared.lua")

util.AddNetworkString("WasteBarrelMenu")
util.AddNetworkString("DisposeWaste")

net.Receive("DisposeWaste", function(len, ply)
    local ent = net.ReadEntity()
    local legal = net.ReadBool()
    if not IsValid(ent) or ent:GetClass() ~= "waste_barrel" then return end

    if legal then
        if ply:canAfford(500) then
            ply:addMoney(-500)
            ent:Remove()
            ply:ChatPrint("Waste disposed legally.")
        else
            ply:ChatPrint("You can't afford legal disposal.")
        end
    else
        -- Illegal disposal
        local detectionChance = ent:GetLeadLined() and 0.4 or 1
        if math.random() <= detectionChance then
            ply:wanted(nil, "Illegal waste disposal")
            ply:ChatPrint("Waste disposed illegally. You are now wanted!")
        else
            ply:ChatPrint("Illegal waste disposal succeeded quietly.")
        end
        ent:Remove()
    end
end)