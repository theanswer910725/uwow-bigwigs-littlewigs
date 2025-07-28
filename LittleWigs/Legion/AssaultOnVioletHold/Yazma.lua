

--------------------------------------------------------------------------------
-- Module Declaration
--
local mod, CL = BigWigs:NewBoss("===>>>>  PARTY INFO  <<<<===", 1712)
if not mod then return end

-- Localization
--
local timerdiff = 0
local timerdungeon = 0

local L = mod:GetLocale()
if L then
	L.custom_on_autokeystone = "Automatic key start when the timer hits zero."
	L.custom_on_autokeystone_desc = "It works with Exorsus Raid Tools and Big Wigs timers."
	L.custom_on_autosave =  "Auto-save after receiving loot (no more than once every 20 seconds)."
	L.custom_on_announcement = "|cff00ff00Enable|r/|cffff0000disable|r all group announcement"
	L.WarlockPets = "Warlock Pets (Interrupt, dispell)"
	L.Bloodlust = "Bloodlust (or similar effects)"
	L.Portals = "Mage Portals"
	L.Rituals = "Rituals"
	L.BattleRes = "BattleRes"
	L.Reaves = "Repair, Reincarnation"
	L.difficulty = "|cffff00ff[LittleWigs]|r|cff00ff00 You can reset instances |r|cffff0000(all players outside the dungeon)|r"
	L.diff = "|cffff00ff[LittleWigs]|r|cff00ff00 Dungeon Difficulty set to Mythic |r"
	L.chatdiff = "Dungeon Difficulty set to Mythic"
	L.chatdiffRW = "[LittleWigs] Dungeon Difficulty set to Mythic"
	L.refresh = "|cff00ff00 Announcement for refresh the difficulty |r|cffff0000(for group leader)|r"
end

--------------------------------------------------------------------------------
-- Initialization
--


function mod:GetOptions()
	return {
	"custom_on_autokeystone",
	"custom_on_autosave",
	"custom_on_announcement",
	{688, "SAY"}, {691, "SAY"}, {157757, "SAY"}, {80353, "SAY"}, {32182, "SAY"}, {230935, "SAY"}, {90355, "SAY"}, {2825, "SAY"}, {160452, "SAY"}, {10059, "SAY"}, {11416, "SAY"}, {11419, "SAY"}, {32266, "SAY"}, {49360, "SAY"}, {11417, "SAY"}, {11418, "SAY"}, {11420, "SAY"}, {32267, "SAY"}, {49361, "SAY"}, {33691, "SAY"}, {53142, "SAY"}, {88345, "SAY"}, {88346, "SAY"}, {132620, "SAY"}, {132626, "SAY"}, {176246, "SAY"}, {176244, "SAY"}, {224871, "SAY"}, {29893, "SAY"}, {43987, "SAY"}, {190336, "SAY"}, {175215, "SAY"}, {188036, "SAY"}, {201352, "SAY"}, {201351, "SAY"}, {185709, "SAY"}, {59782, "SAY"}, {7720, "SAY"}, {698, "SAY"}, {111771, "SAY"}, {95750, "SAY"}, {20484, "SAY"}, {61999, "SAY"}, {126393, "SAY"}, {159931, "SAY"}, {159956, "SAY"}, {21169, "SAY"}, {20707, "SAY"}, {67826, "SAY"}, {199109, "SAY"}, {199115, "SAY"},
	"stages",
	}, {
	["custom_on_announcement"] = "general",
	[688] = L.WarlockPets,
	[80353] = L.Bloodlust,
	[10059] = L.Portals,
	[29893] = L.Rituals,
	[95750] = L.BattleRes,
	[67826] = L.Reaves,
	["stages"] = L.refresh
	}
end

