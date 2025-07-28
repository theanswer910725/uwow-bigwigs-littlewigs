
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Rokmora", 1458, 1662)
if not mod then return end
mod:RegisterEnableMob(91003, 97720, 96247, 98406, 91006, 91001, 91000, 105636)
mod.engageId = 1790

--------------------------------------------------------------------------------
-- Locals
--

local ShatterCount = 0
local SkitterMarks = { [8] = true, [7] = true, [6] = true, [5] = true }
local SkitterMarked = {}

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.warmup_text = "Rokmora Active"
	L.warmup_trigger = "Navarrogg?! Betrayer! You would lead these intruders against us?!"
	L.warmup_trigger_2 = "Either way, I will enjoy every moment of it. Rokmora, crush them!"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"warmup",
		188169, -- Razor Shards
		188114, -- Shatter
		192800, -- Choking Dust
		{187793, "FLASH"}, -- Brittle
		SkitterMarker,
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("CHAT_MSG_MONSTER_YELL", "Warmup")
	self:Log("SPELL_CAST_START", "RazorShards", 188169)
	self:Log("SPELL_CAST_START", "Shatter", 188114)

	self:Log("SPELL_AURA_APPLIED", "ChokingDustDamage", 192800)
	self:Log("SPELL_PERIODIC_DAMAGE", "ChokingDustDamage", 192800)
	self:Log("SPELL_PERIODIC_MISSED", "ChokingDustDamage", 192800)
	self:Log("SPELL_SUMMON", "Brittle", 187793)
	self:Death("SkitterDeath", 97720)
	self:RegisterTargetEvents("SkitterMark")
	wipe(SkitterMarked)
end

function mod:OnEngage()
	SkitterMarked = {}
	SkitterMarks = { [8] = true, [7] = true, [6] = true, [5] = true }
	ShatterCount = 1
	self:CDBar(188169, 28) -- Razor Shards
	self:CDBar(188114, 23) -- Shatter
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:SkitterMark(event, unit, guid)
	if self:MobId(guid) == 97720 and not SkitterMarked[guid] then
		local icon = next(SkitterMarks)
		if icon then
			SetRaidTarget(unit, icon)
			SkitterMarks[icon] = nil
			SkitterMarked[guid] = icon
		end
	end
end

function mod:SkitterDeath(args)
	if SkitterMarked[args.destGUID] then
		SkitterMarks[SkitterMarked[args.destGUID]] = true
	end
end

function mod:Warmup(event, msg)
	if msg == L.warmup_trigger then
		self:Bar("warmup", 21, L.warmup_text, "achievement_dungeon_neltharionslair")
	elseif msg == L.warmup_trigger_2 then
		self:Bar("warmup", 7, L.warmup_text, "achievement_dungeon_neltharionslair")
	end
end

function mod:RazorShards(args)
	self:Message(args.spellId, "Urgent", "Warning", CL.incoming:format(args.spellName))
	self:CDBar(args.spellId, 29) -- pull:25.6, 29.1, 29.9
end

function mod:Brittle(args)
	if self:BarTimeLeft(188114) > 5 or self:BarTimeLeft(CL.count:format(self:SpellName(188114), ShatterCount)) > 5 then
		self:CDBar(187793, 5)
	end
	self:Message(187793, "Attention", "Info", CL.spawned:format(self:SpellName(215929)))
end

function mod:Shatter(args)
	BrittleTimeLeft = self:BarTimeLeft(187793)
	self:Message(args.spellId, "Attention", "Alert", CL.count:format(args.spellName, ShatterCount))
	ShatterCount = ShatterCount + 1
	self:CDBar(args.spellId, 24, CL.count:format(args.spellName, ShatterCount))
	self:CastBar(188114, 4.3)
	if BrittleTimeLeft > 0.9 and BrittleTimeLeft < 3.3 then
		self:Message(187793, "Urgent", "Punch", CL.custom_sec:format(CL.spawned:format(self:SpellName(215929)), BrittleTimeLeft))
	elseif BrittleTimeLeft > 3.2 and BrittleTimeLeft < 4.4 then
		self:Message(187793, "Important", "Bam", CL.custom_sec:format(CL.spawned:format(self:SpellName(215929)), BrittleTimeLeft))
		self:Flash(187793)
	end
end

do
	local prev = 0
	function mod:ChokingDustDamage(args)
		if self:Me(args.destGUID) then
			local t = GetTime()
			if t-prev > 2 then
				prev = t
				self:Message(args.spellId, "Personal", "Alarm", CL.underyou:format(args.spellName))
			end
		end
	end
end

