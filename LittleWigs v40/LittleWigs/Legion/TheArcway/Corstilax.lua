
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Corstilax", 1516, 1498)
if not mod then return end
mod:RegisterEnableMob(98205)
mod.engageId = 1825

local EnergyBurstCounter = 1

local timersMythic = {
	--[[ Energy Burst ]]--
	[195362] = {18.23, 30.00, 41.80, 41.24, 30.00, 40.47, 44.68, 30.01, 29.98, 44.10, 30.07, 30.00},
}

local timers = timersMythic
--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		195804, -- Quarantine
		{196068, "ICON", "SAY"}, -- Suppression Protocol
		196115, -- Cleansing Force
		{220481, "FLASH"}, -- Destabilized Orb
		195362, -- Energy Burst
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_SUCCESS", "QuarantineSuccess", 195791)
	self:Log("SPELL_AURA_APPLIED", "Quarantine", 195804)
	self:Log("SPELL_AURA_APPLIED", "SuppressionProtocol", 196068)
	self:Log("SPELL_AURA_REMOVED", "SuppressionProtocolRemoved", 196068)
	self:Log("SPELL_CAST_START", "CleansingForce", 196115)
	self:Log("SPELL_CAST_SUCCESS", "DestabilizedOrb", 220481)
	self:Log("SPELL_AURA_APPLIED", "DestabilizedOrbDamage", 220500)
	self:Log("SPELL_PERIODIC_DAMAGE", "DestabilizedOrbDamage", 220500)
end

function mod:OnEngage()
	timers = timersMythic
	EnergyBurstCounter = 1
	self:Bar(195362, timers[195362][EnergyBurstCounter]) -- Energy Burst
	self:ScheduleTimer("EnergyBurst", timers[195362][EnergyBurstCounter])
	self:CDBar(196068, 6) -- Suppression Protocol
	self:CDBar(195804, 22) -- Quarantine
	self:CDBar(196115, 30) -- Cleansing Force
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:EnergyBurst()
	self:Message(195362, "Positive", "Long")
	EnergyBurstCounter = EnergyBurstCounter + 1
	self:Bar(195362, timers[195362][EnergyBurstCounter])
	self:ScheduleTimer("EnergyBurst", timers[195362][EnergyBurstCounter])
end

function mod:Quarantine(args)
	self:TargetMessage(args.spellId, args.destName, "Attention", "Info", nil, nil, true)
	self:CDBar(args.spellId, 48)
end

function mod:QuarantineSuccess(args)
	self:CDBar(195804, 47)
end

function mod:SuppressionProtocol(args)
	self:TargetMessage(args.spellId, args.destName, "Urgent", "Alarm")
	self:TargetBar(args.spellId, 8, args.destName)
	self:ScheduleTimer("CDBar", 8, args.spellId, 38)
	self:PrimaryIcon(args.spellId, args.destName)
	self:ScheduleTimer("PrimaryIcon", 8, args.spellId, nil)
	if self:Me(args.destGUID) then
		self:SayCountdown(args.spellId, 8, nil, 3)
		self:Say(args.spellId)
	end
end

function mod:SuppressionProtocolRemoved(args)
	self:PrimaryIcon(args.spellId, nil)
end

function mod:CleansingForce(args)
	self:Message(args.spellId, "Urgent", "Alert")
	self:Bar(args.spellId, 10, CL.cast:format(args.spellName))
	self:CDBar(args.spellId, 46)
end

function mod:DestabilizedOrb(args)
	self:Message(args.spellId, "Attention")
end

do
	local prev = 0
	function mod:DestabilizedOrbDamage(args)
		if self:Me(args.destGUID) then
			local t = GetTime()
			if t-prev > 2 then
				prev = t
				self:Flash(220481)
				self:Message(220481, "Personal", "Alarm", CL.underyou:format(args.spellName))
			end
		end
	end
end
