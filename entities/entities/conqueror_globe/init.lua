AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:Initialize()
    self:SetModel("models/props_phx/misc/smallcannonball.mdl") -- Placeholder for globe
    DarkRP.ValidatedPhysicsInit(self, SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)

    local phys = self:GetPhysicsObject()

    if phys:IsValid() then
        phys:Wake()
    end

    self.colonies = {} -- Up to 5
end

function ENT:Use(activator, caller)
    -- Open colony management menu
    net.Start("OpenColonyMenu")
    net.WriteTable(self.colonies)
    net.Send(caller)
end

function ENT:AddColony()
    if #self.colonies < 5 then
        table.insert(self.colonies, {
            population = 1000,
            economy = 1.0,
            loyalty = 1.0,
            type = "normal"
        })
    end
end

function ENT:CollectTaxes()
    local total = 0
    for _, colony in ipairs(self.colonies) do
        total = total + colony.population * colony.economy * colony.loyalty * 10
    end
    self:Getowning_ent():addMoney(total)
end