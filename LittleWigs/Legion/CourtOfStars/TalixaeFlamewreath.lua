--TO DO
--maybe some sort of dispel warning when people reach x stacks of Withering Soul?

--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Talixae Flamewreath", 1571, 1719)
if not mod then return end
mod:RegisterEnableMob(104217)
mod.engageId = 1869

--------------------------------------------------------------------------------
-- Locals
--

local InfernalEruptionCount = 0
local BurningIntensityCount = 0
local WitheringSoulCount = 0

local timers = {
	[207881] = {14.4, 20.63, 25.47, 22.99, 25.51, 22.52, 25.47, 22.53, 25.50, 22.55, 25.54, 22.52, 25.55, 22.31, 25.52, 22.46, 25.50, 22.13, 25.50, 21.96, 25.55},
	[208165] = {11.9, 14.52, 14.55, 16.93, 14.56, 14.51, 16.99, 14.53, 14.54, 16.92, 14.54, 14.53, 16.95, 14.50, 14.56, 16.98, 14.53, 14.55, 16.97, 14.50, 14.51, 17.03, 14.56, 14.55, 16.97, 14.50, 14.51, 16.99, 14.53, 14.54, 17.02},
	[207906] = {6, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23},
}
--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		207881, -- Infernal Eruption
		207906, -- Burning Intensity
		208165, -- Withering Soul
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "InfernalEruption", 207881)
	self:Log("SPELL_CAST_START", "BurningIntensity", 207906)
	self:Log("SPELL_CAST_START", "WitheringSoul", 208165)
	self:Death("TalixaeFlamewreathDeath", 104217)
end

function mod:OnEngage()
	InfernalEruptionCount = 1
	BurningIntensityCount = 1
	WitheringSoulCount = 1
	self:Bar(207906, timers[207906][BurningIntensityCount], CL.count:format(self:SpellName(207906), BurningIntensityCount)) -- Burning Intensity
	self:Bar(208165, timers[208165][WitheringSoulCount], CL.count:format(self:SpellName(208165), WitheringSoulCount)) -- Withering Soul
	self:Bar(207881, timers[207881][InfernalEruptionCount], CL.count:format(self:SpellName(207881), InfernalEruptionCount)) -- Infernal Eruption
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:InfernalEruption(args)
	self:Message(args.spellId, "Urgent", "Long", CL.count:format(args.spellName, InfernalEruptionCount))
	InfernalEruptionCount = InfernalEruptionCount + 1
	self:Bar(args.spellId, timers[args.spellId][InfernalEruptionCount], CL.count:format(self:SpellName(207881), InfernalEruptionCount))
end

function mod:BurningIntensity(args)
	self:Message(args.spellId, "Important", "Info", CL.count:format(args.spellName, BurningIntensityCount))
	BurningIntensityCount = BurningIntensityCount + 1
	self:Bar(args.spellId, timers[args.spellId][BurningIntensityCount], CL.count:format(self:SpellName(207906), BurningIntensityCount))
end

function mod:WitheringSoul(args)
	self:Message(args.spellId, "Attention", "Alert", CL.count:format(args.spellName, WitheringSoulCount))
	WitheringSoulCount = WitheringSoulCount + 1
	self:Bar(args.spellId, timers[args.spellId][WitheringSoulCount], CL.count:format(self:SpellName(208165), WitheringSoulCount))
end

function mod:TalixaeFlamewreathDeath(args)
	local AdvisorMod = BigWigs:GetBossModule("Advisor Melandrus", true)
	if AdvisorMod then
		AdvisorMod:Enable()
	end
end