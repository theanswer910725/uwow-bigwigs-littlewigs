
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Black Rook Hold Trash", 1501)
if not mod then return end
mod.displayName = CL.trash
mod:RegisterEnableMob(
	101839, -- Risen Companion
	98280, -- Risen Arcanist
	98243, -- Soul-torn Champion
	100485, -- Soul-torn Vanguard
	102094, -- Risen Swordsman
	98275, -- Risen Archer
	98691, -- Risen Scout
	98370, -- Ghostly Councilor
	98810, -- Wrathguard Bladelord
	102788, -- Felspite Dominator
	102095 -- Risen Lancer
)

local mark = {
  ["{rt1}"] = "|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_1:0|t",
  ["{rt2}"] = "|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_2:0|t",
  ["{rt3}"] = "|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_3:0|t",
  ["{rt4}"] = "|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_4:0|t",
  ["{rt5}"] = "|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_5:0|t",
  ["{rt6}"] = "|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_6:0|t",
  ["{rt7}"] = "|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_7:0|t",
  ["{rt8}"] = "|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_8:0|t"
}

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.companion = "Risen Companion"
	L.arcanist = "Risen Arcanist"
	L.champion = "Soul-torn Champion"
	L.swordsman = "Risen Swordsman"
	L.archer = "Risen Archer"
	L.scout = "Risen Scout"
	L.councilor = "Ghostly Councilor"
	L.WrathguardBladelord = "Wrathguard Bladelord"
	L.dominator = "Felspite Dominator"
	L.risenlancer = "Risen Lancer"
	L.warmup_text = "The last boulders !"
	L.warmup_trigger = "Ha! We'll get 'em wit' these big rocks!"
	L.warmup_trigger2 = "Ahh! They coming! RUN!"
	L.warmup_trigger3 = "AHHH! WE SORRY! WE PROMISE!"
	L.warmup_trigger4 = "The darkness... it is gone."
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		222397,
		"warmup",
		225963, -- Bloodthirsty Leap (Risen Companion)
		{200248, "SAY"}, -- Arcane Blitz (Risen Arcanist)
		{200261, "SAY"}, -- Bonebreaking Strike (Soul-torn Champion)
		{197974, "SAY"}, -- Bonecrushing Strike (Soul-torn Vanguard)
		225998, -- Commanding Shout
		214003, -- Coup de Grace (Risen Swordsman)
		200343, -- Arrow Barrage (Risen Archer)
		{193633, "SAY", "FLASH"}, -- Shoot (Risen Archer)
		200291, -- Knife Dance (Risen Scout)
		225573, -- Dark Mending (Ghostly Councilor)
		201139, -- Brutal Assault (Wrathguard Bladelord)
		8599,   -- Enrage
		203163, -- Sic Bats! (Felspite Dominator)
		227913,  -- Felfrenzy (Felspite Dominator)
		{214002, "SAY"}, -- Raven's Dive (Risen Lancer)
		"stages"
	}, {
		[225963] = L.companion,
		[200248] = L.arcanist,
		[200261] = L.champion,
		[214003] = L.swordsman,
		[200343] = L.archer,
		[200291] = L.scout,
		[225573] = L.councilor,
		[201139] = L.WrathguardBladelord,
		[203163] = L.dominator,
		[214002] = L.risenlancer
	}
end

