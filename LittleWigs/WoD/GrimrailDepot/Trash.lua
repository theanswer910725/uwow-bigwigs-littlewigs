--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Grimrail Depot Trash", 1208)
if not mod then return end
mod.displayName = CL.trash
mod:RegisterEnableMob(
	81407,  -- Grimrail Bombardier
	81236,  -- Grimrail Technician
	81212,  -- Grimrail Overseer
	80937,  -- Grom'kar Gunner
	88163,  -- Grom'kar Cinderseer
	80935,  -- Grom'kar Boomer
	80938,  -- Grom'kar Hulk
	82579,  -- Grom'kar Far Seer
	82597,  -- Grom'kar Captain
	82590   -- Grimrail Scout
)

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.grimrail_bombardier = "Grimrail Bombardier"
	L.grimrail_technician = "Grimrail Technician"
	L.grimrail_overseer = "Grimrail Overseer"
	L.gromkar_gunner = "Grom'kar Gunner"
	L.gromkar_cinderseer = "Grom'kar Cinderseer"
	L.gromkar_boomer = "Grom'kar Boomer"
	L.gromkar_hulk = "Grom'kar Hulk"
	L.gromkar_far_seer = "Grom'kar Far Seer"
	L.gromkar_captain = "Grom'kar Captain"
	L.grimrail_scout = "Grimrail Scout"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-- Grimrail Bombardier
		164218, -- Double Slash
		-- Grimrail Technician
		163966, -- Activating
		164192, -- 50,000 Volts
		-- Grimrail Overseer
		164168, -- Dash
		164163, -- Hewing Swipe
		-- Grom'kar Gunner
		166675, -- Shrapnel Blast
		-- Grom'kar Cinderseer
		176032, -- Flametongue
		176025, -- Lava Wreath
		-- Grom'kar Boomer
		156301, -- Blackrock Mortar
		176127, -- Cannon Barrage
		-- Grom'kar Hulk
		176023, -- Getting Angry
		-- Grom'kar Far Seer
		166335, -- Storm Shield
		166341, -- Thunder Zone
		166387, -- Healing Rain
		-- Grom'kar Captain
		166380, -- Reckless Slash
		-- Grimrail Scout
		166397, -- Arcane Blitz
	}, {
		[164218] = L.grimrail_bombardier,
		[163966] = L.grimrail_technician,
		[164168] = L.grimrail_overseer,
		[166675] = L.gromkar_gunner,
		[176032] = L.gromkar_cinderseer,
		[156301] = L.gromkar_boomer,
		[176023] = L.gromkar_hulk,
		[166335] = L.gromkar_far_seer,
		[166380] = L.gromkar_captain,
		[166397] = L.grimrail_scout,
	}
end

function mod:OnBossEnable()
	-- Grimrail Bombardier
	self:Log("SPELL_CAST_START", "DoubleSlash", 164218)
	-- Grimrail Technician
	self:Log("SPELL_AURA_APPLIED", "Activating", 163966)
	self:Log("SPELL_CAST_START", "FiftyThousandVolts", 164192)
	-- Grimrail Overseer
	self:Log("SPELL_CAST_START", "Dash", 164168)
	self:Log("SPELL_CAST_START", "HewingSwipe", 164163)
	-- Grom'kar Gunner
	self:Log("SPELL_CAST_START", "ShrapnelBlast", 166675)
	self:Log("SPELL_DAMAGE", "ShrapnelBlastDamage", 166676)
	self:Log("SPELL_MISSED", "ShrapnelBlastDamage", 166676)
	-- Grom'kar Cinderseer
	self:Log("SPELL_CAST_START", "Flametongue", 176032)
	self:Log("SPELL_CAST_START", "LavaWreath", 176025)
	self:Log("SPELL_AURA_APPLIED", "FlametongueDamage", 176033)
	self:Log("SPELL_PERIODIC_DAMAGE", "FlametongueDamage", 176033)
	self:Log("SPELL_MISSED", "FlametongueDamage", 176033)
	-- Grom'kar Boomer
	self:Log("SPELL_CAST_START", "BlackrockMortar", 156301)
	self:Log("SPELL_CAST_START", "CannonBarrage", 176127)
	-- Grom'kar Hulk
	self:Log("SPELL_AURA_APPLIED_DOSE", "GettingAngryApplied", 176023)
	-- Grom'kar Far Seer
	self:Log("SPELL_CAST_START", "StormShield", 166335)
	self:Log("SPELL_AURA_APPLIED", "StormShieldApplied", 166335)
	self:Log("SPELL_CAST_START", "ThunderZone", 166341)
	self:Log("SPELL_CAST_START", "HealingRain", 166387)
	self:Log("SPELL_AURA_APPLIED", "ThunderZoneDamage", 166340)
	self:Log("SPELL_MISSED", "ThunderZoneDamage", 166340)
	-- Grom'kar Captain
	self:Log("SPELL_CAST_START", "RecklessSlash", 166380)
	-- Grimrail Scout
	self:Log("SPELL_CAST_SUCCESS", "ArcaneBlitz", 166397)
	--
