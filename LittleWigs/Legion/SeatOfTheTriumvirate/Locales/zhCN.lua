local L = BigWigs:NewBossLocale("Viceroy Nezhar", "zhCN")
if not L then return end
if L then
	L.tentacles = "触须"
	L.guards = "影卫"
	L.interrupted = "%s已打断%s（%.1f秒剩余）！"
end

L = BigWigs:NewBossLocale("L'ura", "zhCN")
if L then
	L.warmup_text = "鲁拉激活"
	L.warmup_trigger = "如此混乱……如此痛苦。我从未体验过这种感受。"
	L.warmup_trigger_2 = "这些可以稍后再想。但它必须死。"
	L.warmup_trigger_3 = "敌人来了！"
	L.warmup_trigger_4 = "小心！"
end

L = BigWigs:NewBossLocale("Zuraal", "zhCN")
if L then
	L.custom_on_autotalk = "自动对话"
	L.custom_on_autotalk_desc = "立即选择奥蕾莉亚·风行者对话选项。"
	L.gossip_available = "可对话"
	L.alleria_gossip_trigger = "跟我走！" -- Allerias yell after the first boss is defeated
	L.warmup_text_2 = "奥蕾莉亚激活"
	L.warmup_trigger_5 = "跟我走！"

	L.alleria = "奥蕾莉亚·风行者"
end


L = BigWigs:NewBossLocale("Seat of the Triumvirate Trash", "zhCN")
if L then
	L.custom_on_autotalk = "自动对话"
	L.custom_on_autotalk_desc = "立即选择奥蕾莉亚·风行者对话选项。"
	L.gossip_available = "可对话"
	L.alleria_gossip_trigger = "跟我走！" -- Allerias yell after the first boss is defeated
	L.warmup_text_2 = "奥蕾莉亚激活"
	L.warmup_trigger_5 = "跟我走！"
	L.warmup_trigger_6 = "我感觉里面散发出强烈的绝望。鲁拉……"
	
	L.alleria = "奥蕾莉亚·风行者"
	L.subjugator = "影卫征服者"
	L.voidbender = "影卫缚灵师"
	L.conjurer = "影卫召唤师"
	L.weaver = "大织影者"
end

L = BigWigs:NewBossLocale("=> AutoMarks <=           ", "zhCN")
if L then
	L.custom_on_Allowmarks = "标记选定小怪"
	L.custom_on_Allowmarks_desc = "用 {rt1}{rt2}{rt3}{rt4}{rt5}{rt6}{rt7} 标记小怪，你需要是助理或领袖"
	L.custom_off_RequireLead = "仅由我（领袖）操作"
	L.custom_off_CombatMarking  = "仅标记战斗中的小怪"
	
	L.Choose = "请选择需要标记的小怪"

	L.custom_off_Mob1 = "裂隙守护者"
	L.custom_off_Mob2 = "大型裂隙守护者"
	L.custom_off_Mob3 = "影卫勇士"
	L.custom_off_Mob4 = "暗影触须"
	L.custom_off_Mob5 = "影卫缚灵师"
	L.custom_off_Mob6 = "织影者精华"
end