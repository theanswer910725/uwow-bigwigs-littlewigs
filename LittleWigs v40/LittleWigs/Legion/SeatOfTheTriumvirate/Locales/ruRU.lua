local L = BigWigs:NewBossLocale("Viceroy Nezhar", "ruRU")
if not L then return end
if L then
	--L.tentacles = "Tentacles"
	--L.guards = "Guards"
	--L.interrupted = "%s interrupted %s (%.1fs left)!"
end

L = BigWigs:NewBossLocale("L'ura", "ruRU")
if L then
	L.warmup_text = "Л'ура активна"
	L.warmup_trigger = "Такой хаос" --"Такой хаос... такая боль. Я еще не чувствовала ничего подобного."
	L.warmup_trigger_2 = "Она должна умереть" --"Впрочем, неважно. Она должна умереть."
	L.warmup_trigger_3 = "Осторожно"
	L.warmup_trigger_4 = "Берегись"
end

L = BigWigs:NewBossLocale("Zuraal", "ruRU")
if L then
	L.custom_on_autotalk = "Авторазговор"
	L.custom_on_autotalk_desc = "Мгновенный выбор опции запуска боя в диалоге."
	L.gossip_available = "Доступный диалог"
	L.alleria_gossip_trigger = "За мной!" -- Allerias yell after the first boss is defeated
	L.warmup_text_2 = "Аллерия активна"
	L.warmup_trigger_5 = "За мной!"

	L.alleria = "Аллерия Ветрокрылая"
end

L = BigWigs:NewBossLocale("Seat of the Triumvirate Trash", "ruRU")
if L then
	L.custom_on_autotalk = "Авторазговор"
	L.custom_on_autotalk_desc = "Мгновенный выбор опции запуска боя в диалоге."
	L.gossip_available = "Доступный диалог"
	L.alleria_gossip_trigger = "За мной!" -- Allerias yell after the first boss is defeated
	L.warmup_text_2 = "Аллерия активна"
	L.warmup_trigger_5 = "За мной!"
	L.warmup_trigger_6 = "Из храма исходит великое отчаяние. Л'ура..."

	L.alleria = "Аллерия Ветрокрылая"
	--L.subjugator = "Shadowguard Subjugator"
	--L.voidbender = "Shadowguard Voidbender"
	--L.conjurer = "Shadowguard Conjurer"
	--L.weaver = "Grand Shadow-Weaver"
end

L = BigWigs:NewBossLocale("=> AutoMarks <=           ", "ruRU")
if L then
	L.custom_on_Allowmarks = "Разрешить маркировать выбранных мобов"
	L.custom_on_Allowmarks_desc = "Отмечать мобов с помощью {rt1}{rt2}{rt3}{rt4}{rt5}{rt6}{rt7}, нужно быть помощником или лидером"
	L.custom_off_RequireLead = "Только если я лидер"
	L.custom_off_CombatMarking  = "Отмечать только тех, кто в бою"
	
	L.Choose = "Выберите, каких мобов отмечать"
	
	L.custom_off_Mob1 = "Страж прорыва"
	L.custom_off_Mob2 = "Страж огромного портала бездны"
	L.custom_off_Mob3 = "Защитник из темной стражи"
	L.custom_off_Mob4 = "Темное щупальце"
	L.custom_off_Mob5 = "Заклинатель Бездны из Темной Стражи"
	L.custom_off_Mob6 = "Сущность заклинателя теней"
end
