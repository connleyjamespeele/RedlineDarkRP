AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:Initialize()
    self:SetModel("models/player/eli.mdl")
    self:SetHullType(HULL_HUMAN)
    self:SetHullSizeNormal()
    self:SetNPCState(NPC_STATE_SCRIPT)
    self:SetSolid(SOLID_BBOX)
    self:CapabilitiesAdd(CAP_ANIMATEDFACE)
    self:SetUseType(SIMPLE_USE)
    self:DropToFloor()
end

function ENT:Use(activator, caller)
    if caller:Team() == TEAM_BLACK_MARKET_DEALER then
        -- Sell supplies
        if caller:canAfford(50000) then
            caller:addMoney(-50000)
            -- Add supplies to lab
            local labs = ents.FindByClass("black_market_lab")
            for _, lab in ipairs(labs) do
                if lab:Getowning_ent() == caller then
                    lab:AddSupplies(10)
                    break
                end
            end
        end
    end
end

-- Spawn in dark areas
hook.Add("InitPostEntity", "SpawnSuppliers", function()
    for i = 1, 5 do
        local pos = Vector(math.random(-10000, 10000), math.random(-10000, 10000), 0)
        local tr = util.TraceLine({start = pos + Vector(0,0,10000), endpos = pos - Vector(0,0,10000)})
        if tr.Hit then
            local ent = ents.Create("black_market_supplier")
            ent:SetPos(tr.HitPos + Vector(0,0,10))
            ent:Spawn()
        end
    end
end)