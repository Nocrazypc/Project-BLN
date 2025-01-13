if not game:IsLoaded() then
        game.Loaded:Wait()
end

if game.PlaceId ~= 920587237 then
    return
end

--------------- modules -------------------
--local Clipboard = loadstring(game:HttpGet("https://raw.githubusercontent.com/Nocrazypc/Project-BLN/refs/heads/main/ClipboardP.lua"))()
local Fusion = loadstring(game:HttpGet("https://raw.githubusercontent.com/Nocrazypc/Project-BLN/refs/heads/main/Fus.lua"))()
local GetInventory = loadstring(game:HttpGet("https://raw.githubusercontent.com/Nocrazypc/Project-BLN/refs/heads/main/GetInv.lua"))()
local Trade = loadstring(game:HttpGet("https://raw.githubusercontent.com/Nocrazypc/Project-BLN/refs/heads/main/Tra.lua"))()
local Teleport = loadstring(game:HttpGet("https://raw.githubusercontent.com/Nocrazypc/Project-BLN/refs/heads/main/Tele.lua"))()
-- local Keyboard = loadstring(game:HttpGet("https://raw.githubusercontent.com/Nocrazypc/Project-BLN/refs/heads/main/Keyboard.lua"))()
local Ailments = loadstring(game:HttpGet("https://raw.githubusercontent.com/Nocrazypc/Project-BLN/refs/heads/main/Deleted%20Files/Ailm.lua"))()
local StatsGuis = loadstring(game:HttpGet("https://raw.githubusercontent.com/Nocrazypc/Project-BLN/refs/heads/main/Stats.lua"))()
local Tutorials = loadstring(game:HttpGet("https://raw.githubusercontent.com/Nocrazypc/Project-BLN/refs/heads/main/Tutorials.lua"))()
local BulkPotions = loadstring(game:HttpGet("https://raw.githubusercontent.com/Nocrazypc/Project-BLN/refs/heads/main/BulkP.lua"))()
local TaskBoard = loadstring(game:HttpGet("https://raw.githubusercontent.com/Nocrazypc/Project-BLN/refs/heads/main/TaskB.lua"))()
local Clipboard = loadstring(game:HttpGet("https://raw.githubusercontent.com/Nocrazypc/Project-BLN/refs/heads/main/ClipB.lua"))()
local clipboard = Clipboard.new()
local taskBoard = TaskBoard.new()

local Players = game:GetService('Players')
local Workspace = game:GetService('Workspace')
local ReplicatedStorage = game:GetService('ReplicatedStorage')
local UserInputService = game:GetService('UserInputService')
local Lighting = game:GetService('Lighting')
local UserGameSettings = UserSettings():GetService('UserGameSettings')
local VirtualUser = game:GetService('VirtualUser')
local CoreGui = game:GetService('CoreGui')
local StarterGui = game:GetService('StarterGui')
local ClientData = require(ReplicatedStorage:WaitForChild('ClientModules'):WaitForChild('Core'):WaitForChild('ClientData'))
local RouterClient = require(ReplicatedStorage.ClientModules.Core:WaitForChild('RouterClient'):WaitForChild('RouterClient'))
local CollisionsClient = require(ReplicatedStorage.ClientModules.Game:WaitForChild('CollisionsClient'))
local localPlayer = Players.LocalPlayer
local Player = Players.LocalPlayer

local PickColorConn
local WelcomeScreen
local RoleChooserDialogConnection
local RobuxProductDialogConnection1
local RobuxProductDialogConnection2
local banMessageConnection
local DailyClaimConnection
local counter = 0
local isNewAccount = false
local isInMiniGame = false
local isBuyingOrAging = false
local guiCooldown = false
local tutorialDebonce = false
local discordCooldown = false
local debounce = false
local StarterGui = game:GetService("StarterGui")

--- Welcome MSG -------

StarterGui:SetCore(
    "SendNotification",
    {
        Title = "Hello Potato 😊",
        Text = "We're Back.. Be Happy!"
    }
)

local Bed
local Shower
local Piano
local NormalLure
local LitterBox
local strollerId
local baitId
local selectedPlayer
local selectedPet
local selectedGift
local selectedToy
local selectedFood
--local Rayfield = loadstring(game:HttpGet("https://raw.githubusercontent.com/Nocrazypc/Rayfield/main/source"))()
local Rayfield = loadstring(game:HttpGet("https://raw.githubusercontent.com/Nocrazypc/Rayfield/main/source.lua"))()
--local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

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
getgenv().PetCurrentlyFarming = ''
getgenv().AutoFusion = false
getgenv().FocusFarmAgePotions = false

--getgenv().AutoMinigame = false
--getgenv().AutoFCMinigame = false

local Egg2Buy = getgenv().SETTINGS.PET_TO_BUY
local TestGui = Instance.new('ScreenGui')
local GuiPopupButton = Instance.new('TextButton')
local ClipboardButton = Instance.new('TextButton')
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
local DailyRewardTable = {
    [9] = 'reward_1',
    [30] = 'reward_2',
    [90] = 'reward_3',
    [140] = 'reward_4',
    [180] = 'reward_5',
    [210] = 'reward_6',
    [230] = 'reward_7',
    [280] = 'reward_8',
    [300] = 'reward_9',
    [320] = 'reward_10',
    [360] = 'reward_11',
    [400] = 'reward_12',
    [460] = 'reward_13',
    [500] = 'reward_14',
    [550] = 'reward_15',
    [600] = 'reward_16',
    [660] = 'reward_17',
}
local DailyRewardTable2 = {
    [9] = 'reward_1',
    [65] = 'reward_2',
    [120] = 'reward_3',
    [180] = 'reward_4',
    [225] = 'reward_5',
    [280] = 'reward_6',
    [340] = 'reward_7',
    [400] = 'reward_8',
    [450] = 'reward_9',
    [520] = 'reward_10',
    [600] = 'reward_11',
    [660] = 'reward_12',
}
local petsTable = GetInventory:TabId('pets')

if #petsTable == 0 then
    petsTable = {
        'Nothing',
    }
end

local giftsTable = GetInventory:TabId('gifts')

if #giftsTable == 0 then
    giftsTable = {
        'Nothing',
    }
end

local toysTable = GetInventory:TabId('toys')

if #toysTable == 0 then
    toysTable = {
        'Nothing',
    }
end

local foodTable = GetInventory:TabId('food')

if #foodTable == 0 then
    foodTable = {
        'Nothing',
    }
end

local pets_legendary = {}
local pets_ultrarare = {}
local pets_rare = {}
local pets_uncommon = {}
local pets_common = {}
local Pets_commonto_ultrarare = {}
local pets_legendary_to_common = {}
local fireButton = function(button)
    local success, errorMessage = pcall(function()
        firesignal(button.MouseButton1Down)
        firesignal(button.MouseButton1Click)
        firesignal(button.MouseButton1Up)
    end)

    print(success, errorMessage)
end
local findButton = function(text, dialogFramePassOn)
    task.wait()

    local dialogFrame = dialogFramePassOn or 'NormalDialog'

    for _, v in localPlayer.PlayerGui.DialogApp.Dialog[dialogFrame].Buttons:GetDescendants()do
        if v:IsA('TextLabel') then
            if v.Text == text then
                fireButton(v)

                break
            end
        end
    end
end
local findFurniture = function()
    if Bed and Piano and LitterBox and NormalLure then
        return
    end

    for key, value in ClientData.get_data()[localPlayer.Name].house_interior.furniture do
        if value.id == 'basiccrib' then
            Bed = key
        elseif value.id == 'stylishshower' or value.id == 'modernshower' then
            Shower = key
        elseif value.id == 'piano' then
            Piano = key
        elseif value.id == 'lures_2023_normal_lure' then
            NormalLure = key
        elseif value.id == 'ailments_refresh_2024_litter_box' then
            LitterBox = key
        end
    end
end
local buyFurniture = function(furnitureId)
    print(`\u{1f4b8} No {furnitureId}, so buying it \u{1f4b8}`)

    local args = {
        {
            {
                ['kind'] = furnitureId,
                ['properties'] = {
                    ['cframe'] = CFrame.new(14, 2, -22) * CFrame.Angles(-0, 8.7, 3.8),
                },
            },
        },
    }

    ReplicatedStorage:WaitForChild('API'):WaitForChild('HousingAPI/BuyFurnitures'):InvokeServer(unpack(args))