function mod:OnBossEnable()
	self:RegisterMessage("BigWigs_OnBossEngage", "Enable")
	self:RegisterEvent("CHAT_MSG_MONSTER_YELL", "Warmup")
	self:RegisterEvent("CHAT_MSG_MONSTER_SAY", "Warmup")

	self:Log("SPELL_AURA_APPLIED", "BloodthirstyLeap", 225963)
	self:Log("SPELL_AURA_APPLIED", "ArcaneBlitz", 200248)
	self:Log("SPELL_AURA_APPLIED_DOSE", "ArcaneBlitz", 200248)
	self:Log("SPELL_CAST_START", "ArcaneBlitzCast", 200248)
	self:Log("SPELL_CAST_START", "BonebreakingStrike", 200261, 197974) -- 197974 = Bonecrushing Strike
	self:Log("SPELL_AURA_APPLIED", "BonebreakingStrikeApp", 200261, 197974)
	self:Log("SPELL_AURA_APPLIED", "RavenDiveApp", 214002)
	self:Log("SPELL_AURA_APPLIED", "CommandingShout", 225998)
	self:Log("SPELL_CAST_START", "CoupdeGrace", 214003)
	self:Log("SPELL_CAST_START", "ArrowBarrage", 200343)
	self:Log("SPELL_CAST_START", "Shoot", 193633)
	self:Log("SPELL_CAST_START", "KnifeDance", 200291)
	self:Log("SPELL_CAST_START", "DarkMending", 225573)
	self:Log("SPELL_CAST_START", "BrutalAssault", 201139)
	self:Log("SPELL_AURA_APPLIED", "SicBats", 203163)
	self:Log("SPELL_CAST_START", "Felfrenzy", 227913)
	self:Log("SPELL_AURA_APPLIED", "Enrage", 8599)
	self:Death("AmalgamofSouls", 98542)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Warmup(_, msg)
	if msg:find(L.warmup_trigger, nil, true) then
		self:Message(222397, "Attention", "Warning", CL.casting:format(self:SpellName(222397)))
	end

	if msg:find(L.warmup_trigger2, nil, true) then
		self:Bar("warmup", 6, L.warmup_text, "inv_stone_10")
		self:Message(222397, "Positive", "Info", CL.over:format(self:SpellName(222397)))
	end

	if msg:find(L.warmup_trigger3, nil, true) then
		self:Bar("warmup", 14, L.warmup_text, "inv_stone_10")
		self:Message(222397, "Positive", "Info", CL.over:format(self:SpellName(222397)))
		self:UnregisterEvent("CHAT_MSG_MONSTER_YELL", "Warmup")
	end
	
	if msg:find(L.warmup_trigger4, nil, true) then
		self:Bar("stages", 20.7, self:SpellName(15276), 66039)
		self:ScheduleTimer("Doors", 20.7)
	end
end

-- Risen Arcanist
function mod:ArcaneBlitz(args)
	self:StackMessage(args.spellId, args.destName, args.amount, "red")
	self:PlaySound(args.spellId, "Info", args.destName)
end

do
	local prev = 0
	local function printTarget(self, name, guid)
		local t = GetTime()
		if self:Me(guid) then
			prev = t
			self:TargetMessage(200248, name, "Personal", "Banana Peel Slip")
			self:Say(200248)
		end
	end
	function mod:ArcaneBlitzCast(args)
		self:GetUnitTarget(printTarget, 0.1, args.sourceGUID)
	end
end

-- Soul-torn Champion, Soul-torn Vanguard

function mod:BonebreakingStrikeApp(args)
	if self:Me(args.destGUID) then
		self:TargetMessage(args.spellId, args.destName, "Personal", "Bam")
		self:Say(args.spellId)
	else
		self:TargetMessage(args.spellId, args.destName, "Neutral", "Long")
	end
end

function mod:BonebreakingStrike(args)
	self:Message(args.spellId, "Urgent", "Alarm", CL.incoming:format(args.spellName))
end

function mod:CommandingShout(args)
	if self:MobId(args.sourceGUID) == 98243 and args.sourceGUID == args.destGUID then
		local unit = self:GetUnitIdByGUID(args.sourceGUID)
		local raidIndex = unit and GetRaidTargetIndex(unit)
		if raidIndex and raidIndex > 0 then
			self:CDBar(225998, 30, CL.other:format(self:SpellName(225998), mark["{rt" .. raidIndex .. "}"]), 225998)
			return
		end
		for i = 1, 8 do
			if self:BarTimeLeft(CL.count:format(self:SpellName(225998), i)) < 1 then
				self:Bar(225998, 30, CL.count:format(self:SpellName(225998), i))
				break
			end
		end
		self:Message(args.spellId, "Attention", "Info")
	end
