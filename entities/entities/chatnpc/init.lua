AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:Initialize()
    self:SetModel("models/player/group01/male_01.mdl")
    self:SetHullType(HULL_HUMAN)
    self:SetHullSizeNormal()
    self:SetNPCState(NPC_STATE_SCRIPT)
    self:SetSolid(SOLID_BBOX)
    self:CapabilitiesAdd(CAP_ANIMATEDFACE)
    self:SetUseType(SIMPLE_USE)
    self:DropToFloor()

    self.chatTimer = 0
    self.conversationPartners = {}
    self.currentTopic = "greeting"
    self.personality = math.random(1, 3) -- 1: friendly, 2: grumpy, 3: mysterious
    self.speechQueue = {}
    self.isSpeaking = false
    self.speechIndex = 1
    self.lastSpokenTime = 0
function ENT:Initialize()
    -- ... existing code ...

    -- Add chat command for interaction
    if SERVER then
        concommand.Add("chatnpc_respond", function(ply, cmd, args)
            if not IsValid(ply) then return end
            local topic = args[1]
            if not topic then return end
            local nearbyNPC = self:GetNearbyChatNPC(ply)
            if nearbyNPC then
                nearbyNPC:PlayerResponded(ply, topic)
            end
        end)
    end
end

function ENT:GetNearbyChatNPC(ply)
    for _, ent in ipairs(ents.FindByClass("chatnpc")) do
        if ent:GetPos():Distance(ply:GetPos()) < 300 then
            return ent
        end
    end
    return nil
end

function ENT:Initialize()
    -- ... existing code ...
    self.playerMemory = {} -- Remember what players talked about
end

