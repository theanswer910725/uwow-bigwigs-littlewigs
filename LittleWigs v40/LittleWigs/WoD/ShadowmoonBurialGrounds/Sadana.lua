
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Sadana Bloodfury", 1176, 1139)
if not mod then return end
mod:RegisterEnableMob(75509)
mod.engageId = 1677
mod.respawnTime = 33

--------------------------------------------------------------------------------
-- Locals
--


local DarkCommunionCount = 0
local DarkEclipseCount = 0
local WhispersOfTheDarkStarCount = 0
local DaggerfallCount = 0
local LunarPurityOnMe = false
local aftermob = 0

local timers = {
	[153153] = {24.24, 60.02, 71.92, 65.59, 72.41, 65.64, 72.30, 65.71, 73.56},  -- Dark Communion
	[164974] = {47.29, 50.84, 46.00, 46.00, 46.01, 46.00, 45.99, 46.02, 45.99, 46.03, 47.16, 46.02}, -- Dark Eclipse
	[153094] = {15.69, 14.42, 12.03, 23.12, 23.15, 23.15, 23.15, 23.17, 23.15, 23.17, 23.16, 22.02, 21.98}, -- Whispers of the Dark Star
	[153240] = {9.60, 11.94, 11.93, 11.92, 11.93, 11.93, 11.95, 11.98, 11.95, 21.39, 11.92, 11.94, 11.92},  -- Daggerfall
}
--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.custom_on_markadd = "Mark the Dark Communion Add"
	L.custom_on_markadd_desc = "Mark the add spawned by Dark Communion with {rt8}, requires promoted or leader."
	L.custom_on_markadd_icon = 8
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		153153, -- Dark Communion
		"custom_on_markadd", -- Add marker option
		153240, -- Daggerfall
		153224, -- Shadow Burn
		153094, -- Whispers of the Dark Star
		164974, -- Dark Eclipse
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_SUCCESS", "DarkCommunion", 153153)
	self:Log("SPELL_CAST_SUCCESS", "Daggerfall", 153240)
	self:Log("SPELL_MISSED", "ShadowBurnDamage", 153224)
	self:Log("SPELL_DAMAGE", "ShadowBurnDamage", 153224)
	self:Log("SPELL_AURA_APPLIED", "ShadowBurnDamage", 153224)
	self:Log("SPELL_CAST_SUCCESS", "WhispersOfTheDarkStar", 153094)
	self:Log("SPELL_CAST_SUCCESS", "DarkEclipse", 164974)
	self:Log("SPELL_AURA_APPLIED", "DarkCommunionApp", 153164)
	self:Log("SPELL_AURA_APPLIED_DOSE", "DarkCommunionApp", 153164)
	self:Log("SPELL_AURA_REMOVED", "DarkEclipseRemoved", 164974)
	self:Log("SPELL_AURA_APPLIED", "LunarPurityApplied", 162652)
	self:Log("SPELL_AURA_REMOVED", "LunarPurityRemoved", 162652)
	self:Death("MobDeath", 75966)
end

function mod:OnEngage()
	DarkCommunionCount = 1
	DarkEclipseCount = 1
	WhispersOfTheDarkStarCount = 1
	DaggerfallCount = 1
	self:Bar(153153, timers[153153][DarkCommunionCount], CL.count:format(CL.next_add, DarkCommunionCount)) -- Dark Commmunion
	self:Bar(164974, timers[164974][DarkEclipseCount], CL.count:format(self:SpellName(164974), DarkEclipseCount)) -- Dark Eclipse
	self:Bar(153094, timers[153094][DarkEclipseCount])
	self:Bar(153240, timers[153240][DarkEclipseCount])
	RefreshTimer = false
	LunarPurityOnMe = false
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:MobDeath()
	RefreshTimer = false
end

function mod:DarkCommunionApp(args)
	RefreshTimer = false
end

function mod:AfterMobTimer()
	if RefreshTimer then
		if DarkCommunionCount == 2 or DarkCommunionCount == 5 or DarkCommunionCount == 7 or DarkCommunionCount == 9 then
			self:CDBar(153240, 1.1)
		elseif DarkCommunionCount == 4 or DarkCommunionCount == 6 or DarkCommunionCount == 8 then
			self:CDBar(153094, 1.1)
			self:CDBar(153240, 0.9)
		end
	end
	self:ScheduleTimer("AfterMobTimer", 0.1)
end

