--------------------------------------------------------------------------------
-- Module Declaration
--

--TO DO List
--Tested everything except post phase 2 timers and soulgorge stacks warnings
--All timers were correct on hc and normal runs
--Test if Soul Echoes say works
local mod, CL = BigWigs:NewBoss("Amalgam of Souls", 1501, 1518)
if not mod then return end
mod:RegisterEnableMob(98542)

--------------------------------------------------------------------------------
-- Locals
--

local gorgeCount = 0
local addsKilled = 0

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"stages",
		196078, -- Call Souls
		194956, -- Reap Soul
		{196587, "FLASH"}, -- Soul Burst
		{194966, "SAY"}, -- Soul Echoes
		{195254, "ICON", "SAY"}, -- Swirling scythe
		196930, -- Soulgorge
		}, {
		[194956] = -12241, -- Stage One: The Amalgam of Souls
		[196078] = -12245, -- Stage Two: The Call of Souls
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "CallSouls", 196078)
	self:Log("SPELL_CAST_SUCCESS", "SoulEchoes", 194966) --27.5
	self:Log("SPELL_CAST_START", "SoulBurstStart", 196587)
	self:Log("SPELL_CAST_SUCCESS", "SoulBurstSuccess", 196587)
	self:Log("SPELL_CAST_START", "ReapSoul", 194956) -- 14.6
	self:Log("SPELL_CAST_SUCCESS", "SwirlingScytheSuccess", 195254)	-- 20 SEC CD
	self:Log("SPELL_CAST_START", "SwirlingScythe", 195254)
	self:Log("SPELL_CAST_START", "Echoes", 194966)
	self:Log("SPELL_AURA_REMOVED", "SoulEchoesRemoved", 194966)
	self:Log("SPELL_AURA_APPLIED", "SoulEchoesApplied", 194966)
	self:Log("SPELL_AURA_APPLIED", "Soulgorge", 196930)
	self:Log("SPELL_AURA_APPLIED_DOSE", "Soulgorge", 196930)
	self:RegisterEvent("INSTANCE_ENCOUNTER_ENGAGE_UNIT", "CheckBossStatus")
	self:Death("SoulDeath", 99664)
	self:Death("AmalgamDead", 98542)
end

function mod:OnEngage()
	gorgeCount = 0
	addsKilled = 0
	self:Bar(195254, 8.5) -- Swirling scythe
	self:Bar(194966, 15.7) -- Soul Echoes
	self:Bar(194956, 20.4) -- Reap Soul
	local BlackRookHoldTrashMod = BigWigs:GetBossModule("Black Rook Hold Trash", true)
	if BlackRookHoldTrashMod then
		BlackRookHoldTrashMod:Enable()
	end
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Soulgorge(args)
	gorgeCount = args.amount or 1
	self:Message(args.spellId, "Attention", "Alert", CL.count:format(args.spellName, gorgeCount))
end

function mod:SoulBurstStart(args)
	self:Message(args.spellId, "Important", "Bam", CL.incoming:format(args.spellName))
	self:Flash(196587)
end

function mod:SoulBurstSuccess(args)
	self:CDBar(195254, 4.5) -- Swirling scythe
	self:CDBar(194966, 12.6) -- Soul Echoes
	self:CDBar(194956, 17.4) -- Reap Soul
	gorgeCount = 0
end

function mod:CallSouls(args)
	gorgeCount = 0
	self:Message(args.spellId, "Positive", "Long", CL.percent:format(50, args.spellName))
	self:CDBar(196587, 27.5) -- Soul Burst
	self:StopBar(195254) -- Swirling scythe
	self:StopBar(194966) -- Soul Echoes
	self:StopBar(194956) -- Reap Soul
end

function mod:ReapSoul(args)
	self:Bar(args.spellId, 13.4)
	if self:Tank() then
		self:Message(args.spellId, "Attention", "Warning", CL.incoming:format(args.spellName))
	end
end

do
	local prev = 0
	local function printTarget(self, name, guid)
		self:PrimaryIcon(195254, name)
		local t = GetTime()
		if self:Me(guid) and self:Melee() then
			prev = t
			self:TargetMessage(195254, name, "Personal", "Bam")
			self:Say(195254)
		elseif self:Me(guid) and t-prev > 1.5 then
			prev = t
			self:TargetMessage(195254, name, "Personal", "Bam")
		elseif t-prev > 1.5 then
			prev = t
			self:TargetMessage(195254, name, "Personal", "None")
		end
	end
	function mod:SwirlingScythe(args)
		self:Bar(195254, 21.7)
		self:GetUnitTarget(printTarget, 0.3, args.sourceGUID)
	end
end

function mod:SwirlingScytheSuccess(args)
	self:PrimaryIcon(195254, nil)
	self:Bar(args.spellId, 21.2)
end

function mod:SoulEchoes(args)
	self:Bar(args.spellId, 26.7)
end

function mod:SoulEchoesApplied(args)
	if self:Me(args.destGUID) then
		local _, _, duration = self:UnitDebuff("player", args.spellId)
		self:SayCountdown(args.spellId, duration, 7, 3)
	end
end

function mod:SoulEchoesRemoved(args)
	if GetRaidTargetIndex(args.destName) == 7 then
		SetRaidTarget(args.destName, 0)
	end
end

do
	local function printTarget(self, name, guid)
		self:SecondaryIcon(195254, name)
		if self:Me(guid) then
			self:TargetMessage(194966, name, "Personal", "Bike Horn")
			self:Say(194966)
		else
			self:TargetMessage(194966, name, "Personal", "None")
		end
	end
	function mod:Echoes(args)
		self:GetUnitTarget(printTarget, 0.3, args.sourceGUID)
	end
end

function mod:SoulDeath(args)
	addsKilled = addsKilled + 1
	self:Message("stages", "Neutral", addsKilled == 7 and "Long", CL.mob_killed:format(args.destName, addsKilled, 7), false)
end

function mod:AmalgamDead(args)
	self:Win()
end
