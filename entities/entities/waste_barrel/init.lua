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
        ply:wanted(nil, "Illegal waste disposal")
        ent:Remove()
        ply:ChatPrint("Waste disposed illegally. You are now wanted!")
    end
end)