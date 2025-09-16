
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("King Deepbeard", 1456, 1491)
if not mod then return end
mod:RegisterEnableMob(91797)
mod.engageId = 1812


local GaseousBubblesCount = 1
--------------------------------------------------------------------------------
-- Locals
--

local bubblesOnMe = false

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.absorb = "Поглощение"
	L.absorb_text = "%s (|cff%s%.0f%%|r)"
	L.cast = "Взрыв через"
	L.cast_text = "%.1fs (|cff%s%.0f%%|r)"
end

--------------------------------------------------------------------------------
-- Initialization
--
function mod:GetOptions()
	return {
		193051, -- Call the Seas
		{193018, "SAY", "FLASH", "INFOBOX"}, -- Gaseous Bubbles
		193093, -- Ground Slam
		{193152, "PROXIMITY"}, -- Quake
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_SUCCESS", "CallTheSeas", 193051)
	self:Log("SPELL_CAST_SUCCESS", "GaseousBubbles", 193018)
	self:Log("SPELL_AURA_APPLIED", "GaseousBubblesApplied", 193018)
	self:Log("SPELL_AURA_REMOVED", "GaseousBubblesRemoved", 193018)
	self:Log("SPELL_CAST_START", "GroundSlam", 193093)
	self:Log("SPELL_CAST_START", "Quake", 193152)
 	self:Log("SPELL_DAMAGE", "Aftershock", 193171)
 	self:Log("SPELL_MISSED", "Aftershock", 193171)
end

function mod:OnEngage()
	GaseousBubblesCount = 1
	bubblesOnMe = false
	self:Bar(193051, 20) -- Call the Seas
	self:CDBar(193018, 11) -- Gaseous Bubbles
	self:CDBar(193093, 7) -- Ground Slam
	self:Bar(193152, 15) -- Quake
	self:OpenProximity(193152, 5) -- Quake
end

--------------------------------------------------------------------------------
-- Event Handlers
--

do
	local timer, castOver, maxAbsorb = nil, 0, 0
	local red, yellow, green = {.6, 0, 0, .6}, {.7, .5, 0}, {0, .5, 0}

	local function updateInfoBox(self, spellId)
		local castTimeLeft = castOver - GetTime()
		local castPercentage = castTimeLeft / 20
		local absorb = UnitGetTotalAbsorbs("player")
		local absorbPercentage = absorb / maxAbsorb

		local diff = castPercentage - absorbPercentage
		local hexColor = "ff0000"
		local rgbColor = red
		if diff > 0.1 then
			hexColor = "00ff00"
			rgbColor = green
		elseif diff > 0 then
			hexColor = "ffff00"
			rgbColor = yellow
		end

		self:SetInfoBar(spellId, 1, absorbPercentage, unpack(rgbColor))
		self:SetInfo(spellId, 2, L.absorb_text:format(self:AbbreviateNumber(absorb), hexColor, absorbPercentage * 100))
		self:SetInfoBar(spellId, 3, castPercentage)
		self:SetInfo(spellId, 4, L.cast_text:format(castTimeLeft, hexColor, castPercentage * 100))
	end

	function mod:GaseousBubblesApplied(args)
		if self:CheckOption(args.spellId, "INFOBOX") and self:Me(args.destGUID) then
			self:OpenInfo(args.spellId, args.spellName)
			self:SetInfo(args.spellId, 1, L.absorb)
			self:SetInfo(args.spellId, 3, L.cast)
			castOver = GetTime() + 20
			maxAbsorb = UnitGetTotalAbsorbs("player")
			timer = self:ScheduleRepeatingTimer(updateInfoBox, 0.1, self, args.spellId)
			bubblesOnMe = true
			self:Say(args.spellId)
			local _, _, duration = self:UnitDebuff("player", args.spellId)
			self:SayCountdown(args.spellId, duration, 8, 5)
			self:TargetBar(args.spellId, 20, args.destName)
			self:Flash(args.spellId)
		end
		self:TargetMessage(args.spellId, args.destName, "Personal", "Warning")
	end
	
	function mod:GaseousBubblesRemoved(args)
		if self:Me(args.destGUID) then
			self:Message(args.spellId, "Positive", "Info", CL.removed:format(args.spellName))
			self:CancelTimer(timer)
			timer = nil
			self:CloseInfo(193018)
			bubblesOnMe = false
			self:CancelSayCountdown(193018)
			self:StopBar(args.spellName, args.destName)
		end
	end
end

function mod:CallTheSeas(args)
	self:Message(args.spellId, "Attention", "Long")
	self:Bar(args.spellId, 30) -- pull:20.5, 30.4, 30.3
end

function mod:GaseousBubbles(args)
	self:CDBar(args.spellId, 31.5) -- pull:12.8, 35.3, 32.8 / m pull:12.9, 35.3, 32.8, 32.8
end

function mod:GroundSlam(args)
	self:Message(args.spellId, "Urgent", "Info", CL.incoming:format(args.spellName))
	self:CDBar(args.spellId, 18) -- pull:5.9, 18.2, 20.6, 19.4
end

function mod:Quake(args)
	self:Message(args.spellId, "Important", "Alert")
	self:Bar(args.spellId, 22.5) -- pull:15.6, 21.9, 21.8, 21.8
end

do
	local prev = 0
	function mod:Aftershock(args)
		if self:Me(args.destGUID) then
			local t = GetTime()
			-- players with Gaseous Bubbles may (and should) be taking damage intentionally
			if t-prev > (bubblesOnMe and 6 or 1.5) then
				prev = t
				self:Message(193152, "Personal", "Alert", CL.underyou:format(args.spellName))
			end
		end
	end
end
