
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Harbaron", 1492, 1512)
if not mod then return end
mod:RegisterEnableMob(96754)
mod.engageId = 1823

local CosmicScytheCounter = 1
local SummonShackledServitorCounter = 1
local NetherRipCounter = 1
local FragmentCounter = 1

local timersMythic = {
	--[[ Cosmic Scythe ]]--
	[194216] = {3.28, 8.63, 15.84, 12.09, 8.52, 8.52, 15.86, 9.62, 8.54, 18.27, 8.53, 10.86, 8.51, 11.06, 8.31, 8.54, 8.52, 17.14, 9.58, 8.51, 18.27},
	--[[ Nether Rip ]]
	[194668] = {14.27, 15.92, 15.69, 19.38, 15.74, 16.08, 15.70, 18.06, 15.76, 15.69, 20.94, 15.72, 16.08, 15.76, 17.93, 15.71, 15.73, 20.90},
	--[[ Fragment ]]
	[194325] = {19.15, 40.00, 41.25, 38.95, 37.72, 41.25},
	--[[ Summon Shackled Servitor ]]
	[194231] = {6.96, 27.90, 32.89, 27.90, 27.88, 27.92, 34.18, 27.88, 27.91, 27.97, 34.17, 27.88, 27.87, 27.92},
}

local timers = timersMythic
--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		194216, -- Cosmic Scythe
		194231, -- Summon Shackled Servitor
		194668, -- Nether Rip
		{194325, "SAY", "ICON"}, -- Fragment
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "SummonShackledServitor", 194231)
	self:Log("SPELL_CAST_START", "NetherRip", 194668)
	self:Log("SPELL_CAST_START", "Fragment", 194325)
	self:Log("SPELL_CAST_START", "CosmicScythe", 194216)

	self:Log("SPELL_PERIODIC_DAMAGE", "NetherRipDamage", 194235)
	self:Log("SPELL_PERIODIC_MISSED", "NetherRipDamage", 194235)
	self:RegisterUnitEvent("UNIT_SPELLCAST_STOP", nil, "boss1")
end

function mod:OnEngage()
	timers = timersMythic
	CosmicScytheCounter = 1
	SummonShackledServitorCounter = 1
	NetherRipCounter = 1
	FragmentCounter = 1
	self:Bar(194216, 3.6) -- Cosmic Scythe
	self:CDBar(194231, 8) -- Summon Shackled Servitor
	self:CDBar(194325, 18) -- Fragment
	if not self:Normal() then
		self:CDBar(194668, 12.5) -- Nether Rip
		self:Bar(194216, timers[194216][CosmicScytheCounter]) -- Cosmic Scythe
		self:Bar(194231, timers[194231][SummonShackledServitorCounter])
		self:Bar(194668, timers[194668][NetherRipCounter])
		self:Bar(194325, timers[194325][FragmentCounter])
	end
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:UNIT_SPELLCAST_STOP(_, _, _, spellId, spellName)
	if spellName == 194325 then
		self:SecondaryIcon(194325, nil)
		self:CancelSayCountdown(194325)
	end
end

do
	local prev = 0
	local function printTarget(self, name, guid)
		self:SecondaryIcon(194325, name)
		local t = GetTime()
		if self:Me(guid) then
			prev = t
			self:TargetMessage(194325, name, "Personal", "Bam")
			self:Say(194325)
			self:SayCountdown(194325, 3, 7, 2)
		elseif t-prev > 1.5 then
			prev = t
			self:TargetMessage(194325, name, "Personal", "None")
		end
	end
	function mod:Fragment(args)
		self:GetUnitTarget(printTarget, 0.4, args.sourceGUID)
		self:CDBar(args.spellId, 40)
		FragmentCounter = FragmentCounter + 1
		if not self:Normal() then
		self:Bar(args.spellId, timers[args.spellId][FragmentCounter])
		end
		if FragmentCounter == 6 then
			FragmentCounter = 3
		end
		if CosmicScytheCounter == 6 then
			self:CDBar(194216, 13.56) -- Cosmic Scythe
			self:CDBar(194231, 8.46) -- Summon Shackled Servitor
			self:CDBar(194668, 5.0) -- Nether Rip
			CosmicScytheCounter = 7
		end
	end
end

function mod:NetherRip(args)
	self:CDBar(args.spellId, 15)
	NetherRipCounter = NetherRipCounter + 1
	if not self:Normal() then
	self:Bar(args.spellId, timers[args.spellId][NetherRipCounter])
	end
	if NetherRipCounter == 18 then
		NetherRipCounter = 11
	end
end

function mod:SummonShackledServitor(args)
	self:CDBar(args.spellId, 28) -- cd varies between 23-26
	self:Message(args.spellId, "Attention", "Info", CL.incoming:format(args.spellName))
	SummonShackledServitorCounter = SummonShackledServitorCounter + 1
	if not self:Normal() then
	self:Bar(args.spellId, timers[args.spellId][SummonShackledServitorCounter])
	end
	if SummonShackledServitorCounter == 12 then
		SummonShackledServitorCounter = 7
	end
end

function mod:CosmicScythe(args)
	self:Message(args.spellId, "Urgent", "Sonar")
	CosmicScytheCounter = CosmicScytheCounter + 1
	if not self:Normal() then
	self:Bar(args.spellId, timers[args.spellId][CosmicScytheCounter])
	end
	if CosmicScytheCounter == 20 then
		CosmicScytheCounter = 9
	end
end

do
	local prev = 0
	function mod:NetherRipDamage(args)
		if self:Me(args.destGUID) then
			local t = GetTime()
			if t-prev > 2 then
				prev = t
				self:Message(194668, "Personal", "Alarm", CL.underyou:format(args.spellName))
			end
		end
	end
end
