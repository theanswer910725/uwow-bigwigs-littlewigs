--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Neltharions Lair Trash", 1458)
if not mod then return end
mod.displayName = CL.trash
mod:RegisterEnableMob(
	92473,
	113998, -- Mightstone Breaker
	90997, -- Mightstone Breaker
	92612, -- Mightstone Breaker
	113538, -- Mightstone Breaker
	92538, -- Tarspitter Grub
	102404, -- Stoneclaw Grubmaster	
	91002, -- Rotdrool Grabber
	91000, -- Vileshard Hulk
	102287, -- Emberhusk Dominator
	91006, -- Rockback Gnasher
	102232 -- Rockbound Trapper
)

--------------------------------------------------------------------------------
-- Locals
--

local WormCall = 0
local Bound = 0
--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.breaker = "Mightstone Breaker"
	L.hulk = "Vileshard Hulk"
	L.emberhusk = "Emberhusk Dominator"
	L.gnasher = "Rockback Gnasher"
	L.StoneclawGrubmaster = "Stoneclaw Grubmaster"
	L.trapper = "Rockbound Trapper"
	L.TarspitterGrub = "Tarspitter Grub"
	L.RotdroolGrabber = "Rotdrool Grabber"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		--[[ Mightstone Breaker ]]--
		183088, -- Avalanche
		
		--[[Emberhusk Dominator ]]--
		201983, -- Frenzy
		226406, -- Ember Swipe

		--[[ Vileshard Hulk ]]--
		226296, -- Piercing Shards
		193505,
		
		--Tarspitter Grub--
		193803, --Metamorphosis

		--Rotdrool Grabber--
		{183539, "SAY", "FLASH"}, --Barbed Tongue
		
		--Stoneclaw Grubmaster--
		183548, --Worm Call

		--[[ Rockback Gnasher ]]--
		{202181, "SAY"}, -- Stone Gaze

		--[[ Rockbound Trapper ]]--
		{193585, "SAY"}, -- Bound
		"stages",
	}, {
		[183088] = L.breaker,
		[201983] = L.emberhusk,
		[193803] = L.TarspitterGrub,
		[183539] = L.RotdroolGrabber,
		[183548] = L.StoneclawGrubmaster,		
		[226296] = L.hulk,
		[202181] = L.gnasher,
		[193585] = L.trapper,
	}
end

function mod:OnBossEnable()
	self:RegisterMessage("BigWigs_OnBossEngage", "Enable")
	self:Log("SPELL_CAST_START", "Avalanche", 183088)
	self:Log("SPELL_CAST_START", "Frenzy", 201983)
	self:Log("SPELL_CAST_START", "EmberSwipe", 226406)
	self:Log("SPELL_CAST_START", "WormCall", 183548)
	self:Log("SPELL_CAST_START", "BarbedTongue", 183539)
	self:Log("SPELL_CAST_START", "PiercingShards", 226296)
	self:Log("SPELL_CAST_START", "Fracture", 193505)
	self:Log("SPELL_CAST_START", "StoneGaze", 202181)
	self:Log("SPELL_CAST_START", "Bound", 193585)
	self:Log("SPELL_CAST_SUCCESS", "Metamorphosis", 193803)
	self:RegisterEvent("LEARNED_SPELL_IN_TAB")
	
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:LEARNED_SPELL_IN_TAB(_, _, _, _, spellGUID, spellId)
	if IsSpellKnown(216486) then
		self:Message("stages", "Positive", "Info", self:SpellName(219066), 183213)
		self:Bar("stages", 11.5, self:SpellName(219066), 183213)
		self:ScheduleTimer("BarrelRide", 11.5)
	end
end

function mod:BarrelRide()
	self:Message("stages", "Neutral", "Long", CL.over:format(self:SpellName(219066)), 183213)
end

function mod:Metamorphosis(args)
	self:Message(args.spellId, "Important", "Long", CL.casting:format(self:SpellName(193803)))
end

