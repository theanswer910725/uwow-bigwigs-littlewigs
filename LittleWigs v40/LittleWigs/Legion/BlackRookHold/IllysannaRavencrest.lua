--------------------------------------------------------------------------------
-- Module Declaration
--

--TO do List Eye beam is completely missing in transcriptor logs in any means ??
--Dark Rush and Eye beam Say's should be Tested
--Arcane blitz warning message could be changed into "Interrupt (sourceGuid)"
local mod, CL = BigWigs:NewBoss("Illysanna Ravencrest", 1501, 1653)
if not mod then return end
mod:RegisterEnableMob(98696)

local DarkRushIconCount = 0
local EyeBeamCount = 0
local BeamCount = 0
local VengefulShearCount = 0
local DarkRushCount = 0
local BrutalGlaiveCount = 0
local EyeBeam = {}
--------------------------------------------------------------------------------
-- Initialization
--
local DarkRushMarker = mod:AddMarkerOption(true, "player", 1, 197478, 1, 2, 3, 4, 5, 6)
function mod:GetOptions()
	return {
		DarkRushMarker,
		"stages",
		{197418, "TANK"}, -- Vengeful Shear
		{197478, "SAY"}, -- Dark Rush
		{197546, "SAY", "ICON"}, -- Brutal Glaive
		{197674, "FLASH", "SAY", "ICON"}, -- Eye Beam
		197797, -- Arcane Blitz
		197974, -- Bonecrushing Strike
	}, {
		[197797] = CL.adds,
		[197418] = -12277, -- Stage One: Vengeance
		[197674] = -12281, -- Stage Two: Fury
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "BrutalGlaive", 197546)
	self:Log("SPELL_CAST_SUCCESS", "BrutalGlaiveSuccess", 197546)
	self:Log("SPELL_CAST_START", "VengefulShear", 197418)
	self:Log("SPELL_CAST_START", "ArcaneBlitz", 197797)
	self:Log("SPELL_CAST_START", "BonecrushingStrike", 197974)
	self:Log("SPELL_AURA_APPLIED", "DarkRushApplied", 197478)
	self:Log("SPELL_AURA_REMOVED", "DarkRushRemoved", 197478)
	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")
	self:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED")
	self:RegisterEvent("RAID_BOSS_WHISPER")
	self:Death("Win", 98696)
	
	self:RegisterEvent("UNIT_AURA")
end

function mod:OnEngage()
	self:Bar(197546, 6.4) -- Brutal Glaive
	self:Bar(197418, 9.2) -- Vengeful Shear
	self:CDBar(197478, 12.6) -- Dark Rush
	self:CDBar("stages", 37, -12281, 131347)
	DarkRushIconCount = 0
	EyeBeamCount = 1
	BeamCount = 0
	VengefulShearCount = 0
	DarkRushCount = 0
	BrutalGlaiveCount = 0
	self:ScheduleTimer("StopTimer", 1)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

do
	function mod:UNIT_AURA(_, unit)
		local name = self:UnitDebuff(unit, 197687)
		local n = self:UnitName(unit)
		if EyeBeam[n] and not name then
			EyeBeam[n] = nil
		elseif name and not EyeBeam[n] then
			guid = UnitGUID(n)
			if not self:Me(guid) then
				self:TargetMessage(197674, n, "Positive", "Long", 197674)
			end
			self:PrimaryIcon(197674, n)
			self:ScheduleTimer("BeamTimer", 13)
			EyeBeam[n] = true
		end
	end
end

function mod:BeamTimer()
	self:PrimaryIcon(197674, nil)
end

function mod:StopTimer()
	BrutalGlaiveTimeLeft = self:BarTimeLeft(197546)
	VengefulShearTimeLeft = self:BarTimeLeft(197418)
	DarkRushTimeLeft = self:BarTimeLeft(197478)
	EyeBeamTimeLeft = self:BarTimeLeft(-12281)
	if BrutalGlaiveTimeLeft > EyeBeamTimeLeft - 6 then
		self:StopBar(197546)
	elseif VengefulShearTimeLeft > EyeBeamTimeLeft - 6 then
		self:StopBar(197418)
	elseif DarkRushTimeLeft > EyeBeamTimeLeft - 6 then
		self:StopBar(197478)
	end
	self:ScheduleTimer("StopTimer", 1)
end


