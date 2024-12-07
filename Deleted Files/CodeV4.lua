
if not game:IsLoaded() then
	game.Loaded:Wait()
end

if game.PlaceId ~= 920587237 then
	return
end

-- task.wait(5)
---------------------------------------------------------------
--[[ Services ]]--
---------------------------------------------------------------
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
-- local VirtualInputManager = game:GetService("VirtualInputManager")
local UserGameSettings = UserSettings():GetService("UserGameSettings")
-- local UserInputService = game:GetService("UserInputService")
local VirtualUser = game:GetService("VirtualUser")
local CoreGui = game:GetService("CoreGui")
local StarterGui = game:GetService("StarterGui")

--- Welcome MSG -------

StarterGui:SetCore(
    "SendNotification",
    {
        Title = "Hello Potato 😊",
        Text = "We're Back.. Be Happy!"
    }
)

-----------------------------------------------------------
--[[ Modules ]]--
-----------------------------------------------------------
-- local Bypass = require(ReplicatedStorage:WaitForChild("Fsys", 600)).load
-- local InventoryDB = require(ReplicatedStorage.ClientDB.Inventory.InventoryDB)
local ClientData = require(ReplicatedStorage:WaitForChild("ClientModules"):WaitForChild("Core"):WaitForChild("ClientData"))
local RouterClient = require(ReplicatedStorage.ClientModules.Core:WaitForChild("RouterClient"):WaitForChild("RouterClient"))
local LegacyTutorial = require(ReplicatedStorage.ClientModules:WaitForChild("Game"):WaitForChild("Tutorial"):WaitForChild("LegacyTutorial"))
-- local PetEntityManager = require(ReplicatedStorage.ClientModules.Game:WaitForChild("PetEntities"):WaitForChild("PetEntityManager"))
local CollisionsClient = require(ReplicatedStorage.ClientModules.Game:WaitForChild("CollisionsClient"))

-- local Remote = Bypass("RouterClient").get("HousingAPI/ActivateFurniture")
-- local ClaimRemote = Bypass("RouterClient").get("QuestAPI/ClaimQuest")
-- local RerollRemote = Bypass("RouterClient").get("QuestAPI/RerollQuest")
local Player = Players.LocalPlayer

-- repeat task.wait(1) until ClientData.get_data()[Player.Name].loaded_in
--print("loading")

local Rayfield = loadstring(game:HttpGet("https://raw.githubusercontent.com/Nocrazypc/Rayfield/main/source"))()

local Clipboard = loadstring(game:HttpGet("https://raw.githubusercontent.com/Nocrazypc/Project-BLN/refs/heads/main/ClipboardP.lua"))()
local Fusion = loadstring(game:HttpGet("https://raw.githubusercontent.com/Nocrazypc/Project-BLN/refs/heads/main/Fus.lua"))()
local GetInventory = loadstring(game:HttpGet("https://raw.githubusercontent.com/Nocrazypc/Project-BLN/refs/heads/main/GetInv.lua"))()
local Trade = loadstring(game:HttpGet("https://raw.githubusercontent.com/Nocrazypc/Project-BLN/refs/heads/main/Tra.lua"))()
local Teleport = loadstring(game:HttpGet("https://raw.githubusercontent.com/Nocrazypc/Project-BLN/refs/heads/main/Tele.lua"))()
-- local Keyboard = loadstring(game:HttpGet("https://raw.githubusercontent.com/Nocrazypc/Project-BLN/refs/heads/main/Keyboard.lua"))()
local Ailments = loadstring(game:HttpGet("https://raw.githubusercontent.com/Nocrazypc/Project-BLN/refs/heads/main/Deleted%20Files/Ailm.lua"))()
local StatsGuis = loadstring(game:HttpGet("https://raw.githubusercontent.com/Nocrazypc/Project-BLN/refs/heads/main/Stats.lua"))()

local Christmas2024 = loadstring(game:HttpGet("https://raw.githubusercontent.com/Nocrazypc/Project-BLN/refs/heads/main/Ch2024.lua"))()

-------------------------------------------------------------------
--[[ Private Variables ]]--
-------------------------------------------------------------------
-- local NewsAppConnection
local PickColorConn
local WelcomeScreen
-- local DialogConnection
local RoleChooserDialogConnection
local RobuxProductDialogConnection1
local RobuxProductDialogConnection2
local banMessageConnection
local DailyClaimConnection
-- local ChatConnection
-- local CharConn

local counter = 0
-- local diedCounter = 0

local isInMiniGame = false
-- local DailyBoolean = true
local NewTaskBool = true
local NewClaimBool = true
-- local isMainMap = false
-- local stopDoingTasks = false
-- local isCurrentlyDoingTasks = false
local guiCooldown = false
local tutorialDebonce = false
-- local stopEquip = false
local discordCooldown = false
local debounce = false

local Bed
local Shower
local Piano
local normalLure
local LitterBox
local strollerId

local baitId
local selectedPlayer
local selectedItem
local selectedPet
local selectedGift
local selectedToy
local selectedFood

getgenv().auto_accept_trade = false
getgenv().auto_trade_all_pets = false
getgenv().auto_trade_fullgrown_neon_and_mega = false
getgenv().auto_trade_custom = false
getgenv().auto_trade_semi_auto = false
getgenv().auto_trade_lowtier_pets = false
getgenv().auto_trade_rarity_pets = false
getgenv().auto_farm = false
getgenv().auto_make_neon = false
getgenv().auto_trade_Legendary = false
getgenv().auto_trade_custom_gifts = false
getgenv().auto_trade_all_neons = false
getgenv().auto_trade_eggs = false
getgenv().auto_trade_all_inventory = false
getgenv().feedAgeUpPotionToggle = false
getgenv().AutoFusion = false
getgenv().FocusFarmAgePotions = false
getgenv().PetCurrentlyFarming = ""

local Egg2Buy = SETTINGS.PET_TO_BUY
local Gift2Buy = "lunar_2024_special_lunar_new_year_gift_box"
local Pet2Buy = SETTINGS.PET_TO_BUY


local TestGui = Instance.new("ScreenGui")
local GuiPopupButton = Instance.new("TextButton")
local ClipboardButton = Instance.new("TextButton")

local PetToggle
local TradeAllInventory
local AllPetsToggle
local LegendaryToggle
local FullgrownToggle
local AnyNeonToggle
local TradeAllMegas
local TradeAllNeons
local LowTierToggle
local RarityToggle
local GiftToggle
local ToyToggle
local FoodToggle

-----------------------------------------------------------------------------------------------
--[[ Tables  ]]--
-----------------------------------------------------------------------------------------------
local DailyRewardTable = {
    [9] = "reward_1", [30] = "reward_2", [90] = "reward_3",[140] = "reward_4",
    [180] = "reward_5", [210] = "reward_6", [230] = "reward_7", [280] = "reward_8",
    [300] = "reward_9", [320] = "reward_10", [360] = "reward_11", [400] = "reward_12",
    [460] = "reward_13", [500] = "reward_14", [550] = "reward_15", [600] = "reward_16",
    [660] = "reward_17",
}

local DailyRewardTable2 = {
    [9] = "reward_1", [65] = "reward_2", [120] = "reward_3", [180] = "reward_4",
	[225] = "reward_5", [280] = "reward_6", [340] = "reward_7", [400] = "reward_8",
    [450] = "reward_9", [520] = "reward_10", [600] = "reward_11", [660] = "reward_12",
}

local NeonTable = { ["neon_fusion"] = true, ["mega_neon_fusion"] = true }


   local ClaimTable = {
	["hatch_three_eggs"] = {3},
	["fully_age_three_pets"] = {3},
	["make_two_trades"] = {2},
	["equip_two_accessories"] = {2},
	["buy_three_furniture_items_with_friends_coop_budget"] = {3},
	["buy_five_furniture_items"] = {5},
	["buy_fifteen_furniture_items"] = {15},
	["play_as_a_baby_for_twenty_five_minutes"] = {1500},
	["play_for_thirty_minutes"] = {1800},
	["sunshine_2024_playtime"] = {2400},
	["bonus_week_2024_small_ailments"] = {5},
	["bonus_week_2024_small_hatch_egg"] = {1},
	["bonus_week_2024_small_age_potion_drank"] = {1},
	["bonus_week_2024_small_ailment_orange"] = {1},
	["bonus_week_2024_medium_ailment_hungry_sleepy_bored"] = {3},
	["bonus_week_2024_medium_ailment_catch_bored"] = {2},
	["bonus_week_2024_medium_ailment_toilet_dirty_sleepy"] = {3},
	["bonus_week_2024_medium_ailment_pizza_hungry"] = {2},
	["bonus_week_2024_medium_ailment_salon_dirty"] = {2},
	["bonus_week_2024_medium_ailment_school_ride"] = {2},
	["bonus_week_2024_medium_ailment_walk_beach"] = {2},
	["bonus_week_2024_medium_ailments"] = {15},
	["bonus_week_2024_large_ailments_common"] = {30},
	["bonus_week_2024_large_ailments_legendary"] = {30},
	["bonus_week_2024_large_ailments_ultra_rare"] = {30},
	["bonus_week_2024_large_ailments_uncommon"] = {30},
	["bonus_week_2024_large_ailments_rare"] = {30},
	["bonus_week_2024_large_ailments"] = {30},
}


local petsTable = GetInventory:TabId("pets")
if #petsTable == 0 then petsTable = {"Nothing"} end
local giftsTable = GetInventory:TabId("gifts")
if #giftsTable == 0 then giftsTable = {"Nothing"} end
local toysTable = GetInventory:TabId("toys")
if #toysTable == 0 then toysTable = {"Nothing"} end
local foodTable = GetInventory:TabId("food")
if #foodTable == 0 then foodTable = {"Nothing"} end

local pets_legendary = {}
local pets_ultrarare = {}
local pets_rare = {}
local pets_uncommon = {}
local pets_common = {}
local pets_eggs = {}
local Pets_commonto_ultrarare = {}
local pets_legendary_to_common = {}

local rng = Random.new()
-----------------------------------------------------------------------------------------------
--[[ Private Functions ]]--
-----------------------------------------------------------------------------------------------
-- local function clickGuiButton(button: Instance, xOffset: number, yOffset: number)
-- 	if typeof(button) ~= "Instance" then print("button is not a Instance") return end
-- 	local xOffset = xOffset or 60
-- 	local yOffset = yOffset or 60
-- 	task.wait()
-- 	VirtualInputManager:SendMouseButtonEvent(button.AbsolutePosition.X + xOffset, button.AbsolutePosition.Y + yOffset, 0, true, game, 1)
-- 	task.wait()
-- 	VirtualInputManager:SendMouseButtonEvent(button.AbsolutePosition.X + xOffset, button.AbsolutePosition.Y + yOffset, 0, false, game, 1)
-- 	task.wait()
-- end

local function FireButton(PassOn, dialogFramePass)
	task.wait() -- gives it time for button
	local dialogFrame = dialogFramePass or "NormalDialog"
	for i, v in pairs(Player.PlayerGui.DialogApp.Dialog[dialogFrame].Buttons:GetDescendants()) do
		if v.Name == "TextLabel" then
			if v.Text == PassOn then
				-- clickGuiButton(v.Parent.Parent)
				pcall(function()
					firesignal(v.Parent.Parent.MouseButton1Down)
					firesignal(v.Parent.Parent.MouseButton1Click)
					firesignal(v.Parent.Parent.MouseButton1Up)
				end)
				break
			end
		end
	end
end


local function getTradeLicense()
	for i, v in ClientData.get_data()[Player.Name].inventory.toys do
		if v.id == "trade_license" then
			return
		end
	end

	pcall(function()
		RouterClient.get("SettingsAPI/SetBooleanFlag"):FireServer("has_talked_to_trade_quest_npc", true)
		task.wait()
		RouterClient.get("TradeAPI/BeginQuiz"):FireServer()
		task.wait(1)
		for _, v in pairs(ClientData.get("trade_license_quiz_manager")["quiz"]) do
			RouterClient.get("TradeAPI/AnswerQuizQuestion"):FireServer(v["answer"])
		end
	end)
end

