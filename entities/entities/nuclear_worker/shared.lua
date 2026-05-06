ENT.Type = "anim"
ENT.Base = "base_gmodentity"

ENT.PrintName = "Nuclear Worker"
ENT.Author = "AI"
ENT.Category = "Nuclear"
ENT.Spawnable = true

function ENT:SetupDataTables()
    self:NetworkVar("Bool", 0, "LegalDisposal")
end

if SERVER then
    function ENT:Initialize()
        self:SetModel("models/player/breen.mdl")
        self:PhysicsInit(SOLID_VPHYSICS)
        self:SetMoveType(MOVETYPE_VPHYSICS)
        self:SetSolid(SOLID_VPHYSICS)
        self:SetUseType(SIMPLE_USE)

        self:SetLegalDisposal(true)

        local phys = self:GetPhysicsObject()
        if phys:IsValid() then
            phys:Wake()
        end

        timer.Create("WorkerUpdate_" .. self:EntIndex(), 30, 0, function()
            if not IsValid(self) then return end
            self:ManageReactor()
        end)
    end

    function ENT:ManageReactor()
        local reactors = ents.FindInSphere(self:GetPos(), 500)
        for _, reactor in ipairs(reactors) do
            if reactor:GetClass() == "nuclear_reactor" then
                -- Add cooling if needed
                if reactor:GetHeat() > 50 and reactor:GetCoolingBarrels() < 4 then
                    reactor:AddCoolingBarrel()
                end

                -- Handle waste
                if reactor:GetWaste() > 20 then
                    if self:GetLegalDisposal() then
                        if reactor:GetOwner():canAfford(100) then
                            reactor:GetOwner():addMoney(-100)
                            reactor:SetWaste(reactor:GetWaste() - 10)
                        end
                    else
                        reactor:GetOwner():wanted(nil, "Illegal waste disposal by worker")
                        reactor:SetWaste(reactor:GetWaste() - 10)
                    end
                end
                break
            end
        end
    end

    function ENT:Use(activator, caller)
        if activator:IsPlayer() and activator == self:GetOwner() then
            net.Start("WorkerMenu")
            net.WriteEntity(self)
            net.Send(activator)
        end
    end

    function ENT:OnRemove()
        timer.Remove("WorkerUpdate_" .. self:EntIndex())
    end
else
    function ENT:Draw()
        self:DrawModel()
    end
end