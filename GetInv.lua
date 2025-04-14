        local ReplicatedStorage = game:GetService('ReplicatedStorage')
        local Players = game:GetService('Players')
        local ClientData = require(ReplicatedStorage:WaitForChild('ClientModules'):WaitForChild('Core'):WaitForChild('ClientData'))
        local InventoryDB = require(ReplicatedStorage:WaitForChild('ClientDB'):WaitForChild('Inventory'):WaitForChild('InventoryDB'))
        local localPlayer = Players.LocalPlayer
        local GetInventory = {}
        local blackListIds = {
            'practice_dog',
            'spring_2025_minigame_spiked_kaijunior',
            'spring_2025_minigame_scorching_kaijunior',
            'spring_2025_minigame_toxic_kaijunior',
            'spring_2025_minigame_spotted_kaijunior',
        }
        local equipWhichPet = function(whichPet, petUnique)
            if whichPet == 1 then
                ReplicatedStorage.API['ToolAPI/Equip']:InvokeServer(petUnique, {
                    ['equip_as_last'] = false,
                })

                getgenv().petCurrentlyFarming1 = petUnique

                print(string.format('equipWhichPet: %s', tostring(getgenv().petCurrentlyFarming1)))

                return true
            elseif whichPet == 2 then
                ReplicatedStorage.API['ToolAPI/Equip']:InvokeServer(petUnique, {
                    ['equip_as_last'] = true,
                })

                getgenv().petCurrentlyFarming2 = petUnique

                print(string.format('equipWhichPet: %s', tostring(getgenv().petCurrentlyFarming2)))

                return true
            end

            return false
        end

        function GetInventory:GetAll()
            return ClientData.get_data()[localPlayer.Name].inventory
        end
        function GetInventory:TabId(tabId)
            local inventoryTable = {}

            for _, v in ClientData.get_data()[localPlayer.Name].inventory[tabId]do
                if table.find(blackListIds, v.id) then
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
        function GetInventory:IsFarmingSelectedPet(hasProHandler)
            if hasProHandler then
                if not ClientData.get('pet_char_wrappers')[2] then
                    return
                end
                if getgenv().petCurrentlyFarming2 == ClientData.get('pet_char_wrappers')[2]['pet_unique'] then
                    return
                end

                print('current pet equipped (2) is not the same pet as selected..')
                print(ReplicatedStorage.API['ToolAPI/Equip']:InvokeServer(getgenv().petCurrentlyFarming2, {}))
            end
            if not ClientData.get('pet_char_wrappers')[1] then
                return
            end
            if getgenv().petCurrentlyFarming1 == ClientData.get('pet_char_wrappers')[1]['pet_unique'] then
                return
            end

            print('current pet equipped (1) is not the same pet as selected..')
            ReplicatedStorage.API['ToolAPI/Equip']:InvokeServer(getgenv().petCurrentlyFarming1, {})
            task.wait(2)

            return
        end
        function GetInventory:GetPetFriendship(whichPet)
            local level = 0
            local petUnique = nil

            for _, pet in ClientData.get_data()[localPlayer.Name].inventory.pets do
                if table.find(blackListIds, pet.id) then
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
            print(string.format('Found pet with friendship level: %s, equipped on: %s', tostring(level), tostring(whichPet)))

            return true
        end
        function GetInventory:GetHighestGrownPet(age, whichPet)
            local PetageCounter = age
            local isNeon = true
            local petFound = false

            while not petFound do
                for _, pet in ClientData.get_data()[localPlayer.Name].inventory.pets do
                    if table.find(blackListIds, pet.id) then
                        continue
                    end
                    if pet.properties.age == PetageCounter and pet.properties.neon == isNeon then
                        if pet.unique == getgenv().petCurrentlyFarming1 then
                            continue
                        end
                        if pet.unique == getgenv().petCurrentlyFarming2 then
                            continue
                        end

                        print(string.format('GetHighestGrownPet: %s', tostring(whichPet)))
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
        function GetInventory:PetRarityAndAge(rarity, age, whichPet)
            local PetageCounter = age
            local isNeon = true
            local petFound = false

            while not petFound do
                for _, pet in ClientData.get_data()[localPlayer.Name].inventory.pets do
                    for _, petDB in InventoryDB.pets do
                        if table.find(blackListIds, pet.id) then
                            continue
                        end
                        if rarity == petDB.rarity and pet.id == petDB.id and pet.properties.age == PetageCounter and pet.properties.neon == isNeon then
                            if pet.unique == getgenv().petCurrentlyFarming1 then
                                continue
                            end
                            if pet.unique == getgenv().petCurrentlyFarming2 then
                                continue
                            end

                            print(string.format('PetRarityAndAge: %s', tostring(whichPet)))
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
        function GetInventory:CheckForPetAndEquip(nameId, whichPet)
            local level = 0
            local petUnique = nil

            for _, pet in ClientData.get_data()[localPlayer.Name].inventory['pets']do
                if pet.id == nameId then
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
                print(string.format('Found pet with friendship level: %s, equipped on: %s', tostring(level), tostring(whichPet)))

                return true
            end

            local PetageCounter = 6
            local isNeon = true
            local petFound = false

            while not petFound do
                for _, pet in ClientData.get_data()[localPlayer.Name].inventory.pets do
                    if pet.id == nameId and pet.properties.age == PetageCounter and pet.properties.neon == isNeon then
                        if pet.unique == getgenv().petCurrentlyFarming1 then
                            continue
                        end
                        if pet.unique == getgenv().petCurrentlyFarming2 then
                            continue
                        end

                        print(string.format('GetHighestGrownPet: %s', tostring(whichPet)))
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
        function GetInventory:GetUniqueId(tabId, nameId)
            for _, v in ClientData.get_data()[localPlayer.Name].inventory[tabId]do
                if v.id == nameId then
                    return v.unique
                end
            end

            return nil
        end
        function GetInventory:IsPetInInventory(tabId, uniqueId)
            for _, v in ClientData.get_data()[localPlayer.Name].inventory[tabId]do
                if v.unique == uniqueId then
                    return true
                end
            end

            return false
        end
        function GetInventory:PriorityEgg(whichPet)
            for _, v in ipairs(getgenv().SETTINGS.HATCH_EGG_PRIORITY_NAMES)do
                for _, v2 in ClientData.get_data()[localPlayer.Name].inventory.pets do
                    if table.find(blackListIds, v2.id) then
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
        function GetInventory:GetPetEggs()
            local eggs = {}

            for i, v in InventoryDB.pets do
                if v.is_egg then
                    table.insert(eggs, v.id)
                end
            end

            return eggs
        end
        function GetInventory:GetNeonPet(whichPet)
            local Petage = 5
            local isNeon = true
            local found_pet = false

            while not found_pet do
                for _, v in ClientData.get_data()[localPlayer.Name].inventory.pets do
                    if table.find(blackListIds, v.id) then
                        continue
                    end
                    if v.properties.age == Petage and v.properties.neon == isNeon then
                        if v.unique == getgenv().petCurrentlyFarming1 then
                            continue
                        end
                        if v.unique == getgenv().petCurrentlyFarming2 then
                            continue
                        end

                        print(string.format('GetNeonPet: %s', tostring(whichPet)))
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
        function GetInventory:PriorityPet(whichPet)
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
                        if table.find(blackListIds, v2.id) then
                            continue
                        end
                        if v == v2.id and v2.properties.age == Petage and v2.properties.neon == isNeon then
                            print('PriorityPet:')
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