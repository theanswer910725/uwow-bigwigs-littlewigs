

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
	L.custom_on_autoRIO = "Automatic RIO check (.ch) if write to you personally"
	L.custom_on_autoRIO_desc = "Displaying only the name and RIO. No more than one announcement for each individual unit."
	
	L.custom_off_autoRIOfullch = "Disable shortening information about RIO (.ch) if write to you personally"

	L.custom_off_autoRIOlfg = "Automatic RIO check (.ch) when using ONLY IN LFG if they write in PM (required be leader or assistant)"
	L.custom_off_autoRIOlfg_desc = "Displaying only the name and RIO. No more than one announcement for each individual unit."
	
	L.custom_on_autoLFG = "Automatic creation of LFG"
	L.custom_on_autoLFG_desc = "After you link the key to the general chat, an LFG will automatically be opened and filled using the data from the key."
	
	L.KarazhanEvent1 = "[LittleWigs] This week's 'Cauldron'"
	L.KarazhanSequence1 = "|cffff00ff [LittleWigs]|r|cff00ff00 First Boss Events: Cauldron -> Witches -> Toe Knee|r"
	
	L.KarazhanEvent2 = "[LittleWigs] This week's 'Witches'"
	L.KarazhanSequence2 = "|cffff00ff [LittleWigs]|r|cff00ff00 First Boss Events: Witches -> Toe Knee -> Cauldron|r"
	
	L.KarazhanEvent3 = "[LittleWigs] This week's 'Toe Knee'"
	L.KarazhanSequence3 = "|cffff00ff [LittleWigs]|r|cff00ff00 First Boss Events: Toe Knee -> Cauldron -> Witches|r"
	
	L.LeftSideChat = "[LittleWigs] <<<=== The left side"
	L.RightSideChat = "[LittleWigs] The right side ===>>>"
	L.LeftSide = "|cffff00ff [LittleWigs]|r|cff00ff00 <<<=== The left side|r"
	L.RightSide = "|cffff00ff [LittleWigs]|r|cff00ff00 The right side ===>>>|r"


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
	"custom_on_autoRIO",
	"custom_off_autoRIOlfg",
	"custom_off_autoRIOfullch",
	"custom_on_autoLFG",
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
	self:RegisterEvent("LOADING_SCREEN_DISABLED")
	self:RegisterEvent("CHALLENGE_MODE_START", "TheKeyIsRunning")
	
	self:RegisterMessage("BigWigs_PluginComm")
	self:RegisterMessage("BigWigs_BossComm")
	
	self:RegisterEvent("CHAT_MSG_WHISPER", "WHISPERMSG")
	self:RegisterEvent("CHALLENGE_MODE_END", "resetlist")
end

--------------------------------------------------------------------------------
-- Event Handlers
--

local whisperlist = {}
local filterforautocheck = false
function mod:WHISPERMSG(_, msg, guid)
	local name = select(1,strsplit("-",guid))
	local entryInfo = C_LFGList.GetActiveEntryInfo()
	local members = GetNumGroupMembers()
	if ((self:GetOption("custom_on_autoRIO") and not self:GetOption("custom_off_autoRIOlfg")) or (entryInfo and self:GetOption("custom_off_autoRIOlfg") and (UnitIsGroupLeader("player") or UnitIsGroupAssistant("player")))) and not whisperlist[name] and not UnitInParty(name) then
		filterforautocheck = true
		SendChatMessage(".ch "..name,"GUILD" ,nil ,nil);
		self:ScheduleTimer("filtercheck", 0.3)
		whisperlist[name] = true
	end
end

function mod:filtercheck()
	filterforautocheck = false
end

function mod:resetlist()
	wipe(whisperlist)
end

local autoRIOfullch = false
function Filter_System(self, event, ...)
local msg = ...
if filterforautocheck and not autoRIOfullch then
	if (string.find(msg, '->') or string.find(msg, '- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -') or string.find(msg, 'Rank in the ladder')) then return true, ... else return false, ... end
	end
end
ChatFrame_AddMessageEventFilter('CHAT_MSG_SYSTEM', Filter_System)

-----------------------------------------------------------------

