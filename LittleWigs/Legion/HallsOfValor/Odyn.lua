
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Odyn", 1477, 1489)
if not mod then return end
mod:RegisterEnableMob(95676)
mod.engageId = 1809
mod.respawnTime = 15

--------------------------------------------------------------------------------
-- Localization
--
local PurpleMarker = mod:AddMarkerOption(true, "player", 3, 197963, 3)
local OrangeMarker = mod:AddMarkerOption(true, "player", 7, 197964, 7)
local YellowMarker = mod:AddMarkerOption(true, "player", 1, 197965, 1)
local BlueMarker = mod:AddMarkerOption(true, "player", 6, 197966, 6)
local GreenMarker = mod:AddMarkerOption(true, "player", 4, 197967, 4)
local L = mod:GetLocale()
if L then
	L.custom_on_autotalk = "Autotalk"
	L.custom_on_autotalk_desc = "Instantly selects the gossip option to start the fight."

	L.gossip_available = "Gossip available"
	L.gossip_trigger = "Most impressive! I never thought I would meet anyone who could match the Valarjar's strength... and yet here you stand."

	L.tankP = "|cFF800080Top Right|r (|T1323037:15:15:0:0:64:64:4:60:4:60|t)" -- Boss_OdunRunes_Purple
	L.tankO = "|cFFFFA500Bottom Right|r (|T1323039:15:15:0:0:64:64:4:60:4:60|t)" -- Boss_OdunRunes_Orange
	L.tankY = "|cFFFFFF00Bottom Left|r (|T1323038:15:15:0:0:64:64:4:60:4:60|t)" -- Boss_OdunRunes_Yellow
	L.tankB = "|cFF0000FFTop Left|r (|T1323035:15:15:0:0:64:64:4:60:4:60|t)" -- Boss_OdunRunes_Blue
	L.tankG = "|cFF008000Top|r (|T1323036:15:15:0:0:64:64:4:60:4:60|t)" -- Boss_OdunRunes_Green
	
	L.ddP = "|cFF800080Bottom Left|r (|T1323037:15:15:0:0:64:64:4:60:4:60|t)" -- Boss_OdunRunes_Purple
	L.ddO = "|cFFFFA500Top Left|r (|T1323039:15:15:0:0:64:64:4:60:4:60|t)" -- Boss_OdunRunes_Orange
	L.ddY = "|cFFFFFF00Top Right|r (|T1323038:15:15:0:0:64:64:4:60:4:60|t)" -- Boss_OdunRunes_Yellow
	L.ddB = "|cFF0000FFBottom Right|r (|T1323035:15:15:0:0:64:64:4:60:4:60|t)" -- Boss_OdunRunes_Blue
	L.ddG = "|cFF008000Bottom|r (|T1323036:15:15:0:0:64:64:4:60:4:60|t)" -- Boss_OdunRunes_Green
end

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"custom_on_autotalk",
		"warmup",
		197961, -- Runic Brand
		198263, -- Radiant Tempest
		200988, -- Spear of Light
		198077, -- Shatter Spears
		{198088, "ICON", "SAY"}, -- Glowing Fragment
		PurpleMarker,
		OrangeMarker,
		YellowMarker,
		BlueMarker,
		GreenMarker,
	}
end

function mod:OnBossEnable()
	self:RegisterEvent("CHAT_MSG_MONSTER_YELL", "Warmup")
	self:Log("SPELL_CAST_START", "RunicBrand", 197961)
	self:Log("SPELL_CAST_START", "RadiantTempest", 198263)
	self:Log("SPELL_CAST_START", "ShatterSpears", 198077)
	self:Log("SPELL_AURA_APPLIED", "GlowingFragment", 198088)
	self:Log("SPELL_AURA_REMOVED", "GlowingFragmentRemoved", 198088)
	
	self:Log("SPELL_AURA_APPLIED", "Purple", 197963)
	self:Log("SPELL_AURA_APPLIED", "Orange", 197964)
	self:Log("SPELL_AURA_APPLIED", "Yellow", 197965)
	self:Log("SPELL_AURA_APPLIED", "Blue", 197966)
	self:Log("SPELL_AURA_APPLIED", "Green", 197967)
	self:Log("SPELL_AURA_REMOVED", "PurpleRemoved", 197963)
	self:Log("SPELL_AURA_REMOVED", "OrangeRemoved", 197964)
	self:Log("SPELL_AURA_REMOVED", "YellowRemoved", 197965)
	self:Log("SPELL_AURA_REMOVED", "BlueRemoved", 197966)
	self:Log("SPELL_AURA_REMOVED", "GreenRemoved", 197967)
	
	self:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", nil, "boss1")
	self:RegisterEvent("GOSSIP_SHOW")
	self:RegisterMessage("BigWigs_BossComm")
end

