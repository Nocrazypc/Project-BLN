        local ReplicatedStorage = game:GetService('ReplicatedStorage')
        local Workspace = game:GetService('Workspace')
        local Players = game:GetService('Players')
        local Misc = loadstring(game:HttpGet("https://raw.githubusercontent.com/Nocrazypc/Project-BLN/refs/heads/main/Misc.lua"))()
        local Bypass = require(ReplicatedStorage:WaitForChild('Fsys')).load
        local ClientData = require(ReplicatedStorage:WaitForChild('ClientModules'):WaitForChild('Core'):WaitForChild('ClientData'))
        local GetInventory = loadstring(game:HttpGet("https://raw.githubusercontent.com/Nocrazypc/Project-BLN/refs/heads/main/GetInv.lua"))()
        local Teleport = loadstring(game:HttpGet("https://raw.githubusercontent.com/Nocrazypc/Project-BLN/refs/heads/main/Tele.lua"))()
        local localPlayer = Players.LocalPlayer
        local doctorId = nil
        local Ailments = {}

        Ailments.whichPet = 1

        local checkPetEquipped = function()
            if ClientData.get('pet_char_wrappers') and ClientData.get('pet_char_wrappers')[Ailments.whichPet] and ClientData.get('pet_char_wrappers')[Ailments.whichPet]['char'] then
                return true
            end

            return false
        end
        local consumeFood = function()
            local foodItem = Workspace.PetObjects:WaitForChild(tostring(Workspace.PetObjects:FindFirstChildWhichIsA('Model')), 10)

            if not foodItem then
                print('NO food item in workspace')

                return
            end
            if not checkPetEquipped() then
                return
            end

            ReplicatedStorage.API['PetAPI/ConsumeFoodObject']:FireServer(foodItem, ClientData.get('pet_char_wrappers')[Ailments.whichPet].pet_unique)
        end

        local function FoodAilments(FoodPassOn)
            local hasFood = false

            for _, v in ClientData.get_data()[localPlayer.Name].inventory.food do
                if v.id == FoodPassOn then
                    hasFood = true

                    if not checkPetEquipped() then
                        Misc.DebugModePrint('\u{26a0}\u{fe0f} Trying to feed pet but no pet equipped \u{26a0}\u{fe0f}')

                        return
                    end

                    local args = {
                        [1] = '__Enum_PetObjectCreatorType_2',
                        [2] = {
                            ['pet_unique'] = ClientData.get('pet_char_wrappers')[Ailments.whichPet].pet_unique,
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
                task.wait(1)
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
                    stuckCount = stuckCount + 1
                    isStuck = stuckCount > 30 and true or false
                until doctor or isStuck
            end
            if isStuck then
                Misc.DebugModePrint("\u{26a0}\u{fe0f} Wasn't able to find Doctor Id \u{26a0}\u{fe0f}")

                return false
            end

            return true
        end
        local getDoctorId = function()
            if doctorId then
                Misc.DebugModePrint(string.format('Doctor Id: %s', tostring(doctorId)))

                return
            end

            Misc.DebugModePrint('\u{1fa79} Getting Doctor ID \u{1fa79}')

            local stuckCount = 0
            local isStuck = false

            ReplicatedStorage.API['LocationAPI/SetLocation']:FireServer('Hospital')
            task.wait(1)

            local doctor = Workspace.HouseInteriors.furniture:FindFirstChild('Doctor', true)

            if not doctor then
                repeat
                    task.wait(1)

                    doctor = Workspace.HouseInteriors.furniture:FindFirstChild('Doctor', true)
                    stuckCount = stuckCount + 1
                    isStuck = stuckCount > 30 and true or false
                until doctor or isStuck
            end
            if isStuck then
                Misc.DebugModePrint("\u{26a0}\u{fe0f} Wasn't able to find Doctor Id \u{26a0}\u{fe0f}")

                return
            end
            if doctor then
                doctorId = doctor:GetAttribute('furniture_unique')

                if doctorId then
                    Misc.DebugModePrint(string.format('Found doctor Id: %s', tostring(doctorId)))
                end
            end
        end
        local useStroller = function()
            local strollerTool = localPlayer.Character:FindFirstChild('StrollerTool')

            if not strollerTool then
                return false
            end

            local args = {
                [1] = ClientData.get('pet_char_wrappers')[Ailments.whichPet].char,
                [2] = localPlayer.Character.StrollerTool.ModelHandle.TouchToSits.TouchToSit,
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
            task.wait(1)
            Misc.DebugModePrint('Exited from seat')
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
            Misc.DebugModePrint(string.format('mystery id: %s', tostring(mysteryId)))

            local ailmentsList = {}

            for i, _ in ClientData.get_data()[localPlayer.Name].ailments_manager.ailments[petUnique][mysteryId]['components']['mystery']['components']do
                table.insert(ailmentsList, i)
            end

            for i = 1, 3 do
                for _, ailment in ailmentsList do
                    Misc.DebugModePrint(string.format('card: %s, ailment: %s', tostring(i), tostring(ailment)))
                    ReplicatedStorage.API['AilmentsAPI/ChooseMysteryAilment']:FireServer(petUnique, 'mystery', i, ailment)
                    task.wait(3)

                    if not ClientData.get_data()[localPlayer.Name].ailments_manager.ailments[petUnique][mysteryId] then
                        Misc.DebugModePrint(string.format('\u{1f449} Picked %s ailment from mystery card \u{1f448}', tostring(ailment)))

                        return
                    end
                end
            end
        end
        local waitForTaskToFinish = function(ailment, petUnique)
            Misc.DebugModePrint(string.format('\u{23f3} Waiting for %s to finish \u{23f3}', tostring(string.upper(ailment))))

            local count = 0

            repeat
                task.wait(5)

                local taskActive = ClientData.get_data()[localPlayer.Name].ailments_manager.ailments[petUnique] and ClientData.get_data()[localPlayer.Name].ailments_manager.ailments[petUnique][ailment] and true or false

                count = count + 5
            until not taskActive or count >= 60

            if count >= 60 then
                Misc.DebugModePrint(string.format('\u{26a0}\u{fe0f} Waited too long for ailment: %s, must be stuck \u{26a0}\u{fe0f}', tostring(ailment)))
                Misc.ReEquipPet(1)
                Misc.ReEquipPet(2)
            else
                Misc.DebugModePrint(string.format('\u{1f389} %s task finished \u{1f389}', tostring(ailment)))
            end
        end
        local waitForJumpingToFinish = function(ailment, petUnique)
            Misc.DebugModePrint(string.format('\u{23f3} Waiting for %s to finish \u{23f3}', tostring(string.upper(ailment))))

            local stuckCount = tick()
            local isStuck = false

            repeat
                babyJump()
                task.wait(0.2)

                local taskActive = ClientData.get_data()[localPlayer.Name].ailments_manager.ailments[petUnique] and ClientData.get_data()[localPlayer.Name].ailments_manager.ailments[petUnique][ailment] and true or false

                task.wait(0.1)

                isStuck = (tick() - stuckCount) >= 120 and true or false
            until not taskActive or isStuck

            if isStuck then
                Misc.DebugModePrint(string.format('\u{26d4} %s ailment is stuck so exiting task \u{26d4}', tostring(ailment)))
            else
                Misc.DebugModePrint(string.format('\u{1f389} %s ailment finished \u{1f389}', tostring(ailment)))
            end
        end
        local babyWaitForTaskToFinish = function(ailment)
            Misc.DebugModePrint(string.format('\u{23f3} Waiting for BABY %s to finish \u{23f3}', tostring(string.upper(ailment))))

            local count = 0

            repeat
                task.wait(5)

                local taskActive = ClientData.get_data()[localPlayer.Name].ailments_manager.baby_ailments and ClientData.get_data()[localPlayer.Name].ailments_manager.baby_ailments[ailment] and true or false

                count = count + 5
            until not taskActive or count >= 60

            if count >= 60 then
                Misc.DebugModePrint(string.format('\u{26a0}\u{fe0f} Waited too long for ailment: %s, must be stuck \u{26a0}\u{fe0f}', tostring(ailment)))
            else
                Misc.DebugModePrint(string.format('\u{1f389} %s task finished \u{1f389}', tostring(string.upper(ailment))))
            end
        end

        function Ailments:HungryAilment()
            Misc.DebugModePrint(string.format('\u{1f356} Doing hungry task on %s \u{1f356}', tostring(Ailments.whichPet)))
            Misc.ReEquipPet(Ailments.whichPet)
            FoodAilments('icecream')
            Misc.DebugModePrint(string.format('\u{1f356} Finished hungry task on %s \u{1f356}', tostring(Ailments.whichPet)))
        end
        function Ailments:ThirstyAilment()
            Misc.DebugModePrint(string.format('\u{1f95b} Doing thirsty task on %s \u{1f95b}', tostring(Ailments.whichPet)))
            Misc.ReEquipPet(Ailments.whichPet)
            FoodAilments('water')
            Misc.DebugModePrint(string.format('\u{1f95b} Finished thirsty task on %s \u{1f95b}', tostring(Ailments.whichPet)))
        end
        function Ailments:SickAilment()
            Misc.ReEquipPet(Ailments.whichPet)

            if doctorId then
                Misc.DebugModePrint(string.format('\u{1fa79} Doing sick task on %s \u{1fa79}', tostring(Ailments.whichPet)))
                ReplicatedStorage.API['LocationAPI/SetLocation']:FireServer('Hospital')

                if not isDoctorLoaded() then
                    Misc.DebugModePrint(string.format('\u{1fa79}\u{26a0}\u{fe0f} Doctor didnt load on %s \u{1fa79}\u{26a0}\u{fe0f}', tostring(Ailments.whichPet)))

                    return
                end

                local args = {
                    [1] = doctorId,
                    [2] = 'UseBlock',
                    [3] = 'Yes',
                    [4] = game:GetService('Players').LocalPlayer.Character,
                }

                ReplicatedStorage.API:FindFirstChild('HousingAPI/ActivateInteriorFurniture'):InvokeServer(unpack(args))
                Misc.DebugModePrint(string.format('\u{1fa79} SICK task Finished on %s \u{1fa79}', tostring(Ailments.whichPet)))
            else
                getDoctorId()
            end
        end
        function Ailments:PetMeAilment()
            Misc.ReEquipPet(Ailments.whichPet)
            Misc.DebugModePrint(string.format('\u{1f431} Doing pet me task on %s \u{1f431}', tostring(Ailments.whichPet)))

            if not checkPetEquipped() then
                return
            end

            ReplicatedStorage.API['AdoptAPI/FocusPet']:FireServer(ClientData.get('pet_char_wrappers')[Ailments.whichPet].char)
            task.wait(1)

            if not checkPetEquipped() then
                return
            end

            ReplicatedStorage.API['PetAPI/ReplicateActivePerformances']:FireServer(ClientData.get('pet_char_wrappers')[Ailments.whichPet].char, {
                ['FocusPet'] = true,
                ['Petting'] = true,
            })
            task.wait(1)

            if not checkPetEquipped() then
                return
            end

            Bypass('RouterClient').get('AilmentsAPI/ProgressPetMeAilment'):FireServer(ClientData.get('pet_char_wrappers')[Ailments.whichPet].pet_unique)
            Misc.DebugModePrint('\u{1f431} RAN PETME AILMENT \u{1f431}')
        end
        function Ailments:SalonAilment(ailment, petUnique)
            Misc.ReEquipPet(Ailments.whichPet)
            Misc.DebugModePrint(string.format('\u{1f457} Doing salon task on %s \u{1f457}', tostring(Ailments.whichPet)))
            ReplicatedStorage.API['LocationAPI/SetLocation']:FireServer('Salon')
            waitForTaskToFinish(ailment, petUnique)
            Misc.DebugModePrint(string.format('\u{1f457} Finished salon task on %s \u{1f457}', tostring(Ailments.whichPet)))
        end
        function Ailments:MoonAilment(ailment, petUnique)
            Misc.ReEquipPet(Ailments.whichPet)
            Misc.DebugModePrint(string.format('\u{1f31a} Doing moon task on %s \u{1f31a}', tostring(Ailments.whichPet)))
            ReplicatedStorage.API['LocationAPI/SetLocation']:FireServer('MoonInterior')
            waitForTaskToFinish(ailment, petUnique)
            Misc.DebugModePrint(string.format('\u{1f31a} Doing moon task on %s \u{1f31a}', tostring(Ailments.whichPet)))
        end
        function Ailments:PizzaPartyAilment(ailment, petUnique)
            Misc.ReEquipPet(Ailments.whichPet)
            Misc.DebugModePrint(string.format('\u{1f355} Doing pizza party task on %s \u{1f355}', tostring(Ailments.whichPet)))
            ReplicatedStorage.API['LocationAPI/SetLocation']:FireServer('PizzaShop')
            waitForTaskToFinish(ailment, petUnique)
            Misc.DebugModePrint(string.format('\u{1f355} Finished pizza party task on %s \u{1f355}', tostring(Ailments.whichPet)))
        end
        function Ailments:SchoolAilment(ailment, petUnique)
            Misc.ReEquipPet(Ailments.whichPet)
            Misc.DebugModePrint(string.format('\u{1f3eb} Doing school task on %s \u{1f3eb}', tostring(Ailments.whichPet)))
            ReplicatedStorage.API['LocationAPI/SetLocation']:FireServer('School')
            waitForTaskToFinish(ailment, petUnique)
            Misc.DebugModePrint(string.format('\u{1f3eb} Finished school task on %s \u{1f3eb}', tostring(Ailments.whichPet)))
        end
        function Ailments:BoredAilment(pianoId, petUnique)
            Misc.ReEquipPet(Ailments.whichPet)
            Misc.DebugModePrint(string.format('\u{1f971} Doing bored task on %s \u{1f971}', tostring(Ailments.whichPet)))

            if pianoId then
                if not checkPetEquipped() then
                    return
                end

                PianoAilment(pianoId, ClientData.get('pet_char_wrappers')[Ailments.whichPet]['char'])
            else
                Teleport.PlayGround(Vector3.new(20, 10, math.random(15, 30)))
            end

            waitForTaskToFinish('bored', petUnique)
            Misc.DebugModePrint(string.format('\u{1f971} Finished bored task on %s \u{1f971}', tostring(Ailments.whichPet)))
        end
        function Ailments:SleepyAilment(bedId, petUnique)
            Misc.ReEquipPet(Ailments.whichPet)
            Misc.DebugModePrint(string.format('\u{1f634} Doing sleep task on %s \u{1f634}', tostring(Ailments.whichPet)))

            if not checkPetEquipped() then
                return
            end

            furnitureAilments(bedId, ClientData.get('pet_char_wrappers')[Ailments.whichPet]['char'])
            waitForTaskToFinish('sleepy', petUnique)
        end
        function Ailments:DirtyAilment(showerId, petUnique)
            Misc.ReEquipPet(Ailments.whichPet)
            Misc.DebugModePrint(string.format('\u{1f9fc} Doing dirty task on %s \u{1f9fc}', tostring(Ailments.whichPet)))

            if not checkPetEquipped() then
                return
            end

            furnitureAilments(showerId, ClientData.get('pet_char_wrappers')[Ailments.whichPet]['char'])
            waitForTaskToFinish('dirty', petUnique)
        end
        function Ailments:ToiletAilment(litterBoxId, petUnique)
            Misc.ReEquipPet(Ailments.whichPet)
            Misc.DebugModePrint(string.format('\u{1f6bd} Doing toilet task on %s \u{1f6bd}', tostring(Ailments.whichPet)))

            if litterBoxId then
                if not checkPetEquipped() then
                    return
                end

                furnitureAilments(litterBoxId, ClientData.get('pet_char_wrappers')[Ailments.whichPet]['char'])
            else
                Teleport.DownloadMainMap()
                task.wait(5)

                localPlayer.Character.HumanoidRootPart.CFrame = Workspace.HouseInteriors.furniture:FindFirstChild('AilmentsRefresh2024FireHydrant', true).PrimaryPart.CFrame + Vector3.new(5, 5, 5)

                task.wait(2)
                Misc.ReEquipPet(Ailments.whichPet)
            end

            waitForTaskToFinish('toilet', petUnique)
        end
        function Ailments:BeachPartyAilment(petUnique)
            Misc.DebugModePrint(string.format('\u{1f3d6}\u{fe0f} Doing beach party on %s \u{1f3d6}\u{fe0f}', tostring(Ailments.whichPet)))
            Teleport.BeachParty()
            task.wait(2)
            Misc.ReEquipPet(Ailments.whichPet)
            waitForTaskToFinish('beach_party', petUnique)
        end
        function Ailments:CampingAilment(petUnique)
            Misc.DebugModePrint(string.format('\u{1f3d5}\u{fe0f} Doing camping task on %s \u{1f3d5}\u{fe0f}', tostring(Ailments.whichPet)))
            Teleport.CampSite()
            task.wait(2)
            Misc.ReEquipPet(Ailments.whichPet)
            waitForTaskToFinish('camping', petUnique)
        end
        function Ailments:WalkAilment(petUnique)
            Misc.ReEquipPet(Ailments.whichPet)
            Misc.DebugModePrint(string.format('\u{1f9ae} Doing walking task on %s \u{1f9ae}', tostring(Ailments.whichPet)))

            if not checkPetEquipped() then
                return
            end

            ReplicatedStorage.API['AdoptAPI/HoldBaby']:FireServer(ClientData.get('pet_char_wrappers')[Ailments.whichPet]['char'])
            waitForJumpingToFinish('walk', petUnique)

            if not checkPetEquipped() then
                return
            end

            ReplicatedStorage.API:FindFirstChild('AdoptAPI/EjectBaby'):FireServer(ClientData.get('pet_char_wrappers')[Ailments.whichPet]['char'])
        end
        function Ailments:RideAilment(strollerId, petUnique)
            Misc.ReEquipPet(Ailments.whichPet)
            Misc.DebugModePrint(string.format('\u{1f697} Doing ride task on %s \u{1f697}', tostring(Ailments.whichPet)))
            ReplicatedStorage.API:FindFirstChild('ToolAPI/Equip'):InvokeServer(strollerId, {})
            task.wait(1)

            if not checkPetEquipped() then
                return
            end
            if not useStroller() then
                return
            end

            waitForJumpingToFinish('ride', petUnique)

            if not checkPetEquipped() then
                return
            end

            ReplicatedStorage.API:FindFirstChild('AdoptAPI/EjectBaby'):FireServer(ClientData.get('pet_char_wrappers')[Ailments.whichPet]['char'])
        end
        function Ailments:PlayAilment(ailment, petUnique)
            Misc.ReEquipPet(Ailments.whichPet)
            Misc.DebugModePrint(string.format('\u{1f9b4} Doing play task on %s \u{1f9b4}', tostring(Ailments.whichPet)))

            local toyId = GetInventory:GetUniqueId('toys', 'squeaky_bone')

            if not toyId then
                ReplicatedStorage.API:FindFirstChild('ShopAPI/BuyItem'):InvokeServer('toys', 'raw_bone', {})
                task.wait(3)

                toyId = GetInventory:GetUniqueId('toys', 'raw_bone')

                if not toyId then
                    Misc.DebugModePrint("\u{26a0}\u{fe0f} Doesn't have raw bone so exiting \u{26a0}\u{fe0f}")

                    return false
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
                Misc.DebugModePrint('\u{1f9b4} Throwing toy \u{1f9b4}')
                ReplicatedStorage.API:FindFirstChild('PetObjectAPI/CreatePetObject'):InvokeServer(unpack(args))
                task.wait(10)

                local taskActive = ClientData.get_data()[localPlayer.Name].ailments_manager.ailments[petUnique] and ClientData.get_data()[localPlayer.Name].ailments_manager.ailments[petUnique][ailment] and true or false

                count = count + 1
            until not taskActive or count >= 6

            if count >= 6 then
                Misc.DebugModePrint('Play task got stuck so requiping pet')
                Misc.ReEquipPet(Ailments.whichPet)

                return false
            end

            Misc.DebugModePrint(string.format('\u{1f9b4} Finished play task on %s \u{1f9b4}', tostring(Ailments.whichPet)))

            return true
        end
        function Ailments:MysteryAilment(mysteryId, petUnique)
            Misc.DebugModePrint('\u{2753} Picking mystery task \u{2753}')
            pickMysteryTask(mysteryId, petUnique)
        end
        function Ailments:BabyHungryAilment()
            Misc.DebugModePrint('\u{1f476}\u{1f374} Doing baby hungry task \u{1f476}\u{1f374}')

            local stuckCount = 0

            repeat
                babyGetFoodAndEat('icecream')

                stuckCount = stuckCount + 1

                task.wait(1)
            until not ClientData.get_data()[localPlayer.Name].ailments_manager.baby_ailments['hungry'] or stuckCount >= 30

            if stuckCount >= 30 then
                Misc.DebugModePrint('\u{26a0}\u{fe0f} Waited too long for Baby Hungry. Must be stuck \u{26a0}\u{fe0f}')
            else
                Misc.DebugModePrint('\u{1f476}\u{1f374} Baby hungry task Finished \u{1f476}\u{1f374}')
            end
        end
        function Ailments:BabyThirstyAilment()
            Misc.DebugModePrint('\u{1f476}\u{1f95b} Doing baby water task \u{1f476}\u{1f95b}')

            local stuckCount = 0

            repeat
                babyGetFoodAndEat('lemonade')

                stuckCount = stuckCount + 1

                task.wait(1)
            until not ClientData.get_data()[localPlayer.Name].ailments_manager.baby_ailments['thirsty'] or stuckCount >= 30

            if stuckCount >= 30 then
                Misc.DebugModePrint('\u{26a0}\u{fe0f} Waited too long for Baby Thirsty. Must be stuck \u{26a0}\u{fe0f}')
            else
                Misc.DebugModePrint('\u{1f476}\u{1f95b} Baby water task Finished \u{1f476}\u{1f95b}')
            end
        end
        function Ailments:BabyBoredAilment(pianoId)
            Misc.DebugModePrint('\u{1f476}\u{1f971} Doing bored task \u{1f476}\u{1f971}')
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
            Misc.DebugModePrint('\u{1f476}\u{1f634} Doing sleepy task \u{1f476}\u{1f634}')
            getUpFromSitting()
            furnitureAilments(bedId, localPlayer.Character)
            babyWaitForTaskToFinish('sleepy')
            getUpFromSitting()
        end
        function Ailments:BabyDirtyAilment(showerId)
            Misc.DebugModePrint('\u{1f476}\u{1f9fc} Doing dirty task \u{1f476}\u{1f9fc}')
            getUpFromSitting()
            furnitureAilments(showerId, localPlayer.Character)
            babyWaitForTaskToFinish('dirty')
            getUpFromSitting()
        end

        return Ailments