function mod:OnBossEnable()
	self:Log("SPELL_CAST_SUCCESS", "InstantCasts", 698, 688, 691, 157757, 80353, 32182, 230935, 90355, 2825, 160452, 10059, 11416, 11419, 32266, 49360, 11417, 11418, 11420, 32267, 49361, 33691, 53142, 88345, 88346, 132620, 132626, 176246, 176244, 224871, 29893, 43987, 190336, 111771, 67826, 199109, 199115, 21169)
	self:Log("SPELL_CAST_START", "Sum", 59782, 7720)
	self:Log("SPELL_AURA_APPLIED", "SoulStone", 20707)
	self:Log("SPELL_CREATE", "Create", 175215, 188036, 201352, 201351, 185709)
	self:Log("SPELL_RESURRECT", "Ressurect", 95750, 20484, 61999, 126393, 159931, 159956)
	self:RegisterEvent("CHAT_MSG_PARTY_LEADER", "PullERT")
	self:RegisterEvent("CHAT_MSG_RAID_LEADER", "PullERT")
	self:RegisterEvent("CHAT_MSG_PARTY", "PullERT")
	self:RegisterEvent("CHAT_MSG_RAID", "PullERT")
	self:RegisterEvent("CHAT_MSG_RAID_WARNING", "PullERT")
	self:RegisterEvent("PLAYER_STARTED_MOVING", "checkdungeon")
	self:RegisterEvent("LOADING_SCREEN_DISABLED", "checkdungeon")
	self:RegisterMessage("BigWigs_PluginComm")
end

--------------------------------------------------------------------------------
-- Event Handlers
--

function mod:StartPull()
	if nil ~= C_ChallengeMode.GetSlottedKeystoneInfo() then
		C_ChallengeMode.StartChallengeMode()
		ChallengesKeystoneFrame:Hide()
	end
end

function mod:BigWigs_PluginComm(_, msg, seconds, sender)
	local inInstance, instanceType = IsInInstance()
	if msg == "Pull" and sender == self:UnitName("player") and GetDungeonDifficultyID() == 23 and inInstance and self:GetOption("custom_on_autokeystone") then
		seconds = tonumber(seconds)
		if seconds == 0 then
			self:CancelTimer(PullTimer)
		else
			self:CancelTimer(PullTimer)
			PullTimer = self:ScheduleTimer("StartPull", seconds)
		end
	end
end

function mod:PullERT(_, msg, guid)
	local inInstance, instanceType = IsInInstance()
	local name = select(1,strsplit("-",guid))
	if name == self:UnitName("player") and GetDungeonDifficultyID() == 23 and inInstance and self:GetOption("custom_on_autokeystone") and (msg == ">>> Атака <<<" or msg == ">>> Pull <<<" or msg == ">>> 开始战斗 <<<" or msg == ">>> 전투 시작 <<<" or msg == ">>> 開怪 <<<")then
		if nil ~= C_ChallengeMode.GetSlottedKeystoneInfo() then
			C_ChallengeMode.StartChallengeMode()
			ChallengesKeystoneFrame:Hide()
		end
	end
end

--------------------------------------------------------------

local needsave = -1;
local lastsave = 0;
local autosave = false
local AutoSaveOnLoot = function(self,event,...)
	if event == "CHAT_MSG_LOOT" and autosave then
        local lootstring, _, _, _, player = ...
        local itemLink = string.match(lootstring,"|%x+|Hitem:.-|h.-|h|r")
        local itemString = string.match(itemLink, "item[%-?%d:]+")
        local _, _, quality, _, _, class, subclass, _, equipSlot, texture, _, ClassID, SubClassID = GetItemInfo(itemString)
		if GetNormalizedRealmName() == "legionx5" or GetNormalizedRealmName() == "uwowx100" or GetNormalizedRealmName() == "uwowfun" or GetNormalizedRealmName() == "epicx1" or GetNormalizedRealmName() == "legionplusx1" then
			if UnitName("player") == player then
				needsave = GetTime()+1;
			elseif event == "TRADE_CLOSED" then
				needsave = GetTime()+1;
			end
		end
	end
	if event == "CHAT_MSG_SYSTEM" then
		local msg = ...
		if ((string.find(msg, 'Подземелье') and string.find(msg, 'обновлено')) or (string.find(msg, 'has been reset'))) and GetDungeonDifficultyID() == 8 then
			SetDungeonDifficultyID(23)
		end
	end
end

local AutoSaveOnUpdate = function(self)
	if needsave ~=-1 and needsave < GetTime() and lastsave+22 < GetTime() then
		SendChatMessage(".save" ,"GUILD" ,nil ,nil);
		lastsave = GetTime();
		needsave = -1;
	end
end

local AutoSaveOnLootFrame = CreateFrame("Frame");
AutoSaveOnLootFrame:RegisterEvent("CHAT_MSG_LOOT");
AutoSaveOnLootFrame:RegisterEvent("TRADE_CLOSED");
AutoSaveOnLootFrame:RegisterEvent("CHAT_MSG_SYSTEM");
AutoSaveOnLootFrame:SetScript("OnEvent", AutoSaveOnLoot);
AutoSaveOnLootFrame:SetScript("OnUpdate", AutoSaveOnUpdate);
AutoSaveOnLootFrame:Show();

