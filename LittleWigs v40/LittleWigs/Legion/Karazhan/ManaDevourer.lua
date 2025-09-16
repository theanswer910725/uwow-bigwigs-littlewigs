
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Mana Devourer", 1651, 1818)
if not mod then return end
mod:RegisterEnableMob(114252)
mod.engageId = 1959

--------------------------------------------------------------------------------
-- Locals
--

local unstableManaOnMe = false
local DecimatingPercent = 1

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"stages",
		227618, -- Arcane Bomb
		227523, -- Energy Void
		227502, -- Unstable Mana
		227297, -- Coalesce Power
		227457, -- Energy Discharge
		227507, -- Decimating Essence
		227296,
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")
	self:Log("SPELL_CAST_SUCCESS", "ArcaneBomb", 227618)
	self:Log("SPELL_CAST_SUCCESS", "EnergyVoid", 227523)
	self:Log("SPELL_AURA_APPLIED", "UnstableMana", 227502)
	self:Log("SPELL_AURA_APPLIED_DOSE", "UnstableMana", 227502)
	self:Log("SPELL_AURA_REMOVED", "UnstableManaRemoved", 227502)
	self:Log("SPELL_AURA_APPLIED", "CoalescePower", 227297)
	self:Log("SPELL_PERIODIC_DAMAGE", "EnergyVoidDamage", 227524)
	self:Log("SPELL_PERIODIC_MISSED", "EnergyVoidDamage", 227524)
	self:Log("SPELL_CAST_START", "DecimatingEssence", 227507)
	self:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED")
	self:RegisterUnitEvent("UNIT_POWER", nil, "boss1")
	self:Death("Win", 0)
end

function mod:OnEngage()
	unstableManaOnMe = false
	DecimatingPercent = 0
	self:Bar(227297, 30) -- Coalesce Power
	self:Bar(227457, 22) -- Energy Discharge
	self:Bar(227618, 7) -- Arcane Bomb
	self:Bar(227523, 14.5) -- Energy Void
end

--------------------------------------------------------------------------------
-- Event Handlers
--

do
	local prev = nil
	function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, _, _, spellGUID, spellId)
		if spellId == 227457 and spellGUID ~= prev then
			prev = spellGUID
			self:CDBar(227457, 27) -- Energy Discharge
		elseif spellId == 227502 and spellGUID ~= prev then
			prev = spellGUID
			DecimatingPercent = DecimatingPercent - 5
			self:Message(227296, "Attention", "Long", CL.percent:format(DecimatingPercent, self:SpellName(227296)))
		elseif spellId == 227507 and spellGUID ~= prev then
			prev = spellGUID
			DecimatingPercent = 0
		end
	end
end

do
	function mod:UNIT_POWER(unit, pType, args)
		if pType == "MANA" then
			local power = UnitPower(unit, 0)/1000
			CoalescePowerTimeLeft = self:BarTimeLeft(227297)
			if CoalescePowerTimeLeft < 1 then
				DecimatingPercent = power + 40
			elseif CoalescePowerTimeLeft > 0.9 and CoalescePowerTimeLeft < 3.1 then
				DecimatingPercent = power + 35
			end
		end
	end
end

function mod:ArcaneBomb(args)
	self:Message(args.spellId, "Important", "Warning")
	self:CDBar(args.spellId, 14.5)
end

function mod:EnergyVoid(args)
	self:Message(args.spellId, "Attention", "Info")
	self:Bar(args.spellId, 21.9)
end

function mod:UnstableMana(args)
	if self:Me(args.destGUID) then
		unstableManaOnMe = true
		local amount = args.amount or 1
		self:StackMessage(args.spellId, args.destName, amount, "Positive")
	end
end

function mod:UnstableManaRemoved(args)
	if self:Me(args.destGUID) then
		unstableManaOnMe = false
	end
end

function mod:CoalescePower(args)
	--self:Message(args.spellId, "Urgent", "Long")
	self:Bar(args.spellId, 30.3)
	if DecimatingPercent < 100 then
		self:Message(227296, "Positive", "Info", CL.percent:format(DecimatingPercent, self:SpellName(227296)))
	elseif DecimatingPercent > 95 then
		self:Message(227296, "Urgent", "Long", CL.percent:format(DecimatingPercent, self:SpellName(227296)))
	end
end

function mod:DecimatingEssence(args)
	self:Message(args.spellId, "red")
	self:PlaySound(args.spellId, "Bam")
	self:CastBar(args.spellId, 2)
end

do
	local prev = 0
	function mod:EnergyVoidDamage(args)
		if self:Me(args.destGUID) and not unstableManaOnMe then
			local t = GetTime()
			if t-prev > 2 then
				prev = t
				self:Message(227523, "Personal", "Alarm", CL.underyou:format(args.spellName))
			end
		end
	end
end