do
	local prev = 0
	local function printTarget(self, name, guid)
		local t = GetTime()
		if self:Me(guid) then
			prev = t
			self:TargetMessage(183539, name, "Personal", "Bam")
			self:Say(183539)
			self:Flash(183539)
		elseif t-prev > 0.5 then
			prev = t
			self:TargetMessage(183539, name, "Personal", "None")
		end
	end
	function mod:BarbedTongue(args)
		self:GetUnitTarget(printTarget, 0.3, args.sourceGUID)
	end
end

function mod:WormCall(args)
	self:Message(args.spellId, "Attention", "Info")
	if WormCall == 0 then
		self:CDBar(args.spellId, 10)
		WormCall = 1
	elseif WormCall == 1 then
		self:CastBar(args.spellId, 10)
		WormCall = 0
	end	
end

-- Mightstone Breaker
function mod:Avalanche(args)
	self:Message(args.spellId, "Attention", "Long")
end

-- Vileshard Hulk
do
	local prev = 0
	function mod:PiercingShards(args)
		local t = GetTime()
		if t-prev > 13 then
			prev = t
			self:Message(args.spellId, "Urgent", "Warning", CL.casting:format(args.spellName))
			self:CDBar(args.spellId, 15.5)
			self:CDBar(193505, 13.2)
			self:CastBar(193505, 29.7)
			self:CastBar(226296, 31)
		else
			self:Message(args.spellId, "Urgent", "Warning", CL.casting:format(args.spellName))
		end
	end
end

do
	local prev = 0
	function mod:Fracture(args)
		local t = GetTime()
		if t-prev > 13 then
			prev = t
			self:Message(args.spellId, "Important", "Long", CL.casting:format(args.spellName))
			self:CDBar(226296, 1.3)
			self:CDBar(193505, 15.5)
			self:CastBar(226296, 29.7)
			self:CastBar(193505, 31)
		else
			self:Message(args.spellId, "Important", "Long", CL.casting:format(args.spellName))
		end
	end
end

-- Emberhusk Dominator
function mod:Frenzy(args)
	self:Message(args.spellId, "Urgent", "Bam", CL.casting:format(args.spellName))
	self:CDBar(args.spellId, 19.5)
	self:CastBar(201983, 39)
end

-- Emberhusk Dominator
function mod:EmberSwipe(args)
	self:CDBar(args.spellId, 9)
	self:CastBar(226406, 18)
end

-- Rockback Gnasher

do
	local prev = 0
	local function printTarget(self, name, guid)
		local t = GetTime()
		if self:Me(guid) then
			prev = t
			self:TargetMessage(202181, name, "Personal", "Bam")
			self:Say(202181)
		elseif t-prev > 0.5 then
			prev = t
			self:TargetMessage(202181, name, "Personal", "Alarm")
		end
	end
	function mod:StoneGaze(args)
		self:GetUnitTarget(printTarget, 0.3, args.sourceGUID)
		self:CDBar(202181, 20.5)
	end
end

-- Rockbound Trapper

do
	local function printTarget(self, name, guid)
		if self:Me(guid) and Bound == 0 then
			self:TargetMessage(193585, name, "Personal", "Warning")
			self:CDBar(193585, 21.5)
			self:Say(193585)
			Bound = 1
		elseif self:Me(guid) and Bound == 1 then
			self:TargetMessage(193585, name, "Personal", "Warning")
			self:CastBar(193585, 21.5)
			self:Say(193585)
			Bound = 0
		elseif Bound == 0 then
			self:TargetMessage(193585, name, "Personal", "Alarm")
			self:CDBar(193585, 21.5)
			Bound = 1
		elseif Bound == 1 then
			self:TargetMessage(193585, name, "Personal", "Alarm")
			self:CastBar(193585, 21.5)
			Bound = 0
		end
	end
	function mod:Bound(args)
		self:GetUnitTarget(printTarget, 0.3, args.sourceGUID)
	end
end
