--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Shadowmoon Burial Grounds Trash", 1176)
if not mod then return end
mod.displayName = CL.trash
mod:RegisterEnableMob(
	75713, -- Shadowmoon Bone-Mender
	75715, -- Reanimated Ritual Bones
	75652, -- Void Spawn
	75506, -- Shadowmoon Loyalist
	75451, -- Defiled Spirit
	76446, -- Shadowmoon Dominator
	77700, -- Shadowmoon Exhumer
	75979,
	75979, -- Exhumed Spirit
	76104, -- Monstrous Corpse Spider
	76057  -- Carrion Worm
)

local ShadowmoonBoneMender = false
local ReanimatedRitualBones = false
local VoidSpawn = false
local ShadowmoonLoyalist = false
local DefiledSpirit = false
local ShadowmoonDominator = false
local ShadowmoonExhumer = false
local ExhumedSpirit = false
local MonstrousCorpseSpider = false
local CarrionWorm = false

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
	L.shadowmoon_bonemender = "Shadowmoon Bone-Mender"
	L.reanimated_ritual_bones = "Reanimated Ritual Bones"
	L.void_spawn = "Void Spawn"
	L.shadowmoon_loyalist = "Shadowmoon Loyalist"
	L.defiled_spirit = "Defiled Spirit"
	L.shadowmoon_dominator = "Shadowmoon Dominator"
	L.shadowmoon_exhumer = "Shadowmoon Exhumer"
	L.exhumed_spirit = "Exhumed Spirit"
	L.monstrous_corpse_spider = "Monstrous Corpse Spider"
	L.carrion_worm = "Carrion Worm"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-- Shadowmoon Bone-Mender
		152818, -- Shadow Mend
		{152819, "SAY"}, -- Shadow Word: Frailty
		-- Reanimated Ritual Bones
		{164907, "TANK_HEALER"}, -- Void Slash
		-- Void Spawn
		"warmup",
		152964, -- Void Pulse
		394512, -- Void Eruptions
		-- Shaodwmoon Loyalist
		398151, -- Sinister Focus
		-- Defiled Spirit
		398154, -- Cry of Anguish
		-- Shaodwmoon Dominator
		398150, -- Domination
		154327,
		{156776, "SAY"},
		-- Shadowmoon Exhumer
		153268, -- Exhume the Crypts
		398205,
		-- Exhumed Spirit
		{398206, "SAY"}, -- Death Blast
		-- Monstrous Corpse Spider
		156718, -- Necrotic Burst
		-- Carrion Worm
		{153395, "SAY"}, -- Body Slam
	}, {
		[152818] = L.shadowmoon_bonemender,
		[164907] = L.reanimated_ritual_bones,
		[152964] = L.void_spawn,
		[398151] = L.shadowmoon_loyalist,
		[398154] = L.defiled_spirit,
		[398150] = L.shadowmoon_dominator,
		[153268] = L.shadowmoon_exhumer,
		[398206] = L.exhumed_spirit,
		[156718] = L.monstrous_corpse_spider,
		[153395] = L.carrion_worm,
	}
end

