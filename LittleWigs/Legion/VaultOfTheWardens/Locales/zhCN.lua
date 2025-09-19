local L = BigWigs:NewBossLocale("Cordana Felsong", "zhCN")
if not L then return end
if L then
	L.kick_combo = "连环踢"

	L.light_dropped = "%s 丢掉了艾露恩之光。"
	L.light_picked = "%s 拾取了艾露恩之光。"

	L.warmup_text = "科达娜·邪歌激活"
	L.warmup_trigger = "我拿到想要的东西了。但我要留下来了结你们……永除后患！"
	L.warmup_trigger_2 = "你们掉进了我的陷阱。让我看看你们在黑暗中的本事吧。"
	L.warmup_trigger_3 = "果然不出我所料！我就知道你会来。"
end

L = BigWigs:NewBossLocale("Glazer", "zhCN")
if L then
	L.radiation_level = "%s：%d%%"
end

L = BigWigs:NewBossLocale("Tirathon Saltheril", "zhCN")
if L then
	L.warmup_trigger = "我为人民而战，为那些被放逐和唾弃的人而战。"
	L.warmup_trigger2 = "我献出了我的血肉，我的灵魂，我的族人却把我视为怪物。"
end

L = BigWigs:NewBossLocale("Vault of the Wardens Trash", "zhCN")
if L then
	L.soulrender = "格雷凡纳·裂魂"
	L.infester = "魔誓寄生者"
	L.myrmidon = "魔誓侍从"
	L.fury = "灌魔之怒"
	L.mother = "邪母"
	L.illianna = "刃舞者伊莲娜"
	L.mendacius = "恐惧魔王孟达休斯"
	L.grimhorn = "奴役者格里霍恩"
end

L = BigWigs:NewBossLocale("=> AutoMarks <=    ", "zhCN")
if L then
	L.custom_on_Allowmarks = "标记选定小怪"
	L.custom_on_Allowmarks_desc = "用 {rt1}{rt2}{rt3}{rt4}{rt5}{rt6}{rt7} 标记小怪，你需要是助理或领袖"
	L.custom_off_RequireLead = "仅由我（领袖）操作"
	L.custom_off_CombatMarking  = "仅标记战斗中的小怪"

	L.Choose = "请选择需要标记的小怪"
	
	L.custom_off_Mob1 = "灌魔之怒"
	L.custom_off_Mob2 = "魔誓寄生者"
	L.custom_off_Mob3 = "过载的透镜"
	L.custom_off_Mob4 = "邪能之怒"
	L.custom_off_Mob5 = "恶魔卫士歼灭者"
	L.custom_off_Mob6 = "影月技师"
	L.custom_off_Mob7 = "影月术士"
	L.custom_off_Mob8 = "疯狂的夺心者"
	L.custom_off_Mob9 = "无面虚空法师"
	L.custom_off_Mob10 = "魔古山藏秘者"
	L.custom_off_Mob11 = "复仇之魂"
	L.custom_off_Mob12 = "格雷凡纳·裂魂"
end