local MyKeyInChat
local MyKeyLevelInChat
local autoLFG = false

function FindKeyInChat(self, event, ...)
    local text, playerName = select(1, ...)
    local msg = text:gsub("|", "/")
    
    if not msg:match("Hkeystone") then
        return
    end

	local entryInfo = C_LFGList.GetActiveEntryInfo()
    local playerNameWithoutRealm = strsplit("-", playerName)
    local playerNameExact = UnitName("player")
    local keyStr = msg:match("%: (.-) %(%d+%)%]")
    local keylvlStr = msg:match("Hkeystone:%d+:(%d+):")
	local keyid = tonumber(msg:match("Hkeystone:(%d+):"))
	local members = GetNumGroupMembers()
    if playerNameWithoutRealm == playerNameExact and autoLFG then
        MyKeyInChat = keyStr
        MyKeyLevelInChat = keylvlStr

        if members < 5 and not entryInfo then
            if not GroupFinderFrame:IsVisible() then
                PVEFrame_ShowFrame("GroupFinderFrame")
            end
            GroupFinderFrameGroupButton4:Click()

            C_Timer.After(0.25, function()
                LFGListCategorySelection_SelectCategory(LFGListFrame.CategorySelection, 2, 0)
                LFGListFrame.CategorySelection.StartGroupButton:Click()
                LFGListEntryCreationGroupDropDownButton:Click()
				LFGListFrame.EntryCreation.Name:SetText("+"..MyKeyLevelInChat)
				local buttonMap = {
					[166] = 1,  -- Депо Мрачных Путей
					[168] = 2,  -- Вечное Цветение
					[165] = 3,  -- Некрополь Призрачной Луны
					--[168] = 4,  --
					[197] = 5,  -- Око Азшары
					[198] = 6,  -- Чаща Темного Сердца
					[200] = 7,  -- Чертоги Доблести
					[206] = 8,  -- Логово Нелтариона
					--[168] = 9,  --
					[207] = 10, -- Казематы Стражей
					[199] = 11, -- Крепость Черной Ладьи
					[208] = 12, -- Утроба душ
					[210] = 13, -- Квартал Звезд
					[209] = 14, -- Катакомбы Сурамара
					--[168] = 15, --
                    [227] = 16, -- Возвращение в Каражан: Нижний Ярус
					[234] = 17, -- Возвращение в Каражан: Верхний Ярус
					[233] = 18, -- Собор Вечной Ночи
					[239] = 19, -- Престол Триумвирата
                }
                local buttonIndex = buttonMap[keyid]
                if buttonIndex then
					_G["DropDownList1Button" .. buttonIndex]:Click()
                end
                C_Timer.After(0.25, function()
					
                    local frame = frame or CreateFrame("Frame")
                    frame:SetScript("OnEvent", function(self)
                        self:UnregisterEvent("LFG_LIST_ACTIVE_ENTRY_UPDATE")
                    end)
                    frame:RegisterEvent("LFG_LIST_ACTIVE_ENTRY_UPDATE")
                end)
            end)
        end
    end
end

local frame = CreateFrame("Frame")
frame:RegisterEvent("CHAT_MSG_CHANNEL")
frame:SetScript("OnEvent", FindKeyInChat)

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

local KeyHolderChatAnnounce
local PersonalAnnouncement
local TankPrioAnnouncement

function mod:left()
	self:Message("stages", "Positive", "Long", L.LeftSide, 8553)
	if KeyHolderChatAnnounce or TankPrioAnnouncement then
		SendChatMessage(L.LeftSideChat, "PARTY")
	end
	KeyHolderChatAnnounce = false
	PersonalAnnouncement = false
	TankPrioAnnouncement = false
end

function mod:right()
	self:Message("stages", "Positive", "Long", L.RightSide, 8553)
	if KeyHolderChatAnnounce or TankPrioAnnouncement then
		SendChatMessage(L.RightSideChat, "PARTY")
	end
	KeyHolderChatAnnounce = false
	PersonalAnnouncement = false
	TankPrioAnnouncement = false
end