function mod:OnBossEnable()
	-- Shadowmoon Bone-Mender
	self:Log("SPELL_CAST_START", "ShadowMend", 152818)
	self:Log("SPELL_AURA_APPLIED", "ShadowWordFrailtyApplied", 152819)

	-- Reanimated Ritual Bones
	self:Log("SPELL_CAST_START", "VoidSlash", 164907)

	-- Void Spawn
	self:Log("SPELL_CAST_START", "VoidPulse", 152964)
	self:Log("SPELL_CAST_SUCCESS", "VoidEruptions", 394512)

	-- Shadowmoon Loyalist
	self:Log("SPELL_AURA_APPLIED", "SinisterFocusApplied", 398151)

	-- Defiled Spirit
	self:Log("SPELL_CAST_START", "CryOfAnguish", 398154)

	-- Shadowmoon Dominator
	self:Log("SPELL_CAST_START", "Domination", 398150)
	self:Log("SPELL_AURA_APPLIED", "DominationApplied", 154327)
	self:Log("SPELL_CAST_SUCCESS", "RendingVoidlash", 156776)

	-- Shadowmoon Exhumer
	self:Log("SPELL_CAST_START", "ExhumeTheCrypts", 153268)
	self:Log("SPELL_AURA_APPLIED", "Incorporeal", 398205)
	self:Log("SPELL_CAST_SUCCESS", "Incorporeal", 398205)
	-- Exhumed Spirit
	self:Log("SPELL_CAST_START", "DeathBlast", 398206)

	-- Monstrous Corpse Spider
	self:Log("SPELL_CAST_START", "NecroticBurst", 156718)

	-- Carrion Worm
	self:Log("SPELL_CAST_START", "BodySlam", 153395)
	--
	self:Log("SPELL_DAMAGE", "PullDamage", "*")
	self:Log("SPELL_PERIODIC_DAMAGE", "PullDamage", "*")
	self:Log("RANGE_DAMAGE", "PullDamage", "*")
	self:Log("SWING_DAMAGE", "PullDamage", "*")
	self:RegisterTargetEvents("ForPull")
	self:RegisterEvent("UNIT_COMBAT", "ForPull")
	self:RegisterEvent("UNIT_THREAT_LIST_UPDATE", "ForPull")
	self:RegisterEvent("UNIT_HEALTH_FREQUENT", "ForPull")
	self:RegisterEvent("PLAYER_REGEN_ENABLED", "WipeTimer")
	self:RegisterEvent("UNIT_FACTION")
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:PullDamage(args)
	if (self:MobId(args.destGUID) == 75713 or self:MobId(args.sourceGUID) == 75713) and ShadowmoonBoneMender == false then
		self:CDBar(152819, 8)
		ShadowmoonBoneMender = true
	elseif (self:MobId(args.destGUID) == 75715 or self:MobId(args.sourceGUID) == 75715) and ReanimatedRitualBones == false then
		self:CDBar(164907, 3)
		ReanimatedRitualBones = true
	elseif (self:MobId(args.destGUID) == 75652 or self:MobId(args.sourceGUID) == 75652) and VoidSpawn == false then
		self:CDBar(394512, 12)
		self:CDBar(152964, 3.5)
		VoidSpawn = true
	elseif (self:MobId(args.destGUID) == 75506 or self:MobId(args.sourceGUID) == 75506) and ShadowmoonLoyalist == false then
		self:CDBar(398151, 5)
		self:CDBar(398154, 26)
		ShadowmoonLoyalist = true
	elseif (self:MobId(args.destGUID) == 76446 or self:MobId(args.sourceGUID) == 76446) and ShadowmoonDominator == false then
		self:CDBar(398150, 10)
		self:CDBar(156776, 15)
		ShadowmoonDominator = true
	elseif (self:MobId(args.destGUID) == 76104 or self:MobId(args.sourceGUID) == 76104) and MonstrousCorpseSpider == false then
		self:CDBar(156718, 4)
		MonstrousCorpseSpider = true
	elseif (self:MobId(args.destGUID) == 76057 or self:MobId(args.sourceGUID) == 76057) and CarrionWorm == false then
		self:CDBar(153395, 3.5)
		CarrionWorm = true
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
				if self:MobId(guid) == 75713 and ShadowmoonBoneMender == false then
					self:CDBar(152819, 8)
					ShadowmoonBoneMender = true
				elseif self:MobId(guid) == 75715 and ReanimatedRitualBones == false then
					self:CDBar(164907, 3)
					ReanimatedRitualBones = true
				elseif self:MobId(guid) == 75652 and VoidSpawn == false then
					self:CDBar(394512, 12)
					self:CDBar(152964, 3.5)
					VoidSpawn = true
				elseif self:MobId(guid) == 75506 and ShadowmoonLoyalist == false then
					self:CDBar(398151, 5)
					self:CDBar(398154, 26)
					ShadowmoonLoyalist = true
				elseif self:MobId(guid) == 76446 and ShadowmoonDominator == false then
					self:CDBar(398150, 10)
					self:CDBar(156776, 15)
					ShadowmoonDominator = true
				elseif self:MobId(guid) == 76104 and MonstrousCorpseSpider == false then
					self:CDBar(156718, 4)
					MonstrousCorpseSpider = true
				elseif self:MobId(guid) == 76057 and CarrionWorm == false then
					self:CDBar(153395, 3.5)
					CarrionWorm = true
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
				ShadowmoonBoneMender = false
				ReanimatedRitualBones = false
				VoidSpawn = false
				ShadowmoonLoyalist = false
				ShadowmoonDominator = false
				MonstrousCorpseSpider = false
				CarrionWorm = false
				self:StopBar(152819)
				self:StopBar(CL.cast:format(self:SpellName(152819)))
				self:StopBar(164907)
				self:StopBar(CL.cast:format(self:SpellName(164907)))
				self:StopBar(394512)
				self:StopBar(CL.cast:format(self:SpellName(394512)))
				self:StopBar(152964)
				self:StopBar(CL.cast:format(self:SpellName(152964)))
				self:StopBar(398151)
				self:StopBar(CL.cast:format(self:SpellName(398151)))
				self:StopBar(398150)
				self:StopBar(CL.cast:format(self:SpellName(398150)))
				self:StopBar(156776)
				self:StopBar(CL.cast:format(self:SpellName(156776)))
				self:StopBar(CL.count:format(self:SpellName(156776), 2))
				self:StopBar(156718)
				self:StopBar(CL.cast:format(self:SpellName(156718)))
				self:StopBar(153395)
				self:StopBar(CL.cast:format(self:SpellName(153395)))
				self:StopBar(398206)
				self:StopBar(CL.cast:format(self:SpellName(398206)))
				
				for i = 1, 8 do
				self:StopBar(CL.count:format(self:SpellName(156776), i))
				self:StopBar(CL.count:format(self:SpellName(398150), i))
				self:StopBar(CL.count:format(self:SpellName(156718), i))
				self:StopBar(CL.other:format(self:SpellName(156776), mark["{rt" .. i .. "}"]))
				self:StopBar(CL.other:format(self:SpellName(398150), mark["{rt" .. i .. "}"]))
				self:StopBar(CL.other:format(self:SpellName(156718), mark["{rt" .. i .. "}"]))
				end
			end
		end
	end
	function mod:WipeTimer()
		self:ScheduleTimer("wipeCheck", 0.1)
	end
