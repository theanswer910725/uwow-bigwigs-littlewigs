local L = BigWigs:NewBossLocale("Black Rook Hold Trash", "ruRU")
if not L then return end
if L then
	L.companion = "Risen Companion"
	L.arcanist = "Risen Arcanist"
	L.champion = "Soul-torn Champion"
	L.swordsman = "Risen Swordsman"
	L.archer = "Risen Archer"
	L.scout = "Risen Scout"
	L.councilor = "Ghostly Councilor"
	L.dominator = "Felspite Dominator"
	L.warmup_text = "Последние валуны !"
	L.warmup_trigger = "Ха! Завалим их здоровенными камнями!"
	L.warmup_trigger2 = "Они идут! БЕЖИМ!"
	L.warmup_trigger3 = "МЫ БОЛЬШЕ НЕ БУДЕМ! ЧЕСТНО-ЧЕСТНО!"
	L.warmup_trigger4 = "Тьма... рассеялась."
end

L = BigWigs:NewBossLocale("Amalgam of Souls", "ruRU")
if L then
end

L = BigWigs:NewBossLocale("Illysanna Ravencrest", "ruRU")
if L then
end

L = BigWigs:NewBossLocale("Kurtalos Ravencrest", "ruRU")
if L then
	L.phase_2_trigger = "Все, мне это надоело!"
end

L = BigWigs:NewBossLocale("=> AutoMarks <=     ", "ruRU")
if L then
	L.custom_on_Allowmarks = "Разрешить маркировать выбранных мобов"
	L.custom_on_Allowmarks_desc = "Отмечать мобов с помощью {rt1}{rt2}{rt3}{rt4}{rt5}{rt6}{rt7}, нужно быть помощником или лидером"
	L.custom_off_RequireLead = "Только если я лидер"
	L.custom_off_CombatMarking  = "Отмечать только тех, кто в бою"
	
	L.Choose = "Выберите, каких мобов отмечать"
	
	L.custom_off_Mob1 = "Восставший питомец"
	L.custom_off_Mob2 = "Восставший разведчик"
	L.custom_off_Mob3 = "Восставший копейщик"
	L.custom_off_Mob4 = "Злобный покоритель скверны"
	L.custom_off_Mob5 = "Страж гнева - мастер клинка"
	L.custom_off_Mob6 = "Фантомный советник"
end