--// completes the starter tutorial
local function completeStarterTutorial()
	pcall(function()
		LegacyTutorial.cancel_tutorial()
		task.wait()
		ReplicatedStorage.API["LegacyTutorialAPI/MarkTutorialCompleted"]:FireServer()
		-- Bypass("TutorialClient").cancel()
		task.wait()
		ReplicatedStorage.API["LegacyTutorialAPI/EquipTutorialEgg"]:FireServer()
		task.wait()
		ReplicatedStorage.API["LegacyTutorialAPI/AddTutorialQuest"]:FireServer()
		task.wait()
		ReplicatedStorage.API["LegacyTutorialAPI/AddHungryAilmentToTutorialEgg"]:FireServer()
		task.wait()
		local function feedStartEgg(SandwichPassOn)
			local Foodid2
			for _, v in pairs(ClientData.get_data()[Player.Name].inventory.food) do
				if v.id == SandwichPassOn then
					Foodid2 = v.unique
					break
				end
			end

			ReplicatedStorage.API["ToolAPI/Equip"]:InvokeServer(Foodid2, { ["use_sound_delay"] = true })
			task.wait(1)
			ReplicatedStorage.API["PetAPI/ConsumeFoodItem"]:FireServer(
				Foodid2,
				ClientData.get("pet_char_wrappers")[1].pet_unique
			)
		end

		feedStartEgg("sandwich-default")
		-- ReplicatedStorage.API["TeamAPI/ChooseTeam"]:InvokeServer("Babies", {["dont_send_back_home"] = true})
	end)
end

-- "basiccrib"  "stylishshower"  "modernshower"  "piano" "lures2023normallure"
local function findFurniture()
	if Bed and Piano and LitterBox then return end
	for key, value in ClientData.get_data()[Player.Name].house_interior.furniture do
		if value.id == "basiccrib" then
			Bed = key
		elseif value.id == "stylishshower" or value.id == "modernshower" then
			Shower = key
		elseif value.id == "piano" then
			Piano = key
		elseif value.id == "lures_2023_normal_lure" then
			normalLure = key
		elseif value.id == "ailments_refresh_2024_litter_box" then
			LitterBox = key
		end
	end
end


local function buyFurniture(furnitureId: string) --piano basiccrib
	--print(`💸 No {furnitureId}, so buying it 💸`)
	local args = {
		{
			{
				["kind"] = furnitureId,
				["properties"] = {["cframe"] = CFrame.new(14, 2, -22) * CFrame.Angles(-0, 8.7, 3.8)},
			},
		},
	}

	ReplicatedStorage:WaitForChild("API"):WaitForChild("HousingAPI/BuyFurnitures"):InvokeServer(unpack(args))
end

local function GrabDailyReward()
	local Daily = ClientData.get("daily_login_manager")
	if Daily.prestige % 2 == 0 then
		for i, v in pairs(DailyRewardTable) do
			if i < Daily.stars or i == Daily.stars then
				if not Daily.claimed_star_rewards[v] then
					RouterClient.get("DailyLoginAPI/ClaimStarReward"):InvokeServer(v)
				end
			end
		end
	else
		for i, v in pairs(DailyRewardTable2) do
			if i < Daily.stars or i == Daily.stars then
				if not Daily.claimed_star_rewards[v] then
					RouterClient.get("DailyLoginAPI/ClaimStarReward"):InvokeServer(v)
				end
			end
		end
	end
end

---\\Auto taskboard Quest
local function QuestCount()
	local Count = 0
	for i, v in pairs(ClientData.get("quest_manager")["quests_cached"]) do
		if
			v["entry_name"]:match("teleport")
			or v["entry_name"]:match("navigate")
			or v["entry_name"]:match("nav")
			or v["entry_name"]:match("gosh_2022_sick")
		then
			Count = Count + 0
		else
			Count = Count + 1
		end
	end
	return Count
end

local function ReRollCount()
	for i, v in pairs(ClientData.get("quest_manager")["daily_quest_data"]) do
		if v == 1 or v == 0 then
			return v
		end
	end
     return 0
end

local function NewTask()
	NewTaskBool = false
	for _, v in pairs(ClientData.get("quest_manager")["quests_cached"]) do
		if v["entry_name"]:match("teleport") then
			task.wait()
		elseif v["entry_name"]:match("tutorial") then
			ReplicatedStorage.API["QuestAPI/ClaimQuest"]:InvokeServer(v["unique_id"])
			-- ClaimRemote:InvokeServer(v["unique_id"])
			task.wait()
		elseif v["entry_name"]:match("celestial_2024_small_open_gift") then
			-- open small gift
			ReplicatedStorage.API["ShopAPI/BuyItem"]:InvokeServer("gifts", "smallgift", {})
			task.wait(1)
			for _, v in ClientData.get_data()[Player.Name].inventory.gifts do
				if v["id"] == "smallgift" then
					ReplicatedStorage.API["ShopAPI/OpenGift"]:InvokeServer(v["unique"])
					break
				end
			end
			task.wait()
		else
			if QuestCount() == 1 then
				if NeonTable[v["entry_name"]] then
					ReplicatedStorage.API["QuestAPI/ClaimQuest"]:InvokeServer(v["unique_id"])
					task.wait()
				elseif not NeonTable[v["entry_name"]] and ReRollCount() >= 1 then
					ReplicatedStorage.API["QuestAPI/RerollQuest"]:FireServer(v["unique_id"])
					-- RerollRemote:FireServer(v["unique_id"])
					task.wait()
				end
			elseif QuestCount() > 1 then
				if NeonTable[v["entry_name"]] then
					ReplicatedStorage.API["QuestAPI/ClaimQuest"]:InvokeServer(v["unique_id"])
					task.wait()
				elseif not NeonTable[v["entry_name"]] and ReRollCount() >= 1 then
					ReplicatedStorage.API["QuestAPI/RerollQuest"]:FireServer(v["unique_id"])
					task.wait()
				elseif not NeonTable[v["entry_name"]] and ReRollCount() <= 0 then
					ReplicatedStorage.API["QuestAPI/ClaimQuest"]:InvokeServer(v["unique_id"])
					task.wait()
				end
			end
		end
	end
	task.wait(1)
	NewTaskBool = true
end

local function NewClaim()
	NewClaimBool = false
	for _, v in pairs(ClientData.get("quest_manager")["quests_cached"]) do
		if ClaimTable[v["entry_name"]] then
			if v["steps_completed"] == ClaimTable[v["entry_name"]][1] then
				ReplicatedStorage.API["QuestAPI/ClaimQuest"]:InvokeServer(v["unique_id"])
				task.wait()
			end
		elseif not ClaimTable[v["entry_name"]] and v["steps_completed"] == 1 then
			ReplicatedStorage.API["QuestAPI/ClaimQuest"]:InvokeServer(v["unique_id"])
			task.wait()
		end
	end
	task.wait(1)
	NewClaimBool = true
end

local function isMuleInGame()
	for _, player in Players:GetPlayers() do
		if player.Name == getgenv().SETTINGS.TRADE_COLLECTOR_NAME then
			return true
		end
	end
	return false
end

--[[local function subToHouse()
game:GetService("ReplicatedStorage").API:FindFirstChild("HousingAPI/SubscribeToHouse"):FireServer(Player)
end--]]


local function agePotion(FoodPassOn)
	for _, v in pairs(ClientData.get_data()[Player.Name].inventory.food) do
		if v.id == FoodPassOn then

                        local isEgg = if table.find(pets_eggs, ClientData.get("pet_char_wrappers")[1]["pet_id"]) then true else false


			local petAge = ClientData.get("pet_char_wrappers")[1]["pet_progression"]["age"]
			if isEgg or petAge >= 6 then
				return
			end
			ReplicatedStorage.API["PetAPI/ConsumeFoodItem"]:FireServer(
				v.unique,
				ClientData.get("pet_char_wrappers")[1].pet_unique
			)
			return
		end
	end
end


local function getPlayersInGame()
	local playerTable = {"Nothing"}
	for _, player in Players:GetPlayers() do
		if player.Name == Player.Name then
			continue
		end
		table.insert(playerTable, player.Name)
	end

	table.sort(playerTable)
	return playerTable
end


-- buy the lure bait and place it
local function buyLure()
	local args = {
		[1] = {
			[1] = {
				["properties"] = {
					["cframe"] = CFrame.new(14, 0, -14)
						* CFrame.Angles(-0, 8.742277657347586e-08, 3.82137093032941e-15),
				},
				["kind"] = "lures_2023_normal_lure",
			},
		},
	}

	ReplicatedStorage.API:FindFirstChild("HousingAPI/BuyFurnitures"):InvokeServer(unpack(args))
end


-- give cookie bait to lure
local function placeBait(baitIdPasson)
	local args = {
		[1] = game:GetService("Players").LocalPlayer,
		[2] = normalLure,
		[3] = "UseBlock",
		[4] = {
			["bait_unique"] = baitIdPasson,
		},
		[5] = game:GetService("Players").LocalPlayer.Character,
	}

	ReplicatedStorage.API:FindFirstChild("HousingAPI/ActivateFurniture"):InvokeServer(unpack(args))
end

local function getBaitReward(baitId)
	local args = {
		[1] = game:GetService("Players").LocalPlayer,
		[2] = baitId,
		[3] = "UseBlock",
		[4] = false,
		[5] = game:GetService("Players").LocalPlayer.Character
	}
	
	ReplicatedStorage.API:FindFirstChild("HousingAPI/ActivateFurniture"):InvokeServer(unpack(args))
end

---Advent Calendar-----
local function getRewardFromAdventCalendar()
	local date = DateTime.now().ToUniversalTime(DateTime.now())
	local claimed = if ClientData.get_data()[Player.Name].winter_2024_advent_manager.rewards_claimed[date["Day"]] then true else false
	if claimed then
		-- print(`Reward already claimed for day {date["Day"]}`)
	else
		ReplicatedStorage.API["WinterfestAPI/AdventCalendarTryTakeReward"]:InvokeServer(date["Day"])
		print(`🎉 Reward claimed: day {date["Day"]} 🎉`)
	end
end
----------------------

local function findBait(baitPassOn)
	local bait
	for _, v in pairs(ClientData.get_data()[Player.Name].inventory.food) do
		if v.id == baitPassOn then
			bait = v.unique
			return bait
		end
	end
end


-- local function buyPet()
-- 	local BuyPet = ReplicatedStorage.API["ShopAPI/BuyItem"]:InvokeServer("pets", Pet2Buy, {})
-- 	if BuyPet == "too little money" then
-- 		return false
-- 	end
-- 	return true
-- end


local function getEgg()
	for _, v in pairs(ClientData.get_data()[Player.Name].inventory.pets) do
		if v.id == Egg2Buy and v.id ~= "practice_dog" and v.properties.age ~= 6 and not v.properties.mega_neon then
			ReplicatedStorage.API["ToolAPI/Equip"]:InvokeServer(v.unique, { ["use_sound_delay"] = true })
			PetCurrentlyFarming = v.unique
			return true
		end
	end
	local BuyEgg = ReplicatedStorage.API["ShopAPI/BuyItem"]:InvokeServer("pets", Egg2Buy, {})
	if BuyEgg == "too little money" then
		-- nothing
		return false
	end
	task.wait(1)
	return false
end

--[[
local function GetGiftPet()
	for _, v in pairs(Bypass("ClientData").get_data()[Player.Name].inventory.gifts) do
		if v["id"] == Gift2Buy then
			ReplicatedStorage.API["ToolAPI/Equip"]:InvokeServer(v.unique, { ["use_sound_delay"] = true })
			task.wait(1)
			ReplicatedStorage.API["LootBoxAPI/ExchangeItemForReward"]:InvokeServer(v["id"], v["unique"])
			return true
		end
	end

	local BuyGift = ReplicatedStorage.API["ShopAPI/BuyItem"]:InvokeServer("gifts", Gift2Buy, {})
	if tostring(BuyGift) == "too little money" then
		--nothing
		return true -- dont wanna buy egg, we will wait for event currenty
	end
end
--]]

local function priorityEgg()
	local found_pet = false
	while found_pet == false do
		task.wait()
		for _, v in ipairs(SETTINGS.HATCH_EGG_PRIORITY_NAMES) do
			for i, v2 in pairs(ClientData.get_data()[Player.Name].inventory.pets) do
				if v == v2.id and v2.id ~= "practice_dog" then
					ReplicatedStorage.API["ToolAPI/Equip"]:InvokeServer(v2.unique, { ["use_sound_delay"] = true })
					PetCurrentlyFarming = v2.unique
					return true
				end
			end
		end

		return false
	end
end


