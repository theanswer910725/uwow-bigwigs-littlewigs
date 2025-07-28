
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Vault of the Wardens Trash", 1493)
if not mod then return end
mod.displayName = CL.trash
mod:RegisterEnableMob(
	98177, -- Glayvianna Soulrender
	96587, -- Felsworn Infester
	98954, -- Felsworn Myrmidon
	99956, -- Fel-Infused Fury
	98533, -- Foul Mother
	96657, -- Blade Dancer Illianna
	99649, -- Dreadlord Mendacius
	102566 -- Grimhorn the Enslaver
)

--------------------------------------------------------------------------------
-- Locals
--

local tormentOnMe = false

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.soulrender = "Glayvianna Soulrender"
	L.infester = "Felsworn Infester"
	L.myrmidon = "Felsworn Myrmidon"
	L.fury = "Fel-Infused Fury"
	L.mother = "Foul Mother"
	L.illianna = "Blade Dancer Illianna"
	L.mendacius = "Dreadlord Mendacius"
	L.grimhorn = "Grimhorn the Enslaver"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		--[[ Glayvianna Soulrender ]]--
		193565, -- Glaive
		191767, -- Swoop
		
		--[[ Felsworn Infester ]]--
		{193069, "SAY"}, -- Nightmares

		--[[ Felsworn Myrmidon ]]--
		191735, -- Deafening Screech

		--[[ Fel-Infused Fury ]]--
		{196799, "FLASH"}, -- Unleash Fury
		196796, -- Fel Gaze

		--[[ Foul Mother ]]--
		210202, -- Foul Stench
		194071, -- A Mother's Love
		{194064, "SAY", "FLASH"}, -- A Mother's Love
		194074,
		194037,

		--[[ Blade Dancer Illianna ]]--
		191527, -- Deafening Shout
		193164, -- Gift of the Doomsayer

		--[[ Dreadlord Mendacius ]]--
		{196249, "FLASH"}, -- Meteor

		--[[ Grimhorn the Enslaver ]]--
		{202615, "SAY"}, -- Torment
		202607, -- Anguished Souls
	}, {
		[193565] = L.soulrender,
		[193069] = L.infester,
		[191735] = L.myrmidon,
		[196799] = L.fury,
		[210202] = L.mother,
		[191527] = L.illianna,
		[196249] = L.mendacius,
		[202615] = L.grimhorn,
	}
end

function mod:OnBossEnable()
	self:RegisterMessage("BigWigs_OnBossEngage", "Disable")

	--[[ Glayvianna Soulrender ]]--
	self:Log("SPELL_AURA_APPLIED", "Glaive", 193565)
	self:Log("SPELL_DAMAGE", "Swoop", 191767)
	

	--[[ Felsworn Infester ]]--
	self:Log("SPELL_CAST_START", "NightmaresCast", 193069)
	self:Log("SPELL_AURA_APPLIED", "NightmaresApplied", 193069)

	--[[ Felsworn Myrmidon ]]--
	self:Log("SPELL_CAST_START", "DeafeningScreech", 191735)

	--[[ Fel-Infused Fury ]]--
	self:Log("SPELL_CAST_START", "UnleashFury", 196799)
	self:Log("SPELL_CAST_START", "FelGaze", 196796)

	--[[ Foul Mother ]]--
	self:Log("SPELL_AURA_APPLIED", "GroundEffectDamage", 210202, 194071) -- Foul Stench, A Mother's Love
 	self:Log("SPELL_PERIODIC_DAMAGE", "GroundEffectDamage", 210202, 194071)
 	self:Log("SPELL_PERIODIC_MISSED", "GroundEffectDamage", 210202, 194071)
	self:Log("SPELL_CAST_START", "Gravity", 194074)
	self:Log("SPELL_CAST_SUCCESS", "Mother", 194064)

	--[[ Blade Dancer Illianna ]]--
	self:Log("SPELL_CAST_START", "DeafeningShout", 191527)
	self:Log("SPELL_AURA_APPLIED", "GiftOfTheDoomsayer", 193164)

	--[[ Dreadlord Mendacius ]]--
	self:Log("SPELL_CAST_START", "Meteor", 196249)

	--[[ Grimhorn the Enslaver ]]--
	self:Log("SPELL_AURA_APPLIED", "Torment", 202615)
	self:Log("SPELL_AURA_REMOVED", "TormentRemoved", 202615)
	self:Log("SPELL_AURA_APPLIED", "AnguishedSouls", 202607) -- Anguished Souls
 	self:Log("SPELL_PERIODIC_DAMAGE", "AnguishedSouls", 202607)
 	self:Log("SPELL_PERIODIC_MISSED", "AnguishedSouls", 202607)
	self:Death("GlayviannaDeath", 98177)
	self:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED")
end

--------------------------------------------------------------------------------
-- Event Handlers
--

