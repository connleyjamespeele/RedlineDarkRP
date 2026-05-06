include("shared.lua")

util.AddNetworkString("WorkerMenu")
util.AddNetworkString("SetWorkerDisposal")

net.Receive("SetWorkerDisposal", function(len, ply)
    local ent = net.ReadEntity()
    local legal = net.ReadBool()
    if not IsValid(ent) or ent:GetClass() ~= "nuclear_worker" or ent:GetOwner() ~= ply then return end

    ent:SetLegalDisposal(legal)
    ply:ChatPrint("Worker disposal set to " .. (legal and "legal" or "illegal"))
end)