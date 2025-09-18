
--------------------------------------------------------------------------------
-- Module Declaration
--

local mod, CL = BigWigs:NewBoss("Halls of Valor Trash", 1477)
if not mod then return end
mod.displayName = CL.trash
mod:RegisterEnableMob(
	97081, -- King Bjorn
	95843, -- King Haldor
	97083, -- King Ranulf
	97084, -- King Tor
	96664, -- Valarjar Runecarver
	97202, -- Olmyr the Enlightened
	97219, -- Solsten
	95834, -- Valarjar Mystic
	95842, -- Valarjar Thundercaller
	97197, -- Valarjar Purifier
	101637, -- Valarjar Aspirant
	97068, -- Storm Drake
	99891, -- Storm Drake
	96640, -- Valarjar Marksman
	96934, -- Valarjar Trapper
	96608, -- Ebonclaw Worg
	96574 -- Stormforged Sentinel
)

local mobcount = 0

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
	L.custom_on_autotalk = "Autotalk"
	L.custom_on_autotalk_desc = "Instantly selects various gossip options around the dungeon."

	L.fourkings = "The Four Kings"
	L.runecarver = "Valarjar Runecarver"
	L.olmyr = "Olmyr the Enlightened"
	L.purifier = "Valarjar Purifier"
	L.thundercaller = "Valarjar Thundercaller"
	L.mystic = "Valarjar Mystic"
	L.aspirant = "Valarjar Aspirant"
	L.drake = "Storm Drake"
	L.marksman = "Valarjar Marksman"
	L.trapper = "Valarjar Trapper"
	L.worg = "Ebonclaw Worg"
	L.sentinel = "Stormforged Sentinel"
	L.Kings = "Ready for talk with %s"
	L.Check = "!kings"
	L.Start = "!pull"
	L.Reply = "I can activate (chat command or leader/assistant use gossip)"
	L.Function = "This function off"
	L.custom_off_multiple_kings = "Disable autotalk with kings (mini-bosses) for activate on chat command group leader"
	L.custom_off_multiple_kings_desc = "Enter |cffff0000!kings|r into the chat to find out if this feature is enabled. Open a dialog window with selected kings (NPC) and wait for the group leader to enter the command |cffff0000!pull|r into the chat to activate all the NPCs at the same time|cffff0000(need disable auto select gossip in other addons)|r|cff00ff00=> CHAT COMMANDS WORK ONLY FOR PARTY LEADER IN GROUP CHAT <=|r"
	L.warmup_trigger1 = "Hyrja... the fury of the storm is yours to command!"
	L.warmup_trigger2= "The Light shines eternal in you, Hyrja!"
end

local Worg = false

--------------------------------------------------------------------------------
-- Initialization
--

function mod:GetOptions()
	return {
		"custom_on_autotalk",
		"custom_off_multiple_kings",
		"warmup",
		{202285, "SAY"},
		192563, -- Cleansing Flames
		199726, -- Unruly Yell
		200969, -- Call Ancestor
		--199674, -- Wicked Dagger
		{199674, "SAY", "FLASH"},
		199652, -- Sever
		192158, -- Sanctify
		192288, -- Searing Light
		200901, -- Eye of the Storm
		191508, -- Blast of Light
		{198962, "SAY"}, -- Shattered rune
		{215430, "SAY", "FLASH", "PROXIMITY"}, -- Thunderstrike
		198931, -- Healing Light (replaced by Holy Radiance in mythic difficulty)
		198934, -- Rune of Healing
		215433, -- Holy Radiance
		198888, -- Lightning Breath
		199210, -- Penetrating Shot
		199341, -- Bear Trap
		199179, -- Leap for the Throat
		210875, -- Charged Pulse
		{199805, "SAY"}, -- Crackle
		{198745, "DISPEL"}, -- Protective Light
	}, {
		["custom_on_autotalk"] = "general",
		[192563] = L.purifier,
		[199726] = L.fourkings,
		[199674] = L.fourkings,
		[199652] = L.fourkings,
		[200969] = L.fourkings,
		[198962] = L.runecarver,
		[192158] = L.olmyr,
		[200901] = L.solsten,
		[191508] = L.aspirant,
		[215430] = L.thundercaller,
		[198931] = L.mystic,
		[198888] = L.drake,
		[199210] = L.marksman,
		[199341] = L.trapper,
		[199179] = L.worg,
		[210875] = L.sentinel,
	}
end