local function priorityPet()
	local Petage = 5
	local isNeon = true
	local found_pet = false
	while found_pet == false do
		task.wait()
		for i, v in ipairs(SETTINGS.PET_ONLY_PRIORITY_NAMES) do
			for i2, v2 in pairs(ClientData.get_data()[Player.Name].inventory.pets) do
				if
					v == v2.id
					and v2.id ~= "practice_dog"
					and v2.properties.age == Petage
					and v2.properties.neon == isNeon
				then
					ReplicatedStorage.API["ToolAPI/Equip"]:InvokeServer(v2.unique, { ["use_sound_delay"] = true })
					PetCurrentlyFarming = v2.unique
					return true
				end
			end
		end
		if found_pet == false then
			Petage = Petage - 1
			if Petage == 0 and isNeon == true then
				Petage = 5
				isNeon = nil
			elseif Petage == 0 and isNeon == nil then
				--getLegendary() -- the selected pet is finished so stop searching
				return false
			end
		end
	end
end


local function getNeonPet()
	local Petage = 5
	local isNeon = true
	local found_pet = false
	while found_pet == false do
		task.wait()
		for i, v in pairs(ClientData.get_data()[Player.Name].inventory.pets) do
			if v.id ~= "practice_dog" and v.properties.age == Petage and v.properties.neon == isNeon then
				ReplicatedStorage.API["ToolAPI/Equip"]:InvokeServer(v.unique, { ["use_sound_delay"] = true })
				PetCurrentlyFarming = v.unique
				return true
			end
		end
		if found_pet == false then
			Petage = Petage - 1
			if Petage == 0 and isNeon == true then
				return false
			end
		end
	end
end


local function getPet()
	if SETTINGS.FOCUS_FARM_AGE_POTION or getgenv().FocusFarmAgePotions then
		if GetInventory:GetPetFriendship() then return end
		if GetInventory:PetRarityAndAge("common", 6) then return end
		if GetInventory:PetRarityAndAge("legendary", 6) then return end
		if GetInventory:PetRarityAndAge("ultra_rare", 6) then return end
		if GetInventory:PetRarityAndAge("rare", 6) then return end
		if GetInventory:PetRarityAndAge("uncommon", 6) then return end
	end

	if SETTINGS.PET_NEON_PRIORITY then
		if getNeonPet() then return end
	end

	if SETTINGS.PET_ONLY_PRIORITY then
		if priorityPet() then return end
	end

	if SETTINGS.HATCH_EGG_PRIORITY then
		if priorityEgg() then return end
		
		for i = 1, 1 do
			ReplicatedStorage.API["ShopAPI/BuyItem"]:InvokeServer("pets", SETTINGS.HATCH_EGG_PRIORITY_NAMES[1], {})
			return
		end
	end

	if GetInventory:PetRarityAndAge("legendary", 5) then return end
	if GetInventory:PetRarityAndAge("ultra_rare", 5) then return end
	if GetInventory:PetRarityAndAge("rare", 5) then return end
	if GetInventory:PetRarityAndAge("uncommon", 5) then return end
	if GetInventory:PetRarityAndAge("common", 5) then return end
	
	-- if GetGiftPet() then
	--     task.wait(1)
	--     if getLegendary() then return end
	--     if getUltraRare() then return end
	--     if getRare() then return end
	--     if getUnCommon() then return end
	--     if getCommon() then return end
	-- end

	if getEgg() then return end
	-- if buyPet() then return end
end



local function removeHandHeldItem()
	local tool = Player.Character:FindFirstChildOfClass("Tool")
	if tool then
		ReplicatedStorage.API["ToolAPI/Unequip"]:InvokeServer(tool.unique.Value, {})
	end
end



local function AgeUpPotionLevelUp()
	local sameUnqiue
	-- local count = 0

	local function equipPet()
		-- checks inventory for neon pet
		for _, v in
			pairs(require(ReplicatedStorage.ClientModules.Core.ClientData).get_data()[Player.Name].inventory.pets)
		do
			if
				v.id == selectedItem
				and v.id ~= "practice_dog"
				and v.properties.age ~= 6
				and v.properties.neon
				and not v.properties.mega_neon
			then
				ReplicatedStorage.API["ToolAPI/Equip"]:InvokeServer(v.unique, { ["use_sound_delay"] = true })
				return true
			end
		end

		for _, v in
			pairs(require(ReplicatedStorage.ClientModules.Core.ClientData).get_data()[Player.Name].inventory.pets)
		do
			if
				v.id == selectedItem
				and v.id ~= "practice_dog"
				and v.properties.age ~= 6
				and not v.properties.mega_neon
			then
				ReplicatedStorage.API["ToolAPI/Equip"]:InvokeServer(v.unique, { ["use_sound_delay"] = true })
				return true
			end
		end
		return false
	end

	local function feedAgePotion()
		for _, v in
			pairs(require(ReplicatedStorage.ClientModules.Core.ClientData).get_data()[Player.Name].inventory.food)
		do
			if v.id == "pet_age_potion" then
				if sameUnqiue == v.unique then
					return true
				end -- means the same age potion is still in inventory
				sameUnqiue = v.unique
				ReplicatedStorage.API["PetAPI/ConsumeFoodItem"]:FireServer(
					v.unique,
					ClientData.get("pet_char_wrappers")[1].pet_unique
				)
				return true
			end
		end
		return false
	end

	while getgenv().feedAgeUpPotionToggle do
		local hasPetEquipped = ClientData.get("pet_char_wrappers")[1]
		if not hasPetEquipped then
			equipPet()
			task.wait(1)
		end

		if selectedItem ~= ClientData.get("pet_char_wrappers")[1]["pet_id"] then
			equipPet()
			task.wait(1)
		end

		local age = ClientData.get("pet_char_wrappers")[1]["pet_progression"]["age"]
		if age >= 6 then
			local hasPet = equipPet()
			task.wait(1) -- wait for pet to equip
			if not hasPet then
				getgenv().PotionToggle:Set(false)
				return
			end
		end

		local hasAgeUpPotion = feedAgePotion()
		if not hasAgeUpPotion then
			--print("no more age up potions")
			getgenv().PotionToggle:Set(false)
			return
		end
		task.wait(1)
	end
end


local function CheckifEgg()
	-- local PetNameID = ClientData.get("pet_char_wrappers")[1]["pet_id"]
	local PetUniqueID = ClientData.get("pet_char_wrappers")[1]["pet_unique"]
	local PetAge = ClientData.get("pet_char_wrappers")[1]["pet_progression"]["age"]

	if PetUniqueID == PetCurrentlyFarming then
		return
	end
	if PetAge ~= 1 then
		return
	end

	getPet()
end


local function SwitchOutFullyGrown()
	if ClientData.get("pet_char_wrappers")[1] == nil or false then
		getPet()
		return
	end
	local PetAge = ClientData.get("pet_char_wrappers")[1]["pet_progression"]["age"]
	if PetAge == 6 then
		getPet()
		return
	elseif PetAge == 1 then
		CheckifEgg()
	end
end


local function ClickTradeWindowPopUps()
	for _, v in pairs(Player.PlayerGui.DialogApp.Dialog.NormalDialog.Buttons:GetDescendants()) do
		if v.Name == "TextLabel" then
			if
				v.Text == "Accept"
				or v.Text == "Okay"
				or v.Text == "Next"
				or v.Text == "I understand"
				or v.Text == "No"
			then
				FireButton(v.Parent.Parent)
				return
			end
		end
	end

	for _, v in pairs(Player.PlayerGui.DialogApp.Dialog.HeaderDialog.Buttons:GetDescendants()) do
		if v.Name == "TextLabel" then
			if v.Text == "Accept" or v.Text == "Okay" or v.Text == "Next" or v.Text == "I understand" then
				FireButton(v.Parent.Parent)
				return
			end
		end
	end
end


local function checkInventory()
	if not game.Players[SETTINGS.TRADE_COLLECTOR_NAME] then
		return false, "false", nil
	end

	for _, accessory in pairs(ClientData.get_data()[Player.Name].inventory.pet_accessories) do
		if not SETTINGS.TRADE_LIST.PET_WEAR_TABLE[1] then
			break
		end
		for _, v2 in SETTINGS.TRADE_LIST.PET_WEAR_TABLE do
			if accessory.id == v2 then
				return true, "pet_accessories", SETTINGS.TRADE_LIST.PET_WEAR_TABLE
			end
		end
	end

	for _, vehicle in pairs(ClientData.get_data()[Player.Name].inventory.transport) do
		if not SETTINGS.TRADE_LIST.VEHICLES_TABLE[1] then
			break
		end
		for _, v2 in SETTINGS.TRADE_LIST.VEHICLES_TABLE do
			if vehicle.id == v2 then
				return true, "transport", SETTINGS.TRADE_LIST.VEHICLES_TABLE
			end
		end
	end

	for _, food in pairs(ClientData.get_data()[Player.Name].inventory.food) do
		if not SETTINGS.TRADE_LIST.FOOD_TABLE[1] then
			break
		end
		for _, v2 in SETTINGS.TRADE_LIST.FOOD_TABLE do
			if food.id == v2 then
				return true, "food", SETTINGS.TRADE_LIST.FOOD_TABLE
			end
		end
	end

	for _, gift in pairs(ClientData.get_data()[Player.Name].inventory.gifts) do
		if not SETTINGS.TRADE_LIST.GIFTS_TABLE[1] then
			break
		end
		for _, v2 in SETTINGS.TRADE_LIST.GIFTS_TABLE do
			if gift.id == v2 then
				return true, "gifts", SETTINGS.TRADE_LIST.GIFTS_TABLE
			end
		end
	end

	for _, toy in pairs(ClientData.get_data()[Player.Name].inventory.toys) do
		if not SETTINGS.TRADE_LIST.TOYS_TABLE[1] then
			break
		end
		for _, v2 in SETTINGS.TRADE_LIST.TOYS_TABLE do
			if toy.id == v2 then
				return true, "toys", SETTINGS.TRADE_LIST.TOYS_TABLE
			end
		end
	end

	if SETTINGS.TRADE_ONLY_LUMINOUS_MEGA then
		for _, pet in pairs(ClientData.get_data()[Player.Name].inventory.pets) do
			for _, v2 in SETTINGS.TRADE_LIST.PETS_TABLE do
				if
					pet.id == v2
					or (pet.properties.neon and pet.properties.age == 6)
					or pet.properties.mega_neon == true
				then
					return true, "pets", SETTINGS.TRADE_LIST.PETS_TABLE
				end
			end
		end
	else
		for _, pet in pairs(ClientData.get_data()[Player.Name].inventory.pets) do
			for _, v2 in SETTINGS.TRADE_LIST.PETS_TABLE do
				if
					pet.id == v2
					or pet.properties.age == 6
					or (pet.properties.neon and pet.properties.age == 6)
					or pet.properties.mega_neon == true
				then
					return true, "pets", SETTINGS.TRADE_LIST.PETS_TABLE
				end
			end
		end
	end

	return false, "false", nil
end


local function tradeCollector(namePassOn)
	while SETTINGS.ENABLE_TRADE_COLLECTOR and SETTINGS.TRADE_COLLECTOR_NAME and Players[namePassOn] do
		local tabBoolean, tabName, tables = checkInventory()
		if not tabBoolean then
			return
		end
		pcall(function()
			repeat
				if not Player.PlayerGui.TradeApp.Frame.Visible then
					ReplicatedStorage.API:FindFirstChild("TradeAPI/SendTradeRequest"):FireServer(Players[namePassOn])
					task.wait(math.random(8, 15))
				end

				ClickTradeWindowPopUps()
				task.wait()
			until Player.PlayerGui.TradeApp.Frame.Visible
			ClickTradeWindowPopUps()
			task.wait(1)
			ClickTradeWindowPopUps()

			local petCounter = 0
			if SETTINGS.TRADE_ONLY_LUMINOUS_MEGA then
				for _, pet in pairs(ClientData.get_data()[Player.Name].inventory[tabName]) do
					for _, v2 in tables do
						if
							pet.id == v2
							or (pet.properties.neon and pet.properties.age == 6)
							or pet.properties.mega_neon == true
						then
							ReplicatedStorage.API:FindFirstChild("TradeAPI/AddItemToOffer"):FireServer(pet.unique)
							petCounter = petCounter + 1
							if petCounter >= 18 then
								break
							end
							task.wait()
						end
					end
				end
			else
				for _, pet in pairs(ClientData.get_data()[Player.Name].inventory[tabName]) do
					for _, v2 in tables do
						if
							pet.id == v2
							or pet.properties.age == 6
							or (pet.properties.neon and pet.properties.age == 6)
							or pet.properties.mega_neon == true
						then
							ReplicatedStorage.API:FindFirstChild("TradeAPI/AddItemToOffer"):FireServer(pet.unique)
							petCounter = petCounter + 1
							if petCounter >= 18 then
								break
							end
							task.wait()
						end
					end
				end
			end
			local stuck = 30
			repeat
				local lock = Player.PlayerGui.TradeApp.Frame.NegotiationFrame.Body.LockIcon.Visible
				stuck -= 1
				task.wait(1)

			until not lock or stuck <= 0
			-- wait for timer to hit 0

			ClickTradeWindowPopUps()
			task.wait(1)
			ReplicatedStorage.API:FindFirstChild("TradeAPI/AcceptNegotiation"):FireServer()
			task.wait(3)
			ReplicatedStorage.API:FindFirstChild("TradeAPI/ConfirmTrade"):FireServer()
			petCounter = 0
			ClickTradeWindowPopUps()
		end)
		task.wait(1)
		ClickTradeWindowPopUps()
		task.wait()
	end
