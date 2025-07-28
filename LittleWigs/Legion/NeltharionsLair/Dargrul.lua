
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Dargrul", 1458, 1687)
if not mod then return end
mod:RegisterEnableMob(91007)
mod.engageId = 1793

local MagmaWaveCount = 0
local CrystalSpikesCount = 0
local LandslideCount = 0
local MoltenCrashCount = 0
--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		{200732, "TANK"}, -- Molten Crash
		200700, -- Landslide
		{200154, "SAY", "ICON"}, -- Burning Hatred
		200404, -- Magma Wave
		200551, -- Crystal Spikes
		200637, -- Magma Sculptor
		200672, -- Crystal Cracked
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "MoltenCrash", 200732)
	self:Log("SPELL_CAST_START", "Landslide", 200700)
	self:Log("SPELL_AURA_APPLIED", "BurningHatred", 200154)
	self:Log("SPELL_AURA_REMOVED", "BurningHatredRemoved", 200154)
	self:Log("SPELL_CAST_START", "CrystalSpikes", 200551)
	self:Log("SPELL_CAST_START", "MagmaWave", 200404)
	self:Log("SPELL_CAST_START", "MagmaSculptor", 200637)

	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss1")
	self:RegisterEvent("CHAT_MSG_RAID_BOSS_EMOTE")
	self:RegisterUnitEvent("UNIT_POWER", nil, "boss1")
end

function mod:OnEngage()
	self:CDBar(200551, 5.90) -- Crystal Spikes
	self:CDBar(200637, 9.47) -- Magma Sculptor
	self:CDBar(200700, 15.56) -- Landslide
	self:CDBar(200732, 18.73) -- Molten Crash
	self:CDBar(200404, self:Normal() and 60 or 66) -- Magma Wave
	self:CDBar(200404, 66.70) -- Magma Wave
	MagmaWaveCount = 1
	CrystalSpikesCount = 1
	LandslideCount = 1
	MoltenCrashCount = 1
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:CHAT_MSG_RAID_BOSS_EMOTE(_, msg)
	if msg:find("200672", nil, true) then
		self:Message(200672, "Positive", "Long", msg)
	end
end

do
	local prev = 0
	function mod:UNIT_POWER(unit, pType, args)
		if pType == "MANA" then
			local t = GetTime()
			if t-prev > 0.5 then
				prev = t
				local power = UnitPower(unit, 0)+35
				if power == 95 then
					self:Message(200404, "Personal", "Bike Horn", CL.percent:format(power, self:SpellName(200404)))
				end
			end
		end
	end
end

function mod:MagmaSculptor(args)
	self:Message(args.spellId, "Attention", "Info", CL.spawned:format(self:SpellName(200637)))
end

function mod:MoltenCrash(args)
	if MoltenCrashCount == 1 and MagmaWaveCount == 3 then
		self:CDBar(args.spellId, 11.4)
	elseif MoltenCrashCount == 1 and MagmaWaveCount == 5 then
		self:CDBar(args.spellId, 11.94)
	elseif MoltenCrashCount == 1 and MagmaWaveCount == 7 then
		self:CDBar(args.spellId, 10.75)
	elseif MoltenCrashCount == 1 and MagmaWaveCount == 10 then
		self:CDBar(args.spellId, 10.21)
	elseif MoltenCrashCount == 1 or MoltenCrashCount == 2 then
		self:CDBar(args.spellId, 17)
	elseif MoltenCrashCount == 3 and (MagmaWaveCount == 3 or MagmaWaveCount == 5 or MagmaWaveCount == 7) then
		self:CDBar(args.spellId, 17)
	end
	self:Message(args.spellId, "Important", "Warning")
	MoltenCrashCount = MoltenCrashCount + 1
end

function mod:Landslide(args)
	if LandslideCount == 3 and MagmaWaveCount == 2 then
		self:CDBar(args.spellId, 18.3)
	elseif LandslideCount == 1 or LandslideCount == 2 then
		self:CDBar(args.spellId, 17)
	elseif LandslideCount == 3 and (MagmaWaveCount == 2 or MagmaWaveCount == 4 or MagmaWaveCount == 6 or MagmaWaveCount == 9) then
		self:CDBar(args.spellId, 17)
	end
	self:Message(args.spellId, "Urgent", "Alert")
	LandslideCount = LandslideCount + 1
end

function mod:BurningHatred(args)
	self:TargetMessage(args.spellId, args.destName, "Attention", "Alarm")
	self:PrimaryIcon(args.spellId, args.destName)
	if self:Me(args.destGUID) then
		self:Say(args.spellId)
	end
end

function mod:BurningHatredRemoved(args)
	self:PrimaryIcon(args.spellId, nil)
end

