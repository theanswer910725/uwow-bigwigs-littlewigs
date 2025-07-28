
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Cordana Felsong", 1493, 1470)
if not mod then return end
mod:RegisterEnableMob(95888, 100525, 100364)
mod.engageId = 1818

--------------------------------------------------------------------------------
-- Locals
--

local warnedForStealLight = nil
local warnedForCreepingDoom = nil
local Shadows = 0
local CreepingDoomCount = 0
local FelGlaiveCount = 0
local mobCollector = {}

local MobsMarks = { [8] = true, [7] = true, [6] = true, [5] = true }
local MobsMarked = {}

local timers1 = {15.7, 7.2, 12.1, 7.2, 7.2, 7.2, 7.2, 7.2, 7.2, 7.2, 7.2, 7.2, 7.2, 7.2, 7.2, 7.2, 7.2, 7.2, 7.2, 7.2, 7.2, 7.2, 7.2, 7.2}
local timers2 = {52.8, 11.2, 7, 14.5, 8.7, 7.2, 11.7, 7.3, 7.2, 7.3, 15.8, 7.2, 7.3, 7.2, 7.2, 7.4, 13.2, 13.2, 7.2, 7.2, 7.3, 7.3, 7.4, 13.1, 17, 7.4}
--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.kick_combo = "Kick Combo"
	L.kick_combo_desc = "{197251}\n{197250}" -- Knockdown Kick & Turn Kick
	L.kick_combo_icon = 197251

	L.light_dropped = "%s dropped the Light."
	L.light_picked = "%s picked up the Light."

	L.warmup_text = "Cordana Felsong Active"
	L.warmup_trigger = "I have what I was after. But I stayed just so that I could put an end to you... once and for all!"
	L.warmup_trigger_2 = "And now you fools have fallen into my trap. Let's see how you fare in the dark."
	L.warmup_trigger_3 = "How utterly predictable! I knew that you would come."
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"warmup",
		MobsMarker,
		197333, -- Fel Glaive
		{206567, "FLASH"}, -- Stolen Light
		{197422, "FLASH"}, -- Creeping Doom
		197796, -- Avatar of Vengeance
		"kick_combo",
		{204481, "SAY"}, -- Elune's Light
		192750, -- Veiled in Shadow
		213583, 213576 -- Deepening Shadows
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("CHAT_MSG_MONSTER_SAY", "Warmup")
	self:RegisterEvent("CHAT_MSG_MONSTER_YELL", "Warmup")
	self:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED")
	self:Log("SPELL_CAST_SUCCESS", "ElunesLight", 204481)
	self:Log("SPELL_CAST_SUCCESS", "FelGlaive", 197333)
	self:Log("SPELL_AURA_APPLIED", "StolenLight", 206567)
	self:Log("SPELL_AURA_REMOVED", "StolenLightRemoved", 206567)
	self:Log("SPELL_CAST_START", "CreepingDoom", 197422, 213685)
	self:Log("SPELL_AURA_REMOVED", "CreepingDoomRemoved", 197422)
	self:Log("SPELL_CAST_START", "KnockdownKick", 197251) -- used for kick_combo
	self:Death("AvatarDeath", 100351)
	self:RegisterUnitEvent("UNIT_HEALTH_FREQUENT", nil, "boss1")
	self:RegisterEvent("LEARNED_SPELL_IN_TAB")
	
	self:Death("MobsDeath", 109077, 100351, 104293)
	self:RegisterTargetEvents("MobsMark")
	wipe(MobsMarked)
end

function mod:OnEngage()
	self:CDBar("kick_combo", 8.4, L.kick_combo, L.kick_combo_icon)
	self:Bar(213583, 10.5)
	self:Bar(197333, 15.7)
	FelGlaiveCount = 1
	self:ScheduleTimer("FelGlaiveCast", timers1[FelGlaiveCount])
	warnedForStealLight = nil
	warnedForCreepingDoom = nil
	Shadows = 0
	Casttwo = 0
	CreepingDoomCount = 0
	MobsMarked = {}
	MobsMarks = { [8] = true, [7] = true, [6] = true, [5] = true }
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:MobsMark(event, unit, guid)
	if (self:MobId(guid) == 109077 or self:MobId(guid) == 100351 or self:MobId(guid) == 104293) and not MobsMarked[guid] then
		local icon = next(MobsMarks)
		if icon then
			SetRaidTarget(unit, icon)
			MobsMarks[icon] = nil
			MobsMarked[guid] = icon
		end
	end
end

function mod:MobsDeath(args)
	if MobsMarked[args.destGUID] then
		MobsMarks[MobsMarked[args.destGUID]] = true
	end
end

