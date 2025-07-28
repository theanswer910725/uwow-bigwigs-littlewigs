local L = BigWigs:NewBossLocale("Mephistroth", "ruRU")
if not L then return end
if L then
	L.custom_on_time_lost = "Время потерянное в период Уход во тьму"
	L.custom_on_time_lost_desc = "Показывать время потерянное в период Уход во тьму на панеле |cffff0000красным|r."
end

L = BigWigs:NewBossLocale("Domatrax", "ruRU")
if L then
	L.custom_on_autotalk = "Авторазговор"
	L.custom_on_autotalk_desc = "Мгновенно выбирает в диалоге с Эгидой опцию чтобы начать встречу с Доматраксом."
	
	L.custom_off_timer_for_cast = "Обратный отсчет до окончания |cff71d5ffХаотическая энергия|r с помощью команды SAY."

	L.missing_aegis = "Ты не стоишь в Эгиде" -- Aegis is a short name for Aegis of Aggramar
	L.aegis_healing = "Эгида: Исходящее исцеление уменьшено"
	L.aegis_damage = "Эгида: Нанесенный урон уменьшен"
end

L = BigWigs:NewBossLocale("Cathedral of Eternal Night Trash", "ruRU")
if L then
	L.dulzak = "Дул'зак"
	L.stranglevine = "Странглевский плеточник"
	L.dreadhunter = "Жуткий охотник"
	L.wrathguard = "Wrathguard Invader"
	L.felguard = "Страж Скверны - разрушитель"
	L.soulmender = "Врачеватель душ адского огня"
	L.temptress = "Искусительница адского огня"
	L.botanist = "Присягнувшая Скверне - ботаник"
	L.orbcaster = "Сквернолап - метательница сфер"
	L.waglur = "Ва'глур"
	L.scavenger = "Змееуст-барахольщик"
	L.helblaze = "Вестник Скверны адского огня"
	L.gazerax = "Созерцатель"
	L.vilebark = "Ходячий гиблодрев"
	L.groznokrl = "Грознокрыл"

	L.throw_tome = "Throw Tome" -- Common part of Throw Arcane/Frost/Silence Tome (242837/242839/242841)
end

L = BigWigs:NewBossLocale("=> AutoMarks <=       ", "ruRU")
if L then
	L.custom_on_Allowmarks = "Разрешить маркировать выбранных мобов"
	L.custom_on_Allowmarks_desc = "Отмечать мобов с помощью {rt1}{rt2}{rt3}{rt4}{rt5}{rt6}{rt7}, нужно быть помощником или лидером"
	L.custom_off_RequireLead = "Только если я лидер"
	L.custom_off_CombatMarking  = "Отмечать только тех, кто в бою"
	
	L.Choose = "Выберите, каких мобов отмечать"
	
	L.custom_off_Mob1 = "Врачеватель душ адского огня"
	L.custom_off_Mob2 = "Жуткий охотник"
	L.custom_off_Mob3 = "Присягнувшая скверне - ботаник"
	L.custom_off_Mob4 = "Вестник скверны адского огня"
	L.custom_off_Mob5 = "Искусительница адского огня"
	L.custom_off_Mob6 = "Сквернолап - метательница сфер"
	L.custom_off_Mob7 = "Нал'аша"
end