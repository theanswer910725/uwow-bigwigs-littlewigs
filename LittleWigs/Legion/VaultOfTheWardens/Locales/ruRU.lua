local L = BigWigs:NewBossLocale("Cordana Felsong", "ruRU")
if not L then return end
if L then
	L.kick_combo = "Комбо удар"

	L.light_dropped = "%s выронил Свет."
	L.light_picked = "%s поднял Свет."

	L.warmup_text = "Кордана Оскверненная Песнь активна"
	L.warmup_trigger = "Я уже получила то, за чем пришла. Но осталась, чтобы покончить с вами… раз и навсегда!"
	L.warmup_trigger_2 = "И вы угодили в мою ловушку. Посмотрим, на что вы способны в темноте."
	L.warmup_trigger_3 = "Как предсказуемо! Я знала, что вы придете."
end

L = BigWigs:NewBossLocale("Glazer", "ruRU")
if L then
	--L.radiation_level = "%s: %d%%"
end

L = BigWigs:NewBossLocale("Tirathon Saltheril", "ruRU")
if L then
	L.warmup_trigger = "И я служу своему народу: изгнанным и отверженным."
	L.warmup_trigger2 = "Я пожертвовал телом и душой. Мой народ отверг меня."
end

L = BigWigs:NewBossLocale("Vault of the Wardens Trash", "ruRU")
if L then
	L.soulrender = "Терзательница душ Глевианна"
	L.infester = "Скверноподданный заразитель"
	L.myrmidon = "Скверноподданный мирмидон"
	L.fury = "Зараженный Скверной яростный боец"
	L.mother = "Темная мать"
	L.illianna = "Иллиана Танцующая с Клинками"
	L.mendacius = "Повелитель ужаса Мендаций"
	L.grimhorn = "Злобнорог Поработитель"
end

L = BigWigs:NewBossLocale("=> AutoMarks <=  ", "ruRU")
if L then
	L.custom_on_Allowmarks = "Разрешить маркировать выбранных мобов"
	L.custom_on_Allowmarks_desc = "Отмечать мобов с помощью {rt1}{rt2}{rt3}{rt4}{rt5}{rt6}{rt7}, нужно быть помощником или лидером"
	L.custom_off_RequireLead = "Только если я лидер"
	L.custom_off_CombatMarking  = "Отмечать только тех, кто в бою"
	
	L.Choose = "Выберите, каких мобов отмечать"
	
	L.custom_off_Mob1 = "Зараженный скверной яростный боец"
	L.custom_off_Mob2 = "Скверноподданный заразитель"
	L.custom_off_Mob3 = "Перегруженная линза"
	L.custom_off_Mob4 = "Ярость Скверны"
	L.custom_off_Mob5 = "Страж Скверны - уничтожитель"
	L.custom_off_Mob6 = "Техник из клана Призрачной Луны"
	L.custom_off_Mob7 = "Чернокнижник из клана Призрачной Луны"
	L.custom_off_Mob8 = "Безумный пожиратель разума"
	L.custom_off_Mob9 = "Безликий маг Бездны"
	L.custom_off_Mob10 = "Хранитель тайн Могу'шан"
	L.custom_off_Mob11 = "Дух отмщения"
	L.custom_off_Mob12 = "Терзательница душ Глевианна"
end
