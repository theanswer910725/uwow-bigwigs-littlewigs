--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("=> AutoMarks <=            ", 1279)
if not mod then return end

mod:RegisterEnableMob(
    81819, -- Everbloom Naturalist
    81820, -- Everbloom Mender
    81985, -- Everbloom Tender
    84990, -- Addled Arcanomancer
    84989, -- Infested Icecaller
    84957, -- Putrid Pyromancer
    83893, -- Earthshaper Telu
    83892 -- Life Warden Gola
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

	L.custom_off_Mob1 = "Everbloom Naturalist"
	L.custom_off_Mob2 = "Everbloom Mender"
	L.custom_off_Mob3 = "Everbloom Tender"
	L.custom_off_Mob4 = "Addled Arcanomancer"
	L.custom_off_Mob5 = "Shadowguard Voidbender"
	L.custom_off_Mob6 = "Infested Icecaller"
	L.custom_off_Mob7 = "Earthshaper Telu"
	L.custom_off_Mob8 = "Life Warden Gola"
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
	}, {
		["custom_on_Allowmarks"] = "general",
		["custom_off_Mob1"] = L.Choose,
	}
end

function mod:OnBossEnable()
	self:RegisterTargetEvents("AutoMarks")
	self:Death("MarkDeath", 81819, 81820, 81985, 84990, 84989, 84957, 83893, 83892)
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
			if (self:GetOption("custom_off_Mob1") and mobID == 81819) or (self:GetOption("custom_off_Mob2") and mobID == 81820) or (self:GetOption("custom_off_Mob3") and mobID == 81985) or (self:GetOption("custom_off_Mob4") and mobID == 84990) or (self:GetOption("custom_off_Mob5") and mobID == 84989) or (self:GetOption("custom_off_Mob6") and mobID == 84957) or (self:GetOption("custom_off_Mob7") and mobID == 83893) or (self:GetOption("custom_off_Mob8") and mobID == 83892) then
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