--------------------------------------------------------------

function mod:raidsay()
	if IsInRaid() then
		SendChatMessage(L.chatdiffRW ,"RAID_WARNING" ,nil ,nil)
		self:CancelTimer(timer)
		self:CancelTimer(timerdiff)
		self:CancelTimer(timerdungeon)
	else
		SendChatMessage(L.chatdiffRW ,"PARTY" ,nil ,nil)
		self:CancelTimer(timer)
		self:CancelTimer(timerdiff)
		self:CancelTimer(timerdungeon)
	end
end

local function sendChatMessage(msg, english)
	local inInstance, instanceType = IsInInstance()
	if inInstance and instanceType == "raid" then
		BigWigsLoader.SendChatMessage(english and ("[LittleWigs] %s / %s"):format(msg, english) or ("[LittleWigs] %s"):format(msg), IsInGroup(2) and "INSTANCE_CHAT" or "RAID")
	elseif IsInGroup() then
		BigWigsLoader.SendChatMessage(english and ("[LittleWigs] %s / %s"):format(msg, english) or ("[LittleWigs] %s"):format(msg), IsInGroup(2) and "INSTANCE_CHAT" or "PARTY")
	end
end


function mod:checkdungeon()
	local diff = GetDungeonDifficultyID()
	local inInstance, instanceType = IsInInstance()
	local timer = 0
	if diff == 8 and UnitIsGroupLeader("player") and inInstance == false then
		if timer == 0 then
		timer = self:ScheduleTimer("check", 5)
		end
	elseif diff == 23 or inInstance == true or UnitIsGroupLeader("player") == false then
		self:CancelTimer(timer)
		self:CancelTimer(timerdiff)
		self:CancelTimer(timerdungeon)
	end
	if self:GetOption("custom_on_autosave") and not autosave then
		autosave = true
	elseif not self:GetOption("custom_on_autosave") and autosave then
		autosave = false
	end
end
	
function mod:checkdiff()
	local timerdiff = 0
	local diff = GetDungeonDifficultyID()
	timerdiff = self:ScheduleTimer("checkdiff", 1)
	if diff == 23 and UnitIsGroupLeader("player") then
		self:Message("stages", "Positive", "Info", L.diff, 8553)
		if IsInRaid() then
			self:ScheduleTimer("raidsay", 0)
			self:CancelTimer(timerdiff)
			self:CancelTimer(timerdungeon)
		else
			sendChatMessage(L.chatdiff)
			self:CancelTimer(timerdiff)
			self:CancelTimer(timerdungeon)
		end
	end
end

function mod:check()
	local inInstance, instanceType = IsInInstance()
	local diff = GetDungeonDifficultyID()
	local t = GetTime()
	local timerdungeon = 0
	self:CancelTimer(timer)
	timer = self:ScheduleTimer("check", 1)
	if diff == 8 and UnitIsGroupLeader("player") and inInstance == false then
		local group = UnitInRaid("player") and "raid" or UnitInParty("player") and "party"
		local members = GetNumGroupMembers()
		local t = GetTime()
		for i = 1, members, 1 do
			local member = group..tostring(i)
			local dungeon = select(4,UnitPosition(member))
			if (dungeon == 1456 and dungeon == 1458 and dungeon == 1466 and dungeon == 1477 and dungeon == 1492 and dungeon == 1493 and dungeon == 1501 and dungeon == 1516 and dungeon == 1544 and dungeon == 1571 and dungeon == 1651 and dungeon == 1677 and dungeon == 1753 and dungeon == 1520 and dungeon == 1530 and dungeon == 1648 and dungeon == 1676 and dungeon == 1712 and dungeon == 1279 and dungeon == 1208 and dungeon == 1176) == false then
				if timerdungeon == 0 then
					timerdungeon = self:ScheduleTimer("notindungeon", 2.5)
				end
			end
			if (dungeon == 1456 or dungeon == 1458 or dungeon == 1466 or dungeon == 1477 or dungeon == 1492 or dungeon == 1493 or dungeon == 1501 or dungeon == 1516 or dungeon == 1544 or dungeon == 1571 or dungeon == 1651 or dungeon == 1677 or dungeon == 1753 or dungeon == 1520 or dungeon == 1530 or dungeon == 1648 or dungeon == 1676 or dungeon == 1712 and dungeon == 1279 and dungeon == 1208 and dungeon == 1176) == true then
				self:CancelTimer(timerdungeon)
			end
		end	
	elseif diff == 23 or inInstance == true or UnitIsGroupLeader("player") == false then
		self:CancelTimer(timer)
		self:CancelTimer(timerdiff)
		self:CancelTimer(timerdungeon)
	end
