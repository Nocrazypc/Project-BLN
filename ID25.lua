        local ReplicatedStorage = game:GetService('ReplicatedStorage')
        local Bypass = require(ReplicatedStorage:WaitForChild('Fsys')).load
        local Workspace = game:GetService('Workspace')
        local SlipperyEvent = {}

        local function IceCubeEvent()
            local iceCubeHillMinigameStatic = Workspace.StaticMap.IceCubeHillMinigameStatic
            local iceCubesFolder = iceCubeHillMinigameStatic:FindFirstChild('IceCubes')

            if not iceCubesFolder then
                return
            end

            for i, v in ipairs(iceCubesFolder:GetChildren())do
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
            end
            for i, v in ipairs(Workspace.StaticMap.IceCubeHillMinigameStatic.IceCubes:GetChildren())do
                if not v then
                    continue
                end
                if not v.PrimaryPart then
                    continue
                end

                local args2 = {
                    [1] = 'ice_cube_hill_minigame',
                    [2] = 'attempt_hit',
                    [3] = v.Name,
                    [4] = v.PrimaryPart.Position,
                    [5] = math.random(800, 2000),
                    [6] = Bypass('LiveOpsTime').now(),
                }

                ReplicatedStorage.API['MinigameAPI/MessageServer']:FireServer(unpack(args2))

                v.DecalPart.Color = Color3.fromRGB(255, 0, 0)

                task.wait(1.1)

                break
            end
        end

        function SlipperyEvent.Start()
            if not Workspace:WaitForChild('StaticMap', 15) then
                return
            end
            if not Workspace.StaticMap:WaitForChild('IceCubeHillMinigameStatic', 15) then
                return
            end
            if not Workspace.StaticMap.IceCubeHillMinigameStatic:WaitForChild('IceCubes', 15) then
                return
            end

            print('\u{1f431}\u{200d}\u{1f4bb} STARTING MINIGAME \u{1f431}\u{200d}\u{1f4bb}')

            while Workspace.StaticMap.ice_cube_hill_minigame_minigame_state.is_game_active do
                IceCubeEvent()
                task.wait()
            end

            print('\u{1f389} EVENT DONE \u{1f389}')
        end

        return SlipperyEvent