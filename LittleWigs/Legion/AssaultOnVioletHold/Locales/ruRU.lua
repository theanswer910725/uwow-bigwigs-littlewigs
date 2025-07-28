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
	L.custom_on_autokeystone =  "Автозапуск ключа по отсчёту."
	L.custom_on_autokeystone_desc = "Работает с обратным отсчётом от Exorsus Raid Tools и Big Wigs. Отсчёт должен быть обязательно от того чей кей планируется запускать !"
	L.custom_on_autosave = "Автоматическое сохранение после получения лута (не чаще, чем раз в 20 секунд)."
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
end

L = BigWigs:NewBossLocale("Thalena", "ruRU")
if L then
	--L.essence = "Essence"
end
