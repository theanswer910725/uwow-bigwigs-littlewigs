local L = BigWigs:NewBossLocale("The Arcway Trash", "zhCN")
if not L then return end
if L then
	L.unstable = "不稳定的软泥怪"
	L.unstable = "不稳定的融合体"
	L.nightborne = "夜之子复国者"
	L.anomaly = "奥术畸体"
	L.shade = "迁跃之影"
	L.wraith = "枯法法力怨灵"
	L.blade = "愤怒卫士邪刃者"
	L.seer = "恐裔先知"
	L.chaosbringer = "艾瑞达混沌使者"
	-- TODO 待验证台词 此台词在玩家 ​首次进入副本下层墓穴通道​（坐标约 X:50, Y:60）时触发
	L.warmup_trigger = "啧啧……瞧瞧这乱糟糟的样子。我们太久没清理墓穴里的垃圾了。看来是有老鼠在作祟。"
end


L = BigWigs:NewBossLocale("=> AutoMarks <=    ", "zhCN")
if L then
	L.custom_on_Allowmarks = "标记选定小怪"
	L.custom_on_Allowmarks_desc = "用 {rt1}{rt2}{rt3}{rt4}{rt5}{rt6}{rt7} 标记小怪，你需要是助理或领袖"
	L.custom_off_RequireLead = "仅由我（领袖）操作"
	L.custom_off_CombatMarking  = "仅标记战斗中的小怪"
	
	L.Choose = "请选择需要标记的小怪"
	
	
	L.custom_off_Mob1 = "被遗忘的幽灵"
	L.custom_off_Mob2 = "艾瑞达混沌使者"
	L.custom_off_Mob3 = "枯法法力怨灵"
	L.custom_off_Mob4 = "迁跃之影"
	L.custom_off_Mob5 = "奥术畸体"
	L.custom_off_Mob6 = "夜之子复国者"
end