end
local grabDailyReward = function()
    local Daily = ClientData.get('daily_login_manager')

    if Daily.prestige % 2 == 0 then
        for i, v in pairs(DailyRewardTable)do
            if i < Daily.stars or i == Daily.stars then
                if not Daily.claimed_star_rewards[v] then
                    ReplicatedStorage.API:FindFirstChild('DailyLoginAPI/ClaimStarReward'):InvokeServer(v)
                end
            end
        end
    else
        for i, v in pairs(DailyRewardTable2)do
            if i < Daily.stars or i == Daily.stars then
                if not Daily.claimed_star_rewards[v] then
                    ReplicatedStorage.API:FindFirstChild('DailyLoginAPI/ClaimStarReward'):InvokeServer(v)
                end
            end
        end
    end
end
local isMuleInGame = function()
    for _, player in Players:GetPlayers()do
        if player.Name == localPlayer.Name then
            continue
        end
        if player.Name == getgenv().SETTINGS.TRADE_COLLECTOR_NAME then
            return true
        end
    end

    return false
end
local getPlayersInGame = function()
    local playerTable = {
        'Nothing',
    }

    for _, player in Players:GetPlayers()do
        if player.Name == localPlayer.Name then
            continue
        end

        table.insert(playerTable, player.Name)
    end

    table.sort(playerTable)

    return playerTable
end

local findBait = function(baitPassOn)
    local bait

    for _, v in pairs(ClientData.get_data()[localPlayer.Name].inventory.food)do
        if v.id == baitPassOn then
            bait = v.unique

            return bait
        end
    end

    return nil
end

local function placeBaitOrPickUp(baitIdPasson)
    if not NormalLure then
        return
    end

    --print('placing bait or picking up')

    local args = {
        [1] = game:GetService('Players').LocalPlayer,
        [2] = NormalLure,
        [3] = 'UseBlock',
        [4] = {
            ['bait_unique'] = baitIdPasson,
        },
        [5] = game:GetService('Players').LocalPlayer.Character,
    }
    local success, errorMessage = pcall(function()
        ReplicatedStorage.API:FindFirstChild('HousingAPI/ActivateFurniture'):InvokeServer(unpack(args))
    end)

    --print('FIRING BAITBOX', success, errorMessage)
end

local agePotionCount = function(nameId)
    local count = 0

    for _, v in ClientData.get_data()[localPlayer.Name].inventory.food do
        if v.id == nameId then
            count += 1
        end
    end

    return count
end

local getEgg = function()
    for _, v in pairs(ClientData.get_data()[localPlayer.Name].inventory.pets)do
        if v.id == Egg2Buy and v.id ~= 'practice_dog' and v.properties.age ~= 6 and not v.properties.mega_neon then
            ReplicatedStorage.API['ToolAPI/Equip']:InvokeServer(v.unique, {
                ['use_sound_delay'] = true,
            })

            PetCurrentlyFarming = v.unique

            return true
        end
    end

    local BuyEgg = ReplicatedStorage.API['ShopAPI/BuyItem']:InvokeServer('pets', Egg2Buy, {})

    if BuyEgg == 'too little money' then
        return false
    end

    task.wait(1)

    return false
end
local getPet = function()
    if getgenv().SETTINGS.FOCUS_FARM_AGE_POTION or getgenv().FocusFarmAgePotions then
        if GetInventory:GetPetFriendship() then
            return
        end
        if GetInventory:PetRarityAndAge('common', 6) then
            return
        end
        if GetInventory:PetRarityAndAge('legendary', 6) then
            return
        end
        if GetInventory:PetRarityAndAge('ultra_rare', 6) then
            return
        end
        if GetInventory:PetRarityAndAge('rare', 6) then
            return
        end
        if GetInventory:PetRarityAndAge('uncommon', 6) then
            return
        end
    end
    if getgenv().SETTINGS.PET_NEON_PRIORITY then
        if GetInventory:GetNeonPet() then
            return
        end
    end
    if getgenv().SETTINGS.PET_ONLY_PRIORITY then
        if GetInventory:PriorityPet() then
            return
        end
    end
    if getgenv().SETTINGS.HATCH_EGG_PRIORITY then
        if GetInventory:PriorityEgg() then
            return
        end

        ReplicatedStorage.API['ShopAPI/BuyItem']:InvokeServer('pets', getgenv().SETTINGS.HATCH_EGG_PRIORITY_NAMES[1], {})

        return
    end
    if GetInventory:PetRarityAndAge('legendary', 5) then
        return
    end
    if GetInventory:PetRarityAndAge('ultra_rare', 5) then
        return
    end
    if GetInventory:PetRarityAndAge('rare', 5) then
        return
    end
    if GetInventory:PetRarityAndAge('uncommon', 5) then
        return
    end
    if GetInventory:PetRarityAndAge('common', 5) then
        return
    end
    if getEgg() then
        return
    end
end
local removeHandHeldItem = function()
    local tool = localPlayer.Character:FindFirstChildOfClass('Tool')

    if tool then
        ReplicatedStorage.API['ToolAPI/Unequip']:InvokeServer(tool.unique.Value, {})
    end
end
local CheckifEgg = function()
    local PetUniqueID = ClientData.get('pet_char_wrappers')[1]['pet_unique']
    local PetAge = ClientData.get('pet_char_wrappers')[1]['pet_progression']['age']

    if PetUniqueID == PetCurrentlyFarming then
        return
    end
    if PetAge ~= 1 then
        return
    end

    getPet()
end
local SwitchOutFullyGrown = function()
    if isBuyingOrAging then
        return
    end
    if ClientData.get('pet_char_wrappers')[1] == nil or false then
        getPet()

        return
    end

    local PetAge = ClientData.get('pet_char_wrappers')[1]['pet_progression']['age']

    if PetAge == 6 then
        getPet()

        return
    elseif PetAge == 1 then
        CheckifEgg()
    end
end
local ClickTradeWindowPopUps = function()
    for _, v in pairs(localPlayer.PlayerGui.DialogApp.Dialog.NormalDialog.Buttons:GetDescendants())do
        if v.Name == 'TextLabel' then
            if v.Text == 'Accept' or v.Text == 'Okay' or v.Text == 'Next' or v.Text == 'I understand' or v.Text == 'No' then
                fireButton(v.Parent.Parent)

                return
            end
        end
    end
    for _, v in pairs(localPlayer.PlayerGui.DialogApp.Dialog.HeaderDialog.Buttons:GetDescendants())do
        if v.Name == 'TextLabel' then
            if v.Text == 'Accept' or v.Text == 'Okay' or v.Text == 'Next' or v.Text == 'I understand' then
                fireButton(v.Parent.Parent)

                return
            end
        end
    end
