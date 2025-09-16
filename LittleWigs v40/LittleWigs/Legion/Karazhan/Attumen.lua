
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Attumen the Huntsman", 1651, 1835)
if not mod then return end
mod:RegisterEnableMob(114262, 114264) -- Attumen, Midnight
mod.engageId = 1960

local StageCount = 0
local SpectralCount = 0
local inIntermission = false
local intermissionOver = false
local SayFake = 0

local L = mod:GetLocale()
if L then
	L.IntangiblePresence1 = "Незримое присутствие"
	L.IntangiblePresence2 = "Intangible Presence"
	L.IntangiblePresence3 = "Körperlose Präsenz"
	L.IntangiblePresence4 = "Presencia intangible"
	L.IntangiblePresence5 = "Présence immatérielle"
	L.IntangiblePresence6 = "Presenza Intangibile"
	L.IntangiblePresence7 = "무형의 존재"
	L.IntangiblePresence8 = "Presença Intangível"
	L.IntangiblePresence9 = "无形"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"stages",
		228895, -- Enrage
		227493, -- Mortal Strike
		{228852, "SAY"}, -- Shared Suffering
		227365, -- Spectral Charge
		227339, -- Mezair
		227363, -- Mighty Stomp
		{227404, "SAY"}, -- Intangible Presence
	}, {
		[227363] = -14300, -- Horse and Rider as One
		[227493] = -14304, -- Fighting on Foot
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")
	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss1", "boss2")
	self:Log("SPELL_CAST_START", "MortalStrike", 227493)
	self:Log("SPELL_CAST_START", "MightyStomp", 227363)
	self:Log("SPELL_CAST_START", "Mezair", 227339)
	self:Log("SPELL_AURA_APPLIED", "MortalStrikeApplied", 227493)
	self:Log("SPELL_AURA_REMOVED", "MortalStrikeRemoved", 227493)
	self:Log("SPELL_CAST_START", "SharedSuffering", 228852)
	self:Log("SPELL_AURA_REMOVED", "IntangiblePresenceA", 227404)
	self:Log("SPELL_AURA_APPLIED", "IntangiblePresenceFirst", 227404)
	self:Log("SPELL_AURA_APPLIED", "Enrage", 228895)
	self:RegisterUnitEvent("UNIT_AURA", nil, "boss1")
	self:RegisterUnitEvent("UNIT_HEALTH", nil, "boss1")
	self:RegisterUnitEvent("UNIT_HEALTH_FREQUENT", nil, "target")
	self:RegisterEvent("VEHICLE_ANGLE_UPDATE")
	self:RegisterEvent("CHAT_MSG_SAY")
	self:RegisterMessage("BigWigs_BossComm")
	self:RegisterMessage("DBM_AddonMessage")
end

function mod:OnEngage()
	SayFake = 1
	self:CDBar(227404, 6)
	self:Bar(227363, 14)
	StageCount = 0
	SpectralCount = 0
	inIntermission = false
	intermissionOver = false
	self:Message("stages", "Neutral", "None", self:SpellName(227584), 164493)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:UNIT_HEALTH_FREQUENT(unit)
	local hp = UnitHealth(unit) / UnitHealthMax(unit) * 100
	local mobId = self:MobId(guid)
	local n = self:UnitName("target")
	if hp then
		guid = UnitGUID("target")
		if mobId == 114262 and hp < 26 and StageCount == 1 then
			StageCount = 2
			SpectralCount = 2
			self:Message(228895, "Neutral", "Punch", CL.other:format(n, CL.percent:format(25, self:SpellName(164493))))
			self:StopBar(227474)
		end
	end
end

function mod:Enrage(args)
	self:Message("stages", "Neutral", "Long", self:SpellName(228895), 228895)
	self:UnregisterUnitEvent("UNIT_AURA", "boss1")
	self:Bar(227363, 14)
	self:StopBar(227493)
	self:StopBar(228852)
	self:StopBar(227365)
	self:StopBar(227404)
	StageCount = 2
	SpectralCount = 2
end

do
	local prev = 0

	function mod:BigWigs_BossComm(_, msg, data, sender)
		local t = GetTime()
		if msg == "intangiblePresenceOnMe" and t-prev > 10 and self:UnitDebuff(sender, 227404) then
			prev = t
			self:Message(227404, "Positive", "Info", CL.on:format(self:SpellName(227404), self:ColorName(sender)))
			SetRaidTarget(sender, 6)
		end
	end
	
	function mod:DBM_AddonMessage(_, sender, prefix, _, _, event)
		local t = GetTime()
		if prefix == "M" and event == "intangiblePresenceOnMe" and self:UnitDebuff(sender, 227404) and sender ~= self:UnitName("player") and t-prev > 10 then
			prev = t
			self:Message(227404, "Positive", "Info", CL.on:format(self:SpellName(227404), self:ColorName(sender)))
			SetRaidTarget(sender, 6)
		end
	end
	
	function mod:CHAT_MSG_SAY(_, msg, _, _, _, sender)
		local t = GetTime()
		if self:UnitDebuff(sender, 227404) and t-prev > 10 and SayFake == 0 and (msg:find(L.IntangiblePresence1) or msg:find(L.IntangiblePresence2) or msg:find(L.IntangiblePresence3) or msg:find(L.IntangiblePresence4) or msg:find(L.IntangiblePresence5) or msg:find(L.IntangiblePresence6) or msg:find(L.IntangiblePresence7) or msg:find(L.IntangiblePresence8) or msg:find(L.IntangiblePresence9)) then
			prev = t
			self:Message(227404, "Positive", "Info", CL.on:format(self:SpellName(227404), self:ColorName(sender)))
			SetRaidTarget(sender, 6)
		end
	end
end

function mod:IntangiblePresenceA(args)
	if GetRaidTargetIndex(args.destName) == 6 then
		SetRaidTarget(args.destName, 0)
	end
	SayFake = 1
end

function mod:fake()
	SayFake = 0
end

function mod:IntangiblePresenceFirst(args)
	SayFake = 1
	self:ScheduleTimer("fake", 0.9)
end

do
	local prev = 0
	function mod:VEHICLE_ANGLE_UPDATE(unit, spellName, _, _, spellId)
		local t = GetTime()
		if t-prev > 10 then
			prev = t
			mod:Sync("intangiblePresenceOnMe")
			self:Say(227404)
		end
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(unit, spellName, _, _, spellId)
	if spellId == 227404 then -- Intangible Presence
		self:Message(spellId, "Attention", self:Dispeller("magic") and "Warning")
		self:Bar(spellId, 58)
	elseif spellId == 227338 then -- Riderless
		self:Message("stages", "Neutral", "Long", spellName, false)
		self:StopBar(227404) -- Intangible Presence
	elseif spellId == 227584 then -- Mounted
		self:Message("stages", "Neutral", "Long", spellName, false)
	end
end


function mod:MortalStrike(args)
	self:Bar(227493, 16)
	self:Message(args.spellId, "Important", (self:Tank() or self:Healer()) and "Alarm", CL.casting:format(args.spellName))
	MortalStrikeTimeLeft = self:BarTimeLeft(227493)
	SharedSufferingTimeLeft = self:BarTimeLeft(228852)
	if MortalStrikeTimeLeft > SharedSufferingTimeLeft and SharedSufferingTimeLeft+3.8 > MortalStrikeTimeLeft then
		mod:CDBar(227493, SharedSufferingTimeLeft+3.8)
	end
end

function mod:MortalStrikeApplied(args)
	if self:Tank(args.destName) then
		self:TargetBar(args.spellId, 10, args.destName)
	end
end

function mod:MortalStrikeRemoved(args)
	self:StopBar(args.spellId, args.destName)
end

function mod:SharedSuffering(args)
	self:Message(228852, "Urgent", "Info")
	self:Bar(228852, 18)
	if self:Tank() then
		self:Say(228852)
		self:SayCountdown(228852, 3.8, 8, 3)
	end
end

function mod:timer()
	if SpectralCount == 0 then
		inIntermission = true
		self:Message("stages", "Neutral", "None", CL.intermission, 227365) -- Spectral Charge icon
		self:CDBar("stages", 13.3, CL.intermission, 227365) -- Spectral Charge icon
		self:ScheduleTimer("timer", 20)
		self:ScheduleTimer("timerover", 13.3)
		self:Bar(227365, 20)
	end
end

function mod:timerover()
	if SpectralCount == 0 then
		intermissionOver = true
		if inIntermission then
			inIntermission = false
			self:StopBar(CL.intermission)
			self:Message("stages", "Neutral", "Info", CL.over:format(CL.intermission), 227365) -- Intermission Over, Spectral Charge icon
		end
	end
end

do
	local hp = 0
	function mod:UNIT_HEALTH(event, unit)
		hp = UnitHealth("boss1") / UnitHealthMax("boss1") * 100
		if self:UnitBuff("boss1", 227338) and StageCount == 1 then
			self:Bar("stages", ceil((100 - hp) / 2), self:SpellName(227474), 164558) -- Dismounted
		end
	end
	function mod:UNIT_AURA(_, unit)
		if StageCount == 2 then
			return
		elseif self:UnitBuff("boss1", 227338) and StageCount == 0 then
			self:Message("stages", "Neutral", "Long", self:SpellName(227338), 164558)
			self:Bar("stages", ceil((100 - hp) / 2), self:SpellName(227474), 164558) -- Dismounted
			self:Bar(227493, 10)
			self:Bar(228852, 18)
			self:StopBar(227404)
			self:StopBar(227363)
			self:StopBar(227365)
			StageCount = 1
			SpectralCount = 1
		elseif not self:UnitBuff("boss1", 227338) and StageCount == 1 then
			self:Message("stages", "Neutral", "Long", self:SpellName(227584), 164493) -- Mounted
			self:StopBar(227493)
			self:StopBar(228852)
			self:Bar(227365, 2)
			self:Bar(227404, 5)
			self:ScheduleTimer("timer", 2)
			SpectralCount = 0
			StageCount = 0
		end
	end
end

function mod:MightyStomp(args)
	self:Bar(227363, 14)
	self:StopBar(227493)
	self:StopBar(228852)
end

function mod:Mezair(args)
	self:StopBar(227404) -- Intangible Presence
end