function mod:OnBossEnable()
	self:RegisterMessage("BigWigs_OnBossEngage", "Disable")

	-- Cleansing Flames, Unruly Yell, Sanctify, Blast of Light, Healing Light, Rune of Healing, Holy Radiance, Lightning Breath, Bear Trap, Charged Pulse
	self:Log("SPELL_CAST_START", "Casts", 192563, 191508, 198931, 198934, 215433, 199341, 210875)
	self:Log("SPELL_AURA_APPLIED", "MugofMead", 202285)
	self:Log("SPELL_CAST_START", "LightningBreath", 198888)
	self:Log("SPELL_CAST_START", "PenetratingShot", 199210)
	self:Log("SPELL_CAST_START", "WickedDagger", 199674)
	self:Log("SPELL_CAST_START", "UnrulyYell", 199726)
	self:Log("SPELL_CAST_START", "Sever", 199652)
	self:Log("SPELL_CAST_START", "CallAncestor", 200969)
	
	self:Log("SPELL_CAST_START", "SearingLight", 192288)
	self:Log("SPELL_CAST_SUCCESS", "SanctifySuccess", 192158)
	self:Log("SPELL_CAST_SUCCESS", "EyeoftheStormSuccess", 200901)
	self:Log("SPELL_CAST_START", "EyeOfTheStormOrSanctify", 200901, 192158)
	--[[ Stormforged Sentinel ]]--
	self:Log("SPELL_CAST_START", "CrackleCast", 199805)
	self:Log("SPELL_AURA_APPLIED", "GroundEffectDamage", 199818) -- Crackle
	self:Log("SPELL_PERIODIC_DAMAGE", "GroundEffectDamage", 199818)
	self:Log("SPELL_PERIODIC_MISSED", "GroundEffectDamage", 199818)
	self:Log("SPELL_AURA_APPLIED", "ProtectiveShield", 198745)

	self:Log("SPELL_AURA_APPLIED", "Thunderstrike", 215430)
	self:Log("SPELL_AURA_REMOVED", "ThunderstrikeRemoved", 215430)
	
	self:Log("SPELL_CAST_START", "ValarjarRunecarver", 198962)

	self:Death("KingsDeath",
		97081, -- King Bjorn
		95843, -- King Haldor
		97083, -- King Ranulf
		97084 -- King Tor
	)
	
	self:Death("OlmyrSolstenDeath", 97202, 97219)

	self:RegisterEvent("UNIT_SPELLCAST_START")
	self:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED")
	self:RegisterEvent("GOSSIP_SHOW")
	self:RegisterEvent("CHAT_MSG_PARTY_LEADER")
	self:RegisterEvent("CHAT_MSG_RAID_LEADER")
	self:RegisterEvent("CHAT_MSG_MONSTER_YELL", "Warmup")
	self:RegisterMessage("BigWigs_BossComm")
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:Warmup(_, msg)
	local name = EJ_GetEncounterInfo(1486)
	if msg:find(L.warmup_trigger1, nil, true) then
		mobcount = mobcount + 1
		self:StopBar(191976)
		self:StopBar(200901)
		if mobcount > 1 then
			self:Bar("warmup", 10, CL.active, 175516)
			self:Message("warmup", "Neutral", "Long", CL.custom_sec:format(CL.spawned:format(name), 10), 175516)
			mobcount = 0
		end
	end
	if msg:find(L.warmup_trigger2, nil, true) then
		mobcount = mobcount + 1
		self:StopBar(192288)
		self:StopBar(192158)
		if mobcount > 1 then
			self:Bar("warmup", 10, CL.active, 175516)
			self:Message("warmup", "Neutral", "Long", CL.custom_sec:format(CL.spawned:format(name), 10), 175516)
			mobcount = 0
		end
	end
end

do
	local prev = nil
	local preva = 0
	function mod:UNIT_SPELLCAST_SUCCEEDED(_, _, _, _, spellGUID, spellId)
		if spellId == 199179 and spellGUID ~= prev then
			prev = spellGUID
			self:Message(199179, "Important", "Alarm")
		end
	end
end

function mod:LightningBreath(args)
	self:Message(args.spellId, "Urgent", "Long")
	self:CDBar(args.spellId, 15.9)
end

function mod:EyeOfTheStormOrSanctify(args)
	self:Message(args.spellId, "Urgent", "Long")
	self:StopBar(192288)
end

function mod:SanctifySuccess(args)
	self:CDBar(args.spellId, 25.3)
	self:CDBar(192288, 7)
end

function mod:SearingLight(args)
	self:CDBar(args.spellId, 7)
	self:Message(args.spellId, "Urgent", self:Interrupter() and "Alarm", CL.casting:format(args.spellName))
end

function mod:EyeoftheStormSuccess(args)
	self:CDBar(args.spellId, 27.5)
end

function mod:Sever(args)
	self:Message(args.spellId, "Important", "Alarm")
	self:CDBar(args.spellId, 12.5)
