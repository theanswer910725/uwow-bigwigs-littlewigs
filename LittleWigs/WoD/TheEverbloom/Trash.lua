--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("The Everbloom Trash", 1279)
if not mod then return end
mod.displayName = CL.trash
mod:RegisterEnableMob(
	81864, -- Dreadpetal
	81819, -- Everbloom Naturalist
	81985, -- Everbloom Cultivator
	82039, -- Rockspine Stinger
	81820, -- Everbloom Mender
	81984, -- Gnarlroot
	86372, -- Melded Berserker
	84767, -- Twisted Abomination
	84989, -- Infested Icecaller
	84957, -- Putrid Pyromancer
	84990  -- Addled Arcanomancer
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
-- Localization
--

local L = mod:GetLocale()
if L then
	L.dreadpetal = "Dreadpetal"
	L.everbloom_naturalist = "Everbloom Naturalist"
	L.everbloom_cultivator = "Everbloom Cultivator"
	L.rockspine_stinger = "Rockspine Stinger"
	L.everbloom_mender = "Everbloom Mender"
	L.gnarlroot = "Gnarlroot"
	L.melded_berserker = "Melded Berserker"
	L.twisted_abomination = "Twisted Abomination"
	L.infested_icecaller = "Infested Icecaller"
	L.putrid_pyromancer = "Putrid Pyromancer"
	L.addled_arcanomancer = "Addled Arcanomancer"

	L.gate_open = "Gate open"
	L.gate_open_desc = "Show a bar indicating when Undermage Kesalon will open the gate to Yalnu."
	L.gate_open_icon = "spell_fire_fireball02"

	L.yalnu_warmup_trigger = "The portal is lost! We must stop this beast before it can escape!"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-- RP Timers
		"gate_open",
		-- Dreadpetal
		{164886, "DISPEL"}, -- Dreadpetal Pollen
		-- Everbloom Naturalist
		{164965, "SAY"}, -- Choking Vines
		-- Everbloom Cultivator
		165213, -- Enraged Growth
		-- Rockspine Stinger
		{165123, "SAY"}, -- Venom Burst
		-- Everbloom Mender
		164887, -- Healing Waters
		-- Gnarlroot
		169494, -- Living Leaves
		426500, -- Gnarled Roots
		-- Melded Berserker
		172578, -- Bounding Whirl
		-- Twisted Abomination
		169445, -- Noxious Eruption
		-- Infested Icecaller
		426845, -- Cold Fusion
		-- Putrid Pyromancer
		427223, -- Cinderbolt Salvo
		-- Addled Arcanomancer
		426974, -- Spatial Disruption
	}, {
		[164886] = L.dreadpetal,
		[164965] = L.everbloom_naturalist,
		[165213] = L.everbloom_cultivator,
		[165123] = L.rockspine_stinger,
		[164887] = L.everbloom_mender,
		[169494] = L.gnarlroot,
		[172578] = L.melded_berserker,
		[169445] = L.twisted_abomination,
		[426845] = L.infested_icecaller,
		[427223] = L.putrid_pyromancer,
		[426974] = L.addled_arcanomancer,
	}
end

function mod:OnBossEnable()
	-- RP Timers
	self:RegisterEvent("CHAT_MSG_MONSTER_YELL")

	-- Dreadpetal
	self:Log("SPELL_AURA_APPLIED_DOSE", "DreadpetalPollenApplied", 164886)

	-- Everbloom Naturalist
	self:Log("SPELL_CAST_START", "ChokingVines", 164965)
	self:Log("SPELL_AURA_APPLIED", "ChokingVinesApplied", 164965)

	-- Everbloom Cultivator
	self:Log("SPELL_CAST_START", "EnragedGrowth", 165213)

	-- Rockspine Stinger
	self:Log("SPELL_AURA_APPLIED", "VenomBurstApplied", 165123)

	-- Everbloom Mender
	self:Log("SPELL_CAST_START", "HealingWaters", 164887)

	-- Gnarlroot
	self:Log("SPELL_CAST_START", "LivingLeaves", 169494)
	self:Log("SPELL_AURA_APPLIED", "LivingLeavesApplied", 169495)
	self:Log("SPELL_CAST_START", "GnarledRoots", 426500)
	self:Death("GnarlrootDeath", 81984)

	-- Melded Berserker
	self:Log("SPELL_CAST_SUCCESS", "BoundingWhirl", 172578)

	-- Twisted Abomination
	self:Log("SPELL_CAST_START", "NoxiousEruption", 169445)

	-- Infested Icecaller
	self:Log("SPELL_CAST_SUCCESS", "ColdFusion", 426845)

	-- Putrid Pyromancer
	self:Log("SPELL_CAST_SUCCESS", "CinderboltSalvo", 427223)

	-- Addled Arcanomancer
	self:Log("SPELL_CAST_SUCCESS", "SpatialDisruption", 426974)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- RP Timers

