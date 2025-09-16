local L = BigWigs:NewBossLocale("Odyn", "ruRU")
if not L then return end
if L then
	L.custom_on_autotalk = "Авторазговор"
	L.custom_on_autotalk_desc = "Мгновенный выбор опции запуска боя в диалоге."

	L.gossip_available = "Доступный диалог"
	L.gossip_trigger = "Удивительно! Я не верил, что кто-то может сравниться с валарьярами... Но вы доказали, что это возможно."

	L.tankP = "|cFF800080Право Верх|r (|T1323037:15:15:0:0:64:64:4:60:4:60|t)" -- Translate "Top Right"
	L.tankO = "|cFFFFA500Право Низ|r (|T1323039:15:15:0:0:64:64:4:60:4:60|t)" -- Translate "Bottom Right"
	L.tankY = "|cFFFFFF00Лево Низ|r (|T1323038:15:15:0:0:64:64:4:60:4:60|t)" -- Translate "Bottom Left"
	L.tankB = "|cFF0000FFЛево Верх|r (|T1323035:15:15:0:0:64:64:4:60:4:60|t)" -- Translate "Top Left"
	L.tankG = "|cFF008000Верх|r (|T1323036:15:15:0:0:64:64:4:60:4:60|t)" -- Translate "Top"
	
	L.ddP = "|cFF800080Лево Низ|r (|T1323037:15:15:0:0:64:64:4:60:4:60|t)" -- Translate "Top Right"
	L.ddO = "|cFFFFA500Лево Верх|r (|T1323039:15:15:0:0:64:64:4:60:4:60|t)" -- Translate "Bottom Right"
	L.ddY = "|cFFFFFF00Право Верх|r (|T1323038:15:15:0:0:64:64:4:60:4:60|t)" -- Translate "Bottom Left"
	L.ddB = "|cFF0000FFПраво Низ|r (|T1323035:15:15:0:0:64:64:4:60:4:60|t)" -- Translate "Top Left"
	L.ddG = "|cFF008000Низ|r (|T1323036:15:15:0:0:64:64:4:60:4:60|t)" -- Translate "Top"
end

L = BigWigs:NewBossLocale("God-King Skovald", "ruRU")
if L then
	L.warmup_text = "Король-бог Сковальд активен"
	L.warmup_trigger = "Сковальд, эти герои завладели Эгидой по праву. Уже поздно что-либо оспаривать."
	L.warmup_trigger_2 = "Или эти псевдогерои сами отдадут Эгиду... Или я вырву ее из их мертвых рук!"
end

L = BigWigs:NewBossLocale("Halls of Valor Trash", "ruRU")
if L then
	L.custom_on_autotalk = "Авторазговор"
	L.custom_on_autotalk_desc = "Мгновенный выбор опций в диалогах."

	L.fourkings = "Четыре Короля"
	L.runecarver = "Валарьяр - резчик рун"
	L.olmyr = "Олмир Просвещенный"
	L.solsten = "Солстен"
	L.purifier = "Валарьяр-очиститель"
	L.thundercaller = "Валарьяр - призыватель молний"
	L.mystic = "Валарьяр-мистик"
	L.aspirant = "Валарьяр-претендентка"
	L.drake = "Штормовой дракон"
	L.marksman = "Валарьяр-лучница"
	L.trapper = "Валарьяр-зверолов"
	L.sentinel = "Закаленный бурей страж"
	L.Kings = "Готов поговорить с %s"
	L.Check = "!kings"
	L.Start = "!pull"
	L.Reply = "Могу активировать (команда чата или запуск диалога лидером/помощником"
	L.Function = "Эта функция выключена"
	L.custom_off_multiple_kings = "Выключить авторазговор с королями (мини-боссами) для активации через чат лидером"
	L.custom_off_multiple_kings_desc = "Введите |cffff0000!kings|r в чат, чтобы узнать у кого включена функция. Откройте окно с диалогом выбранного короля (NPC) и дождитесь когда лидер группы отправит команду |cffff0000!pull|r в чат, чтобы активировать всех NPC одновременно.                                     |cffff0000Не забудьте выключить автоскип разговоров в других аддонах (AngryKeystones)|r|cff00ff00    => КОМАНДЫ ЧАТА РАБОТАЮТ ТОЛЬКО ДЛЯ ЛИДЕРА ГРУППЫ В ГРУППОВОМ ЧАТЕ <=|r"
	L.warmup_trigger1 = "Хирья... Теперь ты можешь повелевать яростью бури!"
	L.warmup_trigger2= "Да озарит тебя вечный Свет, Хирья!"
end

L = BigWigs:NewBossLocale("=> AutoMarks <=         ", "ruRU")
if L then
	L.custom_on_Allowmarks = "Разрешить маркировать выбранных мобов"
	L.custom_on_Allowmarks_desc = "Отмечать мобов с помощью {rt1}{rt2}{rt3}{rt4}{rt5}{rt6}{rt7}, нужно быть помощником или лидером"
	L.custom_off_RequireLead = "Только если я лидер"
	L.custom_off_CombatMarking  = "Отмечать только тех, кто в бою"
	
	L.Choose = "Выберите, каких мобов отмечать"
	
	L.custom_off_Mob1 = "Валарьяр-мистик"
	L.custom_off_Mob2 = "Валарьяр-очиститель"
	L.custom_off_Mob3 = "Валарьяр-призыватель молний"
	L.custom_off_Mob4 = "Валарьяр-лучница"
	L.custom_off_Mob5 = "Четыре Короля"
end