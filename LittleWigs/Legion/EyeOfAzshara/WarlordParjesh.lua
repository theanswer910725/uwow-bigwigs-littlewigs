
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Warlord Parjesh", 1456, 1480)
if not mod then return end
mod:RegisterEnableMob(91784)
mod.engageId = 1810

--------------------------------------------------------------------------------
-- Locals
--
local addCount = 1

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		{192094, "ICON", "SAY", "FLASH"}, -- Impaling Spear
		{192131, "ICON", "SAY"}, -- Throw Spear
		197064, -- Enrage
		197502, -- Restoration
		191900, -- Crashing Wave
		192053, -- Quicksand
		192072, -- Call Reinforcements
		196563, -- Call Reinforcements
	}, {
		[192094] = "general",
		[192072] = "normal",
		[196563] = "heroic",
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "ImpalingSpear", 192094)
	self:Log("SPELL_AURA_REMOVED", "ImpalingSpearOver", 192094)
	self:Log("SPELL_AURA_APPLIED", "ThrowSpear", 192131)
	self:Log("SPELL_AURA_REMOVED", "ThrowSpearRemoved", 192131)
	self:Log("SPELL_CAST_SUCCESS", "CallReinforcementsNormal", 192072, 192073)
	self:Log("SPELL_CAST_SUCCESS", "CallReinforcements", 196563)
	self:Log("SPELL_AURA_APPLIED", "Enrage", 197064)
	self:Log("SPELL_CAST_START", "Restoration", 197502)
	self:Log("SPELL_CAST_START", "CrashingWave", 191900)

	self:Log("SPELL_AURA_APPLIED", "QuicksandDamage", 192053)
	self:Log("SPELL_PERIODIC_DAMAGE", "QuicksandDamage", 192053)
	self:Log("SPELL_PERIODIC_MISSED", "QuicksandDamage", 192053)
	
	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", "Spear", "boss1")
	self:RegisterUnitEvent("UNIT_POWER", nil, "boss1")
	self:RegisterUnitEvent("UNIT_SPELLCAST_STOP", nil, "boss1")
end

function mod:OnEngage()
	addCount = 1
	self:CDBar(192094, self:Normal() and 35 or 29) -- Impaling Spear
	self:CDBar(191900, self:Normal() and 31 or 25) -- Crashing Wave
	self:CDBar(192131, 10.9) -- ThrowSpear
	self:CDBar(self:Normal() and 192072 or 196563, 5) -- Call Reinforcements
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:UNIT_SPELLCAST_STOP(_, _, _, spellId, spellName)
	if spellName == 191946 then
		self:PrimaryIcon(192094, nil)
		self:CancelSayCountdown(192094)
	end
end

do
	local prev = 0
	function mod:UNIT_POWER(unit, pType, args)
		if pType == "ENERGY" then
			local t = GetTime()
			if t-prev > 0.5 then
				prev = t
				local power = UnitPower(unit, 3)
				if power > 89 and power < 94 then
					self:Message(191900, "Personal", "Bike Horn", CL.percent:format(power, self:SpellName(191900)))
				end
			end
		end
	end
end

function mod:Spear(_, spellName, _, _, spellId)
	if spellId == 192131 and self:BarTimeLeft(191900) < 16 and self:BarTimeLeft(191900)+8 > 16 and self:BarTimeLeft(196563)+8 > 16 and self:BarTimeLeft(196563)-self:BarTimeLeft(191900) < 9.7 then
		self:CDBar(192131, self:BarTimeLeft(191900)+9.7)
		self:CDBar(196563, self:BarTimeLeft(191900)+13.4)
	elseif spellId == 192131 and self:BarTimeLeft(191900) < 16 and self:BarTimeLeft(191900)+8 > 16 then
		self:CDBar(192131, self:BarTimeLeft(191900)+9.7)
	elseif spellId == 192131 then
		self:CDBar(192131, 16)
	end
end

function mod:ImpalingSpear(args)
	self:TargetMessage(args.spellId, args.destName, "Important", "Warning")
	self:CDBar(args.spellId, 27) -- pull:35.0, 31.6 / hc pull:29.2, 29.2, 26.8 / m pull:29.1, 28.0, 28.3, 27.5
	self:PrimaryIcon(args.spellId, args.destName)
	if self:Me(args.destGUID) then
		self:Say(args.spellId)
		self:Flash(args.spellId)
		self:SayCountdown(192094, 5, 8, 3)
	end
	ThrowSpearTimeLeft = self:BarTimeLeft(192131)
	CallReinforcementsTimeLeft = self:BarTimeLeft(196563)
	if ThrowSpearTimeLeft < 6.5 then
		self:CDBar(192131, 6.5)
	elseif CallReinforcementsTimeLeft < 6.5 then
		self:CDBar(196563, 6.5)
	end
end

function mod:ImpalingSpearOver(args)
	self:PrimaryIcon(args.spellId, nil)
	if self:Me(args.destGUID) then
		self:CancelSayCountdown(192094)
	end
end

function mod:ThrowSpear(args)
	self:SecondaryIcon(args.spellId, args.destName)
	if self:Me(args.destGUID) then
		self:Say(192131)
		self:TargetMessage(args.spellId, args.destName, "Personal", "Bam")
	else
		self:TargetMessage(args.spellId, args.destName, "Attention", "Alarm")
	end
end

function mod:ThrowSpearRemoved(args)
	self:SecondaryIcon(args.spellId, nil)
end

do
	function mod:CallReinforcementsNormal(args) -- Normal only
		--["192073-Call Reinforcements"] = "pull:26.0, 52.3",
		--["192072-Call Reinforcements"] = "pull:5.4, 52.3, 52.2",
		self:Message(192072, "Attention", "Info", args.spellName, args.spellId)
		self:CDBar(192072, addCount % 2 == 0 and 31 or 20, args.spellName, args.spellId == 192072 and 192073 or 192072) -- Use correct icon for upcoming add
		addCount = addCount + 1
	end
	function mod:CallReinforcements(args) -- Heroic +
		self:Message(args.spellId, "Attention", "Info")
		self:CDBar(args.spellId, 28) -- hc pull:5.4, 31.6, 31.6, 27.9, 29.2 / m pull:5.7, 31.5, 28.0, 27.9, 27.9
		ThrowSpearTimeLeft = self:BarTimeLeft(192131)
		if ThrowSpearTimeLeft < 2 then
			self:CDBar(192131, 2)
		end
	end
end

function mod:Enrage(args)
	self:Message(args.spellId, "Urgent", "Alert", CL.percent:format(30, args.spellName))
end

function mod:Restoration(args)
	self:Message(args.spellId, "Positive", self:Interrupter() and "Warning" or "Long", CL.casting:format(args.spellName))
end

function mod:CrashingWave(args)
	self:Message(args.spellId, "Attention", "Alert", CL.casting:format(args.spellName))
	self:CDBar(args.spellId, 27)
	ThrowSpearTimeLeft = self:BarTimeLeft(192131)
	if ThrowSpearTimeLeft < 2.5 then
		self:CDBar(192131, 2.5)
	end
end

do
	local prev = 0
	function mod:QuicksandDamage(args)
		if self:Me(args.destGUID) then
			local t = GetTime()
			if t-prev > 2 then
				prev = t
				self:Message(args.spellId, "Personal", "Alarm", CL.underyou:format(args.spellName))
			end
		end
	end
end
