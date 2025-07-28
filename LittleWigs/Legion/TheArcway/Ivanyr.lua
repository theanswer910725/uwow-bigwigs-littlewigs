
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Ivanyr", 1516, 1497)
if not mod then return end
mod:RegisterEnableMob(98203)
mod.engageId = 1827

local NetherLinkCount = 1
local NetherLinkIconCount = 0
--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.interrupted = "%s interrupted %s (%.1fs left)!"
end
--------------------------------------------------------------------------------
-- Initialization
--
local NetherLinkMarker = mod:AddMarkerOption(true, "player", 1, 196805, 1, 2, 3, 4, 5, 6) --Nether Link
function mod:GetOptions()
	return {
		{196805, "SAY"}, -- Nether Link
		NetherLinkMarker,
		{196562, "PROXIMITY", "SAY"}, -- Volatile Magic
		196392, -- Overcharge Mana
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_AURA_APPLIED", "NetherLink", 196805)
	self:Log("SPELL_AURA_REMOVED", "NetherLinkRemoved", 196805)
	self:Log("SPELL_AURA_APPLIED", "VolatileMagicApplied", 196562)
	self:Log("SPELL_AURA_REMOVED", "VolatileMagicRemoved", 196562)
	self:Log("SPELL_CAST_SUCCESS", "OverchargeMana", 196392)
	--self:Log("SPELL_INTERRUPT", "Interrupt", "*")
end

function mod:OnEngage()
	NetherLinkCount = 1
	NetherLinkIconCount = 0
	self:CDBar(196562, 10) -- Volatile Magic
	self:CDBar(196805, 18) -- Nether Link
	self:CDBar(196392, 31.5) -- Overcharge Mana
end

--------------------------------------------------------------------------------
-- Event Handlers
--

do
	local list = mod:NewTargetList()
	function mod:NetherLink(args)
		list[#list+1] = args.destName
		if #list == 1 then
			self:ScheduleTimer("TargetMessage", 0.1, args.spellId, list, "Attention", "Info")
			self:CDBar(args.spellId, 33)
		end
		if self:GetOption(NetherLinkMarker) then
			local icon = (NetherLinkIconCount % 6) + 1
			SetRaidTarget(args.destName, icon)
			NetherLinkIconCount = NetherLinkIconCount + 1
		end
		if self:Me(args.destGUID) then
			local _, _, duration = self:UnitDebuff("player", args.spellId)
			self:SayCountdown(args.spellId, duration, 4, 3)
		end
	end
	function mod:NetherLinkRemoved(args)
		if self:GetOption(NetherLinkMarker) then
			SetRaidTarget(args.destName, 0)
		end
	end
end

do
	local targets, isOnMe = {}
	local function printTarget(self, spellId)
		if isOnMe then
			self:OpenProximity(spellId, 8)
		else
			self:OpenProximity(spellId, 8, targets)
		end
		self:TargetMessage(spellId, self:ColorName(targets), "Urgent", "Alarm", nil, nil, true)
		wipe(targets)
		isOnMe = nil
	end

	function mod:VolatileMagicApplied(args)
		targets[#targets+1] = args.destName
		if #targets == 1 then
			self:ScheduleTimer(printTarget, 0.1, self, args.spellId)
			self:Bar(args.spellId, 4, ("<%s>"):format(args.spellName))
			self:CDBar(args.spellId, 35)
		end
		if self:Me(args.destGUID) then
			local _, _, duration = self:UnitDebuff("player", args.spellId)
			self:SayCountdown(args.spellId, duration, 2, 3)
			self:TargetBar(args.spellId, 5, args.destName)
			isOnMe = true
		end
	end

	function mod:VolatileMagicRemoved(args)
		self:CloseProximity(args.spellId)
		if self:Me(args.destGUID) then
			self:CancelSayCountdown(args.spellId)
		end
	end
end

do
	local prev = 0
	function mod:Interrupt(args)
		if args.extraSpellId == 196392 then
			self:CDBar(196392, 38)
			self:CastBar(196392, 78)
		end
	end
end

function mod:OverchargeMana(args)
	self:Message(args.spellId, "Important", "Long", CL.casting:format(args.spellName))
	self:CDBar(196392, 40)
end