end

do
	local prev = 0
	function mod:notindungeon()
		local t = GetTime()
		if t-prev > 60 then
			prev = t
			StaticPopup_Show("CONFIRM_RESET_INSTANCES")
			self:Message("stages", "Positive", "Long", L.difficulty, 8553)
			print(L.difficulty)
			timerdiff = self:ScheduleTimer("checkdiff", 0)
		end
	end
end


function mod:Sum(args)
	if self:GetOption("custom_on_announcement") then
		if self:Me(args.sourceGUID) and self:CheckOption(args.spellId, "SAY") then
			sendChatMessage(CL.on:format(CL.casting:format(args.spellName), UnitName("target")))
		end
	end
end

function mod:InstantCasts(args)
	local spellId = args.spellId
	if (UnitInParty(args.sourceName) or UnitInRaid(args.sourceName)) and self:GetOption("custom_on_announcement") then
		if self:Me(args.sourceGUID) and self:CheckOption(args.spellId, "SAY") then
			if spellId == 698 then
				sendChatMessage(CL.casting:format(args.spellName))
			else
				sendChatMessage(args.spellName)
			end
		end
		self:TargetMessage(args.spellId, self:ColorName(args.sourceName), "Positive", "Long", nil, nil, true)
	end
end

function mod:Create(args)
	if (UnitInParty(args.sourceName) or UnitInRaid(args.sourceName)) and self:GetOption("custom_on_announcement") then
		if self:Me(args.sourceGUID) and self:CheckOption(args.spellId, "SAY") then
			sendChatMessage(args.spellName)
		end
		self:TargetMessage(args.spellId, self:ColorName(args.sourceName), "Positive", "Long", nil, nil, true)
	end
end

function mod:SoulStone(args)
	if (UnitInParty(args.sourceName) or UnitInRaid(args.sourceName)) and self:GetOption("custom_on_announcement") then
		if self:Me(args.sourceGUID) and self:CheckOption(args.spellId, "SAY") then
			sendChatMessage(CL.on:format(args.spellName, args.destName))
		end
		self:TargetMessage(args.spellId, args.destName, "Positive", "Long")
	end
end

function mod:Ressurect(args)
	local spellId = args.spellId
	if (UnitInParty(args.sourceName) or UnitInRaid(args.sourceName)) and self:GetOption("custom_on_announcement") then
		if self:Me(args.sourceGUID) and self:CheckOption(args.spellId, "SAY") then
			sendChatMessage(CL.on:format(args.spellName, args.destName))
		end
		self:TargetMessage(args.spellId, args.destName, "Positive", "Long")
	end
end

local function msg(...)
    print("|cffff0000Uwow:|r |cffff00ffLittleWigs|r |cffff0000[|r|cff00ff00Modded by|r |cFFA330C9Энелрила|r|cffff0000]|r",...)
end
msg("|cFF00D1FF - Loaded version 38 |r")
local debug_enabled = false
local function debug(...)
  if debug_enabled then
  end
end

CinematicFrame:HookScript("OnShow", function(self, ...)
  debug("CinematicFrame:OnShow",...)
  if IsModifierKeyDown() then return end
  CinematicFrame_CancelCinematic()
end)

local omfpf = _G["MovieFrame_PlayMovie"]
_G["MovieFrame_PlayMovie"] = function(...)
  debug("MovieFrame_PlayMovie",...)
  if IsModifierKeyDown() then return omfpf(...) end
  GameMovieFinished()
  return true
end



local f = CreateFrame("Frame")

function f:OnEvent(event, addon)
	if addon == "Blizzard_TalkingHeadUI" then
		hooksecurefunc("TalkingHeadFrame_PlayCurrent", function()
			zoneName = GetSubZoneText();
			if zoneName ~= "Temple of Fal'adora" and
			   zoneName ~= "Falanaar Tunnels" and
			   zoneName ~= "Shattered Locus" then
				TalkingHeadFrame_CloseImmediately()
			end
		end)
	self:UnregisterEvent(event)
	end
end

f:RegisterEvent("ADDON_LOADED")
f:SetScript("OnEvent", f.OnEvent)


local AutoKeystone = CreateFrame("Frame")

