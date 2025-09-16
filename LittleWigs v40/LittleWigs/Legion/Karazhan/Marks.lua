--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("=> AutoMarks <=   ", 1651)
if not mod then return end

mod:RegisterEnableMob(
	114627, --Визжащий ужас
    114338, --Скопление маны
    114249, --Нестабильная энергия
    114675, --Проекция Хранителя
    115484,  --Сквернотопырь
	-- ловер
	114629, --Призрачный эконом
    114796, --Благонравная горничная
    114803, --Призрачный помощник смотрителя стойл
    114624, --Волшебный страж
    114628, --Скелет-официант
    114794  --Костяная гончая
)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.custom_on_Allowmarks = "Allow marks of selected mobs"
	L.custom_on_Allowmarks_desc = "Mark mobs with {rt1}{rt2}{rt3}{rt4}{rt5}{rt6}{rt7}, you need to be an assistant or a leader"
	L.custom_off_RequireLead = "Only if I am the leader"
	L.custom_off_CombatMarking  = "Mark only those who are in combat"
	
	L.Choose = "Choose which mobs to mark"
	L.Lower = "Lower Karazhan"

	L.custom_off_Mob1 = "Shrieking Terror"
	L.custom_off_Mob2 = "Mana Confluence"
	L.custom_off_Mob3 = "Volatile Energy"
	L.custom_off_Mob4 = "Guardian's Image"
	L.custom_off_Mob5 = "Fel Bat"
	
	L.custom_off_Mob6 = "Spectral Retainer"
	L.custom_off_Mob7 = "Wholesome Hostess"
	L.custom_off_Mob8 = "Spectral Stable Hand"
	L.custom_off_Mob9 = "Arcane Warden"
	L.custom_off_Mob10 = "Skeletal Waiter"
	L.custom_off_Mob11 = "Skeletal Hound"
end
--------------------------------------------------------------------------------
-- Locals
--
local MobAddMarks = {}
--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"custom_on_Allowmarks",
		"custom_off_CombatMarking",
		"custom_off_RequireLead",
		
		"custom_off_Mob1",
		"custom_off_Mob2",
		"custom_off_Mob3",
		"custom_off_Mob4",
		"custom_off_Mob5",
		
		"custom_off_Mob6",
		"custom_off_Mob7",
		"custom_off_Mob8",
		"custom_off_Mob9",
		"custom_off_Mob10",
		"custom_off_Mob11",
	}, {
		["custom_on_Allowmarks"] = "general",
		["custom_off_Mob1"] = L.Choose,
		["custom_off_Mob6"] = L.Lower,
	}
end

function mod:OnBossEnable()
	self:RegisterTargetEvents("AutoMarks")
	self:Death("MarkDeath", 114627, 114338, 114249, 114675, 115484, 114629, 114796, 114803, 114624, 114628, 114794)
	self:RegisterEvent("PLAYER_REGEN_ENABLED", "ResetMobAddList")
	self:RegisterEvent("PLAYER_REGEN_DISABLED")
	self:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:MarkDeath(args)
	local guid = args.destGUID
	local mobId = self:MobId(guid)
	if self:GetOption("custom_on_Allowmarks") then
		for key,guid in pairs(MobAddMarks) do
			MobAddMarks[key] = nil
		end
	end
end

do
	function mod:AutoMarks(event, unit, guid)
		local guid = UnitGUID(unit)
		local mobID = self:MobId(guid)
		if self:GetOption("custom_off_RequireLead") and not UnitIsGroupLeader("player") and ((UnitInParty("player") or UnitInRaid("player"))) then return end
		if self:GetOption("custom_on_Allowmarks") and ((self:GetOption("custom_off_CombatMarking") and UnitAffectingCombat(unit)) or not self:GetOption("custom_off_CombatMarking")) then
			if (self:GetOption("custom_off_Mob1") and mobID == 114627) or (self:GetOption("custom_off_Mob2") and mobID == 114338) or (self:GetOption("custom_off_Mob3") and mobID == 114249) or (self:GetOption("custom_off_Mob4") and mobID == 114675) or (self:GetOption("custom_off_Mob5") and mobID == 115484 or (self:GetOption("custom_off_Mob6") and mobID == 114629) or (self:GetOption("custom_off_Mob7") and mobID == 114796) or (self:GetOption("custom_off_Mob8") and mobID == 114803) or (self:GetOption("custom_off_Mob9") and mobID == 114624) or (self:GetOption("custom_off_Mob10") and mobID == 114628) or (self:GetOption("custom_off_Mob11") and mobID == 114794)) then
				for i = 1, 7 do
					if not MobAddMarks[i] and not GetRaidTargetIndex(unit) then
						SetRaidTarget(unit, i)
						MobAddMarks[i] = guid
						break
					end
				end
			end
		end
	end
end
	
do	
	local CheckInCombat = 0
	function mod:COMBAT_LOG_EVENT_UNFILTERED(event, ...)
		if select(2,...) == "UNIT_DIED" then
			if CheckInCombat == 0 then
				CheckInCombat = self:ScheduleTimer("ResetMobAddList", 1)
			end
		end
	end
	
	function mod:ResetMobAddList()
		if not UnitAffectingCombat("player") and not UnitAffectingCombat("party1") and not UnitAffectingCombat("party2") and not UnitAffectingCombat("party3") and not UnitAffectingCombat("party4") and not UnitAffectingCombat("raid1") and not UnitAffectingCombat("raid2") and not UnitAffectingCombat("raid3") and not UnitAffectingCombat("raid4") and not UnitAffectingCombat("raid5") then
			wipe(MobAddMarks)
		end
	end
	
	function mod:PLAYER_REGEN_DISABLED()
		wipe(MobAddMarks)
	end
end