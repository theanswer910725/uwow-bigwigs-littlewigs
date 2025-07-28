--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("=> AutoMarks <=  ", 1493)
if not mod then return end

mod:RegisterEnableMob(
	99956,  --Зараженный скверной яростный боец
    96587,  --Скверноподданный заразитель
    113552, --Перегруженная линза
    107101, --Ярость Скверны
    99644,  --Страж Скверны - уничтожитель
    99645,  --Техник из клана Призрачной Луны
    99704,  --Чернокнижник из клана Призрачной Луны
    99657,  --Безумный пожиратель разума
    99651,  --Безликий маг Бездны
    99676,  --Хранитель тайн Могу'шан
    100364, --Дух отмщения
    98177  --Терзательница душ Глевианна
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

	L.custom_off_Mob1 = "Fel-Infused Fury"
	L.custom_off_Mob2 = "Felsworn Infester"
	L.custom_off_Mob3 = "Overloaded Lens"
	L.custom_off_Mob4 = "Fel Fury"
	L.custom_off_Mob5 = "Felguard Annihilator"
	L.custom_off_Mob6 = "Shadowmoon Technician"
	L.custom_off_Mob7 = "Shadowmoon Warlock"
	L.custom_off_Mob8 = "Deranged Mindflayer"
	L.custom_off_Mob9 = "Faceless Voidcaster"
	L.custom_off_Mob10 = "Mogu'shan Secret-Keeper"
	L.custom_off_Mob11 = "Spirit of Vengeance"
	L.custom_off_Mob12 = "Glayvianna Soulrender"
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
		"custom_off_Mob12",
	}, {
		["custom_on_Allowmarks"] = "general",
		["custom_off_Mob1"] = L.Choose,
	}
end

function mod:OnBossEnable()
	self:RegisterTargetEvents("AutoMarks")
	self:Death("MarkDeath", 99956, 96587, 113552, 107101, 99644, 99645, 99704, 99657, 99651, 99676, 100364, 98177)
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
			if (self:GetOption("custom_off_Mob1") and mobID == 99956) or (self:GetOption("custom_off_Mob2") and mobID == 96587) or (self:GetOption("custom_off_Mob3") and mobID == 113552) or (self:GetOption("custom_off_Mob4") and mobID == 107101) or (self:GetOption("custom_off_Mob5") and mobID == 99644) or (self:GetOption("custom_off_Mob6") and mobID == 99645) or (self:GetOption("custom_off_Mob7") and mobID == 99704) or (self:GetOption("custom_off_Mob8") and mobID == 99657) or (self:GetOption("custom_off_Mob9") and mobID == 99651) or (self:GetOption("custom_off_Mob10") and mobID == 99676) or (self:GetOption("custom_off_Mob11") and mobID == 100364) or (self:GetOption("custom_off_Mob12") and mobID == 98177) then
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