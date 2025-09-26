local L = BigWigs:NewBossLocale("Neltharions Lair Trash", "zhCN")
if not L then return end
if L then
	L.breaker = "巨石破坏者"
	L.hulk = "邪裂巨人"
	L.gnasher = "岩背啮咬者"
	L.trapper = "缚石捕兽者"
	L.emberhusk = "烬壳统御者"
	L.vicious_manafang = "枯碎蜘蛛"
end

L = BigWigs:NewBossLocale("Rokmora", "zhCN")
if L then
	L.warmup_text = "洛克莫拉激活"
	L.warmup_trigger = "纳瓦罗格？！叛徒！你想带领这些入侵者对抗我们吗？！"
	L.warmup_trigger_2 = "无论如何，我都会好好享受它每一刻的。洛克莫拉，碾碎他们！"
end

L = BigWigs:NewBossLocale("Ularogg Cragshaper", "zhCN")
if L then
	L.totems = "雕像"
	L.bellow = "{193375}（雕像）" -- Bellow of the Deeps (Totems)
end

L = BigWigs:NewBossLocale("=> AutoMarks <=      ", "zhCN")
if L then
	L.custom_on_Allowmarks = "标记选定小怪"
	L.custom_on_Allowmarks_desc = "用 {rt1}{rt2}{rt3}{rt4}{rt5}{rt6}{rt7} 标记小怪，你需要是助理或领袖"
	L.custom_off_RequireLead = "仅由我（领袖）操作"
	L.custom_off_CombatMarking  = "仅标记战斗中的小怪"
	
	L.Choose = "请选择需要标记的小怪"
	L.custom_off_Mob1 = "缚石捕兽者"
	L.custom_off_Mob2 = "岩背啮咬者"
	L.custom_off_Mob3 = "喷油蛆虫"
	L.custom_off_Mob4 = "虫语虔信者"
	L.custom_off_Mob5 = "邪裂巨人"
	L.custom_off_Mob6 = "腐涎劫掠者"
	L.custom_off_Mob7 = "枯碎塑造者"
end
