
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
local MagmaSculptorCount = 0

local timers = {
	[200551] = {21.80, 21.84, 33.30, 21.85, 21.78, 26.62, 21.80, 32.75, 29.07, 21.81, 26.82, 22.86, 38.68, 21.82, 21.83, 26.55, 21.81, 32.67, 26.62, 21.84, 21.83, 26.66, 21.82, 23.84, 21.82, 35.78}, -- Crystal Spikes
	[200637] = {74.49, 71.51, 77.56, 71.51, 75.12, 71.50, 71.52, 87.89, 71.50}, -- Magma Sculptor
	[200700] = {17.00, 18.60, 23.64, 17.03, 17.02, 19.20, 16.98, 17.00, 17.01, 30.15, 17.03, 17.02, 16.99, 17.02, 17.02, 16.98, 27.50, 17.04, 17.02, 19.20, 16.99, 17.01, 17.03, 30.05, 17.07, 16.91, 18.37, 17.95, 17.02, 17.02, 26.24, 17.02, 16.99, 17.01, 18.67}, -- Landslide
	[200732] = {17.03, 18.57, 23.61, 17.05, 17.04, 28.72, 7.48, 16.94, 17.07, 30.13, 17.02, 17.05, 26.24, 7.77, 16.99, 16.98, 27.52, 17.04, 17.02, 28.65, 7.52, 17.01, 17.05, 30.05, 17.00, 16.97, 27.31, 9.02, 16.99, 17.06, 26.20, 17.03, 17.06, 16.97}, -- Molten Crash
	[200404] = {66.05, 65.96, 65.98, 66.00, 65.99, 66.01, 66.84, 66.13, 67.24}, -- Magma Wave
}
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
		216407, -- Lava Geyser
		200637, -- Magma Sculptor
		200672, -- Crystal Cracked
	}, {
		[200154] = -12596, -- Molten Charskin
	}, {
		[200637] = CL.big_add, -- Magma Sculptor (Big Add)
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_START", "MoltenCrash", 200732)
	self:Log("SPELL_CAST_START", "Landslide", 200700)
	self:Log("SPELL_AURA_APPLIED", "BurningHatred", 200154)
	self:Log("SPELL_AURA_REMOVED", "BurningHatredRemoved", 200154)
	self:Log("SPELL_CAST_START", "CrystalSpikes", 200551)
	self:Log("SPELL_CAST_START", "MagmaWave", 200404)
	self:Log("SPELL_CAST_START", "MagmaWavePreCast", 200418)
	self:Log("SPELL_CAST_START", "MagmaSculptor", 200637)
	self:Log("SPELL_AURA_APPLIED", "LavaGeyserDamage", 216407)
	self:Log("SPELL_PERIODIC_DAMAGE", "LavaGeyserDamage", 216407)

	self:RegisterEvent("CHAT_MSG_RAID_BOSS_EMOTE")
end

function mod:OnEngage()
	self:CDBar(200551, 5.86) -- Crystal Spikes
	self:CDBar(200637, 10.72, CL.big_add) -- Magma Sculptor
	self:CDBar(200700, 16.36) -- Landslide
	self:CDBar(200732, 19.58) -- Molten Crash
	self:CDBar(200404, 68.01) -- Magma Wave
	MagmaWaveCount = 1
	CrystalSpikesCount = 1
	LandslideCount = 1
	MoltenCrashCount = 1
	MagmaSculptorCount = 1
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:CHAT_MSG_RAID_BOSS_EMOTE(_, msg)
	if msg:find("200672", nil, true) then
		self:Message(200672, "Positive", "Info", msg)
	end
end

function mod:MagmaSculptor(args)
	self:Message(args.spellId, "yellow", "Alert", CL.incoming:format(CL.big_add))
	self:Bar(args.spellId, timers[args.spellId][MagmaSculptorCount], CL.big_add)
	MagmaSculptorCount = MagmaSculptorCount + 1
end

function mod:MoltenCrash(args)
	self:Message(args.spellId, "Personal", "Alert")
	self:Bar(args.spellId, timers[args.spellId][MoltenCrashCount])
	MoltenCrashCount = MoltenCrashCount + 1
end

function mod:Landslide(args)
	self:Message(args.spellId, "orange", "Alarm")
	self:Bar(args.spellId, timers[args.spellId][LandslideCount])
	LandslideCount = LandslideCount + 1
end

function mod:BurningHatred(args)
	self:TargetMessage(args.spellId, args.destName, "red", nil)
	self:PrimaryIcon(args.spellId, args.destName)
	if self:Me(args.destGUID) then
		self:Say(args.spellId)
		self:PlaySound(args.spellId, "Warning", nil, args.destName)
	else
		self:PlaySound(args.spellId, "Alert", nil, args.destName)
	end
end

function mod:BurningHatredRemoved(args)
	self:PrimaryIcon(args.spellId, nil)
end

function mod:CrystalSpikes(args)
	self:Message(args.spellId, "yellow", "Alarm")
	self:Bar(args.spellId, timers[args.spellId][CrystalSpikesCount])
	CrystalSpikesCount = CrystalSpikesCount + 1
end

function mod:MagmaWavePreCast(args)
	self:Message(200404, "red") -- Magma Wave
	self:PlaySound(200404, "long") -- Magma Wave
end

function mod:MagmaWave(args)
	self:CastBar(200404, 6)
	self:Bar(args.spellId, timers[args.spellId][MagmaWaveCount])
	MagmaWaveCount = MagmaWaveCount + 1
end

do
	local prev = 0
	function mod:LavaGeyserDamage(args)
		if self:Me(args.destGUID) then
			local t = GetTime()
			if t - prev > 2 then
				prev = t
				self:Message(args.spellId, "Personal", "Alarm", CL.underyou:format(args.spellName))
			end
		end
	end
end