end
local checkInventory = function()
    if not Players[getgenv().SETTINGS.TRADE_COLLECTOR_NAME] then
        return false, 'false', nil
    end

    for _, accessory in pairs(ClientData.get_data()[localPlayer.Name].inventory.pet_accessories)do
        if not getgenv().SETTINGS.TRADE_LIST.PET_WEAR_TABLE[1] then
            break
        end

        for _, v2 in getgenv().SETTINGS.TRADE_LIST.PET_WEAR_TABLE do
            if accessory.id == v2 then
                return true, 'pet_accessories', getgenv().SETTINGS.TRADE_LIST.PET_WEAR_TABLE
            end
        end
    end
    for _, vehicle in pairs(ClientData.get_data()[localPlayer.Name].inventory.transport)do
        if not getgenv().SETTINGS.TRADE_LIST.VEHICLES_TABLE[1] then
            break
        end

        for _, v2 in getgenv().SETTINGS.TRADE_LIST.VEHICLES_TABLE do
            if vehicle.id == v2 then
                return true, 'transport', getgenv().SETTINGS.TRADE_LIST.VEHICLES_TABLE
            end
        end
    end
    for _, food in pairs(ClientData.get_data()[localPlayer.Name].inventory.food)do
        if not getgenv().SETTINGS.TRADE_LIST.FOOD_TABLE[1] then
            break
        end

        for _, v2 in getgenv().SETTINGS.TRADE_LIST.FOOD_TABLE do
            if food.id == v2 then
                return true, 'food', getgenv().SETTINGS.TRADE_LIST.FOOD_TABLE
            end
        end
    end
    for _, gift in pairs(ClientData.get_data()[localPlayer.Name].inventory.gifts)do
        if not getgenv().SETTINGS.TRADE_LIST.GIFTS_TABLE[1] then
            break
        end

        for _, v2 in getgenv().SETTINGS.TRADE_LIST.GIFTS_TABLE do
            if gift.id == v2 then
                return true, 'gifts', getgenv().SETTINGS.TRADE_LIST.GIFTS_TABLE
            end
        end
    end
    for _, toy in pairs(ClientData.get_data()[localPlayer.Name].inventory.toys)do
        if not getgenv().SETTINGS.TRADE_LIST.TOYS_TABLE[1] then
            break
        end

        for _, v2 in getgenv().SETTINGS.TRADE_LIST.TOYS_TABLE do
            if toy.id == v2 then
                return true, 'toys', getgenv().SETTINGS.TRADE_LIST.TOYS_TABLE
            end
        end
    end

    if getgenv().SETTINGS.TRADE_ONLY_LUMINOUS_MEGA then
        for _, pet in pairs(ClientData.get_data()[localPlayer.Name].inventory.pets)do
            for _, v2 in getgenv().SETTINGS.TRADE_LIST.PETS_TABLE do
                if pet.id == v2 or (pet.properties.neon and pet.properties.age == 6) or pet.properties.mega_neon == true then
                    return true, 'pets', getgenv().SETTINGS.TRADE_LIST.PETS_TABLE
                end
            end
        end
    else
        for _, pet in pairs(ClientData.get_data()[localPlayer.Name].inventory.pets)do
            for _, v2 in getgenv().SETTINGS.TRADE_LIST.PETS_TABLE do
                if pet.id == v2 or pet.properties.age == 6 or (pet.properties.neon and pet.properties.age == 6) or pet.properties.mega_neon == true then
                    return true, 'pets', getgenv().SETTINGS.TRADE_LIST.PETS_TABLE
                end
            end
        end
    end

    return false, 'false', nil
end
local tradeCollector = function(namePassOn)
    while getgenv().SETTINGS.ENABLE_TRADE_COLLECTOR and getgenv().SETTINGS.TRADE_COLLECTOR_NAME and Players[namePassOn] do
        local tabBoolean, tabName, tables = checkInventory()

        if not tabBoolean then
            return
        end

        pcall(function()
            repeat
                if not localPlayer.PlayerGui.TradeApp.Frame.Visible then
                    ReplicatedStorage.API:FindFirstChild('TradeAPI/SendTradeRequest'):FireServer(Players[namePassOn])
                    task.wait(math.random(8, 15))
                end

                ClickTradeWindowPopUps()
                task.wait()
            until localPlayer.PlayerGui.TradeApp.Frame.Visible

            ClickTradeWindowPopUps()
            task.wait(1)
            ClickTradeWindowPopUps()

            local petCounter = 0

            if getgenv().SETTINGS.TRADE_ONLY_LUMINOUS_MEGA then
                for _, pet in pairs(ClientData.get_data()[localPlayer.Name].inventory[tabName])do
                    for _, v2 in tables do
                        if pet.id == v2 or (pet.properties.neon and pet.properties.age == 6) or pet.properties.mega_neon == true then
                            ReplicatedStorage.API:FindFirstChild('TradeAPI/AddItemToOffer'):FireServer(pet.unique)

                            petCounter = petCounter + 1

                            if petCounter >= 18 then
                                break
                            end

                            task.wait()
                        end
                    end
                end
            else
                for _, pet in pairs(ClientData.get_data()[localPlayer.Name].inventory[tabName])do
                    for _, v2 in tables do
                        if pet.id == v2 or pet.properties.age == 6 or (pet.properties.neon and pet.properties.age == 6) or pet.properties.mega_neon == true then
                            ReplicatedStorage.API:FindFirstChild('TradeAPI/AddItemToOffer'):FireServer(pet.unique)

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
                local lock = localPlayer.PlayerGui.TradeApp.Frame.NegotiationFrame.Body.LockIcon.Visible

                stuck -= 1

                task.wait(1)
            until not lock or stuck <= 0

            ClickTradeWindowPopUps()
            task.wait(1)
            ReplicatedStorage.API:FindFirstChild('TradeAPI/AcceptNegotiation'):FireServer()
            task.wait(3)
            ReplicatedStorage.API:FindFirstChild('TradeAPI/ConfirmTrade'):FireServer()

            petCounter = 0

            ClickTradeWindowPopUps()
        end)
        task.wait(1)
        ClickTradeWindowPopUps()
        task.wait()
    end
end

--[[local removeGameOverButton = function()
    localPlayer.PlayerGui.MinigameRewardsApp.Body.Button:WaitForChild('Face')

    for _, v in pairs(localPlayer.PlayerGui.MinigameRewardsApp.Body.Button:GetDescendants())do
        if v.Name == 'TextLabel' then
            if v.Text == 'NICE!' then
                task.wait(10)
                fireButton(v.Parent.Parent)

                break
            end
        end
    end
end
local onTextChangedMiniGame = function()
    if getgenv().SETTINGS.EVENT.DO_FROSTCLAW_MINIGAME then
        findButton('No')

        return
    end
    if getgenv().SETTINGS.EVENT and getgenv().SETTINGS.EVENT.DO_MINIGAME then
        findButton('Yes')
    else
        findButton('No')
    end
end--]]
local completeBabyAilments = function()
    for key, _ in ClientData.get_data()[localPlayer.Name].ailments_manager.baby_ailments do
        if key == 'hungry' then
        --ReplicatedStorage.API['ToolAPI/Unequip']:InvokeServer(PetCurrentlyFarming, {})
        --task.wait(1)
        --ReplicatedStorage.API['ToolAPI/Equip']:InvokeServer(PetCurrentlyFarming, {})
            ReplicatedStorage.API['ShopAPI/BuyItem']:InvokeServer('food', "icecream", {})
            task.wait(5)
            Ailments:BabyHungryAilment()
            task.wait(7)
			
            return
        elseif key == 'thirsty' then
        --ReplicatedStorage.API['ToolAPI/Unequip']:InvokeServer(PetCurrentlyFarming, {})
        --task.wait(1)
        --ReplicatedStorage.API['ToolAPI/Equip']:InvokeServer(PetCurrentlyFarming, {})
            ReplicatedStorage.API['ShopAPI/BuyItem']:InvokeServer('food', "water", {})
            task.wait(5)
            Ailments:BabyThirstyAilment()
            task.wait(7)

            return
	elseif key == 'bored' then
            Ailments:BabyBoredAilment(Piano)

            return
        elseif key == 'sleepy' then
            Ailments:BabySleepyAilment(Bed)

            return
        elseif key == 'dirty' then
            Ailments:BabyDirtyAilment(Shower)

            return
        end
    end
end

local function checkIfPetEquipped()
    if not ClientData.get('pet_char_wrappers')[1] then
        print('no pet so requipping')
        ReplicatedStorage.API['ToolAPI/Unequip']:InvokeServer(PetCurrentlyFarming, {})
        task.wait(1)
        ReplicatedStorage.API['ToolAPI/Equip']:InvokeServer(PetCurrentlyFarming, {})

        local count = 0

        repeat
            count += 1

            task.wait(1)
        until ClientData.get_data()[localPlayer.Name].pet_char_wrappers[1] or count > 10

        if count > 10 then
            checkIfPetEquipped()
        end
    end
end

