include("shared.lua")

util.AddNetworkString("NuclearTerminalMenu")
util.AddNetworkString("WithdrawWaste")

net.Receive("WithdrawWaste", function(len, ply)
    local ent = net.ReadEntity()
    if not IsValid(ent) or ent:GetClass() ~= "nuclear_terminal" then return end

    -- Find nearby reactor
    local reactors = ents.FindInSphere(ent:GetPos(), 500)
    for _, reactor in ipairs(reactors) do
        if reactor:GetClass() == "nuclear_reactor" and reactor:GetWaste() > 0 then
            local waste = ents.Create("waste_barrel")
            waste:SetPos(ent:GetPos() + Vector(0, 50, 0))
            waste:Spawn()
            waste:SetWasteAmount(reactor:GetWaste())
            reactor:SetWaste(0)
            break
        end
    end
end)