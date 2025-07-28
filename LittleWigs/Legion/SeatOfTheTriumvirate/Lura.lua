
--------------------------------------------------------------------------------
-- TODO:
-- -- Improve timers, especially initial timers when entering last phase (after Naaru's Lament)
-- -- Check if any (important) abilities are missing

--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("L'ura", 1753, 1982)
if not mod then return end
mod:RegisterEnableMob(124729) -- L'ura
mod.engageId = 2068

local Fragment = 0
local WardenMarked = {}
--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.warmup_text = "L'ura Active"
	L.warmup_trigger = "Such chaos... such anguish. I have never sensed anything like it before."
	L.warmup_trigger_2 = "Such musings can wait, though. This entity must die."
	L.warmup_trigger_3 = "Incoming!"
	L.warmup_trigger_4 = "Look out!"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"warmup",
		247795, -- Call to the Void
		248535, -- Naaru's Lament
		247930, -- Umbral Cadence
		245164, -- Fragment of Despair
		247816, -- Backlash
		249009, -- Grand Shift
		WardenMarker,
	},{
		[249009] = "mythic",
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("CHAT_MSG_MONSTER_SAY", "Warmup")
	self:RegisterEvent("CHAT_MSG_MONSTER_YELL", "Warmup")
	self:Log("SPELL_CAST_START", "CalltotheVoid", 247795)
	self:Log("SPELL_AURA_APPLIED", "NaarusLament", 248535)
	self:Log("SPELL_CAST_SUCCESS", "UmbralCadence", 247930)
	self:Log("SPELL_CAST_SUCCESS", "FragmentofDespair", 245164)
	self:Log("SPELL_AURA_APPLIED", "Backlash", 247816)

	--[[ Mythic ]]--
	self:Log("SPELL_CAST_START", "GrandShift", 249009)
	self:Death("WardenDeath", 124745)
	self:RegisterTargetEvents("WardenMark")
	wipe(WardenMarked)
end

function mod:OnEngage()
	wipe(WardenMarked)
	WardenMarks = { [8] = true, [7] = true }
	Fragment = 0
	-- Nothing?
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:WardenMark(event, unit, guid)
	if self:MobId(guid) == 124745 and not WardenMarked[guid] then
		local icon = next(WardenMarks)
		if icon then
			SetRaidTarget(unit, icon)
			WardenMarks[icon] = nil
			WardenMarked[guid] = icon
		end
	end
end

function mod:WardenDeath(args)
	if WardenMarked[args.destGUID] then
		WardenMarks[WardenMarked[args.destGUID]] = true
	end
end

function mod:Warmup(_, msg, event)
	if msg == L.warmup_trigger then
		self:Bar("warmup", 32.2, L.warmup_text, "spell_priest_divinestar_shadow")
	elseif msg == L.warmup_trigger_2 then
		self:Bar("warmup", 8.47, L.warmup_text, "spell_priest_divinestar_shadow")
	elseif msg == L.warmup_trigger_3 then
		self:Bar("warmup", 6.47, L.warmup_text, "spell_priest_divinestar_shadow")
	elseif msg == L.warmup_trigger_4 then
		self:Bar("warmup", 6.1, L.warmup_text, "spell_priest_divinestar_shadow")
	elseif msg:find(L.warmup_trigger, nil, true) then
		self:Bar("warmup", 32.2, L.warmup_text, "spell_priest_divinestar_shadow")
	elseif msg:find(L.warmup_trigger_2, nil, true) then
		self:Bar("warmup", 8.47, L.warmup_text, "spell_priest_divinestar_shadow")
	elseif msg:find(L.warmup_trigger_3, nil, true) then
		self:Bar("warmup", 6.47, L.warmup_text, "spell_priest_divinestar_shadow")
	elseif msg:find(L.warmup_trigger_4, nil, true) then
		self:Bar("warmup", 6.1, L.warmup_text, "spell_priest_divinestar_shadow")
	end
end

function mod:CalltotheVoid(args)
	self:Message(args.spellId, "Important", "Warning")
	self:CDBar(245164, 11) -- Fragment of Despair
end

function mod:NaarusLament(args)
	self:Message(args.spellId, "Neutral", "Info")
end

function mod:UmbralCadence(args)
	self:Message(args.spellId, "Attention", "Alert")
	self:CDBar(args.spellId, 10.5)
end

function mod:FragmentofDespair(args)
	self:Message(args.spellId, "Important", "Warning", CL.incoming:format(args.spellName))
	if Fragment == 0 then
		self:CDBar(245164, 10)
		Fragment = 1
	elseif Fragment == 1 then
		self:CastBar(245164, 10)
		Fragment = 0
	end
end

function mod:Backlash(args)
	self:Message(args.spellId, "Positive", "Long")
	self:Bar(args.spellId, 12.5)
	self:RegisterTargetEvents("SkitterMark")
end

function mod:GrandShift(args)
	self:Message(args.spellId, "Urgent", "Alarm")
	self:Bar(args.spellId, 14.5)
end