function mod:CrystalSpikes(args)
	if MagmaWaveCount == 1 then
		if CrystalSpikesCount == 1 then
			self:CDBar(args.spellId, 21.91)
		elseif CrystalSpikesCount == 2 then
			self:CDBar(args.spellId, 27.89)
		end
	end
	if MagmaWaveCount == 2 then
		if CrystalSpikesCount == 1 then
			self:CDBar(args.spellId, 21.9)
		elseif CrystalSpikesCount == 2 then
			self:CDBar(args.spellId, 21.93)
		end
	end
	if MagmaWaveCount == 3 then
		if CrystalSpikesCount == 1 then
			self:CDBar(args.spellId, 21.9)
		end
	end
	if MagmaWaveCount == 4 then
		if CrystalSpikesCount == 1 then
			self:CDBar(args.spellId, 25.41)
		elseif CrystalSpikesCount == 2 then
			self:CDBar(args.spellId, 21.9)
		end
	end
	if MagmaWaveCount == 5 then
		if CrystalSpikesCount == 1 then
			self:CDBar(args.spellId, 25.45)
		end
	end
	if MagmaWaveCount == 6 then
		if CrystalSpikesCount == 1 then
			self:CDBar(args.spellId, 25.48)
		elseif CrystalSpikesCount == 2 then
			self:CDBar(args.spellId, 23.8)
		end
	end
	if MagmaWaveCount == 7 then
		if CrystalSpikesCount == 1 then
			self:CDBar(args.spellId, 21.91)
		end
	end
	if MagmaWaveCount == 8 then
		if CrystalSpikesCount == 1 then
			self:CDBar(args.spellId, 25.47)
		elseif CrystalSpikesCount == 2 then
			self:CDBar(args.spellId, 21.9)
		end
	end
	if MagmaWaveCount == 9 then
		if CrystalSpikesCount == 1 then
			self:CDBar(args.spellId, 27.46)
		end
	end
	if MagmaWaveCount == 10 then
		if CrystalSpikesCount == 1 then
			self:CDBar(args.spellId, 21.9)
		elseif CrystalSpikesCount == 2 then
			self:CDBar(args.spellId, 21.9)
		end
	end
	self:Message(args.spellId, "Positive", "Alarm")
	CrystalSpikesCount = CrystalSpikesCount + 1
end

function mod:MagmaWave(args)
	if MagmaWaveCount == 1 then
		self:CDBar(200551, 12.59) -- Crystal Spikes
		self:CDBar(200637, 14.99) -- Magma Sculptor
		self:CDBar(200700, 6.59) -- Landslide
		self:CDBar(200732, 9.83) -- Molten Crash
		self:CDBar(200404, 60.99)
	elseif MagmaWaveCount == 2 then
		self:CDBar(200551, 20.88) -- Crystal Spikes
		self:CDBar(200637, 25.13) -- Magma Sculptor
		self:CDBar(200700, 14.88) -- Landslide
		self:CDBar(200732, 6.59) -- Molten Crash
		self:CDBar(200404, 61.01)
	elseif MagmaWaveCount == 3 then
		self:CDBar(200551, 6.59) -- Crystal Spikes
		self:CDBar(200637, 35.31) -- Magma Sculptor
		self:CDBar(200700, 9.03) -- Landslide
		self:CDBar(200732, 12.25) -- Molten Crash
		self:CDBar(200404, 62.97)
	elseif MagmaWaveCount == 4 then
		self:CDBar(200551, 12.92) -- Crystal Spikes
		self:CDBar(200637, 43.44) -- Magma Sculptor
		self:CDBar(200700, 15.35) -- Landslide
		self:CDBar(200732, 6.62) -- Molten Crash
		self:CDBar(200404, 60.99)
	elseif MagmaWaveCount == 5 then
		self:CDBar(200551, 6.63) -- Crystal Spikes
		self:CDBar(200637, 53.54) -- Magma Sculptor
		self:CDBar(200700, 9.08) -- Landslide
		self:CDBar(200732, 12.34) -- Molten Crash
		self:CDBar(200404, 63.07)
	elseif MagmaWaveCount == 6 then
		self:CDBar(200551, 20.09) -- Crystal Spikes
		self:CDBar(200700, 14.05) -- Landslide
		self:CDBar(200732, 6.57) -- Molten Crash
		self:CDBar(200404, 60.94)
	elseif MagmaWaveCount == 7 then
		self:CDBar(200551, 9.08) -- Crystal Spikes
		self:CDBar(200637, 6.64) -- Magma Sculptor
		self:CDBar(200700, 11.48) -- Landslide
		self:CDBar(200732, 14.68) -- Molten Crash
		self:CDBar(200404, 60.97)
	elseif MagmaWaveCount == 8 then
		self:CDBar(200551, 19.22) -- Crystal Spikes
		self:CDBar(200637, 16.79) -- Magma Sculptor
		self:CDBar(200700, 6.69) -- Landslide
		self:CDBar(200732, 9.89) -- Molten Crash
		self:CDBar(200404, 61.06)
	elseif MagmaWaveCount == 9 then
		self:CDBar(200551, 8.67) -- Crystal Spikes
		self:CDBar(200637, 26.87) -- Magma Sculptor
		self:CDBar(200700, 13.63) -- Landslide
		self:CDBar(200732, 6.66) -- Molten Crash
	else
		self:CDBar(args.spellId, 60)
	end
	self:Message(200404, "Positive", "Long")
	CrystalSpikesCount = 1
	LandslideCount = 1
	MoltenCrashCount = 1
	MagmaWaveCount = MagmaWaveCount + 1
end

function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, _, _, spellId)
	if spellId == 201661 or spellId == 201663 then -- Dargrul Ability Callout 02, Dargrul Ability Callout 03
		self:Message(200404, "Positive", "Long")
		self:CDBar(200404, self:Normal() and 59.7 or 60.8)
		self:CastBar(200404, 7, CL.cast:format(self:SpellName(200404)))
	end
end
