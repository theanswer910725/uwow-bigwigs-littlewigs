
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Cathedral of Eternal Night Trash", 1677)
if not mod then return end
mod.displayName = CL.trash
mod:RegisterEnableMob(
	118704, -- Dul'zak
	119977, -- Stranglevine lasher
	121553, -- Dreadhunter
	118690, -- Wrathguard Invader
	119952, -- Felguard Destroyer
	119923, -- Helblaze Soulmender
	118703, -- Felborne Botanist
	118714, -- Hellblaze Temptress
	118713, -- Felstrider Orbcaster
	120713, -- Wa'glur
	118719, -- Wyrmtongue Scavenger
	118724, -- Helblaze Felbringer
	120779, -- Helblaze Felbringer
	118723, -- Gazerax
	118706, -- Necrotic Spiderling
	118705, -- Nal'asha
	121569  -- Vilebark Walker
)

local mark = {
  ["{rt1}"] = "|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_1:0|t",
  ["{rt2}"] = "|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_2:0|t",
  ["{rt3}"] = "|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_3:0|t",
  ["{rt4}"] = "|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_4:0|t",
  ["{rt5}"] = "|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_5:0|t",
  ["{rt6}"] = "|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_6:0|t",
  ["{rt7}"] = "|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_7:0|t",
  ["{rt8}"] = "|TInterface\\TargetingFrame\\UI-RaidTargetingIcon_8:0|t"
}
--------------------------------------------------------------------------------
-- Localization
--

local L = mod:GetLocale()
if L then
	L.dulzak = "Dul'zak"
	L.stranglevine = "Stranglevine lasher"
	L.dreadhunter = "Dreadhunter"
	L.wrathguard = "Wrathguard Invader"
	L.felguard = "Felguard Destroyer"
	L.soulmender = "Helblaze Soulmender"
	L.botanist = "Felborne Botanist"
	L.temptress = "Hellblaze Temptress"
	L.orbcaster = "Felstrider Orbcaster"
	L.waglur = "Wa'glur"
	L.scavenger = "Wyrmtongue Scavenger"
	L.helblaze = "Helblaze Felbringer"
	L.gazerax = "Gazerax"
	L.necrotic = "Necrotic Spiderling"
	L.Nalasha = "Nal'asha"
	L.vilebark = "Vilebark Walker"

	L.throw_tome = "Throw Tome"
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		-- Dul'zak
		238653, -- Shadow Wave
		-- Stranglevine lasher
		{238688, "SAY"}, -- Choking vines
		-- Dreadhunter
		242724, -- Dread Scream
		-- Wrathguard Invader
		{236737, "SAY"}, -- Fel Strike
		-- Felguard Destroyer
		241598, -- Shadow Wall
		-- Helblaze Soulmender
		238543, -- Demonic Mending
		-- Felborne Botanist
		237565, -- Blistering Rain
		-- Hellblaze Temptress
		{237391, "SAY"}, -- Alluring Aroma
		-- Felstrider Orbcaster
		239320, -- Felblaze Orb
		239288, -- Burning Strands
		-- Wa'glur
		241772, -- Unearthy Howl
		-- Wyrmtongue Scavenger
		242839, -- Throw Frost Tome
		242841, -- Throw Silence Tome
		239101, -- Throw Arcane Tome
		-- Helblaze Felbringer
		237599, -- Devastating Swipe
		-- Gazerax
		239232, -- Blinding Glare
		239201, -- Fel Glare
		239235, -- Focused Destruction
		-- Necrotic Spiderling
		236954, -- Sinister Fangs
		-- Nal'asha
		239052, -- Spider Call
		239266, -- Venom Storm
		237394, -- Vanish
		237395,
		
		-- Vilebark Walker
		242760, -- Lumbering Crash
		242772, -- Vile Roots
	}, {
		[238653] = L.dulzak,
		[238688] = L.stranglevine,
		[242724] = L.dreadhunter,
		[236737] = L.wrathguard,
		[241598] = L.felguard,
		[238543] = L.soulmender,
		[237565] = L.botanist,
		[237391] = L.temptress,
		[239320] = L.orbcaster,
		[239288] = L.orbcaster,
		[241772] = L.waglur,
		[242839] = L.scavenger,
		[239232] = L.gazerax,
		[236954] = L.necrotic,
		[239052] = L.Nalasha,
		[237599] = L.helblaze,
		[242760] = L.vilebark,
	}
end

