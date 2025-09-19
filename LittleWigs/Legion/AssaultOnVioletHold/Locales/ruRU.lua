local L = BigWigs:NewBossLocale("Assault on Violet Hold Trash", "ruRU")
if not L then return end
if L then
	--L.custom_on_autotalk = "Autotalk"
	--L.custom_on_autotalk_desc = "Instantly selects Lieutenant Sinclaris gossip option to start the Assault on Violet Hold."
	--L.keeper = "Portal Keeper"
	--L.guardian = "Portal Guardian"
	--L.infernal = "Blazing Infernal"
end

local L = BigWigs:NewBossLocale("===>>>>  PARTY INFO  <<<<===", "ruRU")
if not L then return end
if L then
	L.custom_on_autoRIO = "Автопроверка РИО (.ch) если вам пишут в личку"
	L.custom_on_autoRIO_desc = "Отображается только имя и рио. Не больше одного анонса для каждого юнита."
	
	L.custom_off_autoRIOfullch = "Отключить сокращение информации о РИО (.ch), если вам пишут в личку"
	
	L.custom_off_autoRIOlfg = "Автопроверка РИО (.ch) ТОЛЬКО находясь В ЗСГ, если вам пишут в личку"
	L.custom_off_autoRIOlfg_desc = "Отображается только имя и рио. Не больше одного анонса для каждого юнита."

	L.custom_on_autoLFG = "Автосоздание ЗСГ"
	L.custom_on_autoLFG_desc = "После вашего линка ключа в общий чат автоматически будет открываться и заполняться ЗСГ используя данные ключа"

	L.custom_on_autokeystone =  "Автозапуск ключа по отсчёту."
	L.custom_on_autokeystone_desc = "Работает с обратным отсчётом от Exorsus Raid Tools и Big Wigs. Отсчёт должен быть обязательно от того чей кей планируется запускать !"
	L.custom_on_autosave = "Автосохранение после получения лута (не чаще, чем раз в 20 секунд)."
	L.custom_on_announcement = "|cff00ff00Включение|r/|cffff0000выключение|r всех групповых анонсов"
	L.WarlockPets = "Warlock Pets (Interrupt, dispell)"
	L.Bloodlust = "Bloodlust (or similar effects)"
	L.Portals = "Mage Portals"
	L.Rituals = "Rituals"
	L.BattleRes = "BattleRes"
	L.Reaves = "Repair, Reincarnation"
	L.difficulty = "|cffff00ff[LittleWigs]|r|cff00ff00 Вы можете обновить сложность |r|cffff0000(все игроки покинули подземелье)|r"
	L.diff = "|cffff00ff[LittleWigs]|r|cff00ff00 Установленный режим сложности подземелья: Эпохальный |r"
	L.chatdiff = "Установленный режим сложности подземелья: Эпохальный"
	L.chatdiffRW = "[LittleWigs] Установленный режим сложности подземелья: Эпохальный"
	L.refresh = "|cff00ff00 Анонс для обновления сложности после ключа |r|cffff0000(для лидера группы)|r"
	
	L.KarazhanEvent1 = "[LittleWigs] На этой неделе 'Чугунок'"
	L.KarazhanSequence1 = "|cffff00ff [LittleWigs]|r|cff00ff00 Ивенты первого босса: Чугунок -> Ведьмы -> Тонни|r"
	
	L.KarazhanEvent2 = "[LittleWigs] На этой неделе 'Ведьмы'"
	L.KarazhanSequence2 = "|cffff00ff [LittleWigs]|r|cff00ff00 Ивенты первого босса: Ведьмы -> Тонни -> Чугунок|r"
	
	L.KarazhanEvent3 = "[LittleWigs] На этой неделе 'Тонни'"
	L.KarazhanSequence3 = "|cffff00ff [LittleWigs]|r|cff00ff00 Ивенты первого босса: Тонни -> Чугунок -> Ведьмы|r"
	
	L.LeftSideChat = "[LittleWigs] <<<=== Левая сторона"
	L.RightSideChat = "[LittleWigs] Правая сторона ===>>>"
	L.LeftSide = "|cffff00ff [LittleWigs]|r|cff00ff00 <<<=== Левая сторона|r"
	L.RightSide = "|cffff00ff [LittleWigs]|r|cff00ff00 Правая сторона ===>>>|r"
end

L = BigWigs:NewBossLocale("Thalena", "ruRU")
if L then
	--L.essence = "Essence"
end
