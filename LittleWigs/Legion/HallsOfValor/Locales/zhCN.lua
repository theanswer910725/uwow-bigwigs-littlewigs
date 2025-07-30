local L = BigWigs:NewBossLocale("Odyn", "zhCN")
if not L then return end
if L then
	L.custom_on_autotalk = "自动对话"
	L.custom_on_autotalk_desc = "立即选择对话选项开始战斗。"

	L.gossip_available = "可对话"
	L.gossip_trigger = "真了不起！没想到还有人能对抗瓦拉加尔的力量……而他们就站在我面前。"

	L.tankP = "|cFF800080右上|r (|T1323037:15:15:0:0:64:64:4:60:4:60|t)" -- Translate "Top Right"
	L.tankO = "|cFFFFA500右下|r (|T1323039:15:15:0:0:64:64:4:60:4:60|t)" -- Translate "Bottom Right"
	L.tankY = "|cFFFFFF00左下|r (|T1323038:15:15:0:0:64:64:4:60:4:60|t)" -- Translate "Bottom Left"
	L.tankB = "|cFF0000FF左上|r (|T1323035:15:15:0:0:64:64:4:60:4:60|t)" -- Translate "Top Left"
	L.tankG = "|cFF008000上|r (|T1323036:15:15:0:0:64:64:4:60:4:60|t)" -- Translate "Top"
	
	L.ddP = "|cFF800080左下|r (|T1323037:15:15:0:0:64:64:4:60:4:60|t)" -- Translate "Top Right"
	L.ddO = "|cFFFFA500左上|r (|T1323039:15:15:0:0:64:64:4:60:4:60|t)" -- Translate "Bottom Right"
	L.ddY = "|cFFFFFF00右上|r (|T1323038:15:15:0:0:64:64:4:60:4:60|t)" -- Translate "Bottom Left"
	L.ddB = "|cFF0000FF右下|r (|T1323035:15:15:0:0:64:64:4:60:4:60|t)" -- Translate "Top Left"
	L.ddG = "|cFF008000下|r (|T1323036:15:15:0:0:64:64:4:60:4:60|t)" -- Translate "Top"
end

L = BigWigs:NewBossLocale("God-King Skovald", "zhCN")
if L then
	L.warmup_text = "神王斯科瓦尔德激活"
	L.warmup_trigger = "按照传统，它已经属于胜利者了。斯科瓦尔德，你的抗议来得太迟了。"
	L.warmup_trigger_2 = "如果这些所谓的“勇士”不肯放弃圣盾……那就让他们去死吧！"
end

L = BigWigs:NewBossLocale("Halls of Valor Trash", "zhCN")
if L then
	L.custom_on_autotalk = "自动对话"
	L.custom_on_autotalk_desc = "立即选择地下城内多个对话选项。"

	L.fourkings = "四王"
	L.runecarver = "瓦拉加尔刻符者"
	L.olmyr = "启迪者奥米尔"
	L.solsten = "索斯坦"
	L.purifier = "瓦拉加尔净化者"
	L.thundercaller = "瓦拉加尔唤雷者"
	L.mystic = "瓦拉加尔秘法师"
	L.aspirant = "瓦拉加尔候选者"
	L.drake = "风暴幼龙"
	L.marksman = "瓦拉加尔神射手"
	L.trapper = "瓦拉加尔捕兽者"
	L.sentinel = "雷铸斥候"
	L.Kings = "准备与 %s 对话"
	L.Check = "!kings"
	L.Start = "!pull"
	L.Reply = "可以激活（聊天命令由队长开启对话）"
	L.Function = "此功能已关闭"
	L.custom_off_multiple_kings = "禁用与小Boss的自动对话，通过队长在聊天中激活"
	L.custom_off_multiple_kings_desc = "在聊天中输入 |cffff0000!kings|r 检查谁启用了此功能。打开小Boss的对话框，等待队长发送 |cffff0000!pull|r 命令，即可同时激活所有小Boss，|cffff0000请确保关闭其他插件（如 AngryKeystones）的自动跳过对话|r|cff00ff00    => 聊天命令仅适用于小队聊天频道，由队长使用 <=|r"
	L.warmup_trigger1 = "赫娅……你来执掌风暴的怒火！"
	L.warmup_trigger2 = "愿圣光永远照耀你，赫娅！"

end

-- TODO : Verify locales for the Opera Hall bosses
L = BigWigs:NewBossLocale("Opera Hall: Westfall Story", "zhCN") 
if L then
	L.warmup_text = "So ya wanna rumble, do ya?"
	L.warmup_trigger = "So ya wanna rumble, do ya?"
end

L = BigWigs:NewBossLocale("=> AutoMarks <=         ", "zhCN")
if L then
	L.custom_on_Allowmarks = "标记选定小怪"
	L.custom_on_Allowmarks_desc = "用 {rt1}{rt2}{rt3}{rt4}{rt5}{rt6}{rt7} 标记小怪，你需要是助理或领袖"
	L.custom_off_RequireLead = "仅由我（领袖）操作"
	L.custom_off_CombatMarking  = "仅标记战斗中的小怪"
	
	L.Choose = "请选择需要标记的小怪"
	
	L.custom_off_Mob1 = "瓦拉加尔秘法师"
	L.custom_off_Mob2 = "瓦拉加尔净化者"
	L.custom_off_Mob3 = "瓦拉加尔唤雷者"
	L.custom_off_Mob4 = "瓦拉加尔神射手"
	L.custom_off_Mob5 = "四王"
end