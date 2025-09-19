--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Darkheart Thicket Trash", 1466)
if not mod then return end
mod.displayName = CL.trash
mod:RegisterEnableMob(
	95771, -- Dreadsoul Ruiner
	99359, -- Rotheart Keeper
	99358, -- Rotheart Dryad
	101679, -- Dreadsoul Poisoner
	95766, -- Crazed Razorbeak
	95779, -- Festerhide Grizzly
	100531, -- Bloodtainted Fury
	113398, -- Bloodtainted Fury
	100527 -- Dreadfire Imp
)

local mark = {
  ["{rt1}"] = "|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_1:0|t",
  ["{rt2}"] = "|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_2:0|t",
  ["{rt3}"] = "|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_3:0|t",
  ["{rt4}"] = "|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_4:0|t",
  ["{rt5}"] = "|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_5:0|t",
  ["{rt6}"] = "|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_6:0|t",
  ["{rt7}"] = "|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_7:0|t",
  ["{rt8}"] = "|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_8:0|t"
}
--------------------------------------------------------------------------------
-- Locals
--

local VileMushroom = 0

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.ruiner = "Dreadsoul Ruiner"
	L.Rotheart = "Rotheart Keeper"
	L.Dryad = "Rotheart Dryad"
	L.poisoner = "Dreadsoul Poisoner"
	L.razorbeak = "Crazed Razorbeak"
	L.grizzly = "Festerhide Grizzly"
	L.fury = "Bloodtainted Fury"
	L.imp = "Dreadfire Imp"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		--[[ Dreadsoul Ruiner ]]--
		200658, -- Star Shower
		
		--[[ Rotheart Keeper ]]--
		198916, -- Vile Mushroom
		
		--[[ Rotheart Dryad ]]--
		{198904, "SAY"}, -- Poison Spear

		--[[ Dreadsoul Poisoner ]]--
		{200684, "SAY"}, -- Nightmare Toxin

		--[[ Crazed Razorbeak ]]--
		200768, -- Propelling Charge

		--[[ Festerhide Grizzly ]]--
		200580, -- Maddening Roar
		218759, -- Corruption Pool
		198408, -- Corruption Pool
		218755, -- Spew Corruption

		--[[ Bloodtainted Fury ]]--
		201226, -- Blood Assault
		201272, -- Blood Bomb
		225562, -- Blood Metamorphosis

		--[[ Dreadfire Imp ]]--
		201399, -- Dread Inferno
	}, {
		[200658] = L.ruiner,
		[198904] = L.Dryad,
		[198916] = L.Rotheart,
		[200684] = L.poisoner,
		[200768] = L.razorbeak,
		[200580] = L.grizzly,
		[201226] = L.fury,
		[201399] = L.imp,
	}
end

function mod:OnBossEnable()
	self:RegisterMessage("BigWigs_OnBossEngage", "Disable")

	--[[ Dreadsoul Ruiner, Dreadfire Imp ]]--
	self:Log("SPELL_CAST_START", "Interrupts", 200658, 201399) -- Star Shower, Dread Inferno

	--[[ Dreadsoul Poisoner ]]--
	self:Log("SPELL_AURA_APPLIED", "NightmareToxinApplied", 200684)
	self:Log("SPELL_AURA_REMOVED", "NightmareToxinRemoved", 200684)
	
	--[[ Rotheart Dryad ]]--
	self:Log("SPELL_AURA_APPLIED", "PoisonSpearApplied", 198904)
	self:Log("SPELL_AURA_REMOVED", "PoisonSpearRemoved", 198904)

	--[[ Crazed Razorbeak, Festerhide Grizzly ]]--
	self:Log("SPELL_CAST_START", "Casts", 200768, 201226, 225562) -- Propelling Charge, Maddening Roar, Blood Assault, Blood Metamorphosis
	self:Log("SPELL_CAST_START", "MaddeningRoar", 200580) --Maddening Roar
	self:Log("SPELL_CAST_SUCCESS", "SpewCorruption", 218755) --Spew Corruption
	
	--[[ Bloodtainted Fury ]]--
	self:Log("SPELL_CAST_SUCCESS", "BloodBomb", 201272)

	--[[ Festerhide Grizzly ]]--
	self:Log("SPELL_AURA_APPLIED", "CorruptionPool", 218759)
	self:Log("SPELL_PERIODIC_DAMAGE", "CorruptionPool", 218759)
	self:Log("SPELL_PERIODIC_MISSED", "CorruptionPool", 218759)
	self:Log("SPELL_AURA_APPLIED", "CorruptionPool", 198408)
	self:Log("SPELL_PERIODIC_DAMAGE", "CorruptionPool", 198408)
	self:Log("SPELL_PERIODIC_MISSED", "CorruptionPool", 198408)
	
	self:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED")
	self:RegisterEvent("PLAYER_REGEN_ENABLED", "WipeTimer")
end

--------------------------------------------------------------------------------
-- Event Handlers
--