local CompletePetAilments = function()
    checkIfPetEquipped()

    local petUnique = ClientData.get_data()[localPlayer.Name].pet_char_wrappers[1].pet_unique

    if not ClientData.get_data()[localPlayer.Name].ailments_manager then
        return false
    end
    if not ClientData.get_data()[localPlayer.Name].ailments_manager.ailments then
        return false
    end
    if not ClientData.get_data()[localPlayer.Name].ailments_manager.ailments[petUnique] then
        return false
    end

    for key, _ in ClientData.get_data()[localPlayer.Name].ailments_manager.ailments[petUnique]do
        if key == 'hungry' then
        ReplicatedStorage.API['ToolAPI/Unequip']:InvokeServer(PetCurrentlyFarming, {})
        task.wait(1)
        ReplicatedStorage.API['ToolAPI/Equip']:InvokeServer(PetCurrentlyFarming, {})
			
            ReplicatedStorage.API['ShopAPI/BuyItem']:InvokeServer('food', "icecream", {})
            task.wait(5)
            Ailments:HungryAilment()
            task.wait(2)

            return true
        elseif key == 'thirsty' then
	ReplicatedStorage.API['ToolAPI/Unequip']:InvokeServer(PetCurrentlyFarming, {})
        task.wait(1)
        ReplicatedStorage.API['ToolAPI/Equip']:InvokeServer(PetCurrentlyFarming, {})
            ReplicatedStorage.API['ShopAPI/BuyItem']:InvokeServer('food', "water", {})
            task.wait(5)
            Ailments:ThirstyAilment()
            task.wait(2)
			
            return true
	elseif key == 'sick' then
            Ailments:SickAilment()

            return true
        end
    end
    for key, _ in ClientData.get_data()[localPlayer.Name].ailments_manager.ailments[petUnique]do
        if key == 'salon' then
            Ailments:SalonAilment(key, petUnique)

            return true
        elseif key == 'pizza_party' then
            Ailments:PizzaPartyAilment(key, petUnique)

            return true
        elseif key == 'school' then
            Ailments:SchoolAilment(key, petUnique)

            return true
        elseif key == 'bored' then
            Ailments:BoredAilment(Piano, petUnique)

            return true
        elseif key == 'sleepy' then
            Ailments:SleepyAilment(Bed, petUnique)
            task.wait(3)
            placeBaitOrPickUp(baitId)

            return true
        elseif key == 'dirty' then
            Ailments:DirtyAilment(Shower, petUnique)
            task.wait(3)
            placeBaitOrPickUp(baitId)

            return true
        elseif key == 'walk' then
            Ailments:WalkAilment(petUnique)

            return true
        elseif key == 'toilet' then
            if not LitterBox then
                print('DOEST HAVE LITTER BOX')
            end

            Ailments:ToiletAilment(LitterBox, petUnique)
			
            return true
        elseif key == 'ride' then
            Ailments:RideAilment(strollerId, petUnique)

            return true
        elseif key == 'play' then
            Ailments:PlayAilment(key, petUnique)

            return true
        end
    end
    for key, _ in ClientData.get_data()[localPlayer.Name].ailments_manager.ailments[petUnique]do
        if key == 'beach_party' then
            Teleport.PlaceFloorAtBeachParty()
            Ailments:BeachPartyAilment(petUnique)
            Teleport.FarmingHome()

            return true
        elseif key == 'camping' then
            Teleport.PlaceFloorAtCampSite()
            Ailments:CampingAilment(petUnique)
            Teleport.FarmingHome()

            return true
        end
    end
    for key, _ in ClientData.get_data()[localPlayer.Name].ailments_manager.ailments[petUnique]do
        if key:match('mystery') then
            Ailments:MysteryAilment(key, petUnique)

            return true
        end
    end

    return false
end
local autoFarm = function()
    if not getgenv().auto_farm then
        return
    end

    CollisionsClient.set_collidable(false)
    Teleport.PlaceFloorAtFarmingHome()
    Teleport.PlaceFloorAtCampSite()
    Teleport.PlaceFloorAtBeachParty()
    Teleport.FarmingHome()
    task.delay(30, function()
        while true do
            if isInMiniGame then
                local count = 0

                repeat
                    print(`\u{23f1}\u{fe0f} Waiting for 10 secs [inside minigame] \u{23f1}\u{fe0f}`)

                    count += 10

                    task.wait(10)
                until not isInMiniGame or count > 120

                isInMiniGame = false
            end

            removeHandHeldItem()

            if not CompletePetAilments() then
                completeBabyAilments()
            end

            --updateStatsGui()
            task.wait(5)
        end
    end)

    if getgenv().SETTINGS.PET_AUTO_FUSION then
        task.spawn(function()
            Fusion:MakeMega(false)
            Fusion:MakeMega(true)
        end)
    end

    task.wait()
    getPet()
end

local startAutoFarm = function()
    --[[if getgenv().AutoFCMinigame then
        return
    end--]]

    counter += 1

    if getgenv().SETTINGS.ENABLE_AUTO_FARM then
        findFurniture()

        if Bed then
            getgenv().auto_farm = true

            autoFarm()
        end
    end
end
local SendMessage = function(url, message, userId)
    local http = game:GetService('HttpService')
    local headers = {
        ['Content-Type'] = 'application/json',
    }
    local data = {
        ['content'] = `<@{userId}> {message}`,
    }
    local body = http:JSONEncode(data)
    local response = request({
        Url = url,
        Method = 'POST',
        Headers = headers,
        Body = body,
    })

    for i, v in response do
        print(i, v)
    end
end
local dailyLoginAppClick = function()
    task.wait(0.1)

    if not localPlayer.PlayerGui.DailyLoginApp.Enabled then
        return
    end

    localPlayer.PlayerGui.DailyLoginApp:WaitForChild('Frame')
    localPlayer.PlayerGui.DailyLoginApp.Frame:WaitForChild('Body')
    localPlayer.PlayerGui.DailyLoginApp.Frame.Body:WaitForChild('Buttons')

    for _, v in localPlayer.PlayerGui.DailyLoginApp.Frame.Body.Buttons:GetDescendants()do
        if v.Name == 'TextLabel' then
            if v.Text == 'CLOSE' then
                fireButton(v.Parent.Parent)
                task.wait(1)
                grabDailyReward()
            elseif v.Text == 'CLAIM!' then
                fireButton(v.Parent.Parent)
                task.wait()
                fireButton(v.Parent.Parent)
                grabDailyReward()
            end
        end
    end
end
local onTextChangedNormalDialog = function()
    if localPlayer.PlayerGui.DialogApp.Dialog.NormalDialog.Info.TextLabel.Text:match('Be careful when trading') then
        findButton('Okay')
    elseif localPlayer.PlayerGui.DialogApp.Dialog.NormalDialog.Info.TextLabel.Text:match('This trade seems unbalanced') then
        findButton('Next')
    elseif localPlayer.PlayerGui.DialogApp.Dialog.NormalDialog.Info.TextLabel.Text:match('sent you a trade request') then
        findButton('Accept')
    elseif localPlayer.PlayerGui.DialogApp.Dialog.NormalDialog.Info.TextLabel.Text:match('Any items lost') then
        findButton('I understand')
    elseif localPlayer.PlayerGui.DialogApp.Dialog.NormalDialog.Info.TextLabel.Text:match('4.5%% Legendary') then
        findButton('Okay')
    elseif localPlayer.PlayerGui.DialogApp.Dialog.NormalDialog.Info.TextLabel.Text:match("Let's start the day") then
        findButton('Start')
    elseif localPlayer.PlayerGui.DialogApp.Dialog.NormalDialog.Info.TextLabel.Text:match('Are you subscribed') then
        findButton('Yes')
    elseif localPlayer.PlayerGui.DialogApp.Dialog.NormalDialog.Info.TextLabel.Text:match('your inventory!') then
        findButton('Awesome!')
    elseif localPlayer.PlayerGui.DialogApp.Dialog.NormalDialog.Info.TextLabel.Text:match('Gingerbread!') then
        findButton('Awesome!')
      end
end

localPlayer.Idled:Connect(function()
    VirtualUser:ClickButton2(Vector2.new())
end)
localPlayer.PlayerGui.HintApp.TextLabel:GetPropertyChangedSignal('Text'):Connect(function(
)
    if localPlayer.PlayerGui.HintApp.TextLabel.Text:match('Bucks') then
        local text = localPlayer.PlayerGui.HintApp.TextLabel.Text

        if not text then
            return
        end

        --print(text)

        --local amount = text:split('+')[2]:split(' ')[1]

        --bucksGained += tonumber(amount)

        --TempBucks:UpdateTextFor('TempBucks', bucksGained)
    elseif localPlayer.PlayerGui.HintApp.TextLabel.Text:match('aged up!') then
        if getgenv().feedAgeUpPotionToggle then
            return
        end

        if getgenv().SETTINGS.PET_AUTO_FUSION then
            Fusion:MakeMega(false)
            Fusion:MakeMega(true)
        end

        task.wait(2)

        if not getgenv().SETTINGS.FOCUS_FARM_AGE_POTION and not getgenv().FocusFarmAgePotions then
            SwitchOutFullyGrown()
        end
    end
end)

