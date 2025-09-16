
--------------------------------------------------------------------------------
-- TODO List:
-- -- Optimize timers (especially after a Void Tear Stun)
-- -- Improve Umbra Shift warnings: alt power tracking, updated way to detect who has been send in (blizzard plz)

--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Zuraal", 1753, 1979)
if not mod then return end
mod:RegisterEnableMob(122313) -- Zuraal the Ascended
mod.engageId = 2065

--------------------------------------------------------------------------------
-- Initialization
--

local addsKilled = 0
local prevEnergy = 0

function mod:GetOptions()
	return {
		"stages",
		246134, -- Null Palm
		244579, -- Decimate
		244602, -- Coalesced Void
		244433, -- Umbra Shift
		{244653, "ICON", "SAY"}, -- Fixate
		244621, -- Void Tear
		"altpower",
		{244061, "INFOBOX"}, --Void Realm
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "NullPalm", 246134)
	self:Log("SPELL_CAST_START", "Decimate", 244579)
	self:Log("SPELL_CAST_SUCCESS", "CoalescedVoid", 246139)
	self:Log("SPELL_DAMAGE", "UmbraShift", 244433) -- No debuff or targetted events
	self:Log("SPELL_MISSED", "UmbraShift", 244433) -- No debuff or targetted events
	self:Log("SPELL_AURA_APPLIED", "Fixate", 244653)
	self:Log("SPELL_AURA_REMOVED", "FixateRemoved", 244653)
	self:Log("SPELL_AURA_APPLIED", "VoidTear", 244621)
	self:Log("SPELL_AURA_REMOVED", "VoidTearRemoved", 244621)
	self:Death("ImageDeath", 122716)
end

function mod:OnEngage()
	self:CDBar(246134, 10.5) -- Null Palm _start
	self:CDBar(244579, 18) -- Decimate _start
	self:CDBar(244602, 20) -- Coalesced Void _success
	self:CDBar(244433, 41) -- Umbra Shift _success
	addsKilled = 0
	prevEnergy = 0
	self:RegisterEvent("UNIT_POWER")
end

function mod:OnWin()
	local trashMod = BigWigs:GetBossModule("Seat of the Triumvirate Trash", true)
	if trashMod then
		trashMod:Enable() -- Making sure to pickup the Alleria yell to start the RP bar
	end
end

--------------------------------------------------------------------------------
-- Event Handlers
--
do
	function mod:UNIT_POWER(unit, pType)
		local group = UnitInRaid("player") and "raid" or UnitInParty("player") and "party"
		local members = GetNumGroupMembers()
		for i = 1, members, 1 do
			local unit = group..tostring(i)
			if UnitName(unit) and UnitClass(unit) then
				local power = UnitPower(unit, 10)
				if power == 100 and power > prevEnergy then
					self:Message(244061, "Important", "Bam", CL.other:format(self:ColorName(UnitName(unit)), CL.percent:format(power, self:SpellName(244061))))
					if UnitName(unit) == UnitName("player") then
						SendChatMessage("[LittleWigs] {rt3} Energy = 100% {rt3}" ,"PARTY" ,nil ,nil)
					end
					prevEnergy = power
				elseif power > 0 and power > prevEnergy then
					self:Message(244061, "Positive", "Info", CL.other:format(self:ColorName(UnitName(unit)), CL.percent:format(power, self:SpellName(244061))))
					prevEnergy = power
				end
			end
		end
		if UnitInParty("player") then
			local power = UnitPower("player", 10)
			if power == 100 and power > prevEnergy then
				self:Message(244061, "Important", "Bam", CL.other:format(self:ColorName(UnitName("player")), CL.percent:format(power, self:SpellName(244061))))
				SendChatMessage("[LittleWigs] {rt3} Energy = 100% {rt3}" ,"PARTY" ,nil ,nil)
				prevEnergy = power
            elseif power > 0 and power > prevEnergy then
				self:Message(244061, "Positive", "Info", CL.other:format(self:ColorName(UnitName("player")), CL.percent:format(power, self:SpellName(244061))))
				prevEnergy = power
			end
		end
	end
end

function mod:ImageDeath(args)
	addsKilled = addsKilled + 1
	self:Message("stages", "Neutral", addsKilled == 7 and "Long", CL.mob_killed:format(args.destName, addsKilled, 7), false)
end

function mod:NullPalm(args)
	self:Message(args.spellId, "Important", "Alarm")
	self:CDBar(args.spellId, 55)
end

function mod:Decimate(args)
	self:Message(args.spellId, "Urgent", "Warning")
	self:CDBar(args.spellId, 12.5)
end

function mod:CoalescedVoid(args)
	self:Message(244602, "Attention", "Alert")
	self:CDBar(244602, 55)
end

function mod:UmbraShift(args)
	self:TargetMessage(args.spellId, args.destName, "Personal", "Warning")
	self:CDBar(args.spellId, 55)
	if not self:Me(args.destGUID) then
		self:OpenAltPower("altpower", 244061)
	end
end

function mod:Fixate(args)
	self:PrimaryIcon(244653, args.destName)
	if self:Me(args.destGUID) then
		self:Say(args.spellId)
		self:SayCountdown(244653, 10, 8, 3)
		self:TargetMessage(244653, args.destName, "Personal", "Bike Horn")
	else
		self:TargetMessage(args.spellId, args.destName, "Personal", "Warning")
	end
end

function mod:FixateRemoved(args)
	self:PrimaryIcon(244653, nil)
	if self:Me(args.destGUID) then
		self:CancelSayCountdown(args.spellId)
	end
end

function mod:VoidTear(args)
	prevEnergy = 0
	self:CloseAltPower("altpower", 244061)
	self:StopBar(246134) -- Null Palm
	self:StopBar(244579) -- Decimate
	self:StopBar(244602) -- Coalesced Void
	self:StopBar(244433) -- Umbra Shift

	self:Message(args.spellId, "Positive", "Long", args.spellName)
	self:Bar(args.spellId, 20)
end

function mod:VoidTearRemoved(args)
	prevEnergy = 0
	self:Message(args.spellId, "Neutral", "Info", CL.removed:format(args.spellName))
	self:CDBar(246134, 10.5) -- Null Palm _start
	self:CDBar(244579, 18) -- Decimate _start
	self:CDBar(244602, 20) -- Coalesced Void _success
	self:CDBar(244433, 41) -- Umbra Shift _success
	addsKilled = 0
end

function mod:BOSS_KILL(_, id)
	if id == 122313 then
		local trashMod = BigWigs:GetBossModule("Seat of the Triumvirate Trash", true)
		trashMod:Enable()
		if trashMod then
			trashMod:Enable() -- Making sure to pickup the Alleria yell to start the RP bar
		end
	end
end
