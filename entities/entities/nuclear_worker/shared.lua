ENT.Type = "anim"
ENT.Base = "base_gmodentity"

ENT.PrintName = "Nuclear Worker"
ENT.Author = "AI"
ENT.Category = "Nuclear"
ENT.Spawnable = true

function ENT:SetupDataTables()
    self:NetworkVar("Bool", 0, "LegalDisposal")
    self:NetworkVar("Bool", 1, "AutoRefill")
    self:NetworkVar("Int", 0, "PriorityMode")
    self:NetworkVar("Bool", 2, "BribeInspector")
end

local function GetEntityOwner(ent)
    if not IsValid(ent) then return nil end
    if ent.Getowning_ent then
        local owner = ent:Getowning_ent()
        if IsValid(owner) then return owner end
    end
    if ent.GetOwner then
        local owner = ent:GetOwner()
        if IsValid(owner) then return owner end
    end
    return nil
end

if SERVER then
    function ENT:Initialize()
        self:SetModel("models/player/breen.mdl")
        self:PhysicsInit(SOLID_VPHYSICS)
        self:SetMoveType(MOVETYPE_VPHYSICS)
        self:SetSolid(SOLID_VPHYSICS)
        self:SetUseType(SIMPLE_USE)

        self:SetLegalDisposal(true)
        self:SetAutoRefill(false)
        self:SetPriorityMode(0)
        self:SetBribeInspector(false)

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
        local owner = GetEntityOwner(self)
        local reactors = ents.FindInSphere(self:GetPos(), 500)
        for _, reactor in ipairs(reactors) do
            if reactor:GetClass() == "nuclear_reactor" then
                local heatFirst = self:GetPriorityMode() == 0
                local heat = reactor:GetHeat()
                local waste = reactor:GetWaste()
                local legalCost = self:GetBribeInspector() and 75 or 100

                if self:GetAutoRefill() and heat > 50 and reactor:GetCoolingBarrels() < reactor:GetMaxCoolingBarrels() then
                    reactor:AddCoolingBarrel()
                end

                local function handleHeat()
                    if heat > 50 and reactor:GetCoolingBarrels() < reactor:GetMaxCoolingBarrels() then
                        reactor:AddCoolingBarrel()
                    end
                end

                local function handleWaste()
                    if waste > 20 and IsValid(owner) and owner:IsPlayer() then
                        if self:GetLegalDisposal() then
                            if owner:canAfford(legalCost) then
                                owner:addMoney(-legalCost)
                                reactor:SetWaste(math.max(0, waste - 10))
                            end
                        else
                            if self:GetBribeInspector() then
                                if math.random() < 0.5 then
                                    owner:wanted(nil, "Illegal waste disposal by worker")
                                end
                            else
                                owner:wanted(nil, "Illegal waste disposal by worker")
                            end
                            reactor:SetWaste(math.max(0, waste - 10))
                        end
                    end
                end

                if heatFirst then
                    handleHeat()
                    handleWaste()
                else
                    handleWaste()
                    handleHeat()
                end
                break
            end
        end
    end

    function ENT:Use(activator, caller)
        if activator:IsPlayer() and activator == GetEntityOwner(self) then
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