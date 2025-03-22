        local ReplicatedStorage = game:GetService('ReplicatedStorage')
        local Workspace = game:GetService('Workspace')
        local SlipperyEvent = {}

        local function IceCubeEvent()
            for i, v in Workspace.StaticMap.IceCubeHillMinigameStatic.IceCubes:GetChildren()do
                if not v then
                    continue
                end
                if not v.PrimaryPart then
                    continue
                end

                local args1 = {
                    [1] = 'ice_cube_hill_minigame',
                    [2] = 'ice_cube_touched',
                    [3] = v.Name,
                }

                ReplicatedStorage.API['MinigameAPI/MessageServer']:FireServer(unpack(args1))

                local args2 = {
                    [1] = 'ice_cube_hill_minigame',
                    [2] = 'attempt_hit',
                    [3] = v.Name,
                    [4] = v.PrimaryPart.Position,
                    [5] = 600,
                }

                ReplicatedStorage.API['MinigameAPI/MessageServer']:FireServer(unpack(args2))
                task.wait(0.1)
            end
        end

        function SlipperyEvent.Start()
            while Workspace.StaticMap.IceCubeHillMinigameStatic:FindFirstChild('IceCubes') do
                IceCubeEvent()
                task.wait()
            end

            --print('Event Done')
        end

        return SlipperyEvent
