-- Set admins
hook.Add("PlayerInitialSpawn", "SetAdmins", function(ply)
    if ply:SteamID64() == "76561199456194136" then
        ply:SetUserGroup("superadmin")
    elseif ply:SteamID64() == "10160000000" then
        ply:SetUserGroup("superadmin")
    end
end)