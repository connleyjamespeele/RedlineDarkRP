include("shared.lua")

util.AddNetworkString("DisposalNPCMenu")
util.AddNetworkString("DisposeWasteNPC")

net.Receive("DisposeWasteNPC", function(len, ply)
    if ply:canAfford(500) then
        ply:addMoney(-500)
        -- Remove waste barrels near player
        local barrels = ents.FindInSphere(ply:GetPos(), 100)
        for _, barrel in ipairs(barrels) do
            if barrel:GetClass() == "waste_barrel" then
                barrel:Remove()
                break
            end
        end
        ply:ChatPrint("Waste disposed legally.")
    else
        ply:ChatPrint("You can't afford disposal.")
    end
end)