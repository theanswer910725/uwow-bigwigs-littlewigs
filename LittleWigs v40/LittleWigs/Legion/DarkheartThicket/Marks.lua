--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("=> AutoMarks <=        ", 1466)
if not mod then return end

mod:RegisterEnableMob(
    99358, --гнилосердная дриада
    99359, --гнилосердный хранитель
    99366, --скверносерд-призыватель
    95769, --Бешеная визгунья
    95771  --грозный разрушитель
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

	L.custom_off_Mob1 = "Rotheart Dryad"
	L.custom_off_Mob2 = "Rotheart Keeper"
	L.custom_off_Mob3 = "Taintheart Summoner"
	L.custom_off_Mob4 = "Mindshattered Screecher"
	L.custom_off_Mob5 = "Dreadsoul Ruiner"
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
	}, {
		["custom_on_Allowmarks"] = "general",
		["custom_off_Mob1"] = L.Choose,
	}
end

function mod:OnBossEnable()
	self:RegisterTargetEvents("AutoMarks")
	self:Death("MarkDeath", 99358, 99359, 99366, 95769, 95771)
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
			if (self:GetOption("custom_off_Mob1") and mobID == 99358) or (self:GetOption("custom_off_Mob2") and mobID == 99359) or (self:GetOption("custom_off_Mob3") and mobID == 99366) or (self:GetOption("custom_off_Mob4") and mobID == 95769) or (self:GetOption("custom_off_Mob5") and mobID == 95771) then
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