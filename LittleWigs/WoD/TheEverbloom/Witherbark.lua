--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Witherbark", 1279, 1214)
if not mod then return end
mod:RegisterEnableMob(81522) -- Witherbark
mod.engageId = 1746
mod.respawnTime = 20

--------------------------------------------------------------------------------
-- Localization
--
local EnergizePercent
local stage = 1

local L = mod:GetLocale()
if L then
	L.energyStatus = "A Globule reached Witherbark: %d%% energy"
end

--------------------------------------------------------------------------------
-- Initialization
--


function mod:GetOptions()
	return {
		"stages",
		164275, -- Brittle Bark
		164438, -- Energize
		164357, -- Parched Gasp
		{164294, "ME_ONLY"}, -- Unchecked Growth
		-10098, -- Unchecked Growth (Add Spawned)
	}, nil, {
		[-10098] = CL.add_spawned,
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "BrittleBark", 164275)
	self:Log("SPELL_AURA_REMOVED", "BrittleBarkOver", 164275)
	self:Log("SPELL_ENERGIZE", "Energize", 164438)
	self:Log("SPELL_CAST_START", "ParchedGasp", 164357)
	self:Log("SPELL_AURA_APPLIED", "UncheckedGrowthApplied", 164302)
	self:Log("SPELL_PERIODIC_DAMAGE", "UncheckedGrowthDamage", 164294)
	self:Log("SPELL_PERIODIC_MISSED", "UncheckedGrowthDamage", 164294)
	self:Log("SPELL_CAST_SUCCESS", "UncheckedGrowthSummon", 164556)
	self:RegisterUnitEvent("UNIT_POWER_FREQUENT", nil, "boss1")
end

function mod:OnEngage()
	EnergizePercent = 0
	stage = 1
	--self:SetStage(1)
	self:Message("stages", "Positive", "Info", CL.stage:format(1), false)
	self:CDBar(164294, 5.8) -- Unchecked Growth
	self:CDBar(164357, 9.7) -- Parched Gasp
	-- cast at 0 energy, 39s energy loss + delay
	self:CDBar(164275, 39.2) -- Brittle Bark
end

--------------------------------------------------------------------------------
-- Event Handlers
--

do
	local prev = 0
	function mod:UNIT_POWER_FREQUENT(_, unit)
		local power = UnitPower(unit)
		local t = GetTime()
		if stage == 2 and t - prev > 0.1 then
			prev = t
			EnergizePercent = EnergizePercent + 25
			self:Message(164438, "Neutral", "Info", CL.percent:format(EnergizePercent, self:SpellName(164438)))
		end
	end
end

do
	local energy = 0

	function mod:BrittleBark(args)
		self:Message("stages", "Positive", nil, CL.stage:format(2), false)
		EnergizePercent = 0
		stage = 2
		energy = 0
		self:Message(args.spellId, "Neutral", "Long", CL.other:format(args.spellName, CL.incoming:format(self:SpellName(-10100)))) -- 10100 = Aqueous Globules
		self:PlaySound(args.spellId, "long")
		self:StopBar(args.spellId)
		self:StopBar(164357) -- Parched Gasp
		if self:Normal() then
			self:StopBar(164294) -- Unchecked Growth
		end
	end

	function mod:BrittleBarkOver(args)
		self:Message("stages", "Positive", nil, CL.stage:format(1), false)
		EnergizePercent = 0
		stage = 1
		self:Message(args.spellId, "Neutral", "Long", CL.over:format(args.spellName))
		--self:PlaySound(args.spellId, "long")
		-- cast at 0 energy, 39s energy loss + delay
		self:Bar(args.spellId, 39.3)
		self:CDBar(164357, 3.6) -- Parched Gasp
	end

	function mod:Energize(args)
		if self:IsEngaged() then -- This happens when killing the trash, we only want it during the encounter.
			energy = energy + args.extraSpellId -- args.extraSpellId is the energy gained from SPELL_ENERGIZE
			if energy < 100 then
				self:Message(args.spellId, "cyan", CL.percent:format(energy))
				self:PlaySound(args.spellId, "info")
			end
		end
	end
end

function mod:ParchedGasp(args)
	self:Message(args.spellId, "Personal")
	self:PlaySound(args.spellId, "alarm")
	self:CDBar(args.spellId, 17.0)
end

function mod:UncheckedGrowthApplied(args)
	self:TargetMessage(164294, args.destName, "yellow")
	self:PlaySound(164294, "alert", nil, args.destName)
	self:CDBar(164294, 12.1)
end

do
	local prev = 0
	function mod:UncheckedGrowthDamage(args)
		if self:Me(args.destGUID) then
			local t = GetTime()
			if t - prev > 1.5 then
				prev = t
				self:Message(args.spellId, "Personal", nil, CL.underyou:format(args.spellName))
			end
		end
	end
end

function mod:UncheckedGrowthSummon()
	self:Message(-10098, "orange", nil, CL.add_spawned, false)
	self:PlaySound(-10098, "info")
end