UserInputService.InputBegan:Connect(function(input, processed)
    if (input.KeyCode == Enum.KeyCode.Q and not processed) then
        if debounce then
            return
        end

        debounce = true

        clipboard:CopyAllInventory()
        task.wait()

        debounce = false
    end
end)

--[[localPlayer.OnTeleport:Connect(function(State)
    if State == Enum.TeleportState.InProgress then
        game:Shutdown()
    end
end)--]]

WelcomeScreen = localPlayer.PlayerGui.DialogApp.Dialog.NormalDialog:GetPropertyChangedSignal('Visible'):Connect(function(
)
    if localPlayer.PlayerGui.DialogApp.Dialog.NormalDialog.Visible then
        localPlayer.PlayerGui.DialogApp.Dialog.NormalDialog:WaitForChild('Info')
        localPlayer.PlayerGui.DialogApp.Dialog.NormalDialog.Info:WaitForChild('TextLabel')
        localPlayer.PlayerGui.DialogApp.Dialog.NormalDialog.Info.TextLabel:GetPropertyChangedSignal('Text'):Connect(function(
        )
            if localPlayer.PlayerGui.DialogApp.Dialog.NormalDialog.Info.TextLabel.Text:match('Welcome to Adopt Me!') then
                findButton('Next')
                task.wait(1)
                findButton('Start')
                task.wait(1)
                Tutorials.CompleteStarterTutorial()
                TradeLicense.Get(ClientData, localPlayer.Name)
                task.wait(1)
                WelcomeScreen:Disconnect()
            end
        end)
    end
end)
PickColorConn = localPlayer.PlayerGui.DialogApp.Dialog.ThemeColorDialog:GetPropertyChangedSignal('Visible'):Connect(function(
)
    if localPlayer.PlayerGui.DialogApp.Dialog.ThemeColorDialog.Visible then
        if tutorialDebonce then
            return
        end

        tutorialDebonce = true

        local colorButton = localPlayer.PlayerGui.DialogApp.Dialog.ThemeColorDialog:WaitForChild('Info'):WaitForChild('Response'):WaitForChild('ColorTemplate')
        local doneButton = localPlayer.PlayerGui.DialogApp.Dialog.ThemeColorDialog:WaitForChild('Buttons'):WaitForChild('ButtonTemplate')

        if not colorButton then
            return
        end

        firesignal(colorButton.MouseButton1Click)
        task.wait(1)
        firesignal(doneButton.MouseButton1Click)

        tutorialDebonce = false

        PickColorConn:Disconnect()
    end
end)
banMessageConnection = localPlayer.PlayerGui.DialogApp.Dialog.NormalDialog:GetPropertyChangedSignal('Visible'):Connect(function(
)
    if localPlayer.PlayerGui.DialogApp.Dialog.NormalDialog.Visible then
        localPlayer.PlayerGui.DialogApp.Dialog.NormalDialog:WaitForChild('Info')
        localPlayer.PlayerGui.DialogApp.Dialog.NormalDialog.Info:WaitForChild('TextLabel')
        localPlayer.PlayerGui.DialogApp.Dialog.NormalDialog.Info.TextLabel:GetPropertyChangedSignal('Text'):Connect(function(
        )
            if localPlayer.PlayerGui.DialogApp.Dialog.NormalDialog.Info.TextLabel.Text:match('ban') then
                findButton('Okay')
                
            if banMessageConnection then                
                banMessageConnection:Disconnect()
                
                banMessageConnection = nil
                end
            elseif localPlayer.PlayerGui.DialogApp.Dialog.NormalDialog.Info.TextLabel.Text:match('You have been awarded') then
                findButton('Awesome!')
            end
        end)
    end
end)
RoleChooserDialogConnection = localPlayer.PlayerGui.DialogApp.Dialog.RoleChooserDialog:GetPropertyChangedSignal('Visible'):Connect(function(
)
    task.wait()

    if localPlayer.PlayerGui.DialogApp.Dialog.RoleChooserDialog.Visible then
        firesignal(localPlayer.PlayerGui.DialogApp.Dialog.RoleChooserDialog.Baby.MouseButton1Click)
        if RoleChooserDialogConnection then        
        RoleChooserDialogConnection:Disconnect()
        
        RoleChooserDialogConnection = nil
        end        
    end
end)
RobuxProductDialogConnection1 = localPlayer.PlayerGui.DialogApp.Dialog.RobuxProductDialog:GetPropertyChangedSignal('Visible'):Connect(function(
)
    if not localPlayer.PlayerGui.DialogApp.Dialog.RobuxProductDialog.Visible then
        return
    end

    localPlayer.PlayerGui.DialogApp.Dialog.RobuxProductDialog:WaitForChild('Buttons')
    task.wait()

    for _, v in localPlayer.PlayerGui.DialogApp.Dialog.RobuxProductDialog.Buttons:GetDescendants()do
        if v.Name == 'TextLabel' then
            if v.Text == 'No Thanks' then
                firesignal(v.Parent.Parent.MouseButton1Click)
                
                	
            if RobuxProductDialogConnection1 then
                RobuxProductDialogConnection1:Disconnect()
                
                RobuxProductDialogConnection1 = nil
                end                
            end
        end
    end
end)
RobuxProductDialogConnection2 = localPlayer.PlayerGui.DialogApp.Dialog:GetPropertyChangedSignal('Visible'):Connect(function(
)
    if not localPlayer.PlayerGui.DialogApp.Dialog.Visible then
        return
    end

    localPlayer.PlayerGui.DialogApp.Dialog:WaitForChild('RobuxProductDialog')

    if not localPlayer.PlayerGui.DialogApp.Dialog.RobuxProductDialog.Visible then
        return
    end

    localPlayer.PlayerGui.DialogApp.Dialog.RobuxProductDialog:WaitForChild('Buttons')
    task.wait()

    for _, v in localPlayer.PlayerGui.DialogApp.Dialog.RobuxProductDialog.Buttons:GetDescendants()do
        if v.Name == 'TextLabel' then
            if v.Text == 'No Thanks' then
                firesignal(v.Parent.Parent.MouseButton1Click)

                if RobuxProductDialogConnection2 then
                    RobuxProductDialogConnection2:Disconnect()
                    RobuxProductDialogConnection2 = nil
                end
            end
        end
    end
end)
DailyClaimConnection = localPlayer.PlayerGui.DailyLoginApp:GetPropertyChangedSignal('Enabled'):Connect(function(
)
    dailyLoginAppClick()
    
        if DailyClaimConnection then
        DailyClaimConnection:Disconnect()
        
        DailyClaimConnection = nil
    end
end)

