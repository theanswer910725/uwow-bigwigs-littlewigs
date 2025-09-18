local L = BigWigs:NewBossLocale("Assault on Violet Hold Trash", "zhCN")
if not L then return end
if L then
	L.custom_on_autotalk = "自动对话"
	L.custom_on_autotalk_desc = "立即选择辛克莱尔中尉对话选项开始突袭紫罗兰监狱。"
	L.keeper = "传送门看护者"
	L.guardian = "传送门守卫者"
	L.infernal = "炽热的地狱火"
end

local L = BigWigs:NewBossLocale("===>>>>  PARTY INFO  <<<<===", "zhCN")
if not L then return end
if L then
	L.custom_on_autokeystone = "根据倒计时自动启动钥匙。"
	L.custom_on_autokeystone_desc = "与 Exrt 和 BigWigs 的倒计时配合使用。倒计时必须来自要启动钥匙的工具！"
	L.custom_on_autosave = "获取战利品后自动保存（间隔不得少于 20 秒）。"
	L.custom_on_announcement = "|cff00ff00开启|r/|cffff0000关闭|r 所有团队公告"
	L.WarlockPets = "术士宠物（打断、驱散）"
	L.Bloodlust = "嗜血（或类似效果）"
	L.Portals = "法师传送门"
	L.Rituals = "仪式"
	L.BattleRes = "战斗复活"
	L.Reaves = "维修、重生"
	L.difficulty = "|cffff00ff[LittleWigs]|r|cff00ff00 您可以更新难度 |r|cffff0000（所有玩家已离开地下城）|r"
	L.diff = "|cffff00ff[LittleWigs]|r|cff00ff00 已设置地下城难度：史诗 |r"
	L.chatdiff = "已设置地下城难度：史诗"
	L.chatdiffRW = "[LittleWigs] 已设置地下城难度：史诗"
	L.refresh = "|cff00ff00 钥匙使用后难度更新公告 |r|cffff0000（团队领袖）|r"

	
	L.custom_on_autoRIO = "当有人私聊你时自动进行大秘境分数检查（.ch）"
	L.custom_on_autoRIO_desc = "仅显示名字与大秘境分数。对每个玩家最多提示一次。"
	L.custom_off_autoRIOfullch = "当有人私聊你时，禁用大秘境分数信息的简略显示（.ch）"
	L.custom_off_autoRIOlfg = "仅在 集合石 中使用时，当有人私聊你时自动进行大秘境分数检查（.ch）（需要你为队长或助理）"
	L.custom_off_autoRIOlfg_desc = "仅显示名字与大秘境分数。对每个玩家最多提示一次。"
	L.custom_on_autoLFG = "自动创建 集合石"
	L.custom_on_autoLFG_desc = "当你将钥石链接到综合频道后，将根据该钥石信息自动开启并填写一个 集合石 活动。"

	L.KarazhanEvent1 = "[LittleWigs] 本周为“锅碗瓢盆”
	L.KarazhanSequence1 = "|cffff00ff [LittleWigs]|r|cff00ff00 卡拉赞Boss顺序：锅碗瓢盆） -> 魔法坏女巫 -> 托尼|r"
	L.KarazhanEvent2 = "[LittleWigs] 本周为“魔法坏女巫"
	L.KarazhanSequence2 = "|cffff00ff [LittleWigs]|r|cff00ff00 卡拉赞Boss顺序：魔法坏女巫 -> 托尼 -> 锅碗瓢盆|r"
	L.KarazhanEvent3 = "[LittleWigs] 本周为“托尼"
	L.KarazhanSequence3 = "|cffff00ff [LittleWigs]|r|cff00ff00 卡拉赞Boss顺序：托尼 -> 锅碗瓢盆 -> 魔法坏女巫|r"

	L.LeftSideChat = "[LittleWigs] <<<=== 左"
	L.RightSideChat = "[LittleWigs] 右 ===>>>"
	L.LeftSide = "|cffff00ff [LittleWigs]|r|cff00ff00 <<<=== 左|r"
	L.RightSide = "|cffff00ff [LittleWigs]|r|cff00ff00 右 ===>>>|r"

end


L = BigWigs:NewBossLocale("Thalena", "zhCN")
if L then
	L.essence = "精华"
end
