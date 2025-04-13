        local ReplicatedStorage = game:GetService('ReplicatedStorage')
        local Players = game:GetService('Players')
        local ClientData = require(ReplicatedStorage:WaitForChild('ClientModules'):WaitForChild('Core'):WaitForChild('ClientData'))
        local InventoryDB = require(ReplicatedStorage:WaitForChild('ClientDB'):WaitForChild('Inventory'):WaitForChild('InventoryDB'))
        local localPlayer = Players.LocalPlayer
        local GetInventory = {}

        function GetInventory:GetAll()
            return ClientData.get_data()[localPlayer.Name].inventory
        end

        function GetInventory:TabId(tabId: string)
            local inventoryTable = {}

            for _, v in ClientData.get_data()[localPlayer.Name].inventory[tabId]do
                if v.id == 'practice_dog' then
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
        
         function GetInventory:IsFarmingSelectedPet()
            if not ClientData.get('pet_char_wrappers')[1] then
                return
            end
            if getgenv().PetCurrentlyFarming == ClientData.get('pet_char_wrappers')[1]['pet_unique'] then
                return
            end
            --print('current pet equipped is not the same pet as selected..')
            ReplicatedStorage.API['ToolAPI/Equip']:InvokeServer(getgenv().PetCurrentlyFarming, {})
            task.wait(2)
            return
        end
        
        function GetInventory:GetPetFriendship()
            local level = 0
            local petUnique = nil

            for _, pet in ClientData.get_data()[localPlayer.Name].inventory.pets do
                if pet.id == 'practice_dog' then
                    continue
                end
                if not pet.properties then
                    continue
                end
                if not pet.properties.friendship_level then
                    continue
                end
                if pet.properties.friendship_level > level then
                    level = pet.properties.friendship_level
                    petUnique = pet.unique
                end
            end

            if not petUnique then
                return false
            end

            ReplicatedStorage.API['ToolAPI/Equip']:InvokeServer(petUnique, {})

            getgenv().PetCurrentlyFarming = petUnique

            return true
        end
        function GetInventory:PetRarityAndAge(rarity: string, age: number)
            local PetageCounter = age or 5
            local isNeon = true
            local petFound = false

            while not petFound do
                for _, pet in ClientData.get_data()[localPlayer.Name].inventory.pets do
                    for _, petDB in InventoryDB.pets do
                        if rarity == petDB.rarity and pet.id == petDB.id and pet.id ~= 'practice_dog' and pet.properties.age == PetageCounter and pet.properties.neon == isNeon then
                            ReplicatedStorage.API['ToolAPI/Equip']:InvokeServer(pet.unique, {})

                            getgenv().PetCurrentlyFarming = pet.unique

                            return true
                        end
                    end
                end

                PetageCounter -= 1

                if PetageCounter <= 0 and isNeon then
                    PetageCounter = age or 5
                    isNeon = nil
                elseif PetageCounter <= 0 and isNeon == nil then
                    return false
                end

                task.wait()
            end
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
        
        function GetInventory:PriorityEgg()
            for _, v in ipairs(getgenv().SETTINGS.HATCH_EGG_PRIORITY_NAMES)do
                for _, v2 in ClientData.get_data()[localPlayer.Name].inventory.pets do
                    if v == v2.id and v2.id ~= 'practice_dog' then
                        ReplicatedStorage.API['ToolAPI/Equip']:InvokeServer(v2.unique, {
                            ['use_sound_delay'] = true,
                        })

                        getgenv().PetCurrentlyFarming = v2.unique

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
        function GetInventory:GetNeonPet()
            local Petage = 5
            local isNeon = true
            local found_pet = false

            while not found_pet do
                for _, v in ClientData.get_data()[localPlayer.Name].inventory.pets do
                    if v.id ~= 'practice_dog' and v.properties.age == Petage and v.properties.neon == isNeon then
                        ReplicatedStorage.API['ToolAPI/Equip']:InvokeServer(v.unique, {
                            ['use_sound_delay'] = true,
                        })

                        getgenv().PetCurrentlyFarming = v.unique

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
        function GetInventory:PriorityPet()
            local Petage = 5
            local isNeon = true
            local found_pet = false

            while found_pet == false do
                for _, v in ipairs(getgenv().SETTINGS.PET_ONLY_PRIORITY_NAMES)do
                    for _, v2 in pairs(ClientData.get_data()[localPlayer.Name].inventory.pets)do
                        if v == v2.id and v2.id ~= 'practice_dog' and v2.properties.age == Petage and v2.properties.neon == isNeon then
                            ReplicatedStorage.API['ToolAPI/Equip']:InvokeServer(v2.unique, {
                                ['use_sound_delay'] = true,
                            })

                            getgenv().PetCurrentlyFarming = v2.unique

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
