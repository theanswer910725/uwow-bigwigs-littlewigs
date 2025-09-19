
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Oakheart", 1466, 1655)
if not mod then return end
mod:RegisterEnableMob(103344)
mod.engageId = 1837
--------------------------------------------------------------------------------
-- Locals
--

local GripCount = 0

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		{204646, "SAY", "ICON", "FLASH"}, -- Crushing Grip
		204574, -- Strangling Roots
		204667, -- Nightmare Breath
		204666, -- Shattered Earth
		204611, -- Crushing Grip
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "CrushingGripStart", 204611)
	self:Log("SPELL_CAST_START", "CrushingGrip", 204646)
	self:Log("SPELL_CAST_SUCCESS", "CrushingGripEnd", 204646)
	self:Log("SPELL_CAST_START", "StranglingRoots", 204574)
	self:Log("SPELL_CAST_START", "NightmareBreath", 204667)
	self:Log("SPELL_CAST_START", "ShatteredEarth", 204666)
end

function mod:OnEngage()
	GripCount = 0
	self:CDBar(204646, 29) -- Crushing Grip
	self:CDBar(204574, 14.2) -- Strangling Roots
	self:CDBar(204667, 20) -- Nightmare Breath
	self:CDBar(204666, 6.4) -- Shattered Earth
end

--------------------------------------------------------------------------------
-- Event Handlers
--

do
	local function printTarget(self, name, guid)
		self:TargetMessage(204646, name, "Urgent", "Alert", nil, nil, true)
		self:PrimaryIcon(204646, name)
		self:ScheduleTimer("DeleteMark", 5)
		if self:Me(guid) then
			self:Say(204646)
			self:SayCountdown(204646, 5, 8, 3)
			self:Flash(204646)
		end
	end
	function mod:CrushingGrip(args)
		self:GetUnitTarget(printTarget, 0.1, args.sourceGUID)
	end
	function mod:CrushingGripEnd(args)
		self:PrimaryIcon(204646, name)
	end
	function mod:DeleteMark()
		self:PrimaryIcon(204646, nil)
	end
end

function mod:CrushingGripStart(args)
	self:CDBar(args.spellId, 31) -- hc pull:28.0, 27.9, 34.0 / m pull:30.1, 32.8, 34.0
	if GripCount == 0 then
		self:CDBar(204574, 6.7)
		self:CDBar(204666, 12.72) -- Shattered Earth
		self:CDBar(204667, 17.52) -- Nightmare Breath
		self:CDBar(args.spellId, 29.7)
		GripCount = GripCount + 1
	elseif GripCount == 1 then
		self:CDBar(204574, 6.7)
		self:CDBar(204666, 24.86) -- Shattered Earth
		self:CDBar(204667, 12.70) -- Nightmare Breath
		self:CDBar(args.spellId, 30)
		GripCount = GripCount + 1
	elseif GripCount == 2 then
		self:CDBar(204574, 6.7)
		self:CDBar(204666, 29.17) -- Shattered Earth
		self:CDBar(204667, 13.36) -- Nightmare Breath
		self:CDBar(args.spellId, 33.5)
		GripCount = GripCount + 1
	elseif GripCount == 3 then
		self:CDBar(204574, 6.7)
		self:CDBar(204666, 29.17) -- Shattered Earth
		self:CDBar(204667, 12.7) -- Nightmare Breath
		self:CDBar(args.spellId, 33.5)
	end
end

function mod:StranglingRoots(args)
	self:Message(args.spellId, "Attention")
end

function mod:NightmareBreath(args)
	self:Message(args.spellId, "Important", "Info")
	if GripCount == 2 then
		self:CDBar(204666, 8.5)
	end
	self:CDBar(args.spellId, 27) -- hc pull:18.6, 26.7, 32.8 / m pull:19.5, 32.8, 26.7, 33.5
end

function mod:ShatteredEarth(args)
	self:Message(args.spellId, "Important", "Alarm")
	CrushingGripTimeLeft = self:BarTimeLeft(204646)
	if GripCount == 0 then
		self:CDBar(args.spellId, 38.7) -- m pull: 7.3, 50.9, 51.1
	elseif GripCount == 1 then
		self:CDBar(204667, 4.8) -- Nightmare Breath
		self:CDBar(args.spellId, 38) -- m pull: 7.3, 50.9, 51.1
	elseif GripCount == 3 or (GripCount == 2 and CrushingGripTimeLeft < 5) then
		self:CDBar(204646, 4.5) -- Crushing Grip
		self:CDBar(args.spellId, 38) -- m pull: 7.3, 50.9, 51.1
	else
		self:CDBar(args.spellId, 38) -- m pull: 7.3, 50.9, 51.1
	end
end
