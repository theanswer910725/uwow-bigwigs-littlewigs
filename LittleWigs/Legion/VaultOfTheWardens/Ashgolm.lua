
--------------------------------------------------------------------------------
-- TODO List:
-- - Check timers

--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Ashgolm", 1493, 1468)
if not mod then return end
mod:RegisterEnableMob(95886, 99233)
mod.engageId = 1816

--------------------------------------------------------------------------------
-- Locals
--
local BrittleCount = 0
--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		192522, -- Fissure
		192520, -- Volcano
		192517, -- Brittle
		192519, -- Lava
		195187, -- Detonate
		-12727, -- Countermeasures
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("CHAT_MSG_MONSTER_EMOTE")
	self:Log("SPELL_CAST_START", "Fissure", 192522)
	self:Log("SPELL_CREATE", "Volcano", 192520)
	self:Log("SPELL_AURA_APPLIED", "Brittle", 192517)
	self:Log("SPELL_AURA_APPLIED", "Lava", 192519)
	self:Log("SPELL_CAST_START", "Detonate", 195187)
end

function mod:OnEngage()
	self:CDBar(-12727, 6.8, nil, "ability_monk_counteractmagic") -- Countermeasures
	self:CDBar(192520, 10) -- Volcano inc
	BrittleCount = 1
end

--------------------------------------------------------------------------------
-- Event Handlers
--
function mod:CHAT_MSG_MONSTER_EMOTE(_, _, sender)
	if sender == self:SpellName(-12727) then -- Countermeasures
		self:Message(-12727, "Positive", "Info", self:SpellName(-12727), false)
	end
end

function mod:Detonate(args)
	self:Message(args.spellId, "Attention", "Warning", CL.casting:format(args.spellName))
end

function mod:Fissure(args)
	self:Message(args.spellId, "Attention", "Alarm")
	self:Bar(args.spellId, 42)
end

function mod:Volcano(args)
	self:Message(args.spellId, "Important", "Long")
	self:Bar(args.spellId, 20)
end

function mod:Brittle(args)
	self:Message(args.spellId, "Positive", "Info")
	self:Bar(args.spellId, 20)
	local remainingVolcano = self:BarTimeLeft(192520)
	if remainingVolcano > 0 then
		self:Bar(192520, remainingVolcano+20) -- estimated
	end
	if self:MythicPlus() or self:Mythic() then
		if BrittleCount == 1 then
			self:CDBar(-12727, 66, nil, "ability_monk_counteractmagic") -- Countermeasures
		elseif BrittleCount == 2 then
			self:CDBar(-12727, 70, nil, "ability_monk_counteractmagic") -- Countermeasures
		elseif BrittleCount == 3 then
			self:CDBar(-12727, 66, nil, "ability_monk_counteractmagic") -- Countermeasures
		else
			self:CDBar(-12727, 70, nil, "ability_monk_counteractmagic") -- Countermeasures
		end
		BrittleCount = BrittleCount + BrittleCount
	end
end

function mod:Lava(args)
	if self:Me(args.destGUID) then
		self:Message(args.spellId, "Personal", "Alert", CL.underyou:format(args.spellName))
	end
end
