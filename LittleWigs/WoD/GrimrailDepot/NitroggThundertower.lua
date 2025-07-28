
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Nitrogg Thundertower", 1208, 1163)
if not mod then return end
mod:RegisterEnableMob(
	79545, -- Nitrogg Thundertower
	79548, -- Assault Cannon
	77483, -- Grom'kar Gunner
	79720, -- Grom'kar Boomer
	79739  -- Grom'kar Grenadier
)
mod.engageId = 1732
mod.respawnTime = 30

--------------------------------------------------------------------------------
-- Locals
--

local waveCount = 0
local stage = 1

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.adds = -9713
	L.adds_desc = -9708
	L.adds_icon = "inv_misc_groupneedmore"

	L.dropped = "%s dropped!"
	L.add_trigger1 = "Let 'em have it, boys!"
	L.add_trigger2 = "Give 'em all ya got."

	L.waves = {}
	L.waves[1] = "1x Grom'kar Boomer, 1x Grom'kar Gunner"
	L.waves[2] = "1x Grom'kar Gunner, 1x Grom'kar Grenadier"
	L.waves[3] = "Iron Infantry"
	L.waves[4] = "2x Grom'kar Boomer"
	L.waves[5] = "Iron Infantry"
	L.waves[6] = "2x Grom'kar Gunner"
	L.waves[7] = "Iron Infantry"
	L.waves[8] = "1x Grom'kar Boomer, 1x Grom'kar Grenadier"
	L.waves[9] = "3x Grom'kar Boomer, 1x Grom'kar Gunner"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"stages",
		163550, -- Blackrock Mortar
		{160681, "SAY", "ICON", "FLASH"}, -- Suppressive Fire
		166570, -- Slag Blast
		"adds",
		160965, -- Blackrock Mortar Shells
		156357, -- Blackrock Shrapnel
		161073, -- Blackrock Grenade
	}, {
		[163550] = -10620, -- Nitrogg Thundertower
		[160681] = -10332, -- Assault Cannon
		["adds"] = -9713,  -- Reinforcements
	}
end

function mod:OnBossEnable()
	-- Stages
	self:Log("SPELL_CAST_SUCCESS", "EncounterEvent", 181089)

	-- Nitrogg Thundertower
	self:Log("SPELL_CAST_START", "BlackrockMortar", 163550)

	-- Assault Cannon
	self:Log("SPELL_CAST_SUCCESS", "SuppressiveFire", 160681) -- APPLIED fires for cannon and player, use SUCCESS which happens at the exact same time
	self:Log("SPELL_AURA_REMOVED", "SuppressiveFireRemoved", 160681)
	self:Log("SPELL_CAST_START", "Reloading", 160680)
	self:Log("SPELL_CAST_START", "SlagBlast", 166565)
	self:Log("SPELL_AURA_APPLIED", "SlagBlastApplied", 166570)
	self:Log("SPELL_AURA_APPLIED_DOSE", "SlagBlastApplied", 166570)

	-- Adds
	self:RegisterEvent("CHAT_MSG_MONSTER_YELL")

	self:Log("SPELL_AURA_APPLIED", "PickedUpBlackrockShrapnel", 156357)
	self:Death("GunnerDies", 77483) -- Grom'kar Gunner

	self:Log("SPELL_AURA_APPLIED", "PickedUpMortarShells", 160702)
	self:Death("BoomerDies", 79720) -- Grom'kar Boomer

	self:Log("SPELL_AURA_APPLIED", "PickedUpGrenades", 160703)
	self:Death("GrenadierDies", 79739) -- Grom'kar Grenadier
end

function mod:OnEngage()
	self:Message("stages", "Neutral", nil, CL.stage:format(1), false)
	stage = 1
	self:Bar(163550, 10.1) -- Blackrock Mortar
	waveCount = 0
end

--------------------------------------------------------------------------------
-- Event Handlers
--

-- Stages

function mod:EncounterEvent(args)
	-- this spell is cast twice during the encounter. the first time is when the boss jumps
	-- into the cannon at 60% health. the second time is when the boss exits the cannon as
	-- the cannon reaches 0% health.
	if stage == 1 then
		stage = 2
		self:Message("stages", "Neutral", "Long", CL.percent:format(60, CL.stage:format(2)), false)
		self:StopBar(163550) -- Blackrock Mortar
	else
		stage = 3
		self:Message("stages", "Neutral", "Long", CL.stage:format(3), false)
		self:StopBar(166570) -- Slag Blast
	end
end

-- Nitrogg Thundertower

function mod:BlackrockMortar(args)
	self:Message(args.spellId, "Attention", "Alert")
	self:Bar(args.spellId, 12.2)
end

-- Assault Cannon

function mod:SuppressiveFire(args)


	self:TargetBar(args.spellId, 10, args.destName)
	self:PrimaryIcon(args.spellId, args.destName)
end

function mod:SuppressiveFireRemoved(args)
	self:PrimaryIcon(args.spellId)
	self:StopBar(args.spellId, args.destName)
end

do
	local function printTarget(self, player, guid)
		self:TargetMessage(160681, player, "Important", "Alert")
		self:PrimaryIcon(160681, player)
		if self:Me(guid) then
			self:Flash(160681)
			self:Say(160681)
		end
	end
	function mod:Reloading(args)
		self:GetBossTarget(printTarget, 0.3, args.sourceGUID)
	end
end

function mod:SlagBlast(args)
	self:Message(166570, "Urgent", "alert")
	self:Bar(166570, 35.3)
end

function mod:SlagBlastApplied(args)
	if self:Me(args.destGUID) then
		self:Message(args.spellId, "Personal", "Alarm", CL.underyou:format(args.spellName))
	end
end

-- Adds

function mod:CHAT_MSG_MONSTER_YELL(_, msg)
	if msg == L.add_trigger1 or msg == L.add_trigger2 then
		local waveMessage
		if waveCount == 0 then
			waveMessage = L.waves[1] -- first entry in table
		else
			waveMessage = L.waves[((waveCount - 1) % 8) + 2] -- then loop all except the first entry
		end
		self:Message("adds", "Attention", "alert", waveMessage, L.adds_icon)
		waveCount = waveCount + 1
	end
end

function mod:GunnerDies()
	self:Message(156357, "Urgent", "info", L.dropped:format(self:SpellName(156357))) -- Blackrock Shrapnel
end

function mod:PickedUpBlackrockShrapnel(args)
	self:TargetMessage(156357, args.destName, "Positive")
end

function mod:BoomerDies()
	self:Message(160965, "Urgent", "Info", L.dropped:format(self:SpellName(160965))) -- Blackrock Mortar Shells
end

function mod:PickedUpMortarShells(args)
	self:TargetMessage(160965, args.destName, "Positive")
end

function mod:GrenadierDies()
	self:Message(161073, "Attention", nil, L.dropped:format(self:SpellName(161073))) -- Blackrock Grenade
end

function mod:PickedUpGrenades(args)
	self:TargetMessage(161073, args.destName, "Positive")
end
