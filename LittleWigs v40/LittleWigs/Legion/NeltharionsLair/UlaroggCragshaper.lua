
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Ularogg Cragshaper", 1458, 1665)
if not mod then return end
mod:RegisterEnableMob(91004)
mod.engageId = 1791

--------------------------------------------------------------------------------
-- Locals
--

local totemsAlive = 0
local StanceCount = 0
local SunderCount = 0
local StrikeCount = 0
local sequence = 0

local timers = {
	[198496] = {18.2, 9.7, 8.5, 0, 9.75, 8.53, 15.75, 8.52, 0, 9.71, 8.50, 15.72, 9.68, 0, 15.78, 9.77, 8.50, 0, 9.72, 8.52, 15.77, 8.49, 0, 9.75, 8.53, 15.76, 9.76, 0},  -- Sunder
	[198428] = {15.81, 18.26, 0, 24.26, 18.26, 0, 18.25, 15.68, 0, 15.77, 18.22, 0, 24.31, 18.19, 0, 18.29, 15.77, 0}, -- Strike of the Mountain
	
	[111111] = {18.2, 9.7, 8.5, 0, 9.75, 8.5, 15.75, 9.74, 0, 15.78, 9.74, 8.50, 0, 9.72, 8.52, 15.76, 9.75, 0, 15.88, 9.70, 8.52, 0, 9.69, 8.52, 15.72, 9.75, 0},  -- Sunder
	[222222] = {15.77, 18.21, 0, 18.22, 15.8, 0, 15.72, 18.22, 0, 18.29, 15.75, 0, 15.84, 18.25, 0, 18.22, 15.75, 0}, -- Strike of the Mountain
}

--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.totems = "Totems"
	L.bellow = "{193375} (Totems)" -- Bellow of the Deeps (Totems)
	L.bellow_desc = 193375
	L.bellow_icon = 193375
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		198564, -- Stance of the Mountain
		198496, -- Sunder
		198428, -- Strike of the Mountain
		"bellow",
	}
end

function mod:OnBossEnable()
	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss1")
	self:Log("SPELL_CAST_START", "Sunder", 198496)
	self:Log("SPELL_CAST_START", "StrikeOfTheMountain", 198428)
	self:Log("SPELL_CAST_START", "BellowOfTheDeeps", 193375)
	self:Death("IntermissionTotemsDeath", 100818)
end

function mod:OnEngage()
	sequence = 0
	SunderCount = 1
	StrikeCount = 1
	StanceCount = 1
	self:Bar(198428, 15.3) -- Strike of the Mountain
	self:CDBar(198496, 8) -- Sunder
	self:CDBar(198564, self:Mythic() and 60.06 or 61, CL.count:format(self:SpellName(198564), StanceCount)) -- Stance of the Mountain
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, _, _, spellId)
	if spellId == 198509 then -- Stance of the Mountain
		totemsAlive = self:Normal() and 3 or 5
		self:StopBar(198496) -- Sunder
		self:StopBar(198428) -- Strike of the Mountain
		self:StopBar(198564) -- Stance of the Mountain
		self:Message(198564, "Attention", "Long")
	end
end


function mod:Sunder(args)
	self:Message(args.spellId, "Attention", "Alert", CL.casting:format(args.spellName))
	if sequence == 2 then
		self:Bar(args.spellId, timers[111111][SunderCount])
	else
		self:Bar(args.spellId, timers[args.spellId][SunderCount])
	end
	SunderCount = SunderCount + 1
end

function mod:StrikeOfTheMountain(args)
	self:Message(args.spellId, "Important", "Alarm")
	if StrikeCount == 5 and sequence == 0 then
		sequence = 2
		self:CDBar(198564, self:BarTimeLeft(CL.count:format(self:SpellName(198564), StanceCount))-3.8, CL.count:format(self:SpellName(198564), StanceCount))
	end
	if sequence == 2 then
		self:Bar(args.spellId, timers[222222][StrikeCount])
	else
		self:Bar(args.spellId, timers[args.spellId][StrikeCount])
	end
	StrikeCount = StrikeCount + 1
