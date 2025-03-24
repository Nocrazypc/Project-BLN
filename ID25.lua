        local ReplicatedStorage = game:GetService('ReplicatedStorage')
        local Players = game:GetService('Players')
        local Bypass = require(ReplicatedStorage:WaitForChild('Fsys')).load
        local Workspace = game:GetService('Workspace')
        local SlipperyEvent = {}

        function SlipperyEvent.CreatePlatform()
            if Workspace:FindFirstChild('MinigamePlatform') then
                return
            end

            local part = Instance.new('Part')

            part.Position = Workspace.StaticMap.IceCubeHillMinigameStatic.HillOrientation.Position + Vector3.new(0, 15, 0)
            part.Size = Vector3.new(200, 2, 200)
            part.Anchored = true
            part.Transparency = 1
            part.Name = 'MinigamePlatform'
            part.Parent = Workspace
        end

        local function teleportToPlatform()
            Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Workspace.MinigamePlatform.CFrame + Vector3.new(0, 5, 0)
        end
        local function getFurthestIceCube()
            local iceCubeHillMinigameStatic = Workspace.StaticMap.IceCubeHillMinigameStatic
            local iceCubesFolder = iceCubeHillMinigameStatic:FindFirstChild('IceCubes')

            if not iceCubesFolder then
                return
            end

            local MAX_DISTANCE = 300
            local distance = 0
            local iceCube

            for i, v in ipairs(iceCubesFolder:GetChildren())do
                if not v then
                    continue
                end
                if not v.PrimaryPart then
                    continue
                end

                local magnitude = (Players.LocalPlayer.Character.HumanoidRootPart.Position - v.PrimaryPart.Position).Magnitude

                if magnitude <= MAX_DISTANCE and magnitude > distance then
                    distance = magnitude
                    iceCube = v
                end
            end

            return iceCube
        end
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

            local iceCube = getFurthestIceCube()

            if not iceCube then
                return
            end

            local args2 = {
                [1] = 'ice_cube_hill_minigame',
                [2] = 'attempt_hit',
                [3] = iceCube.Name,
                [4] = iceCube.PrimaryPart.Position,
                [5] = math.random(800, 2000),
                [6] = Bypass('LiveOpsTime').now(),
            }

            ReplicatedStorage.API['MinigameAPI/MessageServer']:FireServer(unpack(args2))

            iceCube.DecalPart.Color = Color3.fromRGB(255, 0, 0)

            task.wait(1.1)
        end

        function SlipperyEvent.Start()
            teleportToPlatform()

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

            while Workspace.StaticMap.ice_cube_hill_minigame_minigame_state.is_game_active.Value do
                IceCubeEvent()
                task.wait()
            end

            print('\u{1f389} EVENT DONE \u{1f389}')
        end

        return SlipperyEvent