function mod:FelGlaiveCast()
	if CreepingDoomCount == 0 then
		FelGlaiveCount = FelGlaiveCount + 1
		self:CDBar(197333, timers1[FelGlaiveCount])
		self:Message(197333, "Important", "Alert")
		timer1 = self:ScheduleTimer("FelGlaiveCast", timers1[FelGlaiveCount])
	elseif CreepingDoomCount == 1 then
		FelGlaiveCount = FelGlaiveCount + 1
		self:CDBar(197333, timers2[FelGlaiveCount])
		self:Message(197333, "Important", "Alert")
		timer2 = self:ScheduleTimer("FelGlaiveCast", timers2[FelGlaiveCount])
	end
end

function mod:StolenLight(args)
	local mobId = self:MobId(args.destGUID)
	self:TargetMessage(args.spellId, args.destName, "Urgent", "Alarm")
	if self:Me(args.destGUID) then
		self:Flash(args.spellId)
	elseif mobId == 104293 then
		self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT")
		self:CancelTimer(timer1)
		self:StopBar(197333)
		self:StopBar(213583)
	end
	self:StopBar(L.kick_combo)
end

function mod:INSTANCE_ENCOUNTER_ENGAGE_UNIT()
	self:CancelTimer(timer1)
	self:Bar(197333, 33.6)
	self:ScheduleTimer("Message", 33.6, 197333, "Important", "Alert")
	self:CDBar("kick_combo", 11, L.kick_combo, L.kick_combo_icon)
	self:UnregisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT")
end

function mod:LEARNED_SPELL_IN_TAB(_, _, _, _, spellGUID, spellId)
	if IsSpellKnown(204481) then
		self:Message(204481, "Positive", "Long", L.light_picked:format(self:ColorName(self:UnitName("player"))))
		self:Say(204481)
	end
end

function mod:Warmup(event, msg)
	if msg == L.warmup_trigger then
		self:Bar("warmup", 16.2, L.warmup_text, "achievement_dungeon_vaultofthewardens")
	elseif msg == L.warmup_trigger_2 then
		self:UnregisterEvent(event)
		self:Bar("warmup", 3.4, L.warmup_text, "achievement_dungeon_vaultofthewardens")
	elseif msg == L.warmup_trigger_3 then
		self:Bar("warmup", 23.2, L.warmup_text, "achievement_dungeon_vaultofthewardens")
	end
end

do
	local prev, prevGUID = 0, nil
	function mod:UNIT_SPELLCAST_SUCCEEDED(_, unit, spellName, _, castGUID, spellId)
		if unit == "boss1" then
			if spellId == 197796 then -- Avatar of Vengeance
				self:Message(spellId, "Urgent", "Long")
				self:Bar(spellId, 45)
			elseif spellId == 213583 or spellId == 197578 or spellId == 226312 or spellId == 213576 then -- Deepening Shadows
				local t = GetTime()
				if t-prev > 2 and Shadows == 0 then
					prev = t
					self:Bar(213583, 30.5)
					self:Message(213583, "Attention", "Alarm")
				elseif t-prev > 2 then
					prev = t
					self:Message(213583, "Attention", "Alarm")
				end
			end
		elseif spellId == 228210 and castGUID ~= prevGUID then -- Elune's Light picked up
			prevGUID = castGUID
			self:Message(204481, "Positive", "Long", L.light_picked:format(self:ColorName(self:UnitName(unit))))
		end
	end
end

function mod:ElunesLight(args)
	self:Message(args.spellId, "Neutral", "Long", L.light_dropped:format(self:ColorName(args.sourceName)))
end

function mod:FelGlaive(args)
	self:Message(args.spellId, "Important", "Alert")
end

function mod:StolenLightRemoved(args)
	self:Message(args.spellId, "Neutral", "Info", CL.removed:format(args.spellName))
end

