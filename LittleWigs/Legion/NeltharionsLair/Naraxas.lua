
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Naraxas", 1458, 1673)
if not mod then return end
mod:RegisterEnableMob(91005)
mod.engageId = 1792

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		199775, -- Frenzy
		{199178, "ICON", "SAY"}, -- Spiked Tongue
		205549, -- Rancid Maw
		210150, -- Toxic Retch
		-12527, -- Wormspeaker Devout
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_SUCCESS", "Frenzy", 199775)
	self:Log("SPELL_CAST_START", "SpikedTongue", 199176)
	self:Log("SPELL_AURA_APPLIED", "SpikedTongueApplied", 199178)
	self:Log("SPELL_AURA_REMOVED", "SpikedTongueRemoved", 199178)
	self:Log("SPELL_CAST_START", "RancidMaw", 205549)
	self:Log("SPELL_CAST_START", "ToxicRetchStart", 210150)
	self:Log("SPELL_CAST_SUCCESS", "ToxicRetch", 210150)

	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss1")
end

function mod:OnEngage()
	self:CDBar(199178, 54) -- Spiked Tongue
	self:CDBar(205549, 8) -- Rancid Maw
	self:CDBar(210150, 13) -- Toxic Retch
	self:CDBar(-12527, 6, -12527, 209906) -- Wormspeaker Devout: spell_shadow_ritualofsacrifice / Fanatic's Sacrifice / icon 136189
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Frenzy(args)
	self:Message(args.spellId, "Attention", "Long", CL.percent:format(20, args.spellName))
end

do
	local function printTarget(self, name, guid)
		self:PrimaryIcon(199178, name)
		if self:Me(guid) then
			self:TargetMessage(199178, name, "Personal", "Bike horn")
			self:Say(199178)
		else
			self:TargetMessage(199178, name, "Personal", "none")
		end
	end
	function mod:SpikedTongue(args)
		self:CDBar(199178, 6, CL.cast:format(args.spellName))
		self:CDBar(205549, 19)
		self:CDBar(210150, 17)
		self:CDBar(199178, 56)
		self:GetUnitTarget(printTarget, 0.4, args.sourceGUID)
		for unit in self:IterateGroup() do
			if self:Tank(unit) then
				self:PrimaryIcon(199178, unit)
				break
			end
		end
	end
end

function mod:SpikedTongueApplied(args)
	if self:MobId(args.destGUID) ~= 91005 then -- Naraxas
		self:TargetMessage(args.spellId, args.destName, "Positive", "Alarm", nil, nil, true)
		self:TargetBar(args.spellId, 10, args.destName)
		self:PrimaryIcon(args.spellId, args.destName)
		if self:Me(args.destGUID) then
			self:SayCountdown(199178, 10, 8, 5)
		end
	end
end

function mod:SpikedTongueRemoved(args)
	if self:MobId(args.destGUID) ~= 91005 then -- Naraxas
		self:Message(args.spellId, "Positive", nil, CL.over:format(args.spellName))
		self:StopBar(args.spellName, args.destName)
		self:PrimaryIcon(args.spellId)
		if self:Me(args.destGUID) then
			self:CancelSayCountdown(199178)
		end
	end
end

function mod:RancidMaw(args)
	self:Message(args.spellId, "Important", "Alert", CL.incoming:format(args.spellName))
	self:CDBar(args.spellId, 18) -- pull:7.2, 18.2, 20.6, 24.3, 18.2
end

function mod:ToxicRetchStart(args)
	self:Message(args.spellId, "Urgent", "Alert", CL.casting:format(args.spellName))
end

function mod:ToxicRetch(args)
	self:CDBar(args.spellId, 14) -- pull:12.1, 17.0, 14.6, 24.3, 14.5, 14.6
end

function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, _, _, spellId)
	if spellId == 199817 then -- Call Minions
		self:ScheduleTimer("Message", 4, -12527, "Attention", "Info", CL.incoming:format(self:SpellName(-12527)), 209906)
		self:ScheduleTimer("Bar", 4, -12527, 68, -12527, 209906) -- spell_shadow_ritualofsacrifice / Fanatic's Sacrifice / icon 136189
	end
end