end

--------------------------------------------------------------------------------
-- Event Handlers
--
-- Grimrail Bombardier

do
	local prev = 0
	function mod:DoubleSlash(args)
		local t = GetTime()
		if t - prev > 4.5 then
			prev = t
			self:CDBar(args.spellId, 6)
		end
		self:Message(args.spellId, "Attention", "Warning")
	end
end

-- Grimrail Technician

function mod:Activating(args)
	self:Message(args.spellId, "Important", "Alarm")
end


function mod:FiftyThousandVolts(args)
	self:Message(args.spellId, "Attention", "warning")
	if self:BarTimeLeft(CL.count:format(self:SpellName(164192), 1)) < 1 then
		self:Bar(164192, 16, CL.count:format(self:SpellName(164192), 1))
	elseif self:BarTimeLeft(CL.count:format(self:SpellName(164192), 2)) < 1 then
		self:Bar(164192, 16, CL.count:format(self:SpellName(164192), 2))
	elseif self:BarTimeLeft(CL.count:format(self:SpellName(164192), 3)) < 1 then
		self:Bar(164192, 16, CL.count:format(self:SpellName(164192), 3))
	elseif self:BarTimeLeft(CL.count:format(self:SpellName(164192), 4)) < 1 then
		self:Bar(164192, 16, CL.count:format(self:SpellName(164192), 4))
	elseif self:BarTimeLeft(CL.count:format(self:SpellName(164192), 5)) < 1 then
		self:Bar(164192, 16, CL.count:format(self:SpellName(164192), 5))
	end
end

-- Grimrail Overseer

do
	local prev = 0
	function mod:Dash(args)
		local t = GetTime()
		if t - prev > 1.5 then
			prev = t
			self:Message(args.spellId, "Personal", "Alert")
		end
	end
end

do
	local prev = 0
	function mod:HewingSwipe(args)
		local t = GetTime()
		if t - prev > 9 then
			prev = t
			self:CDBar(args.spellId, 11)
		end
		self:Message(args.spellId, "Attention", "Warning")
	end
end

-- Grom'kar Gunner

do
	local prev = 0
	local preva = 0
	function mod:ShrapnelBlast(args)
		local t = GetTime()
		local ta = GetTime()
		if t - prev > 1.5 then
			prev = t
			self:Message(args.spellId, "Important", "Alert")
		end
		if ta - preva > 13.5 then
			prev = t
			self:CDBar(args.spellId, 14.6)
		end
	end
end

do
	local prev = 0
	function mod:ShrapnelBlastDamage(args)
		if self:Me(args.destGUID) then
			local t = GetTime()
			if t - prev > 1.5 then
				prev = t
				self:Message(166675, "Personal", "Alarm", CL.underyou:format(self:SpellName(166675)))
			end
		end
	end
