        local ReplicatedStorage = game:GetService('ReplicatedStorage')
        local VirtualInputManager = game:GetService('VirtualInputManager')
        local ClientData = require(ReplicatedStorage:WaitForChild('ClientModules'):WaitForChild('Core'):WaitForChild('ClientData'))
        local Misc = {}

        function Misc.ClickGuiButton(button, xOffset1, yOffset1)
            if typeof(button) ~= 'Instance' then
                return print('button is not a Instance')
            end

            local xOffset = xOffset1 or 60
            local yOffset = yOffset1 or 60

            task.wait()
            VirtualInputManager:SendMouseButtonEvent(button.AbsolutePosition.X + xOffset, button.AbsolutePosition.Y + yOffset, 0, true, game, 1)
            task.wait()
            VirtualInputManager:SendMouseButtonEvent(button.AbsolutePosition.X + xOffset, button.AbsolutePosition.Y + yOffset, 0, false, game, 1)
            task.wait()

            return
        end
        function Misc.WaitForPetToEquip()
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
        function Misc.IsPetEquipped(whichPet)
            local petIndex = ClientData.get('pet_char_wrappers')[whichPet]

            if not petIndex then
                return
            end
            if not petIndex['pet_unique'] then
                return
            end
        end
        function Misc.UnEquip(petUnique, EquipAsLast)
            local success, errorMessage = pcall(function()
                ReplicatedStorage.API['ToolAPI/Unequip']:InvokeServer(petUnique, {
                    ['equip_as_last'] = EquipAsLast,
                })
            end)

            if not success then
                print('Failed to Unequip pet:', errorMessage)

                return false
            end

            return true
        end
        function Misc.Equip(petUnique, EquipAsLast)
            local success, errorMessage = pcall(function()
                ReplicatedStorage.API['ToolAPI/Equip']:InvokeServer(petUnique, {
                    ['equip_as_last'] = EquipAsLast,
                })
            end)

            if not success then
                print('Failed to equip pet:', errorMessage)

                return false
            end

            return true
        end
        function Misc.ReEquipPet(whichPet)
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
                if not Misc.UnEquip(petUnique, false) then
                    return false
                end

                task.wait(1)

                if not Misc.Equip(petUnique, false) then
                    return false
                end
            elseif whichPet == 2 then
                if not Misc.UnEquip(petUnique, true) then
                    return false
                end

                task.wait(1)

                if not Misc.Equip(petUnique, true) then
                    return false
                end
            end

            repeat
                task.wait(1)

                hasPetChar = ClientData.get('pet_char_wrappers') and ClientData.get('pet_char_wrappers')[whichPet] and ClientData.get('pet_char_wrappers')[whichPet]['char'] and true or false
                EquipTimeout = EquipTimeout + 1
            until hasPetChar or EquipTimeout >= 20

            if EquipTimeout >= 20 then
                print('\u{26a0}\u{fe0f} Waited too long for Equipping pet \u{26a0}\u{fe0f}')

                return false
            end

            Misc.DebugModePrint(string.format('ReEquipPet: success in equipping %s', tostring(whichPet)))

            return true
        end
        function Misc.DebugModePrint(message)
            if getgenv().debugMode then
                print(message)
            end
        end

        return Misc