end

local function completeBabyAilments()
	for key, _ in ClientData.get_data()[Player.Name].ailments_manager.baby_ailments do
		if key == "hungry" then
			Ailments:BabyHungryAilment()
			return
		elseif key == "thirsty" then
			Ailments:BabyThirstyAilment()
			return
		elseif key == "bored" then
			Ailments:BabyBoredAilment(Piano)
			-- need baby to do task too
			return
		elseif key == "sleepy" then
			Ailments:BabySleepyAilment(Bed)
			-- need baby to do task too
			getBaitReward(baitId) -- check to see if this is really working
			task.wait(2)
			placeBait(baitId)
			return
		elseif key == "dirty" then
			Ailments:BabyDirtyAilment(Shower)
			-- need baby to do task too
			return
		end
	end
end


local function autoFarm()
	     if not getgenv().auto_farm then return end
	     CollisionsClient.set_collidable(false)
	     Teleport.PlaceFloorAtFarmingHome()
	     Teleport.PlaceFloorAtCampSite()
	     Teleport.PlaceFloorAtBeachParty()
	     Teleport.FarmingHome()
	     
	     Christmas2024.getGingerbread()
	     
		local function CompletePetAilments()
		-- if ClientData.get("pet_char_wrappers")[1] == nil then
		-- 	ReplicatedStorage.API["ToolAPI/Equip"]:InvokeServer(PetCurrentlyFarming, {})
		-- 	return -- return because when pet gets requipped it will call this function anyway
		-- end

		if not ClientData.get("pet_char_wrappers")[1] then
			--print("no pet so requipping")
			ReplicatedStorage.API["ToolAPI/Unequip"]:InvokeServer(PetCurrentlyFarming, {})
			task.wait(1)
			ReplicatedStorage.API["ToolAPI/Equip"]:InvokeServer(PetCurrentlyFarming, {})
			return false
		end

		local petUnique = ClientData.get_data()[Player.Name].pet_char_wrappers[1].pet_unique

		if not ClientData.get_data()[Player.Name].ailments_manager then return false end
		if not ClientData.get_data()[Player.Name].ailments_manager.ailments then return false end
		if not ClientData.get_data()[Player.Name].ailments_manager.ailments[petUnique] then return false end

		-- instant ailments first
		for key, _ in ClientData.get_data()[Player.Name].ailments_manager.ailments[petUnique] do
			if key == "hungry" then
				Ailments:HungryAilment()
				return true
			elseif key == "thirsty" then
				Ailments:ThirstyAilment()
				return true
			elseif key == "sick" then
				Ailments:SickAilment()
				-- should already do baby task when pet does it
				return true
			end
		end

		-- for ailments that fake loction and use furniture items
		for key, _ in ClientData.get_data()[Player.Name].ailments_manager.ailments[petUnique] do
			if key == "salon" then
				Ailments:SalonAilment(key, petUnique)
				-- should already do baby task when pet does it
				return true
			elseif key == "pizza_party" then
				Ailments:PizzaPartyAilment(key, petUnique)
				-- should already do baby task when pet does it
				return true
			elseif key == "school" then
				Ailments:SchoolAilment(key, petUnique)
				-- should already do baby task when pet does it
				return true
			elseif key == "bored" then
				Ailments:BoredAilment(Piano, petUnique)
				-- need baby to do task too
				return true
			elseif key == "sleepy" then
				Ailments:SleepyAilment(Bed, petUnique)
				-- need baby to do task too
				getBaitReward(baitId) -- check to see if this is really working
				task.wait(2)
				placeBait(baitId)
				return true
			elseif key == "dirty" then
				Ailments:DirtyAilment(Shower, petUnique)
				-- need baby to do task too
				return true
			elseif key == "walk" then
				Ailments:WalkAilment(petUnique)
				-- need baby to do task too
				return true
			elseif key == "toilet" then
				Ailments:ToiletAilment(LitterBox, petUnique)
				-- baby doesnt have this task?
				return true
			elseif key == "ride" then
				Ailments:RideAilment(strollerId, petUnique)
				-- baby doesnt have this task?
				return true
			elseif key == "play" then
				Ailments:PlayAilment(key, petUnique)
				-- baby doesnt have this task?
				return true
			end
		end

		-- for ailments that teleport to mainmap
		for key, _ in ClientData.get_data()[Player.Name].ailments_manager.ailments[petUnique] do
			if key == "beach_party" then
	                Teleport.PlaceFloorAtBeachParty()
				Ailments:BeachPartyAilment(petUnique)
                             Teleport.FarmingHome()
				-- should already do baby task when pet does it
				return true
			elseif key == "camping" then
			     getRewardFromAdventCalendar()
			     Teleport.PlaceFloorAtCampSite()
				Ailments:CampingAilment(petUnique)
				Teleport.FarmingHome()
				-- should already do baby task when pet does it
                      Christmas2024.getGingerbread()
				return true
			end
		end

		-- last mystery ailment
		for key, _ in ClientData.get_data()[Player.Name].ailments_manager.ailments[petUnique] do
			if key:match("mystery") then
				Ailments:MysteryAilment(key, petUnique)
				return true
			end
		end

		return false
	end


	task.delay(30, function()
		while true do
                        pcall(function()
                                if isInMiniGame then
                                        repeat
                                             -- print(`⏱️ Waiting for 10 secs [inside minigame] ⏱️`)
                                                task.wait(10)
                                        until not isInMiniGame
                                end
                                removeHandHeldItem()
                                if not CompletePetAilments() then
                                completeBabyAilments()
                                end
                                
                        StatsGuis:UpdateText("TimeFrame")
			        StatsGuis:UpdateText("BucksAndPotionFrame")
                        StatsGuis:UpdateText("TotalFrame")
                        StatsGuis:UpdateText("TotalFrame1")
                        StatsGuis:UpdateText("TotalFrame2")
			--[[print(`⏱️ Waiting for 5 secs ⏱️`)--]]
			task.wait(5)
		end
	end)
		

	-- Player.PlayerGui.AilmentsMonitorApp.Ailments.ChildRemoved:Connect(function(ailment)
	-- 	if getgenv().feedAgeUpPotionToggle then return end
	-- 	if stopDoingTasks then return end

	-- 	if not SETTINGS.FOCUS_FARM_AGE_POTION then
	-- 		SwitchOutFullyGrown()
	-- 		task.wait(2)
	-- 	else
	-- 		getPet()
	-- 	end

	-- 	CompletePetAilments()
	-- 	CompleteBabyAilments()
	-- end)


	-- For text that popups on bottom ui
	Player.PlayerGui.HintApp.TextLabel:GetPropertyChangedSignal("Text"):Connect(function()
		if Player.PlayerGui.HintApp.TextLabel.Text:match("aged up!") then
			if getgenv().feedAgeUpPotionToggle then
				return
			end
			if SETTINGS.PET_AUTO_FUSION then
				Fusion:MakeMega(false) -- makes neon
				Fusion:MakeMega(true) -- makes mega
			end
			task.wait(2) -- gives it time for pet to fully equipped
			if not SETTINGS.FOCUS_FARM_AGE_POTION then
				SwitchOutFullyGrown()
			end
		--[[elseif Player.PlayerGui.HintApp.TextLabel.Text:match("You have left the queue") then
			if workspace.Interiors:FindFirstChild("Winter2023Shop") then
				Player.Character.PrimaryPart.CFrame = workspace.Interiors.Winter2023Shop.PetRescue.JoinZone.Collider.CFrame
					+ Vector3.new(0, -14, 0)
			end--]]
		end
	end)

	--[[Player.PlayerGui.MinigameInGameApp.Body.Left.Container.ValueLabel:GetPropertyChangedSignal("Text"):Connect(function()
		local eventTime = Player.PlayerGui.MinigameInGameApp.Body.Left.Container.ValueLabel.Text
		if eventTime == "00:00" then
			game:Shutdown()
		end
	end)--]]

	local function PlaceFloorAtSpleefMinigame()
		if workspace:FindFirstChild("SpleefLocation") then return end
	
		local floor = workspace.Interiors:WaitForChild("SpleefMinigame"):WaitForChild("Minigame"):WaitForChild("Floor")
		local part = Instance.new("Part")
		part.Position = floor.Position + Vector3.new(0, 20, 0)
		part.Size = Vector3.new(200, 2, 200)
		part.Anchored = true
		part.Transparency = 1
		part.Name = "SpleefLocation"
		part.Parent = workspace
	end


	--Fires when inside the minigame
	Player.PlayerGui.MinigameInGameApp:GetPropertyChangedSignal("Enabled"):Connect(function()
		if Player.PlayerGui.MinigameInGameApp.Enabled then
			Player.PlayerGui.MinigameInGameApp:WaitForChild("Body")
			Player.PlayerGui.MinigameInGameApp.Body:WaitForChild("Middle")
			Player.PlayerGui.MinigameInGameApp.Body.Middle:WaitForChild("Container")
			Player.PlayerGui.MinigameInGameApp.Body.Middle.Container:WaitForChild("TitleLabel")
			if Player.PlayerGui.MinigameInGameApp.Body.Middle.Container.TitleLabel.Text:match("MELT OFF") then
				     
                                PlaceFloorAtSpleefMinigame()
                                
                 end
		end
	end)


	  local function RemoveGameOverButton()
		Player.PlayerGui.MinigameRewardsApp.Body.Button:WaitForChild("Face")
		for _, v in pairs(Player.PlayerGui.MinigameRewardsApp.Body.Button:GetDescendants()) do
			if v.Name == "TextLabel" then
				if v.Text == "NICE!" then
					task.wait(5)
					-- clickGuiButton(v.Parent.Parent, 30, 60)
					firesignal(v.Parent.Parent.MouseButton1Down)
					firesignal(v.Parent.Parent.MouseButton1Click)
					firesignal(v.Parent.Parent.MouseButton1Up)
					break
				end
			end
		end
	end

	local function onTextChangedMiniGame()
	           isInMiniGame = true
                FireButton("Yes")
	end

	-- fires when it ask you if you want to join minigame
	Player.PlayerGui.DialogApp.Dialog.ChildAdded:Connect(function(NormalDialogChild)
		if NormalDialogChild.Name == "NormalDialog" then
			NormalDialogChild:GetPropertyChangedSignal("Visible"):Connect(function()
				if NormalDialogChild.Visible then
					NormalDialogChild:WaitForChild("Info")
					NormalDialogChild.Info:WaitForChild("TextLabel")
					NormalDialogChild.Info.TextLabel:GetPropertyChangedSignal("Text"):Connect(function()
						if Player.PlayerGui.DialogApp.Dialog.NormalDialog.Info.TextLabel.Text:match("Melt Off") then
							onTextChangedMiniGame()
						elseif Player.PlayerGui.DialogApp.Dialog.NormalDialog.Info.TextLabel.Text:match("invitation") then
							game:Shutdown()
						elseif Player.PlayerGui.DialogApp.Dialog.NormalDialog.Info.TextLabel.Text:match("You found a") then
							FireButton("Okay")
						end
					end)
				else
                                        ReplicatedStorage.API:FindFirstChild("MinigameAPI/AttemptJoin"):FireServer("spleef_minigame", true)
					
				end
			end)
		end
	end)


	--  Player.PlayerGui.DialogApp.Dialog.NormalDialog:GetPropertyChangedSignal("Visible"):Connect(function()
		if Player.PlayerGui.DialogApp.Dialog.NormalDialog.Visible then
			Player.PlayerGui.DialogApp.Dialog.NormalDialog:WaitForChild("Info")
			Player.PlayerGui.DialogApp.Dialog.NormalDialog.Info:WaitForChild("TextLabel")
			Player.PlayerGui.DialogApp.Dialog.NormalDialog.Info.TextLabel:GetPropertyChangedSignal("Text"):Connect(function()
				if Player.PlayerGui.DialogApp.Dialog.NormalDialog.Info.TextLabel.Text:match("Melt Off") then
					onTextChangedMiniGame()
				elseif Player.PlayerGui.DialogApp.Dialog.NormalDialog.Info.TextLabel.Text:match("invitation") then
					game:Shutdown()
				elseif Player.PlayerGui.DialogApp.Dialog.NormalDialog.Info.TextLabel.Text:match("You found a") then
					FireButton("Okay")
				end
			end)
            else
                        ReplicatedStorage.API:FindFirstChild("MinigameAPI/AttemptJoin"):FireServer("spleef_minigame", true)
		end
	end)


	-- if Player.PlayerGui.DialogApp.Dialog.NormalDialog.Visible then
	--     if Player.PlayerGui.DialogApp.Dialog.NormalDialog.Info.TextLabel.Text:match("Tile Skip is starting soon!") then
	--         FireButton("Yes")

	--     elseif Player.PlayerGui.DialogApp.Dialog.NormalDialog.Info.TextLabel.Text:match("Crabby Grabby is starting soon!") then
	--         FireButton("Yes")

	--     end
	-- end


	Player.PlayerGui.MinigameRewardsApp.Body:GetPropertyChangedSignal("Visible"):Connect(function()
		if Player.PlayerGui.MinigameRewardsApp.Body.Visible then
			Player.PlayerGui.MinigameRewardsApp.Body:WaitForChild("Button")
			Player.PlayerGui.MinigameRewardsApp.Body.Button:WaitForChild("Face")
			Player.PlayerGui.MinigameRewardsApp.Body.Button.Face:WaitForChild("TextLabel")
			if Player.PlayerGui.MinigameRewardsApp.Body.Button.Face.TextLabel.Text:match("NICE!") then
				Player.Character.HumanoidRootPart.Anchored = false
				RemoveGameOverButton()
				isInMiniGame = false
				Teleport.FarmingHome()
			end
		end
	end)

	-- Player.PlayerGui.BattlePassApp.Body.Header.Title.Title.Text:match("Pony Pass")
	--[[Player.PlayerGui.BattlePassApp.Body:GetPropertyChangedSignal("Visible"):Connect(function()
		if Player.PlayerGui.BattlePassApp.Body.Visible then
			Player.PlayerGui.BattlePassApp.Body:WaitForChild("InnerBody")
			Player.PlayerGui.BattlePassApp.Body.InnerBody:WaitForChild("ScrollingFrame")
			Player.PlayerGui.BattlePassApp.Body.InnerBody.ScrollingFrame:WaitForChild("21")
			if Player.PlayerGui.BattlePassApp.Body.InnerBody.ScrollingFrame[21] then
				for _, v in Player.PlayerGui.BattlePassApp.Body.InnerBody.ScrollingFrame:GetChildren() do
					if not v:FindFirstChild("ButtonFrame") then
						continue
					end
					if v.ButtonFrame:FindFirstChild("ClaimButton") then
						ReplicatedStorage.API["BattlePassAPI/ClaimReward"]:InvokeServer(
							"celestial_2024_pass_4",
							tonumber(v.Name) - 1
						)
						task.wait(1)
						ReplicatedStorage.API["BattlePassAPI/ClaimReward"]:InvokeServer(
							"celestial_2024_pass_4",
							tonumber(v.Name)
						)
					end
				end

				-- Player.PlayerGui.BattlePassApp.Body.Header.ExitFrame.ExitButton
				-- Player.PlayerGui.BattlePassApp.Body:WaitForChild("Header")
				-- Player.PlayerGui.BattlePassApp.Body.Header:WaitForChild("ExitFrame")
				-- Player.PlayerGui.BattlePassApp.Body.Header.ExitFrame:WaitForChild("ExitButton")
				-- local count = 0
				-- repeat
				--     clickGuiButton(Player.PlayerGui.BattlePassApp.Body.Header.ExitFrame.ExitButton, 30, 60)
				--     count += 1
				--     task.wait(1)
				-- until not Player.PlayerGui.BattlePassApp.Body.Visible or count >= 10

				-- joinMiniGame()
				stopDoingTasks = false
			end
		end
	end) --]]


	--// Code below runs once when auto farm is enabled
	if SETTINGS.PET_AUTO_FUSION then

			Fusion:MakeMega(false)
			Fusion:MakeMega(true)
			
	end


	task.wait()
	getPet()
	task.wait()
	getTradeLicense()

	Player.Idled:Connect(function()
		VirtualUser:ClickButton2(Vector2.new())
	end)

	-- for _, v in getconnections(Player.Idled) do
	--	v:Disable()
	-- end

	-- if not Bypass("ClientData").get_data()[Player.Name].inventory.toys.trade_license then
	--     getTradeLicense()
	--     FireButton("Okay")
	-- end
	-- ReplicatedStorage.API["EventAPI/ClaimObbyReward"]:InvokeServer(1)

	-- adopt me code
	ReplicatedStorage.API["CodeRedemptionAPI/AttemptRedeemCode"]:InvokeServer("AMTRUCK2024")

	-- setfpscap(SETTINGS.SET_FPS)
end


local function startAutoFarm()
	counter += 1
	if SETTINGS.ENABLE_AUTO_FARM then
		findFurniture()
		if Bed then
			-- task.wait(math.random(1, 5))
			-- FarmToggle:Set(true)
			getgenv().auto_farm = true
			autoFarm()
			-- task.wait(2)
		-- else
		-- 	print("no bed")
		-- 	if counter >= 10 then
		-- 		game:Shutdown()
		-- 	end
		-- 	buyFurniture("basiccrib")
		-- 	-- FarmToggle:Set(false)
		-- 	startAutoFarm()
		end
	end
end


local function SendMessage(url, message, userId)
	-- local http = game:GetService("HttpService")
	local request = request or http_request
	local headers = {
		["Content-Type"] = "application/json",
	}
	local data = {
		["content"] = `<@{userId}> {message}`,
	}
	local body = http:JSONEncode(data)
	local response = request({
		Url = url,
		Method = "POST",
		Headers = headers,
		Body = body,
	})
	for i, v in response do
		print(i, v)
	end
end

local function dailyLoginAppClick()
	if not Player.PlayerGui.DailyLoginApp.Enabled then return end
	Player.PlayerGui.DailyLoginApp:WaitForChild("Frame")
	Player.PlayerGui.DailyLoginApp.Frame:WaitForChild("Body")
	Player.PlayerGui.DailyLoginApp.Frame.Body:WaitForChild("Buttons")
	for _, v in Player.PlayerGui.DailyLoginApp.Frame.Body.Buttons:GetDescendants() do
		if v.Name == "TextLabel" then
			if v.Text == "CLOSE" then
				-- clickGuiButton(v.Parent.Parent) -- Close button
				task.wait(1)
				GrabDailyReward()
			elseif v.Text == "CLAIM!" then
				-- clickGuiButton(v.Parent.Parent) -- Claim button
				-- task.wait(.1)
				-- clickGuiButton(v.Parent.Parent) -- Close button
				-- task.wait(1)
				firesignal(v.Parent.Parent.MouseButton1Down)
				firesignal(v.Parent.Parent.MouseButton1Click)
				firesignal(v.Parent.Parent.MouseButton1Up) --claim button
				task.wait(.2)
				firesignal(v.Parent.Parent.MouseButton1Down)
				firesignal(v.Parent.Parent.MouseButton1Click)
				firesignal(v.Parent.Parent.MouseButton1Up) --close button
				GrabDailyReward()
			end
		end
	end
end

local function onTextChanged()
	if Player.PlayerGui.DialogApp.Dialog.NormalDialog.Info.TextLabel.Text:match("Be careful when trading") then
		FireButton("Okay")
	elseif Player.PlayerGui.DialogApp.Dialog.NormalDialog.Info.TextLabel.Text:match("This trade seems unbalanced") then
		FireButton("Next")
	elseif Player.PlayerGui.DialogApp.Dialog.NormalDialog.Info.TextLabel.Text:match("sent you a trade request") then
		FireButton("Accept")
	elseif Player.PlayerGui.DialogApp.Dialog.NormalDialog.Info.TextLabel.Text:match("Any items lost") then
		FireButton("I understand")
	elseif Player.PlayerGui.DialogApp.Dialog.NormalDialog.Info.TextLabel.Text:match("4.5%% Legendary") then
		FireButton("Okay")
	elseif Player.PlayerGui.DialogApp.Dialog.NormalDialog.Info.TextLabel.Text:match("Let's start the day") then
		FireButton("Start")
	elseif Player.PlayerGui.DialogApp.Dialog.NormalDialog.Info.TextLabel.Text:match("Are you subscribed") then
		FireButton("Yes")
	elseif Player.PlayerGui.DialogApp.Dialog.NormalDialog.Info.TextLabel.Text:match("your inventory") then
		FireButton("Awesome!")
	end
end

--[[ local function isMuleTrading()
	if ClientData.get_data()[Player.Name].in_active_trade then
		return true
	else
		return false
	end
end ]]--

-----------------------------------------------------------------------------------------------
--[[ Handling ]]--
-----------------------------------------------------------------------------------------------

-- Player.CharacterAdded:Connect(function(character: Model)
-- 	findFurniture()
-- 	diedCounter += 1
-- 	if diedCounter >= 3 then
-- 		game:Shutdown()
-- 	end
-- end)

UserInputService.InputBegan:Connect(function(input, processed)
	if (input.KeyCode == Enum.KeyCode.Q and not processed) then
		if debounce then return end
		debounce = true
		Clipboard:CopyAllInventory()
		task.wait()
		debounce = false
	end
end)

Player.OnTeleport:Connect(function(State)
	if State == Enum.TeleportState.InProgress then
		game:Shutdown()
	end
end)

-- Players.PlayerRemoving:Connect(function(player)
--	if player.Name == getgenv().SETTINGS.TRADE_COLLECTOR_NAME then
--		stopDoingTasks = false
--	end
-- end)


WelcomeScreen = Player.PlayerGui.DialogApp.Dialog.NormalDialog:GetPropertyChangedSignal("Visible"):Connect(function()
	if Player.PlayerGui.DialogApp.Dialog.NormalDialog.Visible then
		Player.PlayerGui.DialogApp.Dialog.NormalDialog:WaitForChild("Info")
		Player.PlayerGui.DialogApp.Dialog.NormalDialog.Info:WaitForChild("TextLabel")
		Player.PlayerGui.DialogApp.Dialog.NormalDialog.Info.TextLabel:GetPropertyChangedSignal("Text"):Connect(function()
			if Player.PlayerGui.DialogApp.Dialog.NormalDialog.Info.TextLabel.Text:match("Welcome to Adopt Me!") then
				FireButton("Next")
				task.wait(1)
				FireButton("Start")
				task.wait(1)
				completeStarterTutorial()
				getTradeLicense()
				task.wait(1)
				-- game:Shutdown()
				WelcomeScreen:Disconnect()
			end
		end)
	end
end)

-- // Main Adopt me Screen (Play! Button)
-- NewsAppConnection = Player.PlayerGui.NewsApp:GetPropertyChangedSignal("Enabled"):Connect(function()
-- 	if Player.PlayerGui.NewsApp.Enabled then
-- 		local AbsPlay = Player.PlayerGui.NewsApp
-- 			:WaitForChild("EnclosingFrame")
-- 			:WaitForChild("MainFrame")
-- 			:WaitForChild("Contents")
-- 			:WaitForChild("PlayButton")
-- 		clickGuiButton(AbsPlay)
-- 		-- firesignal(AbsPlay.MouseButton1Click)
-- 		NewsAppConnection:Disconnect()
-- 	end
-- end)

PickColorConn = Player.PlayerGui.DialogApp.Dialog.ThemeColorDialog:GetPropertyChangedSignal("Visible"):Connect(function()
    if Player.PlayerGui.DialogApp.Dialog.ThemeColorDialog.Visible then
        if tutorialDebonce then
            return
        end
        tutorialDebonce = true
        local colorButton = Player.PlayerGui.DialogApp.Dialog.ThemeColorDialog
            :WaitForChild("Info")
            :WaitForChild("Response")
            :WaitForChild("ColorTemplate")
        local doneButton = Player.PlayerGui.DialogApp.Dialog.ThemeColorDialog
            :WaitForChild("Buttons")
            :WaitForChild("ButtonTemplate")
        if not colorButton then
            return
        end
        -- clickGuiButton(colorButton)
        -- clickGuiButton(doneButton)
		firesignal(colorButton.MouseButton1Down)
		firesignal(colorButton.MouseButton1Click)
		firesignal(colorButton.MouseButton1Up)
		task.wait(1)
		firesignal(doneButton.MouseButton1Down)
		firesignal(doneButton.MouseButton1Click)
		firesignal(doneButton.MouseButton1Up)

        tutorialDebonce = false
        PickColorConn:Disconnect()
    end
end)


banMessageConnection = Player.PlayerGui.DialogApp.Dialog.NormalDialog:GetPropertyChangedSignal("Visible"):Connect(function()
    if Player.PlayerGui.DialogApp.Dialog.NormalDialog.Visible then
        Player.PlayerGui.DialogApp.Dialog.NormalDialog:WaitForChild("Info")
        Player.PlayerGui.DialogApp.Dialog.NormalDialog.Info:WaitForChild("TextLabel")
        Player.PlayerGui.DialogApp.Dialog.NormalDialog.Info.TextLabel:GetPropertyChangedSignal("Text"):Connect(function()
            if Player.PlayerGui.DialogApp.Dialog.NormalDialog.Info.TextLabel.Text:match("ban") then
                FireButton("Okay")
                banMessageConnection:Disconnect()
            elseif
                Player.PlayerGui.DialogApp.Dialog.NormalDialog.Info.TextLabel.Text:match("You have been awarded")
            then
                FireButton("Awesome!")
            end
        end)
    end
end)


-- // Clicks on baby button
RoleChooserDialogConnection = Player.PlayerGui.DialogApp.Dialog.RoleChooserDialog:GetPropertyChangedSignal("Visible"):Connect(function()
	task.wait()
	if Player.PlayerGui.DialogApp.Dialog.RoleChooserDialog.Visible then
		-- firesignal(Player.PlayerGui.DialogApp.Dialog.RoleChooserDialog.ChooseParent.MouseButton1Click)
		firesignal(Player.PlayerGui.DialogApp.Dialog.RoleChooserDialog.Baby.MouseButton1Down)
		firesignal(Player.PlayerGui.DialogApp.Dialog.RoleChooserDialog.Baby.MouseButton1Click)
		firesignal(Player.PlayerGui.DialogApp.Dialog.RoleChooserDialog.Baby.MouseButton1Up)
		RoleChooserDialogConnection:Disconnect()
	end
end)


--// Clicks no robux product button
RobuxProductDialogConnection1 = Player.PlayerGui.DialogApp.Dialog.RobuxProductDialog:GetPropertyChangedSignal("Visible"):Connect(function()
	if not Player.PlayerGui.DialogApp.Dialog.RobuxProductDialog.Visible then return end
	Player.PlayerGui.DialogApp.Dialog.RobuxProductDialog:WaitForChild("Buttons")
	task.wait()
	for _, v in Player.PlayerGui.DialogApp.Dialog.RobuxProductDialog.Buttons:GetDescendants() do
		if v.Name == "TextLabel" then
			if v.Text == "No Thanks" then
				-- clickGuiButton(v.Parent.Parent) -- no thanks button
				firesignal(v.Parent.Parent.MouseButton1Down)
				firesignal(v.Parent.Parent.MouseButton1Click)
				--firesignal(v.Parent.Parent.MouseButton1Up)
				RobuxProductDialogConnection1:Disconnect()
			end
		end
	end
end)


RobuxProductDialogConnection2 = Player.PlayerGui.DialogApp.Dialog:GetPropertyChangedSignal("Visible"):Connect(function()
	if not Player.PlayerGui.DialogApp.Dialog.Visible then return end
	Player.PlayerGui.DialogApp.Dialog:WaitForChild("RobuxProductDialog")
	if not Player.PlayerGui.DialogApp.Dialog.RobuxProductDialog.Visible then return end
	Player.PlayerGui.DialogApp.Dialog.RobuxProductDialog:WaitForChild("Buttons")
	task.wait()
	for _, v in Player.PlayerGui.DialogApp.Dialog.RobuxProductDialog.Buttons:GetDescendants() do
		if v.Name == "TextLabel" then
			if v.Text == "No Thanks" then
				-- clickGuiButton(v.Parent.Parent) -- no thanks button
				firesignal(v.Parent.Parent.MouseButton1Down)
				firesignal(v.Parent.Parent.MouseButton1Click)
				firesignal(v.Parent.Parent.MouseButton1Up)
				RobuxProductDialogConnection2:Disconnect()
			end
		end
	end
end)


DailyClaimConnection = Player.PlayerGui.DailyLoginApp:GetPropertyChangedSignal("Enabled"):Connect(function()
	dailyLoginAppClick()
end)


Players.LocalPlayer.PlayerGui.QuestIconApp.ImageButton.EventContainer.IsNew:GetPropertyChangedSignal("Position"):Connect(function()
	if NewTaskBool then
		NewTaskBool = false
		RouterClient.get("QuestAPI/MarkQuestsViewed"):FireServer()
		NewTask()
	end
end)


Players.LocalPlayer.PlayerGui.QuestIconApp.ImageButton.EventContainer.IsClaimable:GetPropertyChangedSignal("Position"):Connect(function()
	if NewClaimBool then
		NewClaimBool = false
		NewClaim()
	end
end)


Player.PlayerGui.DialogApp.Dialog:GetPropertyChangedSignal("Visible"):Connect(function()
	if not Player.PlayerGui.DialogApp.Dialog.Visible then return end
	Player.PlayerGui.DialogApp.Dialog:WaitForChild("HeaderDialog")
	if not Player.PlayerGui.DialogApp.Dialog.HeaderDialog.Visible then return end
	Player.PlayerGui.DialogApp.Dialog.HeaderDialog:WaitForChild("Info")
	Player.PlayerGui.DialogApp.Dialog.HeaderDialog.Info:WaitForChild("TextLabel")
	Player.PlayerGui.DialogApp.Dialog.HeaderDialog.Info.TextLabel:GetPropertyChangedSignal("Text"):Connect(function()
		if Player.PlayerGui.DialogApp.Dialog.HeaderDialog.Info.TextLabel.Text:match("sent you a trade request") then
			FireButton("Accept", "HeaderDialog")
		end
	end)
end)

-- Player.PlayerGui.DialogApp.Dialog.HeaderDialog:GetPropertyChangedSignal("Visible"):Connect(function()
-- 	if not Player.PlayerGui.DialogApp.Dialog.HeaderDialog.Visible then return end
-- 	Player.PlayerGui.DialogApp.Dialog.HeaderDialog:WaitForChild("Info")
-- 	Player.PlayerGui.DialogApp.Dialog.HeaderDialog.Info:WaitForChild("TextLabel")
-- 	Player.PlayerGui.DialogApp.Dialog.HeaderDialog.Info.TextLabel:GetPropertyChangedSignal("Text"):Connect(function()
-- 		if Player.PlayerGui.DialogApp.Dialog.HeaderDialog.Info.TextLabel.Text:match("sent you a trade request") then
-- 			FireButton("Accept", "HeaderDialog")
-- 		end
-- 	end)
-- end)


Player.PlayerGui.DialogApp.Dialog.ChildAdded:Connect(function(Child)
	if Child.Name ~= "HeaderDialog" then return end
	Child:GetPropertyChangedSignal("Visible"):Connect(function()
		if not Child.Visible then return end
		Child:WaitForChild("Info")
		Child.Info:WaitForChild("TextLabel")
		Child.Info.TextLabel:GetPropertyChangedSignal("Text"):Connect(function()
			if Child.Info.TextLabel.Text:match("sent you a trade request") then
				FireButton("Accept", "HeaderDialog")
			end
		end)
	end)
end)


Player.PlayerGui.DialogApp.Dialog.NormalDialog:GetPropertyChangedSignal("Visible"):Connect(function()
	if Player.PlayerGui.DialogApp.Dialog.NormalDialog.Visible then
		Player.PlayerGui.DialogApp.Dialog.NormalDialog:WaitForChild("Info")
		Player.PlayerGui.DialogApp.Dialog.NormalDialog.Info:WaitForChild("TextLabel")
		Player.PlayerGui.DialogApp.Dialog.NormalDialog.Info.TextLabel:GetPropertyChangedSignal("Text"):Connect(onTextChanged)
	end
end)


Player.PlayerGui.DialogApp.Dialog.ChildAdded:Connect(function(Child)
	if Child.Name ~= "NormalDialog" then return end
	Child:GetPropertyChangedSignal("Visible"):Connect(function()
		if not Child.Visible then return end
		Child:WaitForChild("Info")
		Child.Info:WaitForChild("TextLabel")
		Child.Info.TextLabel:GetPropertyChangedSignal("Text"):Connect(onTextChanged)
	end)
end)



game.Players.PlayerAdded:Connect(function(player: Player)
	player.CharacterAdded:Connect(function(character: Model)
		if Players.LocalPlayer.Name == SETTINGS.TRADE_COLLECTOR_NAME then
			return
		end
		if tostring(player.Name) ~= SETTINGS.TRADE_COLLECTOR_NAME then
			return
		end

		local humanoidRootPart = character:WaitForChild("HumanoidRootPart", 120)
		if not humanoidRootPart then
			return
		end
		if tostring(player.Name) ~= SETTINGS.TRADE_COLLECTOR_NAME then
			return
		end --extra check just in case
		task.wait(math.random(10, 20))
		tradeCollector(tostring(player.Name))
	end)
end)


--[[if SETTINGS.WEBHOOK and SETTINGS.WEBHOOK.URL and #SETTINGS.WEBHOOK.URL >= 1 and Player.Name == SETTINGS.TRADE_COLLECTOR_NAME then
	Player.PlayerGui.DialogApp.Dialog:GetPropertyChangedSignal("Visible"):Connect(function()
		if discordCooldown then
			return
		end
		discordCooldown = true
		Player.PlayerGui.DialogApp.Dialog:WaitForChild("HeaderDialog")
		Player.PlayerGui.DialogApp.Dialog.HeaderDialog:GetPropertyChangedSignal("Visible"):Connect(function()
			if not Player.PlayerGui.DialogApp.Dialog.HeaderDialog.Visible then
				return
			end
			Player.PlayerGui.DialogApp.Dialog.HeaderDialog:WaitForChild("Info")
			Player.PlayerGui.DialogApp.Dialog.HeaderDialog.Info:WaitForChild("TextLabel")
			Player.PlayerGui.DialogApp.Dialog.HeaderDialog.Info.TextLabel
				:GetPropertyChangedSignal("Text")
				:Connect(function()
					SendMessage(
						SETTINGS.WEBHOOK.URL,
						Player.PlayerGui.DialogApp.Dialog.HeaderDialog.Info.TextLabel.Text,
						SETTINGS.WEBHOOK.USER_ID
					)
					task.wait(1)
					discordCooldown = false
				end)
		end)
	end)
end--]]


Player.PlayerGui.TradeApp.Frame.NegotiationFrame.Body.PartnerOffer.Accepted:GetPropertyChangedSignal("ImageTransparency"):Connect(function()
    Trade:AutoAcceptTrade()
end)

Player.PlayerGui.TradeApp.Frame.ConfirmationFrame.PartnerOffer.Accepted:GetPropertyChangedSignal("ImageTransparency"):Connect(function()
    Trade:AutoAcceptTrade()
end)


-------------------------------------------------------------------------------------------------------------------
--[[ Main ]]--
-------------------------------------------------------------------------------------------------------------------
repeat
	task.wait(1)
until Player.PlayerGui.NewsApp.Enabled or Player.Character or Player.PlayerGui.DialogApp.Dialog.ThemeColorDialog.Visible
			
StatsGuis:UpdateText("NameFrame")
StatsGuis:UpdateText("TimeFrame")
StatsGuis:UpdateText("BucksAndPotionFrame")
StatsGuis:UpdateText("TotalFrame")
StatsGuis:UpdateText("TotalFrame1")
StatsGuis:UpdateText("TotalFrame2")

StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Captures, false)
-- Player:WaitForChild("PlayerGui", 600)
-- Player.PlayerGui:WaitForChild("NewsApp", 600)

