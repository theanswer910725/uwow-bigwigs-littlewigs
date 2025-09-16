--------------------------------------------------------------------------------
-- To Do
-- Enveloping Winds timers are not 100% accurate

--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Advisor Melandrus", 1571, 1720)
if not mod then return end
mod:RegisterEnableMob(104218)
mod.engageId = 1870

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.warmup_trigger = "Yet another failure, Melandrus. Consider this your chance to correct it. Dispose of these outsiders. I must return to the Nighthold."
	L.warmup_trigger2 = "Must you leave so soon, Grand Magistrix?"
end

--------------------------------------------------------------------------------
-- Locals
--

local bladeSurgeCount = 0
local slicingMaelstromCount = 0
local EnvelopingWindsCount = 0

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"warmup",
		209602, -- Blade Surge
		{224333, "SAY"}, -- Enveloping Winds
		209628, -- Piercing Gale
		209676, -- Slicing Maelstrom
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("CHAT_MSG_MONSTER_SAY", "Warmup")
	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss1")
	self:Log("SPELL_CAST_START", "BladeSurge", 209602)
	self:Log("SPELL_CAST_START", "PiercingGale", 209628)
	self:Log("SPELL_CAST_START", "SlicingMaelstrom", 209676)
	self:Log("SPELL_AURA_APPLIED", "EnvelopingWinds", 224333)
end

function mod:OnEngage()
	bladeSurgeCount = 1
	slicingMaelstromCount = 1
	EnvelopingWindsCount = 1
	self:CDBar(209628, 11) -- Piercing Gale
	self:CDBar(224333, 9.94) -- Enveloping Winds
	self:CDBar(209602, 5.96, CL.count:format(self:SpellName(209602), bladeSurgeCount)) -- Blade Surge
	self:CDBar(209676, 22.8, CL.count:format(self:SpellName(209676), slicingMaelstromCount)) -- Slicing Maelstrom
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Warmup(event, msg)
	if msg == L.warmup_trigger then
		self:UnregisterEvent(event)
		self:Bar("warmup", 7.4, CL.active, "inv_helm_mask_fittedalpha_b_01_nightborne_01")
	end
	if msg == L.warmup_trigger2 then
		self:Bar("warmup", 28, CL.active, "inv_helm_mask_fittedalpha_b_01_nightborne_01")
	end
end

function mod:BladeSurge(args)
	local text = CL.count:format(args.spellName, bladeSurgeCount)
	self:Message(args.spellId, "Important", "Info", text)
	self:StopBar(text)
	bladeSurgeCount = bladeSurgeCount + 1
	self:CDBar(args.spellId, 12.04, CL.count:format(args.spellName, bladeSurgeCount))
end

function mod:UNIT_SPELLCAST_SUCCEEDED(unit, spellName, _, _, spellId)
	if spellId == 224327 then -- Enveloping Winds
		self:Message(224333, "Attention", "Info", spellName)
		if EnvelopingWindsCount == 1 then
			self:CDBar(224333, 19.99) -- actual spellid has no icon/tooltip
		elseif EnvelopingWindsCount == 2 then
			self:CDBar(224333, 22.07)
		elseif slicingMaelstromCount > 2 then
			self:CDBar(224333, 24.05)
		end
		EnvelopingWindsCount = EnvelopingWindsCount + 1
	end
end

do
	local prev = 0
	function mod:PiercingGale(args)
		local t = GetTime()
		if t-prev > 2 then
			prev = t
			self:Message(args.spellId, "Urgent", "Alarm")
			self:CDBar(args.spellId, 24)
		end
	end
end

function mod:SlicingMaelstrom(args)
	local text = CL.count:format(args.spellName, slicingMaelstromCount)
	self:Message(args.spellId, "Attention", "Warning", text)
	self:StopBar(text)
	self:Bar(209628, 12.1) -- Piercing Gale
	slicingMaelstromCount = slicingMaelstromCount + 1
	self:CDBar(args.spellId, 24, CL.count:format(args.spellName, slicingMaelstromCount))
end

function mod:EnvelopingWinds(args)
	local _, class = UnitClass("player")
	if self:Dispeller("magic") or class == "WARLOCK" then
		self:TargetMessage(args.spellId, args.destName, "Important", "Bam", nil, nil, self:Dispeller("magic"))
	end
	if self:Me(args.destGUID) then
		self:Say(224333)
	end
end