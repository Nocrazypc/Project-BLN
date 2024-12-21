        local ReplicatedStorage = game:GetService('ReplicatedStorage')
        local LegacyTutorial = require(ReplicatedStorage.ClientModules:WaitForChild('Game'):WaitForChild('Tutorial'):WaitForChild('LegacyTutorial'))
        local ClientData = require(ReplicatedStorage:WaitForChild('ClientModules'):WaitForChild('Core'):WaitForChild('ClientData'))
        local localPlayer = game:GetService('Players').LocalPlayer
        local Tutorials = {}

        function Tutorials.CompleteStarterTutorial()
            pcall(function()
                LegacyTutorial.cancel_tutorial()
                task.wait()
                ReplicatedStorage.API['LegacyTutorialAPI/MarkTutorialCompleted']:FireServer()
                task.wait()
                ReplicatedStorage.API['LegacyTutorialAPI/EquipTutorialEgg']:FireServer()
                task.wait()
                ReplicatedStorage.API['LegacyTutorialAPI/AddTutorialQuest']:FireServer()
                task.wait()
                ReplicatedStorage.API['LegacyTutorialAPI/AddHungryAilmentToTutorialEgg']:FireServer()
                task.wait()

                local feedStartEgg = function(SandwichPassOn)
                    local Foodid2

                    for _, v in pairs(ClientData.get_data()[localPlayer.Name].inventory.food)do
                        if v.id == SandwichPassOn then
                            Foodid2 = v.unique

                            break
                        end
                    end

                    ReplicatedStorage.API['ToolAPI/Equip']:InvokeServer(Foodid2, {
                        ['use_sound_delay'] = true,
                    })
                    task.wait(1)
                    ReplicatedStorage.API['PetAPI/ConsumeFoodItem']:FireServer(Foodid2, ClientData.get('pet_char_wrappers')[1].pet_unique)
                end

                feedStartEgg('sandwich-default')
            end)
        end

        return Tutorials
