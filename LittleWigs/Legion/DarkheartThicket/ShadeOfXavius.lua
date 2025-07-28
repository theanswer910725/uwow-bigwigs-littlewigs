
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Shade of Xavius", 1466, 1657)
if not mod then return end
mod:RegisterEnableMob(99192)
mod.engageId = 1839

--------------------------------------------------------------------------------
-- Locals
--
local LastBoltTime = 0
local NightmareBolt = 0
local GrowingParanoia = 0
local FeedOnTheWeak = 0
--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		200050, -- Apocalyptic Nightmare
		{200289, "SAY", "ICON"}, -- Growing Paranoia
		{200185, "ICON", "SAY"}, -- Nightmare Bolt
		200238, -- Feed on the Weak
		{200238, "ICON", "SAY"}, -- Feed on the Weak
		200182, -- Festering Rip
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "GrowingParanoia", 200289)
	self:Log("SPELL_AURA_REMOVED", "GrowingParanoiaRemoved", 200289)
	self:Log("SPELL_CAST_START", "NightmareBolt", 212834, 200185) -- Normal, Heroic+
	self:Log("SPELL_AURA_REMOVED", "WakingNightmareOver", 200243)
	self:Log("SPELL_AURA_APPLIED", "FeedOnTheWeakApplied", 200238)
	self:Log("SPELL_AURA_APPLIED", "FesteringRip", 200182)
	--self:Log("SPELL_AURA_REMOVED", "FeedOnTheWeakRemoved", 200238)
	--self:Log("SPELL_CAST_START", "FeedOnTheWeakApplied", 200238)
end

function mod:OnEngage()
	NightmareBolt = 0
	GrowingParanoia = 0
	FeedOnTheWeak = 0
	LastBoltTime = 0
	self:CDBar(200289, 25.5) -- Growing Paranoia
	self:CDBar(200185, 8.8) -- Nightmare Bolt
	self:CDBar(200238, 14) -- Feed on the Weak
	self:RegisterUnitEvent("UNIT_HEALTH_FREQUENT", nil, "boss1")
	self:UnregisterEvent("CHAT_MSG_MONSTER_YELL")
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:FesteringRip(args)
	local _, class = UnitClass("player")
	if self:Dispeller("magic") or class == "WARLOCK" then
		self:TargetMessage(args.spellId, args.destName, "Important", "Long", nil, nil, self:Dispeller("magic"))
	end
end

function mod:CHAT_MSG_MONSTER_YELL(event, msg)
	NightmareTimeLeft = self:BarTimeLeft(200185)
	FeedTimeLeft = self:BarTimeLeft(200238)
	ParanoiaTimeLeft = self:BarTimeLeft(200289)
	mod:CDBar(200185, NightmareTimeLeft + 5.5)
	mod:CDBar(200238, FeedTimeLeft + 5.5)
	mod:CDBar(200289, ParanoiaTimeLeft + 5.5)
	self:Message(200050, "Neutral", "Long", CL.custom_sec:format(self:SpellName(200050), 5))
	self:Bar(200050, 5)
	self:UnregisterEvent("CHAT_MSG_MONSTER_YELL")
end
	
function mod:UNIT_HEALTH_FREQUENT(unit)
	local hp = UnitHealth(unit) / UnitHealthMax(unit) * 100
	if UnitHealth(unit) / UnitHealthMax(unit) < 0.51 then
		self:RegisterEvent("CHAT_MSG_MONSTER_YELL")
		self:UnregisterUnitEvent("UNIT_HEALTH_FREQUENT", unit)
	end
end

