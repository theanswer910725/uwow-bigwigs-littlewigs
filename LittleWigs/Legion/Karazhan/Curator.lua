
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("The Curator", 1651, 1836)
if not mod then return end
mod:RegisterEnableMob(114247, 114249)
mod.engageId = 1964
mod.respawnTime = 15

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.Energy = "Volatile Energy"
end

--------------------------------------------------------------------------------
-- Initialization
--


function mod:GetOptions()
	return {
		"stages",
		227267, -- Summon Volatile Energy
		227279, -- Power Discharge
		227254, -- Evocation
		227270, -- ArcLightning
		228738, -- Static Charge
	}, {
		[227270] = L.Energy,
	}
end

function mod:OnBossEnable()
	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", "PowerDischarge", "boss1")
	self:Log("SPELL_CAST_SUCCESS", "SummonVolatileEnergy", 227267)
	self:Log("SPELL_PERIODIC_DAMAGE", "PowerDischargeDamage", 227465)
	self:Log("SPELL_PERIODIC_MISSED", "PowerDischargeDamage", 227465)
	self:Log("SPELL_AURA_APPLIED", "ArcLightning", 227270)
	self:Log("SPELL_AURA_APPLIED_DOSE", "ArcLightningApplied", 227270)
	self:Log("SPELL_AURA_APPLIED", "Evocation", 227254)
	self:Log("SPELL_AURA_REMOVED", "EvocationOver", 227254)
	self:Death("ImageDeath", 114249)
end

function mod:OnEngage()
	self:Bar(227267, 5) -- Summon Volatile Energy
	self:CDBar(227279, 12) -- Power Discharge
	self:CDBar(227254, 53) -- Evocation
	addsKilled = 0
end

--------------------------------------------------------------------------------
-- Event Handlers
--
function mod:PowerDischarge()
	if self:BarTimeLeft(227254) > 14 then
		self:CDBar(227279, 14) -- Power Discharge
		self:ScheduleTimer("PowerDischarge", 14)
	end
	self:Message(227279, "Urgent", "Alert")
end
function mod:ArcLightningApplied(args)
	local amount = args.amount
	if amount % 3 == 0 then
		self:StackMessage(227270, args.destName, amount, "Personal", "Warning")
	end
end

function mod:ArcLightning(args)
	self:Bar(228738, 5)
	self:Bar(227267, 8)
end

function mod:SummonVolatileEnergy(args)
	self:Message(args.spellId, "Attention", "Info")
	self:Bar(args.spellId, 9.7)
end

function mod:PowerDischarge(_, _, _, _, spellId)
	if spellId == 227278 then
		self:Message(227279, "Urgent", "Alert")
		self:CDBar(227279, 12)
	end
end

do
	local prev = 0
	function mod:PowerDischargeDamage(args)
		if self:Me(args.destGUID) then
			local t = GetTime()
			if t-prev > 2 then
				prev = t
				self:Message(227279, "Personal", "Alarm", CL.underyou:format(args.spellName))
			end
		end
	end
end

function mod:Evocation(args)
	self:Message(args.spellId, "Positive", "Long")
	self:CastBar(args.spellId, 20)
	self:StopBar(227267) -- Summon Volatile Energy
	self:StopBar(227279) -- Power Discharges
	self:StopBar(227270)
end

function mod:ImageDeath(args)
	addsKilled = addsKilled + 1
	self:Message("stages", "Neutral", addsKilled == 5 and "Long", CL.mob_killed:format(args.destName, addsKilled, 5), false)
end

function mod:EvocationOver(args)
	self:CDBar(227279, 13) -- Power Discharge
	self:ScheduleTimer("PowerDischarge", 13)
	self:Message(args.spellId, "Neutral", "Info", CL.over:format(args.spellName))
	self:CDBar(args.spellId, 53)
	self:Bar(227267, 6)
	addsKilled = 0
end
