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
end


L = BigWigs:NewBossLocale("Thalena", "zhCN")
if L then
	L.essence = "精华"
end