end

-- Shadowmoon Bone-Mender

function mod:ShadowMend(args)
	self:Message(args.spellId, "Urgent", "alert")
end

do
	local prev = 0
	function mod:ShadowWordFrailtyApplied(args)
		local t = GetTime()
		local _, class = UnitClass("player")
		if self:Dispeller("magic") or self:Me(args.destGUID) or class == "WARLOCK" then
			self:TargetMessage(args.spellId, args.destName, "Urgent", "Bam", nil, nil, nil)
			if self:Me(args.destGUID) then
				self:Say(args.spellId)
			end
		end
		if t - prev > 13 then
			prev = t
			self:CDBar(args.spellId, 15.6)
		end
	end
end

-- Reanimated Ritual Bones

function mod:VoidSlash(args)
	if self:Tank() then
		self:Message(args.spellId, "Personal", "Alarm")
		if self:BarTimeLeft(args.spellId) < 2 then
			self:CDBar(args.spellId, 10)
		end
	else
		self:Message(args.spellId, "Personal", "Alert")
	end
end

-- Void Spawn

function mod:VoidPulse(args)
	self:Message(args.spellId, "Important", "Alert", CL.casting:format(args.spellName))
	if self:BarTimeLeft(args.spellId) < 2 and self:BarTimeLeft(394512) < 5 then
		self:CDBar(args.spellId, 10.85)
	elseif self:BarTimeLeft(args.spellId) < 2 and self:BarTimeLeft(394512) < 10 then
		self:CDBar(args.spellId, 15.75)
	else
		self:CDBar(args.spellId, 8.5)
	end
end


function mod:VoidEruptions(args)
	self:Message(args.spellId, "Urgent", "long")
	if self:BarTimeLeft(args.spellId) < 2 then
		self:CDBar(args.spellId, 18.3)
		self:CDBar(152964, 6.23)
	end
end

-- Shadowmoon Loyalist


function mod:SinisterFocusApplied(args)
	local _, class = UnitClass("player")
	if self:Dispeller("magic") or class == "WARLOCK" then
		self:TargetMessage(args.spellId, args.destName, "Urgent", "Alert", nil, nil, nil)
	end
	if self:BarTimeLeft(args.spellId) < 2 then
		self:CDBar(args.spellId, 15.8)
	end
end

-- Defiled Spirit


function mod:CryOfAnguish(args)
	self:Message(args.spellId, "Urgent", "alarm")
	if self:BarTimeLeft(args.spellId) < 2 then
		self:CDBar(args.spellId, 7.5)
	end
end

-- Shadowmoon Dominator


function mod:Domination(args)
	self:Message(args.spellId, "Important", "Alarm", CL.casting:format(args.spellName))
	if self:BarTimeLeft(398150) < 2 then
		self:CDBar(398150, 20)
	end
	
	local unit = self:GetUnitIdByGUID(args.sourceGUID)
    local raidIndex = unit and GetRaidTargetIndex(unit)
    if raidIndex and raidIndex > 0 then
		self:CDBar(156776, 3, CL.other:format(self:SpellName(156776), mark["{rt" .. raidIndex .. "}"]), 156776)
		self:ScheduleTimer("CDBar", 3, 156776, 14, CL.other:format(self:SpellName(156776), mark["{rt" .. raidIndex .. "}"]), 156776)
		return
    end
    for i = 1, 8 do
        if self:BarTimeLeft(CL.count:format(self:SpellName(156776), i)) < 3 then
			self:Bar(156776, 3, CL.count:format(self:SpellName(156776), i))
			self:ScheduleTimer("CDBar", 3, 156776, 14, CL.count:format(self:SpellName(156776), i))
            break
        end
    end
