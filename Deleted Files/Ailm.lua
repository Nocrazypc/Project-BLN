        local ReplicatedStorage = game:GetService('ReplicatedStorage')
        local Workspace = game:GetService('Workspace')
        local Players = game:GetService('Players')
        local ClientData = require(ReplicatedStorage:WaitForChild('ClientModules'):WaitForChild('Core'):WaitForChild('ClientData'))
        local GetInventory = loadstring(game:HttpGet("https://raw.githubusercontent.com/Nocrazypc/Project-BLN/refs/heads/main/GetInv.lua"))()
        local Teleport = loadstring(game:HttpGet("https://raw.githubusercontent.com/Nocrazypc/Project-BLN/refs/heads/main/Tele.lua"))()
        local localPlayer = Players.LocalPlayer
        local doctorId = nil
        local Ailments = {}

        local function FoodAilments(FoodPassOn)
            local hasFood = false

            for _, v in ClientData.get_data()[localPlayer.Name].inventory.food do
                if v.id == FoodPassOn then
                    hasFood = true

                    if not ClientData.get('pet_char_wrappers')[1] then
                        print('\u{26a0}\u{fe0f} Trying to feed pet but no pet equipped \u{26a0}\u{fe0f}')
                        return
                    end
                        
                    if not ClientData.get('pet_char_wrappers')[1].pet_unique then
                        return
                    end

                    local args = {
                        [1] = '__Enum_PetObjectCreatorType_2',
                        [2] = {
                            ['pet_unique'] = ClientData.get('pet_char_wrappers')[1].pet_unique,
                            ['unique_id'] = v.unique,
                        },
                    }

                    ReplicatedStorage.API['PetObjectAPI/CreatePetObject']:InvokeServer(unpack(args))

                    return
                end
            end

            if not hasFood then
                ReplicatedStorage.API['ShopAPI/BuyItem']:InvokeServer('food', FoodPassOn, {})
                task.wait(5)
                FoodAilments(FoodPassOn)
            end
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
                    task.wait(1)

                    doctor = Workspace.HouseInteriors.furniture:FindFirstChild('Doctor', true)

                    stuckCount += 1

                    isStuck = if stuckCount > 30 then true else false
                until doctor or isStuck
            end
            if isStuck then
                return false
            end

            return true
        end
        local getDoctorId = function()
            if doctorId then
                print(`Doctor Id: {doctorId}`)

                return
            end

            local stuckCount = 0
            local isStuck = false

            ReplicatedStorage.API['LocationAPI/SetLocation']:FireServer('Hospital')
            task.wait(1)

            local doctor = Workspace.HouseInteriors.furniture:FindFirstChild('Doctor', true)

            if not doctor then
                repeat
                    task.wait(1)

                    doctor = Workspace.HouseInteriors.furniture:FindFirstChild('Doctor', true)

                    stuckCount += 1

                    isStuck = if stuckCount > 30 then true else false
                until doctor or isStuck
            end
            if isStuck then
                return
            end
            if doctor then
                doctorId = doctor:GetAttribute('furniture_unique')
            end
        end
        local useStroller = function()
            local args = {
                [1] = ClientData.get('pet_char_wrappers')[1].char,
                [2] = localPlayer.Character.StrollerTool.ModelHandle.TouchToSits.TouchToSit,
            }

            ReplicatedStorage.API:FindFirstChild('AdoptAPI/UseStroller'):InvokeServer(unpack(args))
        end
        local babyJump = function()
            if localPlayer.Character.Humanoid:GetState() == Enum.HumanoidStateType.Freefall then
                return
            end

            localPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
        end
        local function getUpFromSitting()
            ReplicatedStorage.API['AdoptAPI/ExitSeatStates']:FireServer()
            task.wait(0.1)
        end

        local function reEquipPet()
            local hasPetChar = false
            local EquipTimeout = 0

            ReplicatedStorage.API['ToolAPI/Unequip']:InvokeServer(ClientData.get_data()[localPlayer.Name].last_equipped_pets[1], {})
            task.wait(1)
            ReplicatedStorage.API['ToolAPI/Equip']:InvokeServer(ClientData.get_data()[localPlayer.Name].last_equipped_pets[1], {})

            repeat
                task.wait(1)

                hasPetChar = if ClientData.get('pet_char_wrappers')[1] and ClientData.get('pet_char_wrappers')[1]['char']then true else false

                EquipTimeout += 1
            until hasPetChar or EquipTimeout >= 10

            if EquipTimeout >= 10 then
                reEquipPet()
            end
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
            local ailmentsList = {}

            for i, _ in ClientData.get_data()[localPlayer.Name].ailments_manager.ailments[petUnique][mysteryId]['components']['mystery']['components']do
                table.insert(ailmentsList, i)
            end

            for i = 1, 3 do
                for _, ailment in ailmentsList do
                    ReplicatedStorage.API['AilmentsAPI/ChooseMysteryAilment']:FireServer(mysteryId, i, ailment)
                    task.wait(3)

                    if not ClientData.get_data()[localPlayer.Name].ailments_manager.ailments[petUnique][mysteryId] then
                        return
                    end
                end
            end
        end
        local waitForTaskToFinish = function(ailment, petUnique)
            local count = 0

            repeat
                task.wait(5)

                local taskActive = if ClientData.get_data()[localPlayer.Name].ailments_manager.ailments[petUnique] and ClientData.get_data()[localPlayer.Name].ailments_manager.ailments[petUnique][ailment]then true else false

                count += 5
            until not taskActive or count >= 60

            if count >= 60 then
            end
        end
        local waitForJumpingToFinish = function(ailment, petUnique)
            local stuckCount = tick()
            local isStuck = false

            repeat
                babyJump()
                task.wait(0.2)

                local taskActive = if ClientData.get_data()[localPlayer.Name].ailments_manager.ailments[petUnique] and ClientData.get_data()[localPlayer.Name].ailments_manager.ailments[petUnique][ailment]then true else false

                task.wait(0.1)

                isStuck = if(tick() - stuckCount) >= 120 then true else false
            until not taskActive or isStuck
        end
        local babyWaitForTaskToFinish = function(ailment)
            local count = 0

            repeat
                task.wait(5)

                local taskActive = if ClientData.get_data()[localPlayer.Name].ailments_manager.baby_ailments and ClientData.get_data()[localPlayer.Name].ailments_manager.baby_ailments[ailment]then true else false

                count += 5
            until not taskActive or count >= 60
        end

        function Ailments:HungryAilment()
            reEquipPet()
            FoodAilments('icecream')
        end
        function Ailments:ThirstyAilment()
            reEquipPet()
            FoodAilments('water')
        end
        function Ailments:SickAilment()
            if doctorId then
                ReplicatedStorage.API['LocationAPI/SetLocation']:FireServer('Hospital')

                if not isDoctorLoaded() then
                    print(`\u{1fa79}\u{26a0}\u{fe0f} Doctor didnt load \u{1fa79}\u{26a0}\u{fe0f}`)

                    return
                end

                local args = {
                    [1] = doctorId,
                    [2] = 'UseBlock',
                    [3] = 'Yes',
                    [4] = game:GetService('Players').LocalPlayer.Character,
                }

                ReplicatedStorage.API:FindFirstChild('HousingAPI/ActivateInteriorFurniture'):InvokeServer(unpack(args))
            else
                getDoctorId()
            end
        end
        function Ailments:SalonAilment(ailment, petUnique)
            reEquipPet()
            ReplicatedStorage.API['LocationAPI/SetLocation']:FireServer('Salon')
            waitForTaskToFinish(ailment, petUnique)
        end
        function Ailments:PizzaPartyAilment(ailment, petUnique)
            reEquipPet()
            ReplicatedStorage.API['LocationAPI/SetLocation']:FireServer('PizzaShop')
            waitForTaskToFinish(ailment, petUnique)
        end
        function Ailments:SchoolAilment(ailment, petUnique)
            reEquipPet()
            ReplicatedStorage.API['LocationAPI/SetLocation']:FireServer('School')
            waitForTaskToFinish(ailment, petUnique)
        end
        function Ailments:BoredAilment(pianoId, petUnique)
            reEquipPet()

            if pianoId then
                if not ClientData.get('pet_char_wrappers')[1] and ClientData.get('pet_char_wrappers')[1]['char'] then
                    return
                end

                PianoAilment(pianoId, ClientData.get('pet_char_wrappers')[1]['char'])
            else
                Teleport.PlayGround(Vector3.new(20, 10, math.random(15, 30)))
            end

            waitForTaskToFinish('bored', petUnique)
        end
        function Ailments:SleepyAilment(bedId, petUnique)
            reEquipPet()

            if not ClientData.get('pet_char_wrappers')[1] and ClientData.get('pet_char_wrappers')[1]['char'] then
                return
            end

            furnitureAilments(bedId, ClientData.get('pet_char_wrappers')[1]['char'])
            waitForTaskToFinish('sleepy', petUnique)
        end
        function Ailments:DirtyAilment(showerId, petUnique)
            reEquipPet()

            if not ClientData.get('pet_char_wrappers')[1] and ClientData.get('pet_char_wrappers')[1]['char'] then
                return
            end

            furnitureAilments(showerId, ClientData.get('pet_char_wrappers')[1]['char'])
            waitForTaskToFinish('dirty', petUnique)
        end
        function Ailments:ToiletAilment(litterBoxId, petUnique)
            reEquipPet()

            if litterBoxId then
                if not ClientData.get('pet_char_wrappers')[1] and ClientData.get('pet_char_wrappers')[1]['char'] then
                    return
                end

                furnitureAilments(litterBoxId, ClientData.get('pet_char_wrappers')[1]['char'])
            else
                Teleport.DownloadMainMap()
                task.wait(5)

                localPlayer.Character.HumanoidRootPart.CFrame = Workspace.HouseInteriors.furniture:FindFirstChild('AilmentsRefresh2024FireHydrant', true).PrimaryPart.CFrame + Vector3.new(5, 5, 5)

                task.wait(2)
                reEquipPet()
            end

            waitForTaskToFinish('toilet', petUnique)
        end
        function Ailments:BeachPartyAilment(petUnique)
            ReplicatedStorage.API['ToolAPI/Unequip']:InvokeServer(ClientData.get_data()[localPlayer.Name].last_equipped_pets[1], {})
            Teleport.BeachParty()
            task.wait(2)
            ReplicatedStorage.API['ToolAPI/Equip']:InvokeServer(ClientData.get_data()[localPlayer.Name].last_equipped_pets[1], {})
            waitForTaskToFinish('beach_party', petUnique)
        end
        function Ailments:CampingAilment(petUnique)
            ReplicatedStorage.API['ToolAPI/Unequip']:InvokeServer(ClientData.get_data()[localPlayer.Name].last_equipped_pets[1], {})
            Teleport.CampSite()
            task.wait(2)
            ReplicatedStorage.API['ToolAPI/Equip']:InvokeServer(ClientData.get_data()[localPlayer.Name].last_equipped_pets[1], {})
            waitForTaskToFinish('camping', petUnique)
        end
        function Ailments:WalkAilment(petUnique)
            reEquipPet()

            if not ClientData.get('pet_char_wrappers')[1] and ClientData.get('pet_char_wrappers')[1]['char'] then
                return
            end

            ReplicatedStorage.API['AdoptAPI/HoldBaby']:FireServer(ClientData.get('pet_char_wrappers')[1]['char'])
            waitForJumpingToFinish('walk', petUnique)

            if not ClientData.get('pet_char_wrappers')[1] and ClientData.get('pet_char_wrappers')[1]['char'] then
                return
            end

            ReplicatedStorage.API:FindFirstChild('AdoptAPI/EjectBaby'):FireServer(ClientData.get('pet_char_wrappers')[1]['char'])
        end
        function Ailments:RideAilment(strollerId, petUnique)
            reEquipPet()
            ReplicatedStorage.API:FindFirstChild('ToolAPI/Equip'):InvokeServer(strollerId, {})
            task.wait(1)
            useStroller()
            waitForJumpingToFinish('ride', petUnique)

            if not ClientData.get('pet_char_wrappers')[1] and ClientData.get('pet_char_wrappers')[1]['char'] then
                return
            end

            ReplicatedStorage.API:FindFirstChild('AdoptAPI/EjectBaby'):FireServer(ClientData.get('pet_char_wrappers')[1]['char'])
        end
        function Ailments:PlayAilment(ailment, petUnique)
            reEquipPet()

            local toyId = GetInventory:GetUniqueId('toys', 'raw_bone')

            if not toyId then
                ReplicatedStorage.API:FindFirstChild('ShopAPI/BuyItem'):InvokeServer('toys', 'raw_bone', {})
                task.wait(3)

                toyId = GetInventory:GetUniqueId('toys', 'raw_bone')

                if not toyId then
                    print(`\u{26a0}\u{fe0f} Doesn't have raw bone so exiting \u{26a0}\u{fe0f}`)

                    return
                end
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
                ReplicatedStorage.API:FindFirstChild('PetObjectAPI/CreatePetObject'):InvokeServer(unpack(args))
                task.wait(10)

                local taskActive = if ClientData.get_data()[localPlayer.Name].ailments_manager.ailments[petUnique] and ClientData.get_data()[localPlayer.Name].ailments_manager.ailments[petUnique][ailment]then true else false

                count += 1
            until not taskActive or count >= 6

            if count >= 6 then
                reEquipPet()

                return
            end
        end
        function Ailments:MysteryAilment(mysteryId, petUnique)
            pickMysteryTask(mysteryId, petUnique)
        end
        function Ailments:BabyHungryAilment()
            local stuckCount = 0

            repeat
                babyGetFoodAndEat('icecream')

                stuckCount += 1

                task.wait(1)
            until not ClientData.get_data()[localPlayer.Name].ailments_manager.baby_ailments['hungry'] or stuckCount >= 30
        end
        function Ailments:BabyThirstyAilment()
            local stuckCount = 0

            repeat
                babyGetFoodAndEat('water')

                stuckCount += 1

                task.wait(1)
            until not ClientData.get_data()[localPlayer.Name].ailments_manager.baby_ailments['thirsty'] or stuckCount >= 30
        end
        function Ailments:BabyBoredAilment(pianoId)
            getUpFromSitting()

            if pianoId then
                PianoAilment(pianoId, localPlayer.Character)
            else
                Teleport.PlayGround(Vector3.new(20, 10, math.random(15, 30)))
            end

            babyWaitForTaskToFinish('bored')
            getUpFromSitting()
        end
        function Ailments:BabySleepyAilment(bedId)
            getUpFromSitting()
            furnitureAilments(bedId, localPlayer.Character)
            babyWaitForTaskToFinish('sleepy')
            getUpFromSitting()
        end
        function Ailments:BabyDirtyAilment(showerId)
            getUpFromSitting()
            furnitureAilments(showerId, localPlayer.Character)
            babyWaitForTaskToFinish('dirty')
            getUpFromSitting()
        end

        return Ailments
