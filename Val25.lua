        local Players = game:GetService('Players')
        local localPlayer = Players.LocalPlayer
        local Teleport = loadstring(game:HttpGet("https://raw.githubusercontent.com/Nocrazypc/Project-BLN/refs/heads/main/Tele.lua"))()
        local ValentinesFolder = workspace.StaticMap:FindFirstChild('Valentines2025')
        local Valentines2025 = {}
        
          local function getRose()
            if not Valentines2025 then
                return
            end
            Teleport.DownloadMainMap()
            local RosesFolder = ValentinesFolder:FindFirstChild('Roses')
            if not RosesFolder then
                return print('no rose folder')
            end
            if RosesFolder:FindFirstChild('Rose') then
                localPlayer.Character.HumanoidRootPart.CFrame = RosesFolder.Rose.PrimaryPart.CFrame + Vector3.new(0, 2, 0)
                return
            end
            return
        end
        local function getHearts()
            getRose()
            if not Valentines2025 then
                return
            end
            local HeartsFolder = ValentinesFolder:WaitForChild('Hearts')
            while true do
                for i, v in HeartsFolder:GetChildren()do
                    if v:IsA('Model') and v:FindFirstChild('Collider') then
                        localPlayer.Character.HumanoidRootPart.CFrame = v.PrimaryPart.CFrame
                        task.wait(1)
                    end
                end
                task.wait()
                if not HeartsFolder:FindFirstChildWhichIsA('Model') then
                    return
                end
            end
        end
        function Valentines2025.GetAllRosesAndHearts()
            repeat
                getRose()
                getHearts()
                local RosesFolder = ValentinesFolder:FindFirstChild('Roses')
                if not RosesFolder then
                    return
                end
            until #RosesFolder:GetChildren() == 0
            print('picked up all roses for the day')
        end

        return Valentines2025