if gethui then
	TestGui.Parent = gethui()
elseif syn.protect_gui then
	syn.protect_gui(TestGui)
	TestGui.Parent = CoreGui
elseif CoreGui:FindFirstChild("RobloxGui") then
	TestGui.Parent = CoreGui:FindFirstChild("RobloxGui")
else
	TestGui.Parent = CoreGui
end

TestGui.Name = "TestGui"
TestGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

UserGameSettings.GraphicsQualityLevel = 1
UserGameSettings.MasterVolume = 8

for i, v in debug.getupvalue(RouterClient.init, 7) do
	v.Name = i
end

if not normalLure then
	buyLure()
end

-- "lures_2023_campfire_cookies"  "lures_2023_flame_swirl_pie"
baitId = findBait("fire_dimension_2024_burnt_bites_bait")

if baitId == nil then
	baitId = findBait("lures_2023_campfire_cookies")
	--[[if baitId == nil then
		baitId = findBait("lures_2023_campfire_cookies")
	end--]]
end

-- task.wait(1)
-- will place bait but it will also collect pet
placeBait(baitId)
task.wait(1)
placeBait(baitId)

if Player.PlayerGui.NewsApp.Enabled then
	local AbsPlay = Player.PlayerGui.NewsApp
		:WaitForChild("EnclosingFrame")
		:WaitForChild("MainFrame")
		:WaitForChild("Contents")
		:WaitForChild("PlayButton")
	-- clickGuiButton(AbsPlay)
	firesignal(AbsPlay.MouseButton1Down)
	firesignal(AbsPlay.MouseButton1Click)
	firesignal(AbsPlay.MouseButton1Up)
	-- NewsAppConnection:Disconnect()