local function GetActiveSide()
    local poi1 = _G["WorldMapFramePOI1"]
	local poi2 = _G["WorldMapFramePOI2"]
    if poi1 and poi1:IsShown() and poi2 and poi2:IsShown() then
		WorldMapFrame:Hide()
        local poi1X = poi1:GetCenter()
		local poi2X = poi2:GetCenter()
        if poi2X < poi1X then
			C_Timer.After(1, function()
				mod:right()
			end)
            return L.RightSide
        end
		if poi1X < poi2X then
			C_Timer.After(1, function()		
				mod:left()
			end)			
			return L.LeftSide
        end
	else
		C_Timer.After(0.25, function()
			ToggleWorldMap()
			local activeSide = GetActiveSide()
			if activeSide ~= nil then
				print(activeSide)
			end
        end)
		return
    end

    return "Не удалось определить"
end

function mod:TheKeyIsRunning()
	local mapID = select(8, GetInstanceInfo())
	if mapID == 1516 then
		PersonalAnnouncement = true
		if self:Tank() then
			self:Sync("TankPrio")
			TankPrioAnnouncement = true
		end
		if KeyHolderChatAnnounce or PersonalAnnouncement or TankPrioAnnouncement then
			ToggleWorldMap()
			local activeSide = GetActiveSide()
			if activeSide ~= nil then
				print(activeSide)
			end
		end
	end
	wipe(whisperlist)
end

--------------------------------------------------------------------------------------

function mod:LOADING_SCREEN_DISABLED()
    mod:checkdungeon()
end

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
	if self:GetOption("custom_on_autoLFG") and not autoLFG then
		autoLFG = true
	elseif not self:GetOption("custom_on_autoLFG") and autoLFG then
		autoLFG = false
	end
	if self:GetOption("custom_off_autoRIOfullch") and not autoRIOfullch then
		autoRIOfullch = true
	elseif not self:GetOption("custom_off_autoRIOfullch") and autoRIOfullch then
		autoRIOfullch = false
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
msg("|cFF00D1FF - Loaded version 39 |r")
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

-------------------------------------------------------------------------------------------------------------------------

local function isDateInRange(year, month, day, start, finish)
    local startYear, startMonth, startDay = unpack(start)
    local endYear, endMonth, endDay = unpack(finish)

    if year > startYear and year < endYear then
        return true
    elseif year == startYear then
        if month > startMonth or (month == startMonth and day >= startDay) then
            return year < endYear or (year == endYear and (month < endMonth or (month == endMonth and day < endDay)))
        end
    elseif year == endYear then
        if month < endMonth or (month == endMonth and day < endDay) then
            return year > startYear or (year == startYear and (month > startMonth or (month == startMonth and day >= startDay)))
        end
    end
    return false
end

local function checkStoryPeriods(thisYear, thisMonth, thisDay, storyPeriods)
    for _, period in ipairs(storyPeriods) do
        if isDateInRange(thisYear, thisMonth, thisDay, {period[1], period[2], period[3]}, {period[4], period[5], period[6]}) then
            return true
        end
    end
    return false
end

