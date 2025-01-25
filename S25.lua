 
local ReplicatedStorage = game:GetService('ReplicatedStorage')
local Workspace = game:GetService('Workspace')
local StarsFolder = Workspace:WaitForChild('Collectables')
local LunarNewYear2025 = {}

        function LunarNewYear2025:CollectStars()
            for _, v in StarsFolder:GetChildren()do
                if not v:IsA('Model') then continue
                end
                ReplicatedStorage.API['MoonAPI/ShootingStarCollected']:FireServer('MainMap', v.Name)
                print(`Collected {v.Name} star`)
                task.wait(1)
            end
        end
return LunarNewYear2025