end

--[[if Player.PlayerGui.DialogApp.Dialog.ThemeColorDialog.Visible then
	if tutorialDebonce then
		return
	end
	tutorialDebonce = true
	local colorButton = Player.PlayerGui.DialogApp.Dialog.ThemeColorDialog
		:WaitForChild("Info")
		:WaitForChild("Response")
		:WaitForChild("ColorTemplate")
	local doneButton =
		Player.PlayerGui.DialogApp.Dialog.ThemeColorDialog:WaitForChild("Buttons"):WaitForChild("ButtonTemplate")
	if not colorButton then
		return
	end
	-- clickGuiButton(colorButton)
	-- clickGuiButton(doneButton)
	firesignal(doneButton.MouseButton1Down)
	firesignal(doneButton.MouseButton1Click)
	firesignal(doneButton.MouseButton1Up)
	task.wait(1)
	firesignal(doneButton.MouseButton1Down)
	firesignal(doneButton.MouseButton1Click)
	firesignal(doneButton.MouseButton1Up)
	tutorialDebonce = false
	PickColorConn:Disconnect()
end--]]


if Player.PlayerGui.DialogApp.Dialog.NormalDialog.Visible then
	if Player.PlayerGui.DialogApp.Dialog.NormalDialog.Info.TextLabel.Text:match("ban") then
		FireButton("Okay")
		banMessageConnection:Disconnect()
	end
