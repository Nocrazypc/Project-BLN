        local ReplicatedStorage = game:GetService('ReplicatedStorage')
        local Workspace = game:GetService('Workspace')
        local VirtualUser = game:GetService('VirtualUser')
        local Players = game:GetService('Players')
        local localPlayer = Players.LocalPlayer
        local Fusion = loadstring(game:HttpGet("https://raw.githubusercontent.com/Nocrazypc/Project-BLN/refs/heads/main/Fus.lua"))()
        local ClientData = require(ReplicatedStorage:WaitForChild("ClientModules"):WaitForChild("Core"):WaitForChild("ClientData"))
        local BulkPotions = {}

        --BulkPotions.__index = BulkPotions

        function BulkPotions.new()
            local self = setmetatable({}, BulkPotions)

            self.SameUnqiue = nil
            self.StopAging = false
            self.EggsTable = {}

            return self
        end

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
                print('Unable to equip pet')

                return false
            end

            print('Pet is Equipped')

            return true
        end

        function BulkPotions:IsPetNormal(petName)
            for _, v in ClientData.get_data()[localPlayer.Name].inventory.pets do
                if v.id == petName and v.id ~= 'practice_dog' and v.properties.age ~= 6 and not v.properties.mega_neon then
                    ReplicatedStorage.API['ToolAPI/Equip']:InvokeServer(v.unique, {
                        ['use_sound_delay'] = true,
                    })
                    waitForPetToEquip()

                    return true
                end
            end

            return false
        end
        function BulkPotions:IsPetNeon(petName)
            for _, v in ClientData.get_data()[localPlayer.Name].inventory.pets do
                if v.id == petName and v.id ~= 'practice_dog' and v.properties.age ~= 6 and v.properties.neon and not v.properties.mega_neon then
                    ReplicatedStorage.API['ToolAPI/Equip']:InvokeServer(v.unique, {
                        ['use_sound_delay'] = true,
                    })
                    waitForPetToEquip()

                    return true
                end
            end

            if self:IsPetNormal(petName) then
                return true
            else
                return false
            end
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
        local consumeItem = function(potionName)
            local agePotion = Workspace.PetObjects:WaitForChild(potionName, 6)

            if not agePotion then
                print('no age potion in workspace')

                return
            end

            ReplicatedStorage.API['PetAPI/ConsumeFoodObject']:FireServer(agePotion, ClientData.get('pet_char_wrappers')[1].pet_unique)
        end

        function BulkPotions:IsSameUnique()
            for _, v in ClientData.get_data()[localPlayer.Name].inventory.food do
                if v.id == 'pet_age_potion' or v.id == 'tiny_pet_age_potion' then
                    if self.SameUnqiue == v.unique then
                        print('has same unqiue age up potion')
                        task.wait(1)

                        return true
                    end
                end
            end

            return false
        end
        function BulkPotions:SetEggTable(newEggTable)
            self.EggsTable = newEggTable
        end
        function BulkPotions:IsEgg()
            local EquipTimeout = 0
            local hasPetChar = false

            repeat
                task.wait(1)

                hasPetChar = if ClientData.get('pet_char_wrappers')[1] and ClientData.get('pet_char_wrappers')[1]['char']then true else false

                EquipTimeout += 1
            until hasPetChar or EquipTimeout >= 30

            if EquipTimeout >= 30 then
                print(`\u{26a0}\u{fe0f} Waited too long for Equipping pet so Stopping aging \u{26a0}\u{fe0f}`)

                self.StopAging = true

                return true
            end

            local isEgg = if table.find(self.EggsTable, ClientData.get('pet_char_wrappers')[1]['pet_id'])then true else false

            return isEgg
        end
        function BulkPotions:FeedAgePotion()
            if self:IsEgg() then
                return print('Pet Equipped is a EGG! or No pet Equipped')
            end
            if self:IsSameUnique() then
                return
            end

            local TotalPotions = localPlayer.PlayerGui.StatsGui.MainFrame.MiddleFrame.TotalPotions
            local TotalTinyPotions = localPlayer.PlayerGui.StatsGui.MainFrame.MiddleFrame.TotalTinyPotions

            for _, v in ClientData.get_data()[localPlayer.Name].inventory.food do
                if v.id == 'pet_age_potion' then
                    self.SameUnqiue = v.unique

                    print('feeding normal age-up potion')

                    local args = {
                        [1] = '__Enum_PetObjectCreatorType_2',
                        [2] = {
                            ['pet_unique'] = ClientData.get('pet_char_wrappers')[1].pet_unique,
                            ['unique_id'] = v.unique,
                        },
                    }

                    ReplicatedStorage.API['PetObjectAPI/CreatePetObject']:InvokeServer(unpack(args))
                    task.wait(1)
                    consumeItem('AgePotion')

                    TotalPotions.Text = `\u{1f9ea} {agePotionCount('pet_age_potion')}`

                    return
                end
            end
            for _, v in ClientData.get_data()[localPlayer.Name].inventory.food do
                if v.id == 'tiny_pet_age_potion' then
                    self.SameUnqiue = v.unique

                    print('feeding tiny age-up potion')

                    local args = {
                        [1] = '__Enum_PetObjectCreatorType_2',
                        [2] = {
                            ['pet_unique'] = ClientData.get('pet_char_wrappers')[1].pet_unique,
                            ['unique_id'] = v.unique,
                        },
                    }

                    ReplicatedStorage.API['PetObjectAPI/CreatePetObject']:InvokeServer(unpack(args))
                    task.wait(1)
                    consumeItem('TinyAgePotion')

                    TotalTinyPotions.Text = `\u{2697}\u{fe0f} {agePotionCount('tiny_pet_age_potion')}`

                    return
                end
            end

            TotalPotions.Text = `\u{1f9ea} {agePotionCount('pet_age_potion')}`
            TotalTinyPotions.Text = `\u{2697}\u{fe0f} {agePotionCount('tiny_pet_age_potion')}`

            return
        end

        local hasAgeUpPotion = function()
            for _, v in ClientData.get_data()[localPlayer.Name].inventory.food do
                if v.id == 'pet_age_potion' or v.id == 'tiny_pet_age_potion' then
                    return true
                end
            end

            return false
        end

        function BulkPotions:AgeAllPetsOfSameName(petId)
            Fusion:MakeMega(false)
            Fusion:MakeMega(true)

            local hasPet = self:IsPetNeon(petId)

            if not hasPet then
                return print(`no {petId} so moving to next pet or stopping`)
            end

            while true do
                local isEgg = self:IsEgg()

                if isEgg then
                    return print('Pet Equipped is an EGG, Stopping')
                end

                local age = ClientData.get('pet_char_wrappers')[1]['pet_progression']['age']

                if age >= 6 then
                    print("pet's age is 6")

                    break
                end

                local hasAgeUpPotion = hasAgeUpPotion()

                if not hasAgeUpPotion then
                    self.StopAging = true

                    print('no more age up potions')

                    return
                end

                self:FeedAgePotion()
                task.wait()
            end

            if self.StopAging then
                return
            end

            self:AgeAllPetsOfSameName(petId)

            return
        end
        function BulkPotions:StartAgingPets(petsTable)
            if typeof(petsTable) ~= 'table' then
                print('is not a table')

                return
            end

            for _, petId in ipairs(petsTable)do
                if self.StopAging then
                    print('stop aging is true, so stopped')

                    return
                end

                self:AgeAllPetsOfSameName(petId)
            end
        end

        localPlayer.Idled:Connect(function()
            VirtualUser:ClickButton2(Vector2.new())
        end)

        return BulkPotions