local KarazhanFirstBoss = nil
local KarazhanFirstBossSequence = nil
local function ManageCalendar()
    local _, thisMonth, thisDay, thisYear = CalendarGetDate()

    local beautiful_beast_story = {
		{2025, 7, 30, 2025, 8, 6},
		{2025, 8, 20, 2025, 8, 27},
		{2025, 9, 10, 2025, 9, 17},
		{2025, 10, 1, 2025, 10, 8},
		{2025, 10, 22, 2025, 10, 29},
		{2025, 11, 12, 2025, 11, 19},
		{2025, 12, 3, 2025, 12, 10},
		{2025, 12, 24, 2025, 12, 31},
		{2026, 1, 14, 2026, 1, 21},
		{2026, 2, 4, 2026, 2, 11},
		{2026, 2, 25, 2026, 3, 4},
		{2026, 3, 18, 2026, 3, 25},
		{2026, 4, 8, 2026, 4, 15},
		{2026, 4, 29, 2026, 5, 6},
		{2026, 5, 20, 2026, 5, 27},
		{2026, 6, 10, 2026, 6, 17},
		{2026, 7, 1, 2026, 7, 8},
		{2026, 7, 22, 2026, 7, 29},
		{2026, 8, 12, 2026, 8, 19},
		{2026, 9, 2, 2026, 9, 9},
		{2026, 9, 23, 2026, 9, 30},
		{2026, 10, 14, 2026, 10, 21},
		{2026, 11, 4, 2026, 11, 11},
		{2026, 11, 25, 2026, 12, 2},
		{2026, 12, 16, 2026, 12, 23},
		{2027, 1, 6, 2027, 1, 13},
		{2027, 1, 27, 2027, 2, 3},
		{2027, 2, 17, 2027, 2, 24},
		{2027, 3, 10, 2027, 3, 17},
		{2027, 3, 31, 2027, 4, 7},
		{2027, 4, 21, 2027, 4, 28},
		{2027, 5, 12, 2027, 5, 19},
		{2027, 6, 2, 2027, 6, 9},
		{2027, 6, 23, 2027, 6, 30},
		{2027, 7, 14, 2027, 7, 21},
		{2027, 8, 4, 2027, 8, 11},
		{2027, 8, 25, 2027, 9, 1},
		{2027, 9, 15, 2027, 9, 22},
		{2027, 10, 6, 2027, 10, 13},
		{2027, 10, 27, 2027, 11, 3},
		{2027, 11, 17, 2027, 11, 24},
		{2027, 12, 8, 2027, 12, 15},
		{2027, 12, 29, 2028, 1, 5},
		{2028, 1, 19, 2028, 1, 26},
		{2028, 2, 9, 2028, 2, 16},
		{2028, 3, 1, 2028, 3, 8},
		{2028, 3, 22, 2028, 3, 29},
		{2028, 4, 12, 2028, 4, 19},
		{2028, 5, 3, 2028, 5, 10},
		{2028, 5, 24, 2028, 5, 31},
		{2028, 6, 14, 2028, 6, 21},
		{2028, 7, 5, 2028, 7, 12},
		{2028, 7, 26, 2028, 8, 2},
		{2028, 8, 16, 2028, 8, 23},
		{2028, 9, 6, 2028, 9, 13},
		{2028, 9, 27, 2028, 10, 4},
		{2028, 10, 18, 2028, 10, 25},
		{2028, 11, 8, 2028, 11, 15},
		{2028, 11, 29, 2028, 12, 6},
		{2028, 12, 20, 2028, 12, 27},
		{2029, 1, 10, 2029, 1, 17},
		{2029, 1, 31, 2029, 2, 7},
		{2029, 2, 21, 2029, 2, 28},
		{2029, 3, 14, 2029, 3, 21},
		{2029, 4, 4, 2029, 4, 11},
		{2029, 4, 25, 2029, 5, 2},
		{2029, 5, 16, 2029, 5, 23},
		{2029, 6, 6, 2029, 6, 13},
		{2029, 6, 27, 2029, 7, 4},
		{2029, 7, 18, 2029, 7, 25},
		{2029, 8, 8, 2029, 8, 15},
		{2029, 8, 29, 2029, 9, 5},
		{2029, 9, 19, 2029, 9, 26},
		{2029, 10, 10, 2029, 10, 17},
		{2029, 10, 31, 2029, 11, 7},
		{2029, 11, 21, 2029, 11, 28},
		{2029, 12, 12, 2029, 12, 19},
		{2030, 1, 2, 2030, 1, 9},
		{2030, 1, 23, 2030, 1, 30},
		{2030, 2, 13, 2030, 2, 20},
		{2030, 3, 6, 2030, 3, 13},
		{2030, 3, 27, 2030, 4, 3},
		{2030, 4, 17, 2030, 4, 24},
		{2030, 5, 8, 2030, 5, 15},
		{2030, 5, 29, 2030, 6, 5},
    }

    local westfall_story = {
		{2025, 8, 6, 2025, 8, 13},
		{2025, 8, 27, 2025, 9, 3},
		{2025, 9, 17, 2025, 9, 24},
		{2025, 10, 8, 2025, 10, 15},
		{2025, 10, 29, 2025, 11, 5},
		{2025, 11, 19, 2025, 11, 26},
		{2025, 12, 10, 2025, 12, 17},
		{2025, 12, 31, 2026, 1, 7},
		{2026, 1, 21, 2026, 1, 28},
		{2026, 2, 11, 2026, 2, 18},
		{2026, 3, 4, 2026, 3, 11},
		{2026, 3, 25, 2026, 4, 1},
		{2026, 4, 15, 2026, 4, 22},
		{2026, 5, 6, 2026, 5, 13},
		{2026, 5, 27, 2026, 6, 3},
		{2026, 6, 17, 2026, 6, 24},
		{2026, 7, 8, 2026, 7, 15},
		{2026, 7, 29, 2026, 8, 5},
		{2026, 8, 19, 2026, 8, 26},
		{2026, 9, 9, 2026, 9, 16},
		{2026, 9, 30, 2026, 10, 7},
		{2026, 10, 21, 2026, 10, 28},
		{2026, 11, 11, 2026, 11, 18},
		{2026, 12, 2, 2026, 12, 9},
		{2026, 12, 23, 2026, 12, 30},
		{2027, 1, 13, 2027, 1, 20},
		{2027, 2, 3, 2027, 2, 10},
		{2027, 2, 24, 2027, 3, 3},
		{2027, 3, 17, 2027, 3, 24},
		{2027, 4, 7, 2027, 4, 14},
		{2027, 4, 28, 2027, 5, 5},
		{2027, 5, 19, 2027, 5, 26},
		{2027, 6, 9, 2027, 6, 16},
		{2027, 6, 30, 2027, 7, 7},
		{2027, 7, 21, 2027, 7, 28},
		{2027, 8, 11, 2027, 8, 18},
		{2027, 9, 1, 2027, 9, 8},
		{2027, 9, 22, 2027, 9, 29},
		{2027, 10, 13, 2027, 10, 20},
		{2027, 11, 3, 2027, 11, 10},
		{2027, 11, 24, 2027, 12, 1},
		{2027, 12, 15, 2027, 12, 22},
		{2028, 1, 5, 2028, 1, 12},
		{2028, 1, 26, 2028, 2, 2},
		{2028, 2, 16, 2028, 2, 23},
		{2028, 3, 8, 2028, 3, 15},
		{2028, 3, 29, 2028, 4, 5},
		{2028, 4, 19, 2028, 4, 26},
		{2028, 5, 10, 2028, 5, 17},
		{2028, 5, 31, 2028, 6, 7},
		{2028, 6, 21, 2028, 6, 28},
		{2028, 7, 12, 2028, 7, 19},
		{2028, 8, 2, 2028, 8, 9},
		{2028, 8, 23, 2028, 8, 30},
		{2028, 9, 13, 2028, 9, 20},
		{2028, 10, 4, 2028, 10, 11},
		{2028, 10, 25, 2028, 11, 1},
		{2028, 11, 15, 2028, 11, 22},
		{2028, 12, 6, 2028, 12, 13},
		{2028, 12, 27, 2029, 1, 3},
		{2029, 1, 17, 2029, 1, 24},
		{2029, 2, 7, 2029, 2, 14},
		{2029, 2, 28, 2029, 3, 7},
		{2029, 3, 21, 2029, 3, 28},
		{2029, 4, 11, 2029, 4, 18},
		{2029, 5, 2, 2029, 5, 9},
		{2029, 5, 23, 2029, 5, 30},
		{2029, 6, 13, 2029, 6, 20},
		{2029, 7, 4, 2029, 7, 11},
		{2029, 7, 25, 2029, 8, 1},
		{2029, 8, 15, 2029, 8, 22},
		{2029, 9, 5, 2029, 9, 12},
		{2029, 9, 26, 2029, 10, 3},
		{2029, 10, 17, 2029, 10, 24},
		{2029, 11, 7, 2029, 11, 14},
		{2029, 11, 28, 2029, 12, 5},
		{2029, 12, 19, 2029, 12, 26},
		{2030, 1, 9, 2030, 1, 16},
		{2030, 1, 30, 2030, 2, 6},
		{2030, 2, 20, 2030, 2, 27},
		{2030, 3, 13, 2030, 3, 20},
		{2030, 4, 3, 2030, 4, 10},
		{2030, 4, 24, 2030, 5, 1},
		{2030, 5, 15, 2030, 5, 22},
    }
	
	local wikket_story = {
		{2025, 8, 13, 2025, 8, 20},
		{2025, 9, 3, 2025, 9, 10},
		{2025, 9, 24, 2025, 10, 1},
		{2025, 10, 15, 2025, 10, 22},
		{2025, 11, 5, 2025, 11, 12},
		{2025, 11, 26, 2025, 12, 3},
		{2025, 12, 17, 2025, 12, 24},
		{2026, 1, 7, 2026, 1, 14},
		{2026, 1, 28, 2026, 2, 4},
		{2026, 2, 18, 2026, 2, 25},
		{2026, 3, 11, 2026, 3, 18},
		{2026, 4, 1, 2026, 4, 8},
		{2026, 4, 22, 2026, 4, 29},
		{2026, 5, 13, 2026, 5, 20},
		{2026, 6, 3, 2026, 6, 10},
		{2026, 6, 24, 2026, 7, 1},
		{2026, 7, 15, 2026, 7, 22},
		{2026, 8, 5, 2026, 8, 12},
		{2026, 8, 26, 2026, 9, 2},
		{2026, 9, 16, 2026, 9, 23},
		{2026, 10, 7, 2026, 10, 14},
		{2026, 10, 28, 2026, 11, 4},
		{2026, 11, 18, 2026, 11, 25},
		{2026, 12, 9, 2026, 12, 16},
		{2026, 12, 30, 2027, 1, 6},
		{2027, 1, 20, 2027, 1, 27},
		{2027, 2, 10, 2027, 2, 17},
		{2027, 3, 3, 2027, 3, 10},
		{2027, 3, 24, 2027, 3, 31},
		{2027, 4, 14, 2027, 4, 21},
		{2027, 5, 5, 2027, 5, 12},
		{2027, 5, 26, 2027, 6, 2},
		{2027, 6, 16, 2027, 6, 23},
		{2027, 7, 7, 2027, 7, 14},
		{2027, 7, 28, 2027, 8, 4},
		{2027, 8, 18, 2027, 8, 25},
		{2027, 9, 8, 2027, 9, 15},
		{2027, 9, 29, 2027, 10, 6},
		{2027, 10, 20, 2027, 10, 27},
		{2027, 11, 10, 2027, 11, 17},
		{2027, 12, 1, 2027, 12, 8},
		{2027, 12, 22, 2027, 12, 29},
		{2028, 1, 12, 2028, 1, 19},
		{2028, 2, 2, 2028, 2, 9},
		{2028, 2, 23, 2028, 3, 1},
		{2028, 3, 15, 2028, 3, 22},
		{2028, 4, 5, 2028, 4, 12},
		{2028, 4, 26, 2028, 5, 3},
		{2028, 5, 17, 2028, 5, 24},
		{2028, 6, 7, 2028, 6, 14},
		{2028, 6, 28, 2028, 7, 5},
		{2028, 7, 19, 2028, 7, 26},
		{2028, 8, 9, 2028, 8, 16},
		{2028, 8, 30, 2028, 9, 6},
		{2028, 9, 20, 2028, 9, 27},
		{2028, 10, 11, 2028, 10, 18},
		{2028, 11, 1, 2028, 11, 8},
		{2028, 11, 22, 2028, 11, 29},
		{2028, 12, 13, 2028, 12, 20},
		{2029, 1, 3, 2029, 1, 10},
		{2029, 1, 24, 2029, 1, 31},
		{2029, 2, 14, 2029, 2, 21},
		{2029, 3, 7, 2029, 3, 14},
		{2029, 3, 28, 2029, 4, 4},
		{2029, 4, 18, 2029, 4, 25},
		{2029, 5, 9, 2029, 5, 16},
		{2029, 5, 30, 2029, 6, 6},
		{2029, 6, 20, 2029, 6, 27},
		{2029, 7, 11, 2029, 7, 18},
		{2029, 8, 1, 2029, 8, 8},
		{2029, 8, 22, 2029, 8, 29},
		{2029, 9, 12, 2029, 9, 19},
		{2029, 10, 3, 2029, 10, 10},
		{2029, 10, 24, 2029, 10, 31},
		{2029, 11, 14, 2029, 11, 21},
		{2029, 12, 5, 2029, 12, 12},
		{2029, 12, 26, 2030, 1, 2},
		{2030, 1, 16, 2030, 1, 23},
		{2030, 2, 6, 2030, 2, 13},
		{2030, 2, 27, 2030, 3, 6},
		{2030, 3, 20, 2030, 3, 27},
		{2030, 4, 10, 2030, 4, 17},
		{2030, 5, 1, 2030, 5, 8},
		{2030, 5, 22, 2030, 5, 29},
	}	

    if checkStoryPeriods(thisYear, thisMonth, thisDay, beautiful_beast_story) then
		KarazhanFirstBoss = L.KarazhanEvent1
		KarazhanFirstBossSequence = L.KarazhanSequence1
		print(L.KarazhanSequence1)
        return
    end

    if checkStoryPeriods(thisYear, thisMonth, thisDay, westfall_story) then
		KarazhanFirstBoss = L.KarazhanEvent2
		KarazhanFirstBossSequence = L.KarazhanSequence2
		print(L.KarazhanSequence2)
        return
    end
	
    if checkStoryPeriods(thisYear, thisMonth, thisDay, wikket_story) then
		KarazhanFirstBoss = L.KarazhanEvent3
		KarazhanFirstBossSequence = L.KarazhanSequence3
		print(L.KarazhanSequence3)
        return
    end
