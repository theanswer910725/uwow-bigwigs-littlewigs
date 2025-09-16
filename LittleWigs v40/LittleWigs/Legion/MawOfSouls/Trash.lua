
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Maw of Souls Trash", 1492)
if not mod then return end
mod.displayName = CL.trash
mod:RegisterEnableMob(
	97200, -- Seacursed Soulkeeper
	99188, -- Waterlogged Soul Guard
	97097, -- Helarjar Champion
	97182, -- Night Watch Mariner
	98919, -- Seacursed Swiftblade
	97365, -- Seacursed Mistmender
	99033, -- Helarjar Mistcaller
	97043, -- Seacursed Slaver
	97185, -- The Grimewalker
	99307 -- Skjal
)

local SeacursedSoulkeeper = false
local SeacursedSlaver = false
local WaterloggedSoulGuard = false
local NightWatchMariner = false
local HelarjarChampion = false
local Skjal = false

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
-- Localization
--

local L = mod:GetLocale()
if L then
	L.soulkeeper = "Seacursed Soulkeeper"
	L.soulguard = "Waterlogged Soul Guard"
	L.champion = "Helarjar Champion"
	L.mariner = "Night Watch Mariner"
	L.swiftblade = "Seacursed Swiftblade"
	L.mistmender = "Seacursed Mistmender"
	L.mistcaller = "Helarjar Mistcaller"
	L.slaver = "Seacursed Slaver"
	L.TheGrimewalker = "The Grimewalker"
	L.skjal = "Skjal"
end

-- Initialization
--

function mod:GetOptions()
	return {
		{200208, "SAY"}, -- Brackwater Blast
		195031, -- Defiant Strike
		{194657, "SAY"}, -- Soul Siphon
		194442, -- Six Pound Barrel
		198405, -- Bone Chilling Scream
		192019, -- Lantern of Darkness
		194615, -- Sea Legs
		199514, -- Torrent of Souls
		199589, -- Whirlpool of Souls
		216197, -- Surging Waters
		194674, -- Barbed Spear
		194099, -- Bile Breath
		195293, -- Debilitating Shout
		{198324, "SAY", "FLASH"}, -- Give No Quarter
		{196885, "SAY", "FLASH"}, -- Give No Quarter
	}, {
		[200208] = L.soulkeeper,
		[194657] = L.soulguard,
		[198405] = L.champion,
		[192019] = L.mariner,
		[194615] = L.swiftblade,
		[199514] = L.mistmender,
		[199589] = L.mistcaller,
		[194674] = L.slaver,
		[194099] = L.TheGrimewalker,
		[195293] = L.skjal,
	}
end

