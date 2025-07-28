
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Naltira", 1516, 1500)
if not mod then return end
mod:RegisterEnableMob(98207, 98759, 110966) -- Naltira, Vicious Manafang
mod.engageId = 1826

--------------------------------------------------------------------------------
-- Locals
--
local ViciousManafangsCount = 1
local webCDCount = 1
local webCount = 1
local blink = 0
local blinkCount = 1
local TangledWebCount = 1
local TangledWebIconCount = 0
local BlinkStrikesCount = 0

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.vicious_manafang = -13765
	L.vicious_manafang_desc = -13766 -- Devour
	L.vicious_manafang_icon = "inv_misc_monsterspidercarapace_01"
end

--------------------------------------------------------------------------------
-- Initialization
--
local TangledWebMarker = mod:AddMarkerOption(true, "player", 1, 200284, 1, 2, 3, 4, 5, 6) -- Tangled Web
function mod:GetOptions()
	return {
		-12687, -- Blink Strikes
		{200040, "FLASH"}, -- Nether Venom
		{200227, "FLASH"}, -- Nether Venom
		200024, -- Nether Venom
		{200284, "PROXIMITY"}, -- Tangled Web
		TangledWebMarker,
		"vicious_manafang", -- Vicious Manafang
		{211543, "SAY"}, -- Devour
	}, {
		[211543] = L.vicious_manafang,
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "WebCD", 200227)
	self:Log("SPELL_CAST_START", "NetherVenom", 200024)
	self:Log("SPELL_CAST_SUCCESS", "NetherVenom", 200040)
	self:Log("SPELL_PERIODIC_DAMAGE", "NetherVenomDamage", 200040)
	self:Log("SPELL_AURA_APPLIED", "TangledWebApplied", 200284)
	self:Log("SPELL_AURA_REMOVED", "TangledWebRemoved", 200284)
	self:Log("SPELL_AURA_APPLIED", "Devour", 211543)
end

function mod:OnEngage()
	ViciousManafangsCount = 1
	webCDCount = 1
	webCount = 1
	blink = 1
	blinkCount = 1
	TangledWebCount = 1
	TangledWebIconCount = 0
	BlinkStrikesCount = 1

	self:CDBar(-12687, 15.7, CL.count:format(self:SpellName(-12687), BlinkStrikesCount)) -- Blink Strikes
	self:CDBar("vicious_manafang", 34, L.vicious_manafang, L.vicious_manafang_icon) -- Vicious Manafang
	self:ScheduleTimer("CDBar", 34, 211543, 12)
	self:ScheduleTimer("ViciousManafangs", 34)
	self:CDBar(200040, 25.3) -- Nether Venom
	self:CDBar(200284, 35) -- Tangled Web
	

	-- no CLEU event for Blink Strikes
	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", "BlinkStrikes", "boss1")
	self:RegisterUnitEvent("UNIT_SPELLCAST_CHANNEL_START", "BlinkStrikes", "boss1")
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:WebCD(args)
	webCDCount = webCDCount + 1
	if webCDCount == 2 then
		self:CDBar(200227, 25.57)
	elseif webCDCount == 3 then
		self:CDBar(200227, 23.79)
		self:CDBar(200024, 29)
	else
		self:CDBar(200227, 30.00)
	end
	self:Message(args.spellId, "Urgent", "Long")
end

function mod:BlinkStrikes(_, spellName, _, _, spellId)
	if spellId == 199810 and blink == 1 then -- UNIT_SPELLCAST_SUCCEEDED
		blinkCount = 1
		self:Message(-12687, "Urgent", "Alert", CL.count:format(spellName, blinkCount))
		blink = blink + 1
	elseif spellId == 199811 and blink == 2 then -- UNIT_SPELLCAST_CHANNEL_START
		local target = self:UnitName("boss1target")
		blinkCount = blinkCount + 1
		blink = blink + 1
	elseif spellId == 199810 and blink == 3 then -- UNIT_SPELLCAST_SUCCEEDED
		self:Message(-12687, "Urgent", "Alert", CL.count:format(spellName, blinkCount))
		blinkCount = 1
		blink = blink + 1
	elseif spellId == 199811 and blink == 4 then -- UNIT_SPELLCAST_CHANNEL_START
		local target = self:UnitName("boss1target")
		blinkCount = blinkCount + 1
		blink = 1
		BlinkStrikesCount = BlinkStrikesCount + 1
		self:CDBar(-12687, 24.2, CL.count:format(self:SpellName(-12687), BlinkStrikesCount))
	end
