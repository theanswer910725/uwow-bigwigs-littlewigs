
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Opera Hall: Westfall Story", 1651, 1826)
if not mod then return end
mod:RegisterEnableMob(114261, 114260, 114265) -- Toe Knee, Mrrgria
mod.engageId = 1957 -- Same for every opera event. So it's basically useless.
mod.respawnTime = 10
--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.warmup_text = "So ya wanna rumble, do ya?"
	L.warmup_trigger = "So ya wanna rumble, do ya?"
end
--------------------------------------------------------------------------------
-- Locals
--
local ToeKnee = true
local Galindre = true
local Babblet = true
local phase = 1
local list = mod:NewTargetList()

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"warmup",
		"stages",
		{227325, "SAY"}, -- Poisonous Shank
		227568, -- Burning Leg Sweep
		{227777, "PROXIMITY", "SAY"}, -- Thunder Ritual
		227783, -- Wash Away
		227453,
	}, {
		[227568] = -14118, -- Toe Knee
		[227777] = -14125, -- Mrrgria
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")
	self:RegisterEvent("CHAT_MSG_RAID_BOSS_EMOTE")
	--self:RegisterEvent("CHAT_MSG_MONSTER_YELL", "Warmup")
	self:Log("SPELL_CAST_START", "BurningLegSweep", 227568)
	self:Log("SPELL_CAST_START", "ThunderRitual", 227777)
	self:Log("SPELL_AURA_APPLIED", "ThunderRitualApplied", 227777)
	self:Log("SPELL_AURA_REMOVED", "ThunderRitualRemoved", 227777)
	self:Log("SPELL_CAST_START", "WashAway", 227783)
	self:Log("SPELL_AURA_APPLIED", "PoisonousShankApplied", 227325)

	self:RegisterEvent("ENCOUNTER_END")
	self:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED")
end

function mod:OnEngage()
	ToeKnee = true
	Galindre = true
	Babblet = true
	phase = 1
	self:ScheduleTimer("PullCheck", 0)
	self:Bar(227568, 10) -- Burning Leg Sweep
	self:Bar(227325, 5) -- Poisonous Shank
	self:Bar(227453, 23.5)
	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT")
	self:RegisterEvent("UNIT_AURA")
end

--------------------------------------------------------------------------------
-- Event Handlers
--


function mod:PullCheck()
	for i = 1, 5 do
		local guid = UnitGUID(("boss%d"):format(i))
		if guid  then
			local mobId = self:MobId(guid)
			if mobId == 114261 and ToeKnee then -- Toe Knee
				self:StopBar(227410) -- Galindre
				self:StopBar(227447) -- Galindre
				self:StopBar(227477) -- Galindre
				self:StopBar(227776) -- Galindre
				self:StopBar(228019) -- Babblet
				self:StopBar(228025) -- Babblet
				ToeKnee = false
			elseif mobId == 114251 and Galindre then -- Galindre
				self:StopBar(227568) -- Toe Knee
				self:StopBar(227325) -- Toe Knee
				self:StopBar(227453) -- Toe Knee
				self:StopBar(228019) -- Babblet
				self:StopBar(228025) -- Babblet
				Galindre = false
			elseif mobId == 114330 and Babblet then -- Babblet
				self:StopBar(227568) -- Toe Knee
				self:StopBar(227325) -- Toe Knee
				self:StopBar(227453) -- Toe Knee
				self:StopBar(227410) -- Galindre
				self:StopBar(227447) -- Galindre
				self:StopBar(227477) -- Galindre
				self:StopBar(227776) -- Galindre
				Babblet = false
			end
		end
	end
end

function mod:ENCOUNTER_END(_, engageId, _, _, _, _, success)
	if engageId == 1957 then
		if success == 0 then
			self:Wipe()
			self:SendMessage("BigWigs_EncounterEnd", self, engageId, self.displayName, self:Difficulty(), 5, success)
		else
			self:Win()
		end
	end
end

do
	local prev = nil
	function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, _, _, spellGUID, spellId)
		if spellId == 227449 and spellGUID ~= prev then
			prev = spellGUID
			self:Message(227453, "Attention", "Alert")
			self:Bar(227453, 30)
		end
	end
end

function mod:Warmup(event, msg)
	if msg == L.warmup_trigger then
		self:Bar(227480, 30, L.warmup_text, "spell_fire_playingwithfire")
		self:Message(227480, "Attention", "Info")
	end
end

do	
	local prev = 0
	function mod:PoisonousShankApplied(args)
		local t = GetTime()
		if (self:Dispeller("poison") or self:Me(args.destGUID)) and t-prev > 7 then
			prev = t
			self:PlaySound(227325, "Bam")
			self:CDBar(227325, 10)
		elseif t-prev > 7 then
			prev = t
			self:CDBar(227325, 10)
		elseif (self:Dispeller("poison") or self:Me(args.destGUID)) and t-prev > 0.1 then
			prev = t
			self:PlaySound(227325, "Bam")
		end
	end
end

do
	local players = {}
	local UnitGUID = UnitGUID
	function mod:UNIT_AURA(_, unit)
		local PoisonousShank = self:UnitDebuff(unit, 227325)
		if PoisonousShank then
			local guid = UnitGUID(unit)
			if not players[guid] then
				players[guid] = true
				if unit == "player" then
					self:Say(227325)
				end
				list[#list+1] = self:UnitName(unit)
				self:TargetsMessage(227325, "green", list, 3)
			end
		elseif players[UnitGUID(unit)] then
			players[UnitGUID(unit)] = nil
		end
	end
end

function mod:INSTANCE_ENCOUNTER_ENGAGE_UNIT()
	local foundMrrgria, foundToeKnee = nil, nil
	for i = 1, 5 do
		local guid = UnitGUID(("boss%d"):format(i))
		if guid  then
			local mobId = self:MobId(guid)
			if mobId == 114260 then -- Mrrgria
				foundMrrgria = true
			elseif mobId == 114261 then -- Toe Knee
				foundToeKnee = true
			end
		end
	end

	if foundMrrgria and phase == 1 then -- Mrrgria
		phase = 2
		self:Message("stages", "Neutral", "Long", CL.stage:format(2), false)
		self:StopBar(227568) -- Burning Leg Sweep
		self:Bar(227777, 8.5) -- Thunder Ritual
		self:Bar(227783, 15.5) -- Wash Away
	elseif foundToeKnee and phase == 2 then -- Toe Knee
		phase = 3
		self:Message("stages", "Neutral", "Long", CL.stage:format(3), false)
		self:Bar(227568, 8) -- Burning Leg Sweep
	end
end

function mod:BurningLegSweep(args)
	self:Message(args.spellId, "Attention", "Alarm")
	self:CDBar(args.spellId, 19)
end

function mod:ThunderRitual(args)
	self:Message(args.spellId, "Important", "Warning")
	self:Bar(args.spellId, 17)
end

function mod:ThunderRitualApplied(args)
	if self:Me(args.destGUID) then
		self:OpenProximity(args.spellId, 5)
		local _, _, duration = self:UnitDebuff("player", args.spellId) -- Random duration
		self:SayCountdown(args.spellId, duration, 8, 3)
		self:TargetBar(args.spellId, duration or 5, args.destName)
	end
end

function mod:ThunderRitualRemoved(args)
	if self:Me(args.destGUID) then
		self:CloseProximity(args.spellId)
		self:CancelSayCountdown(227777)
	end
end

function mod:WashAway(args)
	self:Message(args.spellId, "Urgent", "Info")
	self:Bar(args.spellId, 23)
end