end

function mod:DominationApplied(args)
	local unit = self:GetUnitIdByGUID(args.sourceGUID)
	if unit and UnitAffectingCombat(unit) then
		self:TargetMessage(args.spellId, args.destName, "Important", "Warning", nil, nil, nil)
	end
	if self:Me(args.destGUID) then
		self:Say(args.spellId)
	end
end

do
	local function printTarget(self, name, guid)
		if self:Me(guid) then
			self:Say(156776)
			self:TargetMessage(156776, name, "Personal", "Bam")
		else
			self:TargetMessage(156776, name, "Important", "alarm")
		end
	end
	function mod:RendingVoidlash(args)
		self:GetUnitTarget(printTarget, 0.1, args.sourceGUID)
		
	    local unit = self:GetUnitIdByGUID(args.sourceGUID)
		local raidIndex = unit and GetRaidTargetIndex(unit)
		if raidIndex and raidIndex > 0 then
			self:CDBar(156776, 10, CL.other:format(self:SpellName(156776), mark["{rt" .. raidIndex .. "}"]), 156776)
			return
		end
		for i = 1, 8 do
			if self:BarTimeLeft(CL.count:format(self:SpellName(156776), i)) < 1 then
				self:Bar(156776, 10, CL.count:format(self:SpellName(156776), i))
				break
			end
		end		
	end
end

-- Shadowmoon Exhumer

function mod:ExhumeTheCrypts(args)
	self:Message(args.spellId, "Attention", "Alert", CL.casting:format(args.spellName))
end

do
	local prev = 0
	function mod:Incorporeal(args)
		local t = GetTime()
		if t - prev > 0.5 then
			prev = t
			self:Message(args.spellId, "Urgent", "Warning", CL.other:format(CL.add_spawned, args.spellName))
		end
	end
end

-- Exhumed Spirit

do
	local prev = 0
	local function printTarget(self, name, guid)
		local t = GetTime()
		if self:Me(guid) and t - prev > 1 then
			prev = t
			self:Say(398206)
			self:TargetMessage(398206, name, "Personal", "Bam")
		end
	end
	function mod:DeathBlast(args)
		local t = GetTime()
		self:GetUnitTarget(printTarget, 0.1, args.sourceGUID)
		if self:BarTimeLeft(args.spellId) < 2 then
			self:CDBar(args.spellId, 9)
		end
		if not self:Me(guid) and t - prev > 1 then
			prev = t
			self:Message(args.spellId, "Important", "Warning", CL.casting:format(args.spellName))
		end
	end
end

-- Monstrous Corpse Spider


function mod:NecroticBurst(args)
	self:Message(args.spellId, "Urgent", "Warning", CL.casting:format(args.spellName))
	
	local unit = self:GetUnitIdByGUID(args.sourceGUID)
    local raidIndex = unit and GetRaidTargetIndex(unit)
    if raidIndex and raidIndex > 0 then
        self:CDBar(156718, 20.5, CL.other:format(self:SpellName(156718), mark["{rt" .. raidIndex .. "}"]), 156718)
		return
    end
    for i = 1, 8 do
        if self:BarTimeLeft(CL.count:format(self:SpellName(156718), i)) < 1 then
            self:Bar(156718, 20.5, CL.count:format(self:SpellName(156718), i))
            break
        end
    end
end

-- Carrion Worm

do
	local function printTarget(self, name, guid)
		if self:Me(guid) then
			self:Say(153395)
		end
	end
	function mod:BodySlam(args)
		self:GetUnitTarget(printTarget, 0.1, args.sourceGUID)
		self:Message(args.spellId, "Important", "Alarm")
		if self:BarTimeLeft(args.spellId) < 2 then
			self:CDBar(args.spellId, 15.7)
		end
	end
end

-----------------------------------------------------------------

local lastMobActiveTime = 0
local checkInterval = 1

function mod:mobactive()
    self:Message("warmup", "Neutral", "Long", CL.other:format(CL.big_add, self:SpellName(155524)), 155524)
    self:Bar("warmup", 34.4, CL.big_add, 155524)
end

function mod:UNIT_FACTION(_, unit)
    local npcID = self:MobId(UnitGUID(unit))
    local currentTime = GetTime()

    if npcID == 75652 and (currentTime - lastMobActiveTime) >= checkInterval then
        lastMobActiveTime = currentTime
        mod:mobactive()
    end
end


