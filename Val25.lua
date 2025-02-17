        local Players = game:GetService('Players')
        local localPlayer = Players.LocalPlayer
        local Teleport = loadstring(game:HttpGet("https://raw.githubusercontent.com/Nocrazypc/Project-BLN/refs/heads/main/Tele.lua"))()
        local ValentinesFolder = workspace.StaticMap:FindFirstChild('Valentines2025')
        local Valentines2025 = {}
        
          local function getRose()
            if not Valentines2025 then
                return
            end
            -- Teleport.DownloadMainMap()
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
                        task.wait(0.5)
                    end
                end
                task.wait(1)
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
            --print('picked up all roses for the day')
        end
------------------------------------------

function Valentines2025.Optimizer()
    local decalsyeeted = true
    local g = game
    local w = g.Workspace
    local l = g.Lighting
    local t = w.Terrain
    sethiddenproperty(l,"Technology",2)
    sethiddenproperty(t,"Decoration",false)
    -- game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.Chat,false)
    t.WaterWaveSize = 0
    t.WaterWaveSpeed = 0
    t.WaterReflectance = 0
    t.WaterTransparency = 0
    l.GlobalShadows = 0
    l.FogEnd = 9e9
    -- l.Brightness = 0
    settings().Rendering.QualityLevel = "0"
    settings().Rendering.MeshPartDetailLevel = Enum.MeshPartDetailLevel.Level04
    task.wait()
    for i, v in pairs(w:GetDescendants()) do
        if v:IsA("Fire") or v:IsA("SpotLight") or v:IsA("Smoke") or v:IsA("Sparkles") then
            v.Enabled = false
        end
    end

    workspace.Terrain.WaterReflectance = 0
    workspace.Terrain.WaterTransparency = 1
    workspace.Terrain.WaterWaveSize = 0
    workspace.Terrain.WaterWaveSpeed = 0

end



        return Valentines2025
