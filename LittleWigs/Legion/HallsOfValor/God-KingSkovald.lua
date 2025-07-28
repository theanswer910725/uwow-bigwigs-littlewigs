
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("God-King Skovald", 1477, 1488)
if not mod then return end
mod:RegisterEnableMob(
	98364, -- Aegis of Aggramar
	95675  -- God-King Skovald
)
mod.engageId = 1808

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.warmup_text = "God-King Skovald Active"
	L.warmup_trigger = "The vanquishers have already taken possession of it, Skovald, as was their right. Your protest comes too late."
	L.warmup_trigger_2 = "If these false champions will not yield the aegis by choice... then they will surrender it in death!"
end

--------------------------------------------------------------------------------
-- Locals
--

local RagnarokCount = 0
local SavageCount = 0
local FelblazeCount = 0

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"warmup",
		193783, -- Aegis of Aggramar
		193668, -- Savage Blade
		193826, -- Ragnarok
		{193659, "SAY", "ICON"}, -- Felblaze Rush
		193702, -- Infernal Flames
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("CHAT_MSG_MONSTER_YELL", "Warmup")
	self:Log("SPELL_CAST_START", "SavageBlade", 193668)
	self:Log("SPELL_CAST_START", "RagnarokStart", 193826)
	self:Log("SPELL_CAST_SUCCESS", "Ragnarok", 193826)
	self:Log("SPELL_CAST_START", "FelblazeRush", 193659)
	self:Log("SPELL_CAST_SUCCESS", "FelblazeRushEnd", 193659)

	self:Log("SPELL_AURA_APPLIED", "AegisOfAggramarPickedUpByPlayer", 193783)
	self:Log("SPELL_AURA_REMOVED", "AegisOfAggramarDroppedBySkovald", 193983)
	self:Log("SPELL_CAST_SUCCESS", "AegisofAggramarApplied", 193983)
	self:Log("SPELL_AURA_APPLIED", "InfernalFlamesDamage", 193702)
	self:Log("SPELL_PERIODIC_DAMAGE", "InfernalFlamesDamage", 193702)
	self:Log("SPELL_PERIODIC_MISSED", "InfernalFlamesDamage", 193702)
	self:Death("SkovaldDeath", 95675)
end

function mod:OnEngage()
	RagnarokCount = 0
	SavageCount = 0
	FelblazeCount = 0
	self:CDBar(193826, 13) -- Ragnarok
	self:CDBar(193668, self:Normal() and 24 or 26) -- Savage Blade
	self:CDBar(193659, 6) -- Felblaze Rush
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:AegisOfAggramarPickedUpByPlayer(args)
	if self:Me(args.destGUID) then
		self:Message(args.spellId, "Positive", "Info", CL.you:format(args.spellName))
	end
end

function mod:AegisOfAggramarDroppedBySkovald(args)
	self:Message(193783, "Neutral", "Info", CL.removed:format(args.spellName))
end

function mod:AegisofAggramarApplied(args)
	if RagnarokCount == 1 and FelblazeCount == 1 and SavageCount == 1 then
		self:CDBar(193659, 11.8) -- Felblaze Rush
		self:CDBar(193668, 16.8)
	elseif RagnarokCount == 1 and FelblazeCount == 1 and SavageCount == 0 then
		self:CDBar(193659, 16.8) -- Felblaze Rush
		self:CDBar(193668, 11.8)
	elseif RagnarokCount == 1 and FelblazeCount == 0 and SavageCount == 0 then
		self:CDBar(193659, 11.5) -- Felblaze Rush
		self:CDBar(193668, 16.2)
	end
end

function mod:Warmup(event, msg)
	if msg == L.warmup_trigger then
		self:UnregisterEvent(event)
		self:Bar("warmup", 24.8, L.warmup_text, "achievement_dungeon_hallsofvalor")
	elseif msg == L.warmup_trigger_2 then -- for engages after a wipe
		self:UnregisterEvent(event)
		self:Bar("warmup", 10, L.warmup_text, "achievement_dungeon_hallsofvalor")
	end
end

function mod:SavageBlade(args)
	self:Message(args.spellId, "Attention", self:Tank() and "Warning")
	self:CDBar(args.spellId, 18) -- pull:24.3, 24.3, 17.8, 20.9 / hc pull:48.6, 19.5 / m pull:47.3, 24.3, 37.6
	if RagnarokCount == 1 and SavageCount == 0 then
		self:CDBar(args.spellId, 21)
	elseif RagnarokCount == 1 and SavageCount == 1 then
		self:CDBar(args.spellId, 22)
	elseif RagnarokCount == 1 and SavageCount == 2 then
		self:CDBar(args.spellId, 22)
	elseif RagnarokCount == 1 and SavageCount == 3 then
		self:CDBar(args.spellId, 22)
	end
	SavageCount = SavageCount + 1
end

function mod:RagnarokStart(args)
	self:Message(args.spellId, "Urgent", "Long")
	SavageCount = 0
	FelblazeCount = 0
end

function mod:Ragnarok(args)
	self:CDBar(args.spellId, 61.7) -- pull:11.4, 63.5
	RagnarokCount = 1
	self:CDBar(193659, 9)
	self:CDBar(193668, 14)
end

do
	local prev = 0
	local function printTarget(self, name, guid)
		local t = GetTime()
		if self:Me(guid) then
			prev = t
			self:TargetMessage(193659, name, "Personal", "Bam")
			self:Say(193659)
		elseif t-prev > 1.5 then
			prev = t
			self:TargetMessage(193659, name, "Important", "Alarm")
		end
	end
	function mod:FelblazeRush(args)
		self:GetUnitTarget(printTarget, 0.3, args.sourceGUID)
		self:PrimaryIcon(193659, args.destName)
		if RagnarokCount == 1 and FelblazeCount == 0 then
			self:CDBar(args.spellId, 11)
		elseif RagnarokCount == 1 and FelblazeCount == 1 then
			self:CDBar(args.spellId, 11)
		elseif RagnarokCount == 1 and FelblazeCount == 2 then
			self:CDBar(args.spellId, 11)
		elseif RagnarokCount == 1 and FelblazeCount == 3 then
			self:CDBar(args.spellId, 11)
		elseif RagnarokCount == 1 and FelblazeCount == 4 then
			self:CDBar(args.spellId, 11)
		end
		FelblazeCount = FelblazeCount + 1
	end
	function mod:FelblazeRushEnd(args)
		self:PrimaryIcon(193659, nil)
	end
end

do
	local prev = 0
	function mod:InfernalFlamesDamage(args)
		if self:Me(args.destGUID) then
			local t = GetTime()
			if t-prev > 2 then
				prev = t
				self:Message(args.spellId, "Personal", "Alarm", CL.underyou:format(args.spellName))
			end
		end
	end
end

function mod:SkovaldDeath(args)
	local odynMod = BigWigs:GetBossModule("Odyn", true)
	if odynMod then
		odynMod:Enable() -- Making sure to pickup the Odyn's yell to start the RP bar
	end
end