end


function mod:CallAncestor(args)
		self:Message(args.spellId, "Info", "Alert")
		self:CDBar(args.spellId, 25.5)
end

do
	local prev = 0
	local function printTarget(self, name, guid)
		local t = GetTime()
		if self:Me(guid) then
			prev = t
			self:TargetMessage(198962, name, "Personal", "Bam")
			self:Say(198962)
		elseif t-prev > 1.5 then
			prev = t
			self:TargetMessage(198962, name, "Info", "Alert")
		end
	end
	function mod:ValarjarRunecarver(args)
		self:GetUnitTarget(printTarget, 0.1, args.sourceGUID)
	end
end

do
	local prev = 0
	local function printTarget(self, name, guid)
		local t = GetTime()
		if self:Me(guid) then
			prev = t
			self:TargetMessage(199674, name, "Personal", "Bam")
			self:Say(199674)
		elseif t-prev > 1.5 then
			prev = t
			self:TargetMessage(199674, name, "Info", "Alert")
		end
	end
	function mod:WickedDagger(args)
		self:CDBar(args.spellId, 13)
		self:GetUnitTarget(printTarget, 0.1, args.sourceGUID)
	end
end

function mod:UnrulyYell(args)
	self:Message(args.spellId, "Important", "Alarm")
	
    local unit = self:GetUnitIdByGUID(args.sourceGUID)
    local raidIndex = unit and GetRaidTargetIndex(unit)
    if raidIndex and raidIndex > 0 then
        self:CDBar(199726, 20, CL.other:format(self:SpellName(199726), mark["{rt" .. raidIndex .. "}"]), 199726)
		return
    end
    for i = 1, 8 do
        if self:BarTimeLeft(CL.count:format(self:SpellName(199726), i)) < 1 then
            self:Bar(199726, 20, CL.count:format(self:SpellName(199726), i))
            break
        end
    end	
end

function mod:PenetratingShot(args)
	self:Message(199210, "Important", "Alarm")
end

do
	local prev = nil
	function mod:UNIT_SPELLCAST_START(_, unit, _, _, spellGUID, spellId)
		if spellId == 199210 and spellGUID ~= prev then
			prev = spellGUID
			self:Message(199210, "Important", "Long")
			local unit = self:GetUnitIdByGUID(UnitGUID(unit))
			local raidIndex = unit and GetRaidTargetIndex(unit)
			if raidIndex and raidIndex > 0 then
				self:CDBar(199210, 19, CL.other:format(self:SpellName(199210), mark["{rt" .. raidIndex .. "}"]), 199210)
				return
			end
			for i = 1, 8 do
				if self:BarTimeLeft(CL.count:format(self:SpellName(199210), i)) < 1 then
					self:Bar(199210, 19, CL.count:format(self:SpellName(199210), i))
					break
				end
			end
		end	
	end
end

function mod:Casts(args)
	self:Message(args.spellId, "Important", "Alarm")
end

do
	local function printTarget(self, name, guid)
		if self:Me(guid) then
			self:Message(199805, "Urgent", "Warning", CL.you:format(self:SpellName(199805)))
			self:Say(199805)
		end
	end

	function mod:CrackleCast(args)
		self:GetUnitTarget(printTarget, 0.1, args.sourceGUID)
	end
end

function mod:ProtectiveShield(args)
	self:Message(args.spellId, "Attention", self:Dispeller("magic", true, args.spellId) and "Info", CL.on:format(self:SpellName(182405), args.sourceName)) -- Shield
end

function mod:Thunderstrike(args)
	if self:Me(args.destGUID) then
		local _, _, duration = self:UnitDebuff("player", args.spellId) -- Random lengths
		self:SayCountdown(215430, duration, 8, 2)
		self:Bar(215430, duration or 3)
		self:OpenProximity(215430, 8)
		self:Say(215430)
		self:Flash(215430)
		self:TargetMessage(args.spellId, args.destName, "Personal", "Sonar")
	elseif not self:Me(args.destGUID) then
		self:TargetMessage(args.spellId, args.destName, "Personal", "Warning")
	end
end

function mod:ThunderstrikeRemoved(args)
	if self:Me(args.destGUID) then
		self:CloseProximity(args.spellId)
	end
end

do
	local prev = 0
	function mod:GroundEffectDamage(args)
		if self:Me(args.destGUID) then
			local t = GetTime()
			if t-prev > 1.5 then
				prev = t
				self:Message(199805, "Personal", "Alert", CL.underyou:format(args.spellName))
			end
		end
	end
end


