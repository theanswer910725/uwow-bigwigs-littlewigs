--------------------------------------------------------------------------------
-- Module Declaration
--

--TO do List
--Brutal Haymaker should be tested tank POV
--Fel vomit cd reduces on every cast 0.64~ multiplier still could be tested a few more tries
local mod, CL = BigWigs:NewBoss("Smashspite", 1501, 1664)
if not mod then return end
mod:RegisterEnableMob(98949)
mod.engageId = 1834

--------------------------------------------------------------------------------
-- Locals
--

local felVomitCD = 35
local mobCollector = {}
--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		198073, -- Earthshaking Stomp
		{198245, "TANK"}, -- Brutal Haymaker
		{198079, "SAY", "ICON"}, -- Hateful Gaze
		{198446, "SAY"}, -- Fel Vomit
		218810,
	}, {
		[218810] = "general",
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_SUCCESS", "FelVomit", 198446)
	self:Log("SPELL_CAST_START", "EarthshakingStomp", 198073)
	self:Log("SPELL_CAST_SUCCESS", "HatefulGaze", 198079)
	self:Log("SPELL_AURA_REMOVED", "HatefulGazeRemoved", 198079)
	self:Log("SPELL_AURA_APPLIED", "HatefulGazeApplied", 198079)
	self:Log("SPELL_CAST_START", "BrutalHaymaker", 198245)
	self:RegisterUnitEvent("UNIT_POWER", nil, "boss1")
	self:RegisterTargetEvents("CheckTargets")
	self:RegisterEvent("UNIT_HEALTH_FREQUENT", "CheckTargets")
end

function mod:OnEngage()
	self:UnregisterEvent("CHAT_MSG_MONSTER_YELL", "Warmup")
	felVomitCD = 35
	self:CDBar(198079, 5.8) -- Hateful Gaze
	self:CDBar(198073, 12) -- Earthshaking Stomp
	self:CDBar(198446, 31) -- Fel Vomit
end

--------------------------------------------------------------------------------
-- Event Handlers
--

do
	local prev = 0
	function mod:CheckTargets(event, unit, guid)
		local guid = UnitGUID(unit)
		local t = GetTime()
		if self:MobId(guid) == 102781 and t-prev > 5 and not UnitAffectingCombat(unit) and not mobCollector[guid] then
			prev = t
			mobCollector[guid] = true
			self:Bar(218810, 6, self:SpellName(218810), 186164) 
		elseif self:MobId(guid) == 102781 and t-prev < 5 and not UnitAffectingCombat(unit) and not mobCollector[guid] then
			mobCollector[guid] = true
		end
	end
end

do
	local prev = 0
	function mod:UNIT_POWER(unit, pType, args)
			local power = UnitPower(unit) / UnitPowerMax(unit) * 100
			local n = self:UnitName(unit)
			local t = GetTime()
			if power > 90 and power < 100 and t-prev > 0.5 and (self:Tank() or self:Healer()) then
				prev = t
				self:Message(198245, "Important", "Alarm", CL.other:format(n, CL.percent:format(power, CL.incoming:format(self:SpellName(198245)))))
			elseif power == 100 and t-prev > 0.5 and (self:Tank() or self:Healer()) then
				prev = t
				self:Message(198245, "Important", "Bam", CL.other:format(n, CL.percent:format(power, self:SpellName(198245))))
		end
	end
end

function mod:BrutalHaymaker(args)
	self:Message(args.spellId, "Positive", "Alarm", CL.incoming:format(args.spellName))
end

function mod:EarthshakingStomp(args)
	self:Message(args.spellId, "Urgent", "Info")
	self:Bar(args.spellId, 24.3)
end

function mod:HatefulGaze(args)
	if self:Me(args.destGUID) then
		self:Say(args.spellId)
	end
	self:Bar(args.spellId, 25.4)
	self:TargetMessage(args.spellId, args.destName, "Attention", "Warning", nil, nil, true)
end

function mod:HatefulGazeApplied(args)
	self:PrimaryIcon(args.spellId, args.destName)
	if self:Me(args.destGUID) then
		local _, _, duration = self:UnitDebuff("player", args.spellId)
		self:SayCountdown(args.spellId, duration, 8, 3)
	end
end

function mod:HatefulGazeRemoved(args)
	self:PrimaryIcon(args.spellId, nil)
	self:CancelSayCountdown(args.spellId)
end

function mod:FelVomit(args)	
	self:TargetMessage(args.spellId, args.destName, "Important", "none", nil, nil, true)
	if self:Me(args.destGUID) then
		self:PlaySound(args.spellId, "alarm", nil, args.destName)
		self:Say(args.spellId)
	else
		self:PlaySound(args.spellId, "alert", nil, args.destName)
	end
end

