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
    --game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.Chat,false)
    t.WaterWaveSize = 0
    t.WaterWaveSpeed = 0
    t.WaterReflectance = 0
    t.WaterTransparency = 1
    l.GlobalShadows = 0
    l.FogEnd = 9e9
    l.Brightness = 1
    settings().Rendering.QualityLevel = "0"
    settings().Rendering.MeshPartDetailLevel = Enum.MeshPartDetailLevel.Level04
    task.wait()
    for i, v in pairs(w:GetDescendants()) do
        if (v:IsA("Decal") or v:IsA("Texture")) and decalsyeeted then
            v.Transparency = 1
        elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
            v.Lifetime = NumberRange.new(0)
        elseif v:IsA("SpecialMesh") and decalsyeeted  then
            v.TextureId=0
        end
    end
    for i = 1,#l:GetChildren() do
        e=l:GetChildren()[i]
        if e:IsA("BlurEffect") or e:IsA("DepthOfFieldEffect") then
            e.Enabled = false
        end
    end
    w.DescendantAdded:Connect(function(v)
        pcall(function()
            if v:IsA("Decal") or v:IsA("Texture") and decalsyeeted then
                v.Transparency = 1
            elseif v:IsA("SpecialMesh") and decalsyeeted then
                v.TextureId=0
            end
        end)
        task.wait()
    end)

    workspace.Terrain.WaterReflectance = 0
    workspace.Terrain.WaterTransparency = 1
    workspace.Terrain.WaterWaveSize = 0
    workspace.Terrain.WaterWaveSpeed = 0

    for i,v in pairs(game.Lighting:GetChildren()) do 
        if v:IsA("Model") then
            v:Destroy()
        elseif v.Name:match("Weather") then 
            v:Destroy()
        end 
    end


    game.Lighting.ChildAdded:Connect(function()
        for i,v in pairs(game.Lighting:GetChildren()) do 
            if v:IsA("Model") then
                v:Destroy()
            elseif v.Name:match("Weather") then 
                v:Destroy()
            end 
        end

    end)
end



        return Valentines2025