do
	local prev = 0
	local function printTarget(self, name, guid)
		local t = GetTime()
		self:PrimaryIcon(197546, name)
		if self:Me(guid) and self:Melee() then
			prev = t
			self:TargetMessage(197546, name, "Personal", "Bam")
			self:Say(197546)
		elseif self:Me(guid) and t-prev > 1.5 then
			prev = t
			self:TargetMessage(197546, name, "Personal", "Bam")
		elseif t-prev > 1.5 then
			prev = t
			self:TargetMessage(197546, name, "Personal", "None")
		end
	end
	function mod:BrutalGlaive(args)
		self:CDBar(args.spellId, 15.8)
		self:CDBar(197418, 2.82)
		if BeamCount == 1 and BrutalGlaiveCount == 1 then
			self:CDBar(args.spellId, 16.82)
			self:CDBar(197418, 3.44)
		elseif BeamCount == 1 and BrutalGlaiveCount == 2 then
			self:CDBar(args.spellId, 13.48)
			self:CDBar(197418, 2.83)
		elseif BeamCount == 1 and BrutalGlaiveCount == 3 then
			self:CDBar(args.spellId, 18.03)
			self:CDBar(197418, 2.81)
		elseif BeamCount == 1 and BrutalGlaiveCount == 4 then
			self:CDBar(args.spellId, 13.44)
			self:CDBar(197418, 2.87)
		elseif BeamCount == 1 and BrutalGlaiveCount == 5 then
			self:CDBar(args.spellId, 18.05)
			self:CDBar(197418, 2.80)
		elseif BeamCount == 1 and BrutalGlaiveCount == 6 then
			self:CDBar(197418, 2.83)
		end
		self:GetUnitTarget(printTarget, 0.3, args.sourceGUID)
	end
	function mod:BrutalGlaiveSuccess(args)
		BrutalGlaiveCount = BrutalGlaiveCount + 1
		self:PrimaryIcon(197546, nil)
	end
end

do
	local list = mod:NewTargetList()
	function mod:DarkRushApplied(args)
		list[#list+1] = args.destName
		if #list == 1 then
			self:ScheduleTimer("TargetMessage", 0.1, args.spellId, list, "Attention", "Info")
		end
		if BeamCount == 1 then
			self:CDBar(args.spellId, 31.53)
		end
		if self:GetOption(DarkRushMarker) then
			local icon = (DarkRushIconCount % 6) + 1
			SetRaidTarget(args.destName, icon)
			DarkRushIconCount = DarkRushIconCount + 1
		end
		if self:Me(args.destGUID) then
			self:SayCountdown(args.spellId, 6, 4, 3)
			self:Say(args.spellId)
		end
	end
	function mod:DarkRushRemoved(args)
		if self:GetOption(DarkRushMarker) then
			SetRaidTarget(args.destName, 0)
		end
	end
end

function mod:VengefulShear(args)
	self:CDBar(args.spellId, 15.8)
	self:Message(args.spellId, "Important", "Warning")
	if BeamCount == 1 and VengefulShearCount == 1 then
		self:CDBar(args.spellId, 16.13)
	elseif BeamCount == 1 and VengefulShearCount == 2 then
		self:CDBar(args.spellId, 13.46)
	elseif BeamCount == 1 and VengefulShearCount == 3 then
		self:CDBar(args.spellId, 18.09)
	elseif BeamCount == 1 and VengefulShearCount == 4 then
		self:CDBar(args.spellId, 13.51)
	elseif BeamCount == 1 and VengefulShearCount == 5 then
		self:CDBar(args.spellId, 18.01)
	end
	VengefulShearCount = VengefulShearCount + 1
end

function mod:RAID_BOSS_WHISPER(_, msg, sender)
	if msg:find("197674", nil, true) then
		self:Message(197674, "Attention", "Bike Horn", msg, false)
		self:Flash(197674)
		self:Say(197674)
		self:SayCountdown(197674, 12, 8, 3)
	end
end

do
	local prev = 0
	local preva = 0
	function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, _, _, spellGUID, spellId)
		local t = GetTime()
		if spellId == 197674 and EyeBeamCount < 4 and t-prev > 11 then
			prev = t
			self:StopBar(197546) -- Brutal Glaive
			self:StopBar(197418) -- Vengeful Shear
			self:CDBar(197674, 13, CL.count:format(self:SpellName(197674), EyeBeamCount))
			EyeBeamCount = EyeBeamCount + 1
		elseif spellId == 197674 and EyeBeamCount > 3 and t-prev > 11 then
			prev = t
			EyeBeamCount = 1
			BeamCount = 1
			VengefulShearCount = 1
			DarkRushCount = 1
			BrutalGlaiveCount = 1
			self:Message("stages", "Neutral", "Long", -12277, 210055)
			self:CDBar("stages", 106, -12281, 131347)
			self:Bar(197546, 6.92) -- Brutal Glaive
			self:Bar(197418, 10.38) -- Vengeful Shear
			self:CDBar(197478, 14) -- Dark Rush
		elseif spellId == 197622 and t-preva > 1  then
			preva = t
			self:StopBar(197546) -- Brutal Glaive
			self:StopBar(197418) -- Vengeful Shear
			self:Bar(197674, 2)
			self:Message("stages", "Neutral", "Long", -12281, 131347)
			self:CDBar("stages", 45.0, -12277, 210055)
		end
	end
end

function mod:ArcaneBlitz(args)
	self:TargetMessage(args.spellId, args.sourceName, "Attention", "Alarm")
end

function mod:BonecrushingStrike(args)
	self:Message(args.spellId, "Important", "Alarm", CL.incoming:format(args.spellName))
end
