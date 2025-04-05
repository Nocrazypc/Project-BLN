        local Workspace = game:GetService('Workspace')
        local ReplicatedStorage = game:GetService('ReplicatedStorage')
        local Players = game:GetService('Players')
        local localPlayer = Players.LocalPlayer
        local Blossom = {}
        local getGlider = function(shakedownInterior)
            local gliderInteractions = shakedownInterior:WaitForChild('GliderInteractions', 15)

            if not gliderInteractions then
                return
            end

            local defaultGlider = gliderInteractions:WaitForChild('spring_2025_default_paraglider', 15)

            if not defaultGlider then
                return
            end

            local gliderCollision = defaultGlider:WaitForChild('Collision', 15)

            if not gliderCollision then
                return
            end
            if not gliderCollision:WaitForChild('TouchInterest', 15) then
                return
            end

            local character = localPlayer.Character or localPlayer.CharacterAdded:Wait()

            if not character then
                return
            end

            local humanoidRootPart = character:WaitForChild('HumanoidRootPart')

            firetouchinterest(humanoidRootPart, gliderCollision, 0)
        end

        function Blossom.StartEvent()
            local isGameActive = Workspace.StaticMap.blossom_shakedown_minigame_state.is_game_active
            local interior = Workspace.Interiors:WaitForChild('BlossomShakedownInterior', 15)

            getGlider(interior)

            if not interior then
                return
            end

            local ringsFolder = interior:WaitForChild('Rings', 15)

            if not ringsFolder then
                return
            end

            for i, v in ringsFolder:GetDescendants()do
                if not isGameActive.Value then
                    return
                end
                if not v:IsA('Model') then
                    continue
                end

                local args = {
                    [1] = 'blossom_shakedown',
                    [2] = 'petal_ring_flown_through',
                    [3] = v.Name,
                }

                ReplicatedStorage.API['MinigameAPI/MessageServer']:FireServer(unpack(args))
                task.wait(4)
            end
        end

        return Blossom