Players.LocalPlayer.PlayerGui.QuestIconApp.ImageButton.EventContainer.IsNew:GetPropertyChangedSignal('Position'):Connect(function(
)
    if taskBoard.NewTaskBool then
        taskBoard.NewTaskBool = false

        ReplicatedStorage.API:FindFirstChild('QuestAPI/MarkQuestsViewed'):FireServer()
        taskBoard:NewTask()
    end
end)
Players.LocalPlayer.PlayerGui.QuestIconApp.ImageButton.EventContainer.IsClaimable:GetPropertyChangedSignal('Position'):Connect(function(
)
    if taskBoard.NewClaimBool then
        taskBoard.NewClaimBool = false

        taskBoard:NewClaim()
    end
end)
localPlayer.PlayerGui.DialogApp.Dialog:GetPropertyChangedSignal('Visible'):Connect(function(
)
    if not localPlayer.PlayerGui.DialogApp.Dialog.Visible then
        return
    end

    localPlayer.PlayerGui.DialogApp.Dialog:WaitForChild('HeaderDialog')

    if not localPlayer.PlayerGui.DialogApp.Dialog.HeaderDialog.Visible then
        return
    end

    localPlayer.PlayerGui.DialogApp.Dialog.HeaderDialog:WaitForChild('Info')
    localPlayer.PlayerGui.DialogApp.Dialog.HeaderDialog.Info:WaitForChild('TextLabel')
    localPlayer.PlayerGui.DialogApp.Dialog.HeaderDialog.Info.TextLabel:GetPropertyChangedSignal('Text'):Connect(function(
    )
        if localPlayer.PlayerGui.DialogApp.Dialog.HeaderDialog.Info.TextLabel.Text:match('sent you a trade request') then
            findButton('Accept', 'HeaderDialog')
        end
    end)
end)
localPlayer.PlayerGui.DialogApp.Dialog.ChildAdded:Connect(function(Child)
    if Child.Name ~= 'HeaderDialog' then
        return
    end

    Child:GetPropertyChangedSignal('Visible'):Connect(function()
        if not Child.Visible then
            return
        end

        Child:WaitForChild('Info')
        Child.Info:WaitForChild('TextLabel')
        Child.Info.TextLabel:GetPropertyChangedSignal('Text'):Connect(function()
            if Child.Info.TextLabel.Text:match('sent you a trade request') then
                findButton('Accept', 'HeaderDialog')
            end
        end)
    end)
end)
localPlayer.PlayerGui.DialogApp.Dialog.NormalDialog:GetPropertyChangedSignal('Visible'):Connect(function(
)
    if localPlayer.PlayerGui.DialogApp.Dialog.NormalDialog.Visible then
        localPlayer.PlayerGui.DialogApp.Dialog.NormalDialog:WaitForChild('Info')
        localPlayer.PlayerGui.DialogApp.Dialog.NormalDialog.Info:WaitForChild('TextLabel')
        localPlayer.PlayerGui.DialogApp.Dialog.NormalDialog.Info.TextLabel:GetPropertyChangedSignal('Text'):Connect(onTextChangedNormalDialog)
    end
end)
localPlayer.PlayerGui.DialogApp.Dialog.ChildAdded:Connect(function(Child)
    if Child.Name ~= 'NormalDialog' then
        return
    end

    Child:GetPropertyChangedSignal('Visible'):Connect(function()
        if not Child.Visible then
            return
        end

        Child:WaitForChild('Info')
        Child.Info:WaitForChild('TextLabel')
        Child.Info.TextLabel:GetPropertyChangedSignal('Text'):Connect(onTextChangedNormalDialog)
    end)
end)
Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function(character)
        if Players.LocalPlayer.Name == getgenv().SETTINGS.TRADE_COLLECTOR_NAME then
            return
        end
        if tostring(player.Name) ~= getgenv().SETTINGS.TRADE_COLLECTOR_NAME then
            return
        end

        local humanoidRootPart = character:WaitForChild('HumanoidRootPart', 120)

        if not humanoidRootPart then
            return
        end
        if tostring(player.Name) ~= getgenv().SETTINGS.TRADE_COLLECTOR_NAME then
            return
        end

        task.wait(math.random(10, 20))
        tradeCollector(tostring(player.Name))
    end)
end)

if getgenv().SETTINGS.WEBHOOK and getgenv().SETTINGS.WEBHOOK.URL and #getgenv().SETTINGS.WEBHOOK.URL >= 1 and localPlayer.Name == getgenv().SETTINGS.TRADE_COLLECTOR_NAME then
    localPlayer.PlayerGui.DialogApp.Dialog:GetPropertyChangedSignal('Visible'):Connect(function(
    )
        if discordCooldown then
            return
        end

        discordCooldown = true

        localPlayer.PlayerGui.DialogApp.Dialog:WaitForChild('HeaderDialog')
        localPlayer.PlayerGui.DialogApp.Dialog.HeaderDialog:GetPropertyChangedSignal('Visible'):Connect(function(
        )
            if not localPlayer.PlayerGui.DialogApp.Dialog.HeaderDialog.Visible then
                return
            end

            localPlayer.PlayerGui.DialogApp.Dialog.HeaderDialog:WaitForChild('Info')
            localPlayer.PlayerGui.DialogApp.Dialog.HeaderDialog.Info:WaitForChild('TextLabel')
            localPlayer.PlayerGui.DialogApp.Dialog.HeaderDialog.Info.TextLabel:GetPropertyChangedSignal('Text'):Connect(function(
            )
                SendMessage(getgenv().SETTINGS.WEBHOOK.URL, localPlayer.PlayerGui.DialogApp.Dialog.HeaderDialog.Info.TextLabel.Text, getgenv().SETTINGS.WEBHOOK.USER_ID)
                task.wait(1)

                discordCooldown = false
            end)
        end)
    end)
end

localPlayer.PlayerGui.TradeApp.Frame.NegotiationFrame.Body.PartnerOffer.Accepted:GetPropertyChangedSignal('ImageTransparency'):Connect(function(
)
    Trade:AutoAcceptTrade()
end)
localPlayer.PlayerGui.TradeApp.Frame.ConfirmationFrame.PartnerOffer.Accepted:GetPropertyChangedSignal('ImageTransparency'):Connect(function(
)
    Trade:AutoAcceptTrade()
end)

repeat
    task.wait(1)
until localPlayer.PlayerGui.NewsApp.Enabled or localPlayer.Character or localPlayer.PlayerGui.DialogApp.Dialog.ThemeColorDialog.Visible

StatsGuis:UpdateText("NameFrame")
StatsGuis:UpdateText("TimeFrame")
StatsGuis:UpdateText("BucksAndPotionFrame")
StatsGuis:UpdateText("TotalFrame")
StatsGuis:UpdateText("TotalFrame1")
--StatsGuis:UpdateText("TotalFrame2")

StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Captures, false)

if gethui then
    TestGui.Parent = gethui()
elseif syn.protect_gui then
    syn.protect_gui(TestGui)

    TestGui.Parent = CoreGui
elseif CoreGui:FindFirstChild('RobloxGui') then
    TestGui.Parent = CoreGui:FindFirstChild('RobloxGui')
else
    TestGui.Parent = CoreGui
end

TestGui.Name = 'TestGui'
TestGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
UserGameSettings.GraphicsQualityLevel = 1
UserGameSettings.MasterVolume = 8

for i, v in debug.getupvalue(RouterClient.init, 7)do
    v.Name = i
end
---First Button- Play---
if localPlayer.PlayerGui.NewsApp.Enabled then
    local AbsPlay = localPlayer.PlayerGui.NewsApp:WaitForChild('EnclosingFrame'):WaitForChild('MainFrame'):WaitForChild('Contents'):WaitForChild('PlayButton')

    fireButton(AbsPlay)
end

if localPlayer.PlayerGui.DialogApp.Dialog.NormalDialog.Visible then
    if localPlayer.PlayerGui.DialogApp.Dialog.NormalDialog.Info.TextLabel.Text:match('ban') then
        findButton('Okay')

        if banMessageConnection then
            banMessageConnection:Disconnect()
            banMessageConnection = nil
        end
    end
end
if localPlayer.PlayerGui.DialogApp.Dialog.RoleChooserDialog.Visible then
    firesignal(localPlayer.PlayerGui.DialogApp.Dialog.RoleChooserDialog.Baby.MouseButton1Click)

    if RoleChooserDialogConnection then
        RoleChooserDialogConnection:Disconnect()
        RoleChooserDialogConnection = nil
    end
end
if localPlayer.PlayerGui.DialogApp.Dialog.NormalDialog.Visible then
    if localPlayer.PlayerGui.DialogApp.Dialog.NormalDialog.Info.TextLabel.Text:match('4.5%% Legendary') then
        task.wait(1)
        findButton('Okay')
    end
end

for _, pettable in pairs({
    pets_common,
    pets_uncommon,
    pets_rare,
    pets_ultrarare,
})do
    for j, petlist in pairs(pettable)do
        table.insert(Pets_commonto_ultrarare, petlist)
    end
end
for _, pettable in pairs({
    pets_legendary,
    pets_ultrarare,
    pets_rare,
    pets_uncommon,
    pets_common,
})do
    for _, petlist in pairs(pettable)do
        table.insert(pets_legendary_to_common, petlist)
    end
end

findFurniture()

if not Bed then
    buyFurniture('basiccrib')
end
task.wait(1)
if not Piano then
    buyFurniture('piano')
end
task.wait(1)
if not LitterBox then
    buyFurniture('ailments_refresh_2024_litter_box')
end
task.wait(1)
if not NormalLure then
    buyFurniture('lures_2023_normal_lure')
end

task.wait(1) 
--baitId = findBait('winter_2024_winter_deer_bait')