function mod:OnBossEnable()
	self:RegisterMessage("BigWigs_OnBossEngage", "Disable")

	self:Log("SPELL_CAST_START", "Casts", 199514, 199589, 216197)	-- Torrent of Souls, Whirlpool of Souls, Surging Waters
	self:Log("SPELL_CAST_START", "SoulSiphon", 194657)
	self:Log("SPELL_CAST_START", "SixPoundBarrel", 194442)
	self:Log("SPELL_CAST_START", "BileBreath", 194099)
	
	self:Log("SPELL_DAMAGE", "TorrentOfSouls", 199519)
	self:Log("SPELL_MISSED", "TorrentOfSouls", 199519)

	self:Log("SPELL_AURA_APPLIED", "BrackwaterBlastApplied", 200208)
	self:Log("SPELL_AURA_REMOVED", "BrackwaterBlastRemoved", 200208)
	self:Log("SPELL_CAST_START", "DefiantStrike", 195031)
	
	self:Log("SPELL_AURA_APPLIED", "GhostlyRage", 194663)
	self:Log("SPELL_CAST_START", "BoneChillingScream", 198405)
	
	self:Log("SPELL_CAST_START", "BarbedSpear", 194674)

	self:Log("SPELL_AURA_APPLIED", "SeaLegs", 194615)

	self:Log("SPELL_CAST_START", "LanternOfDarkness", 192019)

	self:Log("SPELL_CAST_START", "DebilitatingShout", 195293)
	--self:Log("SPELL_CAST_START", "GiveNoQuarter", 198324)
	self:Log("SPELL_CAST_START", "GiveNoQuarter", 196885)
	self:Log("SPELL_CAST_SUCCESS", "GiveNoQuarterR", 198324) -- the target-selecting instant cast (the real channeling cast is 196885)
	self:Death("SkjalDeath", 99307)
	self:Log("SPELL_DAMAGE", "PullDamage", "*")
	self:Log("SPELL_PERIODIC_DAMAGE", "PullDamage", "*")
	self:Log("RANGE_DAMAGE", "PullDamage", "*")
	self:Log("SWING_DAMAGE", "PullDamage", "*")
	self:RegisterTargetEvents("ForPull")
	self:RegisterEvent("UNIT_COMBAT", "ForPull")
	self:RegisterEvent("UNIT_THREAT_LIST_UPDATE", "ForPull")
	self:RegisterEvent("UNIT_HEALTH_FREQUENT", "ForPull")
	self:RegisterEvent("PLAYER_REGEN_ENABLED", "WipeTimer")
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:PullDamage(args)
	if (self:MobId(args.destGUID) == 97200 or self:MobId(args.sourceGUID) == 97200) and SeacursedSoulkeeper == false then
		self:CDBar(195031, 12)
		SeacursedSoulkeeper = true
	elseif (self:MobId(args.destGUID) == 97043 or self:MobId(args.sourceGUID) == 97043) and SeacursedSlaver == false then
		self:CDBar(194674, 8.6)
		SeacursedSlaver = true
	elseif (self:MobId(args.destGUID) == 99188 or self:MobId(args.sourceGUID) == 99188) and WaterloggedSoulGuard == false then
		self:CDBar(194442, 6.1)
		self:CDBar(194657, 14.5)
		WaterloggedSoulGuard = true
	elseif (self:MobId(args.destGUID) == 97182 or self:MobId(args.sourceGUID) == 97182) and NightWatchMariner == false then
		self:CDBar(192019, 4)
		NightWatchMariner = true
	elseif (self:MobId(args.destGUID) == 97097 or self:MobId(args.sourceGUID) == 97097) and HelarjarChampion == false then
		self:CDBar(198405, 16)
		HelarjarChampion = true
	elseif (self:MobId(args.destGUID) == 99307 or self:MobId(args.sourceGUID) == 99307) and Skjal == false then
		self:CDBar(198324, 8.5)
		self:CDBar(195293, 12)
		Skjal = true
	end
end

do
	local unitTable = {
		"target", "targettarget", "targettargettarget",
		"mouseover", "mouseovertarget", "mouseovertargettarget",
		"focus", "focustarget", "focustargettarget",
		"nameplate1", "nameplate2", "nameplate3", "nameplate4", "nameplate5", "nameplate6", "nameplate7", "nameplate8", "nameplate9", "nameplate10",
		"nameplate11", "nameplate12", "nameplate13", "nameplate14", "nameplate15", "nameplate16", "nameplate17", "nameplate18", "nameplate19", "nameplate20",
		"nameplate21", "nameplate22", "nameplate23", "nameplate24", "nameplate25", "nameplate26", "nameplate27", "nameplate28", "nameplate29", "nameplate30",
		"nameplate31", "nameplate32", "nameplate33", "nameplate34", "nameplate35", "nameplate36", "nameplate37", "nameplate38", "nameplate39", "nameplate40",
		"party1target", "party2target", "party3target", "party4target",
		"raid1target", "raid2target", "raid3target", "raid4target", "raid5target",
		"raid6target", "raid7target", "raid8target", "raid9target", "raid10target",
		"raid11target", "raid12target", "raid13target", "raid14target", "raid15target",
		"raid16target", "raid17target", "raid18target", "raid19target", "raid20target",
		"raid21target", "raid22target", "raid23target", "raid24target", "raid25target",
		"raid26target", "raid27target", "raid28target", "raid29target", "raid30target",
		"raid31target", "raid32target", "raid33target", "raid34target", "raid35target",
		"raid36target", "raid37target", "raid38target", "raid39target", "raid40target"
	}
	function mod:ForPull(event, unit, unitTarget, guid)
		if IsInInstance() then
			if not unit then return end
			local InCombat = UnitAffectingCombat(unit)
			local exists = UnitExists(unit)
			local canAttack = UnitCanAttack("player", unit)
			local hp = UnitHealth(unit) / UnitHealthMax(unit) * 100
			local guid = UnitGUID(unit)
			local unit = unitTable[i]
			if InCombat and exists and canAttack and hp > 90 then
				if self:MobId(guid) == 97200 and SeacursedSoulkeeper == false then
					self:CDBar(195031, 12)
					SeacursedSoulkeeper = true
				elseif self:MobId(guid) == 97043 and SeacursedSlaver == false then
					self:CDBar(194674, 8.6)
					SeacursedSlaver = true
				elseif self:MobId(guid) == 99188 and WaterloggedSoulGuard == false then
					self:CDBar(194442, 6.1)
					self:CDBar(194657, 14.5)
					WaterloggedSoulGuard = true
				elseif self:MobId(guid) == 97182 and NightWatchMariner == false then
					self:CDBar(192019, 4)
					NightWatchMariner = true
				elseif self:MobId(guid) == 97097 and HelarjarChampion == false then
					self:CDBar(198405, 16)
					HelarjarChampion = true
				elseif self:MobId(guid) == 99307 and Skjal == false then
					self:CDBar(198324, 8.5)
					self:CDBar(195293, 12)
					Skjal = true
				end
			end
		end
	end