function mod:MugofMead(args)
	if self:Me(args.destGUID) then
		self:Say(202285)
	end
	self:Message(202285, "Positive", "Info", CL.on:format(self:SpellName(202285), self:ColorName(args.sourceName)))
end

local function sendChatMessage(msg, english)
	local inInstance, instanceType = IsInInstance()
	if inInstance and instanceType == "raid" then
		BigWigsLoader.SendChatMessage(english and ("[LittleWigs] %s / %s"):format(msg, english) or ("[LittleWigs] %s"):format(msg), IsInGroup(2) and "INSTANCE_CHAT" or "RAID")
	elseif IsInGroup() then
		BigWigsLoader.SendChatMessage(english and ("[LittleWigs] %s / %s"):format(msg, english) or ("[LittleWigs] %s"):format(msg), IsInGroup(2) and "INSTANCE_CHAT" or "PARTY")
	end
end

function mod:CHAT_MSG_PARTY_LEADER(_, msg, _, _, _, target)
	if msg:find(L.Start) and self:GetOption("custom_off_multiple_kings") then
		SelectGossipOption(1, "", true)
		SelectGossipOption(1)
	elseif msg:find(L.Check) and self:GetOption("custom_off_multiple_kings") then
		sendChatMessage(L.Reply)
	elseif msg:find(L.Check) and not self:GetOption("custom_off_multiple_kings") then
		sendChatMessage(L.Function)
	end
end

function mod:CHAT_MSG_RAID_LEADER(_, msg, _, _, _, target)
	if msg:find(L.Start) and self:GetOption("custom_off_multiple_kings") then
		SelectGossipOption(1, "", true)
		SelectGossipOption(1)
	elseif msg:find(L.Check) and self:GetOption("custom_off_multiple_kings") then
		sendChatMessage(L.Reply)
	elseif msg:find(L.Check) and not self:GetOption("custom_off_multiple_kings") then
		sendChatMessage(L.Function)
	end
end

hooksecurefunc("GossipTitleButton_OnClick", function()
	if UnitIsGroupLeader("player") or UnitIsGroupAssistant("player") then
		mod:Sync("kings")
	end
end)

function mod:BigWigs_BossComm(_, msg, data, sender)
	if msg == "kings" and GetGossipOptions() then
		SelectGossipOption(1, "", true)
		SelectGossipOption(1)
	end
end

do
	local autoTalk = {
		[97081] = true, -- King Bjorn
		[95843] = true, -- King Haldor
		[97083] = true, -- King Ranulf
		[97084] = true, -- King Tor
	}

	function mod:GOSSIP_SHOW()
		local mobId = self:MobId(UnitGUID("npc"))
		if self:GetOption("custom_on_autotalk") and not self:GetOption("custom_off_multiple_kings") and autoTalk[mobId] then
			if GetGossipOptions() then
				SelectGossipOption(1)
			end
		elseif GetGossipOptions() and self:GetOption("custom_off_multiple_kings") and autoTalk[mobId] then
			sendChatMessage(L.Kings:format(self:UnitName("target")))
			if UnitIsGroupLeader("player") then
local btn = CreateFrame("Button", nil, GossipFrame, "UIPanelButtonTemplate")
btn:SetPoint("TOPLEFT", 0, -12)
btn:SetSize(100, 40)
btn:SetText("Ready check")
btn:SetScript("OnClick", function(self, button, down)
    DoReadyCheck()
end)
btn:RegisterForClicks("AnyDown")

local pullBtn = CreateFrame("Button", "!pull", GossipFrame, "UIPanelButtonTemplate")
pullBtn:SetSize(100, 40)
pullBtn:SetPoint("TOPRIGHT", 0, -12)
pullBtn:SetText("!pull")
pullBtn:SetScript("OnClick", function(self, button, down)
    SendChatMessage("!pull", "PARTY")
    btn:Hide()
    pullBtn:Hide()
end)
pullBtn:RegisterForClicks("AnyDown")
pullBtn.text:SetPoint("CENTER")
pullBtn.text:SetText("!pull")
			end
		end
	end
end

function mod:KingsDeath(args)
	local GodKingSkovaldMod = BigWigs:GetBossModule("God-King Skovald", true)
	if GodKingSkovaldMod then
		GodKingSkovaldMod:Enable()
	end
end

function mod:OlmyrSolstenDeath(args)
	local mobId = self:MobId(args.destGUID)
	mobcount = mobcount + 1
	if mobcount > 1 then
		self:Bar("warmup", 10, CL.active, 175516)
	end
	if mobId == 97202 then
		self:StopBar(192288)
		self:StopBar(192158)
	elseif mobId == 97219 then 
		self:StopBar(191976)
		self:StopBar(200901)
	end
end