end

function mod:ViciousManafangs()
	ViciousManafangsCount = ViciousManafangsCount + 1
	if ViciousManafangsCount == 2 then
		self:ScheduleTimer("ViciousManafangs", 21)
		self:Bar("vicious_manafang", 21, L.vicious_manafang, L.vicious_manafang_icon)
		self:ScheduleTimer("CDBar", 21, 211543, 12)
	elseif ViciousManafangsCount == 3 then
		self:ScheduleTimer("ViciousManafangs", 21)
		self:Bar("vicious_manafang", 21, L.vicious_manafang, L.vicious_manafang_icon)
		self:ScheduleTimer("CDBar", 21, 211543, 12)
	elseif ViciousManafangsCount == 4 then
		self:ScheduleTimer("ViciousManafangs", 28.5)
		self:Bar("vicious_manafang", 28, L.vicious_manafang, L.vicious_manafang_icon)
		self:ScheduleTimer("CDBar", 28.5, 211543, 12)
	elseif ViciousManafangsCount == 5 then
		self:ScheduleTimer("ViciousManafangs", 25)
		self:Bar("vicious_manafang", 25, L.vicious_manafang, L.vicious_manafang_icon)
		self:ScheduleTimer("CDBar", 25, 211543, 12)
	else
		self:ScheduleTimer("ViciousManafangs", 30)
		self:Bar("vicious_manafang", 30, L.vicious_manafang, L.vicious_manafang_icon)
		self:ScheduleTimer("CDBar", 30, 211543, 12)
	end
	self:Message("vicious_manafang", "Attention", self:Tank() and "Info", CL.spawned:format(self:SpellName(L.vicious_manafang)), false)
end

function mod:Devour(args)
	self:TargetMessage(args.spellId, args.destName, "Important", "Info", nil, nil, true)
	if self:Me(args.destGUID) then
		self:Say(args.spellId)
	end
end

do
	local targets, isOnMe = {}
	local function printTarget(self, spellId)
		if isOnMe then
			self:OpenProximity(spellId, 30, targets)
		end
		self:TargetMessage(spellId, self:ColorName(targets), "Attention", "Warning")
		wipe(targets)
		isOnMe = nil
	end

	function mod:TangledWebApplied(args)
		targets[#targets+1] = args.destName
		if #targets == 1 then
			self:ScheduleTimer(printTarget, 0.1, self, args.spellId)
			webCount = webCount + 1
		end
		if self:Me(args.destGUID) then
			isOnMe = true
		end
		if self:GetOption(TangledWebMarker) then
			local icon = (TangledWebIconCount % 6) + 1
			SetRaidTarget(args.destName, icon)
			TangledWebIconCount = TangledWebIconCount + 1
		end
	end

	function mod:TangledWebRemoved(args)
		if self:Me(args.destName) then
			self:Message(args.spellId, "Positive", nil, CL.removed:format(args.spellName))
			self:CloseProximity(args.spellId)
		end
		if self:GetOption(TangledWebMarker) then
			SetRaidTarget(args.destName, 0)
		end
	end
end

do
	local prev = 0
	function mod:NetherVenom(args)
		local t = GetTime()
		if t-prev > 5 then
			prev = t
			self:Message(args.spellId, "Urgent")
			self:CDBar(args.spellId, 30)
		end
	end
end

do
	local prev = 0
	function mod:NetherVenomDamage(args)
		if self:Me(args.destGUID) then
			local t = GetTime()
			if t-prev > 2 then
				prev = t
				self:Flash(args.spellId)
				self:Message(args.spellId, "Personal", "Alarm", CL.underyou:format(args.spellName))
			end
		end
	end
end