end

-- Grom'kar Cinderseer

do
	local prev = 0
	function mod:Flametongue(args)
		local t = GetTime()
		if t - prev > 10 then
			prev = t
			self:CDBar(args.spellId, 11.5)
		end
		self:Message(args.spellId, "Urgent", "Alarm")
	end
end

do
	local prev = 0
	function mod:LavaWreath(args)
		local t = GetTime()
		if t - prev > 15 then
			prev = t
			self:CDBar(args.spellId, 17)
		end
		self:Message(args.spellId, "Attention", "Alert")
	end
end

do
	local prev = 0
	function mod:FlametongueDamage(args)
		if self:Me(args.destGUID) then
			local t = GetTime()
			if t - prev > 1.5 then
				prev = t
				self:Message(176032, "Personal", "Alarm", CL.underyou:format(self:SpellName(176032)))
			end
		end
	end
end

-- Grom'kar Boomer

do
	local prev = 0
	function mod:BlackrockMortar(args)
		if self:MobId(args.sourceGUID) == 80935 then -- Grom'kar Boomer trash version, Nitrogg has adds that cast this spell
			local t = GetTime()
			if t - prev > 22 then
				prev = t
				self:CDBar(args.spellId, 24)
			end
			self:Message(args.spellId, "Attention", "Alert")
		end
	end
end

do
	local prev = 0
	function mod:CannonBarrage(args)
		local t = GetTime()
		if t - prev > 22 then
			prev = t
			self:CDBar(args.spellId, 24)
		end
		self:Message(args.spellId, "Urgent", "Alarm")
	end
end

-- Grom'kar Hulk

function mod:GettingAngryApplied(args)
	-- 3% damage increase per stack, stacks on every successful melee hit (1.5s swings)
	local amount = args.amount
	if amount >= 6 and amount % 3 == 0 then
		self:StackMessage(args.spellId, args.destName, amount, "Important", nil)
		if amount >= 12 then
			self:PlaySound(args.spellId, "Warning")
		else
			self:PlaySound(args.spellId, "Alert")
		end
	end
end

-- Grom'kar Far Seer

function mod:StormShield(args)
	if self:Interrupter() then
		self:Message(args.spellId, "Important", "Warning", CL.casting:format(args.spellName))
	end
end

function mod:StormShieldApplied(args)
	local _, class = UnitClass("player")
	if (self:Dispeller("magic", true) or class == "WARLOCK")then
		self:Message(args.spellId, "Attention", "Warning", CL.other:format(args.destName, args.spellName))
	end
end

function mod:ThunderZone(args)
	self:Message(args.spellId, "Attention", "Alert")
end

do
	local prev = 0
	function mod:HealingRain(args)
		local t = GetTime()
		if t - prev > 16 then
			prev = t
			self:CDBar(args.spellId, 18)
		end
		self:Message(args.spellId, "Urgent", "Alarm", CL.casting:format(args.spellName))
	end
end

do
	local prev = 0
	function mod:ThunderZoneDamage(args)
		if self:Me(args.destGUID) then
			local t = GetTime()
			if t - prev > 1.5 then
				prev = t
				self:Message(166341, "Personal", "Alarm", CL.underyou:format(self:SpellName(166341)))
			end
		end
	end
end

-- Grom'kar Captain

do
	local prev = 0
	function mod:RecklessSlash(args)
		local t = GetTime()
		if t - prev > 12.5 then
			prev = t
			self:CDBar(args.spellId, 14)
		end
		self:Message(args.spellId, "Urgent", "Alarm")
	end
end

-- Grimrail Scout

do
	local prev = 0
	function mod:ArcaneBlitz(args)
		local t = GetTime()
		if t - prev > 13.5 then
			prev = t
			self:CDBar(args.spellId, 15.5)
		end
		self:Message(args.spellId, "Attention", "Long")
	end
end
