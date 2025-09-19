local L = BigWigs:NewBossLocale("Black Rook Hold Trash", "zhCN")
if not L then return end
if L then
	L.arcanist = "复活的奥术师"
	L.champion = "失魂的勇士"
	L.swordsman = "复活的剑士"
	L.archer = "复活的弓箭手"
	L.scout = "复活的斥候"
	L.councilor = "幽灵顾问"
	L.dominator = "魔怨支配者"
	L.warmup_text = "最后一批滚石！"  -- "The last boulders !"
	L.warmup_trigger = "哈！我们会用这些大石头解决他们的！！"  -- "Ha! We'll get 'em wit' these big rocks!"
	L.warmup_trigger2 = "啊！他们来了！快跑！！"  -- "Ahh! They coming! RUN!"
	L.warmup_trigger3 = "啊！我们很抱歉！我们保证！"  -- "AHHH! WE SORRY! WE PROMISE!"
 	-- TODO 需要在黑鸦堡垒进行台词验证
	L.warmup_trigger4 = "黑暗……它消失了。"  -- "The darkness... it is gone."
end

L = BigWigs:NewBossLocale("Amalgam of Souls", "zhCN")
if L then
end

L = BigWigs:NewBossLocale("Illysanna Ravencrest", "zhCN")
if L then
end

L = BigWigs:NewBossLocale("Kurtalos Ravencrest", "zhCN")
if L then
	L.phase_2_trigger = "够了！我受够了。" 
end

L = BigWigs:NewBossLocale("=> AutoMarks <=     ", "zhCN")
if L then
	L.custom_on_Allowmarks = "标记选定小怪"
	L.custom_on_Allowmarks_desc = "用 {rt1}{rt2}{rt3}{rt4}{rt5}{rt6}{rt7} 标记小怪，你需要是助理或领袖"
	L.custom_off_RequireLead = "仅由我（领袖）操作"
	L.custom_off_CombatMarking  = "仅标记战斗中的小怪"
	
	L.Choose = "请选择需要标记的小怪"
	
	L.custom_off_Mob1 = "复活的小伙伴"
	L.custom_off_Mob2 = "复活的斥候"
	L.custom_off_Mob3 = "复活的长枪兵"
	L.custom_off_Mob4 = "魔怨支配者"
	L.custom_off_Mob5 = "愤怒卫士剑圣"
	L.custom_off_Mob6 = "幽灵顾问"
	L.custom_off_Mob7 = "失魂的勇士"
end