do
	local prev = 0
	local function printTarget(self, name, guid)
		self:PrimaryIcon(200289, name)
		local t = GetTime()
		if self:Me(guid) then
			prev = t
			self:TargetMessage(200289, name, "Attention", "Alarm")
		elseif t-prev > 1.5 then
			prev = t
			self:TargetMessage(200289, name, "Attention", "Alarm")
		end
	end
	function mod:GrowingParanoia(args)
		self:GetUnitTarget(printTarget, 0.4, args.sourceGUID)
		self:CDBar(args.spellId, 26) -- pull:25.5, 26.8, 28.0, 19.5 / hc pull:27.1, 32.8, 26.7, 27.9 / m pull:25.5, 37.6, 47.3
		if FeedOnTheWeak == 1 and GrowingParanoia == 0 then
			self:CDBar(200185, 5.9) -- Nightmare Bolt
			self:CDBar(200238, 17.5) -- FeedOnTheWeak
			FeedOnTheWeak = 0
		elseif NightmareBolt == 1 and GrowingParanoia == 0 then
			self:CDBar(200185, 13.6) -- Nightmare Bolt
			self:CDBar(200238, 13.6) -- FeedOnTheWeak
			FeedOnTheWeak = 0
		end
		GrowingParanoia = GrowingParanoia + 1
	end
	function mod:GrowingParanoiaRemoved(args)
		self:PrimaryIcon(200289, nil)
	end
end

do
	local prev = 0
	local function printTarget(self, name, guid)
		local t = GetTime()
		if self:Me(guid) then
			prev = t
			self:TargetMessage(200238, name, "Important", "Warning")
			self:Say(200238)
		elseif t-prev > 1.5 then
			prev = t
			self:TargetMessage(200238, name, "Attention", "Alarm")
		end
	end
	function mod:FeedOnTheWeakApplied(args)
		NightmareBolt = 0
		GrowingParanoia = 0
		FeedOnTheWeak = 1
		self:GetBossTarget(printTarget, 0.4, args.sourceGUID)
		self:CDBar(args.spellId, 29) -- pull:25.5, 26.8, 28.0, 19.5 / hc pull:27.1, 32.8, 26.7, 27.9 / m pull:25.5, 37.6, 47.3
		if (LastBoltTime-GetTime()) > 13 then
			self:CDBar(200289, 9.0) -- Growing Paranoia
			self:CDBar(200185, 16.0) -- Nightmare Bolt
		elseif (LastBoltTime-GetTime()) < 0.6 then
			self:CDBar(200185, 8.4) -- Nightmare Bolt
			self:CDBar(200289, 13.2) -- Growing Paranoia
		elseif (LastBoltTime-GetTime()) < 13 then
			self:CDBar(200289, 8.5) -- Growing Paranoia
			self:CDBar(200185, 8.5) -- Nightmare Bolt
		end
	end
end

do
	local prev = 0
	local function printTarget(self, name, guid)
		self:SecondaryIcon(200185, name)
		local t = GetTime()
		if self:Me(guid) then
			prev = t
			self:TargetMessage(200185, name, "Personal", "Bam")
			self:Say(200185)
		elseif t-prev > 1.5 then
			prev = t
			self:TargetMessage(200185, name, "Personal", "None")
		end
	end
	function mod:NightmareBolt(args)
		self:GetUnitTarget(printTarget, 0.4, args.sourceGUID)
		self:CDBar(200185, 17.81) -- pull:9.6, 19.5, 30.4, 24.3, 19.4 / hc pull:9.1, 23.1, 37.6, 21.8 / m pull:7.2, 21.9, 26.7, 21.9, 17.0
		if FeedOnTheWeak == 1 and NightmareBolt == 0 then
			self:CDBar(200289, 4.8) -- Growing Paranoia
			self:CDBar(200185, 18.52) -- Nightmare Bolt
			self:CDBar(200238, 18.52) -- FeedOnTheWeak
			FeedOnTheWeak = 0
		elseif NightmareBolt == 1 then
			self:CDBar(200238, 5.0) -- FeedOnTheWeak
			self:CDBar(200289, 15.0) -- Growing Paranoia
			self:CDBar(200185, 20.9) -- Nightmare Bolt
		end
		NightmareBolt = NightmareBolt + 1
		LastBoltTime = GetTime() + 19
	end
	function mod:WakingNightmareOver(args)
		self:SecondaryIcon(200185, nil)
	end
end