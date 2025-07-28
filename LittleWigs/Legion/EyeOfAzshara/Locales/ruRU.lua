local L = BigWigs:NewBossLocale("Eye of Azshara Trash", "ruRU")
if not L then return end
if L then
	L.gritslime = "Песчаная Улитка"
	L.wrangler = "Ловчий из клана Колец Ненависти"
	L.stormweaver = "Заклинательница штормов из клана Колец Ненависти"
	L.crusher = "Мирмидон из клана Колец Ненависти"
	L.oracle = "Оракул из клана Колец Ненависти"
	L.siltwalker = "Ходульник Мак'раны"
	L.tides = "Неутомимая волна"
	L.arcanist = "Колдунья из клана Колец Ненависти"
end

L = BigWigs:NewBossLocale("Lady Hatecoil", "ruRU")
if L then
	L.custom_on_show_helper_messages = "Вспомогательные сообщения для Кольцо молний и Средоточие молний"
	L.custom_on_show_helper_messages_desc = "Включите эту опцию, чтобы добавить вспомогательное сообщение, сообщающее вам, безопасна ли вода или земля, когда босс начнет каст |cff71d5ffКольцо молний|r или |cff71d5ffСредоточие молний|r."

	L.water_safe = "%s (вода безопасна)"
	L.land_safe = "%s (земля безопасна)"
end

L = BigWigs:NewBossLocale("=> AutoMarks <=", "ruRU")
if L then
	L.custom_on_Allowmarks = "Разрешить маркировать выбранных мобов"
	L.custom_on_Allowmarks_desc = "Отмечать мобов с помощью {rt1}{rt2}{rt3}{rt4}{rt5}{rt6}{rt7}, нужно быть помощником или лидером"
	L.custom_off_RequireLead = "Только если я лидер"
	L.custom_off_CombatMarking  = "Отмечать только тех, кто в бою"
	
	L.Choose = "Выберите, каких мобов отмечать"
	
	L.custom_off_HatecoilStormweaver = "Заклинательница штормов из клана Колец Ненависти"
	L.custom_off_HatecoilArcanist = "Колдунья из клана Колец Ненависти"
	L.custom_off_MakranaHardshell = "Твердопанцирник Мак'раны"
	L.custom_off_Ritualmobs = "Ритуальные мобы рядом с последним боссом"
end