do
	function mod:wipeCheck()
		local group = UnitInRaid("player") and "raid" or UnitInParty("player") and "party"
		local members = GetNumGroupMembers()
		local UnitsInCombat = 0
		for i = 1, members, 1 do
			local member = group..tostring(i)
			if UnitAffectingCombat(member) then
				UnitsInCombat = UnitsInCombat + 1
			elseif UnitsInCombat == 0 then
				self:StopBar(200658)
				self:StopBar(CL.cast:format(self:SpellName(200658)))
				self:StopBar(201399)
				self:StopBar(CL.cast:format(self:SpellName(201399)))
				self:StopBar(200684)
				self:StopBar(CL.cast:format(self:SpellName(200684)))
				self:StopBar(198904)
				self:StopBar(CL.cast:format(self:SpellName(198904)))
				self:StopBar(200768)
				self:StopBar(CL.cast:format(self:SpellName(200768)))
				self:StopBar(201226)
				self:StopBar(CL.cast:format(self:SpellName(201226)))
				self:StopBar(225562)
				self:StopBar(CL.cast:format(self:SpellName(225562)))
				self:StopBar(200580)
				self:StopBar(CL.cast:format(self:SpellName(200580)))
				self:StopBar(218755)
				self:StopBar(CL.cast:format(self:SpellName(218755)))
				self:StopBar(201272)
				self:StopBar(CL.cast:format(self:SpellName(201272)))
				self:StopBar(218759)
				self:StopBar(CL.cast:format(self:SpellName(218759)))
				self:StopBar(198408)
				self:StopBar(CL.cast:format(self:SpellName(198408)))
				self:StopBar(198799)
				self:StopBar(CL.cast:format(self:SpellName(198799)))
			end
		end
	end
	function mod:WipeTimer()
		self:ScheduleTimer("wipeCheck", 0.1)
	end
end

do
	local prev = nil
	function mod:UNIT_SPELLCAST_SUCCEEDED(_, unit, _, _, spellGUID, spellId)
		if spellId == 198799 and spellGUID ~= prev then
			prev = spellGUID
			self:Message(198916, "Important", "Long")
			local unit = self:GetUnitIdByGUID(UnitGUID(unit))
			local raidIndex = unit and GetRaidTargetIndex(unit)
			if raidIndex and raidIndex > 0 then
				self:CDBar(198916, 16, CL.other:format(self:SpellName(198916), mark["{rt" .. raidIndex .. "}"]), 198916)
				return
			end
			for i = 1, 8 do
				if self:BarTimeLeft(CL.count:format(self:SpellName(198916), i)) < 1 then
					self:Bar(198916, 16, CL.count:format(self:SpellName(198916), i))
					break
				end
			end
		end	
	end
end

-- Rotheart Dryad

function mod:PoisonSpearApplied(args)
	if self:Me(args.destGUID) then
		self:Say(args.spellId)
	end
	self:TargetMessage(args.spellId, args.destName, "Important", "Bam", nil, nil, self:Dispeller("poison"))
	self:TargetBar(args.spellId, 12, args.destName)
end

function mod:PoisonSpearRemoved(args)
	if self:Me(args.destGUID) then
		self:Message(args.spellId, "Positive", "Info", CL.removed:format(args.spellName))
	end
	self:StopBar(args.spellId, args.destName)
end

do
	local prevTable = {}
	-- Dreadsoul Ruiner, Dreadfire Imp
	function mod:Interrupts(args)
		local t = GetTime()
		if t - (prevTable[args.spellId] or 0) > 1 then
			prevTable[args.spellId] = t
			self:Message(args.spellId, "Attention", self:Interrupter() and "Alarm", CL.casting:format(args.spellName))
		end
	end

	-- Crazed Razorbeak, Festerhide Grizzly, Bloodtainted Fury
	function mod:Casts(args)
		local t = GetTime()
		if t - (prevTable[args.spellId] or 0) > 1 then
			prevTable[args.spellId] = t
			self:Message(args.spellId, "Urgent", "Warning", CL.casting:format(args.spellName))
		end
	end
end

function mod:MaddeningRoar(args)
	self:Message(args.spellId, "Urgent", "Warning", CL.casting:format(args.spellName))
	self:Bar(args.spellId, 26)
end

function mod:SpewCorruption(args)
	self:Message(args.spellId, "Attention", "Alarm", CL.casting:format(args.spellName))
	self:Bar(args.spellId, 26)
end

function mod:NightmareToxinApplied(args)
	if self:Me(args.destGUID) then
		self:Say(args.spellId)
		self:SayCountdown(args.spellId, 3, 8, 2)
	end
	self:TargetMessage(args.spellId, args.destName, "Important", "Bam", nil, nil, self:Dispeller("poison"))
	self:TargetBar(args.spellId, 3, args.destName)
end

function mod:NightmareToxinRemoved(args)
	if self:Me(args.destGUID) then
		self:CancelSayCountdown(args.spellId)
		self:Message(args.spellId, "Positive", "Info", CL.removed:format(args.spellName))
	end
	self:StopBar(args.spellId, args.destName)
end

-- Festerhide Grizzly
do
	local prev = 0
	function mod:CorruptionPool(args)
		if self:Me(args.destGUID) then
			local t = GetTime()
			if t-prev > 1.5 then
				prev = t
				self:Message(args.spellId, "Personal", "Warning", CL.underyou:format(args.spellName))
			end
		end
	end
end

-- Bloodtainted Fury
function mod:BloodBomb(args)
	self:Message(args.spellId, "Urgent", "Alert")
end
