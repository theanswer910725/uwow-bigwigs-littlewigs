local L = BigWigs:NewBossLocale("Eye of Azshara Trash", "zhCN")
if not L then return end
if L then
	L.gritslime = "砂泥蜗牛
	L.wrangler = "积怨牧鱼者"
	L.stormweaver = "积怨织雷者"
	L.crusher = "积怨碾压者"
	L.oracle = "积怨神谕者"
	L.siltwalker = "玛拉纳沙地行者"
	L.tides = "焦躁的海潮元素"
	L.arcanist = "积怨奥术师"
end

L = BigWigs:NewBossLocale("Lady Hatecoil", "zhCN")
if L then
	L.custom_on_show_helper_messages = "静电新星和凝聚闪电帮助信息"
	L.custom_on_show_helper_messages_desc = "启用此选项当首领开始施放|cff71d5ff静电新星|r或|cff71d5ff凝聚闪电|r时添加告知自身水中或沙丘安全的信息。"

	L.water_safe = "%s（水中安全）"
	L.land_safe = "%s（沙丘安全）"
end


L = BigWigs:NewBossLocale("=> AutoMarks <=", "zhCN")
if L then
	L.custom_on_Allowmarks = "标记选定小怪"
	L.custom_on_Allowmarks_desc = "用 {rt1}{rt2}{rt3}{rt4}{rt5}{rt6}{rt7} 标记小怪，你需要是助理或领袖"
	L.custom_off_RequireLead = "仅由我（领袖）操作"
	L.custom_off_CombatMarking  = "仅标记战斗中的小怪"
	
	L.Choose = "请选择需要标记的小怪"
	
	L.custom_off_HatecoilStormweaver = "积怨织雷者"
	L.custom_off_HatecoilArcanist = "积怨奥术师"
	L.custom_off_MakranaHardshell = "玛拉纳硬壳战士"
	L.custom_off_Ritualmobs = "尾王附近的仪式小怪"
end