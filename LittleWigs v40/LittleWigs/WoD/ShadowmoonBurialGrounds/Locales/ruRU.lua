local L = BigWigs:NewBossLocale("Sadana Bloodfury", "ruRU")
if not L then return end
if L then
	L.custom_on_markadd = "Ставить метку на адда от Темного контакта"
	L.custom_on_markadd_desc = "Ставит {rt8} на адда, призванного Темным контактом, нужно быть лидером группы или помощником."
end

L = BigWigs:NewBossLocale("Bonemaw", "ruRU")
if L then
	L.summon_worms = "Призыв помощников"
	L.summon_worms_desc = "Костебрюх призывает двух червей-трупоедов"
	L.summon_worms_trigger = "привлекает ближайших червей-трупоедов"

	L.submerge = "Погружение"
	L.submerge_desc = "Костебрюх погружается и появляется в другом месте"
	L.submerge_trigger = "шипит и уползает обратно в темные глубины!"
end

L = BigWigs:NewBossLocale("Shadowmoon Burial Grounds Trash", "ruRU")
if L then
	L.shadowmoon_bonemender = "Подчинитель костей из клана Призрачной Луны"
	L.reanimated_ritual_bones = "Оживленные ритуальные кости"
	L.void_spawn = "Дитя Бездны"
	L.shadowmoon_loyalist = "Верная служительница из клана Призрачной Луны"
	L.defiled_spirit = "Оскверненный дух"
	L.shadowmoon_dominator = "Поработитель из клана Призрачной Луны"
	L.shadowmoon_exhumer = "Извлекатель душ из клана Призрачной Луны"
	L.exhumed_spirit = "Эксгумированный дух"
	L.monstrous_corpse_spider = "Чудовищный трупный паук"
	L.carrion_worm = "Червь-трупоед"
end

L = BigWigs:NewBossLocale("=> AutoMarks <=             ", "ruRU")
if L then
	L.custom_on_Allowmarks = "Разрешить маркировать выбранных мобов"
	L.custom_on_Allowmarks_desc = "Отмечать мобов с помощью {rt1}{rt2}{rt3}{rt4}{rt5}{rt6}{rt7}, нужно быть помощником или лидером"
	L.custom_off_RequireLead = "Только если я лидер"
	L.custom_off_CombatMarking  = "Отмечать только тех, кто в бою"
	
	L.Choose = "Выберите, каких мобов отмечать"
	
	L.custom_off_Mob1 = "Подчинитель костей из клана Призрачной Луны"
	L.custom_off_Mob2 = "Эксгумированный дух"
	L.custom_off_Mob3 = "Верная служительница из клана Призрачной Луны"
	L.custom_off_Mob4 = "Поработитель из клана Призрачной Луны"
	L.custom_off_Mob5 = "Извлекатель душ из клана Призрачной Луны"
	L.custom_off_Mob6 = "Чудовищный трупный паук"
end