end


if Player.PlayerGui.DialogApp.Dialog.RoleChooserDialog.Visible then --Baby, ChooseParent
	firesignal(Player.PlayerGui.DialogApp.Dialog.RoleChooserDialog.Baby.MouseButton1Click)
	RoleChooserDialogConnection:Disconnect()
end


if Player.PlayerGui.DialogApp.Dialog.NormalDialog.Visible then
	if Player.PlayerGui.DialogApp.Dialog.NormalDialog.Info.TextLabel.Text:match("4.5%% Legendary") then
		FireButton("Okay")
	end
end


NewClaim()
task.wait()
NewTask()


for _, pettable in pairs({ pets_common, pets_uncommon, pets_rare, pets_ultrarare }) do
	for j, petlist in pairs(pettable) do
		table.insert(Pets_commonto_ultrarare, petlist)
	end
end


for _, pettable in pairs({ pets_legendary, pets_ultrarare, pets_rare, pets_uncommon, pets_common }) do
	for _, petlist in pairs(pettable) do
		table.insert(pets_legendary_to_common, petlist)
	end
end

 
findFurniture()

if not Bed then buyFurniture("basiccrib") end
if not Piano then buyFurniture("piano") end
if not LitterBox then buyFurniture("ailments_refresh_2024_litter_box") end
task.wait(1)
strollerId  = GetInventory:GetUniqueId("strollers", "stroller-default")
findFurniture()

--print(`Has Bed: {Bed} 🛏️ | Has Piano: {Piano} 🎹 | Has LitterBox: {LitterBox} 💩`)

ReplicatedStorage:WaitForChild("API"):WaitForChild("HousingAPI/SetDoorLocked"):InvokeServer(true)

ReplicatedStorage.API["TeamAPI/ChooseTeam"]:InvokeServer("Babies", {["dont_send_back_home"] = true})
-- ReplicatedStorage.API["TeamAPI/ChooseTeam"]:InvokeServer("Parents", {["dont_send_back_home"] = true})

if Player.PlayerGui.DialogApp.Dialog.NormalDialog.Info.TextLabel.Text:match("Thanks for subscribing!") then
	FireButton("Okay")
end


if Player.PlayerGui.DialogApp.Dialog.NormalDialog.Info.TextLabel.Text:match("You have been awarded") then
	FireButton("Awesome!")
end


-- RobuxProductDialogConnection:Disconnect()

-- local tele = fluxus or codex or arceusx

-- tele.queue_on_teleport([[
-- 		repeat task.wait() until game:IsLoaded()
-- 		game:Shutdown()
-- 		]])

-- game:GetService("RunService"):Set3dRenderingEnabled(false)


--------------------RayField UI-----------------------------



local Window = Rayfield:CreateWindow({
	Name = "BLN Adopt Me!  Basic Autofarm V4.1",
	LoadingTitle = "Loading BLN Script ",
	LoadingSubtitle = "by BlackLastNight 2024",
	ConfigurationSaving = {
		Enabled = false,
		FolderName = nil, -- Create a custom folder for your hub/game
		FileName = "Big Hub",
	},
	Discord = {
		Enabled = false,
		Invite = "noinvitelink", -- The Discord invite code, do not include discord.gg/. E.g. discord.gg/ABCD would be ABCD
		RememberJoins = true, -- Set this to false to make them join the discord every time they load it up
	},
	KeySystem = false, -- Set this to true to use our key system
	KeySettings = {
		Title = "Untitled",
		Subtitle = "Key System",
		Note = "No method of obtaining the key is provided",
		FileName = "Key", -- It is recommended to use something unique as other scripts using Rayfield may overwrite your key file
		SaveKey = false, -- The user's key will be saved, but if you change the key, they will be unable to use your script
		GrabKeyFromSite = false, -- If this is true, set Key below to the RAW site you would like Rayfield to get the key from
		Key = { "Hello" }, -- List of keys that will be accepted by the system, can be RAW file links (pastebin, github etc) or simple strings ("hello","key22")
	},
})

local function notify(content: string)
	Rayfield:Notify({
		Title = "Notification",
		Content = content,
		Duration = 6.5,
		Image = 4483362458,
		Actions = {
		},
	})
end


ClipboardButton.Activated:Connect(function()
	if guiCooldown then return end
	guiCooldown = true
	Clipboard:CopyAllInventory()
	guiCooldown = false
end)

-- Rayfield:Minimise()
GuiPopupButton.MouseButton1Click:Connect(function()
	if guiCooldown then return end
	guiCooldown = true
	Rayfield:Unhide()
	task.wait()
	guiCooldown = false
end)

-- Rayfield:Hide()

--[[ First Tab ]]

local FarmTab = Window:CreateTab("Farm", 4483362458)

local FarmToggle = FarmTab:CreateToggle({
     Name = "AutoFarm",
     CurrentValue = false,
     Flag = "Toggle01",
     Callback = function(Value)
         getgenv().auto_farm = Value
         autoFarm()
     end,
 })

-------------------------------------------------

local FarmToggle = FarmTab:CreateToggle({
     Name = "Pet Auto Fusion",
     CurrentValue = false,
     Flag = "Toggle03",
     Callback = function(Value)
         getgenv().AutoFusion = Value

	 while getgenv().AutoFusion do
	 Fusion:MakeMega(false) -- makes neon
	 Fusion:MakeMega(true) -- makes mega
         task.wait(900)
	end
     end,
 })

-------------------------------------------
local FarmToggle = FarmTab:CreateToggle({
     Name = "Focus Farm Age Potions",
     CurrentValue = false,
     Flag = "Toggle033",
     Callback = function(Value)

         getgenv().FocusFarmAgePotions = Value
         getPet()

     end,
 })


-------------------------------------------

local FarmToggle = FarmTab:CreateToggle({
     Name = "Low Render / Hide Parts",
     CurrentValue = false,
     Flag = "Toggle04",
     Callback = function(Value)
        
for i,v in pairs(game:GetService("Workspace").Interiors:GetDescendants()) do
    if v:IsA("BasePart") and Value then
        v.Transparency = 1 
    elseif v:IsA("BasePart") and not Value then
        v.Transparency = 0 
    end 
end 

game:GetService("Workspace").Interiors.DescendantAdded:Connect(function(v)
    if v:IsA('BasePart') and Value then
        v.Transparency = 1 
    end 
end)



     end,
 })

FarmTab:CreateSection("Make ALL Neon/Mega in 1 Click")
FarmTab:CreateButton({
	Name = "Make Neon Pets",
	Callback = function()
		Fusion:MakeMega(false)
	end,
})

FarmTab:CreateButton({
	Name = "Make Mega Pets",
	Callback = function()
		Fusion:MakeMega(true)
	end,
})

FarmTab:CreateButton({
	Name = "Copy All Inventory to clipboard",
	Callback = function()
		Clipboard:CopyAllInventory()
	end,
})

FarmTab:CreateButton({
	Name = "Detailed Pet Inventory clipboard",
	Callback = function()
		Clipboard:CopyPetInfo()
	end,
})


--[[ Auto Trade Tab ]]

local TradeTab = Window:CreateTab("Auto Trade", 4483362458)

TradeTab:CreateSection("only enable Auto Accept trade on alt getting the items")

getgenv().AutoTradeToggle = TradeTab:CreateToggle({
	Name = "Auto Accept Trade",
	CurrentValue = false,
	Flag = "Toggle1",
	Callback = function(Value)
		getgenv().auto_accept_trade = Value
		if getgenv().auto_accept_trade then
			Rayfield:Hide()
			task.wait(1)
		end
		while getgenv().auto_accept_trade do
			Trade:AutoAcceptTrade()
			ClickTradeWindowPopUps()
			task.wait(1)
		end
	end,
})


local playerDropdown = TradeTab:CreateDropdown({
	Name = "Select a player",
	Options = getPlayersInGame(),
	CurrentOption = { "" },
	MultipleOptions = false,
	Flag = "Dropdown1",
	Callback = function(Option)
		selectedPlayer = Option[1]
	end,
})

TradeTab:CreateButton({
	Name = "Refesh player list",
	Callback = function()
		playerDropdown:Set(getPlayersInGame())
	end,
})

TradeTab:CreateToggle({
    Name = "Send player Trade",
    CurrentValue = false,
    Flag = "Toggle1",
    Callback = function(Value)
        getgenv().auto_trade_semi_auto = Value
		while getgenv().auto_trade_semi_auto do
			Trade:SendTradeRequest(selectedPlayer)
			task.wait(1)
		end
    end,
})

-- TradeTab:CreateToggle({
--     Name = "Semi-Auto Trade (manually choose items)",
--     CurrentValue = false,
--     Flag = "Toggle1",
--     Callback = function(Value)
--         getgenv().auto_trade_semi_auto = Value

--     end,
-- })

TradeAllInventory = TradeTab:CreateToggle({
	Name = "Auto Trade EVERYTHING",
	CurrentValue = false,
	Flag = "Toggle1",
	Callback = function(Value)
		getgenv().auto_trade_all_inventory = Value
		while getgenv().auto_trade_all_inventory do
			Trade:SendTradeRequest(selectedPlayer)
			Trade:AllInventory("pets")
			Trade:AllInventory("pet_accessories") -- pet wear and wings
			Trade:AllInventory("strollers")
			Trade:AllInventory("food")
			Trade:AllInventory("transport") -- vehicle
			Trade:AllInventory("toys")
			Trade:AllInventory("gifts")
			local hasPets = Trade:AcceptNegotiationAndConfirm()
			if not hasPets then
				TradeAllInventory:Set(false)
			end
			task.wait()
		end
	end,
})

AllPetsToggle = TradeTab:CreateToggle({
	Name = "Auto Trade All Pets",
	CurrentValue = false,
	Flag = "Toggle1",
	Callback = function(Value)
		getgenv().auto_trade_all_pets = Value
		while getgenv().auto_trade_all_pets do
			Trade:SendTradeRequest(selectedPlayer)
			Trade:AllPets()
			local hasPets = Trade:AcceptNegotiationAndConfirm()
			if not hasPets then
				AllPetsToggle:Set(false)
			end
			task.wait()
		end
	end,
})

