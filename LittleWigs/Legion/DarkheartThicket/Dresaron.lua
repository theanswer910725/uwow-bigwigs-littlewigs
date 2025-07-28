
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Dresaron", 1466, 1656)
if not mod then return end
mod:RegisterEnableMob(99200)
mod.engageId = 1838 -- START fires prior to engaging the boss

local first = true
local PhaseCount = 0
local BreathCount = 0

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		199345, -- Down Draft
		199389, -- Earthshaking Roar	
		199460, -- Falling Rocks
		191325, -- Breath of Corruption
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "DownDraft", 199345)
	
	self:Log("SPELL_CAST_START", "EarthshakingRoar", 199389)

	self:Log("SPELL_AURA_APPLIED", "FallingRocksDamage", 199460)
	self:Log("SPELL_PERIODIC_DAMAGE", "FallingRocksDamage", 199460)
	self:Log("SPELL_PERIODIC_MISSED", "FallingRocksDamage", 199460)

	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss1")

	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")

	self:Death("Win", 99200)
end

function mod:OnEngage()
	PhaseCount = 0
	BreathCount = 1
	first = true
	self:CDBar(199389, 19.7) -- Earthshaking Roar
	self:CDBar(199345, 19.7) -- Down Draft
	self:CDBar(191325, 13.3) -- Breath of Corruption
end

--------------------------------------------------------------------------------
-- Event Handlers
--


function mod:EarthshakingRoar(args)
	if PhaseCount == 0 then
		PhaseCount = 2
		self:CDBar(199345, 3.7) -- Down Draft
		self:CDBar(191325, 15) -- Breath of Corruption
		self:CDBar(199389, 22.5) -- Earthshaking Roar
	elseif PhaseCount == 1 then
		self:CDBar(199389, 34) -- Earthshaking Roar
	elseif PhaseCount == 3 then
		self:CDBar(199389, 30) -- Earthshaking Roar
	end
end

function mod:DownDraft(args)
	if PhaseCount == 0 then
		self:CDBar(199389, 11.5) -- Earthshaking Roar
		self:CDBar(191325, 15) -- Breath of Corruption
		self:CDBar(args.spellId, 34) -- Down Draft
		PhaseCount = 1
	elseif PhaseCount == 1 then
		self:CDBar(199389, 11.5) -- Earthshaking Roar
		self:CDBar(191325, 15) -- Breath of Corruption
		self:CDBar(args.spellId, 34) -- Down Draft
	elseif PhaseCount == 2 then
		self:CDBar(args.spellId, 30) -- Down Draft
		self:CDBar(191325, 12) -- Breath of Corruption
		self:CDBar(199389, 18.5) -- Earthshaking Roar
		PhaseCount = 3
	elseif PhaseCount == 3 then
		self:CDBar(args.spellId, 30) -- Down Draft
		self:CDBar(191325, 12) -- Breath of Corruption
		self:CDBar(199389, 17) -- Earthshaking Roar
	end
	self:Message(args.spellId, "Important", "Warning")
end

do
	local prev = 0
	function mod:FallingRocksDamage(args)
		if self:Me(args.destGUID) then
			local t = GetTime()
			if t-prev > 2 then
				prev = t
				self:Message(args.spellId, "Personal", "Alarm", CL.you:format(args.spellName))
			end
		end
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, _, _, spellId)
	if spellId == 199332 and PhaseCount == 0 then
		self:Message(191325, "Attention", "Info")
		BreathCount = BreathCount + 1
	elseif spellId == 199332 and PhaseCount == 1 then
		self:Bar(191325, BreathCount % 2 == 0 and 13 or 20)
		self:Message(191325, "Attention", "Info")
		BreathCount = BreathCount + 1
	elseif spellId == 199332 and PhaseCount == 2 then -- Breath of Corruption
		self:Bar(191325, BreathCount % 2 == 0 and 13 or 18)
		self:Message(191325, "Attention", "Info")
		BreathCount = BreathCount + 1
	elseif spellId == 199332 and PhaseCount == 3 then
		self:Bar(191325, BreathCount % 2 == 0 and 13 or 18)
		self:Message(191325, "Attention", "Info")
		BreathCount = BreathCount + 1
	end
end

