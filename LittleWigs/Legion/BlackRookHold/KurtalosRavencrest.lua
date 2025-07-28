--------------------------------------------------------------------------------
-- Module Declaration
--

--TO DO List
--Timers work fine couldnt test Say mechanic stinging swarm due to rng targetting.
local mod, CL = BigWigs:NewBoss("Kurtalos Ravencrest", 1501, 1672)
if not mod then return end
mod:RegisterEnableMob(98965,98970)

--------------------------------------------------------------------------------
-- Locals
--

local shadowBoltCount = 1
local unerringShearCount = 1
local mobCollector = {}

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.phase_2_trigger = "Enough! I tire of this."
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"stages",
		{198635, "TANK"}, -- Unerring Sheer
		198820, -- Dark Blast
		{198641, "SAY", "ICON"}, -- Whirling Blade
		{201733, "SAY", "ICON"}, -- Stinging Swarm
		199193, -- Dreadlords Guise
		{202019, "FLASH"}, -- Shadow Bolt Volley
		199143, -- Cloud of Hypnosis
		}, {
		[198635] = -12502, -- Stage One: Lord of the Keep
		[201733] = -12509, -- Stage Two: Vengeance of the Ancients
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_SUCCESS", "UnerringSheer", 198635)
	self:Log("SPELL_CAST_START", "DarkBlast", 198820)
	self:Log("SPELL_CAST_START", "WhirlingBlade", 198641)
	self:Log("SPELL_CAST_SUCCESS", "WhirlingBladeEnd", 198641)
	self:Log("SPELL_CAST_START", "ShadowBoltValley", 202019) -- First one only
	self:Log("SPELL_CAST_START", "StingingSwarm", 201733)
	self:Log("SPELL_CAST_SUCCESS", "CloudOfHypnosis", 199143)
	self:Log("SPELL_CAST_START", "DreadlordsGuise", 199193)
	self:Log("SPELL_AURA_APPLIED", "StingingSwarmApplied", 201733)
	self:Log("SPELL_CAST_SUCCESS", "StingingSwarmEnd", 201733)
	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")
	self:RegisterUnitEvent("UNIT_SPELLCAST_STOP", nil, "boss1")
	self:RegisterEvent("CHAT_MSG_MONSTER_SAY")
	self:Death("KurtalosDeath", 98965)
	self:Death("Win", 98970)
	self:RegisterTargetEvents("CheckTargets")
	self:RegisterEvent("UNIT_HEALTH_FREQUENT", "CheckTargets")
end

function mod:OnEngage()
	shadowBoltCount = 1
	unerringShearCount = 1
	self:CDBar(198635, 5.9, CL.count:format(self:SpellName(198635), unerringShearCount))
	self:CDBar(198641, 11) -- Whirling Blade
	self:CDBar(198820, 12) -- Dark Blast
end

--------------------------------------------------------------------------------
-- Event Handlers
--

do
	function mod:CheckTargets(event, unit, guid, name)
		local guid = UnitGUID(unit)
		local n = self:UnitName(unit)
		local hp = UnitHealth(unit) / UnitHealthMax(unit) * 100
		if self:MobId(guid) == 98965 and UnitAffectingCombat(unit) and not mobCollector[guid] and hp < 21 then
			mobCollector[guid] = true
			self:StopBar(CL.count:format(self:SpellName(198635), unerringShearCount)) -- Unerring Shear
			self:StopBar(198641) -- Whirling Blade
			self:StopBar(198820) -- Dark Blast
			self:UnregisterEvent("CheckTargets")
			self:UnregisterEvent("CHAT_MSG_MONSTER_SAY")
		end
	end
end

function mod:CHAT_MSG_MONSTER_SAY(event, msg)
	if msg == L.phase_2_trigger then
		self:UnregisterEvent(event)
		self:UnregisterEvent("CheckTargets")
		self:UnregisterEvent("CHAT_MSG_MONSTER_SAY")
		self:StopBar(CL.count:format(self:SpellName(198635), unerringShearCount)) -- Unerring Shear
		self:StopBar(198641) -- Whirling Blade
		self:StopBar(198820) -- Dark Blast
	end
end

function mod:DarkBlast(args)
	if shadowBoltCount == 1 then
		self:Bar(args.spellId, 17.5)
	end
	self:Message(args.spellId, "Attention", "Warning", CL.incoming:format(args.spellName))
end

function mod:UnerringSheer(args)
	self:StopBar(CL.count:format(args.spellName, unerringShearCount))
	self:Message(args.spellId, "Urgent", "Alert", CL.count:format(args.spellName, unerringShearCount))
	unerringShearCount = unerringShearCount + 1
	self:CDBar(args.spellId, 12, CL.count:format(args.spellName, unerringShearCount))
end

do
	local prev = 0
	local function printTarget(self, name, guid)
		self:PrimaryIcon(198641, name)
		local t = GetTime()
		if self:Me(guid) then
			self:Say(198641)
			prev = t
			self:TargetMessage(198641, name, "Personal", "Bam")
		elseif t-prev > 1.5 then
			prev = t
			self:TargetMessage(198641, name, "Attention", "Info")
		end
	end
	function mod:WhirlingBlade(args)
		self:CDBar(198641, 25) -- Whirling Blade
		self:GetUnitTarget(printTarget, 0.3, args.sourceGUID)
	end
end

function mod:WhirlingBladeEnd(args)
	self:PrimaryIcon(198641, nil)
end

function mod:ShadowBoltValley(args)
	if shadowBoltCount == 1 then
		self:Flash(202019)
		self:Message(args.spellId, "Important", "Warning", CL.incoming:format(args.spellName))
	else
		self:Message(args.spellId, "Attention", "Info", CL.incoming:format(args.spellName))
	end
	self:Bar(args.spellId, 8.5)
	shadowBoltCount = shadowBoltCount + 1
end

function mod:DreadlordsGuise(args)
	self:StopBar(201733) -- Stinging Swarm
	self:StopBar(198641) -- Whirling Blade
	self:StopBar(202019) -- Shadow Bolt Volley
	self:StopBar(199143) -- Cloud of Hypnosis
	self:StopBar(198820) -- Dark Blast
	if mod:Mythic() then
		self:CastBar(199193, 19) -- 27 on normal
		self:Bar(199193, 85)
		self:ScheduleTimer("CDBar", 19, 201733, 15) -- Stinging Swarm
	else
		self:Bar(args.spellId, 27) -- longer than 23 on Norm/hc
	end
end

function mod:CloudOfHypnosis(args)
	self:Bar(args.spellId, 34.7)
end

do
	local prev = 0
	local function printTarget(self, name, guid)
		self:SecondaryIcon(201733, name)
		local t = GetTime()
		if self:Me(guid) then
			prev = t
			self:TargetMessage(201733, name, "Personal", "Bam")
		elseif t-prev > 1.5 then
			prev = t
			self:TargetMessage(201733, name, "Attention", "Info")
		end
	end
	function mod:StingingSwarm(args)
		self:StopBar(198820) -- Dark Blast
		self:CDBar(args.spellId, 20)
		self:GetUnitTarget(printTarget, 0.3, args.sourceGUID)
	end
end

function mod:StingingSwarmEnd(args)
	self:SecondaryIcon(201733, nil)
end

function mod:UNIT_SPELLCAST_STOP(_, _, _, spellId, spellName)
	if spellName == 201733 then
		self:SecondaryIcon(201733, nil)
	end
end

function mod:StingingSwarmApplied(args)
	if self:Me(args.destGUID) then
		self:Say(args.spellId)
	end
	self:RegisterTargetEvents("MarkStingingSwarm")
end

function mod:MarkStingingSwarm(_, unit, guid)
	if self:MobId(guid) == 101008 then -- Stinging Swarm
		SetRaidTarget(unit, 8)
		self:UnregisterTargetEvents()
	end
end

function mod:KurtalosDeath()
	self:Message("stages", "Neutral", "Long", -12509, false)
	self:StopBar(198820) -- Dark Blast
	self:StopBar(198641) -- Whirling Blade
	self:Bar(202019, 19.4) -- Shadow Bolt Volley
	self:CDBar(201733, 26.6)
	self:CDBar(199143, 21.8)
	self:Bar(199193, 40)
end
