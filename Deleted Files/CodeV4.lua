local __DARKLUA_BUNDLE_MODULES

__DARKLUA_BUNDLE_MODULES = {
    cache = {},
    load = function(m)
        if not __DARKLUA_BUNDLE_MODULES.cache[m] then
            __DARKLUA_BUNDLE_MODULES.cache[m] = {
                c = __DARKLUA_BUNDLE_MODULES[m](),
            }
        end

        return __DARKLUA_BUNDLE_MODULES.cache[m].c
    end,
}

do
    function __DARKLUA_BUNDLE_MODULES.a()
        local VirtualInputManager = cloneref(game:GetService('VirtualInputManager'))
        local Workspace = cloneref(game:GetService('Workspace'))
        local ReplicatedStorage = cloneref(game:GetService('ReplicatedStorage'))
        local Players = cloneref(game:GetService('Players'))
        local Utils = {}
        local Bypass = (require(ReplicatedStorage:WaitForChild('Fsys')).load)
        local ClientData = Bypass('ClientData')
        local RouterClient = Bypass('RouterClient')
        local debugMode = getgenv().SETTINGS.DEBUG_MODE or false
        local localPlayer = Players.LocalPlayer

        function Utils.PlaceFLoorUnderPlayer()
            if Workspace:FindFirstChild('FloorUnderPlayer') then
                return
            end

            local character = localPlayer.Character or localPlayer.CharacterAdded:Wait()
            local humanoidRootPart = (character:WaitForChild('HumanoidRootPart'))
            local floorPart = Instance.new('Part')

            floorPart.Position = humanoidRootPart.Position + Vector3.new(0, -2.2, 0)
            floorPart.Size = Vector3.new(100, 2, 100)
            floorPart.Anchored = true
            floorPart.Transparency = 1
            floorPart.Name = 'FloorUnderPlayer'
            floorPart.Parent = Workspace
        end
        function Utils.RemoveHandHeldItem()
            local character = localPlayer.Character
            local tool = (character and {
                (character:FindFirstChildOfClass('Tool')),
            } or {nil})[1]

            if not tool then
                return
            end

            local unique = tool:FindFirstChild('unique')

            if not unique then
                return
            end
            if not unique:IsA('StringValue') then
                return
            end

            RouterClient.get('ToolAPI/Unequip'):InvokeServer(unique.Value, {})
        end
        function Utils.FindBait()
            local baits = getgenv().SETTINGS.BAIT_TO_USE_IN_ORDER

            if not baits then
                baits = {
                    --'ice_dimension_2025_shiver_cone_bait',
                    --'ice_dimension_2025_subzero_popsicle_bait',
                    'ice_dimension_2025_ice_soup_bait',
                }
            end

            for _, id in ipairs(baits)do
                for _, v in pairs(ClientData.get_data()[localPlayer.Name].inventory.food)do
                    if id == v.id then
                        return v.unique
                    end
                end
            end

            return nil
        end
        function Utils.PlaceBaitOrPickUp(normalLureKey, baitUnique)
            if not (normalLureKey and baitUnique) then
                return
            end
            if typeof(normalLureKey) ~= 'string' then
                return
            end

            Utils.PrintDebug('placing bait or picking up')

            local args = {
                [1] = localPlayer,
                [2] = normalLureKey,
                [3] = 'UseBlock',
                [4] = {
                    ['bait_unique'] = baitUnique,
                },
                [5] = localPlayer.Character,
            }
            local success, errorMessage = pcall(function()
                return RouterClient.get('HousingAPI/ActivateFurniture'):InvokeServer(table.unpack(args))
            end)

            Utils.PrintDebug('BAITBOX:', success, errorMessage)
        end
        function Utils.GetPlayersInGame()
            local playerTable = {}

            for _, player in Players:GetPlayers()do
                if player.Name == localPlayer.Name then
                    continue
                end

                table.insert(playerTable, player.Name)
            end

            table.sort(playerTable)

            return playerTable
        end
        function Utils.ConsumeItem(potionName)
            local agePotion = Workspace:WaitForChild('PetObjects'):WaitForChild(potionName, 15)

            if not agePotion then
                return
            end

            RouterClient.get('PetAPI/ConsumeFoodObject'):FireServer(agePotion, ClientData.get('pet_char_wrappers')[1].pet_unique)
        end
		
        function Utils.CreatePetObject(objectUnique)
            local args = {
                [1] = '__Enum_PetObjectCreatorType_2',
                [2] = {
                    ['pet_unique'] = ClientData.get('pet_char_wrappers')[1].pet_unique,
                    ['unique_id'] = objectUnique,
                },
            }
            RouterClient.get('PetObjectAPI/CreatePetObject'):InvokeServer(unpack(args))
        end
		
        function Utils.FeedAgePotion(petEggs, FoodPassOn)
            for _, v in ClientData.get_data()[localPlayer.Name].inventory.food do
                if v.id == FoodPassOn then
                    if not ClientData.get('pet_char_wrappers')[1] then
                        return
                    end

                    local isEgg = table.find(petEggs, ClientData.get('pet_char_wrappers')[1]['pet_id']) and true or false
                    local petAge = ClientData.get('pet_char_wrappers')[1]['pet_progression']['age']

                    if isEgg or petAge >= 6 then
                        return
                    end

                    local args = {
                        [1] = '__Enum_PetObjectCreatorType_2',
                        [2] = {
                            ['pet_unique'] = ClientData.get('pet_char_wrappers')[1].pet_unique,
                            ['unique_id'] = v.unique,
                        },
                    }

                    RouterClient.get('PetObjectAPI/CreatePetObject'):InvokeServer(unpack(args))
                    Utils.ConsumeItem('AgePotion')

                    return
                end
            end

            return
        end
        function Utils.IsCollectorInGame(collectorNames)
            for _, player in Players:GetPlayers()do
                if player.Name == localPlayer.Name then
                    continue
                end
                if table.find(collectorNames, player.Name) then
                    return true
                end
            end

            return false
        end
        function Utils.BucksAmount()
            return ClientData.get_data()[localPlayer.Name].money or 0
        end
        function Utils.EventCurrencyAmount()
            --return ClientData.get_data()[localPlayer.Name].pet_recycler_manager.saved_points
        end
        function Utils.FoodItemCount(nameId)
            local count = 0

            for ExampleObjects, v in ClientData.get_data()[localPlayer.Name].inventory.food do
                if v.id == nameId then
                    count = count + 1
                end
            end

            return count
        end
        function Utils.FormatNumber(num)
            if num >= 1e6 then
                return string.format('%.2fM', num / 1e6)
            elseif num >= 1e3 then
                return string.format('%.1fK', num / 1e3)
            else
                return string.format('%.0f', num)
            end
        end
        function Utils.FormatTime(currentTime)
            local hours = math.floor(currentTime / 3600)
            local minutes = math.floor((currentTime % 3600) / 60)
            local seconds = currentTime % 60

            return string.format('%02d:%02d:%02d', hours, minutes, seconds)
        end
        function Utils.ClickGuiButton(button, xOffset, yOffset)
            if not button then
                return
            end

            pcall(function()
                local xOffset1 = xOffset or 60
                local yOffset1 = yOffset or 60

                task.wait()
                VirtualInputManager:SendMouseButtonEvent(button.AbsolutePosition.X + xOffset1, button.AbsolutePosition.Y + yOffset1, 0, true, game, 1)
                task.wait()
                VirtualInputManager:SendMouseButtonEvent(button.AbsolutePosition.X + xOffset1, button.AbsolutePosition.Y + yOffset1, 0, false, game, 1)
            end)

            return
        end
        function Utils.FireButton(button)
            if not button then
                return
            end
            if firesignal then
                pcall(function()
                    local mouseButton1Down = button.MouseButton1Down
                    local mouseButton1Up = button.MouseButton1Up
                    local mouseButton1Click = button.MouseButton1Click

                    firesignal(mouseButton1Down)
                    task.wait(1)
                    firesignal(mouseButton1Up)
                    task.wait(1)
                    firesignal(mouseButton1Click)
                end)
            else
                Utils.ClickGuiButton(button)
            end
        end
        function Utils.FindButton(text, dialogFramePassOn)
            task.wait(0.1)

            dialogFramePassOn = dialogFramePassOn or 'NormalDialog'

            local dialog = localPlayer:WaitForChild('PlayerGui'):WaitForChild('DialogApp'):WaitForChild('Dialog')
            local buttons = dialog:WaitForChild(dialogFramePassOn):WaitForChild('Buttons', 10)

            if not buttons then
                Utils.PrintDebug('NO BUTTONS')

                return
            end

            for _, v in buttons:GetDescendants()do
                if v:IsA('TextLabel') and v.Text == text then
                    local button = v:FindFirstAncestorWhichIsA('ImageButton') or v:FindFirstAncestorWhichIsA('TextButton')

                    if not button then
                        return
                    end

                    Utils.FireButton(button)

                    return
                end
            end
        end
        function Utils.IsPetEquipped(whichPet)
            local petIndex = ClientData.get('pet_char_wrappers')[whichPet]

            if not petIndex then
                return false
            end
            if not petIndex['char'] then
                return false
            end

            return true
        end
        function Utils.UnEquip(petUnique, EquipAsLast)
            local success, errorMessage = pcall(function()
                ReplicatedStorage.API['ToolAPI/Unequip']:InvokeServer(petUnique, {
                    ['equip_as_last'] = EquipAsLast,
                })
            end)

            if not success then
                Utils.PrintDebug('Failed to Unequip pet:', errorMessage)

                return false
            end

            return true
        end
        function Utils.UnEquipAllPets()
            repeat
                if Utils.IsPetEquipped(1) then
                    Utils.UnEquip(ClientData.get('pet_char_wrappers')[1].pet_unique, false)
                end

                task.wait(1)
            until not Utils.IsPetEquipped(1)

            Utils.PrintDebug('UnEquipped all pets')
        end
        function Utils.Equip(petUnique, EquipAsLast)
            local success, errorMessage = pcall(function()
                ReplicatedStorage.API['ToolAPI/Equip']:InvokeServer(petUnique, {
                    ['equip_as_last'] = EquipAsLast,
                })
            end)

            if not success then
                Utils.PrintDebug('Failed to equip pet:', errorMessage)

                return false
            end

            return true
        end
        function Utils.ReEquipPet(whichPet)
            local hasPetChar = false
            local EquipTimeout = 0

            if not ClientData.get('pet_char_wrappers') then
                return false
            end
            if not ClientData.get('pet_char_wrappers')[whichPet] then
                return false
            end

            local petUnique = ClientData.get('pet_char_wrappers')[whichPet].pet_unique

            if whichPet == 1 then
                if not Utils.UnEquip(petUnique, false) then
                    return false
                end

                task.wait(1)

                if not Utils.Equip(petUnique, false) then
                    return false
                end
            elseif whichPet == 2 then
                if not Utils.UnEquip(petUnique, true) then
                    return false
                end

                task.wait(1)

                if not Utils.Equip(petUnique, true) then
                    return false
                end
            end

            repeat
                task.wait(1)

                hasPetChar = ClientData.get('pet_char_wrappers') and ClientData.get('pet_char_wrappers')[whichPet] and ClientData.get('pet_char_wrappers')[whichPet]['char'] and true or false
                EquipTimeout = EquipTimeout + 1
            until hasPetChar or EquipTimeout >= 20

            if EquipTimeout >= 20 then
                Utils.PrintDebug('\u{26a0}\u{fe0f} Waited too long for Equipping pet \u{26a0}\u{fe0f}')

                return false
            end

            Utils.PrintDebug(string.format('ReEquipPet: success in equipping %s', tostring(whichPet)))

            return true
        end
        function Utils.PrintDebug(...)
            if not debugMode then
                return
            end

            print(string.format('[Debug] %s', tostring(...)))
        end
        function Utils.CenterText(text, width)
            local textLength = #text

            if textLength >= width then
                return text
            end

            local padding = width - textLength
            local left = math.floor(padding / 2)
            local right = padding - left

            return string.format('%s %s %s', tostring(string.rep(' ', left)), tostring(text), tostring(string.rep(' ', right)))
        end
        function Utils.WaitForPetToEquip()
            local hasPetChar = nil
            local stuckTimer = 0

            repeat
                task.wait(1)

                hasPetChar = ClientData.get('pet_char_wrappers') and ClientData.get('pet_char_wrappers')[1] and ClientData.get('pet_char_wrappers')[1].pet_unique and true or false
                stuckTimer = stuckTimer + 1
            until hasPetChar or stuckTimer > 20

            if stuckTimer > 20 then
                return false
            end

            return true
        end
        function Utils.GetCharacter()
            return localPlayer.Character or localPlayer.CharacterAdded:Wait()
        end

        function Utils.GetHumanoidRootPart()
            return (Utils.GetCharacter():WaitForChild('HumanoidRootPart'))
        end

        function Utils.FireRedeemCode(code)
            RouterClient.get('CodeRedemptionAPI/AttemptRedeemCode'):InvokeServer(code)
        end

        return Utils
    end
    function __DARKLUA_BUNDLE_MODULES.b()
        local ReplicatedStorage = cloneref(game:GetService('ReplicatedStorage'))
        local Players = cloneref(game:GetService('Players'))
        local Bypass = (require(ReplicatedStorage:WaitForChild('Fsys')).load)
        local ClientData = Bypass('ClientData')
        local RouterClient = Bypass('RouterClient')
        local Utils = __DARKLUA_BUNDLE_MODULES.load('a')
        local self = {}
        local localPlayer = Players.LocalPlayer
        local furnitures = {
            basiccrib = 'nil',
            stylishshower = 'nil',
            modernshower = 'nil',
            piano = 'nil',
            lures_2023_normal_lure = 'nil',
            ailments_refresh_2024_litter_box = 'nil',
        }

        function self.GetFurnituresKey()
            Utils.PrintDebug('getting furniture ids')

            for key, value in ClientData.get_data()[localPlayer.Name].house_interior.furniture do
                if value.id == 'basiccrib' then
                    furnitures['basiccrib'] = key
                elseif value.id == 'stylishshower' or value.id == 'modernshower' then
                    furnitures['stylishshower'] = key
                    furnitures['modernshower'] = key
                elseif value.id == 'piano' then
                    furnitures['piano'] = key
                elseif value.id == 'lures_2023_normal_lure' then
                    furnitures['lures_2023_normal_lure'] = key
                elseif value.id == 'ailments_refresh_2024_litter_box' then
                    furnitures['ailments_refresh_2024_litter_box'] = key
                end
            end

            return furnitures
        end
        function self.BuyFurniture(furnitureId)
            --[[local args = {
                {
                    {
                        ['kind'] = furnitureId,
                        ['properties'] = {
                            ['cframe'] = CFrame.new(14, 2, -22) * CFrame.Angles(-0, 8.7, 3.8),
                        },
                    },
                },
            }

            RouterClient.get('HousingAPI/BuyFurnitures'):InvokeServer(unpack(args))--]]
        end
        function self.subscribeToHouse(playerName)
            RouterClient.get('HousingAPI/SubscribeToHouse'):FireServer(playerName)
        end

        return self
    end
    function __DARKLUA_BUNDLE_MODULES.c()
        return {
            Denylist = {
                'practice_dog',
                'starter_egg',
                'dog',
                'cat',
                'cracked_egg',
                'basic_egg_2022_ant',
                'basic_egg_2022_mouse',
                'spring_2025_minigame_spiked_kaijunior',
                'spring_2025_minigame_scorching_kaijunior',
                'spring_2025_minigame_toxic_kaijunior',
                'spring_2025_minigame_spotted_kaijunior',
                'beach_2024_mahi_spinning_rod_temporary',
                'sandwich-default',
                'squeaky_bone_default',
                'trade_license',
            },
            Allowlist = {
                'ice_dimension_2025_frostbite_bear',
            },
        }
    end
    function __DARKLUA_BUNDLE_MODULES.d()
        return {
            'soda_fountain_water',
            'fossil_2024_long_neck_throw_toy',
        }
    end
    function __DARKLUA_BUNDLE_MODULES.e()
        local ReplicatedStorage = cloneref(game:GetService('ReplicatedStorage'))
        local Players = cloneref(game:GetService('Players'))
        local Bypass = (require(ReplicatedStorage:WaitForChild('Fsys')).load)
        local ClientData = Bypass('ClientData')
        local RouterClient = Bypass('RouterClient')
        local InventoryDB = Bypass('InventoryDB')
        local AllowOrDenyList = __DARKLUA_BUNDLE_MODULES.load('c')
        local TrashItemsList = __DARKLUA_BUNDLE_MODULES.load('d')
        local Utils = __DARKLUA_BUNDLE_MODULES.load('a')
        local self = {}
        local localPlayer = Players.LocalPlayer
        local lowTierRarity = {
            'common',
            'uncommon',
            'rare',
            'ultra_rare',
        }
        local inActiveTrade = function()
            local timeOut = 60

            repeat
                task.wait(1)

                timeOut = timeOut - 1
            until ClientData.get_data()[localPlayer.Name].in_active_trade or timeOut <= 0

            if timeOut <= 0 then
                return
            end
            if #ClientData.get_data()[localPlayer.Name].trade.sender_offer.items >= 18 then
                return
            end
        end
        local waitForActiveTrade = function()
            local timeOut = 60

            while not ClientData.get_data()[localPlayer.Name].in_active_trade do
                task.wait(1)

                timeOut = timeOut - 1

                if timeOut <= 0 then
                    return false, Utils.PrintDebug('\u{26a0}\u{fe0f} waiting for trade timedout \u{26a0}\u{fe0f}')
                end
            end

            return true
        end
        local isMulesInGame = function(playerMulesTable)
            for _, player in Players:GetPlayers()do
                if player.Name == localPlayer.Name then
                    continue
                end
                if table.find(playerMulesTable, player.Name) then
                    return true
                end
            end

            return false
        end
        local convertPetAges = function(options)
            local agesNumber = {}

            for _, v in options['ages']do
                if v == 'Newborn/Reborn' then
                    table.insert(agesNumber, 1)
                elseif v == 'Junior/Twinkle' then
                    table.insert(agesNumber, 2)
                elseif v == 'Pre_Teen/Sparkle' then
                    table.insert(agesNumber, 3)
                elseif v == 'Teen/Flare' then
                    table.insert(agesNumber, 4)
                elseif v == 'Post_Teen/Sunshine' then
                    table.insert(agesNumber, 5)
                elseif v == 'Full_Grown/Luminous' then
                    table.insert(agesNumber, 6)
                end
            end

            return agesNumber
        end
        local MultipleOptionsTradeLoop = function(
            newOptions,
            isNeon,
            isMegaNeon
        )
            local raritys = newOptions['rarity']
            local ages = newOptions['ages']
            local waitForAdded = 0

            for _, petDB in InventoryDB.pets do
                for _, pet in ClientData.get_data()[localPlayer.Name].inventory.pets do
                    if table.find(AllowOrDenyList.Denylist, pet.id) then
                        continue
                    end
                    if petDB.id ~= pet.id then
                        continue
                    end
                    if not table.find(raritys, petDB.rarity) then
                        continue
                    end
                    if not table.find(ages, pet.properties.age) then
                        continue
                    end
                    if pet.properties.neon == isNeon and pet.properties.mega_neon == isMegaNeon then
                        if not ClientData.get_data()[localPlayer.Name].in_active_trade then
                            return false
                        end
                        if #ClientData.get_data()[localPlayer.Name].trade.sender_offer.items >= 18 then
                            return true
                        end

                        RouterClient.get('TradeAPI/AddItemToOffer'):FireServer(pet.unique)

                        waitForAdded = waitForAdded + 1

                        repeat
                            task.wait(0.1)
                        until #ClientData.get_data()[localPlayer.Name].trade.sender_offer.items >= waitForAdded or not ClientData.get_data()[localPlayer.Name].in_active_trade
                    end
                end
            end

            if not ClientData.get_data()[localPlayer.Name].in_active_trade then
                return false
            end
            if #ClientData.get_data()[localPlayer.Name].trade.sender_offer.items >= 1 then
                return true
            else
                return false
            end
        end
        local hasTrashItems = function()
            for _, v in ClientData.get_data()[localPlayer.Name].inventory do
                for _, item in v do
                    if not table.find(TrashItemsList, item.id) then
                        continue
                    end
                    if not item.properties.age then
                        return true
                    end
                    if item.properties.age == 6 or item.properties.neon or item.properties.mega_neon then
                        continue
                    end

                    return true
                end
            end

            return false
        end

        function self.AcceptNegotiationAndConfirm()
            local timeOut = 30

            repeat
                task.wait(1)

                if ClientData.get_data()[localPlayer.Name].in_active_trade then
                    if ClientData.get_data()[localPlayer.Name].trade.current_stage == 'negotiation' then
                        if not ClientData.get_data()[localPlayer.Name].trade.sender_offer.negotiated then
                            RouterClient.get('TradeAPI/AcceptNegotiation'):FireServer()
                        end
                    end
                    if #ClientData.get_data()[localPlayer.Name].trade.sender_offer.items == 0 and #ClientData.get_data()[localPlayer.Name].trade.recipient_offer.items == 0 then
                        RouterClient.get('TradeAPI/DeclineTrade'):FireServer()

                        return false
                    end
                    if ClientData.get_data()[localPlayer.Name].trade.current_stage == 'confirmation' then
                        if not ClientData.get_data()[localPlayer.Name].trade.sender_offer.confirmed then
                            RouterClient.get('TradeAPI/ConfirmTrade'):FireServer()
                        end
                    end
                end

                timeOut = timeOut - 1
            until not ClientData.get_data()[localPlayer.Name].in_active_trade or timeOut <= 0

            return true
        end
        function self.SendTradeRequest(playerTable)
            if typeof(playerTable) ~= 'table' then
                return false, Utils.PrintDebug('playerTable is not a table')
            end

            while true do
                if not isMulesInGame(playerTable) then
                    return false
                end

                local TradeApp = (localPlayer:WaitForChild('PlayerGui'):WaitForChild('TradeApp'))
                local TradeFrame = (TradeApp:WaitForChild('Frame'))

                if TradeFrame.Visible then
                    return true
                end

                for _, player in Players:GetPlayers()do
                    if not table.find(playerTable, player.Name) then
                        continue
                    end
                    if ClientData.get_data()[player.Name] and not ClientData.get_data()[player.Name].in_active_trade then
                        RouterClient.get('TradeAPI/SendTradeRequest'):FireServer(player)
                        task.wait(1)
                    end
                end

                task.wait(math.random(20, 30))
            end
        end
        function self.SelectTabAndTrade(tab, selectedItem)
            inActiveTrade()

            for _, item in ClientData.get_data()[localPlayer.Name].inventory[tab]do
                if item.id == selectedItem then
                    if not ClientData.get_data()[localPlayer.Name].in_active_trade then
                        return
                    end

                    RouterClient.get('TradeAPI/AddItemToOffer'):FireServer(item.unique)

                    if #ClientData.get_data()[localPlayer.Name].trade.sender_offer.items >= 18 then
                        return
                    end

                    task.wait(0.1)
                end
            end
        end
        function self.NeonNewbornToPostteen()
            inActiveTrade()

            for _, pet in ClientData.get_data()[localPlayer.Name].inventory.pets do
                if table.find(AllowOrDenyList.Denylist, pet.id) then
                    continue
                end
                if pet.properties.age <= 5 and pet.properties.neon then
                    if not ClientData.get_data()[localPlayer.Name].in_active_trade then
                        return
                    end

                    RouterClient.get('TradeAPI/AddItemToOffer'):FireServer(pet.unique)

                    if #ClientData.get_data()[localPlayer.Name].trade.sender_offer.items >= 18 then
                        return
                    end

                    task.wait(0.1)
                end
            end
        end
        function self.MultipleOptions(options)
            if typeof(options) ~= 'table' then
                return
            end

            local newOptions = table.clone(options)
            local isNormal = table.find(newOptions['neons'], 'normal') and true or nil
            local isNeon = table.find(newOptions['neons'], 'neon') and true or nil
            local isMegaNeon = table.find(newOptions['neons'], 'mega_neon') and true or nil

            newOptions['ages'] = convertPetAges(newOptions)

            inActiveTrade()

            if isNormal then
                if MultipleOptionsTradeLoop(newOptions, nil, nil) then
                    return
                end
            end
            if isNeon then
                if MultipleOptionsTradeLoop(newOptions, true, nil) then
                    return
                end
            end
            if isMegaNeon then
                if MultipleOptionsTradeLoop(newOptions, nil, true) then
                    return
                end
            end

            return
        end
        function self.LowTiers()
            inActiveTrade()

            for _, petDB in InventoryDB.pets do
                for _, pet in ClientData.get_data()[localPlayer.Name].inventory.pets do
                    if table.find(AllowOrDenyList.Denylist, pet.id) then
                        continue
                    end
                    if petDB.id == pet.id and table.find(lowTierRarity, petDB.rarity) and pet.properties.age <= 5 and not pet.properties.neon and not pet.properties.mega_neon then
                        if not ClientData.get_data()[localPlayer.Name].in_active_trade then
                            return
                        end

                        RouterClient.get('TradeAPI/AddItemToOffer'):FireServer(pet.unique)

                        if #ClientData.get_data()[localPlayer.Name].trade.sender_offer.items >= 18 then
                            return
                        end

                        task.wait(0.1)
                    end
                end
            end
        end
        function self.NewbornToPostteen(rarity)
            inActiveTrade()

            for _, petDB in InventoryDB.pets do
                for _, pet in ClientData.get_data()[localPlayer.Name].inventory.pets do
                    if table.find(AllowOrDenyList.Denylist, pet.id) then
                        continue
                    end
                    if petDB.id == pet.id and petDB.rarity == rarity and pet.properties.age <= 5 and not pet.properties.neon and not pet.properties.mega_neon then
                        if not ClientData.get_data()[localPlayer.Name].in_active_trade then
                            return
                        end

                        RouterClient.get('TradeAPI/AddItemToOffer'):FireServer(pet.unique)

                        if #ClientData.get_data()[localPlayer.Name].trade.sender_offer.items >= 18 then
                            return
                        end

                        task.wait(0.1)
                    end
                end
            end
        end
        function self.NewbornToPostteenByPetId(petIds)
            if typeof(petIds) ~= 'table' then
                return
            end

            inActiveTrade()

            for _, pet in ClientData.get_data()[localPlayer.Name].inventory.pets do
                if table.find(AllowOrDenyList.Denylist, pet.id) then
                    continue
                end
                if table.find(petIds, pet.id) and pet.properties.age <= 5 and not pet.properties.mega_neon then
                    if not ClientData.get_data()[localPlayer.Name].in_active_trade then
                        return
                    end

                    RouterClient.get('TradeAPI/AddItemToOffer'):FireServer(pet.unique)

                    if #ClientData.get_data()[localPlayer.Name].trade.sender_offer.items >= 18 then
                        return
                    end

                    task.wait(0.1)
                end
            end
        end
        function self.FullgrownAndAnyNeonsAndMegas()
            inActiveTrade()

            for _, pet in ClientData.get_data()[localPlayer.Name].inventory.pets do
                if pet.properties.age == 6 or pet.properties.neon or pet.properties.mega_neon then
                    if not ClientData.get_data()[localPlayer.Name].in_active_trade then
                        return
                    end

                    RouterClient.get('TradeAPI/AddItemToOffer'):FireServer(pet.unique)

                    if #ClientData.get_data()[localPlayer.Name].trade.sender_offer.items >= 18 then
                        return
                    end

                    task.wait(0.1)
                end
            end
        end
        function self.Fullgrown()
            inActiveTrade()

            for _, pet in ClientData.get_data()[localPlayer.Name].inventory.pets do
                if pet.properties.age == 6 or (pet.properties.age == 6 and pet.properties.neon) or pet.properties.mega_neon then
                    if not ClientData.get_data()[localPlayer.Name].in_active_trade then
                        return
                    end

                    RouterClient.get('TradeAPI/AddItemToOffer'):FireServer(pet.unique)

                    if #ClientData.get_data()[localPlayer.Name].trade.sender_offer.items >= 18 then
                        return
                    end

                    task.wait(0.1)
                end
            end
        end
        function self.AllPetsOfSameRarity(rarity)
            inActiveTrade()

            for _, petDB in InventoryDB.pets do
                for _, pet in ClientData.get_data()[localPlayer.Name].inventory.pets do
                    if table.find(AllowOrDenyList.Denylist, pet.id) then
                        continue
                    end
                    if petDB.id == pet.id and petDB.rarity == rarity then
                        if not ClientData.get_data()[localPlayer.Name].in_active_trade then
                            return
                        end

                        RouterClient.get('TradeAPI/AddItemToOffer'):FireServer(pet.unique)

                        if #ClientData.get_data()[localPlayer.Name].trade.sender_offer.items >= 18 then
                            return
                        end

                        task.wait(0.1)
                    end
                end
            end
        end
        function self.AutoAcceptTrade()
            if ClientData.get_data()[localPlayer.Name].in_active_trade then
                if ClientData.get_data()[localPlayer.Name].trade.sender_offer.negotiated then
                    RouterClient.get('TradeAPI/AcceptNegotiation'):FireServer()
                end
                if ClientData.get_data()[localPlayer.Name].trade.sender_offer.confirmed then
                    RouterClient.get('TradeAPI/ConfirmTrade'):FireServer()
                end
            end
        end
        function self.AllInventory(TabPassOn)
            inActiveTrade()

            for _, item in ClientData.get_data()[localPlayer.Name].inventory[TabPassOn]do
                if table.find(AllowOrDenyList.Denylist, item.id) then
                    continue
                end
                if not ClientData.get_data()[localPlayer.Name].in_active_trade then
                    return
                end

                RouterClient.get('TradeAPI/AddItemToOffer'):FireServer(item.unique)

                if #ClientData.get_data()[localPlayer.Name].trade.sender_offer.items >= 18 then
                    return
                end

                task.wait(0.1)
            end
        end
        function self.AllPets()
            inActiveTrade()

            for _, pet in ClientData.get_data()[localPlayer.Name].inventory.pets do
                if table.find(AllowOrDenyList.Denylist, pet.id) then
                    continue
                end
                if not ClientData.get_data()[localPlayer.Name].in_active_trade then
                    return
                end

                RouterClient.get('TradeAPI/AddItemToOffer'):FireServer(pet.unique)

                if #ClientData.get_data()[localPlayer.Name].trade.sender_offer.items >= 18 then
                    return
                end

                task.wait(0.1)
            end
        end
        function self.AllNeons(version)
            inActiveTrade()

            for _, pet in ClientData.get_data()[localPlayer.Name].inventory.pets do
                if pet.properties[version] then
                    if not ClientData.get_data()[localPlayer.Name].in_active_trade then
                        return
                    end

                    RouterClient.get('TradeAPI/AddItemToOffer'):FireServer(pet.unique)

                    if #ClientData.get_data()[localPlayer.Name].trade.sender_offer.items >= 18 then
                        return
                    end

                    task.wait(0.1)
                end
            end
        end
        function self.CheckInventory()
            if not isMulesInGame(getgenv().SETTINGS.TRADE_COLLECTOR_NAME) then
                Utils.PrintDebug('Collecters no longer ingame')

                return false
            end
            if getgenv().SETTINGS.TRADE_ONLY_LUMINOUS_MEGA then
                for _, v in ClientData.get_data()[localPlayer.Name].inventory do
                    for _, item in v do
                        if table.find(AllowOrDenyList.Denylist, item.id) then
                            continue
                        end
                        if table.find(getgenv().SETTINGS.TRADE_LIST, item.id) or (item.properties.neon and item.properties.age == 6) or item.properties.mega_neon then
                            return true
                        end
                    end
                end
            else
                for _, v in ClientData.get_data()[localPlayer.Name].inventory do
                    for _, item in v do
                        if table.find(AllowOrDenyList.Denylist, item.id) then
                            continue
                        end
                        if table.find(getgenv().SETTINGS.TRADE_LIST, item.id) or item.properties.age == 6 or item.properties.neon or item.properties.mega_neon then
                            return true
                        end
                    end
                end
            end

            return false
        end
        function self.TradeCollector(namePassOn)
            local isInventoryFull = false

            if typeof(namePassOn) ~= 'table' then
                return Utils.PrintDebug(string.format('\u{1f6ab} %s is not a table', tostring(namePassOn)))
            end
            if typeof(getgenv().SETTINGS.TRADE_LIST) ~= 'table' then
                return Utils.PrintDebug('TRADE_LIST is not a table')
            end
            if table.find(namePassOn, localPlayer.Name) then
                return Utils.PrintDebug('\u{1f6ab} MULE CANNOT TRADE ITSELF OR OTHER MULES')
            end

            while getgenv().SETTINGS.ENABLE_TRADE_COLLECTOR do
                if not isMulesInGame(getgenv().SETTINGS.TRADE_COLLECTOR_NAME) then
                    return Utils.PrintDebug('\u{26a0}\u{fe0f} MULE NOT INGAME \u{26a0}\u{fe0f}')
                end
                if not self.CheckInventory() then
                    return Utils.PrintDebug('\u{1f6ab} NO ITEMS TO TRADE')
                end
                if not self.SendTradeRequest(namePassOn) then
                    return Utils.PrintDebug('\u{26a0}\u{fe0f} NO MULES TO TRADE \u{26a0}\u{fe0f}')
                end
                if not waitForActiveTrade() then
                    task.wait(1)

                    continue
                end
                if getgenv().SETTINGS.TRADE_ONLY_LUMINOUS_MEGA then
                    for _, v in ClientData.get_data()[localPlayer.Name].inventory do
                        if isInventoryFull then
                            break
                        end

                        for _, item in v do
                            if table.find(getgenv().SETTINGS.TRADE_LIST, item.id) or (item.properties.neon and item.properties.age == 6) or item.properties.mega_neon then
                                if table.find(AllowOrDenyList.Denylist, item.id) then
                                    continue
                                end
                                if not ClientData.get_data()[localPlayer.Name].in_active_trade then
                                    return
                                end

                                RouterClient.get('TradeAPI/AddItemToOffer'):FireServer(item.unique)

                                if #ClientData.get_data()[localPlayer.Name].trade.sender_offer.items >= 18 then
                                    isInventoryFull = true

                                    break
                                end

                                task.wait(0.1)
                            end
                        end

                        if isInventoryFull then
                            break
                        end
                    end
                else
                    for _, v in ClientData.get_data()[localPlayer.Name].inventory do
                        if isInventoryFull then
                            break
                        end

                        for _, item in v do
                            if table.find(getgenv().SETTINGS.TRADE_LIST, item.id) or item.properties.age == 6 or item.properties.neon or item.properties.mega_neon then
                                if table.find(AllowOrDenyList.Denylist, item.id) then
                                    continue
                                end
                                if not ClientData.get_data()[localPlayer.Name].in_active_trade then
                                    return
                                end

                                RouterClient.get('TradeAPI/AddItemToOffer'):FireServer(item.unique)

                                if #ClientData.get_data()[localPlayer.Name].trade.sender_offer.items >= 18 then
                                    isInventoryFull = true

                                    break
                                end

                                task.wait(0.1)
                            end
                        end

                        if isInventoryFull then
                            break
                        end
                    end
                end

                local hasPets = self.AcceptNegotiationAndConfirm()

                if not hasPets then
                    Utils.PrintDebug('\u{1f389} DONE TRADING ITEMS \u{1f389}')

                    return
                end

                isInventoryFull = false
            end

            return
        end
        function self.TradeTrashCollector(namePassOn)
            local isInventoryFull = false

            if table.find(namePassOn, localPlayer.Name) then
                return Utils.PrintDebug('\u{1f6ab} MULE CANNOT TRADE ITSELF')
            end

            while getgenv().SETTINGS.ENABLE_TRASH_COLLECTOR do
                if not isMulesInGame(namePassOn) then
                    return Utils.PrintDebug('\u{26a0}\u{fe0f} MULE NOT INGAME \u{26a0}\u{fe0f}')
                end
                if not hasTrashItems() then
                    return Utils.PrintDebug('\u{1f6ab} NO ITEMS TO TRADE')
                end
                if not self.SendTradeRequest(namePassOn) then
                    return Utils.PrintDebug('\u{26a0}\u{fe0f} NO MULES TO TRADE \u{26a0}\u{fe0f}')
                end
                if not waitForActiveTrade() then
                    task.wait(1)

                    continue
                end

                for _, v in ClientData.get_data()[localPlayer.Name].inventory do
                    if isInventoryFull then
                        break
                    end

                    for _, item in v do
                        if not table.find(TrashItemsList, item.id) then
                            continue
                        end
                        if item.properties.age and (item.properties.age == 6 or item.properties.neon or item.properties.mega_neon) then
                            continue
                        end
                        if not ClientData.get_data()[localPlayer.Name].in_active_trade then
                            return
                        end

                        RouterClient.get('TradeAPI/AddItemToOffer'):FireServer(item.unique)

                        if #ClientData.get_data()[localPlayer.Name].trade.sender_offer.items >= 18 then
                            isInventoryFull = true

                            break
                        end

                        task.wait(0.1)
                    end

                    if isInventoryFull then
                        break
                    end
                end

                local hasPets = self.AcceptNegotiationAndConfirm()

                if not hasPets then
                    Utils.PrintDebug('\u{1f389} DONE TRADING ITEMS \u{1f389}')

                    return
                end

                isInventoryFull = false
            end

            return
        end

        return self
    end
    function __DARKLUA_BUNDLE_MODULES.f()
        local ReplicatedStorage = cloneref(game:GetService('ReplicatedStorage'))
        local Players = cloneref(game:GetService('Players'))
        local Workspace = cloneref(game:GetService('Workspace'))
        local Bypass = (require(ReplicatedStorage:WaitForChild('Fsys')).load)
        local ClientData = Bypass('ClientData')
        local CollisionsClient = Bypass('CollisionsClient')
        local Teleport = {}
        local localPlayer = Players.LocalPlayer
        local getconstants = getconstants or debug.getconstants
        local getgc = getgc or get_gc_objects or debug.getgc
        local get_thread_identity = getthreadidentity or get_thread_identity or gti or getidentity or syn.get_thread_identity or fluxus.get_thread_identity
        local set_thread_identity = setthreadidentity or set_thread_context or sti or setthreadcontext or setidentity or syn.set_thread_identity or fluxus.set_thread_identity
        local SetLocationTP
        local rng = Random.new()

        for _, v in pairs(getgc())do
            if type(v) == 'function' then
                if getfenv(v).script == ReplicatedStorage.ClientModules.Core.InteriorsM.InteriorsM then
                    if table.find(getconstants(v), 'LocationAPI/SetLocation') then
                        SetLocationTP = v

                        break
                    end
                end
            end
        end

        local SetLocationFunc = function(a, b, c)
            local k = get_thread_identity()

            set_thread_identity(2)
            SetLocationTP(a, b, c)
            set_thread_identity(k)
        end

        function Teleport.Init() end
        function Teleport.PlaceFloorAtFarmingHome()
            if Workspace:FindFirstChild('FarmingHomeLocation') then
                return
            end
			
            local campsite = Workspace.StaticMap.Campsite.CampsiteOrigin
            local part = Instance.new('Part')
            local SurfaceGui = Instance.new('SurfaceGui')
            local TextLabel = Instance.new('TextLabel')

            part.Position = campsite.Position + Vector3.new(0, 80, 0)
            part.Size = Vector3.new(200, 2, 200)
            part.Anchored = true
            part.Transparency = 0
            part.Name = 'FarmingHomeLocation'
            part.Parent = Workspace
            SurfaceGui.Parent = part
            SurfaceGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
            SurfaceGui.AlwaysOnTop = false
            SurfaceGui.CanvasSize = Vector2.new(600, 600)
            SurfaceGui.Face = Enum.NormalId.Top
            TextLabel.Parent = SurfaceGui
	        TextLabel.BackgroundColor3 = Color3.fromRGB(30, 160, 0)
	        TextLabel.BackgroundTransparency = 0 
            TextLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
            TextLabel.BorderSizePixel = 0
            TextLabel.Size = UDim2.new(1, 0, 1, 0)
            TextLabel.Font = Enum.Font.SourceSans
	        TextLabel.Text = "🍕🍕😋"
            TextLabel.TextColor3 = Color3.fromRGB(0, 0, 0)
            TextLabel.TextScaled = true
            TextLabel.TextSize = 14
            TextLabel.TextWrapped = true
        end
        --[[function Teleport.PlaceCameraPart()
            if Workspace:FindFirstChild('CameraPartLocation') then
                return
            end

            local part = Instance.new('Part')

            part.Position = Vector3.new(100000, 10000, 100000)
            part.Size = Vector3.new(2, 2, 2)
            part.Anchored = true
            part.Transparency = 1
            part.Name = 'CameraPartLocation'
            part.Parent = Workspace
        end--]]
        function Teleport.PlaceFloorAtCampSite()
            if Workspace:FindFirstChild('CampingLocation') then
                return
            end

            local campsite = Workspace.StaticMap.Campsite.CampsiteOrigin
            local part = Instance.new('Part')
            local SurfaceGui = Instance.new('SurfaceGui')
            local TextLabel = Instance.new('TextLabel')

            part.Position = campsite.Position + Vector3.new(0, 30, 0)
            part.Size = Vector3.new(200, 2, 200)
            part.Anchored = true
            part.Transparency = 0
            part.Name = 'CampingLocation'
            part.Parent = Workspace
			SurfaceGui.Parent = part
            SurfaceGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
            SurfaceGui.AlwaysOnTop = false
            SurfaceGui.CanvasSize = Vector2.new(600, 600)
            SurfaceGui.Face = Enum.NormalId.Top
            TextLabel.Parent = SurfaceGui
	        TextLabel.BackgroundColor3 = Color3.fromRGB(30, 160, 0)
	        TextLabel.BackgroundTransparency = 0
            TextLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
            TextLabel.BorderSizePixel = 0
            TextLabel.Size = UDim2.new(1, 0, 1, 0)
            TextLabel.Font = Enum.Font.SourceSans
	        TextLabel.Text = "🌲🌲🌲"
            TextLabel.TextColor3 = Color3.fromRGB(0, 0, 0)
            TextLabel.TextScaled = true
            TextLabel.TextSize = 14
            TextLabel.TextWrapped = true
        end
        function Teleport.PlaceFloorAtBeachParty()
            if Workspace:FindFirstChild('BeachPartyLocation') then
                return
            end

            local part = Instance.new('Part')
            local SurfaceGui = Instance.new('SurfaceGui')
            local TextLabel = Instance.new('TextLabel')

            part.Position = Workspace.StaticMap.Beach.BeachPartyAilmentTarget.Position + Vector3.new(0, -10, 0)
            part.Size = Vector3.new(1000, 2, 1000)
            part.Anchored = true
            part.Transparency = 0
            part.Name = 'BeachPartyLocation'
            part.Parent = Workspace

            SurfaceGui.Parent = part
            SurfaceGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
            SurfaceGui.AlwaysOnTop = false
            SurfaceGui.CanvasSize = Vector2.new(600, 600)
            SurfaceGui.Face = Enum.NormalId.Top
            TextLabel.Parent = SurfaceGui
	        TextLabel.BackgroundColor3 = Color3.fromRGB(84, 184,200)
	        TextLabel.BackgroundTransparency = 0
            TextLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
            TextLabel.BorderSizePixel = 0
            TextLabel.Size = UDim2.new(1, 0, 1, 0)
            TextLabel.Font = Enum.Font.SourceSans
	        TextLabel.Text = "🌊🌊🌊"
            TextLabel.TextColor3 = Color3.fromRGB(0, 0, 0)
            TextLabel.TextScaled = true
            TextLabel.TextSize = 14
            TextLabel.TextWrapped = true
			
        end
        function Teleport.placeFloorOnJoinZone()
            for _, v in Workspace:GetChildren()do
                if v.Name == 'FloorPart2' then
                    return
                end
            end

            local part = Instance.new('Part')

            part.Position = game.Workspace.Interiors:WaitForChild('Halloween2024Shop'):WaitForChild('TileSkip'):WaitForChild('JoinZone'):WaitForChild('EmitterPart').Position + Vector3.new(0, 
-2, 0)
            part.Size = Vector3.new(100, 2, 100)
            part.Anchored = true
            part.Name = 'FloorPart2'
            part.Parent = Workspace
        end
        function Teleport.DeleteWater()
            Workspace.Terrain:Clear()
        end
        function Teleport.FarmingHome()
            localPlayer.Character:WaitForChild('HumanoidRootPart').Anchored = true
            localPlayer.Character.HumanoidRootPart.CFrame = Workspace.FarmingHomeLocation.CFrame * CFrame.new(rng:NextInteger(1, 30), 10, rng:NextInteger(1, 30))
            localPlayer.Character:WaitForChild('HumanoidRootPart').Anchored = false

            localPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Landed)
            Teleport.DeleteWater()
        end
        function Teleport.MainMap()
            local isAlreadyOnMainMap = Workspace:FindFirstChild('Interiors'):FindFirstChild('center_map_plot', true)

            if isAlreadyOnMainMap then
                return
            end

            CollisionsClient.set_collidable(false)

            localPlayer.Character:WaitForChild('HumanoidRootPart').Anchored = true

            SetLocationFunc('MainMap', 'Neighborhood/MainDoor', {})
            Workspace.Interiors:WaitForChild(tostring(Workspace.Interiors:FindFirstChildWhichIsA('Model')))

            localPlayer.Character.PrimaryPart.CFrame = Workspace:WaitForChild('StaticMap'):WaitForChild('Campsite'):WaitForChild('CampsiteOrigin').CFrame + Vector3.new(math.random(1, 5), 10, math.random(1, 5))
            localPlayer.Character:WaitForChild('HumanoidRootPart').Anchored = false

            localPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Landed)
            Teleport.DeleteWater()
            task.wait(2)
        end
        function Teleport.Nursery()
            localPlayer.Character:WaitForChild('HumanoidRootPart').Anchored = true

            SetLocationFunc('Nursery', 'MainDoor', {})
            task.wait(1)
            Workspace.Interiors:WaitForChild(tostring(Workspace.Interiors:FindFirstChildWhichIsA('Model')))

            localPlayer.Character.PrimaryPart.CFrame = Workspace.Interiors.Nursery:WaitForChild('GumballMachine'):WaitForChild('Root').CFrame + Vector3.new(
-8, 10, 0)
            localPlayer.Character:WaitForChild('HumanoidRootPart').Anchored = false

            localPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Landed)
            task.wait(2)
        end

        function Teleport.Recycler()
            localPlayer.Character:WaitForChild('HumanoidRootPart').Anchored = true
            SetLocationFunc('Nursery', 'MainDoor', {})
            task.wait(1)
            Workspace.Interiors:WaitForChild(tostring(Workspace.Interiors:FindFirstChildWhichIsA('Model')))
            local recyclerModel = (workspace.Interiors.Nursery:WaitForChild('Recycler', 60))
            if not recyclerModel then
                return
            end

            local teleportPostion = recyclerModel:GetPivot().Position

            localPlayer.Character:MoveTo(teleportPostion)
			
            localPlayer.Character:WaitForChild('HumanoidRootPart').Anchored = false
            localPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Landed)
            task.wait(2)
        end
		
        function Teleport.CampSite()
            ReplicatedStorage.API['LocationAPI/SetLocation']:FireServer('MainMap', localPlayer, ClientData.get_data()[localPlayer.Name].LiveOpsMapType)
            task.wait(1)

            localPlayer.Character.PrimaryPart.CFrame = Workspace.CampingLocation.CFrame + Vector3.new(rng:NextInteger(1, 30), 5, rng:NextInteger(1, 30))

            localPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Landed)
            Teleport.DeleteWater()
        end
        function Teleport.BeachParty()
            ReplicatedStorage.API['LocationAPI/SetLocation']:FireServer('MainMap', localPlayer, ClientData.get_data()[localPlayer.Name].LiveOpsMapType)
            task.wait(1)

            localPlayer.Character.PrimaryPart.CFrame = Workspace.BeachPartyLocation.CFrame + Vector3.new(math.random(1, 30), 5, math.random(1, 30))

            localPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Landed)
            Teleport.DeleteWater()
        end
        function Teleport.Bonfire()
            ReplicatedStorage.API['LocationAPI/SetLocation']:FireServer('MainMap', localPlayer, ClientData.get_data()[localPlayer.Name].LiveOpsMapType)
            task.wait(1)

            local npc = workspace.HouseInteriors.furniture:FindFirstChild('summerfest_2025_bonfire_npc', true)

            if not npc then
                return
            end

            local location = npc.PrimaryPart.Position + Vector3.new(math.random(1, 15), 5, math.random(1, 15))

            localPlayer.Character:MoveTo(location)
            localPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Landed)
            Teleport.DeleteWater()
        end
        function Teleport.PlayGround(vec)
            localPlayer.Character:WaitForChild('HumanoidRootPart').Anchored = true

            SetLocationFunc('MainMap', 'Neighborhood/MainDoor', {})
            task.wait(1)
            Workspace.Interiors:WaitForChild(tostring(Workspace.Interiors:FindFirstChildWhichIsA('Model')))

            localPlayer.Character.PrimaryPart.CFrame = Workspace:WaitForChild('StaticMap'):WaitForChild('Park'):WaitForChild('Roundabout').PrimaryPart.CFrame + vec
            localPlayer.Character:WaitForChild('HumanoidRootPart').Anchored = false

            localPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Landed)
            Teleport.DeleteWater()
        end
        function Teleport.DownloadMainMap()
            local interiors = Workspace:WaitForChild('Interiors', 30)

            if not interiors then
                return
            end

            local isAlreadyOnMainMap = interiors:FindFirstChild('center_map_plot', true)

            if isAlreadyOnMainMap then
                return false
            end

            localPlayer.Character:WaitForChild('HumanoidRootPart').Anchored = true

            SetLocationFunc('MainMap', 'Neighborhood/MainDoor', {})
            task.wait(1)
            Workspace.Interiors:WaitForChild(tostring(Workspace.Interiors:FindFirstChildWhichIsA('Model')))

            localPlayer.Character:WaitForChild('HumanoidRootPart').Anchored = false

            localPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Landed)
            Teleport.DeleteWater()

            return true
        end
        function Teleport.MoonZone()
            localPlayer.Character:WaitForChild('HumanoidRootPart').Anchored = true

            SetLocationFunc('MoonInterior', 'MainDoor', {})
            task.wait(1)
            Workspace.Interiors:WaitForChild(tostring(Workspace.Interiors:FindFirstChildWhichIsA('Model')))

            localPlayer.Character:WaitForChild('HumanoidRootPart').Anchored = false

            localPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Landed)
        end
        function Teleport.SkyCastle()
            localPlayer.Character:WaitForChild('HumanoidRootPart').Anchored = true

            local isAlreadyOnSkyCastle = Workspace:WaitForChild('Interiors'):FindFirstChild('SkyCastle')

            if not isAlreadyOnSkyCastle then
                SetLocationFunc('SkyCastle', 'MainDoor', {})
            end

            task.wait(1)
            Workspace.Interiors:WaitForChild(tostring(Workspace.Interiors:FindFirstChildWhichIsA('Model')))

            local skyCastle = Workspace.Interiors:FindFirstChild('SkyCastle')

            if not skyCastle then
                return
            end

            skyCastle:WaitForChild('Potions')
            skyCastle.Potions:WaitForChild('GrowPotion')
            skyCastle.Potions.GrowPotion:WaitForChild('Part')

            localPlayer.Character.PrimaryPart.CFrame = skyCastle.Potions.GrowPotion.Part.CFrame + Vector3.new(math.random(1, 5), 10, math.random(
-5, -1))
            localPlayer.Character:WaitForChild('HumanoidRootPart').Anchored = false

            localPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Landed)
        end
        function Teleport.Neighborhood()
            localPlayer.Character:WaitForChild('HumanoidRootPart').Anchored = true

            SetLocationFunc('Neighborhood', 'MainDoor', {})
            task.wait(1)
            Workspace.Interiors:WaitForChild(tostring(Workspace.Interiors:FindFirstChildWhichIsA('Model')))

            if not Workspace.Interiors:FindFirstChild('Neighborhood!Fall') then
                return
            end

            Workspace.Interiors['Neighborhood!Fall']:WaitForChild('InteriorOrigin')

            localPlayer.Character.PrimaryPart.CFrame = Workspace.Interiors['Neighborhood!Fall'].InteriorOrigin.CFrame + Vector3.new(0, 
-10, 0)
            localPlayer.Character:WaitForChild('HumanoidRootPart').Anchored = false

            localPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Landed)
            Teleport.DeleteWater()
        end

        return Teleport
    end
    function __DARKLUA_BUNDLE_MODULES.g()
        local ReplicatedStorage = cloneref(game:GetService('ReplicatedStorage'))
        local Players = cloneref(game:GetService('Players'))
        local Bypass = (require(ReplicatedStorage:WaitForChild('Fsys')).load)
        local ClientData = Bypass('ClientData')
        local RouterClient = Bypass('RouterClient')
        local InventoryDB = Bypass('InventoryDB')
        local Utils = __DARKLUA_BUNDLE_MODULES.load('a')
        local self = {}
        local localPlayer = Players.LocalPlayer
        local buyItem = function(valuesTable, howManyToBuy)
            local hasMoney = Bypass('RouterClient').get('ShopAPI/BuyItem'):InvokeServer(valuesTable.category, valuesTable.id, {
                ['buy_count'] = howManyToBuy,
            })

            if hasMoney ~= 'success' then
                return false
            end

            return true
        end
        local getAmountToPurchase = function(valuesTable, currencyLimit)
            local currency = ClientData.get_data()[localPlayer.Name][valuesTable.currency_id] or ClientData.get_data()[localPlayer.Name]['money']

            if not currency then
                return 0, Utils.PrintDebug('NO CURRENCY ON PLAYER')
            end

            currency = currency - currencyLimit

            local count = 0

            while true do
                local moneyLeft = currency - valuesTable.cost

                if moneyLeft <= 0 then
                    break
                end
                if count >= 99 then
                    break
                end

                currency = moneyLeft
                count = count + 1

                task.wait()
            end

            return count
        end
        local getHowManyCanPurchase = function(valuesTable, maxAmount)
            local currency = ClientData.get_data()[localPlayer.Name][valuesTable.currency_id] or ClientData.get_data()[localPlayer.Name]['money']

            if not currency then
                return 0, Utils.PrintDebug('NO CURRENCY ON PLAYER')
            end
            if not valuesTable.cost then
                return 0, Utils.PrintDebug('Pet doesnt have Cost to it?')
            end

            local count = 0

            while true do
                local moneyLeft = currency - valuesTable.cost

                if moneyLeft <= 0 then
                    break
                end
                if count >= maxAmount or count >= 99 then
                    break
                end

                currency = moneyLeft
                count = count + 1

                task.wait()
            end

            Utils.PrintDebug(string.format('getHowManyCanPurchase: %s', tostring(count)))

            return count
        end
        local getItemInfoFromDatabase = function(nameId)
            assert(typeof(nameId) == 'string', 'getItemInfoFromDatabase: is not a string')

            for _, v in InventoryDB do
                for key, value in v do
                    if key == nameId then
                        return value
                    end
                end
            end

            return nil
        end
        local getAmountNeeded = function(nameId, maxAmount)
            local itemValues = getItemInfoFromDatabase(nameId)

            if not itemValues then
                return 0
            end

            local count = 0

            for _, item in ClientData.get_data()[localPlayer.Name].inventory[itemValues.category]do
                if nameId == item.id then
                    count = count + 1
                end
            end

            if count < maxAmount then
                return (maxAmount - count)
            end

            return 0
        end
        local buyPet = function(valuesTable, howManyToBuy)
            local hasMoney = RouterClient.get('ShopAPI/BuyItem'):InvokeServer(valuesTable.category, valuesTable.id, {
                ['buy_count'] = howManyToBuy,
            })

            if hasMoney ~= 'success' then
                return false
            end

            return true
        end
        local openBox = function(nameId)
            local itemValues = getItemInfoFromDatabase(nameId)

            if not itemValues then
                return
            end

            for _, v in ClientData.get_data()[localPlayer.Name].inventory[itemValues.category]do
                if v.id == nameId then
                    RouterClient.get('LootBoxAPI/ExchangeItemForReward'):InvokeServer(v['id'], v['unique'])
                    task.wait(0.1)
                end
            end
        end

        function self.StartBuyItems(itemToBuy)
            for _, value in ipairs(itemToBuy)do
                while true do
                    local itemValues = getItemInfoFromDatabase(value.NameId)

                    if not itemValues then
                        break
                    end

                    local amountNeeded = getAmountNeeded(value.NameId, value.MaxAmount)

                    if amountNeeded == 0 then
                        Utils.PrintDebug(string.format('has max amount of: %s skipping', tostring(value.NameId)))

                        break
                    end

                    local amountPurchase = getHowManyCanPurchase(itemValues, amountNeeded)

                    if amountPurchase == 0 then
                        Utils.PrintDebug(string.format('amount to purchase is: %s', tostring(amountPurchase)))

                        break
                    end
                    if not buyPet(itemValues, amountPurchase) then
                        Utils.PrintDebug('Has no money to buy more or something went wrong.')

                        break
                    end

                    task.wait()
                end
            end
        end
        function self.OpenItems(nameIdTable)
            assert(typeof(nameIdTable) == 'table', 'is not a table')

            for _, v in nameIdTable do
                openBox(v)
            end
        end
        function self.BuyGlormy()
            local stones = ClientData.get_data()[localPlayer.Name].social_stones_2025 or 0

            if stones <= 24 then
                return
            end

            RouterClient.get('SocialStonesAPI/AttemptExchange'):FireServer('pets', 'moon_2025_glormy_dolphin', 1)
        end
        function self.BuyItemWithCurrencyLimit(itemNameId, currencyLimit)
            while Bypass('ClientData').get_data()[localPlayer.Name].money >= currencyLimit do
                local itemValues = getItemInfoFromDatabase(itemNameId)

                if not itemValues then
                    break
                end

                local amountPurchase = getAmountToPurchase(itemValues, currencyLimit)

                if amountPurchase <= 0 then
                    break
                end
                if not buyItem(itemValues, amountPurchase) then
                    break
                end

                task.wait(1)
            end
        end

        return self
    end
    function __DARKLUA_BUNDLE_MODULES.h()
        local ReplicatedStorage = cloneref(game:GetService('ReplicatedStorage'))
        local Players = cloneref(game:GetService('Players'))
        local Bypass = (require(ReplicatedStorage:WaitForChild('Fsys')).load)
        local ClientData = (Bypass('ClientData'))
        local self = {}
        local localPlayer = Players.LocalPlayer
        local getFullgrownPets = function(mega)
            local fullgrownTable = {}

            if mega then
                for _, v in ClientData.get_data()[localPlayer.Name].inventory.pets do
                    if v.properties.age == 6 and v.properties.neon then
                        if not fullgrownTable[v.id] then
                            fullgrownTable[v.id] = {
                                ['count'] = 0,
                                ['unique'] = {},
                            }
                        end

                        do
                            local __DARKLUA_VAR = fullgrownTable[v.id]

                            __DARKLUA_VAR['count'] = __DARKLUA_VAR['count'] + 1
                        end

                        table.insert(fullgrownTable[v.id]['unique'], v.unique)

                        if fullgrownTable[v.id]['count'] >= 4 then
                            break
                        end
                    end
                end
            else
                for _, v in ClientData.get_data()[localPlayer.Name].inventory.pets do
                    if v.properties.age == 6 and not v.properties.neon and not v.properties.mega_neon then
                        if not fullgrownTable[v.id] then
                            fullgrownTable[v.id] = {
                                ['count'] = 0,
                                ['unique'] = {},
                            }
                        end

                        do
                            local __DARKLUA_VAR = fullgrownTable[v.id]

                            __DARKLUA_VAR['count'] = __DARKLUA_VAR['count'] + 1
                        end

                        table.insert(fullgrownTable[v.id]['unique'], v.unique)

                        if fullgrownTable[v.id]['count'] >= 4 then
                            break
                        end
                    end
                end
            end

            return fullgrownTable
        end

        function self.MakeMega(bool)
            repeat
                local fusionReady = {}
                local fullgrownTable = getFullgrownPets(bool)

                for _, valueTable in fullgrownTable do
                    if valueTable.count >= 4 then
                        table.insert(fusionReady, valueTable.unique[1])
                        table.insert(fusionReady, valueTable.unique[2])
                        table.insert(fusionReady, valueTable.unique[3])
                        table.insert(fusionReady, valueTable.unique[4])

                        break
                    end
                end

                if #fusionReady >= 4 then
                    ReplicatedStorage.API:FindFirstChild('PetAPI/DoNeonFusion'):InvokeServer({
                        unpack(fusionReady),
                    })
                    task.wait()
                end
            until #fusionReady <= 3
        end

        return self
    end
    function __DARKLUA_BUNDLE_MODULES.i()
        local ReplicatedStorage = game:GetService('ReplicatedStorage')
        local Players = game:GetService('Players')
        local Bypass = (require(ReplicatedStorage:WaitForChild('Fsys')).load)
        local ClientData = (Bypass('ClientData'))
        local RouterClient = Bypass('RouterClient')
        local InventoryDB = Bypass('InventoryDB')
        local AllowOrDenyList = __DARKLUA_BUNDLE_MODULES.load('c')
        local Utils = __DARKLUA_BUNDLE_MODULES.load('a')
        local GetInventory = {}
        --local PetsToReleaseList = getgenv().SETTINGS.PETS_TO_AGE_IN_PEN or {}
        local localPlayer = Players.LocalPlayer
        local eggList = {}
        local equipWhichPet = function(whichPet, petUnique)
            if whichPet == 1 then
                RouterClient.get('ToolAPI/Equip'):InvokeServer(petUnique, {
                    ['equip_as_last'] = false,
                })

                getgenv().petCurrentlyFarming1 = petUnique

                return true
            elseif whichPet == 2 then
                RouterClient.get('ToolAPI/Equip'):InvokeServer(petUnique, {
                    ['equip_as_last'] = true,
                })

                getgenv().petCurrentlyFarming2 = petUnique

                return true
            end

            return false
        end

       --[[function GetInventory.GetPetUniquesForPetPen(
            petIds,
            CurrentIdlePets,
            amount
        )
            local petUniques = {}
            for _, v in ClientData.get_data()[localPlayer.Name].inventory.pets do
                if not table.find(petIds, v.id) then
                    continue
                end
                if table.find(CurrentIdlePets, v.unique) then
                    continue
                end
                if v.properties.age == 6 then
                    continue
                end
                if v.properties.mega_neon then
                    continue
                end
                table.insert(petUniques, v.unique)
                if #petUniques >= amount then
                    break
                end
            end
            return petUniques
        end--]]

        --[[function GetInventory.GetPetsToRelease()
            local petUniques = {}
            for _, pet in ClientData.get_data()[localPlayer.Name].inventory.pets do
                if not table.find(PetsToReleaseList, pet.id) then
                    continue
                end
                if pet.properties.mega_neon then
                    petUniques[pet.unique] = true
                end
            end
            return petUniques
        end --]]		

        function GetInventory.GetAgeablePets()
            local ageablePets = {}
            local eggList = GetInventory.GetPetEggs()

            for _, pet in ClientData.get_data()[localPlayer.Name].inventory.pets do
                if table.find(AllowOrDenyList.Denylist, pet.id) then
                    continue
                end
                if table.find(eggList, pet.id) then
                    continue
                end
                if pet.properties.age == 6 or (pet.properties.neon and pet.properties.age == 6) or pet.properties.mega_neon then
                    continue
                end
                if table.find(ageablePets, pet.id) then
                    continue
                end

                table.insert(ageablePets, pet.id)
            end

            table.sort(ageablePets)

            return ageablePets
        end
        function GetInventory.GetAll()
            return ClientData.get_data()[localPlayer.Name].inventory
        end
        function GetInventory.TabId(tabId)
            local inventoryTable = {}

            for _, v in ClientData.get_data()[localPlayer.Name].inventory[tabId]do
                if table.find(AllowOrDenyList.Denylist, v.id) then
                    continue
                end
                if table.find(inventoryTable, v.id) then
                    continue
                end

                table.insert(inventoryTable, v.id)
            end

            table.sort(inventoryTable)

            return inventoryTable
        end
        function GetInventory.IsFarmingSelectedPet(hasProHandler)
            if hasProHandler then
                if not ClientData.get('pet_char_wrappers')[2] then
                    return
                end
                if getgenv().petCurrentlyFarming2 == ClientData.get('pet_char_wrappers')[2]['pet_unique'] then
                    return
                end

                RouterClient.get('ToolAPI/Equip'):InvokeServer(getgenv().petCurrentlyFarming2, {})
            end
            if not ClientData.get('pet_char_wrappers')[1] then
                return
            end
            if getgenv().petCurrentlyFarming1 == ClientData.get('pet_char_wrappers')[1]['pet_unique'] then
                return
            end

            RouterClient.get('ToolAPI/Equip'):InvokeServer(getgenv().petCurrentlyFarming1, {})
            task.wait(2)
        end
        function GetInventory.GetPetFriendship(petTable, whichPet)
            local level = 0
            local petUnique = nil

            for _, pet in ClientData.get_data()[localPlayer.Name].inventory.pets do
                if table.find(AllowOrDenyList.Denylist, pet.id) then
                    continue
                end
                if not table.find(petTable, pet.id) then
                    continue
                end
                if not pet.properties then
                    continue
                end
                if not pet.properties.friendship_level then
                    continue
                end
                if pet.properties.friendship_level > level then
                    if pet.unique == getgenv().petCurrentlyFarming1 then
                        continue
                    end
                    if pet.unique == getgenv().petCurrentlyFarming2 then
                        continue
                    end

                    level = pet.properties.friendship_level
                    petUnique = pet.unique
                end
            end

            if not petUnique then
                return false
            end

            equipWhichPet(whichPet, petUnique)

            return true
        end
        function GetInventory.GetHighestGrownPet(age, whichPet)
            local PetageCounter = age
            local isNeon = true
            local petFound = false

            while not petFound do
                for _, pet in ClientData.get_data()[localPlayer.Name].inventory.pets do
                    if table.find(AllowOrDenyList.Denylist, pet.id) then
                        continue
                    end
                    if pet.properties.age == PetageCounter and pet.properties.neon == isNeon then
                        if pet.unique == getgenv().petCurrentlyFarming1 then
                            continue
                        end
                        if pet.unique == getgenv().petCurrentlyFarming2 then
                            continue
                        end

                        equipWhichPet(whichPet, pet.unique)

                        return true
                    end
                end

                PetageCounter = PetageCounter - 1

                if PetageCounter <= 0 and isNeon then
                    PetageCounter = age
                    isNeon = nil
                elseif PetageCounter <= 0 and isNeon == nil then
                    return false
                end

                task.wait()
            end

            return false
        end

        function GetInventory.GetHighestGrownPetForIdle(age)
            local PetageCounter = age
            local isNeon = true
            local petFound = false
            local petUniques = {}

            while not petFound do
                for _, pet in ClientData.get_data()[localPlayer.Name].inventory.pets do
                    if table.find(AllowOrDenyList.Denylist, pet.id) then
                        continue
                    end
                    if pet.properties.age == PetageCounter and pet.properties.neon == isNeon then
                        if pet.unique == getgenv().petCurrentlyFarming1 then
                            continue
                        end
                        if pet.unique == getgenv().petCurrentlyFarming2 then
                            continue
                        end

                        table.insert(petUniques, pet.unique)

                        if #petUniques >= 4 then
                            return petUniques
                        end
                    end
                end

                PetageCounter = PetageCounter - 1

                if PetageCounter <= 0 and isNeon then
                    PetageCounter = age
                    isNeon = nil
                elseif PetageCounter <= 0 and isNeon == nil then
                    return petUniques
                end

                task.wait()
            end

            return petUniques
        end
		
        function GetInventory.GetPetRarity()
            if not Utils.IsPetEquipped(1) then
                return nil
            end
            local farmingPetId = ClientData.get('pet_char_wrappers')[1]['pet_id']
            for _, petDB in InventoryDB.pets do
                if petDB.id == farmingPetId then
                    return petDB.rarity
                end
            end
            return nil
        end
        function GetInventory.PetRarityAndAge(rarity, age, whichPet)
            local PetageCounter = age
            local isNeon = true
            local petFound = false

            while not petFound do
                for _, pet in ClientData.get_data()[localPlayer.Name].inventory.pets do
                    for _, petDB in InventoryDB.pets do
                        if table.find(AllowOrDenyList.Denylist, pet.id) then
                            continue
                        end
                        if rarity == petDB.rarity and pet.id == petDB.id and pet.properties.age == PetageCounter and pet.properties.neon == isNeon then
                            if pet.unique == getgenv().petCurrentlyFarming1 then
                                continue
                            end
                            if pet.unique == getgenv().petCurrentlyFarming2 then
                                continue
                            end

                            equipWhichPet(whichPet, pet.unique)

                            return true
                        end
                    end
                end

                PetageCounter = PetageCounter - 1

                if PetageCounter <= 0 and isNeon then
                    PetageCounter = age
                    isNeon = nil
                elseif PetageCounter <= 0 and isNeon == nil then
                    return false
                end

                task.wait()
            end

            return false
        end
        function GetInventory.CheckForPetAndEquip(nameIds, whichPet)
            local level = 0
            local petUnique = nil

            for _, pet in ClientData.get_data()[localPlayer.Name].inventory['pets']do
                if table.find(nameIds, pet.id) then
                    if not pet.properties then
                        continue
                    end
                    if not pet.properties.friendship_level then
                        continue
                    end
                    if pet.properties.friendship_level > level then
                        if pet.unique == getgenv().petCurrentlyFarming1 then
                            continue
                        end
                        if pet.unique == getgenv().petCurrentlyFarming2 then
                            continue
                        end

                        level = pet.properties.friendship_level
                        petUnique = pet.unique
                    end
                end
            end

            if petUnique then
                equipWhichPet(whichPet, petUnique)

                return true
            end

            local PetageCounter = 6
            local isNeon = true
            local petFound = false

            while not petFound do
                for _, pet in ClientData.get_data()[localPlayer.Name].inventory.pets do
                    if table.find(nameIds, pet.id) and pet.properties.age == PetageCounter and pet.properties.neon == isNeon then
                        if pet.unique == getgenv().petCurrentlyFarming1 then
                            continue
                        end
                        if pet.unique == getgenv().petCurrentlyFarming2 then
                            continue
                        end

                        equipWhichPet(whichPet, pet.unique)

                        return true
                    end
                end

                PetageCounter = PetageCounter - 1

                if PetageCounter <= 0 and isNeon then
                    PetageCounter = 6
                    isNeon = nil
                elseif PetageCounter <= 0 and isNeon == nil then
                    return false
                end

                task.wait()
            end

            return false
        end
        function GetInventory.GetUniqueId(tabId, nameId)
            for _, v in ClientData.get_data()[localPlayer.Name].inventory[tabId]do
                if v.id == nameId then
                    return v.unique
                end
            end

            return nil
        end
        function GetInventory.IsPetInInventory(tabId, uniqueId)
            for _, v in ClientData.get_data()[localPlayer.Name].inventory[tabId]do
                if v.unique == uniqueId then
                    return true
                end
            end

            return false
        end
        function GetInventory.PriorityEgg(whichPet)
            for _, v in ipairs(getgenv().SETTINGS.HATCH_EGG_PRIORITY_NAMES)do
                for _, v2 in ClientData.get_data()[localPlayer.Name].inventory.pets do
                    if table.find(AllowOrDenyList.Denylist, v2.id) then
                        continue
                    end
                    if v == v2.id then
                        if v2.unique == getgenv().petCurrentlyFarming1 then
                            continue
                        end
                        if v2.unique == getgenv().petCurrentlyFarming2 then
                            continue
                        end

                        equipWhichPet(whichPet, v2.unique)

                        return true
                    end
                end
            end

            return false
        end
        function GetInventory.GetPetEggs()
            if #eggList >= 1 then
                return eggList
            end

            for i, v in InventoryDB.pets do
                if v.is_egg then
                    table.insert(eggList, v.id)
                end
            end

            return eggList
        end
        function GetInventory.GetNeonPet(whichPet)
            local Petage = 5
            local isNeon = true
            local found_pet = false

            while not found_pet do
                for _, v in ClientData.get_data()[localPlayer.Name].inventory.pets do
                    if table.find(AllowOrDenyList.Denylist, v.id) then
                        continue
                    end
                    if v.properties.age == Petage and v.properties.neon == isNeon then
                        if v.unique == getgenv().petCurrentlyFarming1 then
                            continue
                        end
                        if v.unique == getgenv().petCurrentlyFarming2 then
                            continue
                        end

                        equipWhichPet(whichPet, v.unique)

                        return true
                    end
                end

                if not found_pet then
                    Petage = Petage - 1

                    if Petage == 0 and isNeon == true then
                        return false
                    end
                end

                task.wait()
            end

            return false
        end
        function GetInventory.PriorityPet(whichPet)
            local Petage = 5
            local isNeon = true
            local found_pet = false

            while found_pet == false do
                for _, v in ipairs(getgenv().SETTINGS.PET_ONLY_PRIORITY_NAMES)do
                    for _, v2 in pairs(ClientData.get_data()[localPlayer.Name].inventory.pets)do
                        if v2.unique == getgenv().petCurrentlyFarming1 then
                            continue
                        end
                        if v2.unique == getgenv().petCurrentlyFarming2 then
                            continue
                        end
                        if table.find(AllowOrDenyList.Denylist, v2.id) then
                            continue
                        end
                        if v == v2.id and v2.properties.age == Petage and v2.properties.neon == isNeon then
                            equipWhichPet(whichPet, v2.unique)

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
                        return false
                    end
                end

                task.wait()
            end

            return false
        end

        return GetInventory
    end
    function __DARKLUA_BUNDLE_MODULES.j()
        local ReplicatedStorage = cloneref(game:GetService('ReplicatedStorage'))
        local Players = cloneref(game:GetService('Players'))
        local PetPotionEffectsDB = (require(ReplicatedStorage:WaitForChild('ClientDB'):WaitForChild('PetPotionEffectsDB')))
        local Bypass = (require(ReplicatedStorage:WaitForChild('Fsys')).load)
        local ClientData = Bypass('ClientData')
        local RouterClient = Bypass('RouterClient')
        local Fusion = __DARKLUA_BUNDLE_MODULES.load('h')
        local Utils = __DARKLUA_BUNDLE_MODULES.load('a')
        local GetInventory = __DARKLUA_BUNDLE_MODULES.load('i')
        local BulkPotion = {}
        local localPlayer = Players.LocalPlayer

        BulkPotion.SameUnqiue = {}
        BulkPotion.SameUnqiueCount = 0
        BulkPotion.StopAging = false
        BulkPotion.PetAge = 0
        BulkPotion.PetUniqueId = ''

        local waitForPetToEquip = function()
            local startTime = DateTime.now().UnixTimestamp
            local isStuck = false

            repeat
                task.wait()

                local isEquipped = ClientData.get('pet_char_wrappers')[1]
                local currentTime = DateTime.now().UnixTimestamp

                if currentTime - startTime >= 10 then
                    isStuck = true
                end
            until isEquipped or isStuck

            if isStuck then
                Utils.PrintDebug('Unable to equip pet')

                return false
            end

            Utils.PrintDebug('Pet is Equipped')

            return true
        end
        local getMaxMega = function(petId)
            local count = 0

            for _, v in ClientData.get_data()[localPlayer.Name].inventory.pets do
                if v.id == petId and v.properties.mega_neon then
                    count = count + 1
                end
            end

            return count
        end

        local getPotionUniques = function(nameId)
            local potions = {}
            local amountNeeded = PetPotionEffectsDB[nameId].multi_use_count(ClientData.get('pet_char_wrappers')[1], ClientData.get_data()[localPlayer.Name].inventory.pets[ClientData.get('pet_char_wrappers')[1].pet_unique])

            if amountNeeded <= 0 then
                return potions
            end

            for _, v in ClientData.get_data()[localPlayer.Name].inventory.food do
                if v.id == nameId then
                    table.insert(potions, v.unique)

                    amountNeeded = amountNeeded - 1

                    if amountNeeded <= 0 then
                        break
                    end
                end
            end

            return potions
        end
        local createPotionObject = function(potionTable)
            local petIndex = ClientData.get('pet_char_wrappers')[1]
            local petUnique = (petIndex and {
                (petIndex.pet_unique),
            } or {nil})[1]

            if not petUnique then
                return false
            end
            if #potionTable == 1 then
                return RouterClient.get('PetObjectAPI/CreatePetObject'):InvokeServer('__Enum_PetObjectCreatorType_2', {
                    ['pet_unique'] = petUnique,
                    ['unique_id'] = potionTable[1],
                })
            elseif #potionTable >= 2 then
                local newpotionTable = table.clone(potionTable)

                table.remove(newpotionTable, 1)

                return RouterClient.get('PetObjectAPI/CreatePetObject'):InvokeServer('__Enum_PetObjectCreatorType_2', {
                    ['pet_unique'] = petUnique,
                    ['unique_id'] = potionTable[1],
                    ['additional_consume_uniques'] = newpotionTable,
                })
            end

            return false
        end
        local hasAgeUpPotion = function()
            for _, v in ClientData.get_data()[localPlayer.Name].inventory.food do
                if v.id == 'pet_age_potion' or v.id == 'tiny_pet_age_potion' then
                    return true
                end
            end

            return false
        end
        local formatTableToDict = function(tableToFormat)
            Utils.PrintDebug('[DEBUG] formatting table')

            local mytable = {}

            for _, v in tableToFormat do
                table.insert(mytable, {
                    NameId = v,
                    MaxAmount = 666,
                })
            end

            return mytable
        end

        function BulkPotion.IsPetNormal(petName)
            BulkPotion.PetAge = 0
            BulkPotion.PetUniqueId = ''

            for _, v in ClientData.get_data()[localPlayer.Name].inventory.pets do
                if v.id == petName and v.id ~= 'practice_dog' and v.properties.age ~= 6 and not v.properties.mega_neon then
                    if BulkPotion.PetAge < v.properties.age then
                        BulkPotion.PetAge = v.properties.age
                        BulkPotion.PetUniqueId = v.unique
                    end
                end
            end

            if BulkPotion.PetUniqueId ~= '' then
                RouterClient.get('ToolAPI/Unequip'):InvokeServer(BulkPotion.PetUniqueId, {
                    ['use_sound_delay'] = true,
                })
                task.wait(1)
                RouterClient.get('ToolAPI/Equip'):InvokeServer(BulkPotion.PetUniqueId, {
                    ['use_sound_delay'] = true,
                })
                waitForPetToEquip()
                Utils.PrintDebug(string.format('pet age: %s, and NORMAL', tostring(BulkPotion.PetAge)))

                return true
            end

            return false
        end
        function BulkPotion.IsPetNeon(petName)
            BulkPotion.PetAge = 0
            BulkPotion.PetUniqueId = ''

            for _, v in ClientData.get_data()[localPlayer.Name].inventory.pets do
                if v.id == petName and v.id ~= 'practice_dog' and v.properties.age ~= 6 and v.properties.neon and not v.properties.mega_neon then
                    if BulkPotion.PetAge < v.properties.age then
                        BulkPotion.PetAge = v.properties.age
                        BulkPotion.PetUniqueId = v.unique
                    end
                end
            end

            if BulkPotion.PetUniqueId ~= '' then
                RouterClient.get('ToolAPI/Unequip'):InvokeServer(BulkPotion.PetUniqueId, {
                    ['use_sound_delay'] = true,
                })
                task.wait(1)
                RouterClient.get('ToolAPI/Equip'):InvokeServer(BulkPotion.PetUniqueId, {
                    ['use_sound_delay'] = true,
                })
                waitForPetToEquip()
                Utils.PrintDebug(string.format('pet age: %s and NEON', tostring(BulkPotion.PetAge)))

                return true
            end
            if BulkPotion.IsPetNormal(petName) then
                return true
            else
                return false
            end
        end
        function BulkPotion.IsSameUnique()
            for _, v in ClientData.get_data()[localPlayer.Name].inventory.food do
                if v.id == 'pet_age_potion' or v.id == 'tiny_pet_age_potion' then
                    if table.find(BulkPotion.SameUnqiue, v.unique) then
                        Utils.PrintDebug('has same unqiue age up potion')

                        BulkPotion.SameUnqiueCount = BulkPotion.SameUnqiueCount + 1

                        if BulkPotion.SameUnqiueCount >= 15 then
                            Utils.PrintDebug('\u{26a0}\u{fe0f} SAME POTION HAS BEEN TRIED 15 TIMES. MUST BE STUCK \u{26a0}\u{fe0f}')

                            BulkPotion.SameUnqiueCount = 0
                            BulkPotion.SameUnqiue = {}
                        end

                        task.wait(1)

                        return true
                    end
                end
            end

            BulkPotion.SameUnqiueCount = 0
            BulkPotion.SameUnqiue = {}

            return false
        end
        function BulkPotion.IsEgg()
            local EquipTimeout = 0
            local hasPetChar = false

            repeat
                task.wait(1)

                hasPetChar = ClientData.get('pet_char_wrappers')[1] and ClientData.get('pet_char_wrappers')[1]['char'] and true or false
                EquipTimeout = EquipTimeout + 1
            until hasPetChar or EquipTimeout >= 30

            if EquipTimeout >= 30 then
                Utils.PrintDebug('\u{26a0}\u{fe0f} Waited too long for Equipping pet so Stopping aging \u{26a0}\u{fe0f}')

                BulkPotion.StopAging = true

                return true
            end

            local isEgg = table.find(GetInventory.GetPetEggs(), ClientData.get('pet_char_wrappers')[1]['pet_id']) and true or false

            return isEgg
        end
        function BulkPotion.FeedAgePotion()
            if BulkPotion.IsEgg() then
                return
            end
            if BulkPotion.IsSameUnique() then
                return
            end

            BulkPotion.SameUnqiueCount = 0

            local potionUniques

            potionUniques = getPotionUniques('pet_age_potion')

            if #potionUniques <= 0 then
                table.clear(potionUniques)

                potionUniques = getPotionUniques('tiny_pet_age_potion')
            end
            if #potionUniques <= 0 then
                return
            end

            BulkPotion.SameUnqiue = potionUniques

            Utils.PrintDebug(string.format('USING POTIONS: %s', tostring(#potionUniques)))
            Utils.PrintDebug(createPotionObject(potionUniques))
            task.wait(2)

            return
        end
        function BulkPotion.AgeAllPetsOfSameName(petId, maxAmount)
            if getgenv().SETTINGS.PET_AUTO_FUSION then
                Fusion.MakeMega(false)
                task.wait(1)
                Fusion.MakeMega(true)
                task.wait(1)
            end

            local result = getMaxMega(petId)

            if result >= maxAmount then
                return false
            end

            local hasPet = BulkPotion.IsPetNeon(petId)

            if not hasPet then
                return false
            end

            while true do
                if BulkPotion.IsEgg() then
                    return false
                end
                if ClientData.get('pet_char_wrappers')[1]['pet_progression']['age'] >= 6 then
                    break
                end
                if not hasAgeUpPotion() then
                    BulkPotion.StopAging = true

                    return false
                end

                BulkPotion.FeedAgePotion()
                task.wait()
            end

            if BulkPotion.StopAging then
                return false
            end

            BulkPotion.AgeAllPetsOfSameName(petId, maxAmount)

            return false
        end
        function BulkPotion.StartAgingPets(petsTable)
            assert(typeof(petsTable) == 'table', 'is not a table')

            if typeof(petsTable[1]) ~= 'table' then
                petsTable = formatTableToDict(petsTable)
            end

            for _, value in ipairs(petsTable)do
                if BulkPotion.StopAging then
                    Utils.PrintDebug('stop aging is true, so stopped')

                    return
                end

                local result = getMaxMega(value.NameId)

                if not value.MaxAmount then
                    value.MaxAmount = 666
                end
                if result >= value.MaxAmount then
                    return false, Utils.PrintDebug(string.format('Pet: %s has maxed Amount: %s', tostring(value.NameId), tostring(result)))
                end

                BulkPotion.AgeAllPetsOfSameName(value.NameId, value.MaxAmount)
            end

            return
        end

        return BulkPotion
    end
    function __DARKLUA_BUNDLE_MODULES.k()
        local ReplicatedStorage = cloneref(game:GetService('ReplicatedStorage'))
        local VirtualUser = cloneref(game:GetService('VirtualUser'))
        local Players = cloneref(game:GetService('Players'))
        local StarterGui = cloneref(game:GetService('StarterGui'))
        local Bypass = (require(ReplicatedStorage:WaitForChild('Fsys')).load)
        local RouterClient = Bypass('RouterClient')
        local Utils = __DARKLUA_BUNDLE_MODULES.load('a')
        local Furniture = __DARKLUA_BUNDLE_MODULES.load('b')
        local Trade = __DARKLUA_BUNDLE_MODULES.load('e')
        local Teleport = __DARKLUA_BUNDLE_MODULES.load('f')
        local BuyItem = __DARKLUA_BUNDLE_MODULES.load('g')
        local BulkPotion = __DARKLUA_BUNDLE_MODULES.load('j')
        local Fusion = __DARKLUA_BUNDLE_MODULES.load('h')
        local self = {}
        local localPlayer = Players.LocalPlayer
        local rng = Random.new()
        local PlayerGui = localPlayer:WaitForChild('PlayerGui')
        local DialogApp = (PlayerGui:WaitForChild('DialogApp'))
        local NewsApp = (PlayerGui:WaitForChild('NewsApp'))
        local pickColorConn = nil
        local pickColorTutorial = function()
            local colorButton = (DialogApp.Dialog.ThemeColorDialog:WaitForChild('Info'):WaitForChild('Response'):WaitForChild('ColorTemplate'))

            if not colorButton then
                return
            end

            Utils.FireButton(colorButton)
            task.wait(3)

            local doneButton = (DialogApp.Dialog.ThemeColorDialog:WaitForChild('Buttons'):WaitForChild('ButtonTemplate'))

            if not doneButton then
                return
            end

            Utils.FireButton(doneButton)
            Utils.PrintDebug('PICKED COLOR')
        end
        local isPlayersInGame = function(playerList)
            for _, player in Players:GetPlayers()do
                if table.find(playerList, player.Name) then
                    return true
                end
            end

            return false
        end
        local loopFurniture = function(dict)
            local updateWithNewKey = false

            for key, value in dict do
                if dict[key] == 'nil' then
                    updateWithNewKey = true

                    Utils.PrintDebug(string.format('\u{1f4b8} No key: %s value: %s , so trying to buy it \u{1f4b8}', tostring(key), tostring(value)))
                    Furniture.BuyFurniture(key)
                    task.wait(1)
                end
            end

            if updateWithNewKey then
                Furniture.GetFurnituresKey()
            end
        end

        local findHomeButtonAndClick = function()
            local homeFrame = (DialogApp:FindFirstChild('Home', true))

            if not homeFrame or not homeFrame.Visible then
                return
            end

            local button = (homeFrame:WaitForChild('Button', 6))

            if not button then
                return
            end

            Utils.FireButton(button)
        end
		
        function self.Init()
            DialogApp.Dialog.ThemeColorDialog:GetPropertyChangedSignal('Visible'):Connect(pickColorTutorial)
            DialogApp.Dialog.SpawnChooserDialog:GetPropertyChangedSignal('Visible'):Connect(findHomeButtonAndClick)
            Players.PlayerAdded:Connect(function(player)
                player.CharacterAdded:Connect(function(character)
                    if table.find(getgenv().SETTINGS.TRADE_COLLECTOR_NAME, localPlayer.Name) then
                        return
                    end
                    if not table.find(getgenv().SETTINGS.TRADE_COLLECTOR_NAME, player.Name) then
                        return
                    end

                    local humanoidRootPart = character:WaitForChild('HumanoidRootPart', 120)

                    if not humanoidRootPart then
                        return
                    end

                    task.wait(rng:NextNumber(1, 20))

                    if getgenv().SETTINGS.ENABLE_TRASH_COLLECTOR then
                        getgenv().SETTINGS.ENABLE_TRADE_COLLECTOR = false

                        Utils.PrintDebug('TRADING trash collector')
                        Trade.TradeTrashCollector(getgenv().SETTINGS.TRASH_COLLECTOR_NAMES)
                    elseif getgenv().SETTINGS.ENABLE_TRADE_COLLECTOR then
                        Trade.TradeCollector(getgenv().SETTINGS.TRADE_COLLECTOR_NAME)
                    end
                end)
            end)

            local queueOnTeleport = (syn and syn.queue_on_teleport) or queue_on_teleport

            if queueOnTeleport then
                queueOnTeleport('\r\n            game:Shutdown()\r\n        ')
            end
        end
        function self.Start()
            --setfpscap(getgenv().SETTINGS.SET_FPS)
            StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Captures, false)

            if DialogApp.Dialog.ThemeColorDialog.Visible then
                Utils.PrintDebug('picking color')
                pickColorTutorial()

                if pickColorConn then
                    pickColorConn:Disconnect()
                end
            end
            if NewsApp.Enabled then
                Utils.PrintDebug('NEWSAPP ENABLED')

                local AbsPlay = (NewsApp:WaitForChild('EnclosingFrame'):WaitForChild('MainFrame'):WaitForChild('Buttons'):WaitForChild('PlayButton'))

                Utils.FireButton(AbsPlay)
                Utils.PrintDebug('NEWSAPP CLICKED')
            end

            findHomeButtonAndClick()

            if not localPlayer.Character then
                Utils.PrintDebug('NO CHARACTER SO WAITING')
                localPlayer.CharacterAdded:Wait()
            end

            RouterClient.get('HousingAPI/SetDoorLocked'):InvokeServer(true)
            Utils.PlaceFLoorUnderPlayer()
            RouterClient.get('TeamAPI/ChooseTeam'):InvokeServer('Babies', {
                ['dont_send_back_home'] = true,
            })
            Utils.PrintDebug('turned to baby')

            if not localPlayer.Character then
                Utils.PrintDebug('NO CHARACTER SO WAITING')
                localPlayer.CharacterAdded:Wait()
            end

            local success, err = pcall(function()
                return RouterClient.get('TeamAPI/Spawn'):InvokeServer()
            end)

            if not success then
                Utils.PrintDebug(string.format('Error spawning to house: %s', tostring(err)))
            end

            task.wait(5)

            if not localPlayer.Character then
                Utils.PrintDebug('NO CHARACTER SO WAITING')
                localPlayer.CharacterAdded:Wait()
            end

            local furnitureKeys = Furniture.GetFurnituresKey()

            loopFurniture(furnitureKeys)
            Utils.PrintDebug(string.format('Bed: %s \u{1f6cf}\u{fe0f}', tostring(furnitureKeys.basiccrib)))
            Utils.PrintDebug(string.format('Shower: %s \u{1f6c1}', tostring(furnitureKeys.stylishshower)))
            Utils.PrintDebug(string.format('Piano: %s \u{1f3b9}', tostring(furnitureKeys.piano)))
            Utils.PrintDebug(string.format('Normal Lure: %s \u{1f4e6}', tostring(furnitureKeys.lures_2023_normal_lure)))
            Utils.PrintDebug(string.format('LitterBox: %s \u{1f6bd}', tostring(furnitureKeys.ailments_refresh_2024_litter_box)))

            if furnitureKeys.basiccrib == 'nil' then
                localPlayer:Kick("No bed found, can't farm without a bed")

                return
            end

            local baitUnique = Utils.FindBait()

            Utils.PrintDebug(string.format('baitUnique: %s \u{1f36a}', tostring(baitUnique)))
            Utils.PlaceBaitOrPickUp(furnitureKeys.lures_2023_normal_lure, baitUnique)
            task.wait(1)
            Utils.PlaceBaitOrPickUp(furnitureKeys.lures_2023_normal_lure, baitUnique)
            task.wait(1)
            Utils.UnEquipAllPets()
            Teleport.PlaceFloorAtFarmingHome()
            Teleport.PlaceFloorAtCampSite()
            Teleport.PlaceFloorAtBeachParty()

            for _, v in getconnections((localPlayer.Idled))do
                v:Disable()
            end

            localPlayer.Idled:Connect(function()
                VirtualUser:ClickButton2(Vector2.new())
            end)

            --local UpdateTextEvent = (ReplicatedStorage:WaitForChild('UpdateTextEvent'))

            --UpdateTextEvent:Fire()

            if getgenv().BUY_BEFORE_FARMING then
                localPlayer:SetAttribute('StopFarmingTemp', true)
                BuyItem.StartBuyItems(getgenv().BUY_BEFORE_FARMING)
            end
            if getgenv().OPEN_ITEMS_BEFORE_FARMING then
                localPlayer:SetAttribute('StopFarmingTemp', true)
                BuyItem.OpenItems(getgenv().OPEN_ITEMS_BEFORE_FARMING)
            end
            if getgenv().AGE_PETS_BEFORE_FARMING then
                localPlayer:SetAttribute('StopFarmingTemp', true)
                BulkPotion.StartAgingPets(getgenv().AGE_PETS_BEFORE_FARMING)
                Utils.PrintDebug('DONE aging pets')
            end
            if getgenv().SETTINGS.PET_AUTO_FUSION then
                Fusion.MakeMega(false)
                Fusion.MakeMega(true)
            end
            if getgenv().SETTINGS.ENABLE_TRASH_COLLECTOR and isPlayersInGame(getgenv().SETTINGS.TRASH_COLLECTOR_NAMES) then
                getgenv().SETTINGS.ENABLE_TRADE_COLLECTOR = false

                Utils.PrintDebug('Trading TRASH collector')
                Trade.TradeTrashCollector(getgenv().SETTINGS.TRASH_COLLECTOR_NAMES)
            elseif getgenv().SETTINGS.ENABLE_TRADE_COLLECTOR and isPlayersInGame(getgenv().SETTINGS.TRADE_COLLECTOR_NAME) then
                Utils.PrintDebug('Trading MULE collector')
                Trade.TradeCollector(getgenv().SETTINGS.TRADE_COLLECTOR_NAME)
            end

            localPlayer:SetAttribute('StopFarmingTemp', false)
        end

        return self
    end
    function __DARKLUA_BUNDLE_MODULES.l()
        local ReplicatedStorage = cloneref(game:GetService('ReplicatedStorage'))
        local Players = cloneref(game:GetService('Players'))
        local Bypass = (require(ReplicatedStorage:WaitForChild('Fsys')).load)
        local ClientData = Bypass('ClientData')
        local RouterClient = Bypass('RouterClient')
        local Utils = __DARKLUA_BUNDLE_MODULES.load('a')
        local self = {}
        local localPlayer = Players.LocalPlayer
        local PlayerGui = localPlayer:WaitForChild('PlayerGui')
        local DailyLoginApp = PlayerGui:WaitForChild('DailyLoginApp')
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
        local grabDailyReward = function()
            Utils.PrintDebug('getting daily rewards')

            local Daily = ClientData.get('daily_login_manager')

            if Daily.prestige % 2 == 0 then
                for i, v in pairs(DailyRewardTable)do
                    if i < Daily.stars or i == Daily.stars then
                        if not Daily.claimed_star_rewards[v] then
                            Utils.PrintDebug('grabbing dialy reward!')
                            RouterClient.get('DailyLoginAPI/ClaimStarReward'):InvokeServer(v)
                        end
                    end
                end
            else
                for i, v in pairs(DailyRewardTable2)do
                    if i < Daily.stars or i == Daily.stars then
                        if not Daily.claimed_star_rewards[v] then
                            Utils.PrintDebug('grabbing dialy reward!')
                            RouterClient.get('DailyLoginAPI/ClaimStarReward'):InvokeServer(v)
                        end
                    end
                end
            end
        end
        local dailyLoginAppClick = function()
            Utils.PrintDebug('Clicking on Daily login app')

            local frame = (DailyLoginApp and {
                (DailyLoginApp:FindFirstChild('Frame')),
            } or {nil})[1]
            local body = (frame and {
                (frame:FindFirstChild('Body')),
            } or {nil})[1]
            local buttons = (body and {
                (body:FindFirstChild('Buttons')),
            } or {nil})[1]

            if not buttons then
                return
            end

            for _, v in buttons:GetDescendants()do
                if v:IsA('TextLabel') then
                    if v.Text == 'CLOSE' and v.Parent and v.Parent.Parent then
                        local button = (v.Parent.Parent)

                        Utils.PrintDebug('pressed Close on daily login')
                        Utils.FireButton(button)
                        task.wait(1)
                        grabDailyReward()
                    elseif v.Text == 'CLAIM!' and v.Parent and v.Parent.Parent then
                        local button = (v.Parent.Parent)

                        Utils.PrintDebug('pressed claim on daily login')
                        Utils.FireButton(button)
                        task.wait(1)
                        Utils.FireButton(button)
                        grabDailyReward()
                    end
                end
            end
        end

        function self.Init()
            self.DailyClaimConnection = DailyLoginApp:GetPropertyChangedSignal('Enabled'):Connect(function(
            )
                dailyLoginAppClick()

                if self.DailyClaimConnection then
                    self.DailyClaimConnection:Disconnect()
                end
            end)
        end
        function self.Start()
            dailyLoginAppClick()
        end

        return self
    end
        function __DARKLUA_BUNDLE_MODULES.m()
        local Players = cloneref(game:GetService('Players'))
        local Utils = __DARKLUA_BUNDLE_MODULES.load('a')
        local Trade = __DARKLUA_BUNDLE_MODULES.load('e')
        local Teleport = __DARKLUA_BUNDLE_MODULES.load('f')
        local self = {}
        local localPlayer = Players.LocalPlayer
        local PlayerGui = localPlayer:WaitForChild('PlayerGui')
        local DialogApp = (PlayerGui:WaitForChild('DialogApp'))
        local MinigameRewardsApp = (PlayerGui:WaitForChild('MinigameRewardsApp'))
        local MinigameInGameApp = (PlayerGui:WaitForChild('MinigameInGameApp'))
        local TradeApp = (PlayerGui:WaitForChild('TradeApp'))
        local PlaytimePayoutsApp = (PlayerGui:WaitForChild('PlaytimePayoutsApp'))
        local certificateConn
        local starterPackAppConn
        local getNormalDialogTextLabel = function()
            local Dialog = (DialogApp and {
                (DialogApp:FindFirstChild('Dialog')),
            } or {nil})[1]
            local NormalDialog = (Dialog and {
                (Dialog:FindFirstChild('NormalDialog')),
            } or {nil})[1]
            local Info = (NormalDialog and {
                (NormalDialog:FindFirstChild('Info')),
            } or {nil})[1]

            if not Info then
                return nil
            end

            local TextLabel = (Info:FindFirstChild('TextLabel'))

            if not TextLabel then
                return nil
            end

            return TextLabel
        end
        local onTextChangedNormalDialog = function()
            local TextLabel = getNormalDialogTextLabel()

            if not TextLabel then
                return
            end

            Utils.PrintDebug(string.format('onTextChangedNormalDialog: %s', tostring(TextLabel.Text)))

            if TextLabel.Text:match('Be careful when trading') then
                Utils.FindButton('Okay')
            elseif TextLabel.Text:match('This trade seems unbalanced') then
                Utils.FindButton('Next')
            elseif TextLabel.Text:match('Social Stones!') then
                Utils.FindButton('Okay')
            elseif TextLabel.Text:match('sent you a trade request') then
                Utils.FindButton('Accept')
            elseif TextLabel.Text:match('Trade request from') then
                Utils.FindButton('Okay')
            elseif TextLabel.Text:match('Any items lost') then
                Utils.FindButton('I understand')
            elseif TextLabel.Text:match('4.5%% Legendary') then
                Utils.FindButton('Okay')
            elseif TextLabel.Text:match('You have been awarded') then
                Utils.FindButton('Awesome!')
            elseif TextLabel.Text:match('Thanks for subscribing!') then
                Utils.FindButton('Okay')
            elseif TextLabel.Text:match("Let's start the day") then
                Utils.FindButton('Start')
            elseif TextLabel.Text:match('Are you subscribed') then
                Utils.FindButton('Yes')
            elseif TextLabel.Text:match('your inventory!') then
                Utils.FindButton('Awesome!')
            elseif TextLabel.Text:match("You've chosen this") then
                Utils.FindButton('Yes')
            elseif TextLabel.Text:match('You can change this option') then
                Utils.FindButton('Okay')
            elseif TextLabel.Text:match('You have enough') then
                Utils.FindButton('Okay')
            elseif TextLabel.Text:match('Thanks for') then
                Utils.FindButton('Okay')
            elseif TextLabel.Text:match('Right now') then
                Utils.FindButton('Next')
            elseif TextLabel.Text:match('You can customize it') then
                Utils.FindButton('Start')
            elseif TextLabel.Text:match('Your subscription') then
                Utils.FindButton('Okay!')
            elseif TextLabel.Text:match('You have been refunded') then
                Utils.FindButton('Awesome!')
            elseif TextLabel.Text:match("You can't afford this") then
                Utils.FindButton('Okay')
            elseif TextLabel.Text:match('mailbox') then
                Utils.FindButton('Okay')
            elseif TextLabel.Text:match('Pay 1500 Bucks') then
                Utils.FindButton('Yes')
            elseif TextLabel.Text:match('Pet Pen!') then
                Utils.FindButton('Go to Pet Pen')
            elseif TextLabel.Text:match('The Homepass has been restarted') then
                Utils.FindButton('Okay')
            end
        end
        local removeGameOverButton = function(screenGuiName)
            task.wait(0.1)

            local guiFrame = localPlayer:WaitForChild('PlayerGui'):FindFirstChild(screenGuiName)

            if not guiFrame then
                return
            end

            local body = guiFrame:FindFirstChild('Body')
            local button = (body and {
                (body:WaitForChild('Button', 10)),
            } or {nil})[1]
            local face = (button and {
                (button:WaitForChild('Face', 10)),
            } or {nil})[1]

            if not (button and face) then
                return
            end

            for _, v in pairs(button:GetDescendants())do
                if v:IsA('TextLabel') and v.Text == 'NICE!' and v.Parent then
                    local guiButton = (v.Parent.Parent)

                    Utils.FireButton(guiButton)

                    return
                end
            end
        end
        local onTextChangedMiniGame = function()
            local hasStartedFarming = localPlayer:GetAttribute('hasStartedFarming')

            if getgenv().SETTINGS.EVENT and getgenv().SETTINGS.EVENT.DO_MINIGAME or getgenv().AutoMinigame and hasStartedFarming then
            task.wait(2)
                Utils.FindButton('No')
            else
                Utils.FindButton('No')
            end
        end
        local friendTradeAccept = function()
            local dialogFrame = (DialogApp:WaitForChild('Dialog'))

            if not dialogFrame.Visible then
                return
            end

            local HeaderDialog = (dialogFrame:WaitForChild('HeaderDialog', 10))

            if not HeaderDialog then
                return
            end

            HeaderDialog:GetPropertyChangedSignal('Visible'):Connect(function()
                if not HeaderDialog.Visible then
                    return
                end

                local Info = HeaderDialog:WaitForChild('Info', 10)

                if not Info then
                    return
                end

                local TextLabel = (Info:WaitForChild('TextLabel', 10))

                if not TextLabel then
                    return
                end

                TextLabel:GetPropertyChangedSignal('Text'):Connect(function()
                    if not TextLabel.Visible then
                        return
                    end
                    if TextLabel.Text:match('sent you a trade request') then
                        Utils.FindButton('Accept', 'HeaderDialog')
                    end
                end)
            end)
        end

        local tryClickPlaytimePayout = function()

            if not PlaytimePayoutsApp.Enabled then
                return
            end

            PlaytimePayoutsApp:WaitForChild('Frame')
            PlaytimePayoutsApp.Frame:WaitForChild('Container')
            PlaytimePayoutsApp.Frame.Container:WaitForChild('CashOutContainer')
            PlaytimePayoutsApp.Frame.Container.CashOutContainer:WaitForChild('CashOutButton')

            local button = (PlaytimePayoutsApp.Frame.Container.CashOutContainer.CashOutButton:WaitForChild('DepthButton'))

            Utils.FireButton(button)

            task.wait(5)

            if PlaytimePayoutsApp.Enabled then
            Players.LocalPlayer.PlayerGui.PlaytimePayoutsApp.Enabled = false --- Closing the shitty check
            end
        end

        function self.Init()
            local Dialog = (DialogApp:WaitForChild('Dialog'))

            Dialog:GetPropertyChangedSignal('Visible'):Connect(friendTradeAccept)
            Dialog:WaitForChild('FriendAfterTradeDialog'):GetPropertyChangedSignal('Visible'):Connect(function(
            )
                if not Dialog.FriendAfterTradeDialog.Visible then
                    return
                end

                local exitButton = (Dialog:WaitForChild('ExitButton', 60))

                task.wait(1)

                if not exitButton or not exitButton.Visible then
                    return
                end

                Utils.FireButton(exitButton)
            end)

            local normalDialog = (Dialog:WaitForChild('NormalDialog'))

            normalDialog:GetPropertyChangedSignal('Visible'):Connect(function()
                if normalDialog.Visible then
                    normalDialog:WaitForChild('Info')
                    normalDialog.Info:WaitForChild('TextLabel')
                    normalDialog.Info.TextLabel:GetPropertyChangedSignal('Text'):Connect(onTextChangedNormalDialog)
                end
            end)
            Dialog.ChildAdded:Connect(function(Child)
                if Child.Name ~= 'NormalDialog' then
                    return
                end

                Child:GetPropertyChangedSignal('Visible'):Connect(function()
                    local myChild = Child

                    if not myChild.Visible then
                        return
                    end

                    myChild:WaitForChild('Info')
                    myChild.Info:WaitForChild('TextLabel')
                    myChild.Info.TextLabel:GetPropertyChangedSignal('Text'):Connect(onTextChangedNormalDialog)
                end)
            end)

            local CertificateApp = (PlayerGui:WaitForChild('CertificateApp'))

            certificateConn = CertificateApp:GetPropertyChangedSignal('Enabled'):Connect(function(
            )
                if not CertificateApp.Enabled then
                    return
                end
                if not CertificateApp:WaitForChild('Content', 10) then
                    return
                end
                if not CertificateApp.Content:WaitForChild('ExitButton', 10) then
                    return
                end

                Utils.FireButton(CertificateApp.Content.ExitButton)

                if certificateConn then
                    certificateConn:Disconnect()
                end
            end)

            local FTUEStarterPackApp = (PlayerGui:WaitForChild('FTUEStarterPackApp'))

            starterPackAppConn = FTUEStarterPackApp.Popups.Default:GetPropertyChangedSignal('Visible'):Connect(function(
            )
                if not FTUEStarterPackApp.Popups.Default.Visible then
                    return
                end
                if not FTUEStarterPackApp.Popups.Default:WaitForChild('ExitButton', 10) then
                    return
                end

                Utils.FireButton(FTUEStarterPackApp.Popups.Default.ExitButton)

                if starterPackAppConn then
                    starterPackAppConn:Disconnect()
                end
            end)

            DialogApp.Dialog.NormalDialog:GetPropertyChangedSignal('Visible'):Connect(function(
            )
                if not DialogApp.Dialog.NormalDialog.Visible then
                    return
                end

                DialogApp.Dialog.NormalDialog:WaitForChild('Info')
                DialogApp.Dialog.NormalDialog.Info:WaitForChild('TextLabel')
                DialogApp.Dialog.NormalDialog.Info.TextLabel:GetPropertyChangedSignal('Text'):Connect(function(
                )
                    if DialogApp.Dialog.NormalDialog.Info.TextLabel.Text:match('Treasure Defense is starting') then
                        onTextChangedMiniGame()
                    elseif DialogApp.Dialog.NormalDialog.Info.TextLabel.Text:match('Cannon Circle is starting') then
                        onTextChangedMiniGame()
                    --elseif DialogApp.Dialog.NormalDialog.Info.TextLabel.Text:match('invitation') then
                    --    localPlayer:Kick()
                    --    game:Shutdown()
                    elseif DialogApp.Dialog.NormalDialog.Info.TextLabel.Text:match('You found a') then
                        Utils.FindButton('Okay')
                    end
                end)
            end)
            DialogApp.Dialog.ChildAdded:Connect(function(child)
                if child.Name ~= 'NormalDialog' then
                    return
                end

                local NormalDialogChild = child

                NormalDialogChild:GetPropertyChangedSignal('Visible'):Connect(function(
                )
                    if not NormalDialogChild.Visible then
                        return
                    end

                    NormalDialogChild:WaitForChild('Info')
                    NormalDialogChild.Info:WaitForChild('TextLabel')
                    NormalDialogChild.Info.TextLabel:GetPropertyChangedSignal('Text'):Connect(function(
                    )
                        if NormalDialogChild.Info.TextLabel.Text:match('Treasure Defense is starting') then
                            onTextChangedMiniGame()
                        elseif NormalDialogChild.Info.TextLabel.Text:match('Cannon Circle is starting') then
                            onTextChangedMiniGame()
                        -- elseif NormalDialogChild.Info.TextLabel.Text:match('invitation') then
                          --  localPlayer:Kick()
                           -- game:Shutdown()
                        elseif NormalDialogChild.Info.TextLabel.Text:match('You found a') then
                            Utils.FindButton('Okay')
                        end
                    end)
                end)
            end)
            MinigameInGameApp:GetPropertyChangedSignal('Enabled'):Connect(function(
            )
                if MinigameInGameApp.Enabled then
                    MinigameInGameApp:WaitForChild('Body')
                    MinigameInGameApp.Body:WaitForChild('Middle')
                    MinigameInGameApp.Body.Middle:WaitForChild('Container')
                    MinigameInGameApp.Body.Middle.Container:WaitForChild('TitleLabel')

                    if MinigameInGameApp.Body.Middle.Container.TitleLabel.Text:match('TREASURE DEFENSE') then
                        if getgenv().SETTINGS.EVENT and getgenv().SETTINGS.EVENT.DO_MINIGAME or getgenv().AutoMinigame then
                            localPlayer:SetAttribute('StopFarmingTemp', true)
                            task.wait(2)

                        end
                    elseif MinigameInGameApp.Body.Middle.Container.TitleLabel.Text:match('CANNON CIRCLE') then
                        if getgenv().SETTINGS.EVENT and getgenv().SETTINGS.EVENT.DO_MINIGAME or getgenv().AutoMinigame then
                            localPlayer:SetAttribute('StopFarmingTemp', true)
                            task.wait(2)

                        end
                    end
                end
            end)
            MinigameRewardsApp.Body:GetPropertyChangedSignal('Visible'):Connect(function(
            )
                if MinigameRewardsApp.Body.Visible then
                    MinigameRewardsApp.Body:WaitForChild('Button')
                    MinigameRewardsApp.Body.Button:WaitForChild('Face')
                    MinigameRewardsApp.Body.Button.Face:WaitForChild('TextLabel')
                    MinigameRewardsApp.Body:WaitForChild('Reward')
                    MinigameRewardsApp.Body.Reward:WaitForChild('TitleLabel')

                    if MinigameRewardsApp.Body.Button.Face.TextLabel.Text:match('NICE!') then
                        local character = (localPlayer.Character)
                        local humanoidRootPart = (character:WaitForChild('HumanoidRootPart'))

                        humanoidRootPart.Anchored = false

                        task.wait(4)
                        removeGameOverButton('MinigameRewardsApp')
                        task.wait(2)
                        Teleport.FarmingHome()
                        localPlayer:SetAttribute('StopFarmingTemp', false)
                    end
                end
            end)
            PlaytimePayoutsApp:GetPropertyChangedSignal('Enabled'):Connect(function(
            )
            tryClickPlaytimePayout()
            end)
        end
        function self.Start()
            --tryClickPlaytimePayout()
            TradeApp.Frame.NegotiationFrame.Body.PartnerOffer.Accepted:GetPropertyChangedSignal('ImageTransparency'):Connect(function(
            )
                Trade.AutoAcceptTrade()
            end)
            TradeApp.Frame.ConfirmationFrame.PartnerOffer.Accepted:GetPropertyChangedSignal('ImageTransparency'):Connect(function(
            )
                Trade.AutoAcceptTrade()
            end)
        end

        return self
    end
    function __DARKLUA_BUNDLE_MODULES.n()
        local Workspace = (cloneref(game:GetService('Workspace')))
        local Terrain = (Workspace:WaitForChild('Terrain'))
        local Lighting = (cloneref(game:GetService('Lighting')))
        local self = {}
        local TURN_ON = false

        local lowSpecTerrain = function()
            Terrain.WaterReflectance = 0
            Terrain.WaterTransparency = 1
            Terrain.WaterWaveSize = 0
            Terrain.WaterWaveSpeed = 0
        end
        local lowSpecLighting = function()
            Lighting.Brightness = 0
            Lighting.GlobalShadows = false
            Lighting.FogEnd = math.huge
            Lighting.FogStart = 0
        end
        local lowSpecTextures = function(v)
            if v:IsA('Part') then
                v.Material = Enum.Material.Plastic
                v.EnableFluidForces = false
                v.CastShadow = false
                v.Reflectance = 0
                v.Transparency = 1
            elseif v:IsA('BasePart') and not v:IsA('MeshPart') then
                v.Material = Enum.Material.Plastic
                v.Reflectance = 0
                v.Transparency = 1
            elseif v:IsA('Decal') or v:IsA('Texture') then
                v.Transparency = 1
            elseif v:IsA('Explosion') then
                v.BlastPressure = 1
                v.BlastRadius = 1
            elseif v:IsA('Fire') or v:IsA('SpotLight') or v:IsA('Smoke') or v:IsA('Sparkles') then
                v.Enabled = false
            elseif v:IsA('MeshPart') then
                v.Material = Enum.Material.Plastic
                v.EnableFluidForces = false
                v.CastShadow = false
                v.Reflectance = 0
                v.TextureID = '10385902758728957'
                v.Transparency = 1
            elseif v:IsA('SpecialMesh') then
                v.TextureId = 0
            elseif v:IsA('ShirtGraphic') then
                v.Graphic = 1
            end
        end

        function self.Init() end
        function self.Start()
            if not TURN_ON then
                return
            end

            lowSpecTerrain()
            --lowSpecLighting()
            --Lighting:ClearAllChildren()
            Terrain:Clear()

            --[[for _, v in pairs(Workspace:GetDescendants())do
                lowSpecTextures(v)
            end

            Workspace.DescendantAdded:Connect(function(v)
                lowSpecTextures(v)
            end)--]]
        end

        return self
    end
    function __DARKLUA_BUNDLE_MODULES.o()
        local ReplicatedStorage = cloneref(game:GetService('ReplicatedStorage'))
        local Players = cloneref(game:GetService('Players'))
        local Bypass = (require(ReplicatedStorage:WaitForChild('Fsys')).load)
        local ClientData = Bypass('ClientData')
        local RouterClient = Bypass('RouterClient')
        local self = {}
        local localPlayer = Players.LocalPlayer
        local getTradeLicense = function()
            for _, v in ClientData.get_data()[localPlayer.Name].inventory.toys do
                if v.id == 'trade_license' then
                    return
                end
            end

            pcall(function()
                RouterClient.get('SettingsAPI/SetBooleanFlag'):FireServer('has_talked_to_trade_quest_npc', true)
                task.wait(1)
                RouterClient.get('TradeAPI/BeginQuiz'):FireServer()
                task.wait(1)

                for _, v in pairs(ClientData.get('trade_license_quiz_manager')['quiz'])do
                    RouterClient.get('TradeAPI/AnswerQuizQuestion'):FireServer(v['answer'])
                end
            end)
        end

        function self.Init() end
        function self.Start()
            getTradeLicense()
        end

        return self
    end
    function __DARKLUA_BUNDLE_MODULES.p()
        local ReplicatedStorage = cloneref(game:GetService('ReplicatedStorage'))
        local Players = cloneref(game:GetService('Players'))
        local Bypass = (require(ReplicatedStorage:WaitForChild('Fsys')).load)
        local ClientData = Bypass('ClientData')
        local RouterClient = Bypass('RouterClient')
        local Utils = __DARKLUA_BUNDLE_MODULES.load('a')
        local LegacyTutorial = (require(ReplicatedStorage:WaitForChild('ClientModules'):WaitForChild('Game'):WaitForChild('Tutorial'):WaitForChild('LegacyTutorial')))
        local self = {}
        local localPlayer = Players.LocalPlayer
        local completeNewStarterTutorial = function()
            local success, errorMessage = pcall(function()
                task.wait(10)
                RouterClient.get('TutorialAPI/ReportDiscreteStep'):FireServer('npc_interaction')
                task.wait(2)
                RouterClient.get('TutorialAPI/ChoosePet'):FireServer('dog')
                task.wait(2)
                RouterClient.get('TutorialAPI/ReportDiscreteStep'):FireServer('cured_dirty_ailment')
                task.wait(2)
                RouterClient.get('TutorialAPI/ReportTutorialCompleted'):FireServer()
                task.wait(2)
                LegacyTutorial.cancel_tutorial()
                task.wait(2)
                RouterClient.get('LegacyTutorialAPI/MarkTutorialCompleted'):FireServer()
            end)

            Utils.PrintDebug('CompleteNewStarterTutorial:', success, errorMessage)
        end
        local doStarterTutorial = function()
            Utils.FindButton('Next')
            task.wait(2)
            Utils.PrintDebug('doing tutorial')
            completeNewStarterTutorial()
            task.wait(1)
            Utils.PrintDebug('doing trade license')
            task.wait(1)
            Utils.FindButton('Next')
        end

        function self.Init() end
        function self.Start()
            local tutorial3Completed = ClientData.get_data()[localPlayer.Name].boolean_flags.tutorial_v3_completed
            local tutorialManagerComleted = ClientData.get_data()[localPlayer.Name].tutorial_manager.completed

            if not tutorial3Completed and not tutorialManagerComleted then
                Utils.PrintDebug('New alt detected. doing tutorial')
                doStarterTutorial()
            end
        end

        return self
    end
    function __DARKLUA_BUNDLE_MODULES.q()
        local ReplicatedStorage = cloneref(game:GetService('ReplicatedStorage'))
        local Players = cloneref(game:GetService('Players'))
        local HttpService = cloneref(game:GetService('HttpService'))
        local Bypass = (require(ReplicatedStorage:WaitForChild('Fsys')).load)
        local AllowOrDenyList = __DARKLUA_BUNDLE_MODULES.load('c')
        local Utils = __DARKLUA_BUNDLE_MODULES.load('a')
        local self = {}
        local localPlayer = Players.LocalPlayer
        local getThumbnailImage = function(rbxassetidLink)
            local assetid = rbxassetidLink:match('rbxassetid://(%d+)')

            if not assetid then
                return nil
            end

            local url = string.format(
[[https://thumbnails.roblox.com/v1/assets?assetIds=%s&size=420x420&format=png&isCircular=false]], tostring(assetid))
            local request = request or syn.request
            local headers = {
                ['Content-Type'] = 'application/json',
            }
            local requestOptions = {
                Url = url,
                Method = 'GET',
                Headers = headers,
            }
            local success, result = pcall(function()
                return request(requestOptions).Body
            end)

            if success then
                local data = HttpService:JSONDecode(result)

                if data and data.data and data.data[1] and data.data[1].imageUrl then
                    return data.data[1].imageUrl
                end
            end

            return nil
        end
        local getItemFromDatabase = function(nameId)
            return Bypass('InventoryDB').pets[nameId] or nil
        end
        local getPetNeonOrMega = function(itemData)
            local info = {}

            if itemData.properties.neon then
                info = {
                    ['Name'] = 'Neon',
                    ['Value'] = 'Yes',
                }
            elseif itemData.properties.mega_neon then
                info = {
                    ['Name'] = 'Mega',
                    ['Value'] = 'Yes',
                }
            else
                info = {
                    ['Name'] = 'Normal',
                    ['Value'] = 'Yes',
                }
            end

            return info
        end
        local filterData = function(data)
            local itemDatabase = getItemFromDatabase(data['id'])

            if not itemDatabase then
                return false
            end
            if not itemDatabase.image then
                return false
            end

            self.SendWebHook(data, itemDatabase)

            return true
        end
        local startWebHook = function()
            Utils.PrintDebug('Webhook Started')

            local DataPartiallyChanged = Bypass('RouterClient').get_event('DataAPI/DataPartiallyChanged')

            self.Connection = DataPartiallyChanged.OnClientEvent:Connect(function(
                _,
                _,
                dataInfo,
                _
            )
                if typeof(dataInfo) ~= 'table' then
                    return
                end
                if not dataInfo.category or dataInfo.category ~= 'pets' then
                    return
                end
                if dataInfo.newness_order and dataInfo.newness_order <= 0 then
                    return
                end
                if table.find(AllowOrDenyList.Denylist, dataInfo.id) then
                    return
                end
                if not dataInfo.properties then
                    return
                end
                if dataInfo.properties.neon or dataInfo.properties.mega_neon or table.find(AllowOrDenyList.Allowlist, dataInfo.id) then
                    if dataInfo.properties.neon and dataInfo.properties.age ~= 6 then
                        return
                    end
                    if self.UniqueString == dataInfo.unique then
                        return
                    end

                    self.UniqueString = dataInfo.unique

                    filterData(dataInfo)
                end
            end)
        end

        function self.Init()
            self.Connection = nil
            self.Cooldown = false
            self.UniqueString = ''
        end
        function self.Start()
            if getgenv().WEBHOOK and getgenv().WEBHOOK.URL and #getgenv().WEBHOOK.URL >= 10 then
                startWebHook()
            end
        end
        function self.SendWebHook(itemData, itemDataDB)
            local imageUrl = getThumbnailImage(itemDataDB['image'])
            local petStats = getPetNeonOrMega(itemData)
            local embed = {
                title = 'NEW PET DETECTED!',
                description = string.format('[%s] %s got it', tostring(getgenv().WEBHOOK.VPS_NAME or 'None'), tostring(localPlayer.Name)),
                color = 0xccff,
                fields = {
                    {
                        name = 'Pet Name',
                        value = itemDataDB.name,
                        inline = true,
                    },
                    {
                        name = 'Rarity',
                        value = itemDataDB.rarity,
                        inline = true,
                    },
                    {
                        name = 'Age',
                        value = itemData.properties.age,
                        inline = true,
                    },
                    {
                        name = tostring(petStats.Name),
                        value = petStats.Value,
                        inline = true,
                    },
                },
                footer = {
                    text = string.format('\nShittyHub - %s', tostring(DateTime.now():FormatLocalTime('LLL', 'en-us'))),
                },
            }

            if imageUrl then
                embed.thumbnail = {url = imageUrl}
            end

            local dataFrame = {
                username = 'Pet Notifier',
                avatar_url = string.format(
[[https://www.roblox.com/headshot-thumbnail/image?userId=%s&width=420&height=420&format=png]], tostring(localPlayer.UserId)),
                embeds = {embed},
            }
            local request = request or syn.request
            local headers = {
                ['Content-Type'] = 'application/json',
            }
            local jsonData = HttpService:JSONEncode(dataFrame)
            local requestData = {
                Url = getgenv().WEBHOOK.URL,
                Method = 'POST',
                Headers = headers,
                Body = jsonData,
            }
            local success, result = pcall(function()
                return request(requestData)
            end)

            if success then
                Utils.PrintDebug(string.format('Request Succesful: %s', tostring(result)))
            else
                Utils.PrintDebug(string.format('Request Failed: %s', tostring(result)))
            end

            return nil
        end
        function self.Cleanup()
            if self.Connection then
                self.Connection:Disconnect()
            end
        end

        return self
    end
    function __DARKLUA_BUNDLE_MODULES.r()
        local ReplicatedStorage = cloneref(game:GetService('ReplicatedStorage'))
        local Workspace = cloneref(game:GetService('Workspace'))
        local Players = cloneref(game:GetService('Players'))
        local Ailment = {}
        local Bypass = (require(ReplicatedStorage:WaitForChild('Fsys')).load)
        local ClientData = (Bypass('ClientData'))
        local Utils = __DARKLUA_BUNDLE_MODULES.load('a')
        local GetInventory = __DARKLUA_BUNDLE_MODULES.load('i')
        local Teleport = __DARKLUA_BUNDLE_MODULES.load('f')
        local localPlayer = Players.LocalPlayer
        local doctorId = nil

        Ailment.whichPet = 1

        local consumeFood = function()
            local foodItem = Workspace.PetObjects:WaitForChild(tostring(Workspace.PetObjects:FindFirstChildWhichIsA('Model')), 10)

            if not foodItem then
                Utils.PrintDebug('NO food item in workspace')

                return
            end
            if not Utils.IsPetEquipped(Ailment.whichPet) then
                return
            end

            ReplicatedStorage.API['PetAPI/ConsumeFoodObject']:FireServer(foodItem, ClientData.get('pet_char_wrappers')[Ailment.whichPet].pet_unique)
        end

        local function FoodAilments(FoodPassOn)
            local hasFood = false

            for _, v in ClientData.get_data()[localPlayer.Name].inventory.food do
                if v.id == FoodPassOn then
                    hasFood = true

                    if not Utils.IsPetEquipped(Ailment.whichPet) then
                        Utils.PrintDebug('\u{26a0}\u{fe0f} Trying to feed pet but no pet equipped \u{26a0}\u{fe0f}')

                        return
                    end

                    local args = {
                        [1] = '__Enum_PetObjectCreatorType_2',
                        [2] = {
                            ['pet_unique'] = ClientData.get('pet_char_wrappers')[Ailment.whichPet].pet_unique,
                            ['unique_id'] = v.unique,
                        },
                    }

                    ReplicatedStorage.API['PetObjectAPI/CreatePetObject']:InvokeServer(unpack(args))
                    consumeFood()

                    return
                end
            end

            if not hasFood then
                ReplicatedStorage.API['ShopAPI/BuyItem']:InvokeServer('food', FoodPassOn, {})
                task.wait(2)
                FoodAilments(FoodPassOn)
            end
        end

        local getKeyFrom = function(itemId)
            for key, value in ClientData.get_data()[localPlayer.Name].house_interior.furniture do
                if value.id == itemId then
                    return key
                end
            end

            return nil
        end
        local useToolOnBaby = function(uniqueId)
            ReplicatedStorage.API['ToolAPI/ServerUseTool']:FireServer(uniqueId, 'END')
        end
        local PianoAilment = function(pianoId, petCharOrPlayerChar)
            local args = {
                localPlayer,
                pianoId,
                'Seat1',
                {
                    ['cframe'] = localPlayer.Character.HumanoidRootPart.CFrame,
                },
                petCharOrPlayerChar,
            }

            task.spawn(function()
                ReplicatedStorage.API:FindFirstChild('HousingAPI/ActivateFurniture'):InvokeServer(unpack(args))
            end)
        end
        local furnitureAilments = function(nameId, petCharOrPlayerChar)
            task.spawn(function()
                ReplicatedStorage.API['HousingAPI/ActivateFurniture']:InvokeServer(localPlayer, nameId, 'UseBlock', {
                    ['cframe'] = localPlayer.Character.HumanoidRootPart.CFrame,
                }, petCharOrPlayerChar)
            end)
        end

        local isDoctorLoaded = function()
            local stuckCount = 0
            local isStuck = false
            local doctor = Workspace.HouseInteriors.furniture:FindFirstChild('Doctor', true)

            if not doctor then
                repeat
                    task.wait(5)

                    doctor = Workspace.HouseInteriors.furniture:FindFirstChild('Doctor', true)
                    stuckCount = stuckCount + 5
                    isStuck = stuckCount > 30 and true or false
                until doctor or isStuck
            end
            if isStuck then
                Utils.PrintDebug("\u{26a0}\u{fe0f} Wasn't able to find Doctor Id \u{26a0}\u{fe0f}")

                return false
            end

            return true
        end
        local getDoctorId = function()
            if doctorId then
                Utils.PrintDebug(string.format('Doctor Id: %s', tostring(doctorId)))

                return
            end

            Utils.PrintDebug('\u{1fa79} Getting Doctor ID \u{1fa79}')

            local stuckCount = 0
            local isStuck = false

            ReplicatedStorage.API['LocationAPI/SetLocation']:FireServer('Hospital')
            task.wait(5)

            local doctor = Workspace.HouseInteriors.furniture:FindFirstChild('Doctor', true)

            if not doctor then
                repeat
                    task.wait(5)

                    doctor = Workspace.HouseInteriors.furniture:FindFirstChild('Doctor', true)
                    stuckCount = stuckCount + 5
                    isStuck = stuckCount > 30 and true or false
                until doctor or isStuck
            end
            if isStuck then
                Utils.PrintDebug("\u{26a0}\u{fe0f} Wasn't able to find Doctor Id \u{26a0}\u{fe0f}")

                return
            end
            if doctor then
                doctorId = doctor:GetAttribute('furniture_unique')

                if doctorId then
                    Utils.PrintDebug(string.format('Found doctor Id: %s', tostring(doctorId)))
                end
            end
        end
        local useStroller = function()
            local strollerTool = localPlayer.Character:FindFirstChild('StrollerTool')

            if not strollerTool then
                return false
            end

            local args = {
                localPlayer,
                ClientData.get('pet_char_wrappers')[Ailment.whichPet].char,
                localPlayer.Character.StrollerTool.ModelHandle.TouchToSits.TouchToSit,
            }

            ReplicatedStorage.API:FindFirstChild('AdoptAPI/UseStroller'):InvokeServer(unpack(args))

            return true
        end
        local babyJump = function()
            if localPlayer.Character.Humanoid:GetState() == Enum.HumanoidStateType.Freefall then
                return
            end

            localPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
        end
        local getUpFromSitting = function()
            ReplicatedStorage.API['AdoptAPI/ExitSeatStates']:FireServer()
            task.wait()
            ReplicatedStorage.API['AdoptAPI/ExitSeatStates']:FireServer()
            task.wait(1)
            Utils.PrintDebug('Exited from seat')
        end

        local function babyGetFoodAndEat(FoodPassOn)
            local hasFood = false

            for _, v in ClientData.get_data()[localPlayer.Name].inventory.food do
                if v.id == FoodPassOn then
                    hasFood = true

                    ReplicatedStorage.API['ToolAPI/Equip']:InvokeServer(v.unique, {})
                    task.wait(1)
                    useToolOnBaby(v.unique)

                    return
                end
            end

            if not hasFood then
                ReplicatedStorage.API['ShopAPI/BuyItem']:InvokeServer('food', FoodPassOn, {})
                task.wait(1)
                babyGetFoodAndEat(FoodPassOn)
            end
        end

        local pickMysteryTask = function(mysteryId, petUnique)
            Utils.PrintDebug(string.format('mystery id: %s', tostring(mysteryId)))

            local ailmentsList = {}

            for i, _ in ClientData.get_data()[localPlayer.Name].ailments_manager.ailments[petUnique][mysteryId]['components']['mystery']['components']do
                table.insert(ailmentsList, i)
            end

            for i = 1, 3 do
                for _, ailment in ailmentsList do
                    Utils.PrintDebug(string.format('card: %s, ailment: %s', tostring(i), tostring(ailment)))
                    ReplicatedStorage.API['AilmentsAPI/ChooseMysteryAilment']:FireServer(petUnique, 'mystery', i, ailment)
                    task.wait(3)

                    if not ClientData.get_data()[localPlayer.Name].ailments_manager.ailments[petUnique][mysteryId] then
                        Utils.PrintDebug(string.format('\u{1f449} Picked %s ailment from mystery card \u{1f448}', tostring(ailment)))

                        return
                    end
                end
            end
        end
        local waitForTaskToFinish = function(ailment, petUnique)
            Utils.PrintDebug(string.format('\u{23f3} Waiting for %s to finish \u{23f3}', tostring(string.upper(ailment))))

            local count = 0

            repeat
                task.wait(5)

                local taskActive = ClientData.get_data()[localPlayer.Name].ailments_manager.ailments[petUnique] and ClientData.get_data()[localPlayer.Name].ailments_manager.ailments[petUnique][ailment] and true or false

                count = count + 5
            until not taskActive or count >= 60

            if count >= 60 then
                Utils.PrintDebug(string.format('\u{26a0}\u{fe0f} Waited too long for ailment: %s, must be stuck \u{26a0}\u{fe0f}', tostring(ailment)))
                Utils.ReEquipPet(1)
                Utils.ReEquipPet(2)
            else
                Utils.PrintDebug(string.format('\u{1f389} %s task finished \u{1f389}', tostring(ailment)))
            end
        end
        local waitForJumpingToFinish = function(ailment, petUnique)
            Utils.PrintDebug(string.format('\u{23f3} Waiting for %s to finish \u{23f3}', tostring(string.upper(ailment))))

            local stuckCount = tick()
            local isStuck = false

            repeat
                babyJump()
                task.wait(0.5)

                local taskActive = ClientData.get_data()[localPlayer.Name].ailments_manager.ailments[petUnique] and ClientData.get_data()[localPlayer.Name].ailments_manager.ailments[petUnique][ailment] and true or false

                task.wait(0.5)

                isStuck = (tick() - stuckCount) >= 120 and true or false
            until not taskActive or isStuck

            if isStuck then
                Utils.PrintDebug(string.format('\u{26d4} %s ailment is stuck so exiting task \u{26d4}', tostring(ailment)))
            else
                Utils.PrintDebug(string.format('\u{1f389} %s ailment finished \u{1f389}', tostring(ailment)))
            end
        end
        local babyWaitForTaskToFinish = function(ailment)
            Utils.PrintDebug(string.format('\u{23f3} Waiting for BABY %s to finish \u{23f3}', tostring(string.upper(ailment))))

            local count = 0

            repeat
                task.wait(5)

                local taskActive = ClientData.get_data()[localPlayer.Name].ailments_manager.baby_ailments and ClientData.get_data()[localPlayer.Name].ailments_manager.baby_ailments[ailment] and true or false

                count = count + 5
            until not taskActive or count >= 60

            if count >= 60 then
                Utils.PrintDebug(string.format('\u{26a0}\u{fe0f} Waited too long for ailment: %s, must be stuck \u{26a0}\u{fe0f}', tostring(ailment)))
            else
                Utils.PrintDebug(string.format('\u{1f389} %s task finished \u{1f389}', tostring(string.upper(ailment))))
            end
        end

        function Ailment.HungryAilment()
            Utils.PrintDebug(string.format('\u{1f356} Doing hungry task on %s \u{1f356}', tostring(Ailment.whichPet)))
            Utils.ReEquipPet(Ailment.whichPet)
            FoodAilments('icecream')
            Utils.PrintDebug(string.format('\u{1f356} Finished hungry task on %s \u{1f356}', tostring(Ailment.whichPet)))
        end
        function Ailment.ThirstyAilment()
            Utils.PrintDebug(string.format('\u{1f95b} Doing thirsty task on %s \u{1f95b}', tostring(Ailment.whichPet)))
            Utils.ReEquipPet(Ailment.whichPet)
            FoodAilments('water')
            Utils.PrintDebug(string.format('\u{1f95b} Finished thirsty task on %s \u{1f95b}', tostring(Ailment.whichPet)))
        end
        function Ailment.SickAilment()
            Utils.ReEquipPet(Ailment.whichPet)

            if doctorId then
                Utils.PrintDebug(string.format('\u{1fa79} Doing sick task on %s \u{1fa79}', tostring(Ailment.whichPet)))
                ReplicatedStorage.API['LocationAPI/SetLocation']:FireServer('Hospital')

                if not isDoctorLoaded() then
                    Utils.PrintDebug(string.format('\u{1fa79}\u{26a0}\u{fe0f} Doctor didnt load on %s \u{1fa79}\u{26a0}\u{fe0f}', tostring(Ailment.whichPet)))

                    return
                end

                local args = {
                    [1] = doctorId,
                    [2] = 'UseBlock',
                    [3] = 'Yes',
                    [4] = game:GetService('Players').LocalPlayer.Character,
                }

                ReplicatedStorage.API:FindFirstChild('HousingAPI/ActivateInteriorFurniture'):InvokeServer(unpack(args))
                Utils.PrintDebug(string.format('\u{1fa79} SICK task Finished on %s \u{1fa79}', tostring(Ailment.whichPet)))
            else
                getDoctorId()
            end
        end
        function Ailment.PetMeAilment()
            Utils.ReEquipPet(Ailment.whichPet)
            Utils.PrintDebug(string.format('\u{1f431} Doing pet me task on %s \u{1f431}', tostring(Ailment.whichPet)))

            if not Utils.IsPetEquipped(Ailment.whichPet) then
                return
            end

            ReplicatedStorage.API['AdoptAPI/FocusPet']:FireServer(ClientData.get('pet_char_wrappers')[Ailment.whichPet].char)
            task.wait(1)

            if not Utils.IsPetEquipped(Ailment.whichPet) then
                return
            end

            ReplicatedStorage.API['PetAPI/ReplicateActivePerformances']:FireServer(ClientData.get('pet_char_wrappers')[Ailment.whichPet].char, {
                ['FocusPet'] = true,
                ['Petting'] = true,
            })
            task.wait(1)

            if not Utils.IsPetEquipped(Ailment.whichPet) then
                return
            end

            Bypass('RouterClient').get('AilmentsAPI/ProgressPetMeAilment'):FireServer(ClientData.get('pet_char_wrappers')[Ailment.whichPet].pet_unique)
            Utils.PrintDebug('\u{1f431} RAN PETME AILMENT \u{1f431}')
        end
        function Ailment.SalonAilment(ailment, petUnique)
            Utils.ReEquipPet(Ailment.whichPet)
            Utils.PrintDebug(string.format('\u{1f457} Doing salon task on %s \u{1f457}', tostring(Ailment.whichPet)))
            ReplicatedStorage.API['LocationAPI/SetLocation']:FireServer('Salon')
            waitForTaskToFinish(ailment, petUnique)
            Utils.PrintDebug(string.format('\u{1f457} Finished salon task on %s \u{1f457}', tostring(Ailment.whichPet)))
        end
        function Ailment.MoonAilment(ailment, petUnique)
            Utils.ReEquipPet(Ailment.whichPet)
            Utils.PrintDebug(string.format('\u{1f31a} Doing moon task on %s \u{1f31a}', tostring(Ailment.whichPet)))
            ReplicatedStorage.API['LocationAPI/SetLocation']:FireServer('MoonInterior')
            waitForTaskToFinish(ailment, petUnique)
            Utils.PrintDebug(string.format('\u{1f31a} Doing moon task on %s \u{1f31a}', tostring(Ailment.whichPet)))
        end
        function Ailment.PizzaPartyAilment(ailment, petUnique)
            Utils.ReEquipPet(Ailment.whichPet)
            Utils.PrintDebug(string.format('\u{1f355} Doing pizza party task on %s \u{1f355}', tostring(Ailment.whichPet)))
            ReplicatedStorage.API['LocationAPI/SetLocation']:FireServer('PizzaShop')
            waitForTaskToFinish(ailment, petUnique)
            Utils.PrintDebug(string.format('\u{1f355} Finished pizza party task on %s \u{1f355}', tostring(Ailment.whichPet)))
        end
        function Ailment.SchoolAilment(ailment, petUnique)
            Utils.ReEquipPet(Ailment.whichPet)
            Utils.PrintDebug(string.format('\u{1f3eb} Doing school task on %s \u{1f3eb}', tostring(Ailment.whichPet)))
            ReplicatedStorage.API['LocationAPI/SetLocation']:FireServer('School')
            waitForTaskToFinish(ailment, petUnique)
            Utils.PrintDebug(string.format('\u{1f3eb} Finished school task on %s \u{1f3eb}', tostring(Ailment.whichPet)))
        end
        function Ailment.BoredAilment(pianoId, petUnique)
            Utils.ReEquipPet(Ailment.whichPet)
            Utils.PrintDebug(string.format('\u{1f971} Doing bored task on %s \u{1f971}', tostring(Ailment.whichPet)))

            if pianoId then
                if not Utils.IsPetEquipped(Ailment.whichPet) then
                    return
                end

                PianoAilment(pianoId, ClientData.get('pet_char_wrappers')[Ailment.whichPet]['char'])
            else
                Teleport.PlayGround(Vector3.new(20, 10, math.random(15, 30)))
            end

            waitForTaskToFinish('bored', petUnique)
            Utils.PrintDebug(string.format('\u{1f971} Finished bored task on %s \u{1f971}', tostring(Ailment.whichPet)))
        end
        function Ailment.SleepyAilment(bedId, petUnique)
            if not bedId then
                Utils.PrintDebug(string.format('NO bedId: %s', tostring(bedId)))

                return
            end

            Utils.ReEquipPet(Ailment.whichPet)
            Utils.PrintDebug(string.format('\u{1f634} Doing sleep task on %s \u{1f634}', tostring(Ailment.whichPet)))

            if not Utils.IsPetEquipped(Ailment.whichPet) then
                return
            end

            furnitureAilments(bedId, ClientData.get('pet_char_wrappers')[Ailment.whichPet]['char'])
            waitForTaskToFinish('sleepy', petUnique)
        end
        function Ailment.DirtyAilment(showerId, petUnique)
            if not showerId then
                Utils.PrintDebug(string.format('NO showerId: %s', tostring(showerId)))

                return
            end

            Utils.ReEquipPet(Ailment.whichPet)
            Utils.PrintDebug(string.format('\u{1f9fc} Doing dirty task on %s \u{1f9fc}', tostring(Ailment.whichPet)))

            if not Utils.IsPetEquipped(Ailment.whichPet) then
                return
            end

            furnitureAilments(showerId, ClientData.get('pet_char_wrappers')[Ailment.whichPet]['char'])
            waitForTaskToFinish('dirty', petUnique)
        end
        function Ailment.ToiletAilment(litterBoxId, petUnique)
            Utils.ReEquipPet(Ailment.whichPet)
            Utils.PrintDebug(string.format('\u{1f6bd} Doing toilet task on %s \u{1f6bd}', tostring(Ailment.whichPet)))

            if litterBoxId then
                if not Utils.IsPetEquipped(Ailment.whichPet) then
                    return
                end

                furnitureAilments(litterBoxId, ClientData.get('pet_char_wrappers')[Ailment.whichPet]['char'])
            else
                Teleport.DownloadMainMap()
                task.wait(5)

                localPlayer.Character.HumanoidRootPart.CFrame = Workspace.HouseInteriors.furniture:FindFirstChild('AilmentsRefresh2024FireHydrant', true).PrimaryPart.CFrame + Vector3.new(5, 5, 5)

                task.wait(2)
                Utils.ReEquipPet(Ailment.whichPet)
            end

            waitForTaskToFinish('toilet', petUnique)
        end
        function Ailment.BeachPartyAilment(petUnique)
            Utils.PrintDebug(string.format('\u{1f3d6}\u{fe0f} Doing beach party on %s \u{1f3d6}\u{fe0f}', tostring(Ailment.whichPet)))
            Teleport.BeachParty()
            task.wait(2)
            Utils.ReEquipPet(Ailment.whichPet)
            waitForTaskToFinish('beach_party', petUnique)
        end
        function Ailment.CampingAilment(petUnique)
            Utils.PrintDebug(string.format('\u{1f3d5}\u{fe0f} Doing camping task on %s \u{1f3d5}\u{fe0f}', tostring(Ailment.whichPet)))
            Teleport.CampSite()
            task.wait(2)
            Utils.ReEquipPet(Ailment.whichPet)
            waitForTaskToFinish('camping', petUnique)
        end
        function Ailment.WalkAilment(petUnique)
            Utils.ReEquipPet(Ailment.whichPet)
            Utils.PrintDebug(string.format('\u{1f9ae} Doing walking task on %s \u{1f9ae}', tostring(Ailment.whichPet)))

            if not Utils.IsPetEquipped(Ailment.whichPet) then
                return
            end

            ReplicatedStorage.API['AdoptAPI/HoldBaby']:FireServer(ClientData.get('pet_char_wrappers')[Ailment.whichPet]['char'])
            waitForJumpingToFinish('walk', petUnique)

            if not Utils.IsPetEquipped(Ailment.whichPet) then
                return
            end

            ReplicatedStorage.API:FindFirstChild('AdoptAPI/EjectBaby'):FireServer(ClientData.get('pet_char_wrappers')[Ailment.whichPet]['char'])
        end
        function Ailment.RideAilment(strollerId, petUnique)
            if not strollerId then
                Utils.PrintDebug(string.format('NO strollerId: %s', tostring(strollerId)))

                return
            end

            Utils.ReEquipPet(Ailment.whichPet)
            Utils.PrintDebug(string.format('\u{1f697} Doing ride task on %s \u{1f697}', tostring(Ailment.whichPet)))
            ReplicatedStorage.API:FindFirstChild('ToolAPI/Equip'):InvokeServer(strollerId, {})
            task.wait(1)

            if not Utils.IsPetEquipped(Ailment.whichPet) then
                return
            end
            if not useStroller() then
                return
            end

            waitForJumpingToFinish('ride', petUnique)

            if not Utils.IsPetEquipped(Ailment.whichPet) then
                return
            end

            ReplicatedStorage.API:FindFirstChild('AdoptAPI/EjectBaby'):FireServer(ClientData.get('pet_char_wrappers')[Ailment.whichPet]['char'])
        end
        function Ailment.PlayAilment(ailment, petUnique)
            Utils.ReEquipPet(Ailment.whichPet)
            Utils.PrintDebug(string.format('\u{1f9b4} Doing play task on %s \u{1f9b4}', tostring(Ailment.whichPet)))

            local toyId = GetInventory.GetUniqueId('toys', 'squeaky_bone_default')

            if not toyId then
                Utils.PrintDebug("\u{26a0}\u{fe0f} Doesn't have squeaky_bone so exiting \u{26a0}\u{fe0f}")

                return false
            end

            local args = {
                [1] = '__Enum_PetObjectCreatorType_1',
                [2] = {
                    ['reaction_name'] = 'ThrowToyReaction',
                    ['unique_id'] = toyId,
                },
            }
            local count = 0

            repeat
                Utils.PrintDebug('\u{1f9b4} Throwing toy \u{1f9b4}')
                ReplicatedStorage.API:FindFirstChild('PetObjectAPI/CreatePetObject'):InvokeServer(unpack(args))
                task.wait(10)

                local taskActive = ClientData.get_data()[localPlayer.Name].ailments_manager.ailments[petUnique] and ClientData.get_data()[localPlayer.Name].ailments_manager.ailments[petUnique][ailment] and true or false

                count = count + 1
            until not taskActive or count >= 6

            if count >= 6 then
                Utils.PrintDebug('Play task got stuck so requiping pet')
                Utils.ReEquipPet(Ailment.whichPet)

                return false
            end

            Utils.PrintDebug(string.format('\u{1f9b4} Finished play task on %s \u{1f9b4}', tostring(Ailment.whichPet)))

            return true
        end
        function Ailment.MysteryAilment(mysteryId, petUnique)
            Utils.PrintDebug('\u{2753} Picking mystery task \u{2753}')
            pickMysteryTask(mysteryId, petUnique)
        end
        function Ailment.BonfireAilment(petUnique)
            Utils.PrintDebug(string.format('\u{1f3d6}\u{fe0f} Doing bonfire on %s \u{1f3d6}\u{fe0f}', tostring(Ailment.whichPet)))
            Teleport.Bonfire()
            task.wait(2)
            Utils.ReEquipPet(Ailment.whichPet)
            waitForTaskToFinish('summerfest_bonfire', petUnique)
        end
        function Ailment.BuccaneerBandAilment(petUnique)
            ReplicatedStorage.API['LocationAPI/SetLocation']:FireServer('MainMap', localPlayer, ClientData.get_data()[localPlayer.Name].LiveOpsMapType)
            task.wait(2)

            local key = getKeyFrom('summerfest_2025_buccaneer_band')

            if not key then
                Utils.PrintDebug('didnt find key for band')

                return
            end

            Utils.PrintDebug('Doing Band task')

            local args = {
                key,
                'Guitar',
                {
                    ['cframe'] = CFrame.new(-607, 35, -1641, -0, -0, -1, 0, 1, -0, 1, -0, -0),
                },
                localPlayer.Character,
            }

            task.spawn(function()
                ReplicatedStorage.API:FindFirstChild('HousingAPI/ActivateInteriorFurniture'):InvokeServer(unpack(args))
            end)
            waitForTaskToFinish('buccaneer_band', petUnique)
            getUpFromSitting()
        end
        function Ailment.BabyHungryAilment()
            Utils.PrintDebug('\u{1f476}\u{1f374} Doing baby hungry task \u{1f476}\u{1f374}')

            local stuckCount = 0

            repeat
                babyGetFoodAndEat('icecream')

                stuckCount = stuckCount + 1

                task.wait(2)
            until not ClientData.get_data()[localPlayer.Name].ailments_manager.baby_ailments['hungry'] or stuckCount >= 30

            if stuckCount >= 30 then
                Utils.PrintDebug('\u{26a0}\u{fe0f} Waited too long for Baby Hungry. Must be stuck \u{26a0}\u{fe0f}')
            else
                Utils.PrintDebug('\u{1f476}\u{1f374} Baby hungry task Finished \u{1f476}\u{1f374}')
            end
        end
        function Ailment.BabyThirstyAilment()
            Utils.PrintDebug('\u{1f476}\u{1f95b} Doing baby water task \u{1f476}\u{1f95b}')

            local stuckCount = 0

            repeat
                babyGetFoodAndEat('lemonade')

                stuckCount = stuckCount + 1

                task.wait(2)
            until not ClientData.get_data()[localPlayer.Name].ailments_manager.baby_ailments['thirsty'] or stuckCount >= 30

            if stuckCount >= 30 then
                Utils.PrintDebug('\u{26a0}\u{fe0f} Waited too long for Baby Thirsty. Must be stuck \u{26a0}\u{fe0f}')
            else
                Utils.PrintDebug('\u{1f476}\u{1f95b} Baby water task Finished \u{1f476}\u{1f95b}')
            end
        end
        function Ailment.BabyBoredAilment(pianoId)
            Utils.PrintDebug('\u{1f476}\u{1f971} Doing bored task \u{1f476}\u{1f971}')
            getUpFromSitting()

            if pianoId then
                PianoAilment(pianoId, localPlayer.Character)
            else
                Teleport.PlayGround(Vector3.new(20, 10, math.random(15, 30)))
            end

            babyWaitForTaskToFinish('bored')
            getUpFromSitting()
        end
        function Ailment.BabySleepyAilment(bedId)
            if not bedId then
                Utils.PrintDebug(string.format('NO bedId: %s', tostring(bedId)))

                return
            end

            Utils.PrintDebug('\u{1f476}\u{1f634} Doing sleepy task \u{1f476}\u{1f634}')
            getUpFromSitting()
            furnitureAilments(bedId, localPlayer.Character)
            babyWaitForTaskToFinish('sleepy')
            getUpFromSitting()
        end
        function Ailment.BabyDirtyAilment(showerId)
            if not showerId then
                Utils.PrintDebug(string.format('NO showerId: %s', tostring(showerId)))

                return
            end

            Utils.PrintDebug('\u{1f476}\u{1f9fc} Doing dirty task \u{1f476}\u{1f9fc}')
            getUpFromSitting()
            furnitureAilments(showerId, localPlayer.Character)
            babyWaitForTaskToFinish('dirty')
            getUpFromSitting()
        end

        return Ailment
    end
    function __DARKLUA_BUNDLE_MODULES.s()
        local ReplicatedStorage = cloneref(game:GetService('ReplicatedStorage'))
        local Players = cloneref(game:GetService('Players'))
        local Bypass = (require(ReplicatedStorage:WaitForChild('Fsys')).load)
        local ClientData = Bypass('ClientData')
        local RouterClient = Bypass('RouterClient')
        local Utils = __DARKLUA_BUNDLE_MODULES.load('a')
        local GetInventory = __DARKLUA_BUNDLE_MODULES.load('i')
        local Fusion = __DARKLUA_BUNDLE_MODULES.load('h')
        local Teleport = __DARKLUA_BUNDLE_MODULES.load('f')
        local FarmingPet = {}
        local localPlayer = Players.LocalPlayer
        --local petToBuy = 'aztec_egg_2025_aztec_egg'
        local potionFarmPets = {
            'dog',
            'cat',
            'starter_egg',
            --'cracked_egg',
            'basic_egg_2022_ant',
            'basic_egg_2022_mouse',
        }
        local petEggs = GetInventory.GetPetEggs()

        local farmEgg = function()
            if not Utils.IsPetEquipped(1) then
                FarmingPet.GetPetToFarm(1)
            end
            local petName = tostring(ClientData.get('pet_char_wrappers')[1].char)
            if petName:match('Egg') then
                return true
            end
            if GetInventory.CheckForPetAndEquip({
                'aztec_egg_2025_aztec_egg',
            }, 1) then
                return true
            else
                local hasMoney = RouterClient.get('ShopAPI/BuyItem'):InvokeServer('pets', 'aztec_egg_2025_aztec_egg', {})
                if hasMoney then
                    return true
                end
                return false
            end
        end

        local isfocusFarmPets = function()
            local equippedPet = ClientData.get('pet_char_wrappers') and ClientData.get('pet_char_wrappers')[1]

            if not equippedPet then
                return false
            end

            local petId = equippedPet.pet_id

            if not petId then
                return false
            end

            local result = table.find(potionFarmPets, petId) and true or false

            return result
        end
        local isProHandler = function()
            local subscription = ClientData.get_data()[localPlayer.Name].subscription_equip_2x_pets

            if not subscription then
                localPlayer:SetAttribute('isProHandler', false)

                return
            end

            localPlayer:SetAttribute('isProHandler', subscription.active)
        end
        local getEgg = function()
            for _, v in ClientData.get_data()[localPlayer.Name].inventory.pets do
                if v.id == getgenv().SETTINGS.PET_TO_BUY and v.id ~= 'practice_dog' and v.properties.age ~= 6 and not v.properties.mega_neon then
                    RouterClient.get('ToolAPI/Equip'):InvokeServer(v.unique, {
                        ['use_sound_delay'] = true,
                    })

                    getgenv().petCurrentlyFarming1 = v.unique

                    return true
                end
            end

            local BuyEgg = RouterClient.get('ShopAPI/BuyItem'):InvokeServer('pets', getgenv().SETTINGS.PET_TO_BUY, {})

            if BuyEgg == 'too little money' then
                return false
            end

            return false
        end

        function FarmingPet.SwitchOutFullyGrown(whichPet)
            if localPlayer:GetAttribute('StopFarmingTemp') == true then
                return
            end
            if not ClientData.get('pet_char_wrappers')[whichPet] then
                if not Utils.ReEquipPet(whichPet) then
                    Utils.PrintDebug('switchOutFullyGrown: GETTING NEW PETS')
                    FarmingPet.GetPetToFarm(whichPet)

                    return
                end

                task.wait(1)
            end

            local PetAge = ClientData.get('pet_char_wrappers')[whichPet]['pet_progression']['age']

            if PetAge == 6 then
                if getgenv().SETTINGS.PET_AUTO_FUSION then
                    Fusion.MakeMega(false)
                    Fusion.MakeMega(true)
                end

                FarmingPet.GetPetToFarm(whichPet)

                return
            end
        end
        function FarmingPet.GetPetToFarm(whichPet)
            if --[[getgenv().SETTINGS.FOCUS_FARM_AGE_POTION or--]] getgenv().FocusFarmAgePotions then
                if whichPet == 1 and isfocusFarmPets() then
                    Utils.PrintDebug(string.format('Has focusFarmpets equipped, %s', tostring(whichPet)))

                    return
                end

                isProHandler()

                if whichPet == 2 and localPlayer:GetAttribute('isProHandler') == true and getgenv().petCurrentlyFarming2 then
                    return
                end

                Utils.PrintDebug(string.format('\u{1f414}\u{1f414} Getting pet to Farm age up potion, %s \u{1f414}\u{1f414}', tostring(whichPet)))

                if GetInventory.CheckForPetAndEquip({'starter_egg'}, whichPet) then
                    return
                end

                Utils.PrintDebug(string.format('\u{1f414}\u{1f414} No starter egg found, trying dog or cat %s \u{1f414}\u{1f414}', tostring(whichPet)))

                if GetInventory.GetPetFriendship(potionFarmPets, whichPet) then
                    return
                end

                Utils.PrintDebug(string.format('\u{1f414}\u{1f414} No friendship pet. checking if pet without friend exist %s \u{1f414}\u{1f414}', tostring(whichPet)))

                if GetInventory.CheckForPetAndEquip(potionFarmPets, whichPet) then
                    return
                end

                if GetInventory.CheckForPetAndEquip({
                    'cracked_egg',
                }, whichPet) then
                    return
                end
                Utils.PrintDebug(string.format('\u{1f414}\u{1f414} No cracked egg found, buying it %s \u{1f414}\u{1f414}', tostring(whichPet)))
                local hasMoney = RouterClient.get('ShopAPI/BuyItem'):InvokeServer('pets', 'cracked_egg', {})
                Utils.PrintDebug(string.format('hasMoney: %s', tostring(hasMoney)))
                if hasMoney then
                    return
                end
            end

            if getgenv().SETTINGS.HATCH_EGG_PRIORITY or getgenv().HatchPriorityEggs then
                if GetInventory.PriorityEgg(whichPet) then
                    return
                end

                local hasMoney = RouterClient.get('ShopAPI/BuyItem'):InvokeServer('pets', getgenv().SETTINGS.HATCH_EGG_PRIORITY_NAMES[1], {})

                if hasMoney then
                    return
                end
            end
            if getgenv().SETTINGS.PET_ONLY_PRIORITY then
                if GetInventory.PriorityPet(whichPet) then
                    return
                end
            end
            if getgenv().SETTINGS.PET_NEON_PRIORITY then
                if GetInventory.GetNeonPet(whichPet) then
                    return
                end
            end
            if GetInventory.PetRarityAndAge('legendary', 5, whichPet) then
                return
            end
            if GetInventory.PetRarityAndAge('ultra_rare', 5, whichPet) then
                return
            end
            if GetInventory.PetRarityAndAge('rare', 5, whichPet) then
                return
            end
            if GetInventory.PetRarityAndAge('uncommon', 5, whichPet) then
                return
            end
            if GetInventory.PetRarityAndAge('common', 5, whichPet) then
                return
            end
            if getEgg() then
                return
            end

            return
        end
        function FarmingPet.CheckIfEgg(whichPet)
            if not ClientData.get('pet_char_wrappers') then
                return
            end
            if not ClientData.get('pet_char_wrappers')[whichPet] then
                return
            end
            if table.find(petEggs, ClientData.get('pet_char_wrappers')[whichPet].pet_id) then
                return
            end

            Utils.PrintDebug(string.format('NOT A EGG SO GETTING NEW EGG %s', tostring(whichPet)))
            FarmingPet.GetPetToFarm(whichPet)

            return
        end
        function FarmingPet.GetTaskBoardPet(whichPet)
            Utils.PrintDebug('Getting Task Board Pet')

            if not Utils.IsPetEquipped(whichPet) then
                FarmingPet.GetPetToFarm(whichPet)
            end
            for _, v in ClientData.get('quest_manager')['quests_cached']do
                if v['entry_name']:match('house_pets_2025_potion_drank') then
                    for _, v in ClientData.get_data()[localPlayer.Name].inventory.food do
                        if v['id'] == 'pet_grow_potion' then
                            Utils.PrintDebug('Found potion, using it')
                            Utils.CreatePetObject(v['unique'])
                            return true
                        end
                    end
                    if Utils.BucksAmount() >= 10000 then
                        Utils.PrintDebug('Buying grow potion')
                        RouterClient.get('ShopAPI/BuyItem'):InvokeServer('food', 'pet_grow_potion', {buy_count = 1})
                        task.wait(1)
                    end
                end
            end

            for _, v in ClientData.get('quest_manager')['quests_cached']do
                if v['entry_name']:match('house_pets_2025_small_hatch_egg') or v['entry_name']:match('house_pets_2025_medium_hatch_egg') then
                    Utils.PrintDebug('Buying Farming Egg')
                    if farmEgg() then
                        return true
                    end
                end
            end
            for _, v in ClientData.get('quest_manager')['quests_cached']do
                if v['entry_name']:match('house_pets_2025_buy_gumball_egg') then
                    if Utils.BucksAmount() >= 10000 then
                        Utils.PrintDebug('Buying gumball egg')
                        Teleport.Nursery()
                        RouterClient.get('ShopAPI/BuyItem'):InvokeServer('pets', 'aztec_egg_2025_aztec_egg', {})
                    end
                end
            end
            for _, v in ClientData.get('quest_manager')['quests_cached']do
                if v['entry_name']:match('house_pets_2025_large_ailments_common') then
                    if GetInventory.GetPetRarity() == 'common' then
                        return true
                    end
                    if GetInventory.PetRarityAndAge('common', 6, whichPet) then
                        return true
                    end
                end
            end
            for _, v in ClientData.get('quest_manager')['quests_cached']do
                if v['entry_name']:match('house_pets_2025_large_ailments_uncommon') then
                    if GetInventory.GetPetRarity() == 'uncommon' then
                        return true
                    end
                    if GetInventory.PetRarityAndAge('uncommon', 6, whichPet) then
                        return true
                    end
                end
            end
            for _, v in ClientData.get('quest_manager')['quests_cached']do
                if v['entry_name']:match('house_pets_2025_large_ailments_rare') then
                    if GetInventory.GetPetRarity() == 'rare' then
                        return true
                    end
                    if GetInventory.PetRarityAndAge('rare', 6, whichPet) then
                        return true
                    end
                end
            end
            for _, v in ClientData.get('quest_manager')['quests_cached']do
                if v['entry_name']:match('house_pets_2025_large_ailments_ultra_rare') then
                    if GetInventory.GetPetRarity() == 'ultra_rare' then
                        return true
                    end
                    if GetInventory.PetRarityAndAge('ultra_rare', 6, whichPet) then
                        return true
                    end
                end
            end
            for _, v in ClientData.get('quest_manager')['quests_cached']do
                if v['entry_name']:match('house_pets_2025_large_ailments_legendary') then
                    if GetInventory.GetPetRarity() == 'legendary' then
                        return true
                    end
                    if GetInventory.PetRarityAndAge('legendary', 6, whichPet) then
                        return true
                    end
                end
            end
            return false
        end
        return FarmingPet
    end 
    function __DARKLUA_BUNDLE_MODULES.t()
        local ReplicatedStorage = cloneref(game:GetService('ReplicatedStorage'))
        local Utils = __DARKLUA_BUNDLE_MODULES.load('a')
        local Bypass = (require(ReplicatedStorage:WaitForChild('Fsys')).load)
        local RouterClient = Bypass('RouterClient')
        local PetRelease = {}
        function PetRelease.Use(petUniques)
            RouterClient.get('HousingAPI/ActivateInteriorFurniture'):InvokeServer('f-27', 'UseBlock', {
                action = 'use',
                uniques = petUniques,
            }, Utils.GetCharacter())
            Utils.PrintDebug('Added Pets To Release')
        end
        function PetRelease.Claim()
            RouterClient.get('HousingAPI/ActivateInteriorFurniture'):InvokeServer('f-27', 'UseBlock', {
                action = 'claim',
            }, Utils.GetCharacter())
            Utils.PrintDebug('Claimed Eggs from Release pets')
        end
        return PetRelease
    end
    function __DARKLUA_BUNDLE_MODULES.u()
        local ReplicatedStorage = cloneref(game:GetService('ReplicatedStorage'))
        local Players = cloneref(game:GetService('Players'))
        local Bypass = (require(ReplicatedStorage:WaitForChild('Fsys')).load)
        local ClientData = Bypass('ClientData')
        local RouterClient = Bypass('RouterClient')
        local CollisionsClient = Bypass('CollisionsClient')
        local Utils = __DARKLUA_BUNDLE_MODULES.load('a')
        local Ailment = __DARKLUA_BUNDLE_MODULES.load('r')
        local Furniture = __DARKLUA_BUNDLE_MODULES.load('b')
        local Teleport = __DARKLUA_BUNDLE_MODULES.load('f')
        local GetInventory = __DARKLUA_BUNDLE_MODULES.load('i')
        local FarmingPet = __DARKLUA_BUNDLE_MODULES.load('s')
        local Fusion = __DARKLUA_BUNDLE_MODULES.load('h')
        --local PetRelease = __DARKLUA_BUNDLE_MODULES.load('t')
        local self = {}
        local localPlayer = Players.LocalPlayer
        local rng = Random.new(DateTime.now().UnixTimestamp)
        local jobId = game.JobId
        local furniture = Furniture.GetFurnituresKey()
        local baitboxCount = 0
        local strollerId = GetInventory.GetUniqueId('strollers', 'stroller-default')
        --[[local tryToReleasePets = function()
            if getgenv().ENABLE_RELEASE_PETS == false then
                return
            end
            Teleport.Recycler()
            task.wait(5)
            PetRelease.Claim()
            task.wait(1)
            PetRelease.Use(GetInventory.GetPetsToRelease())
        end--]]
        local tryFeedAgePotion = function()
            if not --[[getgenv().SETTINGS.FOCUS_FARM_AGE_POTION or--]] getgenv().FocusFarmAgePotions then
                if ClientData.get('pet_char_wrappers')[1] and table.find(GetInventory.GetPetEggs(), ClientData.get('pet_char_wrappers')[1].pet_id) then
                    Utils.PrintDebug('is egg, not feeding age potion')
                else
                    if ClientData.get('pet_char_wrappers')[1] and table.find(getgenv().SETTINGS.PET_ONLY_PRIORITY_NAMES, ClientData.get('pet_char_wrappers')[1].pet_unique) then
                        Utils.PrintDebug('FEEDING AGE POTION')
                        Utils.FeedAgePotion(GetInventory.GetPetEggs(), 'pet_age_potion')
                        task.wait()
                        Utils.FeedAgePotion(GetInventory.GetPetEggs(), 'tiny_pet_age_potion')
                    end
                end
            end
        end
        local completeBabyAilments = function()
            if localPlayer:GetAttribute('StopFarmingTemp') == true then
                return
            end

            for key, _ in ClientData.get_data()[localPlayer.Name].ailments_manager.baby_ailments do
                if key == 'hungry' then
                    Ailment.BabyHungryAilment()

                    return
                elseif key == 'thirsty' then
                    Ailment.BabyThirstyAilment()

                    return
                elseif key == 'bored' then
                    if furniture.piano == 'nil' then
                        continue
                    end

                    Ailment.BabyBoredAilment(furniture.piano)

                    return
                elseif key == 'sleepy' then
                    if furniture.basiccrib == 'nil' then
                        continue
                    end

                    Ailment.BabySleepyAilment(furniture.basiccrib)

                    return
                elseif key == 'dirty' then
                    if furniture.stylishshower == 'nil' then
                        continue
                    end

                    Ailment.BabyDirtyAilment(furniture.stylishshower)

                    return
                end
            end
        end
        local completePetAilments = function(whichPet)
            if localPlayer:GetAttribute('StopFarmingTemp') == true then
                return false
            end
            if localPlayer:GetAttribute('IsProHandler') == false and whichPet == 2 then
                return false
            end

            local petWrapper = ClientData.get_data()[localPlayer.Name].pet_char_wrappers

            if not petWrapper or not petWrapper[whichPet] then
                if not Utils.IsPetEquipped(whichPet) then
                    Utils.PrintDebug('Getting pet because its not equipped')
                    FarmingPet.GetPetToFarm(whichPet)
                end
            end
            if not ClientData.get_data()[localPlayer.Name].ailments_manager then
                return false
            end
            if not ClientData.get_data()[localPlayer.Name].ailments_manager.ailments then
                return false
            end
            if not ClientData.get_data()[localPlayer.Name].pet_char_wrappers then
                return false
            end
            if not ClientData.get_data()[localPlayer.Name].pet_char_wrappers[whichPet] then
                return false
            end

            local petUnique = ClientData.get_data()[localPlayer.Name].pet_char_wrappers[whichPet].pet_unique

            if not petUnique then
                return false
            end
            if not ClientData.get_data()[localPlayer.Name].ailments_manager.ailments[petUnique] then
                return false
            end

            local petcount = 0

            for _ in ClientData.get_data()[localPlayer.Name].ailments_manager.ailments[petUnique]do
                petcount = petcount + 1
            end

            if petcount == 0 then
                return false
            end

            Ailment.whichPet = whichPet

            for key, _ in ClientData.get_data()[localPlayer.Name].ailments_manager.ailments[petUnique]do
                if key == 'hungry' then
                    Ailment.HungryAilment()

                    return true
                elseif key == 'thirsty' then
                    Ailment.ThirstyAilment()

                    return true
                elseif key == 'sick' then
                    Ailment.SickAilment()

                    return true
                elseif key == 'pet_me' then
                    Ailment.PetMeAilment()

                    return true
                end
            end
            for key, _ in ClientData.get_data()[localPlayer.Name].ailments_manager.ailments[petUnique]do
                if key == 'salon' then
                    Ailment.SalonAilment(key, petUnique)
                    Teleport.FarmingHome()

                    return true
                elseif key == 'moon' then
                    Ailment.MoonAilment(key, petUnique)

                    return true
                elseif key == 'pizza_party' then
                    Ailment.PizzaPartyAilment(key, petUnique)
                    Teleport.FarmingHome()

                    return true
                elseif key == 'school' then
                    Ailment.SchoolAilment(key, petUnique)
                    Teleport.FarmingHome()

                    return true
                elseif key == 'bored' then
                    if furniture.piano == 'nil' then
                        continue
                    end

                    Ailment.BoredAilment(furniture.piano, petUnique)

                    return true
                elseif key == 'sleepy' then
                    if furniture.basiccrib == 'nil' then
                        continue
                    end

                    Ailment.SleepyAilment(furniture.basiccrib, petUnique)

                    return true
                elseif key == 'dirty' then
                    if furniture.stylishshower == 'nil' then
                        continue
                    end
                    --task.wait(65) -- test
                    Ailment.DirtyAilment(furniture.stylishshower, petUnique)

                    return true
                elseif key == 'walk' then
                    Ailment.WalkAilment(petUnique)

                    return true
                elseif key == 'toilet' then
                    if furniture.ailments_refresh_2024_litter_box == 'nil' then
                        continue
                    end

                    Ailment.ToiletAilment(furniture.ailments_refresh_2024_litter_box, petUnique)

                    return true
                elseif key == 'ride' then
                    Ailment.RideAilment(strollerId, petUnique)

                    return true
                elseif key == 'play' then
                    if not Ailment.PlayAilment(key, petUnique) then
                        return false
                    end

                    return true
                end
            end
            for key, _ in ClientData.get_data()[localPlayer.Name].ailments_manager.ailments[petUnique]do
                if key == 'beach_party' then
                    Teleport.PlaceFloorAtBeachParty()
                    Ailment.BeachPartyAilment(petUnique)
                    task.wait(5)
                    Teleport.FarmingHome()

                    return true
                elseif key == 'camping' then
                    Teleport.PlaceFloorAtCampSite()
                    Ailment.CampingAilment(petUnique)
                    task.wait(160) -- test
                    Teleport.FarmingHome()

                    return true
               elseif key == 'buccaneer_band' then
                    Ailment.BuccaneerBandAilment(petUnique)
                    task.wait(5)
                    Teleport.FarmingHome()

                    return true
                elseif key == 'summerfest_bonfire' then
                    Ailment.BonfireAilment(petUnique)
                    task.wait(5)
                    Teleport.FarmingHome()

                    return true
                end
            end
            for key, _ in ClientData.get_data()[localPlayer.Name].ailments_manager.ailments[petUnique]do
                if key:match('mystery') then
                    Ailment.MysteryAilment(key, petUnique)

                    return true
                end
            end

            return false
        end
        local setupFloor = function()
            Teleport.PlaceFloorAtFarmingHome()
            Teleport.PlaceFloorAtCampSite()
            Teleport.PlaceFloorAtBeachParty()
        end

        local startAutoFarm = function()
            task.spawn(function()
                while getgenv().auto_farm do
                    if game.JobId ~= jobId then
                        getgenv().auto_farm = false

                        --Utils.PrintDebug(' \u{26d4} not same jobid so exiting \u{26d4}')
                        --task.wait()
                        --game:Shutdown()

                        return
                    end
                    if localPlayer:GetAttribute('StopFarmingTemp') == true then
                        local count = 0

                        repeat
                            Utils.PrintDebug('Stopping because its buying or aging or in minigame')

                            count = count + 20

                            task.wait(20)
                        until not localPlayer:GetAttribute('StopFarmingTemp') or count > 600

                        localPlayer:SetAttribute('StopFarmingTemp', false)
                    end

                    Utils.RemoveHandHeldItem()

                    if getgenv().SETTINGS.HATCH_EGG_PRIORITY or getgenv().HatchPriorityEggs then
                        FarmingPet.CheckIfEgg(1)
                        task.wait(1)

                        if localPlayer:GetAttribute('isProHandler') then
                            FarmingPet.CheckIfEgg(2)
                            task.wait(1)
                        end
                    end
                    if --[[getgenv().SETTINGS.FOCUS_FARM_AGE_POTION or--]] getgenv().FocusFarmAgePotions then
                         FarmingPet.GetPetToFarm(1)
                    end
                    if not completePetAilments(1) then
                        task.wait()
                        completeBabyAilments()
                    end

                    task.wait(1)

                    if not --[[getgenv().SETTINGS.FOCUS_FARM_AGE_POTION or--]] getgenv().FocusFarmAgePotions then
                        FarmingPet.SwitchOutFullyGrown(1)

                        if localPlayer:GetAttribute('isProHandler') then
                            FarmingPet.SwitchOutFullyGrown(2)
                        end
                    end
                    if baitboxCount > 600 then
                        local baitUnique = Utils.FindBait()

                        Utils.PlaceBaitOrPickUp(furniture.lures_2023_normal_lure, baitUnique)
                        task.wait(2)
                        Utils.PlaceBaitOrPickUp(furniture.lures_2023_normal_lure, baitUnique)

                        baitboxCount = 0

                        --tryToReleasePets()
                    end

                    tryFeedAgePotion()

                    local waitTime = rng:NextNumber(5, 15)

                    baitboxCount = baitboxCount + waitTime

                    Utils.PrintDebug(string.format('waiting %s', tostring(waitTime)))
                    task.wait(waitTime)
                end
            end)
        end

        function self.Init()
            --RouterClient.get('PayAPI/DisablePopups'):FireServer()
        end
        function self.Start()
            if not getgenv().auto_farm then
                Utils.PrintDebug('ENABLE_AUTO_FARM is false')

                return
            end
            if getgenv().SETTINGS.PET_AUTO_FUSION or getgenv().AutoFusion then
                Fusion.MakeMega(false)
                Fusion.MakeMega(true)
                task.wait(2)
            end

            setupFloor()
            CollisionsClient.set_collidable(false)
            task.wait(2)
            Teleport.FarmingHome()
            Utils.PrintDebug('teleported to farming place')
            Utils.PrintDebug('Started Farming')
            localPlayer:SetAttribute('hasStartedFarming', true)
            --tryToReleasePets()
            Utils.UnEquipAllPets()
            task.wait(2)
            FarmingPet.GetPetToFarm(1)

            task.wait(2)

            if localPlayer:GetAttribute('isProHandler') == true then
                FarmingPet.GetPetToFarm(2)
            end

            startAutoFarm()

            --localPlayer:SetAttribute('StopFarmingTemp', true)
        end

        return self
    end

    function __DARKLUA_BUNDLE_MODULES.v()
        local ReplicatedStorage = cloneref(game:GetService('ReplicatedStorage'))
        local Players = cloneref(game:GetService('Players'))
        local Bypass = (require(ReplicatedStorage:WaitForChild('Fsys')).load)
        local RouterClient = Bypass('RouterClient')
        local ClientData = Bypass('ClientData')
        local Utils = __DARKLUA_BUNDLE_MODULES.load('a')
        local PetOffline = {}
        local localPlayer = Players.LocalPlayer

        function PetOffline.AddPet(petId)
            RouterClient.get('IdleProgressionAPI/AddPet'):FireServer(petId)
            Utils.PrintDebug('Added pet to offline farming: ' .. petId)
        end
        function PetOffline.RemovePet(petId)
            RouterClient.get('IdleProgressionAPI/RemovePet'):FireServer(petId)
        end
        function PetOffline.ClaimAllXP()
            RouterClient.get('IdleProgressionAPI/CommitAllProgression'):FireServer()
            Utils.PrintDebug('Claimed all XP')
        end
        function PetOffline.GetAmountOfPetsInPen()
            local count = 0
            for _, _ in ClientData.get_data()[localPlayer.Name].idle_progression_manager.active_pets do
                count = count + 1
            end
            return count
        end

        return PetOffline
    end
    function __DARKLUA_BUNDLE_MODULES.w()
        local ReplicatedStorage = game:GetService('ReplicatedStorage')
        local Players = game:GetService('Players')
        local Bypass = (require(ReplicatedStorage:WaitForChild('Fsys')).load)
        local ClientData = Bypass('ClientData')
        local RouterClient = (Bypass('RouterClient'))
        local PetOffline = __DARKLUA_BUNDLE_MODULES.load('v')
        local GetInventory = __DARKLUA_BUNDLE_MODULES.load('i')
        local Utils = __DARKLUA_BUNDLE_MODULES.load('a')
        local PetOfflineHandler = {}
        local localPlayer = Players.LocalPlayer
        --local petsInPenList = getgenv().SETTINGS.PETS_TO_AGE_IN_PEN
        local CurrentIdlePets = {}
        local petProgrssedDebounce = false
        local updateCurrentIdlePets = function()
            CurrentIdlePets = {}

            local idleManager = ClientData.get_data()[localPlayer.Name].idle_progression_manager

            for key, value in idleManager.active_pets do
                table.insert(CurrentIdlePets, key)
            end
        end
        local removeAllMaxedPets = function()
            local idleManager = ClientData.get_data()[localPlayer.Name].idle_progression_manager

            for key, value in idleManager.active_pets do
                if value.max_age then
                    PetOffline.RemovePet(key)
                    task.wait(1)
                end
            end

            updateCurrentIdlePets()
        end
        local addAllPetsToidleFarm = function()
            if #CurrentIdlePets >= 4 then
                return
            end

            local petUniques = GetInventory.GetHighestGrownPetForIdle(5)

             Utils.PrintDebug(string.format('how many pets ids ther is in table: %s', tostring(#petUniques)))

            for _, unique in ipairs(petUniques)do
                if table.find(CurrentIdlePets, unique) then
                    Utils.PrintDebug(string.format('Pet %s is already in idle farm, skipping...', tostring(unique)))

                    continue
                end

                PetOffline.AddPet(unique)
                task.wait(1)
            end
        end

        function PetOfflineHandler.Init()
            RouterClient.get('DataAPI/DataChanged').OnClientEvent:Connect(function(
                _,
                dataType,
                data
            )
                if dataType ~= 'idle_progression_manager' then
                    return
                end
                if not data then
                    return
                end
		
                if petProgrssedDebounce then
                    return
                end

                petProgrssedDebounce = true
		
                if data.age_up_pending then
                     Utils.PrintDebug('Age up pending, claiming all XP...')
                    PetOffline.ClaimAllXP()
                end

                for key, value in data.active_pets do
                    if value.max_age then
                        PetOffline.RemovePet(key)
                        task.wait(1)
                    end
                end

                updateCurrentIdlePets()
                addAllPetsToidleFarm()

                petProgrssedDebounce = false
            end)
        end
        function PetOfflineHandler.Start()
            if getgenv().ENABLE_AUTO_FARM == false then
                return
            end

            PetOffline.ClaimAllXP()
            task.wait(2)
            removeAllMaxedPets()
            task.wait(2)
            addAllPetsToidleFarm()
        end

        return PetOfflineHandler
    end
------------- free----------------------------
    function __DARKLUA_BUNDLE_MODULES.x()

    end

    function __DARKLUA_BUNDLE_MODULES.y()

    end

    function __DARKLUA_BUNDLE_MODULES.z()

    end
---------------------------------------------------
    function __DARKLUA_BUNDLE_MODULES.A()
        local ReplicatedStorage = cloneref(game:GetService('ReplicatedStorage'))
        local Players = cloneref(game:GetService('Players'))
        local Bypass = (require(ReplicatedStorage:WaitForChild('Fsys')).load)
        local ClientData = Bypass('ClientData')
        local InventoryDB = Bypass('InventoryDB')
        local Clipboard = {}
        local localPlayer = Players.LocalPlayer
        local getPetInfoMega = function(title)
            local megaPets = {}
            local textPetList = ''

            for _, v in ClientData.get_data()[localPlayer.Name].inventory.pets do
                for _, v2 in InventoryDB.pets do
                    if v.id == v2.id and v.properties.mega_neon then
                        megaPets[title .. v2.name] = (megaPets[title .. v2.name] or 0) + 1
                    end
                end
            end
            for i, v in megaPets do
                textPetList = string.format('%s%s x%s\n', tostring(textPetList), tostring(i), tostring(v))
            end

            return textPetList
        end
        local getPetInfoNeon = function(title)
            local neonPets = {}
            local textPetList = ''

            for _, v in ClientData.get_data()[localPlayer.Name].inventory.pets do
                for _, v2 in InventoryDB.pets do
                    if v.id == v2.id and v.properties.neon then
                        neonPets[title .. v2.name] = (neonPets[title .. v2.name] or 0) + 1
                    end
                end
            end
            for i, v in neonPets do
                textPetList = string.format('%s%s x%s\n', tostring(textPetList), tostring(i), tostring(v))
            end

            return textPetList
        end
        local getPetInfoNormal = function(title)
            local normalPets = {}
            local textPetList = ''

            for _, v in pairs(ClientData.get_data()[localPlayer.Name].inventory.pets)do
                for _, v2 in InventoryDB.pets do
                    if v.id == v2.id and not v.properties.neon and not v.properties.mega_neon then
                        normalPets[title .. v2.name] = (normalPets[title .. v2.name] or 0) + 1
                    end
                end
            end
            for i, v in normalPets do
                textPetList = string.format('%s%s x%s\n', tostring(textPetList), tostring(i), tostring(v))
            end

            return textPetList
        end
        local getInventoryInfo = function(tab, tablePassOn)
            for _, v in pairs(ClientData.get_data()[localPlayer.Name].inventory[tab])do
                if v.id == 'practice_dog' then
                    continue
                end

                tablePassOn[v.id] = (tablePassOn[v.id] or 0) + 1
            end
        end
        local getTable = function(nameId, tablePassOn)
            local text = ''

            for i, v in tablePassOn do
                for _, v2 in InventoryDB[nameId]do
                    if i == tostring(v2.id) then
                        text = text .. '[' .. string.upper(nameId) .. '] ' .. v2.name .. ' x' .. v .. '\n'
                    end
                end
            end

            return text
        end
        local getAgeupPotionInfo = function()
            local count = 0

            for _, v in pairs(ClientData.get_data()[localPlayer.Name].inventory.food)do
                if v.id == 'pet_age_potion' then
                    count = count + 1
                end
            end

            return count
        end
        local addComma = function(amount)
            local formatted = amount
            local k

            while true do
                formatted, k = string.gsub(formatted, '^(-?%d+)(%d%d%d)', '%1,%2')

                if k == 0 then
                    break
                end
            end

            return formatted
        end
        local getBucksInfo = function()
            local text = ''
            local potions = getAgeupPotionInfo()
            local potionAmount = potions * 0.04
            local bucks = ClientData.get_data()[localPlayer.Name].money or 0

            text = text .. string.format('%s Age-up Potions + %s Bucks | Adopt me\n', tostring(potions), tostring(addComma(bucks)))

            local formatNumber = string.format('%.2f', potionAmount)

            text = text .. string.format('sell for $%s  %s\n\n', tostring(tostring(formatNumber)), tostring(localPlayer.Name))

            return text
        end

        function Clipboard.GetAllInventoryData()
            local inventoryData = ''
            local inventoryTables = {
                petsTable = {},
                petAccessoriesTable = {},
                strollersTable = {},
                foodTable = {},
                transportTable = {},
                toysTable = {},
                giftsTable = {},
            }

            getInventoryInfo('pets', inventoryTables.petsTable)
            getInventoryInfo('pet_accessories', inventoryTables.petAccessoriesTable)
            getInventoryInfo('strollers', inventoryTables.strollersTable)
            getInventoryInfo('food', inventoryTables.foodTable)
            getInventoryInfo('transport', inventoryTables.transportTable)
            getInventoryInfo('toys', inventoryTables.toysTable)
            getInventoryInfo('gifts', inventoryTables.giftsTable)

            inventoryData = inventoryData .. getBucksInfo()
            inventoryData = inventoryData .. getTable('pets', inventoryTables.petsTable)
            inventoryData = inventoryData .. getTable('pet_accessories', inventoryTables.petAccessoriesTable)
            inventoryData = inventoryData .. getTable('strollers', inventoryTables.strollersTable)
            inventoryData = inventoryData .. getTable('food', inventoryTables.foodTable)
            inventoryData = inventoryData .. getTable('transport', inventoryTables.transportTable)
            inventoryData = inventoryData .. getTable('toys', inventoryTables.toysTable)
            inventoryData = inventoryData .. getTable('gifts', inventoryTables.giftsTable)

            return inventoryData
        end
        function Clipboard.CopyDetailedPetInfo()
            local petDetailedList = ''

            petDetailedList = petDetailedList .. getPetInfoMega('[MEGA NEON] ')
            petDetailedList = petDetailedList .. getPetInfoNeon('[NEON] ')
            petDetailedList = petDetailedList .. getPetInfoNormal('[Normal] ')

            return petDetailedList
        end
        function Clipboard.GetIdsFromDatabase(nameId)
            local data = ''
            local lines = 
[[

---------------------------------------------------------------
]]

            for catagoryName, catagoryTable in InventoryDB do
                if catagoryName ~= nameId then
                    continue
                end

                data = data .. lines
                data = data .. string.format('\n                    %s                    \n', tostring(string.upper(catagoryName)))
                data = data .. lines .. '\n'

                for id, _ in catagoryTable do
                    data = data .. string.format('%s\n', tostring(id))
                end
            end

            return data
        end

        return Clipboard
    end
    function __DARKLUA_BUNDLE_MODULES.B()
        local Players = cloneref(game:GetService('Players'))
        local Rayfield = loadstring(game:HttpGet("https://raw.githubusercontent.com/Nocrazypc/Rayfield/main/Source1.lua"))()
        local GetInventory = __DARKLUA_BUNDLE_MODULES.load('i')
        local Clipboard = __DARKLUA_BUNDLE_MODULES.load('A')
        local Fusion = __DARKLUA_BUNDLE_MODULES.load('h')
        local Trade = __DARKLUA_BUNDLE_MODULES.load('e')
        local Utils = __DARKLUA_BUNDLE_MODULES.load('a')
        local BulkPotion = __DARKLUA_BUNDLE_MODULES.load('j')
        local Teleport = __DARKLUA_BUNDLE_MODULES.load('f')
        local self = {}
        local localPlayer = Players.LocalPlayer
        local cooldown = false
        local selectedPlayer
        local selectedPet
        local selectedAgeablePet
        local selectedAgeableNumber
        local selectedGift
        local selectedToy
        local selectedFood
        local PetToggle
        local TradeAllInventory
        local AllPetsToggle
        local LegendaryToggle
        local FullgrownToggle
        local MultipleChoiceToggle
        local AnyNeonToggle
        local TradeAllMegas
        local TradeAllNeons
        local LowTierToggle
        local RarityToggle
        local GiftToggle
        local ToyToggle
        local FoodToggle
        local petRaritys = {
            'common',
            'uncommon',
            'rare',
            'ultra_rare',
            'legendary',
        }
        local petAges = {
            'Newborn/Reborn',
            'Junior/Twinkle',
            'Pre_Teen/Sparkle',
            'Teen/Flare',
            'Post_Teen/Sunshine',
            'Full_Grown/Luminous',
        }
        local petNeons = {
            'normal',
            'neon',
            'mega_neon',
        }
        local multipleOptionsTable = {
            ['rarity'] = {},
            ['ages'] = {},
            ['neons'] = {},
        }
-------------------------------------------

    function __DARKLUA_BUNDLE_MODULES.C()
        local ReplicatedStorage = cloneref(game:GetService('ReplicatedStorage'))
        local Players = cloneref(game:GetService('Players'))
        local Bypass = (require(ReplicatedStorage:WaitForChild('Fsys')).load)
        local ClientData = Bypass('ClientData')
        local RouterClient = Bypass('RouterClient')
        local self = {}
        local localPlayer = Players.LocalPlayer
        local PlayerGui = localPlayer:WaitForChild('PlayerGui')
        local neonTable = {
            ['neon_fusion'] = true,
            ['mega_neon_fusion'] = true,
        }
        local claimTable = {
            ['hatch_three_eggs'] = {3},
            ['fully_age_three_pets'] = {3},
            ['fully_age_up_a_pet_to_its_max_age'] = {1},
            ['make_two_trades'] = {2},
            ['equip_two_accessories'] = {2},
            ['buy_three_furniture_items_with_friends_coop_budget'] = {3},
            ['buy_five_furniture_items'] = {5},
            ['buy_fifteen_furniture_items'] = {15},
            ['play_as_a_baby_for_twenty_five_minutes'] = {1500},
            ['play_for_thirty_minutes'] = {1800},
            ['sunshine_2024_playtime'] = {2400},
            ['bonus_week_2024_small_ailments'] = {5},
            ['bonus_week_2024_small_hatch_egg'] = {1},
            ['bonus_week_2024_small_age_potion_drank'] = {1},
            ['bonus_week_2024_small_ailment_orange'] = {1},
            ['bonus_week_2024_medium_ailment_hungry_sleepy_bored'] = {3},
            ['bonus_week_2024_medium_ailment_catch_bored'] = {2},
            ['bonus_week_2024_medium_ailment_toilet_dirty_sleepy'] = {3},
            ['bonus_week_2024_medium_ailment_pizza_hungry'] = {2},
            ['bonus_week_2024_medium_ailment_salon_dirty'] = {2},
            ['bonus_week_2024_medium_ailment_school_ride'] = {2},
            ['bonus_week_2024_medium_ailment_walk_beach'] = {2},
            ['bonus_week_2024_medium_ailments'] = {15},
            ['bonus_week_2024_large_ailments_common'] = {30},
            ['bonus_week_2024_large_ailments_legendary'] = {30},
            ['bonus_week_2024_large_ailments_ultra_rare'] = {30},
            ['bonus_week_2024_large_ailments_uncommon'] = {30},
            ['bonus_week_2024_large_ailments_rare'] = {30},
            ['bonus_week_2024_large_ailments'] = {30},
        }

        function self.Init()
            self.NewTaskBool = true
            self.NewClaimBool = true
            self.NeonTable = neonTable
            self.ClaimTable = claimTable
        end
        function self.Start()
            local ImageButton = PlayerGui:WaitForChild('QuestIconApp'):WaitForChild('ImageButton')
            local IsNew = ImageButton:WaitForChild('EventContainer'):WaitForChild('IsNew')
            local IsClaimable = ImageButton:WaitForChild('EventContainer'):WaitForChild('IsClaimable')

            IsNew:GetPropertyChangedSignal('Position'):Connect(function()
                if self.NewTaskBool then
                    self.NewTaskBool = false

                    RouterClient.get('QuestAPI/MarkQuestsViewed'):FireServer()
                    self:NewTask()
                end
            end)
            IsClaimable:GetPropertyChangedSignal('Position'):Connect(function()
                if self.NewClaimBool then
                    self.NewClaimBool = false

                    self:NewClaim()
                end
            end)
            self:NewClaim()
            self:NewTask()
        end
        function self.QuestCount()
            local Count = 0

            for _, v in pairs(ClientData.get('quest_manager')['quests_cached'])do
                if v['entry_name']:match('teleport') or v['entry_name']:match('navigate') or v['entry_name']:match('nav') or v['entry_name']:match('gosh_2022_sick') then
                    Count = Count + 0
                else
                    Count = Count + 1
                end
            end

            return Count
        end

        local reRollCount = function()
            for _, v in pairs(ClientData.get('quest_manager')['daily_quest_data'])do
                if v == 1 or v == 0 then
                    return v
                end
            end

            return 0
        end

        function self:NewTask()
            self.NewTaskBool = false

            for _, v in pairs(ClientData.get('quest_manager')['quests_cached'])do
                if v['entry_name']:match('teleport') then
                    task.wait()
                elseif v['entry_name']:match('tutorial') then
                    RouterClient.get('QuestAPI/ClaimQuest'):InvokeServer(v['unique_id'])
                    task.wait()
                elseif v['entry_name']:match('celestial_2024_small_open_gift') then
                    RouterClient.get('ShopAPI/BuyItem'):InvokeServer('gifts', 'smallgift', {})
                    task.wait(1)

                    for _, v in ClientData.get_data()[localPlayer.Name].inventory.gifts do
                        if v['id'] == 'smallgift' then
                            RouterClient.get('ShopAPI/OpenGift'):InvokeServer(v['unique'])

                            break
                        end
                    end

                    task.wait()
                else
                    if self.QuestCount() == 1 then
                        if self.NeonTable[v['entry_name'] ] then
                            RouterClient.get('QuestAPI/ClaimQuest'):InvokeServer(v['unique_id'])
                            task.wait()
                        elseif not self.NeonTable[v['entry_name'] ] and reRollCount() >= 1 then
                            RouterClient.get('QuestAPI/RerollQuest'):FireServer(v['unique_id'])
                            task.wait()
                        end
                    elseif self.QuestCount() > 1 then
                        if self.NeonTable[v['entry_name'] ] then
                            RouterClient.get('QuestAPI/ClaimQuest'):InvokeServer(v['unique_id'])
                            task.wait()
                        elseif not self.NeonTable[v['entry_name'] ] and reRollCount() >= 1 then
                            RouterClient.get('QuestAPI/RerollQuest'):FireServer(v['unique_id'])
                            task.wait()
                        elseif not self.NeonTable[v['entry_name'] ] and reRollCount() <= 0 then
                            RouterClient.get('QuestAPI/ClaimQuest'):InvokeServer(v['unique_id'])
                            task.wait()
                        end
                    end
                end
            end

            task.wait(1)

            self.NewTaskBool = true
        end
        function self:NewClaim()
            self.NewClaimBool = false

            for _, v in pairs(ClientData.get('quest_manager')['quests_cached'])do
                if self.ClaimTable[v['entry_name'] ] then
                    if v['steps_completed'] == self.ClaimTable[v['entry_name'] ][1] then
                        RouterClient.get('QuestAPI/ClaimQuest'):InvokeServer(v['unique_id'])
                        task.wait()
                    end
                elseif not self.ClaimTable[v['entry_name'] ] and v['steps_completed'] == 1 then
                    RouterClient.get('QuestAPI/ClaimQuest'):InvokeServer(v['unique_id'])
                    task.wait()
                end
            end

            task.wait(1)

            self.NewClaimBool = true
        end

        return self
    end
------------- Rayfield Config ------------- 
local Rayfield = loadstring(game:HttpGet("https://raw.githubusercontent.com/Nocrazypc/Rayfield/main/Source1.lua"))()

        local setupRayfield = function()
        local Window = Rayfield:CreateWindow({
	        Name = "BLN Adopt Me!  Autofarm V4.4 - Feli Mode ❤",
                Theme = 'Default',
                DisableRayfieldPrompts = true,
                DisableBuildWarnings = true,
                LoadingTitle = "Loading BLN V4 Script ",
                LoadingSubtitle = "by BlackLastNight 2025",
	        ConfigurationSaving = {
		Enabled = false,
		FolderName = nil, -- Create a custom folder for your hub/game
		FileName = "BLN 4",
                },
                Discord = {
                    Enabled = false,
                    Invite = 'noinvitelink',
                    RememberJoins = true,
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

-----  First Tab - Autofarm -------------------
local FarmTab = Window:CreateTab("Farm", 4483362458)
------------------------------------------------
local FarmToggle = FarmTab:CreateToggle({
     Name = "Start AutoFarm",
     CurrentValue = true,
     Flag = "Toggle01",
     Callback = function(Value)
	
		  task.wait(3)
          Teleport.FarmingHome()
		  --getgenv().auto_farm = Value
          localPlayer:SetAttribute('StopFarmingTemp', false)
     end,
 })

FarmTab:CreateButton({
	Name = "Stop AutoFarm Temporarily (5 minutes)",
	Callback = function()
	    localPlayer:SetAttribute('StopFarmingTemp', true)
        task.wait(300)
        localPlayer:SetAttribute('StopFarmingTemp', false)
	end,
})
-----------------------------------------------
local FarmToggle = FarmTab:CreateToggle({
     Name = "Pet Auto Fusion",
     CurrentValue = false,
     Flag = "Toggle03",
     Callback = function(Value)
         getgenv().AutoFusion = Value

	 while getgenv().AutoFusion do
	 Fusion.MakeMega(false) -- makes neon
	 Fusion.MakeMega(true) -- makes mega
         task.wait(600)
	end
     end,
 })
-------------------------------------------
local FarmToggle = FarmTab:CreateToggle({
     Name = "Focus Farm Age Potions",
     CurrentValue = true,
     Flag = "Toggle033",
     Callback = function(Value)

         getgenv().FocusFarmAgePotions = Value

     end,
 })
-------------------------------------------
local FarmToggle = FarmTab:CreateToggle({
     Name = "Low Render / Hide Parts",
     CurrentValue = true,
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
-------------------------------------
--[[for i,v in pairs(game:GetService("ReplicatedStorage").ClientModules.Game.PetEntities.PetPerformancesFolder.Emotes:GetChildren()) do 
    if v:IsA("ModuleScript") then 
        require(v).step = function() return end 
    end
end    

for i,v in pairs(game:GetService("ReplicatedStorage").ClientModules.Game.PetEntities.PetReactions:GetChildren()) do 
    require(v).init_reaction = function() return end 
end  

for i,v in pairs(game:GetService("ReplicatedStorage").ClientModules.Game.PetEntities.PetPerformancesFolder.Transitions:GetChildren()) do 
    if v:IsA("ModuleScript") then 
        require(v).step = function() return end 
    end
end   

for Data,Effect in pairs(require(game:GetService("ReplicatedStorage").ClientModules.Core.UIManager.Apps.SpecialEffectsApp)) do 
    if type(Data) == "function" then 
        Data = function() return end 
    end
end--]]
--------------------------------------
     end,
 })
-------- Transition disabler -------------
local FarmToggle = FarmTab:CreateToggle({
     Name = "Transitions Disabler",
     CurrentValue = true,
     Flag = "Toggle05",
     Callback = function(Value)

pcall(function() 
    require(game.ReplicatedStorage.ClientModules.Core.UIManager.Apps.TransitionsApp).transition = function() return end 
    require(game.ReplicatedStorage.ClientModules.Core.UIManager.Apps.TransitionsApp).sudden_fill = function() return end
    if Player.PlayerGui:FindFirstChild("TransitionsApp") then
        Player.PlayerGui.TransitionsApp:FindFirstChild("Whiteout").Visible = false
    end
end)

     end,
 })

FarmTab:CreateDivider()
--------- Hatch Eggs Only ------------
FarmTab:CreateSection("Eggs Only")
--------------------------------------
local FarmToggle = FarmTab:CreateToggle({
     Name = "Buy & Hatch Current Eggs: Aztec Egg",
     CurrentValue = false,
     Flag = "Toggle201",
     Callback = function(Value)
	
        task.wait(3)
        getgenv().HatchPriorityEggs = Value
        localPlayer:SetAttribute('StopFarmingTemp', false)

     end,
 })

FarmTab:CreateDivider()
----------- Minigames -------------
FarmTab:CreateSection("Events & Minigames: Nothing")
--------------------------------------
--[[local FarmToggle = FarmTab:CreateToggle({
     Name = " Get daily Skulls from Temple Trek Minigame",
     CurrentValue = false,
     Flag = "Toggle10",
     Callback = function(Value)

     local AztecEvent = __DARKLUA_BUNDLE_MODULES.load('w')
	 getgenv().AutoMinigame = Value

	 while task.wait(3) do
         AztecEvent.StartEvent()
         task.wait(20)
         AztecEvent.BuyRoyalEgg()
         task.wait(3600)
         end

     end,
 })--]]

--[[local FarmToggle = FarmTab:CreateToggle({
     Name = "Tear Up Toykyo Minigame",
     CurrentValue = false,
     Flag = "Toggle11",
     Callback = function(Value)

     getgenv().AutoMinigame2 = Value

     end,
 }) --]]


--------- Second Tab -----------
            local MiscTab = Window:CreateTab('Others', 4483362458)

            MiscTab:CreateSection('1 Click = ALL Neon/Mega')
            MiscTab:CreateButton({
                Name = 'Make Neons',
                Callback = function()
                    Fusion.MakeMega(false)
                end,
            })
            MiscTab:CreateButton({
                Name = 'Make Megas',
                Callback = function()
                    Fusion.MakeMega(true)
                end,
            })
            MiscTab:CreateDivider()
            MiscTab:CreateButton({
                Name = 'Get player inventory data',
                Callback = function()
                    setclipboard(Clipboard.GetAllInventoryData())
                end,
            })
            MiscTab:CreateButton({
                Name = 'Get player Detailed inventory data',
                Callback = function()
                    setclipboard(Clipboard.CopyDetailedPetInfo())
                end,
            })
            MiscTab:CreateDivider()
            MiscTab:CreateButton({
                Name = "Get pets database id's",
                Callback = function()
                    setclipboard(Clipboard.GetIdsFromDatabase('pets'))
                end,
            })
            MiscTab:CreateButton({
                Name = "Get gifts database id's",
                Callback = function()
                    setclipboard(Clipboard.GetIdsFromDatabase('gifts'))
                end,
            })
            MiscTab:CreateButton({
                Name = "Get pet_accessories (pet wear and wings) database id's",
                Callback = function()
                    setclipboard(Clipboard.GetIdsFromDatabase('pet_accessories'))
                end,
            })
            MiscTab:CreateButton({
                Name = "Get toys database id's",
                Callback = function()
                    setclipboard(Clipboard.GetIdsFromDatabase('toys'))
                end,
            })
            MiscTab:CreateButton({
                Name = "Get transport database id's",
                Callback = function()
                    setclipboard(Clipboard.GetIdsFromDatabase('transport'))
                end,
            })
            MiscTab:CreateButton({
                Name = "Get food database id's",
                Callback = function()
                    setclipboard(Clipboard.GetIdsFromDatabase('food'))
                end,
            })
            MiscTab:CreateButton({
                Name = "Get strollers database id's",
                Callback = function()
                    setclipboard(Clipboard.GetIdsFromDatabase('strollers'))
                end,
            })
            MiscTab:CreateButton({
                Name = "Get stickers database id's",
                Callback = function()
                    setclipboard(Clipboard.GetIdsFromDatabase('stickers'))
                end,
            }) 

-------Third Tab: AutoTrade --------------

            local TradeTab = Window:CreateTab('Auto Trade', 4483362458)

            TradeTab:CreateSection('only enable Auto Accept trade on alt getting the items')
            TradeTab:CreateToggle({
                Name = 'Auto accept trade windows',
                CurrentValue = false,
                Flag = 'Toggle1',
                Callback = function(Value)
                    getgenv().auto_accept_trade = Value

                    if getgenv().auto_accept_trade then
                        Rayfield:SetVisibility(false)
                        task.wait(1)
                    end

                    while getgenv().auto_accept_trade do
                        Trade.AutoAcceptTrade()
                        task.wait(1)
                    end
                end,
            })

            local playerDropdown = TradeTab:CreateDropdown({
                Name = 'Select a player',
                Options = {
                    '',
                },
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
                    local playersTable = Utils.GetPlayersInGame()

                    playerDropdown:Refresh(playersTable)
                end,
            })
            TradeTab:CreateToggle({
                Name = 'Send player Trade',
                CurrentValue = false,
                Flag = 'Toggle1',
                Callback = function(Value)
                    getgenv().auto_trade_semi_auto = Value

                    while getgenv().auto_trade_semi_auto do
                        Trade.SendTradeRequest({selectedPlayer})
                        task.wait(1)
                    end
                end,
            })
            TradeTab:CreateToggle({
                Name = 'Semi-Auto Trade (manually choose items)',
                CurrentValue = false,
                Flag = 'Toggle1',
                Callback = function(Value)
                    getgenv().auto_trade_semi_auto = Value
                end,
            })

            TradeAllInventory = TradeTab:CreateToggle({
                Name = 'Auto Trade EVERYTHING',
                CurrentValue = false,
                Flag = 'Toggle1',
                Callback = function(Value)
                    getgenv().auto_trade_all_inventory = Value

                    while getgenv().auto_trade_all_inventory do
                        Trade.SendTradeRequest({selectedPlayer})
                        Trade.AllInventory('pets')
                        Trade.AllInventory('pet_accessories')
                        Trade.AllInventory('strollers')
                        Trade.AllInventory('food')
                        Trade.AllInventory('transport')
                        Trade.AllInventory('toys')
                        Trade.AllInventory('gifts')

                        local hasPets = Trade.AcceptNegotiationAndConfirm()

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
                        Trade.SendTradeRequest({selectedPlayer})
                        Trade.AllPets()

                        local hasPets = Trade.AcceptNegotiationAndConfirm()

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
                        Trade.SendTradeRequest({selectedPlayer})
                        Trade.FullgrownAndAnyNeonsAndMegas()

                        local hasPets = Trade.AcceptNegotiationAndConfirm()

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
                        Trade.SendTradeRequest({selectedPlayer})
                        Trade.AllPetsOfSameRarity('legendary')

                        local hasPets = Trade.AcceptNegotiationAndConfirm()

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
                        Trade.SendTradeRequest({selectedPlayer})
                        Trade.Fullgrown()

                        local hasPets = Trade.AcceptNegotiationAndConfirm()

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
                        Trade.SendTradeRequest({selectedPlayer})
                        Trade.AllNeons('mega_neon')

                        local hasPets = Trade.AcceptNegotiationAndConfirm()

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
                        Trade.SendTradeRequest({selectedPlayer})
                        Trade.AllNeons('neon')

                        local hasPets = Trade.AcceptNegotiationAndConfirm()

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
                            Trade.SendTradeRequest({selectedPlayer})
                        end

                        Trade.LowTiers()

                        local hasPets = Trade.AcceptNegotiationAndConfirm()

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
                            Trade.SendTradeRequest({selectedPlayer})
                        end

                        Trade.NewbornToPostteen('legendary')

                        local hasPets = Trade.AcceptNegotiationAndConfirm()

                        if not hasPets then
                            RarityToggle:Set(false)
                        end

                        task.wait()
                    end
                end,
            })

            TradeTab:CreateSection('Multiple Choice')

            local petRarityDropdown = TradeTab:CreateDropdown({
                Name = 'Select rarity(s)',
                Options = petRaritys,
                CurrentOption = {},
                MultipleOptions = true,
                Flag = 'Dropdown1',
                Callback = function(Options)
                    multipleOptionsTable['rarity'] = Options
                end,
            })
            local petAgeDropdown = TradeTab:CreateDropdown({
                Name = 'Select pet age(s)',
                Options = petAges,
                CurrentOption = {},
                MultipleOptions = true,
                Flag = 'Dropdown1',
                Callback = function(Options)
                    multipleOptionsTable['ages'] = Options
                end,
            })
            local petNeonDropdown = TradeTab:CreateDropdown({
                Name = 'Select pet normal or neon/mega',
                Options = petNeons,
                CurrentOption = {},
                MultipleOptions = true,
                Flag = 'Dropdown1',
                Callback = function(Options)
                    multipleOptionsTable['neons'] = Options
                end,
            })

            MultipleChoiceToggle = TradeTab:CreateToggle({
                Name = 'START trading multi-choice pets',
                CurrentValue = false,
                Flag = 'Toggle1',
                Callback = function(Value)
                    getgenv().auto_trade_multi_choice = Value

                    if getgenv().auto_trade_multi_choice then
                        if #multipleOptionsTable['rarity'] == 0 then
                            MultipleChoiceToggle:Set(false)

                            return Utils.PrintDebug('\u{1f6d1} didnt select any rarity')
                        end
                        if #multipleOptionsTable['ages'] == 0 then
                            MultipleChoiceToggle:Set(false)

                            return Utils.PrintDebug('\u{1f6d1} didnt select any ages')
                        end
                        if #multipleOptionsTable['neons'] == 0 then
                            MultipleChoiceToggle:Set(false)

                            return Utils.PrintDebug('\u{1f6d1} didnt select normal or neon or mega_neon')
                        end
                    end

                    while getgenv().auto_trade_multi_choice do
                        if not Trade.SendTradeRequest({selectedPlayer}) then
                            Utils.PrintDebug('\u{26a0}\u{fe0f} PLAYER YOU WERE TRADING LEFT GAME \u{26a0}\u{fe0f}')
                            MultipleChoiceToggle:Set(false)

                            return
                        end

                        Trade.MultipleOptions(multipleOptionsTable)

                        local hasPets = Trade.AcceptNegotiationAndConfirm()

                        if not hasPets then
                            MultipleChoiceToggle:Set(false)
                        end

                        task.wait()
                    end

                    petRarityDropdown:Set({
                        '',
                    })
                    petAgeDropdown:Set({
                        '',
                    })
                    petNeonDropdown:Set({
                        '',
                    })

                    return
                end,
            })

            TradeTab:CreateSection('Send Custom Pet, sends ALL ages of selected pet')

            local petsDropdown = TradeTab:CreateDropdown({
                Name = 'Select a Pet',
                Options = {
                    '',
                },
                CurrentOption = {
                    '',
                },
                MultipleOptions = false,
                Flag = 'Dropdown1',
                Callback = function(Option)
                    selectedPet = Option[1] or ''
                end,
            })

            TradeTab:CreateButton({
                Name = 'Refresh Pet list',
                Callback = function()
                    petsDropdown:Refresh(GetInventory.TabId('pets'))
                end,
            })

            PetToggle = TradeTab:CreateToggle({
                Name = 'Auto Trade Selected Pet',
                CurrentValue = false,
                Flag = 'Toggle1',
                Callback = function(Value)
                    getgenv().auto_trade_custom = Value

                    while getgenv().auto_trade_custom do
                        Trade.SendTradeRequest({selectedPlayer})
                        Trade.SelectTabAndTrade('pets', selectedPet)

                        local hasPets = Trade.AcceptNegotiationAndConfirm()

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
                Options = {
                    '',
                },
                CurrentOption = {
                    '',
                },
                MultipleOptions = false,
                Flag = 'Dropdown1',
                Callback = function(Option)
                    selectedGift = Option[1] or 'Nothing'
                end,
            })

            TradeTab:CreateButton({
                Name = 'Refresh Gift list',
                Callback = function()
                    giftsDropdown:Refresh(GetInventory.TabId('gifts'))
                end,
            })

            GiftToggle = TradeTab:CreateToggle({
                Name = 'Auto Trade Custom Gift',
                CurrentValue = false,
                Flag = 'Toggle1',
                Callback = function(Value)
                    getgenv().auto_trade_custom = Value

                    while getgenv().auto_trade_custom do
                        Trade.SendTradeRequest({selectedPlayer})
                        Trade.SelectTabAndTrade('gifts', selectedGift)

                        local hasPets = Trade.AcceptNegotiationAndConfirm()

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
                Options = {
                    '',
                },
                CurrentOption = {
                    '',
                },
                MultipleOptions = false,
                Flag = 'Dropdown1',
                Callback = function(Option)
                    selectedToy = Option[1] or 'Nothing'
                end,
            })

            TradeTab:CreateButton({
                Name = 'Refresh Toy list',
                Callback = function()
                    toysDropdown:Refresh(GetInventory.TabId('toys'))
                end,
            })

            ToyToggle = TradeTab:CreateToggle({
                Name = 'Auto Trade Custom Toy',
                CurrentValue = false,
                Flag = 'Toggle1',
                Callback = function(Value)
                    getgenv().auto_trade_custom = Value

                    while getgenv().auto_trade_custom do
                        Trade.SendTradeRequest({selectedPlayer})
                        Trade.SelectTabAndTrade('toys', selectedToy)

                        local hasPets = Trade.AcceptNegotiationAndConfirm()

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
                Options = {
                    '',
                },
                CurrentOption = {
                    '',
                },
                MultipleOptions = false,
                Flag = 'Dropdown1',
                Callback = function(Option)
                    selectedFood = Option[1] or 'Nothing'
                end,
            })

            TradeTab:CreateButton({
                Name = 'Refresh Food list',
                Callback = function()
                    foodDropdown:Refresh(GetInventory.TabId('food'))
                end,
            })

            FoodToggle = TradeTab:CreateToggle({
                Name = 'Auto Trade Custom Food',
                CurrentValue = false,
                Flag = 'Toggle1',
                Callback = function(Value)
                    getgenv().auto_trade_custom = Value

                    while getgenv().auto_trade_custom do
                        Trade.SendTradeRequest({selectedPlayer})
                        Trade.SelectTabAndTrade('food', selectedFood)

                        local hasPets = Trade.AcceptNegotiationAndConfirm()

                        if not hasPets then
                            FoodToggle:Set(false)
                        end

                        task.wait()
                    end
                end,
            })

            local ageUpPotionTab = Window:CreateTab('Age Up Potion', 4483362458)
            local petToAge = ageUpPotionTab:CreateDropdown({
                Name = 'Select pet to age',
                Options = {
                    '',
                },
                CurrentOption = {
                    '',
                },
                MultipleOptions = false,
                Flag = 'Dropdown1',
                Callback = function(Options)
                    selectedAgeablePet = Options[1]
                end,
            })

            ageUpPotionTab:CreateSlider({
                Name = 'How many to age up',
                Range = {1, 100},
                Increment = 1,
                Suffix = 'Mega Pets',
                CurrentValue = 100,
                Flag = 'Slider1',
                Callback = function(Value)
                    selectedAgeableNumber = Value
                end,
            })
            ageUpPotionTab:CreateButton({
                Name = 'Refresh pet list',
                Callback = function()
                    petToAge:Refresh(GetInventory.GetAgeablePets())
                end,
            })
            ageUpPotionTab:CreateDivider()
            ageUpPotionTab:CreateButton({
                Name = 'START aging pet',
                Callback = function()
                    if cooldown then
                        return
                    end

                    cooldown = true

                    localPlayer:SetAttribute('StopFarmingTemp', true)
                    BulkPotion.StartAgingPets({
                        {
                            NameId = selectedAgeablePet,
                            MaxAmount = selectedAgeableNumber,
                        },
                    })
                    task.wait(1)
                    localPlayer:SetAttribute('StopFarmingTemp', false)

                    cooldown = false
                end,
            })
        end

        function self.Init() end
        function self.Start()
            task.defer(function()
                setupRayfield()
                Rayfield:SetVisibility(false)  --- RayField UI Visibility ----
            end)
        end

        return self
    end
end

if not game:IsLoaded() then
    game.Loaded:Wait()
end
if game.PlaceId ~= 920587237 then
    return
end
--setfpscap(getgenv().SETTINGS.SET_FPS or 2)

local ReplicatedStorage = cloneref(game:GetService('ReplicatedStorage'))
local Players = cloneref(game:GetService('Players'))
local UserGameSettings = UserSettings():GetService('UserGameSettings')

UserGameSettings.GraphicsQualityLevel = 1
UserGameSettings.MasterVolume = 8

local Bypass = (require(ReplicatedStorage:WaitForChild('Fsys')).load)
local RouterClient = (Bypass('RouterClient'))
local localPlayer = Players.LocalPlayer
local NewsApp = (localPlayer:WaitForChild('PlayerGui'):WaitForChild('NewsApp'))

local StatsGuis = loadstring(game:HttpGet("https://raw.githubusercontent.com/Nocrazypc/Project-BLN/refs/heads/main/Stats.lua"))()

if not NewsApp.Enabled then
    repeat
        task.wait(5)
    until NewsApp.Enabled or localPlayer.Character
end

for i, v in debug.getupvalue(RouterClient.init, 7)do
    v.Name = i
end

getgenv().auto_accept_trade = false
getgenv().auto_trade_all_pets = false
getgenv().auto_trade_fullgrown_neon_and_mega = false
getgenv().auto_trade_multi_choice = false
getgenv().auto_trade_custom = false
getgenv().auto_trade_semi_auto = false
getgenv().auto_trade_lowtier_pets = false
getgenv().auto_trade_rarity_pets = false
getgenv().auto_make_neon = false
getgenv().auto_trade_Legendary = false
getgenv().auto_trade_custom_gifts = false
getgenv().auto_trade_all_neons = false
getgenv().auto_trade_eggs = false
getgenv().auto_trade_all_inventory = false
getgenv().feedAgeUpPotionToggle = false
getgenv().petCurrentlyFarming1 = nil
getgenv().petCurrentlyFarming2 = nil
Utils = __DARKLUA_BUNDLE_MODULES.load('a')

getgenv().auto_farm = true
getgenv().AutoFusion = false
getgenv().FocusFarmAgePotions = true
getgenv().HatchPriorityEggs = false

getgenv().ENABLE_RELEASE_PETS = false
--getgenv().PETS_TO_AGE_IN_PEN = {}

getgenv().AutoMinigame = false
getgenv().AutoMinigame2 = false

local files = {
    {
        PrepareAccountHandler = __DARKLUA_BUNDLE_MODULES.load('k'),
    },
    {
        DailyRewardHandler = __DARKLUA_BUNDLE_MODULES.load('l'),
    },
    {
        GameGuiHandler = __DARKLUA_BUNDLE_MODULES.load('m'),
    },
    {
        PotatoModeHandler = __DARKLUA_BUNDLE_MODULES.load('n'),
    },
    {
        TradeLicenseHandler = __DARKLUA_BUNDLE_MODULES.load('o'),
    },
    {
        TutorialHandler = __DARKLUA_BUNDLE_MODULES.load('p'),
    },
    -- {
       -- WebhookHandler = __DARKLUA_BUNDLE_MODULES.load('q'),
    -- },
    {
        AutoFarmHandler = __DARKLUA_BUNDLE_MODULES.load('u'),
    },
    {
        PetOfflineHandler = __DARKLUA_BUNDLE_MODULES.load('w'),
    },
	-------------------------------------------------------------
    {
       RayfieldHandler = __DARKLUA_BUNDLE_MODULES.load('B'),
    },
    {
        TaskBoardHandler = __DARKLUA_BUNDLE_MODULES.load('C'),
    },
}

Utils.PrintDebug('----- INITIALIZING MODULES -----')

for index, _table in ipairs(files)do
    for moduleName, _ in _table do
        if files[index][moduleName].Init then
            Utils.PrintDebug(string.format('INITIALIZING: %s', tostring(moduleName)))
            files[index][moduleName].Init()
            task.wait(1)
        end
    end
end

Utils.PrintDebug('----- STARTING MODULES -----')

for index, _table in ipairs(files)do
    for moduleName, _ in _table do
        if files[index][moduleName].Start then
            Utils.PrintDebug(string.format('STARTING: %s', tostring(moduleName)))
            files[index][moduleName].Start()
            task.wait(1)
        end
    end
end



-------------- Autostart some toggled options for Feli---------------------
-------- Low Render- Hide parts ------------
task.spawn(function()
        
for i,v in pairs(game:GetService("Workspace").Interiors:GetDescendants()) do
    if v:IsA("BasePart") then
        v.Transparency = 1 
    elseif not v:IsA("BasePart") then
        v.Transparency = 0 
    end 
end 

game:GetService("Workspace").Interiors.DescendantAdded:Connect(function(v)
    if v:IsA('BasePart') then
        v.Transparency = 1 
    end 
end)
end)
--------Transitions Remover -------------
pcall(function() 
    require(game.ReplicatedStorage.ClientModules.Core.UIManager.Apps.TransitionsApp).transition = function() return end 
    require(game.ReplicatedStorage.ClientModules.Core.UIManager.Apps.TransitionsApp).sudden_fill = function() return end
    if Player.PlayerGui:FindFirstChild("TransitionsApp") then
        Player.PlayerGui.TransitionsApp:FindFirstChild("Whiteout").Visible = false
    end
end)

------ Updater Stats Gui ---------------
StatsGuis:UpdateText("NameFrame")
        task.spawn(function()
            while task.wait() do
			StatsGuis:UpdateText("TimeFrame")
			StatsGuis:UpdateText("BucksAndPotionFrame")
            StatsGuis:UpdateText("TotalFrame")
            StatsGuis:UpdateText("TotalFrame1")
            --StatsGuis:UpdateText("TotalFrame2")
            task.wait(5) 
            end
        end)
-----------------------------------------