function ENT:PlayerResponded(ply, response)
    if not self.conversationPartners[ply] then
        self:StartConversation(ply)
        return
    end

    local lowerResponse = string.lower(response)
    self.playerMemory[ply] = self.playerMemory[ply] or {}
    table.insert(self.playerMemory[ply], lowerResponse)

    if table.HasValue({"weather", "news", "quests", "personal", "hobbies", "travel"}, lowerResponse) then
        self:RespondToTopic(ply, lowerResponse)
    elseif lowerResponse == "yes" or lowerResponse == "sure" or lowerResponse == "okay" then
        self:SayToPlayer(ply, self.responses.positive[math.random(#self.responses.positive)])
    elseif lowerResponse == "no" or lowerResponse == "never" then
        self:SayToPlayer(ply, self.responses.negative[math.random(#self.responses.negative)])
    else
        self:SayToPlayer(ply, self.responses.neutral[math.random(#self.responses.neutral)])
        timer.Simple(2, function() self:OfferTopics(ply) end)
    end
end

function ENT:AskQuestion(ply)
    if not self.conversationPartners[ply] then return end
    local question = self.questions[math.random(#self.questions)]
    -- Personalize based on memory
    if self.playerMemory[ply] and #self.playerMemory[ply] > 0 then
        local lastTopic = self.playerMemory[ply][#self.playerMemory[ply]]
        if lastTopic == "weather" then
            question = "Do you like this kind of weather?"
        elseif lastTopic == "travel" then
            question = "Where have you traveled?"
        end
    end
    self:SayToPlayer(ply, question)
    self:SetChatMessage(question)
    self:SetChatType(4)
end
end

function ENT:Use(activator, caller)
    if IsValid(activator) and activator:IsPlayer() then
        self:StartConversation(activator)
    end
end

function ENT:Think()
    self:UpdateAI()
    self:ProcessSpeech()
end

function ENT:UpdateAI()
    self.chatTimer = self.chatTimer + FrameTime()

    if self.chatTimer > 60 then -- Every minute, say something random
        self:RandomChat()
        self.chatTimer = 0
    end

    -- Look for nearby players to chat with
    for _, ply in ipairs(player.GetAll()) do
        if self:GetPos():Distance(ply:GetPos()) < 200 and not self.conversationPartners[ply] then
            self:InitiateChat(ply)
        elseif self:GetPos():Distance(ply:GetPos()) > 250 and self.conversationPartners[ply] then
            self:EndConversation(ply)
        end
    end
end

function ENT:StartConversation(ply)
    self.conversationPartners[ply] = true
    local greeting = self:GetGreeting()
    self:SayToPlayer(ply, greeting)
    self:SetChatMessage(greeting)
    self:SetChatType(0)
    -- Offer conversation options
    timer.Simple(2, function() self:OfferTopics(ply) end)
end

function ENT:InitiateChat(ply)
    self:StartConversation(ply)
end

function ENT:EndConversation(ply)
    self.conversationPartners[ply] = nil
    self:SayToPlayer(ply, "Goodbye, friend!")
end

function ENT:RandomChat()
    local messages = {
        "Did you hear about the latest news?",
        "The weather is nice today, isn't it?",
        "Have you seen any interesting things lately?",
        "I wonder what's for dinner...",
        "Life is full of surprises!",
        "Tell me about yourself.",
        "What's your favorite hobby?",
        "Have you traveled much?"
    }
    local msg = messages[math.random(#messages)]
    for ply, _ in pairs(self.conversationPartners) do
        if IsValid(ply) then
            self:SayToPlayer(ply, msg)
        end
    end
    self:SetChatMessage(msg)
    self:SetChatType(1)
end

function ENT:GetGreeting()
    local greetings = {
        "Hello there! How are you?",
        "Greetings, friend! What brings you here?",
        "Hey! Nice to meet you. Let's chat!",
        "Welcome! I've been waiting for someone to talk to."
    }
    return greetings[math.random(#greetings)]
end

function ENT:OfferTopics(ply)
    if not self.conversationPartners[ply] then return end
    local topics = "What would you like to talk about? Say 'chatnpc_respond weather', 'chatnpc_respond news', 'chatnpc_respond quests', 'chatnpc_respond personal', 'chatnpc_respond hobbies', or 'chatnpc_respond travel' in chat."
    self:SayToPlayer(ply, topics)
    self:SetChatMessage("Offering topics...")
    self:SetChatType(2)
end

function ENT:SimulatePlayerResponse(ply)
    if not self.conversationPartners[ply] then return end
    local topics = {"weather", "news", "quests", "personal"}
    local chosen = topics[math.random(#topics)]
    self:RespondToTopic(ply, chosen)
end

function ENT:RespondToTopic(ply, topic)
    if not self.knowledge[topic] then
        self:SayToPlayer(ply, "I'm not sure about that. Let's talk about something else.")
        timer.Simple(2, function() self:OfferTopics(ply) end)
        return
    end
    local response = self.knowledge[topic][math.random(#self.knowledge[topic])]
    self:SayToPlayer(ply, response)
    self:SetChatMessage(response)
    self:SetChatType(3)
    -- Continue conversation
    timer.Simple(3, function() self:AskQuestion(ply) end)
end

function ENT:AskQuestion(ply)
    if not self.conversationPartners[ply] then return end
    local question = self.questions[math.random(#self.questions)]
    self:SayToPlayer(ply, question)
    self:SetChatMessage(question)
    self:SetChatType(4)
end

function ENT:SayToPlayer(ply, message)
    ply:ChatPrint("[Chat NPC] " .. message)
    -- Add to speech queue for sequential speaking
    table.insert(self.speechQueue, {player = ply, message = message})
    -- Play a random voice sound
    self:EmitSound("vo/npc/male01/answer" .. math.random(1, 40) .. ".wav", 75, 100, 0.5)
end

function ENT:ProcessSpeech()
    if self.isSpeaking then
        if CurTime() - self.lastSpokenTime > 2 then -- 2 seconds per message
            self.isSpeaking = false
        end
        return
    end

    if #self.speechQueue > 0 then
        local speech = table.remove(self.speechQueue, 1)
        if IsValid(speech.player) then
            speech.player:ChatPrint("[Chat NPC] " .. speech.message)
            self:SetChatMessage(speech.message)
            self.isSpeaking = true
            self.lastSpokenTime = CurTime()
        end
    end
end

function ENT:OnRemove()
    for ply, _ in pairs(self.conversationPartners) do
        if IsValid(ply) then
            self:EndConversation(ply)
        end
    end
end