function mod:OnBossEnable()
	self:RegisterMessage("BigWigs_OnBossEngage", "Disable")
	self:RegisterEvent("UNIT_SPELLCAST_START", "ShadowWave") -- Shadow Wave
	self:Log("SPELL_CAST_START", "ChokingVines", 238688) -- Choking Vines
	self:Log("SPELL_CAST_START", "FelStrike", 236737) -- Fel Strike
	self:Log("SPELL_CAST_START", "DreadScream", 242724) -- Dread Scream
	self:Log("SPELL_CAST_START", "ShadowWall", 241598) -- Shadow Wall
	self:Log("SPELL_CAST_START", "DemonicMending", 238543) -- Demonic Mending
	self:Log("SPELL_CAST_START", "BlisteringRain", 237565) -- Blistering Rain
	self:Log("SPELL_CAST_START", "AlluringAroma", 237391) -- Alluring Aroma
	self:Log("SPELL_CAST_START", "FelblazeOrb", 239320) -- Felblaze Orb
	self:Log("SPELL_CAST_START", "BurningStrands", 239288) -- Burning Strands
	self:Log("SPELL_CAST_START", "UnearthyHowl", 241772) -- Unearthy Howl
	self:Log("SPELL_CAST_START", "BlindingGlare", 239232) -- Blinding Glare
	self:Log("SPELL_CAST_START", "FelGlare", 239201) -- Fel Glare
	self:Log("SPELL_CAST_START", "FocusedDestruction", 239235) -- Focused Destruction
	self:Log("SPELL_CAST_START", "ThrowTome", 242839, 242841, 242837) -- Throw Frost Tome, Throw Silence Tome, Throw Arcane Tome
	self:Log("SPELL_CAST_START", "DevastatingSwipe", 237599) -- Devastating Swipe
	self:Log("SPELL_CAST_START", "LumberingCrash", 242760) -- Lumbering Crash
	self:Log("SPELL_AURA_APPLIED_DOSE", "SinisterFangsApplied", 236954)
	self:Log("SPELL_CAST_START", "VileRoots", 242772) -- Vile Roots
	self:Log("SPELL_CAST_SUCCESS", "SpiderCall", 239052) -- Spider Call
	self:Log("SPELL_CAST_START", "VenomStorm", 239266) -- Venom Storm
	self:Log("SPELL_CAST_START", "Vanish", 237395) -- Vanish
	self:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED")
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:SinisterFangsApplied(args)
	local amount = args.amount
	if amount % 5 == 0 and self:Dispeller("poison") then
		self:StackMessage(236954, args.destName, amount, "Personal", "Bite")
	end
end

do
	local prev = 0
	local function printTarget(self, name, guid)
		local t = GetTime()
		if self:Me(guid) then
			prev = t
			self:TargetMessage(238688, name, "Personal", "Bite")
			self:Say(238688)
		elseif t-prev > 1.5 then
			prev = t
			self:TargetMessage(238688, name, "Personal", "Alert")
		end
	end
	function mod:ChokingVines(args)
		self:GetUnitTarget(printTarget, 0.1, args.sourceGUID)
	end
end

-- Dul'zak
do
	local prev = nil
	function mod:ShadowWave(_, _, spellName, _, castGUID, spellId)
		if spellId == 238653 and castGUID ~= prev then -- Shadow Wave
			prev = castGUID
			self:Message(spellId, "Urgent", "Sneeze", CL.incoming:format(spellName))
			self:Message(spellId, "Urgent", "Alarm", CL.incoming:format(spellName))
			self:Bar(spellId, 23.2)
		end
	end
end

-- Wrathguard Invader
do
	local prev = 0
	local function printTarget(self, name, guid)
		local t = GetTime()
		if self:Me(guid) then
			prev = t
			self:TargetMessage(236737, name, "Personal", "Alert")
			self:Say(236737)
		elseif t-prev > 1.5 then
			prev = t
			self:TargetMessage(236737, name, "Personal", "Alert")
		end
	end
	function mod:FelStrike(args)
		self:GetUnitTarget(printTarget, 0.1, args.sourceGUID)
	end
end

-- Felguard Destroyer
function mod:ShadowWall(args)
	self:Message(args.spellId, "Attention", "Long", CL.casting:format(args.spellName))
end

-- Helblaze Soulmender

do
	local prev = 0
	function mod:DemonicMending(args)
		local t = GetTime()
		if t-prev > 15 then
			prev = t
			self:CDBar(238543, 25)
		elseif t-prev > 0.3 then
			prev = t
			self:CastBar(238543, 25)
		end
		self:Message(args.spellId, "Urgent", "Bam", CL.casting:format(args.spellName))
	end
end