end

function mod:BellowOfTheDeeps(args)
	self:Message("bellow", "Urgent", "Info", CL.incoming:format(L.totems), args.spellId)
	if StrikeCount == 5 and sequence == 0 then
		sequence = 1
	end
end

function mod:IntermissionTotemsDeath()
	totemsAlive = totemsAlive - 1
	if totemsAlive == 0 then
		if	StanceCount == 1 then -- all of them fire UNIT_DIED
			StanceCount = StanceCount + 1
			--self:CDBar(198564, self:Mythic() and 52.01 or 70.7, CL.count:format(self:SpellName(198564), StanceCount)) -- Stance of the Mountain
			self:CDBar(198564, self:Mythic() and 55.84 or 70.7, CL.count:format(self:SpellName(198564), StanceCount)) -- Stance of the Mountain
			self:Bar(198428, 8.36) -- Strike of the Mountain
			self:CDBar(198496, 3.48) -- Sunder
		elseif StanceCount == 2 then -- all of them fire UNIT_DIED
			StanceCount = StanceCount + 1
			if sequence == 2 then
			  self:CDBar(198564, self:Mythic() and 56.80 or 70.7, CL.count:format(self:SpellName(198564), StanceCount)) -- Stance of the Mountain
			  self:Bar(198428, 11.98) -- Strike of the Mountain
			  self:CDBar(198496, 7.10) -- Sunder
			else
				self:CDBar(198564, self:Mythic() and 57.94 or 70.7, CL.count:format(self:SpellName(198564), StanceCount)) -- Stance of the Mountain
				self:Bar(198428, 14.37) -- Strike of the Mountain
				self:CDBar(198496, 9.52) -- Sunder
			end
		elseif StanceCount == 3 then -- all of them fire UNIT_DIED
			StanceCount = StanceCount + 1
			if sequence == 2 then
			  self:CDBar(198564, self:Mythic() and 52.13 or 70.7, CL.count:format(self:SpellName(198564), StanceCount)) -- Stance of the Mountain
			  self:Bar(198428, 8.38) -- Strike of the Mountain
			  self:CDBar(198496, 3.51) -- Sunder
			else
			  self:CDBar(198564, self:Mythic() and 56.88 or 70.7, CL.count:format(self:SpellName(198564), StanceCount)) -- Stance of the Mountain
			  self:Bar(198428, 12.03) -- Strike of the Mountain
			  self:CDBar(198496, 7.13) -- Sunder
			end
		elseif StanceCount == 4 then -- all of them fire UNIT_DIED
			StanceCount = StanceCount + 1
			if sequence == 2 then
			  self:CDBar(198564, self:Mythic() and 56.89 or 70.7, CL.count:format(self:SpellName(198564), StanceCount)) -- Stance of the Mountain
			  self:Bar(198428, 11.96) -- Strike of the Mountain
			  self:CDBar(198496, 7.09) -- Sunder
			else
			  self:CDBar(198564, self:Mythic() and 55.68 or 70.7, CL.count:format(self:SpellName(198564), StanceCount)) -- Stance of the Mountain
			  self:Bar(198428, 8.35) -- Strike of the Mountain
			  self:CDBar(198496, 3.48) -- Sunder
			end
		elseif StanceCount == 5 then -- all of them fire UNIT_DIED
			StanceCount = StanceCount + 1
			if sequence == 2 then
			  self:CDBar(198564, self:Mythic() and 52.6 or 70.7, CL.count:format(self:SpellName(198564), StanceCount)) -- Stance of the Mountain
			  self:Bar(198428, 8.41) -- Strike of the Mountain
			  self:CDBar(198496, 3.48) -- Sunder
			else
			  self:CDBar(198564, self:Mythic() and 58.19 or 70.7, CL.count:format(self:SpellName(198564), StanceCount)) -- Stance of the Mountain
			  self:Bar(198428, 14.46) -- Strike of the Mountain
			  self:CDBar(198496, 9.59) -- Sunder
			end
		end
	end
end