function mod:CreepingDoom(args)
	self:Message(197422, "Important", "Info", CL.incoming:format(args.spellName))
	self:Flash(197422)
	if args.spellId == 197422 then
		self:StopBar(L.kick_combo)
		self:Bar(197422, 35, CL.cast:format(args.spellName))
		self:CancelTimer(timer1)
		self:CancelTimer(timer2)
		self:StopBar(197333)
		if CreepingDoomCount == 0 then
			FelGlaiveCount = 1
			CreepingDoomCount = 1
			timer2 = self:ScheduleTimer("FelGlaiveCast", timers2[FelGlaiveCount])
		end
	elseif Shadows == 3 and Casttwo == 0 then
		self:CDBar("kick_combo", 12, L.kick_combo, L.kick_combo_icon)
		self:Bar(213583, 14.5) -- Deepening Shadows
		self:Bar(197796, 17.2) -- Avatar of Vengeance
		self:ScheduleTimer("Bar", 17.2, 197796, 44.3) -- Avatar of Vengeance
		self:Bar(197422, 64)
		Casttwo = 1
	elseif Shadows == 3 and Casttwo == 1 then
		self:Bar(213583, 10.8) -- Deepening Shadows
		self:CDBar("kick_combo", 13.3, L.kick_combo, L.kick_combo_icon)
		self:Bar(197796, 42.2) -- Avatar of Vengeance
		self:ScheduleTimer("Bar", 42.2, 197796, 44.2) -- Avatar of Vengeance
		self:Bar(197422, 64)
		Casttwo = 2
	elseif Shadows == 3 and Casttwo == 2 then
		self:CDBar("kick_combo", 12.1, L.kick_combo, L.kick_combo_icon)
		self:Bar(213583, 14.5) -- Deepening Shadows
		self:Bar(197796, 22.4) -- Avatar of Vengeance
		self:ScheduleTimer("Bar", 22.4, 197796, 53.7) -- Avatar of Vengeance
		self:Bar(197422, 64)
		Casttwo = 3
	elseif Shadows == 3 and Casttwo == 3 then
		self:ScheduleTimer("Message", 13.3, 197333, "Important", "Alert")
		self:Bar(213583, 10.8) -- Deepening Shadows
		self:Bar(197796, 12.1) -- Avatar of Vengeance
		self:ScheduleTimer("Bar", 12.1, 197796, 88.1) -- Avatar of Vengeance
		self:Bar(197333, 13.3) -- Fel Glaive
		self:CDBar("kick_combo", 14.5, L.kick_combo, L.kick_combo_icon)
		self:Bar(197422, 64)
		Casttwo = 4
	elseif Shadows == 3 and Casttwo == 4 then
		self:ScheduleTimer("Message", 11, 197333, "Important", "Alert")
		self:Bar(197333, 11) -- Fel Glaive
		self:CDBar("kick_combo", 12, L.kick_combo, L.kick_combo_icon)
		self:Bar(213583, 14.5) -- Deepening Shadows
		self:Bar(197796, 36.2) -- Avatar of Vengeance
		self:ScheduleTimer("Bar", 36.2, 197796, 45) -- Avatar of Vengeance
		self:Bar(197422, 64)
		Casttwo = 5
	elseif Shadows == 3 and Casttwo == 5 then
		self:ScheduleTimer("Message", 12.1, 197333, "Important", "Alert")
		self:Bar(213583, 10.8) -- Deepening Shadows
		self:Bar(197333, 12.1) -- Fel Glaive
		self:CDBar("kick_combo", 13.3, L.kick_combo, L.kick_combo_icon)
		self:Bar(197796, 17.2) -- Avatar of Vengeance
		self:ScheduleTimer("Bar", 17.2, 197796,  61.7) -- Avatar of Vengeance
		self:Bar(197422, 64)
		Casttwo = 6
	elseif Shadows == 3 and Casttwo == 6 then
		self:ScheduleTimer("Message", 10.8, 197333, "Important", "Alert")
		self:Bar(197333, 10.8) -- Fel Glaive
		self:CDBar("kick_combo", 12.1, L.kick_combo, L.kick_combo_icon)
		self:Bar(213583, 14.5) -- Deepening Shadows
		self:Bar(197796, 42.2) -- Avatar of Vengeance
		self:Bar(197422, 64)
		-- YOU WILL DIE !
		Casttwo = 3
	end
end

function mod:CreepingDoomRemoved(args)
	self:Message(args.spellId, "Neutral", "Info", CL.over:format(args.spellName))
	self:Bar(213583, 11.5) -- Deepening Shadows
	self:Bar(197796, 12.7) -- Avatar of Vengeance
	self:ScheduleTimer("Bar", 12.7, 197796, 44.5) -- Avatar of Vengeance
	self:Bar(197333, 17.7) -- Fel Glaive
	self:Bar(197422, 40)
	self:CDBar("kick_combo", 22.8, L.kick_combo, L.kick_combo_icon)
end

function mod:KnockdownKick(args)
	self:Message("kick_combo", "Attention", self:Tank() and "Warning", L.kick_combo, L.kick_combo_icon)
	if Shadows == 0 then
		self:CDBar("kick_combo", 21, L.kick_combo, L.kick_combo_icon)
	elseif Shadows == 1 then
		self:CDBar("kick_combo", 15.5, L.kick_combo, L.kick_combo_icon)
	elseif Shadows == 3 then
		self:CDBar("kick_combo", 21, L.kick_combo, L.kick_combo_icon)
	end
end

function mod:AvatarDeath()
	self:Message(197796, "Positive", "Long", CL.removed:format(self:SpellName(205004))) -- Vengeance removed
end

function mod:UNIT_HEALTH_FREQUENT(unit)
	local hp = UnitHealth(unit) / UnitHealthMax(unit) * 100
	if hp < 80 and not warnedForStealLight then
		warnedForStealLight = true
		self:Message(206567, "Attention", nil, CL.soon:format(self:SpellName(206387))) -- Steal Light soon
		Shadows = 1
	elseif hp < 45 and not warnedForCreepingDoom then
		warnedForCreepingDoom = true
		self:Message(197422, "Important", nil, CL.soon:format(self:SpellName(197422))) -- Creeping Doom soon
		self:UnregisterUnitEvent("UNIT_HEALTH_FREQUENT", unit)
		Shadows = 3
	end
end
