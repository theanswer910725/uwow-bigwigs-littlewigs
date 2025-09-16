local L = BigWigs:NewBossLocale("Neltharions Lair Trash", "ruRU")
if not L then return end
if L then
	L.breaker = "Крушитель из племени Камня Силы"
	--L.hulk = "Vileshard Hulk"
	--L.gnasher = "Rockback Gnasher"
	--L.trapper = "Rockbound Trapper"
	L.emberhusk = "Emberhusk Dominator"
	L.vicious_manafang = "Ползун из чумных осколков"
end

L = BigWigs:NewBossLocale("Rokmora", "ruRU")
if L then
	L.warmup_text = "Рокмора активна"
	L.warmup_trigger = "Наваррогг?! Предатель, ты привел к нам чужаков?!"
	L.warmup_trigger_2 = "Меня устроят оба варианта! Рокмора, убей их!"
end

L = BigWigs:NewBossLocale("Ularogg Cragshaper", "ruRU")
if L then
	L.totems = "Тотемы"
	L.bellow = "{193375} (Тотемы)" -- Bellow of the Deeps (Totems)
end

L = BigWigs:NewBossLocale("=> AutoMarks <=      ", "ruRU")
if L then
	L.custom_on_Allowmarks = "Разрешить маркировать выбранных мобов"
	L.custom_on_Allowmarks_desc = "Отмечать мобов с помощью {rt1}{rt2}{rt3}{rt4}{rt5}{rt6}{rt7}, нужно быть помощником или лидером"
	L.custom_off_RequireLead = "Только если я лидер"
	L.custom_off_CombatMarking  = "Отмечать только тех, кто в бою"
	
	L.Choose = "Выберите, каких мобов отмечать"
	
	L.custom_off_Mob1 = "Скальный зверолов"
	L.custom_off_Mob2 = "Камнеспинный щелкозуб"
	L.custom_off_Mob3 = "Личинка смолоплюя"
	L.custom_off_Mob4 = "Преданный червепоклонник"
	L.custom_off_Mob5 = "Злобнозем-исполин"
	L.custom_off_Mob6 = "Гнилослюнный червь"
	L.custom_off_Mob7 = "Заклинатель чумных осколков"
end
