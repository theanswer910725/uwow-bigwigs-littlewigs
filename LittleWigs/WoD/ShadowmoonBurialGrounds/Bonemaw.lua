
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Bonemaw", 1176, 1140)
if not mod then return end
mod:RegisterEnableMob(75452) -- Bonemaw
mod.engageId = 1679

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.summon_worms = "Summon Carrion Worms"
	L.summon_worms_desc = "Bonemaw summons two Carrion Worms."
	L.summon_worms_icon = "ability_hunter_pet_worm"
	L.summon_worms_trigger = "piercing screech attracts nearby Carrion Worms!"

	L.submerge = "Submerge"
	L.submerge_desc = "Bonemaw submerges and repositions."
	L.submerge_icon = "misc_arrowdown"
	L.submerge_trigger = "hisses, slinking back into the shadowy depths!"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		165578, -- Corpse Breath
		154175, -- Body Slam
		{153804, "FLASH"}, -- Inhale
		"summon_worms",
		"submerge",
	}, nil, {
		["summon_worms"] = CL.adds,
	}
end

function mod:OnBossEnable()
	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", "InhaleIncUnitEvent", "boss1")
	self:RegisterEvent("CHAT_MSG_RAID_BOSS_EMOTE")
	self:Log("SPELL_CAST_START", "CorpseBreath", 165578)
	self:Log("SPELL_CAST_START", "BodySlam", 154175)
	self:Log("SPELL_CAST_SUCCESS", "Inhale", 153804)
	self:Log("SPELL_AURA_REMOVED", "InhaleOver", 153804)
end

function mod:OnEngage()
	self:CDBar(165578, 5.9) -- Corpse Breath
	self:CDBar(153804, 16.35) -- Inhale
	self:Bar("summon_worms", 36, CL.spawning:format(CL.adds), L.summon_worms_icon)
	self:CDBar(154175, 30.88) -- Body Slam
	self:Bar("submerge", 65.2, L.submerge, L.submerge_icon)
	CorpseBreathFirst = true
	InhaleFirst = true
	BodySlamFirst = true
	submergeFirst = true
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:InhaleIncUnitEvent(event, unit, _, spellId)
	if spellId == 154868 then
		-- unit event is 1s faster than emote (and the first emote is 1s late),
		-- but the unit event only fires for the first Inhale.
		self:InhaleInc()
		self:UnregisterUnitEvent(event, unit)
	end
end

function mod:CHAT_MSG_RAID_BOSS_EMOTE(_, msg)
	-- %s's piercing screech attracts nearby Carrion Worms!
	if msg:find(L.summon_worms_trigger, nil, true) then
		self:Message("summon_worms", "Neutral", "Info", CL.spawning:format(CL.adds), L.summon_worms_icon)
		self:StopBar(CL.spawning:format(CL.adds))
		BodySlamFirst = false
		self:CDBar(154175, 4)
		self:CDBar(165578, 8)
		self:CDBar(153804, 17)
		return
	end

	-- %s hisses, slinking back into the shadowy depths!
	if msg:find(L.submerge_trigger, nil, true) then
		self:Message("submerge", "Neutral", "info", L.submerge, L.submerge_icon)
			if submergeFirst then
				self:Bar("submerge", 44.5, L.submerge, L.submerge_icon)
				submergeFirst = false
			else
				self:Bar("submerge", 44.5, L.submerge, L.submerge_icon)
			end
				self:CDBar(154175, 12)
				self:CDBar(165578, 17.5)
				self:CDBar(153804, 27.5)
		return
	end

	-- %s begins to |cFFFF0404|Hspell:153804|h[Inhale]|h|r his enemies!
	if msg:find("153804", nil, true) then -- Inhale
		self:InhaleInc()
		return
	end
end

function mod:CorpseBreath(args)
	if CorpseBreathFirst then
		self:CDBar(args.spellId, 38.6)
		CorpseBreathFirst = false
	else
		self:CDBar(args.spellId, 44.5)
	end
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "Alert")
end

do
	local prev = 0
	function mod:BodySlam(args)
		local t = GetTime()
		if t - prev > 1 then
			prev = t
			self:Message(args.spellId, "Attention", "Alert")
		end
		if self:MobId(args.sourceGUID) == 75452 then
			if BodySlamFirst then
				self:CDBar(args.spellId, 8.5)
				BodySlamFirst = false
			else
				self:CDBar(args.spellId, 44.5)
			end
		end
	end
end

do
	local prev = 0
	function mod:InhaleInc()
		local t = GetTime()
		if t - prev > 5 then
			prev = t
			self:Message(153804, "Urgent", "Warning", CL.incoming:format(self:SpellName(153804)))
			self:Flash(153804)
			if InhaleFirst then
				self:CDBar(153804, 37.6)
				InhaleFirst = false
			else
				self:CDBar(153804, 44.5)
			end
		end
	end
end

function mod:Inhale(args)
	self:Message(args.spellId, "Urgent", "Alarm")
	self:CastBar(args.spellId, 9)
	if self:BarTimeLeft(CL.cast:format(self:SpellName(153804))) > self:BarTimeLeft(L.submerge) then
		self:Bar("submerge", self:BarTimeLeft(CL.cast:format(self:SpellName(153804)))+4, L.submerge, L.submerge_icon)
	end
end

function mod:InhaleOver(args)
	self:Message(args.spellId, "Positive", "Info", CL.over:format(args.spellName))
end