--if not baitId then
    baitId = findBait('lures_2023_campfire_cookies')
--end   
print(`\u{1f36a} Found baitId: {baitId} \u{1f36a}`)
placeBaitOrPickUp(baitId)
task.wait(2)
placeBaitOrPickUp(baitId)

strollerId = GetInventory:GetUniqueId('strollers', 'stroller-default')

findFurniture()
print(`Has Bed: {Bed} \u{1f6cf}\u{fe0f} | Has Piano: {Piano} \u{1f3b9} | Has LitterBox: {LitterBox} \u{1f4a9} | Has Lure: {NormalLure}`)
ReplicatedStorage:WaitForChild('API'):WaitForChild('HousingAPI/SetDoorLocked'):InvokeServer(true)

if not localPlayer.Character then
    print('get player character so waiting')
    localPlayer.CharacterAdded:Wait()
end
if localPlayer.Character:WaitForChild('HumanoidRootPart') then
    ReplicatedStorage.API['TeamAPI/ChooseTeam']:InvokeServer('Babies', {
        ['dont_send_back_home'] = true,
    })
end
if localPlayer.PlayerGui.DialogApp.Dialog.NormalDialog.Info.TextLabel.Text:match('Thanks for subscribing!') then
    findButton('Okay')
end
if localPlayer.PlayerGui.DialogApp.Dialog.NormalDialog.Info.TextLabel.Text:match('You have been awarded') then
    findButton('Awesome!')
end

Teleport.PlaceFloorAtFarmingHome()
Teleport.PlaceFloorAtCampSite()
Teleport.PlaceFloorAtBeachParty()

--[[GuiPopupButton.Text = "Open GUI"
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
GuiPopupButton.Parent = TestGui--]]


--[[ClipboardButton.Activated:Connect(function()
    if guiCooldown then
        return
    end

    guiCooldown = true

    clipboard:CopyAllInventory()

    guiCooldown = false
end)--]]

-- Rayfield:Minimise()
--[[GuiPopupButton.MouseButton1Click:Connect(function()
    if guiCooldown then
        return
    end

    guiCooldown = true

    Rayfield:Unhide()
    task.wait()

    guiCooldown = false
end)--]]

----------------------------------------

dailyLoginAppClick()
--Teleport.FarmingHome()
	
if getgenv().BUY_BEFORE_FARMING then
    isBuyingOrAging = true
    BuyItems:BuyPets(getgenv().BUY_BEFORE_FARMING)
end
if getgenv().OPEN_ITEMS_BEFORE_FARMING then
    isBuyingOrAging = true
    BuyItems:OpenItems(getgenv().OPEN_ITEMS_BEFORE_FARMING)
end
if getgenv().AGE_PETS_BEFORE_FARMING then
    isBuyingOrAging = true
    
    local bulkPotions = BulkPotions.new()

    bulkPotions:SetEggTable(GetInventory:GetPetEggs())
    bulkPotions:StartAgingPets(getgenv().AGE_PETS_BEFORE_FARMING)
    print('DONE aging pets')
end

    isBuyingOrAging = false

if isMuleInGame() then
    tradeCollector(getgenv().SETTINGS.TRADE_COLLECTOR_NAME)
end

--DailyClaimConnection:Disconnect()
task.delay(5, function()
    if Players.LocalPlayer.Name == getgenv().SETTINGS.TRADE_COLLECTOR_NAME and getgenv().SETTINGS.ENABLE_TRADE_COLLECTOR == true then
        task.spawn(function()
            getgenv().AutoTradeToggle:Set(true)
        end)
    end
end)

task.wait(2)
startAutoFarm()

-----------------------Rayfield---------------------
task.wait(5)
local Window = Rayfield:CreateWindow({
	Name = "BLN Adopt Me!  Basic Autofarm V4.2",
	LoadingTitle = "Loading BLN V4 Script ",
	LoadingSubtitle = "by BlackLastNight 2025",
	ConfigurationSaving = {
		Enabled = false,
		FolderName = nil, -- Create a custom folder for your hub/game
		FileName = "BLN 4",
	},
	Discord = {
		Enabled = false,
		Invite = "noinvitelink", -- The Discord invite code, do not include discord.gg/. E.g. discord.gg/ABCD would be ABCD
		RememberJoins = true, -- Set this to false to make them join the discord every time they load it up
	},
    KeySystem = false,
    KeySettings = {
        Title = 'Untitled',
        Subtitle = 'Key System',
        Note = 'No method of obtaining the key is provided',
        FileName = 'Key',
        SaveKey = false,
        GrabKeyFromSite = false,
        Key = {
            'Hello',
        },
    },
})

--[[ First Tab - Autofarm ]]
local FarmTab = Window:CreateTab("Farm", 4483362458)



local petsDropdown0 = FarmTab:CreateDropdown({
    Name = 'Select a Pet',
    Options = petsTable,
    CurrentOption = { "" },
    MultipleOptions = false,
    Flag = 'Dropdown0',
    Callback = function(Option)
        selectedPet = Option[1] or 'Nothing'
    end,
})

FarmTab:CreateButton({
    Name = 'Refesh Pet list',
    Callback = function()
        petsDropdown0:Set(GetInventory:TabId('pets'))
    end,
})




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

------------- minigames-------------

------------------------------------


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
local TradeTab = Window:CreateTab('Auto Trade', 4483362458)

TradeTab:CreateSection('only enable Auto Accept trade on alt getting the items')

getgenv().AutoTradeToggle = TradeTab:CreateToggle({
    Name = 'Auto Accept Trade',
    CurrentValue = false,
    Flag = 'Toggle1',
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
    Name = 'Select a player',
    Options = getPlayersInGame(),
    CurrentOption = {
        '',
    },
    MultipleOptions = false,
    Flag = 'Dropdown1',
    Callback = function(Option)
        selectedPlayer = Option[1]
    end,
})

TradeTab:CreateButton({
    Name = 'Refesh player list',
    Callback = function()
        playerDropdown:Set(getPlayersInGame())
    end,
})
TradeTab:CreateToggle({
    Name = 'Send player Trade',
    CurrentValue = false,
    Flag = 'Toggle1',
    Callback = function(Value)
        getgenv().auto_trade_semi_auto = Value

        while getgenv().auto_trade_semi_auto do
            Trade:SendTradeRequest(selectedPlayer)
            task.wait(1)
        end
    end,
})

TradeAllInventory = TradeTab:CreateToggle({
    Name = 'Auto Trade EVERYTHING',
    CurrentValue = false,
    Flag = 'Toggle1',
    Callback = function(Value)
        getgenv().auto_trade_all_inventory = Value

        while getgenv().auto_trade_all_inventory do
            Trade:SendTradeRequest(selectedPlayer)
            Trade:AllInventory('pets')
            Trade:AllInventory('pet_accessories')
            Trade:AllInventory('strollers')
            Trade:AllInventory('food')
            Trade:AllInventory('transport')
            Trade:AllInventory('toys')
            Trade:AllInventory('gifts')

            local hasPets = Trade:AcceptNegotiationAndConfirm()

            if not hasPets then
                TradeAllInventory:Set(false)
            end

            task.wait()
        end
    end,
})
AllPetsToggle = TradeTab:CreateToggle({
    Name = 'Auto Trade All Pets',
    CurrentValue = false,
    Flag = 'Toggle1',
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
    Name = 'FullGrown, Newborn to luminous Neons and Megas',
    CurrentValue = false,
    Flag = 'Toggle1',
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
    Flag = 'Toggle1',
    Callback = function(Value)
        getgenv().auto_trade_Legendary = Value

        while getgenv().auto_trade_Legendary do
            Trade:SendTradeRequest(selectedPlayer)
            Trade:AllPetsOfSameRarity('legendary')

            local hasPets = Trade:AcceptNegotiationAndConfirm()

            if not hasPets then
                LegendaryToggle:Set(false)
            end

            task.wait()
        end
    end,
})
FullgrownToggle = TradeTab:CreateToggle({
    Name = 'Auto Trade FullGrown, luminous Neons and Megas',
    CurrentValue = false,
    Flag = 'Toggle1',
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
    Name = 'Auto Trade All Megas',
    CurrentValue = false,
    Flag = 'Toggle1',
    Callback = function(Value)
        getgenv().auto_trade_all_neons = Value

        while getgenv().auto_trade_all_neons do
            Trade:SendTradeRequest(selectedPlayer)
            Trade:AllNeons('mega_neon')

            local hasPets = Trade:AcceptNegotiationAndConfirm()

            if not hasPets then
                TradeAllMegas:Set(false)
            end

            task.wait()
        end
    end,
})
TradeAllNeons = TradeTab:CreateToggle({
    Name = 'Auto Trade All Neons',
    CurrentValue = false,
    Flag = 'Toggle1',
    Callback = function(Value)
        getgenv().auto_trade_all_neons = Value

        while getgenv().auto_trade_all_neons do
            Trade:SendTradeRequest(selectedPlayer)
            Trade:AllNeons('neon')

            local hasPets = Trade:AcceptNegotiationAndConfirm()

            if not hasPets then
                TradeAllNeons:Set(false)
            end

            task.wait()
        end
    end,
})
LowTierToggle = TradeTab:CreateToggle({
    Name = 'Auto Trade Common to Ultra-rare and Newborn to Post-Teen',
    CurrentValue = false,
    Flag = 'Toggle1',
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
    Name = 'Auto Trade Legendary Newborn to Post-Teen',
    CurrentValue = false,
    Flag = 'Toggle1',
    Callback = function(Value)
        getgenv().auto_trade_rarity_pets = Value

        while getgenv().auto_trade_rarity_pets do
            if selectedPlayer then
                Trade:SendTradeRequest(selectedPlayer)
            end

            Trade:NewbornToPostteen('legendary')

            local hasPets = Trade:AcceptNegotiationAndConfirm()

            if not hasPets then
                RarityToggle:Set(false)
            end

            task.wait()
        end
    end,
})

