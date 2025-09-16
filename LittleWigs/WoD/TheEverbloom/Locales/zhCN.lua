local L = BigWigs:NewBossLocale("Witherbark", "zhCN")
if not L then return end
if L then
	L.energyStatus = "小水滴到达枯木：%d%% 能量"
end

L = BigWigs:NewBossLocale("The Everbloom Trash", "zhCN")
if L then
	L.dreadpetal = "恐瓣"
	L.everbloom_naturalist = "永茂博学者"
	L.everbloom_cultivator = "永茂栽培者"
	L.rockspine_stinger = "石脊钉刺者"
	L.everbloom_mender = "永茂栽培者"
	L.gnarlroot = "瘤根"
	L.melded_berserker = "融合狂战士"
	L.twisted_abomination = "扭曲的憎恶"
	L.infested_icecaller = "被感染的唤冰者"
	L.putrid_pyromancer = "腐烂的炎术士"
	L.addled_arcanomancer = "疯狂的奥法师"

	L.gate_open_desc = "显示下级法师克萨伦何时打开通往雅努大门的计时条。"
	L.yalnu_warmup_trigger = "传送门失守了！我们必须在这头野兽逃跑前阻止它！"
end

local L = BigWigs:NewBossLocale("Ancient Protectors", "zhCN")
if not L then return end
if L then
	L.custom_off_always_show_casts = "始终显示 |cff71d5ff自然之怒|r/|cff71d5ff水箭|r 的目标。"
end

L = BigWigs:NewBossLocale("=> AutoMarks <=            ", "zhCN")
if L then
	L.custom_on_Allowmarks = "标记选定小怪"
	L.custom_on_Allowmarks_desc = "用 {rt1}{rt2}{rt3}{rt4}{rt5}{rt6}{rt7} 标记小怪，你需要是助理或领袖"
	L.custom_off_RequireLead = "仅由我（领袖）操作"
	L.custom_off_CombatMarking  = "仅标记战斗中的小怪"
	
	L.Choose = "请选择需要标记的小怪"
	
	L.custom_off_Mob1 = "永茂博学者"
	L.custom_off_Mob2 = "永茂栽培者"
	L.custom_off_Mob3 = "永茂栽培者"
	L.custom_off_Mob4 = "疯狂的奥法师"
	L.custom_off_Mob5 = "被感染的唤冰者"
	L.custom_off_Mob6 = "腐烂的炎术士"
	L.custom_off_Mob7 = "塑地者特鲁"
	L.custom_off_Mob8 = "生命守卫高拉"
end