end

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
				SeacursedSoulkeeper = false
				SeacursedSlaver = false
				WaterloggedSoulGuard = false
				NightWatchMariner = false
				HelarjarChampion = false
				Skjal = false
				self:StopBar(195031)
				self:StopBar(CL.cast:format(self:SpellName(195031)))
				self:StopBar(194674)
				self:StopBar(CL.cast:format(self:SpellName(194674)))
				self:StopBar(194442)
				self:StopBar(CL.cast:format(self:SpellName(194442)))
				self:StopBar(194657)
				self:StopBar(CL.cast:format(self:SpellName(194657)))
				self:StopBar(192019)
				self:StopBar(CL.cast:format(self:SpellName(192019)))
				self:StopBar(198405)
				self:StopBar(CL.cast:format(self:SpellName(198405)))
				self:StopBar(198405)
				self:StopBar(CL.cast:format(self:SpellName(198405)))
				self:StopBar(196885)
				self:StopBar(CL.cast:format(self:SpellName(196885)))
				self:StopBar(194099)
				self:StopBar(CL.cast:format(self:SpellName(194099)))
				self:StopBar(198324)
				self:StopBar(CL.cast:format(self:SpellName(198324)))
				self:StopBar(195293)
				self:StopBar(CL.cast:format(self:SpellName(195293)))
				for i = 1, 8 do
				self:StopBar(CL.count:format(self:SpellName(198405), i))
				self:StopBar(CL.other:format(self:SpellName(198405), mark["{rt" .. i .. "}"]))
				end
			end
		end
	end
	function mod:WipeTimer()
		self:ScheduleTimer("wipeCheck", 0.1)
	end
end



function mod:SkjalDeath(args)
	self:ScheduleTimer("SkjalDeathDelay", 1)
	self:StopBar(196885)
	self:StopBar(CL.cast:format(self:SpellName(196885)))
	self:StopBar(198324)
	self:StopBar(CL.cast:format(self:SpellName(198324)))
	self:StopBar(195293)
	self:StopBar(CL.cast:format(self:SpellName(195293)))
end

function mod:SkjalDeathDelay()
	local HelyaMod = BigWigs:GetBossModule("Helya", true)
	if HelyaMod then
		HelyaMod:Enable()
	end
end

do
	local prevTable = {}
	function mod:Casts(args)
		local t = GetTime()
		if t - (prevTable[args.spellId] or 0) > 1 then
			prevTable[args.spellId] = t
			self:Message(args.spellId, "Urgent", "Alarm")
		end
	end

	function mod:TorrentOfSouls(args)
		if self:Me(args.destGUID) then
			local t = GetTime()
			if t - (prevTable[args.spellId] or 0) > 1.5 then
				prevTable[args.spellId] = t

				local spellId = self:CheckOption(199514, "MESSAGE") and 199514 or 199589 -- both these spells do damage with 199519
				self:Message(spellId, "Personal", "Alert", CL.underyou:format(args.spellName))
			end
		end
	end

	function mod:GhostlyRage(args)
		local t = GetTime()
		if t - (prevTable[args.spellId] or 0) > 1.5 then
			prevTable[args.spellId] = t
			self:Message(198405, "Attention", "Info", CL.soon:format(self:SpellName(5782))) -- Bone Chilling Scream, 5782 = "Fear"
		end
		
		
		local unit = self:GetUnitIdByGUID(args.sourceGUID)
		local raidIndex = unit and GetRaidTargetIndex(unit)
		if raidIndex and raidIndex > 0 then
			self:CDBar(198405, 6, CL.other:format(self:SpellName(198405), mark["{rt" .. raidIndex .. "}"]), 198405)
			self:ScheduleTimer("CDBar", 6, 198405, 18, CL.other:format(self:SpellName(198405), mark["{rt" .. raidIndex .. "}"]), 198405)
			return
		end
		for i = 1, 8 do
			if self:BarTimeLeft(CL.count:format(self:SpellName(198405), i)) < 1 then
				self:Bar(198405, 6, CL.count:format(self:SpellName(198405), i))
				break
			end
		end		
	end

	function mod:BoneChillingScream(args)
		local t = GetTime()
		if t - (prevTable[args.spellId] or 0) > 1 then
			prevTable[args.spellId] = t
			self:Message(args.spellId, "Important", "Warning")
		end
	end

	function mod:SeaLegs(args)
		if self:MobId(args.destGUID) ~= 98919 then return end -- mages can spellsteal it
		-- for casters/hunters it's deflection, for melees it's just dodge chance
		if self:Ranged() or self:Dispeller("magic", true) then
			local t = GetTime()
			if t - (prevTable[args.spellId] or 0) > 1 then
				prevTable[args.spellId] = t
				self:Message(args.spellId, "Attention", "Alarm", CL.other:format(args.spellName, args.destName))
			end
		end
	end