function mod:OnEngage()
	self:Bar(198263, 24) -- Radiant Tempest
	self:Bar(198077, 40) -- Shatter Spears
	self:Bar(197961, 44) -- Runic Brand
end

function mod:VerifyEnable(unit)
	return UnitCanAttack("player", unit) or (UnitHealth(unit) / UnitHealthMax(unit) > 0.8)
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Warmup(event, msg)
	if msg == L.gossip_trigger then
		self:Bar("warmup", 25.2, L.gossip_available, "achievement_boss_odyn")
	end
end

function mod:RunicBrand(args)
	self:Message(args.spellId, "Attention", "Alarm", CL.casting:format(args.spellName))
	self:Bar(args.spellId, 56) -- m pull:44.0, 56.0
end


function mod:GlowingFragment(args)
	self:PrimaryIcon(args.spellId, args.destName)
	self:TargetMessage(args.spellId, args.destName, "Urgent", "Info")
	if self:Me(args.destGUID) then
		self:Say(198088)
	end
end

function mod:GlowingFragmentRemoved(args)
	self:PrimaryIcon(args.spellId, nil)
end

function mod:Purple(args)
	if self:Me(args.destGUID) then
		if self:Tank() then
			self:Message(197961, "Urgent", "Warning", L.tankP, args.spellId)
		else
			self:Message(197961, "Urgent", "Warning", L.ddP, args.spellId)
		end
	end
	if self:GetOption(PurpleMarker) then
		SetRaidTarget(args.destName, 3)
	end
end

function mod:Orange(args)
	if self:Me(args.destGUID) then
		if self:Tank() then
			self:Message(197961, "Urgent", "Warning", L.tankO, args.spellId)
		else
			self:Message(197961, "Urgent", "Warning", L.ddO, args.spellId)
		end
	end
	if self:GetOption(OrangeMarker) then
		SetRaidTarget(args.destName, 7)
	end
end

function mod:Yellow(args)
	if self:Me(args.destGUID) then
		if self:Tank() then
			self:Message(197961, "Urgent", "Warning", L.tankY, args.spellId)
		else
			self:Message(197961, "Urgent", "Warning", L.ddY, args.spellId)
		end
	end
	if self:GetOption(YellowMarker) then
		SetRaidTarget(args.destName, 1)
	end
end

function mod:Blue(args)
	if self:Me(args.destGUID) then
		if self:Tank() then
			self:Message(197961, "Urgent", "Warning", L.tankB, args.spellId)
		else
			self:Message(197961, "Urgent", "Warning", L.ddB, args.spellId)
		end
	end
	if self:GetOption(BlueMarker) then
		SetRaidTarget(args.destName, 6)
	end
end

function mod:Green(args)
	if self:Me(args.destGUID) then
		if self:Tank() then
			self:Message(197961, "Urgent", "Warning", L.tankG, args.spellId)
		else
			self:Message(197961, "Urgent", "Warning", L.ddG, args.spellId)
		end
	end
	if self:GetOption(GreenMarker) then
		SetRaidTarget(args.destName, 4)
	end
end

function mod:PurpleRemoved(args)
	if self:GetOption(PurpleMarker) then
		SetRaidTarget(args.destName, 0)
	end
end

function mod:OrangeRemoved(args)
	if self:GetOption(OrangeMarker) then
		SetRaidTarget(args.destName, 0)
	end
end

function mod:YellowRemoved(args)
	if self:GetOption(YellowMarker) then
		SetRaidTarget(args.destName, 0)
	end
end

function mod:BlueRemoved(args)
	if self:GetOption(BlueMarker) then
		SetRaidTarget(args.destName, 0)
	end
end

function mod:GreenRemoved(args)
	if self:GetOption(GreenMarker) then
		SetRaidTarget(args.destName, 0)
	end
end

function mod:RadiantTempest(args)
	self:Message(args.spellId, "Important", "Long")
	self:CDBar(args.spellId, 56) -- hc pull:24.0 / m pull:8.0, 80.0
end

function mod:ShatterSpears(args)
	self:Message(args.spellId, "Important", "Alert", CL.incoming:format(args.spellName))
	self:Bar(args.spellId, 56) -- m pull:40.0, 56.0
end

function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, _, _, spellId)
	if spellId == 198396 then -- Spear of Light
		self:Message(200988, "Urgent", "Alert")
	end
end

function mod:GOSSIP_SHOW()
	if self:GetOption("custom_on_autotalk") and self:MobId(UnitGUID("npc")) == 95676 then
		if GetGossipOptions() then
			SelectGossipOption(1, "", true) -- auto confirm it
			mod:Sync("odyn")
		end
	end
end

function mod:BigWigs_BossComm(_, msg)
	if msg == "odyn" then
		local name = EJ_GetEncounterInfo(1489)
		self:Message("warmup", "Neutral", "Info", CL.incoming:format(name), false)
		self:CDBar("warmup", 2.7, name, "achievement_boss_odyn")
	end
end
