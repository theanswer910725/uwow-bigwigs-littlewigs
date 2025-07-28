local L = BigWigs:NewBossLocale("Karazhan Trash", "ruRU")
if not L then return end
if L then
	L.confluence = "Скопление маны"
	L.charger = "Призрачный конь"
	L.skeletalUsher = "Гниющий билетер"
	L.spectral = "Призрачный эконом"
	L.custom_on_autotalk = "Авторазговор"
	L.custom_on_autotalk_desc = "Мгновенно выбирает вариант разговора Барнса, чтобы запустить встречу в оперном зале."
	L.attendant = "Призрачный смотритель"
	L.hostess = "Благонравная горничная"
	L.SpectralStableHand = "Призрачный помощник смотрителя стойл"
	L.opera_hall_westfall_story_text = "(Тонни)Оперный зал: Однажды в Западном Крае"
	L.opera_hall_westfall_story_trigger = "Они родились по разные стороны Сторожевого холма."
	L.opera_hall_beautiful_beast_story_text = "(Чугунок)Оперный зал: Красавица и Зверь"
	L.opera_hall_beautiful_beast_story_trigger = "Эта история о любви и гневе навсегда поставит точку в вопросе, обманчива ли красота."
	L.opera_hall_wikket_story_text = "(Ведьмы)Оперный зал: Злюкер"
	L.opera_hall_wikket_story_trigger = "Эй, шнуропс, закрой хлеборезку! Король обезьян покажет вам... пьеску!" -- Shut your jabber, drama man! The Monkey King got another plan!
	L.barnes = "Барнс"
	L.maiden = "Исправившаяся дева"
	L.philanthropist = "Бестелесный филантроп"
	L.guardsman = "Фантомный стражник"
	L.warmup_trigger = "Я разбросал по башне столько фрагментов своей души..."
end

L = BigWigs:NewBossLocale("Nightbane", "ruRU")
if L then
	L.name = "Ночная Погибель"
end

L = BigWigs:NewBossLocale("Attumen the Huntsman", "ruRU")
if L then
	L.IntangiblePresence = "Незримое присутствие"
end

L = BigWigs:NewBossLocale("Opera Hall: Westfall Story", "ruRU")
if L then
	L.warmup_text = "Ну что, покружимся?"
	L.warmup_trigger = "Ну что, покружимся?"
end

L = BigWigs:NewBossLocale("=> AutoMarks <=   ", "ruRU")
if L then
	L.custom_on_Allowmarks = "Разрешить маркировать выбранных мобов"
	L.custom_on_Allowmarks_desc = "Отмечать мобов с помощью {rt1}{rt2}{rt3}{rt4}{rt5}{rt6}{rt7}, нужно быть помощником или лидером"
	L.custom_off_RequireLead = "Только если я лидер"
	L.custom_off_CombatMarking  = "Отмечать только тех, кто в бою"
	
	L.Choose = "Выберите, каких мобов отмечать"
	L.Lower = "Нижний Каражан"
	
	L.custom_off_Mob1 = "Визжащий ужас"
	L.custom_off_Mob2 = "Скопление маны"
	L.custom_off_Mob3 = "Нестабильная энергия"
	L.custom_off_Mob4 = "Проекция Хранителя"
	L.custom_off_Mob5 = "Сквернотопырь"
	
	L.custom_off_Mob6 = "Призрачный эконом"
	L.custom_off_Mob7 = "Благонравная горничная"
	L.custom_off_Mob8 = "Призрачный помощник смотрителя стойл"
	L.custom_off_Mob9 = "Волшебный страж"
	L.custom_off_Mob10 = "Скелет-официант"
	L.custom_off_Mob11 = "Костяная гончая"
end