end

function mod:firstboss()
	local mapID = select(8, GetInstanceInfo())
    if mapID == 1651 then
		self:Message("stages", "Positive", "Long", KarazhanFirstBossSequence, 8553)
	end
end
-----------------------------------------------------------------------------------
local AutoKeystone = CreateFrame("Frame")

function AutoKeystone:OnEvent(event, addon)
	if (addon == "Blizzard_ChallengesUI") then
		if ChallengesKeystoneFrame then
			ChallengesKeystoneFrame:HookScript("OnShow", self.OnShow)
			ChallengesKeystoneFrame:HookScript("OnHide", self.OnHide)
			
			self:UnregisterEvent(event)
		end
	end
end

local button
local btn
local frame
local pullRunning = false
local timers = {}
local keyStarted = false

function AutoKeystone:OnShow()
	AutoKeystone:ResetButtons()
	AutoKeystone:CreateButtons()
end

function AutoKeystone:OnHide()
	AutoKeystone:ResetButtons()
end

function AutoKeystone:CreateButtons()
	local function SendMessage()
		ManageCalendar()
		if IsInRaid() then
			SendChatMessage(KarazhanFirstBoss, "RAID_WARNING")
		elseif IsInGroup() then
			SendChatMessage(KarazhanFirstBoss, "PARTY")
		end
		mod:firstboss()
	end

	local mapID = select(8, GetInstanceInfo())
	if mapID == 1651 then
		if not button then
			button = CreateFrame("Button", "BossEventButton", ChallengesKeystoneFrame, "UIPanelButtonTemplate")
			button:SetText("Boss events")
			button:SetWidth(100)
			button:SetHeight(25)
			button:SetPoint("TOP", 0, -122) 
			button:SetScript("OnClick", SendMessage)
		end
		button:Show()
	else
		if button then
			button:Hide()
		end
	end

	if not btn then
		btn = CreateFrame("Button", nil, ChallengesKeystoneFrame, "UIPanelButtonTemplate")
		btn:SetPoint("TOP", 0, -300)
		btn:SetSize(100, 40)
		btn:SetText("Ready check")
		btn:SetScript("OnClick", function(self, button, down)
			DoReadyCheck()
		end)
		btn:RegisterForClicks("AnyDown")
	end
	btn:Show()

	if not frame then
		frame = CreateFrame("Button", "PullButton", ChallengesKeystoneFrame, "UIPanelButtonTemplate")
		frame:SetSize(80, 22)
		frame:SetPoint("CENTER", ChallengesKeystoneFrame, "CENTER", 0, -2)
		frame:SetText("Pull timer")

		local function SendMessage(msg)
			if IsInRaid() then
				SendChatMessage(msg, "RAID_WARNING")
			else
				SendChatMessage(msg, "PARTY")
			end
		end

		frame:SetScript("OnClick", function(self)
			local plugin
			if BigWigs then
				plugin = BigWigs:GetPlugin("Pull")
			end

			if pullRunning then
				if plugin and plugin.Sync then
					plugin:Sync("Pull", 0)
				end

				SendMessage("PULL Canceled")
				for _, timer in pairs(timers) do
					timer:Cancel()
				end
				timers = {}
				pullRunning = false
				frame:SetText("Pull timer")
			else
				if plugin and plugin.Sync then
					plugin:Sync("Pull", 6)
				end

				pullRunning = true
				frame:SetText("Cancel (6)")
				SendMessage("[LittleWigs] The auto key is running")
				for i = 5, 1, -1 do
					local timer = C_Timer.NewTimer(6 - i, function()
						SendMessage("PULL in " .. tostring(i))
						frame:SetText("Cancel (" .. tostring(i) .. ")")
					end)
					table.insert(timers, timer)
				end
				local startTimer = C_Timer.NewTimer(6, function()
					SendMessage(">>PULL NOW<<")
					keyStarted = true
					pullRunning = false
					C_ChallengeMode.StartChallengeMode()
					ChallengesKeystoneFrame:Hide()
					frame:SetText("Pull timer")
					timers = {}
					AutoKeystone:ResetButtons()
				end)
				table.insert(timers, startTimer)
			end
		end)
	end
	frame:Show()

	for container=BACKPACK_CONTAINER, NUM_BAG_SLOTS do
		local slots = GetContainerNumSlots(container)
		for slot=1, slots do
			local _, _, _, _, _, _, slotLink, _, _, slotItemID = GetContainerItemInfo(container, slot)
			local mapID = select(8, GetInstanceInfo())			
			if slotLink and slotLink:match("|Hkeystone:209") and mapID == 1516 then
				KeyHolderChatAnnounce = true
			end
			if slotLink and slotLink:match("|Hkeystone:") then
				PickupContainerItem(container, slot)
				if (CursorHasItem()) then
					C_ChallengeMode.SlotKeystone()
				end
			end
		end
	end
