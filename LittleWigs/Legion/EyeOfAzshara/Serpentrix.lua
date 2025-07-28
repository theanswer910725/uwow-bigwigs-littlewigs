
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Serpentrix", 1456, 1479)
if not mod then return end
mod:RegisterEnableMob(91808, 97260)
mod.engageId = 1813

--------------------------------------------------------------------------------
-- Locals
--

local submergeHp = 66

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		191797,  -- Winds
		191873, -- Submerge
		{191855, "SAY", "ICON"}, -- Toxic Wound
		{192005, "SAY"}, -- Arcane Blast
		192007, -- Arcane Blast
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("CHAT_MSG_RAID_BOSS_EMOTE")
	
	self:Log("SPELL_AURA_APPLIED", "Winds", 191797)
	self:Log("SPELL_AURA_APPLIED", "ToxicWound", 191855)
	self:Log("SPELL_AURA_REMOVED", "ToxicWoundOver", 191855)
	self:Log("SPELL_CAST_START", "ArcaneBlast", 192005)
	self:Log("SPELL_AURA_APPLIED", "ArcaneBlastApplied", 192007)
	self:Log("SPELL_AURA_APPLIED_DOSE", "ArcaneBlastApplied", 192007)
end

function mod:OnEngage()
	self:CDBar(191855, 5) -- Toxic Wound
	submergeHp = 66
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Winds(args)
	if self:Me(args.destGUID) then
		self:Message(191797, "Attention", "Alarm")
		self:CDBar(191797, 90)
	end
end

function mod:ArcaneBlastApplied(args)
	self:StackMessage(args.spellId, args.destName, args.amount, "red")
	self:PlaySound(args.spellId, "alert", args.destName)
end

do
	local prev = 0
	local function printTarget(self, name, guid)
		local t = GetTime()
		if self:Me(guid) then
			prev = t
			self:TargetMessage(192005, name, "Personal", "Bam")
			self:Say(192005)
		elseif t-prev > 0.5 then
			prev = t
			self:TargetMessage(192005, name, "Personal", "None")
		end
	end
	function mod:ArcaneBlast(args)
		self:GetUnitTarget(printTarget, 0.3, args.sourceGUID)
	end
end

function mod:CHAT_MSG_RAID_BOSS_EMOTE(_, msg)
	if msg:find("191873", nil, true) then
		self:Message(191873, "Attention", "Long", CL.percent:format(submergeHp, self:SpellName(191873)))
		submergeHp = submergeHp - 33
	end
end

function mod:ToxicWound(args)
	local _, _, duration = self:UnitDebuff("player", args.spellId)
	self:TargetMessage(args.spellId, args.destName, "Important", "Alarm")
	--self:CDBar(args.spellId, 25) -- pull:27.8, 25.5, 29.2 -- pull:5.9, 25.1, 41.0
	self:PrimaryIcon(args.spellId, args.destName)
	if self:Me(args.destGUID) then
		self:Say(args.spellId)
		self:SayCountdown(args.spellId, duration, 8, 3)
	end
end

function mod:ToxicWoundOver(args)
	self:PrimaryIcon(args.spellId)
	if self:Me(args.destGUID) then
		self:CancelSayCountdown(args.spellId)
	end
end

