        local Workspace = game:GetService('Workspace')
        local ReplicatedStorage = game:GetService('ReplicatedStorage')
        local Players = game:GetService('Players')
        local localPlayer = Players.LocalPlayer
        local ClientData = require(ReplicatedStorage:WaitForChild('ClientModules'):WaitForChild('Core'):WaitForChild('ClientData'))
        local Blossom = {}

        local createAFKPlateform = function()
             if Workspace:FindFirstChild('BlossomAFKLocation') then
                 return
             end
 
             local part = Instance.new('Part')
             local SurfaceGui = Instance.new('SurfaceGui')
             local TextLabel = Instance.new('TextLabel')
 
             part.Position = Workspace.StaticMap.Springfest2025.CherryBlossomViewingArea.Position
             part.Size = Vector3.new(200, 2, 200)
             part.Anchored = true
             part.Transparency = 1
             part.Name = 'BlossomAFKLocation'
             part.Parent = Workspace
             SurfaceGui.Parent = part
             SurfaceGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
             SurfaceGui.AlwaysOnTop = false
             SurfaceGui.CanvasSize = Vector2.new(600, 600)
             SurfaceGui.Face = Enum.NormalId.Top
             TextLabel.Parent = SurfaceGui
             TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
             TextLabel.BackgroundTransparency = 1
             TextLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
             TextLabel.BorderSizePixel = 0
             TextLabel.Size = UDim2.new(1, 0, 1, 0)
             TextLabel.Font = Enum.Font.SourceSans
             TextLabel.Text = "🌸🌸🌸"
             TextLabel.TextColor3 = Color3.fromRGB(0, 0, 0)
             TextLabel.TextScaled = true
             TextLabel.TextSize = 14
             TextLabel.TextWrapped = true
 
             task.wait(1)
         end

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

         function Blossom.Teleport()
             createAFKPlateform()
 
             localPlayer.Character:WaitForChild('HumanoidRootPart').Anchored = true
             localPlayer.Character.HumanoidRootPart.CFrame = Workspace.BlossomAFKLocation.CFrame * CFrame.new(math.random(1, 40), 10, math.random(1, 40))
             localPlayer.Character:WaitForChild('HumanoidRootPart').Anchored = false
 
             localPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Landed)
             ReplicatedStorage.API['LocationAPI/SetLocation']:FireServer('MainMap', localPlayer, ClientData.get_data()[localPlayer.Name].LiveOpsMapType)
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
                task.wait(math.random(0.3, 2))
            end
        end

        return Blossom