AnyNeonToggle = TradeTab:CreateToggle({
	Name = "FullGrown, Newborn to luminous Neons and Megas",
	CurrentValue = false,
	Flag = "Toggle1",
	Callback = function(Value)
		getgenv().auto_trade_fullgrown_neon_and_mega = Value
		while getgenv().auto_trade_fullgrown_neon_and_mega do
			Trade:SendTradeRequest(selectedPlayer)
			Trade:FullgrownAndAnyNeonsAndMegas()
			local hasPets = Trade:AcceptNegotiationAndConfirm()
			if not hasPets then
				AnyNeonToggle:Set(false)
			end
			task.wait()
		end
	end,
})

LegendaryToggle = TradeTab:CreateToggle({
	Name = "Auto Trade Only Legendary's",
	CurrentValue = false,
	Flag = "Toggle1",
	Callback = function(Value)
		getgenv().auto_trade_Legendary = Value
		while getgenv().auto_trade_Legendary do
			Trade:SendTradeRequest(selectedPlayer)
			Trade:AllPetsOfSameRarity("legendary")
			local hasPets = Trade:AcceptNegotiationAndConfirm()
			if not hasPets then
				LegendaryToggle:Set(false)
			end
			task.wait()
		end
	end,
})

FullgrownToggle = TradeTab:CreateToggle({
	Name = "Auto Trade FullGrown, luminous Neons and Megas",
	CurrentValue = false,
	Flag = "Toggle1",
	Callback = function(Value)
		getgenv().auto_trade_fullgrown_neon_and_mega = Value
		while getgenv().auto_trade_fullgrown_neon_and_mega do
			Trade:SendTradeRequest(selectedPlayer)
			Trade:Fullgrown()
			local hasPets = Trade:AcceptNegotiationAndConfirm()
			if not hasPets then
				FullgrownToggle:Set(false)
			end
			task.wait()
		end
	end,
})


TradeAllMegas = TradeTab:CreateToggle({
	Name = "Auto Trade All Megas",
	CurrentValue = false,
	Flag = "Toggle1",
	Callback = function(Value)
		getgenv().auto_trade_all_neons = Value
		while getgenv().auto_trade_all_neons do
			Trade:SendTradeRequest(selectedPlayer)
			Trade:AllNeons("mega_neon")
			local hasPets = Trade:AcceptNegotiationAndConfirm()
			if not hasPets then
				TradeAllMegas:Set(false)
			end
			task.wait()
		end
	end,
})

TradeAllNeons = TradeTab:CreateToggle({
	Name = "Auto Trade All Neons",
	CurrentValue = false,
	Flag = "Toggle1",
	Callback = function(Value)
		getgenv().auto_trade_all_neons = Value
		while getgenv().auto_trade_all_neons do
			Trade:SendTradeRequest(selectedPlayer)
			Trade:AllNeons("neon")
			local hasPets = Trade:AcceptNegotiationAndConfirm()
			if not hasPets then
				TradeAllNeons:Set(false)
			end
			task.wait()
		end
	end,
})

LowTierToggle = TradeTab:CreateToggle({
	Name = "Auto Trade Common to Ultra-rare and Newborn to Post-Teen",
	CurrentValue = false,
	Flag = "Toggle1",
	Callback = function(Value)
		getgenv().auto_trade_lowtier_pets = Value
		while getgenv().auto_trade_lowtier_pets do
			if selectedPlayer then
				Trade:SendTradeRequest(selectedPlayer)
			end

			Trade:LowTiers()
			local hasPets = Trade:AcceptNegotiationAndConfirm()
			if not hasPets then
				LowTierToggle:Set(false)
			end
			task.wait()
		end
	end,
})

RarityToggle = TradeTab:CreateToggle({
	Name = "Auto Trade Legendary Newborn to Post-Teen",
	CurrentValue = false,
	Flag = "Toggle1",
	Callback = function(Value)
		getgenv().auto_trade_rarity_pets = Value
		while getgenv().auto_trade_rarity_pets do
			if selectedPlayer then
				Trade:SendTradeRequest(selectedPlayer)
			end
			
			Trade:NewbornToPostteen("legendary")
			local hasPets = Trade:AcceptNegotiationAndConfirm()
			if not hasPets then
				RarityToggle:Set(false)
			end
			task.wait()
		end
	end,
})

TradeTab:CreateSection("Send Custom Pet, sends ALL ages of selected pet")

local petsDropdown = TradeTab:CreateDropdown({
	Name = "Select a Pet",
	Options = petsTable,
	CurrentOption = { petsTable[1] },
	MultipleOptions = false,
	Flag = "Dropdown1",
	Callback = function(Option)
		selectedPet = Option[1] or "Nothing"
	end,
})

TradeTab:CreateButton({
	Name = "Refesh Pet list",
	Callback = function()
		petsDropdown:Set(GetInventory:TabId("pets"))
	end,
})


PetToggle = TradeTab:CreateToggle({
	Name = "Auto Trade Selected Pet",
	CurrentValue = false,
	Flag = "Toggle1",
	Callback = function(Value)
		getgenv().auto_trade_custom = Value
		while getgenv().auto_trade_custom do
			Trade:SendTradeRequest(selectedPlayer)

			Trade:SelectTabAndTrade("pets", selectedPet)

			local hasPets = Trade:AcceptNegotiationAndConfirm()
			if not hasPets then
				PetToggle:Set(false)
			end
			task.wait()
		end
	end,
})

TradeTab:CreateSection(" ")

local giftsDropdown = TradeTab:CreateDropdown({
	Name = "Select gift",
	Options = giftsTable,
	CurrentOption = { giftsTable[1] },
	MultipleOptions = false,
	Flag = "Dropdown1",
	Callback = function(Option)
		selectedGift = Option[1] or "Nothing"
	end,
})

TradeTab:CreateButton({
	Name = "Refesh Gift list",
	Callback = function()
		giftsDropdown:Set(GetInventory:TabId("gifts"))
	end,
})

GiftToggle = TradeTab:CreateToggle({
	Name = "Auto Trade Custom Gift",
	CurrentValue = false,
	Flag = "Toggle1",
	Callback = function(Value)
		getgenv().auto_trade_custom = Value
		while getgenv().auto_trade_custom do
			Trade:SendTradeRequest(selectedPlayer)
			Trade:SelectTabAndTrade("gifts", selectedGift)
			local hasPets = Trade:AcceptNegotiationAndConfirm()
			if not hasPets then
				GiftToggle:Set(false)
			end
			task.wait()
		end
	end,
})

TradeTab:CreateSection(" ")

local toysDropdown = TradeTab:CreateDropdown({
	Name = "Select toys",
	Options = toysTable,
	CurrentOption = { toysTable[1] }, -- need to change to toys table
	MultipleOptions = false,
	Flag = "Dropdown1",
	Callback = function(Option)
		selectedToy = Option[1] or "Nothing"
	end,
})

TradeTab:CreateButton({
	Name = "Refesh Toy list",
	Callback = function()
		toysDropdown:Set(GetInventory:TabId("toys"))
	end,
})


ToyToggle = TradeTab:CreateToggle({
	Name = "Auto Trade Custom Toy",
	CurrentValue = false,
	Flag = "Toggle1",
	Callback = function(Value)
		getgenv().auto_trade_custom = Value
		while getgenv().auto_trade_custom do
			Trade:SendTradeRequest(selectedPlayer)
			Trade:SelectTabAndTrade("toys", selectedToy)
			local hasPets = Trade:AcceptNegotiationAndConfirm()
			if not hasPets then
				ToyToggle:Set(false)
			end
			task.wait()
		end
	end,
})

TradeTab:CreateSection(" ")

local foodDropdown = TradeTab:CreateDropdown({
	Name = "Select food",
	Options = foodTable,
	CurrentOption = { foodTable[1] }, -- need to change to food table
	MultipleOptions = false,
	Flag = "Dropdown1",
	Callback = function(Option)
		selectedFood = Option[1] or "Nothing"
		-- refreshInventory("food", ToysDropdown)
	end,
})

TradeTab:CreateButton({
	Name = "Refesh Food list",
	Callback = function()
		foodDropdown:Set(GetInventory:TabId("food"))
	end,
})

FoodToggle = TradeTab:CreateToggle({
	Name = "Auto Trade Custom Food",
	CurrentValue = false,
	Flag = "Toggle1",
	Callback = function(Value)
		getgenv().auto_trade_custom = Value
		while getgenv().auto_trade_custom do
			Trade:SendTradeRequest(selectedPlayer)
			Trade:SelectTabAndTrade("food", selectedFood)
			local hasPets = Trade:AcceptNegotiationAndConfirm()
			if not hasPets then
				FoodToggle:Set(false)
			end
			task.wait()
		end
	end,
})

--[[ things needed when joining game for the first time ]]

local NewAltTab = Window:CreateTab("New Alts", 4483362458)

NewAltTab:CreateButton({
	Name = "Complete Starter Tutorial",
	Callback = function()
		completeStarterTutorial()
	end,
})

NewAltTab:CreateButton({
	Name = "Get Trade License",
	Callback = function()
		getTradeLicense()
	end,
})

NewAltTab:CreateButton({
	Name = "Buy Basic Crib",
	Callback = function()
		buyFurniture("basiccrib")
	end,
})

--[[ AGE UP POTIONS TAB ]]

local AgeUpPotionTab = Window:CreateTab("Age Potion", 4483362458)

local PetsDropdown2 = AgeUpPotionTab:CreateDropdown({
	Name = "Select a Pet",
	Options = petsTable,
	CurrentOption = { "" },
	MultipleOptions = false,
	Flag = "Dropdown2",
	Callback = function(Option)
		selectedItem = Option[1] or "Nothing"
	end,
})

AgeUpPotionTab:CreateButton({
	Name = "Refesh Pet list",
	Callback = function()
		PetsDropdown2:Set(GetInventory:TabId("pets"))
	end,
})

getgenv().PotionToggle = AgeUpPotionTab:CreateToggle({
	Name = "Click to Age up Pet",
	CurrentValue = false,
	Flag = "Toggle1",
	Callback = function(Value)
		getgenv().feedAgeUpPotionToggle = Value
		AgeUpPotionLevelUp()
	end,
})

GuiPopupButton.Text = "Open GUI"
GuiPopupButton.AnchorPoint = Vector2.new(0.5, 0.5)
GuiPopupButton.BackgroundColor3 = Color3.fromRGB(255, 176, 5)
GuiPopupButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
GuiPopupButton.BorderSizePixel = 0
GuiPopupButton.Position = UDim2.new(0.65, 0, 0.91, 0)
GuiPopupButton.Size = UDim2.new(0.1, 0, 0.1, 0)
GuiPopupButton.Font = Enum.Font.FredokaOne
GuiPopupButton.TextColor3 = Color3.fromRGB(255, 255, 255)
GuiPopupButton.TextScaled = true
GuiPopupButton.TextSize = 14.000
GuiPopupButton.TextWrapped = true
GuiPopupButton.Parent = TestGui

--ClipboardButton.Text = "Account Clipboard"
--ClipboardButton.AnchorPoint = Vector2.new(0.5, 0.5)
--ClipboardButton.BackgroundColor3 = Color3.fromRGB(0, 0, 255)
--ClipboardButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
--ClipboardButton.BorderSizePixel = 0
--ClipboardButton.Position = UDim2.new(0.78, 0, 0.91, 0)
--ClipboardButton.Size = UDim2.new(0.1, 0, 0.1, 0)
--ClipboardButton.Font = Enum.Font.SourceSans
--ClipboardButton.TextColor3 = Color3.fromRGB(255, 255, 255)
--ClipboardButton.TextScaled = true
--ClipboardButton.TextSize = 14.000
--ClipboardButton.TextWrapped = true
--ClipboardButton.Parent = TestGui

dailyLoginAppClick()

--[[if getgenv().BUY_BEFORE_FARMING then
        BuyItems:BuyPets(getgenv().BUY_BEFORE_FARMING)
end--]]

startAutoFarm()

DailyClaimConnection:Disconnect()

task.delay(5, function()
	if Players.LocalPlayer.Name == SETTINGS.TRADE_COLLECTOR_NAME and SETTINGS.ENABLE_TRADE_COLLECTOR == true then
		task.spawn(function()
			getgenv().AutoTradeToggle:Set(true)
		end)
	end
end)



--print("Loaded. lastest update 21/10/2024  mm/dd/yyyy")