-- triggered from Archmage Sol's OnWin
function mod:ArchmageSolDefeated()
	-- 7.26 [ENCOUNTER_END] 1751#Archmage Sol
	-- 38.84 [CLEU] SPELL_CAST_SUCCESS#Undermage Kesalon#170741#Pyroblast
	-- 40.27 [CHAT_MSG_MONSTER_SAY] If that beast crosses through, the unchecked growth will choke the whole of Azeroth! Hurry!#Undermage Kesalon
	-- ~42.26 Gate Despawns
	self:Bar("gate_open", 30.0, L.gate_open, L.gate_open_icon)
end

function mod:CHAT_MSG_MONSTER_YELL(_, msg, sender)
	if msg == L.yalnu_warmup_trigger then
		-- The portal is lost! We must stop this beast before it can escape!#Lady Baihu
		local yalnuMod = BigWigs:GetBossModule("Yalnu", true)
		if yalnuMod then
			yalnuMod:Enable()
			yalnuMod:Warmup()
		end
	end
end

-- Dreadpetal

function mod:DreadpetalPollenApplied(args)
	-- stacks relatively quickly, only dispels with movement (or by kiting)
	-- can be applied to NPCs by mind-controlled mobs
	if args.amount >= 6 and args.amount % 3 == 0 and (self:Me(args.destGUID) or (self:Dispeller(nil, nil, args.spellId))) then
		self:StackMessage(args.spellId, args.destName, args.amount, "blue")
		self:PlaySound(args.spellId, "alert", nil, args.destName)
	end
end

-- Everbloom Naturalist

do
	local prev = 0
	function mod:ChokingVines(args)
		if bit.band(args.sourceFlags, COMBATLOG_OBJECT_REACTION_FRIENDLY) == 1 then -- these NPCs can be mind-controlled by Priests
			return
		end
		local t = GetTime()
		if t - prev > 1.5 then
			prev = t
			self:Message(args.spellId, "yellow", CL.casting:format(args.spellName))
			self:PlaySound(args.spellId, "alert")
		end
		if self:BarTimeLeft(args.spellId) < 2 then
			self:CDBar(args.spellId, 20)
		end
	end
end

do
	local prev = 0
	function mod:ChokingVinesApplied(args)
		local t = GetTime()
		if t - prev > 2 then
			prev = t
			self:TargetMessage(args.spellId, args.destName, "orange")
			if self:Me(args.destGUID) then
				self:PlaySound(args.spellId, "info", nil, args.destName)
				self:Say(args.spellId)
			else
				self:PlaySound(args.spellId, "alarm", nil, args.destName)
			end
		end
	end
end

-- Everbloom Cultivator

do
	local prev = 0
	function mod:EnragedGrowth(args)
		if bit.band(args.sourceFlags, COMBATLOG_OBJECT_REACTION_FRIENDLY) == 1 then -- these NPCs can be mind-controlled by Priests
			return
		end
		local t = GetTime()
		if t - prev > 1.5 then
			prev = t
			self:Message(args.spellId, "red", CL.casting:format(args.spellName))
			self:PlaySound(args.spellId, "alert")
		end
		if self:BarTimeLeft(args.spellId) < 2 then
			self:CDBar(args.spellId, 14.6)
		end
	end
end

-- Rockspine Stinger

do
	local prev = 0
	local prevSay = 0
	function mod:VenomBurstApplied(args)
		local onMe = self:Me(args.destGUID)
		local t = GetTime()
		if t - prev > 1.5 then
			prev = t
			self:TargetMessage(args.spellId, args.destName, "red")
			if onMe then
				self:PlaySound(args.spellId, "alert", nil, args.destName)
			else
				self:PlaySound(args.spellId, "alarm", nil, args.destName)
			end
		end
		if onMe and t - prevSay > 3 then
			prevSay = t
			self:Say(args.spellId, nil, nil, "Venom Burst")
		end
	end