end

do
	local prev = 0
	local function printTarget(self, name, guid)
		local t = GetTime()
		if t-prev > 14 and self:Me(guid) then
			prev = t
			self:TargetMessage(194657, name, "Personal", "Bam")
			self:Say(194657)
			self:CDBar(194657, 17.5)
		elseif t-prev > 14 then
			prev = t
			self:TargetMessage(194657, name, "Urgent", "Alarm")
			self:CDBar(194657, 17.5)
		elseif t-prev > 0.1 and self:Me(guid) then
			self:Say(194657)
			self:TargetMessage(194657, name, "Personal", "Bam")
		elseif t-prev > 0.1 then
			self:TargetMessage(194657, name, "Urgent", "Alarm")
		end
	end
	function mod:SoulSiphon(args)
		self:GetUnitTarget(printTarget, 0.4, args.sourceGUID)
	end
end

do
	local prev = 0
	function mod:BarbedSpear(args)
		local t = GetTime()
		if t-prev > 15.5 then
			prev = t
			self:CDBar(194674, 8.5)
			self:CastBar(194674, 17)
		end
		self:Message(args.spellId, "Urgent", "Warning")
	end
end

do
	local prev = 0
	function mod:DefiantStrike(args)
		local t = GetTime()
		if t-prev > 22 then
			prev = t
			self:Bar(195031, 24)
		end
		self:Message(args.spellId, "Urgent", "Sonar")
	end
end

do
	local prev = 0
	function mod:SixPoundBarrel(args)
		local t = GetTime()
		if t-prev > 14 then
			prev = t
			self:Bar(194442, 17.5)
		end
		self:Message(194442, "Urgent", "Sonar")
	end
end

function mod:BileBreath(args)
	self:Message(args.spellId, "Urgent", "Sonar")
	self:CDBar(args.spellId, 15.7)
end

function mod:LanternOfDarkness(args)
	self:Message(args.spellId, "Attention", "Long")
	self:CastBar(args.spellId, 7)
	self:CDBar(args.spellId, 14.6)
end

function mod:DebilitatingShout(args)
	self:CDBar(args.spellId, 12.5)
	self:CDBar(196885, 4)
	self:Message(args.spellId, "Urgent", "Long")
end

do
	local function printTarget(self, name, guid)
		if self:Me(guid) then
			self:TargetMessage(196885, name, "Important", "Bam")
			self:Flash(196885)
			self:Say(196885)
		else
			self:TargetMessage(196885, name, "Important", "Alarm")
		end
	end

	function mod:GiveNoQuarter(args)
		self:GetUnitTarget(printTarget, 0.1, args.sourceGUID)
		if self:BarTimeLeft(195293) > 0 then
			self:CDBar(args.spellId, self:BarTimeLeft(195293)+4)
		else
			self:CDBar(args.spellId, 9.7)
		end
	end
end

function mod:GiveNoQuarterR(args)
	if self:Me(args.destGUID) then
		self:Say(args.spellId)
		self:Flash(args.spellId)
		self:TargetMessage(args.spellId, args.destName, "Important", "Bam")
	else
		self:TargetMessage(args.spellId, args.destName, "Important", "Alarm", nil, nil, true)
	end
end

function mod:BrackwaterBlastApplied(args)
	if self:Me(args.destGUID) then
		self:Say(args.spellId)
		self:SayCountdown(args.spellId, 3, 8, 2)
	end
	self:TargetMessage(args.spellId, args.destName, "Important", "Bam", nil, nil, self:Dispeller("magic"))
	self:TargetBar(args.spellId, 3, args.destName)
end

function mod:BrackwaterBlastRemoved(args)
	if self:Me(args.destGUID) then
		self:CancelSayCountdown(args.spellId)
	end
	self:StopBar(args.spellId, args.destName)
end
