
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Moroes", 1651, 1837)
if not mod then return end
mod:RegisterEnableMob(
	114312, -- Moroes
	114316, -- Baroness Dorothea Millstripe
	114317, -- Lady Catriona Von'Indi
	114318, -- Baron Rafe Dreuger
	114319, -- Lady Keira Berrybuck
	114320, -- Lord Robin Daris
	114321  -- Lord Crispin Ference
)
mod.engageId = 1961

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.cc = "Crowd Control"
	L.cc_desc = "Timers and alerts for crowd control on the dinner guests."
	L.cc_icon = "ability_hunter_traplauncher"
end

--------------------------------------------------------------------------------
-- Locals
--

local mobCollector = {}
local guestDeaths = 0
local WillBreakerCount = 0

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"cc",
		--[[ Moroes ]]--
		--227736, -- Vanish
		{227736, "SAY", "ICON"}, -- Vanish
		227742, -- Garrote
		{227851, "SAY", "TANK_HEALER"}, -- Coat Check
		227872, -- Ghastly Purge

		--[[ Baroness Dorothea Millstripe ]]--
		227545, -- Mana Drain

		--[[ Lady Catriona Von'Indi ]]--
		227578, -- Healing Stream

		--[[ Baron Rafe Dreuger ]]--
		227646, -- Iron Whirlwind

		--[[ Lady Keira Berrybuck ]]--
		227616, -- Empowered Arms

		--[[ Lord Robin Daris ]]--
		{227463, "ICON", "SAY"}, -- Whirling Edge

		--[[ Lord Crispin Ference ]]--
		227672, -- Will Breaker
	},{
		["cc"] = CL.general,
		[227736] = -14360, -- Moroes
		[227545] = -14366, -- Baroness Dorothea Millstripe
		[227578] = -14369, -- Lady Catriona Von'Indi
		[227646] = -14372, -- Baron Rafe Dreuger
		[227616] = -14374, -- Lady Keira Berrybuck
		[227463] = -14376, -- Lord Robin Daris
		[227672] = -14378, -- Lord Crispin Ference
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")
	--[[ Moroes ]]--
	self:Log("SPELL_CAST_START", "Vanish", 227736)
	self:Log("SPELL_AURA_APPLIED", "Garrote", 227742)
	self:Log("SPELL_AURA_APPLIED_DOSE", "Garrote", 227742)
	self:Log("SPELL_AURA_APPLIED", "CoatCheck", 227851) -- the debuff Moroes applies at the start of his cast
	self:Log("SPELL_AURA_APPLIED", "CoatCheckDispellable", 227832) -- the debuff that replaces the previous one 1.5s after, can be dispelled
	self:Log("SPELL_CAST_START", "GhastlyPurge", 227872)

	--[[ Baroness Dorothea Millstripe ]]--
	self:Log("SPELL_CAST_START", "ManaDrain", 227545)

	--[[ Lady Catriona Von'Indi ]]--
	self:Log("SPELL_CAST_START", "HealingStream", 227578)

	--[[ Baron Rafe Dreuger ]]--
	self:Log("SPELL_CAST_START", "IronWhirlwind", 227646)
	self:Log("SPELL_DAMAGE", "IronWhirlwindDamage", 227651)
	self:Log("SPELL_MISSED", "IronWhirlwindDamage", 227651)

	--[[ Lady Keira Berrybuck ]]--
	self:Log("SPELL_AURA_APPLIED", "EmpoweredArms", 227616)

	--[[ Lord Robin Daris ]]--
	self:Log("SPELL_CAST_START", "WhirlingEdge", 227463)

	--[[ Lord Crispin Ference ]]--
	self:Log("SPELL_CAST_START", "WillBreaker", 227672)
	
	
	-- CC tracking
	self:Log("SPELL_AURA_APPLIED", "CrowdControlApplied", 227909, 115078, 3355, 20066)
	self:Log("SPELL_AURA_REFRESH", "CrowdControlApplied", 227909, 115078, 3355, 20066)
	self:Log("SPELL_AURA_REMOVED", "CrowdControlRemoved", 227909, 115078, 3355, 20066)
	
	self:RegisterUnitEvent("UNIT_HEALTH_FREQUENT", nil, "boss1")
	self:Log("SPELL_DAMAGE", "PullDamage", "*")
	self:Log("SPELL_PERIODIC_DAMAGE", "PullDamage", "*")
	self:Log("RANGE_DAMAGE", "PullDamage", "*")
	self:Log("SWING_DAMAGE", "PullDamage", "*")
	self:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED")

	self:Death("GuestDeath",
		114316, -- Baroness Dorothea Millstripe
		114317, -- Lady Catriona Von'Indi
		114318, -- Baron Rafe Dreuger
		114319, -- Lady Keira Berrybuck
		114320, -- Lord Robin Daris
		114321  -- Lord Crispin Ference
	)
end

function mod:OnEngage()
	WillBreakerCount = 1
	wipe(mobCollector)
	mobCollector = {}
	guestDeaths = 0
	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT")
	self:CDBar(227736, 7) -- Vanish
	self:CDBar(227851, 30) -- Coat Check
	-- other bars are started in IEEU
end

--------------------------------------------------------------------------------
-- Event Handlers

do
	local prev = 0
	function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, _, _, spellGUID, spellId)
		local t = GetTime()
		if spellId == 227643 and t-prev > 0.5 then
			prev = t
			self:Message(227646, "Attention", "Long")
			self:Bar(227646, 10.14)
		elseif spellId == 227872 and t-prev > 0.5 then
			prev = t
			self:Message(227872, "Neutral")
		end
	end
end

function mod:PullDamage(args)
	local guid = args.destGUID or args.sourceGUID
	if not mobCollector[guid] then
		if (self:MobId(args.destGUID) == 114321 or self:MobId(args.sourceGUID) == 114321) then
			self:CDBar(227672, 10, CL.count:format(self:SpellName(227672), 1))-- Will Breaker
			self:CDBar(227672, 26, CL.count:format(self:SpellName(227672), 2))
			WillBreakerCount = 1
		elseif (self:MobId(args.destGUID) == 114320 or self:MobId(args.sourceGUID) == 114320) then
			self:Bar(227578, 19.99)
		elseif (self:MobId(args.destGUID) == 114318 or self:MobId(args.sourceGUID) == 114318) then
			self:CDBar(227646, 5.06) -- Iron Whirlwind
		elseif (self:MobId(args.destGUID) == 114316 or self:MobId(args.sourceGUID) == 114316) then
			self:CDBar(227545, 17) -- Mana Drain applied
		end
		mobCollector[guid] = true
	end
end

function mod:INSTANCE_ENCOUNTER_ENGAGE_UNIT()
	for i = 1, 5 do
		local guid = UnitGUID(("boss%d"):format(i))
		if guid and not mobCollector[guid] then
			mobCollector[guid] = true
			local mobId = self:MobId(guid)
			if mobId == 114316 then -- Baroness Dorothea Millstripe
				self:CDBar(227545, 9) -- Mana Drain applied
			--elseif mobId == 114317 then -- Lady Catriona Von'Indi
				-- She casts Healing Stream whenever Moroes drops below 50%
			elseif mobId == 114318 then -- Baron Rafe Dreuger
				self:CDBar(227646, 4.5) -- Iron Whirlwind
			elseif mobId == 114319 then -- Lady Keira Berrybuck
				self:CDBar(227616, 9.5) -- Empowered Arms
			--elseif mobId == 114320 then -- Lord Robin Daris
				-- Whirling Edge is cast instantly
			elseif mobId == 114321 then -- Lord Crispin Ference
				self:Bar(227672, 10.5) -- Will Breaker
			end
		end
	end
end

function mod:UNIT_HEALTH_FREQUENT(unit)
	local hp = UnitHealth(unit) / UnitHealthMax(unit) * 100
	if hp < 65 or guestDeaths == 4 then
		self:UnregisterUnitEvent("UNIT_HEALTH_FREQUENT", "boss1")
		if guestDeaths < 4 then
			self:Message(227872, "Attention", "Info", CL.soon:format(self:SpellName(227872))) -- Ghastly Purge Soon
		end
	end
end

do
	local prev = 0
	local function printTarget(self, name, guid)
		local t = GetTime()
		if self:Me(guid) then
			prev = t
			self:TargetMessage(227736, name, "Personal", "Bam")
			self:Say(227736)
		elseif t-prev > 1.5 then
			prev = t
			self:TargetMessage(227736, name, "Personal", "None")
		end
	end
	function mod:Vanish(args)
		self:GetUnitTarget(printTarget, 0.3, args.sourceGUID)
		self:CDBar(227736, 20.5)
		self:SecondaryIcon(args.spellId, args.destName)
	end
end

function mod:Garrote(args)
	local amount = args.amount or 1
	self:StackMessage(args.spellId, args.destName, amount, "Urgent", "Info")
	self:SecondaryIcon(args.spellId, nil)
end

function mod:CoatCheck(args)
	if self:Tank() then
		self:Message(args.spellId, "Urgent", "Alarm", CL.casting:format(args.spellName))
	end
	if self:Me(args.destGUID) then
	self:Say(args.spellId)
	end
	self:Bar(args.spellId, 34)
end

function mod:CoatCheckDispellable(args)
	if not self:Tank() then
		self:TargetMessage(227851, args.destName, "Urgent", "Alarm", nil, nil, true)
	end
end

function mod:GhastlyPurge(args)
	self:Message(args.spellId, "Neutral")
end

function mod:ManaDrain(args)
	self:Message(args.spellId, "Urgent", self:Interrupter() and "Warning", CL.casting:format(args.spellName))
	self:CDBar(args.spellId, 18)
end

function mod:HealingStream(args)
	self:Message(args.spellId, "Important", self:Interrupter() and "Warning", CL.casting:format(args.spellName))
	self:Bar(227578, 30)
end

function mod:IronWhirlwind(args)
	self:Message(args.spellId, "Attention", "Long")
	self:Bar(args.spellId, 10.5)
end

do
	local prev = 0
	function mod:IronWhirlwindDamage(args)
		if self:Me(args.destGUID) then
			local t = GetTime()
			if t-prev > 2 then
				prev = t
				self:Message(227646, "Personal", "Alarm", CL.underyou:format(args.spellName))
			end
		end
	end
end

function mod:EmpoweredArms(args)
	self:Message(args.spellId, "Important", self:Tank() and "Info", CL.on:format(args.spellName, args.destName))
end

do
	local function printTarget(self, player, guid)
		if self:Me(guid) then
			self:Say(227463)
		end
		self:TargetMessage(227463, player, "Urgent", "Warning")
	end

	function mod:WhirlingEdge(args)
		self:GetBossTarget(printTarget, 1.5, args.sourceGUID)
	end
end

function mod:WillBreaker(args)
	self:Message(args.spellId, "Important", "Long")
	self:CDBar(227672, 17, CL.count:format(self:SpellName(227672), WillBreakerCount))
	self:CDBar(227672, 34, CL.count:format(self:SpellName(227672), WillBreakerCount + 1))
	WillBreakerCount = 1
end

function mod:CrowdControlApplied(args)
	local spellId = args.spellId
	if spellId == 227909 then
		self:TargetBar("cc", 70, args.destName, args.spellId)
	elseif spellId == 115078 then
		self:TargetBar("cc", 60, args.destName, args.spellId)
	elseif spellId == 3355 then
		self:TargetBar("cc", 60, args.destName, args.spellId)
	elseif spellId == 20066 then
		self:TargetBar("cc", 60, args.destName, args.spellId)
	end
	self:Message("cc", "Positive", "Long", CL.on:format(args.spellName, args.destName), args.spellId)
end

function mod:CrowdControlRemoved(args)
	self:Message("cc", "Positive", "Info", CL.other:format(args.destName, CL.over:format(args.spellName)), args.spellId)
	self:StopBar(args.spellId, args.destName)
end

function mod:GuestDeath(args)
	guestDeaths = guestDeaths + 1
	local mobId = self:MobId(args.destGUID)
	if mobId == 114316 then -- Baroness Dorothea Millstripe
		self:StopBar(227545) -- Mana Drain
	elseif mobId == 114317 then -- Lady Catriona Von'Indi
	elseif mobId == 114318 then -- Baron Rafe Dreuger
		self:StopBar(227646) -- Iron Whirlwind
	elseif mobId == 114319 then -- Lady Keira Berrybuck
		self:StopBar(227616) -- Empowered Arms
	elseif mobId == 114320 then -- Lord Robin Daris
		-- Whirling Edge is cast instantly
	elseif mobId == 114321 then -- Lord Crispin Ference
		self:StopBar(227672) -- Will Breaker
	end
end
