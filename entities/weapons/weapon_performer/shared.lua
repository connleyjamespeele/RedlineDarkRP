SWEP.PrintName = "Performer Tool"
SWEP.Author = "AI"
SWEP.Instructions = "Left click on a player/NPC to offer a dance for $500"
SWEP.Spawnable = false
SWEP.AdminOnly = false

SWEP.ViewModel = "models/weapons/v_hands.mdl"
SWEP.WorldModel = "models/weapons/w_hands.mdl"

SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "none"

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"

if SERVER then
    util.AddNetworkString("PerformerDancePrompt")
    util.AddNetworkString("PerformerDanceAccept")
end

function SWEP:PrimaryAttack()
    if CLIENT then return end
    self:SetNextPrimaryFire(CurTime() + 1)
    local tr = self.Owner:GetEyeTrace()
    local ent = tr.Entity
    if IsValid(ent) and (ent:IsPlayer() or ent:IsNPC()) and tr.HitPos:Distance(self.Owner:GetPos()) < 200 then
        net.Start("PerformerDancePrompt")
        net.WriteEntity(self.Owner)
        net.Send(ent)
    end
end

if CLIENT then
    net.Receive("PerformerDancePrompt", function()
        local performer = net.ReadEntity()
        local frame = vgui.Create("DFrame")
        frame:SetTitle("Dance Offer")
        frame:SetSize(300, 100)
        frame:Center()
        frame:MakePopup()

        local label = vgui.Create("DLabel", frame)
        label:SetText("Do you want to dance for $500?")
        label:Dock(TOP)

        local yes = vgui.Create("DButton", frame)
        yes:SetText("Yes")
        yes:Dock(LEFT)
        yes.DoClick = function()
            net.Start("PerformerDanceAccept")
            net.WriteEntity(performer)
            net.SendToServer()
            frame:Close()
        end

        local no = vgui.Create("DButton", frame)
        no:SetText("No")
        no:Dock(RIGHT)
        no.DoClick = function()
            frame:Close()
        end
    end)
end

if SERVER then
    net.Receive("PerformerDanceAccept", function(len, ply)
        local performer = net.ReadEntity()
        if not IsValid(performer) or not performer:IsPlayer() then return end
        -- Play sound (placeholder)
        ply:EmitSound("performer/dance.wav") -- Placeholder path
        performer:EmitSound("performer/dance.wav")
        -- Black screen effect
        ply:ScreenFade(SCREENFADE.IN, Color(0,0,0), 2, 2)
        performer:ScreenFade(SCREENFADE.IN, Color(0,0,0), 2, 2)
        -- Pay performer
        performer:addMoney(500)
        ply:ChatPrint("You danced and paid $500!")
        performer:ChatPrint("You earned $500 from the dance!")
    end)
end