-- Dreadhunter
function mod:DreadScream(args)
	self:CastBar(args.spellId, 26)
	self:Bar(args.spellId, 13)
	self:Message(args.spellId, "Urgent", "Bleat", CL.casting:format(args.spellName))
end

-- Felborne Botanist
function mod:BlisteringRain(args)
	self:Message(args.spellId, "Attention", "Long", CL.casting:format(args.spellName))
	
	local unit = self:GetUnitIdByGUID(args.sourceGUID)
    local raidIndex = unit and GetRaidTargetIndex(unit)
    if raidIndex and raidIndex > 0 then
        self:CDBar(237565, 22, CL.other:format(self:SpellName(237565), mark["{rt" .. raidIndex .. "}"]), 237565)
		return
    end
    for i = 1, 8 do
        if self:BarTimeLeft(CL.count:format(self:SpellName(237565), i)) < 1 then
            self:Bar(237565, 22, CL.count:format(self:SpellName(237565), i))
            break
        end
    end
end

-- Hellblaze Temptress
do
	local prev = 0
	local function printTarget(self, name, guid)
		local t = GetTime()
		if self:Me(guid) then
			prev = t
			self:TargetMessage(237391, name, "Personal", "Bam")
			self:Say(237391)
		elseif t-prev > 1.5 then
			prev = t
			self:TargetMessage(237391, name, "Personal", "Warning")
		end
	end
	function mod:AlluringAroma(args)
		self:GetUnitTarget(printTarget, 0.1, args.sourceGUID)
	end
end

-- Felstrider Orbcaster
function mod:FelblazeOrb(args)
	self:Message(args.spellId, "Urgent", "Warning", CL.casting:format(args.spellName))
end

function mod:BurningStrands(args)
	self:Message(args.spellId, "Urgent", "Bam", CL.casting:format(args.spellName))
	self:Bar(args.spellId, 17)
end

-- Wa'glur
function mod:UnearthyHowl(args)
	self:Message(args.spellId, "Urgent", "Warning", CL.casting:format(args.spellName))
end

-- Gazerax
function mod:BlindingGlare(args)
	self:Message(args.spellId, "Urgent", "Warning", CL.casting:format(args.spellName))
	self:CastBar(args.spellId, 2.5)
	self:CDBar(args.spellId, 30.5)
	self:CDBar(239201, 2.55)
end

function mod:FelGlare(args)
	self:CDBar(args.spellId, 7.3)
	self:Message(args.spellId, "Urgent", "Alert", CL.casting:format(args.spellName))
end

function mod:FocusedDestruction(args)
	self:CDBar(args.spellId, 31.5)
	self:CDBar(239201, 7.2)
	self:Message(args.spellId, "Urgent", "Sonar", CL.casting:format(args.spellName))
end

do
	local prev = 0
	function mod:ThrowTome(args)
		local t = GetTime()
		if t-prev > 1 then
			prev = t
			self:Message(args.spellId == 242837 and 239101 or args.spellId, "Urgent", "Warning", CL.casting:format(L.throw_tome)) -- using a different ID for Arcane Tome's options because 242837 has no description
		end
	end
end

-- Vilebark Walker
function mod:LumberingCrash(args)
	self:Message(args.spellId, "Important", "Alarm", CL.casting:format(args.spellName))
	self:CastBar(args.spellId, 17.5)
	self:Bar(args.spellId, 35)
end

function mod:VileRoots(args)
	self:Message(args.spellId, "Important", "Alarm", CL.casting:format(args.spellName))
	self:CastBar(args.spellId, 16)
	self:Bar(args.spellId, 32)
end

-- Helblaze Felbringer
function mod:DevastatingSwipe(args)
	self:Message(args.spellId, "Urgent", "Warning", CL.casting:format(args.spellName))
end

-- Nal'asha
function mod:SpiderCall(args)
	self:Bar(args.spellId, 27.5)
	self:Message(239052, "Attention", "Info", CL.spawned:format(self:SpellName(225017)))
end

function mod:VenomStorm(args)
	self:Bar(args.spellId, 20.3) 
	self:Message(args.spellId, "Urgent", "Sonar", CL.casting:format(args.spellName))
end

do
	local prev = nil
	function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, _, _, spellGUID, spellId)
		if spellId == 237394 and spellGUID ~= prev then -- 237395
			prev = spellGUID
			--self:CDBar(237394, 29)
			--self:CDBar(239266, 1.5)
			--self:Message(237394, "Urgent", "Warning")
		end
	end
end

function mod:Vanish(args)
	self:CDBar(237394, 20.3)
	self:Message(237394, "Urgent", "Warning")
end
