--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Eye of Azshara Trash", 1456)
if not mod then return end
mod.displayName = CL.trash
mod:RegisterEnableMob(
	95947, -- Mak'rana Hardshell
	91786, -- Gritslime Snail
	100216, -- Hatecoil Wrangler
	91783, -- Hatecoil Stormweaver
	91782, -- Hatecoil Crusher
	98173, -- Mystic Ssa'veh
	95861, -- Hatecoil Oracle
	91790, -- Mak'rana Siltwalker
	97173, -- Restless Tides
	97171, -- Hatecoil Arcanist
	91787, -- Cove Seagull
	100248, 100249, 100250, 98173 -- Ritualist Lesha
)

local Lesha = false
local Varisz = false
local Ashioi = false
local Ssaveh = false
local Hardshell = false
local Siltwalker = false

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.hardshell = "Mak'rana Hardshell"
	L.gritslime = "Gritslime Snail"
	L.wrangler = "Hatecoil Wrangler"
	L.stormweaver = "Hatecoil Stormweaver"
	L.crusher = "Hatecoil Crusher"
	L.oracle = "Hatecoil Oracle"
	L.siltwalker = "Mak'rana Siltwalker"
	L.tides = "Restless Tides"
	L.CoveSeagull = "Cove Seagull"
	L.arcanist = "Hatecoil Arcanist"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		191797,  -- Winds
		196175, -- Armorshell
		--[[ Gritslime Snail ]]--
		195473, -- Abrasive Slime

		--[[ Hatecoil Wrangler ]]--
		225089, -- Lightning Prod

		--[[ Hatecoil Stormweaver & Mystic Ssa'veh ]]--
		196870, -- Storm
		195109, -- Arc Lightning

		--[[ Hatecoil Crusher ]]--
		195129, -- Thundering Stomp

		--[[ Hatecoil Oracle ]]--
		195046, -- Rejuvenating Waters

		--[[ Mak'rana Siltwalker ]]--
		196127, -- Spray Sand

		--[[ Restless Tides ]]--
		195284, -- Undertow
		
		--[[ Cove Seagull ]]--
		{195561, "SAY"}, -- Blinding Peck

		--[[ Hatecoil Arcanist & Ritualist Lesha ]]--
		196027, -- Aqua Spout
		{197105, "SAY"}, -- Polymorph: Fish
		{192706, "SAY", "ICON"}, -- Arcane Bomb
		196515, -- Magic Binding
		
	}, {
		[196175] = L.hardshell,
		[195473] = L.gritslime,
		[225089] = L.wrangler,
		[196870] = L.stormweaver,
		[195129] = L.crusher,
		[195046] = L.oracle,
		[196127] = L.siltwalker,
		[195284] = L.tides,
		[195561] = L.CoveSeagull,
		[196027] = L.arcanist
	}
end

function mod:OnBossEnable()
	self:RegisterMessage("BigWigs_OnBossEngage", "Disable")
	self:Log("SPELL_AURA_APPLIED", "Winds", 191797)
	self:Log("SPELL_CAST_START", "Armorshell", 196175)
	self:Log("SPELL_CAST_START", "AbrasiveSlime", 195473)
	self:Log("SPELL_CAST_START", "LightningProd", 225089)
	self:Log("SPELL_CAST_START", "Storm", 196870)
	self:Log("SPELL_CAST_START", "ArcLightning", 195109)
	self:Log("SPELL_CAST_START", "ThunderingStomp", 195129)
	self:Log("SPELL_CAST_START", "RejuvenatingWaters", 195046)
	self:Log("SPELL_CAST_START", "SpraySand", 196127)
	self:Log("SPELL_CAST_START", "Undertow", 195284)
	self:Log("SPELL_CAST_START", "AquaSpout", 196027)
	self:Log("SPELL_AURA_APPLIED", "PolymorphFish", 197105)
	self:Log("SPELL_CAST_START", "PolymorphFishCast", 197105)
	self:Log("SPELL_CAST_START", "ArcaneBomb", 192706)
	self:Log("SPELL_AURA_APPLIED", "ArcaneBombApplied", 192706)
	self:Log("SPELL_AURA_REMOVED", "ArcaneBombRemoved", 192706)
	self:Log("SPELL_AURA_APPLIED", "BlindingPeck", 195561)
	self:Log("SPELL_CAST_START", "MagicBinding", 196515)
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
	if (self:MobId(args.destGUID) == 100248 or self:MobId(args.sourceGUID) == 100248) and Lesha == false then
		self:CDBar(196027, 7)
		self:CDBar(192706, 15)
		Lesha = true
	elseif (self:MobId(args.destGUID) == 100249 or self:MobId(args.sourceGUID) == 100249) and Varisz == false then
		self:CDBar(197105, 7)
		self:CDBar(192706, 15)
		Varisz = true
	elseif (self:MobId(args.destGUID) == 100250 or self:MobId(args.sourceGUID) == 100250) and Ashioi == false then
		self:CDBar(196515, 7)
		self:CDBar(192706, 15)
		Ashioi = true
	elseif (self:MobId(args.destGUID) == 98173 or self:MobId(args.sourceGUID) == 98173) and Ssaveh == false then
		self:CDBar(196870, 7)
		Ssaveh = true
	elseif (self:MobId(args.destGUID) == 95947 or self:MobId(args.sourceGUID) == 95947) and Hardshell == false then
		self:CDBar(196175, 5.4)
		Hardshell = true
	elseif (self:MobId(args.destGUID) == 91790 or self:MobId(args.sourceGUID) == 91790) and Siltwalker == false then
		self:CDBar(196127, 6.5)
		Siltwalker = true
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
			local InCombat = UnitAffectingCombat(unit)
			local exists = UnitExists(unit)
			local canAttack = UnitCanAttack("player", unit)
			local hp = UnitHealth(unit) / UnitHealthMax(unit) * 100
			local guid = UnitGUID(unit)
			local unit = unitTable[i]
			if InCombat and exists and canAttack and hp > 90 then
				if self:MobId(guid) == 100248 and Lesha == false then
					self:CDBar(196027, 7)
					self:CDBar(192706, 15)
					Lesha = true
				elseif self:MobId(guid) == 100249 and Varisz == false then
					self:CDBar(197105, 7)
					self:CDBar(192706, 15)
					Varisz = true
				elseif self:MobId(guid) == 100250 and Ashioi == false then
					self:CDBar(196515, 7)
					self:CDBar(192706, 15)
					Ashioi = true
				elseif self:MobId(guid) == 98173 and Ssaveh == false then
					self:CDBar(196870, 7)
					Ssaveh = true
				elseif self:MobId(guid) == 95947 and Hardshell == false then
					self:CDBar(196175, 5.4)
					Hardshell = true
				elseif self:MobId(guid) == 91790 and Siltwalker == false then
					self:CDBar(196127, 6.5)
					Siltwalker = true
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
				Lesha = false
				Varisz = false
				Ashioi = false
				Ssaveh = false
				Hardshell = false
				self:StopBar(195473)
				self:StopBar(CL.cast:format(self:SpellName(195473)))
				self:StopBar(225089)
				self:StopBar(CL.cast:format(self:SpellName(225089)))
				self:StopBar(196870)
				self:StopBar(CL.cast:format(self:SpellName(196870)))
				self:StopBar(195109)
				self:StopBar(CL.cast:format(self:SpellName(195109)))
				self:StopBar(195129)
				self:StopBar(CL.cast:format(self:SpellName(195129)))
				self:StopBar(195046)
				self:StopBar(CL.cast:format(self:SpellName(195046)))
				self:StopBar(196127)
				self:StopBar(CL.cast:format(self:SpellName(196127)))
				self:StopBar(195284)
				self:StopBar(CL.cast:format(self:SpellName(195284)))
				self:StopBar(196027)
				self:StopBar(CL.cast:format(self:SpellName(196027)))
				self:StopBar(197105)
				self:StopBar(CL.cast:format(self:SpellName(197105)))			
				self:StopBar(192706)
				self:StopBar(CL.cast:format(self:SpellName(192706)))
				self:StopBar(196515)
				self:StopBar(CL.cast:format(self:SpellName(196515)))
				self:StopBar(196175)
				self:StopBar(CL.cast:format(self:SpellName(196175)))
			end
		end
	end
	function mod:WipeTimer()
		self:ScheduleTimer("wipeCheck", 0.1)
	end
end

function mod:MagicBinding(args)
	self:Message(args.spellId, "Urgent", "Warning", CL.casting:format(args.spellName))
	self:CDBar(196515, 18)
end

function mod:Winds(args)
	if self:Me(args.destGUID) then
		self:Message(191797, "Attention", "Alarm")
		self:CDBar(191797, 90)
	end
end

do
	local prev = 0
	local function printTarget(self, name, guid)
		local t = GetTime()
		if t-prev > 0.3 then
			prev = t
			self:TargetMessage(192706, name, "Attention", "Alarm")
		end
	end
	function mod:ArcaneBombApplied(args)
		local t = GetTime()
		self:PrimaryIcon(192706, args.destName)
		if self:Me(args.destGUID) then
			prev = t
			self:Say(args.spellId)
			self:TargetMessage(args.spellId, args.destName, "Personal", "Bam")
			local _, _, duration = self:UnitDebuff("player", args.spellId)
			self:SayCountdown(args.spellId, duration, 8, 5)
			self:TargetBar(args.spellId, duration, args.destName)
		else
			self:TargetMessage(args.spellId, args.destName, "Attention", "Long")
		end
	end
	function mod:ArcaneBombRemoved(args)
		self:PrimaryIcon(192706, nil)
		if self:Me(args.destGUID) then
			self:Message(args.spellId, "Positive", "Info", CL.removed:format(args.spellName))
			self:CancelSayCountdown(args.spellId)
			self:StopBar(args.spellId, args.destName)
		end
	end
end

do
	local prev = 0
	function mod:ArcaneBomb(args)
		local t = GetTime()
		if t-prev > 9 then
			prev = t
			self:CDBar(192706, 16)
		elseif t-prev > 0.3 then
			self:CastBar(192706, 16)
		end
	end
end

do
	local prev = 0
	function mod:PolymorphFishCast(args)
		self:Message(args.spellId, "Attention", "Long", CL.casting:format(args.spellName))
		local t = GetTime()
		if t-prev > 15 then
			prev = t
			self:CDBar(197105, 18)
		end
	end
end

-- Gritslime Snail
function mod:AbrasiveSlime(args)
	self:Message(args.spellId, "Attention", "Long", CL.casting:format(args.spellName))
	self:CDBar(args.spellId, 8) -- "Abrasive Slime"
	self:CastBar(195473, 16)
end

-- Hatecoil Wrangler
function mod:LightningProd(args)
	self:Message(args.spellId, "Urgent", "Warning", CL.casting:format(args.spellName))
end

-- Hatecoil Stormweaver
function mod:Storm(args)
	self:Message(args.spellId, "Attention", "Long", CL.casting:format(args.spellName))
	self:CDBar(args.spellId, 18)
end

function mod:ArcLightning(args)
	self:Message(args.spellId, "Attention", "Alarm", CL.casting:format(args.spellName))
end

-- Hatecoil Crusher
function mod:ThunderingStomp(args)
	self:Message(args.spellId, "Important", self:Interrupter() and "Warning" or "Info", CL.casting:format(args.spellName))
	self:CDBar(args.spellId, 19) -- "Thundering Stomp"
	self:CastBar(args.spellId, 38)
end

-- Hatecoil Oracle
function mod:RejuvenatingWaters(args)
	self:Message(args.spellId, "Attention", self:Interrupter() and "Alarm", CL.casting:format(args.spellName))
end

-- Mak'rana Siltwalker

do
	local prev = 0
	function mod:SpraySand(args)
		self:Message(args.spellId, "Attention", "Long", CL.casting:format(args.spellName))
		local t = GetTime()
		if t-prev > 13 then
			prev = t
			self:CDBar(args.spellId, 14.6) -- "Spray Sand"
			self:CastBar(196127, 29.2)
		end
	end
end

-- Mak'rana Hardshell

do
	local prev = 0
	function mod:Armorshell(args)
		self:Message(args.spellId, "Attention", "Alert", CL.casting:format(args.spellName))
		local t = GetTime()
		if t-prev > 17 then
			prev = t
			self:CDBar(196175, 18.1)
			self:CastBar(196175, 36.2)
		end
	end
end

-- Restless Tides
function mod:Undertow(args)
	self:Message(args.spellId, "Attention", "Long", CL.casting:format(args.spellName))
end

-- Hatecoil Arcanist

do
	local prev = 0
	function mod:AquaSpout(args)
		self:Message(args.spellId, "Attention", "Alarm", CL.casting:format(args.spellName))
		local t = GetTime()
		if t-prev > 16 then
			prev = t
			self:CDBar(196027, 16)
		elseif t-prev > 0.5 and t-prev < 17 then
			self:CastBar(196027, 16)
		end
	end
end

function mod:BlindingPeck(args)
	if self:Me(args.destGUID) then
		self:Say(args.spellId)
	end
	self:TargetMessage(args.spellId, args.destName, "Attention", "Info", self:SpellName(args.spellId))
end

function mod:PolymorphFish(args)
	if self:Dispeller("magic") then
		self:TargetMessage(args.spellId, args.destName, "Attention", "Info", self:SpellName(118), nil, true) -- 118 is Polymorph, which is shorter than "Polymorph: Fish"
	elseif self:Me(args.destGUID) then
		self:TargetMessage(args.spellId, args.destName, "Attention", "Info", self:SpellName(118), nil, true)
		self:Say(args.spellId)
	end
end