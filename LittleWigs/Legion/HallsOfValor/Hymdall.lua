
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Hymdall", 1477, 1485)
if not mod then return end
mod:RegisterEnableMob(94960)
mod.engageId = 1805

--------------------------------------------------------------------------------
-- Locals
--

local bladeCount = 1
local HornCount = 1
local StormBreathCount = 0

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		{193235, "ICON", "SAY"}, -- Dancing Blade
		191284, -- Horn of Valor
		193092, -- Bloodletting Sweep
		188404, -- Storm Breath
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_SUCCESS", "DancingBladeSuccess", 193235)
	self:Log("SPELL_CAST_START", "DancingBlade", 193235)
	self:Log("SPELL_CAST_START", "HornOfValor", 191284)
	
	self:Log("SPELL_CAST_SUCCESS", "StormBreathSucess", 188404)

	self:Log("SPELL_PERIODIC_DAMAGE", "DancingBladeDamage", 193234)
	self:Log("SPELL_PERIODIC_MISSED", "DancingBladeDamage", 193234)

	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss1")
end

function mod:OnEngage()
	bladeCount = 1
	HornCount = 1
	StormBreathCount = 0
	self:CDBar(193235, 5.8) -- Dancing Blade
	self:CDBar(191284, 11.6) -- Horn of Valor
	self:CDBar(193092, 16.5) -- Bloodletting Sweep
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:StormBreathSucess(args)
	StormBreathCount = StormBreathCount + 1
	self:Message(args.spellId, "green", "Sonar", CL.count:format(args.spellName, StormBreathCount))
	if StormBreathCount == 3 then
		StormBreathCount = 0
	end
end

do	
	local prev = 0
	local function printTarget(self, name, guid)
		local t = GetTime()
		self:PrimaryIcon(193235, name)
		if self:Me(guid) then
			prev = t
			self:Say(193235)
			self:TargetMessage(193235, name, "Personal", "Bam")
		elseif t-prev > 2 then
			prev = t
			self:TargetMessage(193235, name, "Urgent", "Alert")
		end
	end

	function mod:DancingBlade(args)
		self:CDBar(args.spellId, bladeCount % 2 == 0 and 12.4 or 32.9) -- pull:5.2, 31.5, 10.9, 31.6, 10.9, 32.4, 10.1
		bladeCount = bladeCount + 1
		self:GetBossTarget(printTarget, 0.4, args.sourceGUID)
	end
		
	function mod:DancingBladeSuccess(args)
		self:PrimaryIcon(193235, nil)
	end
end

function mod:HornOfValor(args)
	self:Message(args.spellId, "Important", "Long", CL.casting:format(args.spellName))
		if HornCount == 1 then
			self:CDBar(args.spellId, 44.6)
			HornCount = 2
		elseif HornCount == 2 then
			self:CDBar(args.spellId, 46)
			HornCount = 3
		elseif HornCount == 3 then
			self:CDBar(args.spellId, 45.4)
	end
end

do
	local prev = 0
	function mod:DancingBladeDamage(args)
		if self:Me(args.destGUID) then
			local t = GetTime()
			if t-prev > 2 then
				prev = t
				self:Message(193235, "Personal", "Alarm", CL.you:format(args.spellName))
			end
		end
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, _, _, spellId)
	if spellId == 193092 then -- Bloodletting Sweep
		self:Message(spellId, "Attention", self:Tank() and "Info")
		self:CDBar(spellId, 15.5) -- 18.2 - 23
	end
end