end

-- Everbloom Mender

do
	local prev = 0
	function mod:HealingWaters(args)
		if bit.band(args.sourceFlags, COMBATLOG_OBJECT_REACTION_FRIENDLY) == 1 then -- these NPCs can be mind-controlled by Priests
			return
		end
		local t = GetTime()
		if t - prev > 1.5 then
			prev = t
			self:Message(args.spellId, "red", CL.casting:format(args.spellName))
			if self:Interrupter() then
				self:PlaySound(args.spellId, "warning")
			else
				self:PlaySound(args.spellId, "alert")
			end
		end
		if self:BarTimeLeft(args.spellId) < 2 then
			self:CDBar(args.spellId, 19.4)
		end	
	end
end

-- Gnarlroot

do
	-- use this timer to schedule StopBars on both abilities, this way if you pull
	-- and reset the mob (or wipe) the bars won't be stuck for the rest of the dungeon.
	local timer

	function mod:LivingLeaves(args)
		if timer then
			self:CancelTimer(timer)
		end
		self:Message(args.spellId, "yellow")
		self:PlaySound(args.spellId, "info")
		self:CDBar(args.spellId, 18.2)
		timer = self:ScheduleTimer("GnarlrootDeath", 30)
	end

	do
		local prev = 0
		function mod:LivingLeavesApplied(args)
			local t = GetTime()
			if t - prev > 2 and self:Me(args.destGUID) then
				prev = t
				self:Message(169494, "Personal", nil, CL.underyou:format(args.spellName))
			end
		end
	end

	function mod:GnarledRoots(args)
		if timer then
			self:CancelTimer(timer)
		end
		self:Message(args.spellId, "orange")
		self:PlaySound(args.spellId, "alarm")
		self:CDBar(args.spellId, 18.2)
		timer = self:ScheduleTimer("GnarlrootDeath", 30)
	end

	function mod:GnarlrootDeath()
		if timer then
			self:CancelTimer(timer)
			timer = nil
		end
		self:StopBar(169494) -- Living Leaves
		self:StopBar(426500) -- Gnarled Roots
	end
end

-- Melded Berserker

do
	local prev = 0
	function mod:BoundingWhirl(args)
		local t = GetTime()
		if t - prev > 1.5 then
			prev = t
			self:Message(args.spellId, "orange")
			self:PlaySound(args.spellId, "alarm")
		end
		if self:BarTimeLeft(args.spellId) < 2 then
			self:CDBar(args.spellId, 16.9)
		end
	end
end

-- Twisted Abomination

do
	local prev = 0
	function mod:NoxiousEruption(args)
		local t = GetTime()
		if t - prev > 1.5 then
			prev = t
			self:Message(args.spellId, "red")
			self:PlaySound(args.spellId, "alert")
		end
		if self:BarTimeLeft(args.spellId) < 2 then
			self:CDBar(args.spellId, 19.4)
		end	
	end
end

-- Infested Icecaller

function mod:ColdFusion(args)
	self:Message(args.spellId, "yellow")
	self:PlaySound(args.spellId, "alarm")
	if self:BarTimeLeft(args.spellId) < 2 then
		self:CDBar(args.spellId, 21.8)
	end
end

-- Putrid Pyromancer

function mod:CinderboltSalvo(args)
	self:Message(args.spellId, "orange")
	self:PlaySound(args.spellId, "alert")
	if self:BarTimeLeft(args.spellId) < 2 then
		self:CDBar(args.spellId, 18.2)
	end
end

-- Addled Arcanomancer

function mod:SpatialDisruption(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "alarm")
	
    local unit = self:GetUnitIdByGUID(args.sourceGUID)
    local raidIndex = unit and GetRaidTargetIndex(unit)
    if raidIndex and raidIndex > 0 then
        self:CDBar(426974, 22, CL.other:format(self:SpellName(426974), mark["{rt" .. raidIndex .. "}"]), 426974)
		return
    end
    for i = 1, 8 do
        if self:BarTimeLeft(CL.count:format(self:SpellName(426974), i)) < 1 then
            self:Bar(426974, 22, CL.count:format(self:SpellName(426974), i))
            break
        end
    end	
end
