ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Bank Vault"
ENT.Author = "AI"
ENT.Spawnable = false

function ENT:Initialize()
    self:SetModel("models/props_c17/safe01.mdl")
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
    local phys = self:GetPhysicsObject()
    if phys:IsValid() then
        phys:Wake()
    end
    self:SetNWInt("Money", 5000) -- Start with 5000
    timer.Create("BankIncome_" .. self:EntIndex(), 300, 0, function() -- Every 5 min
        if not IsValid(self) then return end
        local owner = self:Getowning_ent()
        if IsValid(owner) and owner:IsPlayer() then
            local income = math.floor(self:GetNWInt("Money") * 0.1)
            owner:addMoney(income)
        end
    end)
end

function ENT:OnRemove()
    timer.Remove("BankIncome_" .. self:EntIndex())
    -- Drop money if destroyed
    if self:GetNWInt("Money") > 0 then
        local money = ents.Create("spawned_money")
        money:SetPos(self:GetPos())
        money:Setamount(self:GetNWInt("Money"))
        money:Spawn()
    end
end

function ENT:Think()
    if self:GetNWInt("Money") <= 0 then
        self:SetNWInt("Money", 5000)
    end
end

function ENT:SetupDataTables()
    self:NetworkVar("Entity", 0, "owning_ent")
end