end

function AutoKeystone:ResetButtons()
	if button then button:Hide() end
	if btn then btn:Hide() end
	if frame then frame:Hide() end
	if BigWigs then
		plugin = BigWigs:GetPlugin("Pull")
	end
	if pullRunning then
		local function SendMessage(msg)
			if IsInRaid() then
				SendChatMessage(msg, "RAID_WARNING")
			else
				SendChatMessage(msg, "PARTY")
			end
		end
		if not keyStarted then
			if plugin and plugin.Sync then
				plugin:Sync("Pull", 0)
			end
			SendMessage("PULL Canceled")
		end
		for _, timer in pairs(timers) do
			timer:Cancel()
		end
		timers = {}
		pullRunning = false
		if frame then frame:SetText("Pull timer") end
	end
	keyStarted = false
end

AutoKeystone:RegisterEvent("ADDON_LOADED")
AutoKeystone:SetScript("OnEvent", AutoKeystone.OnEvent)


-------------------------------------------------------------------------------------------------------

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
			PullTimer = self:ScheduleTimer("StartPull", seconds+0.5)
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

------------------------------------------------------------------------------------------------------------

function mod:BigWigs_BossComm(_, msg, data, sender)
	if msg == "TankPrio" then
		KeyHolderChatAnnounce = false
	end
end
-------------------------------------------------------------------------------------------------------

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
i:RegisterEvent("LOADING_SCREEN_DISABLED")
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
	elseif event == "LOADING_SCREEN_DISABLED" then
      local partyinfoMod = BigWigs:GetBossModule("===>>>>  PARTY INFO  <<<<===", true)
	  partyinfoMod:Enable()
	  end
    end
)