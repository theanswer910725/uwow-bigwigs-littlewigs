local L = BigWigs:NewBossLocale("Maw of Souls Trash", "zhCN")
if not L then return end
if L then
	L.soulkeeper = "海咒护魂者"
	L.soulguard = "浸水的灵魂卫士"
	L.champion = "海拉加尔勇士"
	L.mariner = "守夜水手"
	L.swiftblade = "海咒快刀手"
	L.mistmender = "海咒雾疗师"
	L.mistcaller = "海拉加尔召雾者"
	L.slaver = "海咒奴隶"
	L.skjal = "斯卡加尔"
end

L = BigWigs:NewBossLocale("=> AutoMarks <=         ", "zhCN")
if L then
	L.custom_on_Allowmarks = "标记选定小怪"
	L.custom_on_Allowmarks_desc = "用 {rt1}{rt2}{rt3}{rt4}{rt5}{rt6}{rt7} 标记小怪，你需要是助理或领袖"
	L.custom_off_RequireLead = "仅由我（领袖）操作"
	L.custom_off_CombatMarking  = "仅标记战斗中的小怪"
	
	L.Choose = "请选择需要标记的小怪"
	
	L.custom_off_Mob1 = "海咒奴隶"
	L.custom_off_Mob2 = "守夜水手"
	L.custom_off_Mob3 = "海拉加尔勇士"
	L.custom_off_Mob4 = "被禁锢的仆从"
	L.custom_off_Mob5 = "毁灭触须"
end
