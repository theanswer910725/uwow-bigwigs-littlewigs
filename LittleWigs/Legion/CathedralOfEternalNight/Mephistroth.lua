
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Mephistroth", 1677, 1878)
if not mod then return end
mod:RegisterEnableMob(116944, 118418)
mod.engageId = 2039

--------------------------------------------------------------------------------
-- Locals
--

local phase = 1
local timeLost = 0
local DemonicUpheavalCount = 0
local upheavalWarned = {}
local Aegis = {}
--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale("enUS", true)
if L then
	L.custom_on_time_lost = "Time lost during Shadow Fade"
	L.custom_on_time_lost_desc = "Show the time lost during Shadow Fade on the bar in |cffff0000red|r."
	L.custom_on_time_lost_icon = "ability_racial_timeismoney"
	L.time_lost = "%s |cffff0000(+%ds)|r"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		{234114, "SAY", "FLASH"}, -- Aegis of Aggramar
		233155, -- Carrion Swarm
		{233196, "SAY"}, -- Demonic Upheaval
		{234817, "PROXIMITY"}, -- Dark Solitude
		233206, -- Shadow Fade
		"custom_on_time_lost",
	},{
		[234114] = "general",
		[233155] = -14949,
		[233206] = -14950,
	}
end

function mod:OnBossEnable()
	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss1", "boss2")
	self:Log("SPELL_CAST_START", "CarrionSwarm", 233155)
	self:Log("SPELL_CAST_START", "DemonicUpheaval", 233196)
	self:RegisterEvent("UNIT_AURA") -- Demonic Upheaval debuff tracking
	self:Log("SPELL_CAST_START", "DarkSolitude", 234817)
	self:Log("SPELL_AURA_APPLIED", "ShadowFade", 233206)
	self:Log("SPELL_AURA_REMOVED", "ShadowFadeRemoved", 233206)
end

function mod:OnEngage()
	phase = 1
	timeLost = 0
	DemonicUpheavalCount = 1
	wipe(upheavalWarned)
	self:OpenProximity(234817, 8) -- Dark Solitude

	self:Bar(233196, 3.78) -- Demonic Upheaval
	self:Bar(234817, 7.1) -- Dark Solitude
	self:Bar(233155, 18.1) -- Carrion Swarm
	self:Bar(233206, 44.2) -- Shadow Fade
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:UNIT_SPELLCAST_SUCCEEDED(unit, spellName, _, _, spellId)
	if spellId == 234283 and phase == 2 then -- Expel Shadows
		self:Message(233206, "Attention", "Warning", 234283)
		local timeLeft = 0
		if timeLost == 0 or not self:GetOption("custom_on_time_lost") then
			timeLeft = self:BarTimeLeft(233206) -- Shadow Fade
		else
			timeLeft = self:BarTimeLeft(L.time_lost:format(self:SpellName(233206), timeLost)) -- Shadow Fade
		end
		self:StopBar(233206) -- Shadow Fade
		self:StopBar(L.time_lost:format(self:SpellName(233206), timeLost)) -- Shadow Fade (-xs)
		local newTime = timeLeft + 7.5
		timeLost = timeLost + 7.5
		if self:GetOption("custom_on_time_lost") then
			self:Bar(233206, newTime <= 30 and newTime or 30, L.time_lost:format(self:SpellName(233206), timeLost)) -- Takes 30s to go from 0-300 UNIT_POWER, max 30s bar.
		else
			self:Bar(233206, newTime <= 30 and newTime or 30, self:SpellName(233206))
		end
	end
end

function mod:CarrionSwarm(args)
	self:Message(args.spellId, "Attention", "Alarm")
	if self:BarTimeLeft(233206) > 18.2 then -- Shadow Fade
		self:Bar(args.spellId, 18.1)
	end
end

function mod:DemonicUpheaval(args)
	self:Message(args.spellId, "Attention", "Alert", CL.incoming:format(args.spellName))
	if self:BarTimeLeft(233206) > 31.9 then -- Shadow Fade
		if DemonicUpheavalCount == 1 then
			self:Bar(args.spellId, 26.81)
		elseif DemonicUpheavalCount == 2 then
			self:Bar(args.spellId, 29.15)
		end
	end
	DemonicUpheavalCount = DemonicUpheavalCount + 1
end

do
	local list, guid = mod:NewTargetList(), nil
	function mod:UNIT_AURA(event, unit)
		local name = self:UnitDebuff(unit, 233963) -- Demonic Upheaval Debuff Id
		local n = self:UnitName(unit)
		if upheavalWarned[n] and not name then
			upheavalWarned[n] = nil
		elseif name and not upheavalWarned[n] then
			guid = UnitGUID(n)
			list[#list+1] = n
			if #list == 1 then
				self:TargetBar(233196, 10.8, n)
				self:ScheduleTimer("TargetMessage", 1, 233196, list, "Important", "Warning", 233963) -- Travel time
			end
			if self:Me(guid) then
				self:Say(233196)
				self:Flash(233196)
				local _, _, duration = self:UnitDebuff("player", 233963)
				self:SayCountdown(233196, duration, 8, 3)
			end
			upheavalWarned[n] = true
		end
		if Aegis[n] and not self:UnitBuff(unit, 234114) then
			Aegis[n] = nil
		elseif self:UnitBuff(unit, 234114) and not Aegis[n] then
			guid = UnitGUID(n)
			self:TargetMessage(234114, n, "Positive", "Long", 234114)
			if self:Me(guid) then
				self:Say(234114)
				self:Flash(234114)
			end
			Aegis[n] = true
		end
	end
end

function mod:DarkSolitude(args)
	self:Message(args.spellId, "Attention", "Alarm")
	if self:BarTimeLeft(233206) > 8.5 then -- Shadow Fade
		self:CDBar(args.spellId, 8.5)
	end
end

function mod:ShadowFade(args)
	phase = 2
	timeLost = 0
	self:CloseProximity(234817) -- Dark Solitude
	self:Message(args.spellId, "Positive", "Long")
	self:Bar(args.spellId, 34)
end

function mod:ShadowFadeRemoved(args)
	DemonicUpheavalCount = 1
	phase = 1
	self:OpenProximity(234817, 8) -- Dark Solitude
	self:Message(args.spellId, "Positive", "Long", CL.removed:format(args.spellName))
	self:Bar(args.spellId, 79.3)
	self:Bar(233196, 3.8) -- Demonic Upheaval
	self:Bar(234817, 7.1) -- Dark Solitude
	self:Bar(233155, 18.1) -- Carrion Swarm
end