TradeTab:CreateSection('Send Custom Pet, sends ALL ages of selected pet')

local petsDropdown = TradeTab:CreateDropdown({
    Name = 'Select a Pet',
    Options = petsTable,
    CurrentOption = { "" },
    MultipleOptions = false,
    Flag = 'Dropdown1',
    Callback = function(Option)
        selectedPet = Option[1] or 'Nothing'
    end,
})

TradeTab:CreateButton({
    Name = 'Refesh Pet list',
    Callback = function()
        petsDropdown:Set(GetInventory:TabId('pets'))
    end,
})

PetToggle = TradeTab:CreateToggle({
    Name = 'Auto Trade Selected Pet',
    CurrentValue = false,
    Flag = 'Toggle1',
    Callback = function(Value)
        getgenv().auto_trade_custom = Value

        while getgenv().auto_trade_custom do
            Trade:SendTradeRequest(selectedPlayer)
            Trade:SelectTabAndTrade('pets', selectedPet)

            local hasPets = Trade:AcceptNegotiationAndConfirm()

            if not hasPets then
                PetToggle:Set(false)
            end

            task.wait()
        end
    end,
})

TradeTab:CreateSection(' ')

local giftsDropdown = TradeTab:CreateDropdown({
    Name = 'Select gift',
    Options = giftsTable,
    CurrentOption = {
        giftsTable[1],
    },
    MultipleOptions = false,
    Flag = 'Dropdown1',
    Callback = function(Option)
        selectedGift = Option[1] or 'Nothing'
    end,
})

TradeTab:CreateButton({
    Name = 'Refesh Gift list',
    Callback = function()
        giftsDropdown:Set(GetInventory:TabId('gifts'))
    end,
})

GiftToggle = TradeTab:CreateToggle({
    Name = 'Auto Trade Custom Gift',
    CurrentValue = false,
    Flag = 'Toggle1',
    Callback = function(Value)
        getgenv().auto_trade_custom = Value

        while getgenv().auto_trade_custom do
            Trade:SendTradeRequest(selectedPlayer)
            Trade:SelectTabAndTrade('gifts', selectedGift)

            local hasPets = Trade:AcceptNegotiationAndConfirm()

            if not hasPets then
                GiftToggle:Set(false)
            end

            task.wait()
        end
    end,
})

TradeTab:CreateSection(' ')

local toysDropdown = TradeTab:CreateDropdown({
    Name = 'Select toys',
    Options = toysTable,
    CurrentOption = {
        toysTable[1],
    },
    MultipleOptions = false,
    Flag = 'Dropdown1',
    Callback = function(Option)
        selectedToy = Option[1] or 'Nothing'
    end,
})

TradeTab:CreateButton({
    Name = 'Refesh Toy list',
    Callback = function()
        toysDropdown:Set(GetInventory:TabId('toys'))
    end,
})

ToyToggle = TradeTab:CreateToggle({
    Name = 'Auto Trade Custom Toy',
    CurrentValue = false,
    Flag = 'Toggle1',
    Callback = function(Value)
        getgenv().auto_trade_custom = Value

        while getgenv().auto_trade_custom do
            Trade:SendTradeRequest(selectedPlayer)
            Trade:SelectTabAndTrade('toys', selectedToy)

            local hasPets = Trade:AcceptNegotiationAndConfirm()

            if not hasPets then
                ToyToggle:Set(false)
            end

            task.wait()
        end
    end,
})

TradeTab:CreateSection(' ')

local foodDropdown = TradeTab:CreateDropdown({
    Name = 'Select food',
    Options = foodTable,
    CurrentOption = {
        foodTable[1],
    },
    MultipleOptions = false,
    Flag = 'Dropdown1',
    Callback = function(Option)
        selectedFood = Option[1] or 'Nothing'
    end,
})

TradeTab:CreateButton({
    Name = 'Refesh Food list',
    Callback = function()
        foodDropdown:Set(GetInventory:TabId('food'))
    end,
})

FoodToggle = TradeTab:CreateToggle({
    Name = 'Auto Trade Custom Food',
    CurrentValue = false,
    Flag = 'Toggle1',
    Callback = function(Value)
        getgenv().auto_trade_custom = Value

        while getgenv().auto_trade_custom do
            Trade:SendTradeRequest(selectedPlayer)
            Trade:SelectTabAndTrade('food', selectedFood)

            local hasPets = Trade:AcceptNegotiationAndConfirm()

            if not hasPets then
                FoodToggle:Set(false)
            end

            task.wait()
        end
    end,
})

local NewAltTab = Window:CreateTab('New Alts', 4483362458)

NewAltTab:CreateButton({
    Name = 'Complete Starter Tutorial',
    Callback = function()
        Tutorials.CompleteStarterTutorial()
    end,
})
NewAltTab:CreateButton({
    Name = 'Get Trade License',
    Callback = function()
        TradeLicense.Get(ClientData, localPlayer.Name)
    end,
})
NewAltTab:CreateButton({
    Name = 'Buy Basic Crib',
    Callback = function()
        buyFurniture('basiccrib')
    end,
})

local AgeUpPotionTab = Window:CreateTab('Age Up Potion', 4483362458)

---------- focused Pets to Age Up --------
 --[[getgenv().AGE_PETS_BEFORE_FARMING = {
 	"winter_2024_winter_buck" 
 }--]]
----------------------------------

getgenv().PotionToggle = AgeUpPotionTab:CreateToggle({
    Name = 'Turm On to Age Up All Pets',
    CurrentValue = false,
    Flag = 'Toggle1',
    Callback = function(Value)
			
       getgenv().feedAgeUpPotionToggle = Value

    while getgenv().feedAgeUpPotionToggle do				
    isBuyingOrAging = true
    local bulkPotions = BulkPotions.new()
    bulkPotions:SetEggTable(GetInventory:GetPetEggs())
    bulkPotions:StartAgingPets(petsTable)
    --bulkPotions:StartAgingPets(getgenv().AGE_PETS_BEFORE_FARMING)				
    print('DONE aging pets')
                                        end
			
    end,
})

--------------------update Stats UI ----------------
            while task.wait(5) do
			StatsGuis:UpdateText("TimeFrame")
			StatsGuis:UpdateText("BucksAndPotionFrame")
                        StatsGuis:UpdateText("TotalFrame")
                        StatsGuis:UpdateText("TotalFrame1")
                        --StatsGuis:UpdateText("TotalFrame2")
			--[[print(`⏱️ Waiting for 5 secs ⏱️`)--]]
                    end
   --print('Loaded. lastest update 10/01/2025  mm/dd/yyyy')                 
                    
