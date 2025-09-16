
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Wrath of Azshara", 1456, 1492)
if not mod then return end
mod:RegisterEnableMob(96028)
mod.engageId = 1814

--------------------------------------------------------------------------------
-- Locals
--

local p2 = false

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		{192706, "SAY", "ICON"}, -- Arcane Bomb
		192617, -- Massive Deluge
		192675, -- Mystic Tornado
		192985, -- Cry of Wrath
		{197365, "SAY", "ICON"}, -- Crushing Depths
	}, {
		[197365] = "heroic",
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("CHAT_MSG_RAID_BOSS_EMOTE")

	self:Log("SPELL_CAST_START", "MassiveDeluge", 192617)
	self:Log("SPELL_CAST_SUCCESS", "CryOfWrath", 192985)
	self:Log("SPELL_CAST_START", "CrushingDepths", 197365) -- Heroic+
	self:Log("SPELL_CAST_SUCCESS", "CrushingDepthsEnd", 197365)
	self:Log("SPELL_AURA_APPLIED", "ArcaneBomb", 192706)
	self:Log("SPELL_AURA_REMOVED", "ArcaneBombRemoved", 192706)

	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss1")
	self:RegisterUnitEvent("UNIT_SPELLCAST_STOP", nil, "boss1")
end

function mod:OnEngage()
	p2 = false
	self:CDBar(192706, self:Normal() and 23 or 26) -- Arcane Bomb
	self:CDBar(192617, 12) -- Massive Deluge
	self:CDBar(197365, 20) -- Crushing Depths
	self:CDBar(192675, 8) -- Mystic Tornado
end

--------------------------------------------------------------------------------
-- Event Handlers
--

do
	local prev = 0
	local function printTarget(self, name, guid)
		local t = GetTime()
		if t-prev > 1.5 then
			prev = t
			self:TargetMessage(192706, name, "Attention", "Alarm")
		end
	end
	function mod:ArcaneBomb(args)
		self:PrimaryIcon(192706, args.destName)
		if self:Me(args.destGUID) then
			prev = t
			self:Say(args.spellId)
			self:TargetMessage(args.spellId, args.destName, "Personal", "Bam")
			local _, _, duration = self:UnitDebuff("player", args.spellId)
			self:SayCountdown(args.spellId, duration, 8, 5)
			self:TargetBar(args.spellId, duration, args.destName)
		end
	end
	function mod:ArcaneBombRemoved(args)
		self:PrimaryIcon(192706, nil)
		if self:Me(args.destGUID) then
			self:Message(args.spellId, "Positive", "Info", CL.removed:format(args.spellName))
			self:CancelSayCountdown(args.spellId)
			self:StopBar(args.spellId, args.destName)
		end
	end
end

function mod:CHAT_MSG_RAID_BOSS_EMOTE(_, msg, _, _, _, unit) -- Arcane Bomb
	if msg:find("192708", nil, true) then -- Fires with _START, target scanning doesn't work.
		self:TargetMessage(192706, unit, "Important", "Alarm")
		self:CDBar(192706, p2 and 23 or 30) -- pull:23.1, 30.4, 23.1 / hc pull:39.7 / hc pull:26.7, 31.2, 23.1 / m pull:26.4, 30.4, 30.4, 36.5 XXX
	end
end

function mod:MassiveDeluge(args)
	self:Message(args.spellId, "Attention", self:Tank() and "Warning")
	self:CDBar(args.spellId, self:Normal() and 51 or 56) -- pull:12.1, 51.0 / hc pull:12.1, 55.9 / m pull:12.2, 59.1, 35.3 XXX
end

function mod:CryOfWrath(args)
	p2 = true
	self:Message(args.spellId, "Positive", "Long", CL.percent:format(10, args.spellName))
end

do
	local function printTarget(self, player, guid)
		if self:Me(guid) then
			self:Say(197365)
			self:SayCountdown(197365, 6, 6, 4)
		end
		self:SecondaryIcon(197365, player)
		self:TargetMessage(197365, player, "Important", "Alarm", nil, nil, true)
	end
	function mod:CrushingDepths(args) -- Heroic+
		self:GetBossTarget(printTarget, 0.4, args.sourceGUID)
		self:CDBar(args.spellId, 41) -- pull:20.8, 41.3 / m pull:20.3, 59.5, 36.5 XXX
	end
	function mod:CrushingDepthsEnd(args)
		self:SecondaryIcon(197365, nil)
	end
end

function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, _, _, spellId)
	if spellId == 192680 then -- Mystic Tornado
		self:Message(192675, "Urgent", "Alert", CL.near:format(self:SpellName(192675)))
		self:CDBar(192675, p2 and 15 or 25) -- hc pull:8.5, 26.3, 15.8 / m pull:8.6, 25.1, 34.0, 18.2, 15.8, 20.7, 15.8
	end
end

function mod:UNIT_SPELLCAST_STOP(_, _, _, spellId, spellName)
	if spellName == 197365 then
		self:SecondaryIcon(197365, nil)
		self:CancelSayCountdown(197365)
	end
end