function mod:Daggerfall(args)
	self:Message(args.spellId, "Attention", "Alert")
	if self:BarTimeLeft(CL.count:format(self:SpellName(164974), DarkEclipseCount)) < 10 then
		self:CDBar(args.spellId, self:BarTimeLeft(CL.count:format(self:SpellName(164974), DarkEclipseCount))+11.9)
	elseif self:BarTimeLeft(153094) < 9 and self:BarTimeLeft(CL.count:format(CL.next_add, DarkCommunionCount)) < 16 then
		self:CDBar(args.spellId, 20)
	elseif self:BarTimeLeft(CL.count:format(CL.next_add, DarkCommunionCount)) < 6 and self:BarTimeLeft(CL.count:format(self:SpellName(164974), DarkEclipseCount)) < 20 then
		self:CDBar(153240, 15, CL.other:format(self:SpellName(153240), "???"), 153240)
		self:CDBar(args.spellId, 33)
	elseif self:BarTimeLeft(CL.count:format(CL.next_add, DarkCommunionCount)) < 16 and self:BarTimeLeft(CL.count:format(self:SpellName(164974), DarkEclipseCount)) < 6 then
		self:CDBar(args.spellId, 27.9)
	elseif self:BarTimeLeft(153094) < 3 then
		self:CDBar(args.spellId, 10)
	elseif self:BarTimeLeft(CL.count:format(CL.next_add, DarkCommunionCount)) < 5 then
		self:CDBar(args.spellId, 10)
	elseif self:BarTimeLeft(CL.count:format(CL.next_add, DarkCommunionCount)) < 9 then
		self:CDBar(args.spellId, 20)
	elseif self:BarTimeLeft(153094) < 9 then
		self:CDBar(args.spellId, 16.5)
	elseif self:BarTimeLeft(CL.count:format(self:SpellName(164974), DarkEclipseCount)) < 13 then
		self:CDBar(args.spellId, 23)
	else
		self:CDBar(args.spellId, 8.5)
	end
end

do
	local prev = 0
	function mod:ShadowBurnDamage(args)
		if self:Me(args.destGUID) then
			local t = GetTime()
			if t - prev > 1.5 then
				prev = t
				self:Message(args.spellId, "Personal", "Alarm", CL.underyou:format(args.spellName))
			end
		end
	end
end

function mod:DarkCommunion(args)
	RefreshTimer = true
	self:ScheduleTimer("AfterMobTimer", 0.1)
	self:Message(args.spellId, "Neutral", "Info", CL.add_spawned)
	--self:Bar(args.spellId, 61, CL.next_add)
	DarkCommunionCount = DarkCommunionCount + 1
	self:Bar(args.spellId, timers[args.spellId][DarkCommunionCount], CL.count:format(CL.next_add, DarkCommunionCount))
	if self:GetOption("custom_on_markadd") then
		self:RegisterTargetEvents("MarkDefiledSpirit")
	end
end

function mod:MarkDefiledSpirit(_, unit, guid)
	if self:MobId(guid) == 75966 then -- Defiled Spirit
		SetRaidTarget(unit, 8)
		self:UnregisterTargetEvents()
	end
end

function mod:WhispersOfTheDarkStar(args)
	self:Message(args.spellId, "orange", "Alarm")
	self:CDBar(args.spellId, 46)
end

do
	local LunarPurityCheck = nil

	local function checkForLunarPurity()
		if not LunarPurityOnMe then
			mod:Message(164974, "Personal", "Alert", CL.no:format(mod:SpellName(162652)))
			LunarPurityCheck = mod:ScheduleTimer(checkForLunarPurity, 1.5)
		else
			mod:Message(164974, "Neutral", "Long", CL.you:format(mod:SpellName(162652)))
			LunarPurityCheck = nil
		end
	end
	
	function mod:DarkEclipse(args)
		self:Message(args.spellId, "red", "Warning", CL.casting:format(args.spellName))
		self:Bar(args.spellId, 6, CL.cast:format(args.spellName))
		--self:CDBar(args.spellId, 46.1)
		DarkEclipseCount = DarkEclipseCount + 1
		self:Bar(args.spellId, timers[args.spellId][DarkEclipseCount], CL.count:format(self:SpellName(args.spellId), DarkEclipseCount))
		self:Bar(153094, timers[153094][DarkEclipseCount])
		self:Bar(153240, timers[153240][DarkEclipseCount])
		checkForLunarPurity()
	end

	function mod:LunarPurityApplied(args)
		if self:Me(args.destGUID) then
			LunarPurityOnMe = true
			if LunarPurityCheck then
				self:CancelTimer(LunarPurityCheck)
				checkForLunarPurity() -- immediately check and give the positive message
			end
		end
	end

	function mod:LunarPurityRemoved(args)
		if self:Me(args.destGUID) then
			LunarPurityOnMe = false
		end
	end

	function mod:DarkEclipseRemoved(args)
		if LunarPurityCheck then
			self:CancelTimer(LunarPurityCheck)
			LunarPurityCheck = nil
		end
	end
end