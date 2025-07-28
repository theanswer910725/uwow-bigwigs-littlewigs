
--------------------------------------------------------------------------------
-- TODO List:
-- - Mythic

--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Thrashbite the Scornful", 1677, 1906)
if not mod then return end
mod:RegisterEnableMob(117194)
mod.engageId = 2057

--------------------------------------------------------------------------------
-- Locals
--
--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		237276, -- Pulverizing Cudgel
		{237726, "SAY", "FLASH", "ICON"}, -- Scornful Gaze
		243124, -- Heave Cudgel
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "PulverizingCudgel", 237276)
	self:Log("SPELL_AURA_APPLIED", "ScornfulGaze", 237726)
	self:Log("SPELL_AURA_REMOVED", "ScornfulGazeRemoved", 237726)
	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss1")
end

function mod:OnEngage()
	self:Bar(237276, 5.9)
	self:Bar(243124, 17.7)
	self:Bar(237726, 26.5)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:UNIT_SPELLCAST_SUCCEEDED(unit, spellName, _, _, spellId)
	if spellId == 243124 then
		self:Message(243124, "Important", "Alert", CL.incoming:format(self:SpellName(243124)))
		self:CDBar(243124, 36.5)
	end
end

function mod:PulverizingCudgel(args)
	self:Message(args.spellId, "Urgent", "Alert")
	self:CDBar(args.spellId, 25)
	ScornfulGazeTimeLeft = self:BarTimeLeft(237726)
	HeaveCudgelTimeLeft = self:BarTimeLeft(243124)
	if ScornfulGazeTimeLeft < 4 then
		self:CDBar(237726, 4.8)
	elseif HeaveCudgelTimeLeft < 4 then
		self:CDBar(243124, 5.8)
	elseif ScornfulGazeTimeLeft > 25 then
		self:CDBar(args.spellId, 27.8)
		self:CDBar(237726, 32.6)
	end
end

function mod:ScornfulGaze(args)
	self:PrimaryIcon(237726, args.destName)
	self:TargetMessage(args.spellId, args.destName, "Urgent", "Warning", args.spellName)
	self:TargetBar(args.spellId, 7, args.destName)
	self:CDBar(args.spellId, 35.3)
	if self:Me(args.destGUID) then
		self:Say(args.spellId)
		self:SayCountdown(237726, 7, 8, 3)
		self:Flash(args.spellId)
	end
	PulverizingCudgelLeft = self:BarTimeLeft(237276)
	HeaveCudgelTimeLeft = self:BarTimeLeft(243124)
	if PulverizingCudgelLeft < 7 then
		self:CDBar(237276, 8)
	elseif HeaveCudgelTimeLeft < 7 then
		self:CDBar(243124, 9.4)
	end
end

function mod:ScornfulGazeRemoved(args)
	self:PrimaryIcon(237726, nil)
end
