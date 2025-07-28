local L = BigWigs:NewBossLocale("Witherbark", "ruRU")
if not L then return end
if L then
	--L.energyStatus = "A Globule reached Witherbark: %d%% energy"
end

L = BigWigs:NewBossLocale("The Everbloom Trash", "ruRU")
if L then
	L.dreadpetal = "Страхоцвет"
	L.everbloom_naturalist = "Натуралист Вечного Цветения"
	L.everbloom_cultivator = "Культиватор Вечного Цветения"
	L.rockspine_stinger = "Камнеспинный жальщик"
	L.everbloom_mender = "Лекарь Вечного Цветения"
	L.gnarlroot = "Кривокорень"
	L.melded_berserker = "Зараженный берсерк"
	L.twisted_abomination = "Искаженное поганище"
	L.infested_icecaller = "Зараженная сотворительница льда"
	L.putrid_pyromancer = "Гнилостный пиромант"
	L.addled_arcanomancer = "Одурманенный маг"

	L.gate_open = "Ворота открыты"
	L.gate_open_desc = "Показывать индикатор, указывающий, когда помощник мага Кесалон откроет ворота к Йалну."
	L.yalnu_warmup_trigger = "Портала больше нет! Надо остановить зверя, пока он не сбежал!"
	

	--L.gate_open_desc = "Show a bar indicating when Undermage Kesalon will open the gate to Yalnu."
	--L.yalnu_warmup_trigger = "The portal is lost! We must stop this beast before it can escape!"
end

local L = BigWigs:NewBossLocale("Ancient Protectors", "ruRU")
if not L then return end
if L then
	L.custom_off_always_show_casts = "Всегда показывать цель заклинания для |cff71d5ffЯрость природы|r/|cff71d5ffВодяная стрела|r"
end

L = BigWigs:NewBossLocale("=> AutoMarks <=            ", "ruRU")
if L then
	L.custom_on_Allowmarks = "Разрешить маркировать выбранных мобов"
	L.custom_on_Allowmarks_desc = "Отмечать мобов с помощью {rt1}{rt2}{rt3}{rt4}{rt5}{rt6}{rt7}, нужно быть помощником или лидером"
	L.custom_off_RequireLead = "Только если я лидер"
	L.custom_off_CombatMarking  = "Отмечать только тех, кто в бою"
	
	L.Choose = "Выберите, каких мобов отмечать"
	
	L.custom_off_Mob1 = "Натуралист Вечного Цветения"
	L.custom_off_Mob2 = "Лекарь Вечного Цветения"
	L.custom_off_Mob3 = "Культиватор Вечного Цветения"
	L.custom_off_Mob4 = "Одурманенный маг"
	L.custom_off_Mob5 = "Зараженная сотворительница льда"
	L.custom_off_Mob6 = "Гнилостный пиромант"
	L.custom_off_Mob7 = "Демиург Телу"
	L.custom_off_Mob8 = "Страж жизни Гола"
end