do
	local incombat = -1
	function mod:checkcombat()
		timer = self:ScheduleTimer("checkcombat", 1)
		local group = UnitInRaid("player") and "raid" or UnitInParty("player") and "party"
		local members = GetNumGroupMembers()
		for i = 1, members, 1 do
			local member = group..tostring(i)
			local affectingCombat = UnitAffectingCombat(member)
			local affectingCombatPlayer = UnitAffectingCombat("player")
			if affectingCombat == true or affectingCombatPlayer == true then
				incombat = GetTime()
			elseif incombat ~= -1 and incombat+2 < GetTime() then
				incombat = -1
				self:CancelTimer(timer)
				self:CancelTimer(timerglaive)
			end
		end
	end
	local prev = 0
	function mod:Glaive(args)
		local t = GetTime()
		if t-prev > 10 then
			prev = t
			self:Message(args.spellId, "Urgent", "Warning")
			self:Bar(191767, 15)
			self:CancelTimer(timer)
			timer = self:ScheduleTimer("checkcombat", 1)
			self:CancelTimer(timerglaive)
			timerglaive = self:ScheduleTimer("scheduledglave", 16)
		end
	end
	function mod:Swoop(args)
		local t = GetTime()
		if t-prev > 10 then
			prev = t
			self:Message(args.spellId, "Urgent", "Warning")
			self:Bar(args.spellId, 15)
			self:CancelTimer(timer)
			timer = self:ScheduleTimer("checkcombat", 1)
			self:CancelTimer(timerglaive)
			timerglaive = self:ScheduleTimer("scheduledglave", 16)
		end
	end
	function mod:scheduledglave()
		local t = GetTime()
		if t-prev > 10 then
			prev = t
			self:Bar(191767, 16)
			self:Message(191767, "Urgent", "Warning")
			timerglaive = self:ScheduleTimer("scheduledglave", 16)
		end
	end
	function mod:GlayviannaDeath(args)
		self:CancelTimer(timer)
		self:CancelTimer(timerglaive)
		self:StopBar(191767)
		self:StopBar(193565)
	end
end

do
	local prev = nil
	local preva = 0
	function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, _, _, spellGUID, spellId)
		local t = GetTime()
		if spellId == 194037 and spellGUID ~= prev and t-preva > 0.1 then
			preva = t
			prev = spellGUID
			self:Message(194037, "Important", "Alarm")
			self:CDBar(194037, 7)
		end
	end
end

function mod:Mother(args)
	self:TargetMessage(args.spellId, args.destName, "Urgent", "Warning")
	self:CDBar(194064, 22)
	if self:Me(args.destGUID) then
		self:Say(args.spellId)
		self:Flash(args.spellId)
		self:Message(args.spellId, "Personal", "Bam")
	end
end


--[[ Felsworn Infester ]]--
do
	local prev = 0
	function mod:NightmaresCast(args)
		self:Message(args.spellId, "Attention", self:Interrupter() and "Info", CL.casting:format(args.spellName))
		local t = GetTime()
		if t-prev > 24 then
			prev = t
			self:CDBar(args.spellId, 27)
		end
	end
end

function mod:NightmaresApplied(args)
	self:TargetMessage(args.spellId, args.destName, "Urgent", self:Healer() and "Alarm")
	if self:Me(args.destGUID) then
		self:Say(args.spellId)
	end
end

--[[ Felsworn Myrmidon ]]--
function mod:DeafeningScreech(args)
	self:Message(args.spellId, "Important", self:Ranged() and "Alert", CL.casting:format(args.spellName))
end

--[[ Fel-Infused Fury ]]--

do
	local prev = 0
	function mod:UnleashFury(args)
		local t = GetTime()
		if t-prev > 27 then
			prev = t
			self:CDBar(196799, 30)
		end
		self:Message(args.spellId, "Attention", "Alarm", CL.casting:format(args.spellName))
		if self:Interrupter(args.sourceGUID) then
			self:Flash(args.spellId)
		end
	end
end

do
	local prev = 0
	function mod:FelGaze(args)
		local t = GetTime()
		if t-prev > 23 then
			prev = t
			self:Message(args.spellId, "Urgent", "Warning", CL.casting:format(args.spellName))
			self:CDBar(196796, 25.5)
		elseif t-prev > 0.5 then
			prev = t
			self:Message(args.spellId, "Urgent", "Warning", CL.casting:format(args.spellName))
		end
	end
end

--[[ Foul Mother ]]--
do
	local prev = 0
	function mod:GroundEffectDamage(args)
		if self:Me(args.destGUID) then
			local t = GetTime()
			if t-prev > 1.5 then
				prev = t
				self:Message(args.spellId, "Personal", "Alert", CL.underyou:format(args.spellName))
			end
		end
	end
end

function mod:Gravity(args)
	self:Message(args.spellId, "Urgent", "Warning", CL.casting:format(args.spellName))
end

--[[ Blade Dancer Illianna ]]--
function mod:DeafeningShout(args)
	self:Message(args.spellId, "Important", self:Ranged() and "Alert", CL.casting:format(args.spellName))
end

function mod:GiftOfTheDoomsayer(args)
	if self:Dispeller("magic") or self:Me(args.destGUID) then
		self:TargetMessage(args.spellId, args.destName, "Urgent", "Alarm", nil, nil, true)
	end
end

--[[ Dreadlord Mendacius ]]--
function mod:Meteor(args)
	self:Message(args.spellId, "Urgent", "Alarm", CL.incoming:format(args.spellName))
end

--[[ Grimhorn the Enslaver ]]--
function mod:Torment(args)
	if self:Me(args.destGUID) then
		tormentOnMe = true
		self:Say(args.spellId)
	end
	self:TargetMessage(args.spellId, args.destName, "Urgent", "Alarm", nil, nil, true)
	self:TargetBar(args.spellId, 6, args.destName)
end

function mod:TormentRemoved(args)
	if self:Me(args.destGUID) then
		tormentOnMe = false
	end
end

do
	local prev = 0
	function mod:AnguishedSouls(args)
		if self:Me(args.destGUID) then
			local t = GetTime()
			-- Increased throttle if the player can't move due to having Torment
			if t-prev > (tormentOnMe and 6 or 1.5) then
				prev = t
				self:Message(args.spellId, "Personal", "Alert", CL.underyou:format(args.spellName))
			end
		end
	end
end
