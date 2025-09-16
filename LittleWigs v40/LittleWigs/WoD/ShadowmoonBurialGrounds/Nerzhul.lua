
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Ner'zhul", 1176, 1160)
if not mod then return end
mod:RegisterEnableMob(76407)
mod.engageId = 1682
mod.respawnTime = 33

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		154442, -- Malevolence
		154350, -- Omen of Death
		154469, -- Ritual of Bones
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "Malevolence", 154442)
	self:Log("SPELL_SUMMON", "OmenOfDeath", 154350)
	self:Log("SPELL_CAST_SUCCESS", "RitualOfBones", 154671)
	self:Log("SPELL_AURA_APPLIED", "RitualOfBonesApplied", 154469)
end

function mod:OnEngage()
	self:CDBar(154442, 9.49) -- Malevolence
	self:CDBar(154350, 8.27) -- Omen of Death
	self:CDBar(154469, 22.04) -- Ritual of Bones
	self:ScheduleTimer("RB", 21)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:RB()
	self:ScheduleTimer("RB", 51.5)
	self:CDBar(154469, 51.5)
	self:CDBar(154350, 24.5)
	self:Message(154469, "Urgent", "Warning")
end

function mod:Malevolence(args)
	self:Message(args.spellId, "Attention", "Alarm")
	if self:BarTimeLeft(154350) < 3 then
		self:CDBar(args.spellId, 8.5)
		self:Bar(154350, 3.6)
	else
		self:CDBar(args.spellId, 8.5)
	end
end

function mod:OmenOfDeath(args)
	self:Message(args.spellId, "Important", "Alert")
	if self:BarTimeLeft(154469) > 10 and self:BarTimeLeft(154469) < 30 then
		self:Bar(args.spellId, 11)
	end
end

function mod:RitualOfBones(args)
	self:Message(154469, "Urgent", "Warning")
	self:CDBar(154469, 50.5)
	-- Ritual of Bones puts Omen of Death on a longer cooldown
	self:CDBar(154350, 25.4) -- Omen of Death
end

function mod:RitualOfBonesApplied(args)
	if self:Me(args.destGUID) then
		self:Message(args.spellId, "Personal", "Alarm", CL.underyou:format(args.spellName))
	elseif self:Healer() then
		self:TargetMessage(args.spellId, args.destName, "Important", "Alert")
	end
end
