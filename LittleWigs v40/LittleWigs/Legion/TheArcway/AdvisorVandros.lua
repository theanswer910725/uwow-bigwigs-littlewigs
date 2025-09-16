
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Advisor Vandros", 1516, 1501)
if not mod then return end
mod:RegisterEnableMob(98208)
mod.engageId = 1829

--------------------------------------------------------------------------------
-- Locals
--

local blastCount = 1

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		203176, -- Accelerating Blast
		202974, -- Force Bomb
		{220871, "ICON", "SAY"}, -- Unstable Mana
		203882, -- Banish In Time
		203833, -- Time Split
		{203957, "SAY"}, -- Time Lock
		203881, -- Summon Chrono Shard
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "AcceleratingBlast", 203176)
	self:Log("SPELL_AURA_APPLIED", "AcceleratingBlastApplied", 203176)
	self:Log("SPELL_CAST_START", "ForceBomb", 202974)
	self:Log("SPELL_CAST_START", "UnstableManaStart", 220871)
	self:Log("SPELL_AURA_APPLIED", "UnstableMana", 220871)
	self:Log("SPELL_AURA_REMOVED", "UnstableManaRemoved", 220871)
	self:Log("SPELL_CAST_START", "BanishInTime", 203882)
	self:Log("SPELL_AURA_REMOVED", "BanishInTimeRemoved", 203914)
	self:Log("SPELL_SUMMON", "ChronoShard", 203881)
	self:Log("SPELL_SUMMON", "ChronoShard", 203254)
	self:Log("SPELL_AURA_APPLIED", "TimeLock", 203957)
	self:Log("SPELL_AURA_REMOVED", "TimeLockRemoved", 203957)
end

function mod:OnEngage()
	blastCount = 1
	self:CDBar(203881, 10.9)
	self:CDBar(203833, 18.9)
	self:CDBar(202974, 26) -- Force Bomb
	self:RegisterUnitEvent("UNIT_HEALTH_FREQUENT", nil, "boss1")
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:TimeLock(args)
	self:TargetMessage(args.spellId, args.destName, "Urgent", "Punch")
	if self:Me(args.destGUID) then
		self:Say(args.spellId)
		local _, _, duration = self:UnitDebuff("player", args.spellId)
		self:SayCountdown(args.spellId, duration, 8, 5)
	end
end

function mod:TimeLockRemoved(args)
	if self:Me(args.destGUID) then
		self:CancelSayCountdown(203957)
	end
end



function mod:ChronoShard(args)
	self:Message(203881, "Attention", "Alert")
	self:CDBar(203833, 8)
	self:CDBar(203881, 10.9)
end

function mod:UNIT_HEALTH_FREQUENT(unit)
	local hp = UnitHealth(unit) / UnitHealthMax(unit) * 100
	if hp <= 55 then
		self:UnregisterUnitEvent("UNIT_HEALTH_FREQUENT", unit)
		self:Message(203882, "Attention", "Info", CL.incoming:format(self:SpellName(203882)))
	end
end

function mod:AcceleratingBlast(args)
	if self:Interrupter() then
		self:Message(args.spellId, "Attention", nil, CL.count:format(args.spellName, blastCount))
	end
	blastCount = blastCount + 1
	if blastCount > 3 then blastCount = 1 end
end

function mod:AcceleratingBlastApplied(args)
	local count = args.amount or 1
	if self:Dispeller("magic", true) and count > 5 and count % 3 == 0 then
		self:StackMessage(args.spellId, args.destName, count, "Urgent", "Alert")
	end
end

function mod:UnstableManaStart(args)
	self:Message(args.spellId, "Attention", "Long")
	self:CDBar(args.spellId, 35) -- never in p1 long enough to get a second cast :\
end

function mod:ForceBomb(args)
	self:Message(args.spellId, "Attention", "Info")
	self:CDBar(args.spellId, 42) -- never in p1 long enough to get a second cast :\
end

function mod:UnstableMana(args)
	self:TargetBar(args.spellId, 8, args.destName)
	self:PrimaryIcon(220871, args.destName)
	if self:Me(args.destGUID) then
		self:TargetMessage(args.spellId, args.destName, "Urgent", "Bam")
		self:Say(args.spellId)
		local _, _, duration = self:UnitDebuff("player", args.spellId)
		self:SayCountdown(args.spellId, duration, 8, 3)
	else
		self:TargetMessage(args.spellId, args.destName, "Urgent", "Alarm")
	end
end

function mod:UnstableManaRemoved(args)
	self:PrimaryIcon(220871, nil)
end

function mod:BanishInTimeRemoved(args)
	self:CDBar(220871, 5)
	self:CDBar(203881, 10.9)
	self:CDBar(203833, 18.9)
	self:CDBar(202974, 27)
end

function mod:BanishInTime(args)
	self:StopBar(202974) -- Force Bomb
	self:StopBar(203881)
	self:StopBar(203833)
	blastCount = 1

	self:Message(args.spellId, "Important", "Long")
end
