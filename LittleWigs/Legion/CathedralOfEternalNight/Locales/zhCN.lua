local L = BigWigs:NewBossLocale("Mephistroth", "zhCN")
if not L then return end
if L then
	L.custom_on_time_lost = "暗影消退计时"
	L.custom_on_time_lost_desc = "显示暗影消退为|cffff0000红色|r计时条。"
end

L = BigWigs:NewBossLocale("Domatrax", "zhCN")
if L then
	L.custom_on_autotalk = "自动对话"
	L.custom_on_autotalk_desc = "立即选择阿格拉玛之盾对话开始与多玛塔克斯战斗。"
	L.custom_off_timer_for_cast = "通过 SAY 指令播报 |cff71d5ff混沌能量|r 结束倒计时"
	L.missing_aegis = "你没站在盾内" -- Aegis is a short name for Aegis of Aggramar
	L.aegis_healing = "盾：降低治疗"
	L.aegis_damage = "盾：降低伤害"
end

L = BigWigs:NewBossLocale("Cathedral of Eternal Night Trash", "zhCN")
if L then
	L.dulzak = "杜尔扎克"
	L.stranglevine = "绞藤鞭笞者"
	L.dreadhunter = "恐怖猎手"
	L.wrathguard = "愤怒卫士入侵者"
	L.felguard = "恶魔卫士毁灭者"
	L.soulmender = "鬼火慰魂者"
	L.temptress = "鬼焰女妖"
	L.botanist = "邪脉植物学家"
	L.orbcaster = "邪足晶球法师"
	L.waglur = "瓦格鲁尔"
	L.scavenger = "虫语清道夫"
	L.helblaze = "鬼火邪能使者"
	L.gazerax = "加泽拉克斯"
	L.vilebark = "邪皮行者"

	L.throw_tome = "投掷宝典" -- Common part of Throw Arcane/Frost/Silence Tome (242837/242839/242841)
end

L = BigWigs:NewBossLocale("=> AutoMarks <=       ", "zhCN")
if L then
	L.custom_on_Allowmarks = "标记选定小怪"
	L.custom_on_Allowmarks_desc = "用 {rt1}{rt2}{rt3}{rt4}{rt5}{rt6}{rt7} 标记小怪，你需要是助理或领袖"
	L.custom_off_RequireLead = "仅由我（领袖）操作"
	L.custom_off_CombatMarking  = "仅标记战斗中的小怪"
	
	L.Choose = "请选择需要标记的小怪"
	
	L.custom_off_Mob1 = "鬼火慰魂者"
	L.custom_off_Mob2 = "恐怖猎手"
	L.custom_off_Mob3 = "邪脉植物学家"
	L.custom_off_Mob4 = "鬼火邪能使者"
	L.custom_off_Mob5 = "鬼焰女妖"
	L.custom_off_Mob6 = "邪足晶球法师"
	L.custom_off_Mob7 = "纳尔莎"
end
