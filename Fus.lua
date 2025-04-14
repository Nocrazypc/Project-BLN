        local ReplicatedStorage = game:GetService('ReplicatedStorage')
        local Players = game:GetService('Players')
        local ClientData = require(ReplicatedStorage:WaitForChild('ClientModules'):WaitForChild('Core'):WaitForChild('ClientData'))
        local localPlayer = Players.LocalPlayer
        local Fusion = {}
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

        function Fusion:MakeMega(bool)
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

            print('\u{1f389} DONE FUSING \u{1f389}')
        end

        return Fusion