end

-- Risen Swordsman
function mod:CoupdeGrace(args)
	self:Message(args.spellId, "Important", "Alarm", CL.incoming:format(args.spellName))
end

-- Risen Archer
function mod:ArrowBarrage(args)
	self:Message(args.spellId, "Attention", "Warning", CL.casting:format(args.spellName))
end

-- Wrathguard Bladelord

do
	local prev = 0
	local function printTarget(self, name, guid)
		local t = GetTime()
		if t-prev > 38 then
			prev = t
			self:TargetMessage(201139, name, "Personal", "Warning")
			self:CDBar(201139, 20)
			self:CastBar(201139, 40)
		elseif t-prev > 0 then
			self:TargetMessage(201139, name, "Personal", "Warning")
		end
	end
	function mod:BrutalAssault(args)
		self:GetUnitTarget(printTarget, 0.1, args.sourceGUID)
	end
end

function mod:Enrage(args)
	self:Message(args.spellId, "Attention", "Info")
end

do
	local function printTarget(self, name, guid)
		if self:Me(guid) then
			self:TargetMessage(193633, name, "Personal", "Bam")
			self:Say(193633)
			self:CastBar(193633, 2)
		else
			self:TargetMessage(193633, name, "Personal", "None")
		end
	end

	function mod:Shoot(args)
		self:GetUnitTarget(printTarget, 0.1, args.sourceGUID)
	end
end

do
	local prev = 0
	local function printTarget(self, name, guid)
		local t = GetTime()
		if self:Me(guid) then
			prev = t
			self:TargetMessage(200248, name, "Personal", "Banana Peel Slip")
			self:Say(200248)
		end
	end
	function mod:ArcaneBlitzCast(args)
		self:GetUnitTarget(printTarget, 0.1, args.sourceGUID)
	end
end

-- Risen Scout
function mod:KnifeDance(args)
	self:Message(args.spellId, "Important", "Alert", CL.casting:format(args.spellName))
	self:CDBar(args.spellId, 20)
end

-- Ghostly Councilor
function mod:DarkMending(args)
	self:Message(args.spellId, "Attention", self:Interrupter() and "Alarm", CL.casting:format(args.spellName))
end

-- Felspite Dominator
function mod:Felfrenzy(args)
	self:Message(args.spellId, "Attention", self:Interrupter() and "Alarm", CL.casting:format(args.spellName))
end

-- Risen Companion
function mod:BloodthirstyLeap(args)
	self:Message(args.spellId, "Attention", "Long")
	self:PlaySound(args.spellId, "Cat")
	self:CDBar(args.spellId, 8)
	self:CastBar(args.spellId, 16)
end

do
	local prev = 0
	function mod:SicBats(args)
		local t = GetTime()
		if t-prev > 1.5 then
			prev = t
			self:TargetMessage(args.spellId, args.destName, "Urgent", "Warning")
		end
	end
end

function mod:RavenDiveApp(args)
	if self:Me(args.destGUID) then
		self:TargetMessage(args.spellId, args.destName, "Personal", "Bam")
		self:Say(args.spellId)
	else
		self:TargetMessage(args.spellId, args.destName, "Neutral", "Long")
	end
end

function mod:AmalgamofSouls(args)
	self:ScheduleTimer("waitdoors", 6)
end

function mod:waitdoors(args)
	self:Message("stages", "Neutral", "Long", CL.custom_sec:format(self:SpellName(15276), 25), 66039)
	self:Bar("stages", 25, self:SpellName(15276), 66039)
end

function mod:Doors()
	self:Message("stages", "Positive", "Info", self:SpellName(15276), 66039)
end