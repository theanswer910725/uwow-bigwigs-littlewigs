local L = BigWigs:NewBossLocale("The Arcway Trash", "ruRU")
if not L then return end
if L then
	L.unstable = "Нестабильное слияние"
	L.unstable = "Нестабильный слизнюк"
	L.anomaly = "Волшебная аномалия"
	L.shade = "Искаженная тень"
	L.wraith = "Иссохший - магический призрак"
	L.blade = "Страж гнева - клинок Скверны"
	L.seer = "Жуткорожденный провидец"
	L.chaosbringer = "Эредарский вестник хаоса"
	L.nightborne = "Ночнорожденный-возродитель"
	L.warmup_trigger = "О-хо-хо... Ну и бардак же тут. Давненько мы не занимались уборкой в катакомбах. Я так полагаю, мы имеем дело с нашествием крыс."
end

L = BigWigs:NewBossLocale("=> AutoMarks <=    ", "ruRU")
if L then
	L.custom_on_Allowmarks = "Разрешить маркировать выбранных мобов"
	L.custom_on_Allowmarks_desc = "Отмечать мобов с помощью {rt1}{rt2}{rt3}{rt4}{rt5}{rt6}{rt7}, нужно быть помощником или лидером"
	L.custom_off_RequireLead = "Только если я лидер"
	L.custom_off_CombatMarking  = "Отмечать только тех, кто в бою"
	
	L.Choose = "Выберите, каких мобов отмечать"
	
	L.custom_off_Mob1 = "Забытая душа"
	L.custom_off_Mob2 = "Эредарский вестник хаоса"
	L.custom_off_Mob3 = "Иссохший - магический призрак"
	L.custom_off_Mob4 = "Искаженная тень"
	L.custom_off_Mob5 = "Волшебная аномалия"
	L.custom_off_Mob6 = "Ночнорожденный-возродитель"
end