function AutoKeystone:OnEvent(event, addon)
	if (addon == "Blizzard_ChallengesUI") then
		if ChallengesKeystoneFrame then
			ChallengesKeystoneFrame:HookScript("OnShow", self.OnShow)
			
			self:UnregisterEvent(event)
		end
	end
end

function AutoKeystone:OnShow()
	for container=BACKPACK_CONTAINER, NUM_BAG_SLOTS do
		local slots = GetContainerNumSlots(container)
		for slot=1, slots do
			local _, _, _, _, _, _, slotLink, _, _, slotItemID = GetContainerItemInfo(container, slot)
			if slotLink and slotLink:match("|Hkeystone:") then
				PickupContainerItem(container, slot)
				if (CursorHasItem()) then
					C_ChallengeMode.SlotKeystone()
				end
			end
		end
	end
end

AutoKeystone:RegisterEvent("ADDON_LOADED")
AutoKeystone:SetScript("OnEvent", AutoKeystone.OnEvent)

local remap = {
	CONFIRM_LOOT_ROLL = "CONFIRM_ROLL",
	CONFIRM_DISENCHANT_ROLL = "CONFIRM_ROLL",
	LOOT_BIND_CONFIRM = "LOOT_BIND_CONFIRM",
}

local f = CreateFrame("Frame")

function f:OnEvent(event, ...)
	self[remap[event]](self, ...)
end

for k in pairs(remap) do
	f:RegisterEvent(k)
end

f:SetScript("OnEvent", f.OnEvent)

function f:CONFIRM_ROLL(id, lootType)
	ConfirmLootRoll(id, lootType)
	StaticPopup_Hide("CONFIRM_LOOT_ROLL")
end

local checkList = {}

function f:OnUpdate(elapsed)
	for slot in pairs(checkList) do
		LootSlot(slot)
		ConfirmLootSlot(slot)
	end
	wipe(checkList)
	StaticPopup_Hide("LOOT_BIND")
	self:SetScript("OnUpdate", nil)
end

function f:LOOT_BIND_CONFIRM(slot)
	if not checkList[slot] then
		checkList[slot] = true
		StaticPopup_Hide("LOOT_BIND")
		self:SetScript("OnUpdate", self.OnUpdate)
	end
end
----------------------------------------------------------------
local i = CreateFrame("Frame")
i:RegisterEvent("PLAYER_ENTERING_WORLD")
i:RegisterEvent("ZONE_CHANGED_NEW_AREA")
i:RegisterEvent("ZONE_CHANGED_INDOORS")
i:RegisterEvent("ZONE_CHANGED")
i:RegisterEvent("PLAYER_STARTED_MOVING")
i:RegisterEvent("PLAYER_DIFFICULTY_CHANGED")
i:SetScript("OnEvent", 
  function(self, event, ...)
	local mapID = select(8,GetInstanceInfo())
    if event == "PLAYER_ENTERING_WORLD" then
      local partyinfoMod = BigWigs:GetBossModule("===>>>>  PARTY INFO  <<<<===", true)
	  partyinfoMod:Enable()
	  i:UnregisterEvent("PLAYER_ENTERING_WORLD")
	  SetCVar("scriptErrors", 0)
	elseif event == "ZONE_CHANGED_NEW_AREA" then
      local partyinfoMod = BigWigs:GetBossModule("===>>>>  PARTY INFO  <<<<===", true)
	  partyinfoMod:Enable()
	elseif event == "ZONE_CHANGED_INDOORS" then
      local partyinfoMod = BigWigs:GetBossModule("===>>>>  PARTY INFO  <<<<===", true)
	  partyinfoMod:Enable()
	elseif event == "ZONE_CHANGED" then
      local partyinfoMod = BigWigs:GetBossModule("===>>>>  PARTY INFO  <<<<===", true)
	  partyinfoMod:Enable()
	 elseif event == "PLAYER_STARTED_MOVING" and mapID == 1477 then
      local partyinfoMod = BigWigs:GetBossModule("===>>>>  PARTY INFO  <<<<===", true)
	  partyinfoMod:Enable()
	  local trashMod = BigWigs:GetBossModule("Halls of Valor Trash", true)
	  trashMod:Enable()
	elseif event == "PLAYER_STARTED_MOVING" then
      local partyinfoMod = BigWigs:GetBossModule("===>>>>  PARTY INFO  <<<<===", true)
	  partyinfoMod:Enable()
	  end
    end
)