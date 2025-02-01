
local RS = game:GetService("ReplicatedStorage")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ClientData = require(RS.ClientModules.Core.ClientData)
local Player = game:GetService("Players").LocalPlayer
local RouterClient = require(RS.ClientModules.Core:WaitForChild("RouterClient"):WaitForChild("RouterClient"))
local LunarNewYear2025 = {}

for i, v in pairs(debug.getupvalue(RouterClient.init, 7)) do
    v.Name = i
end





-- SHOOTING STARS
function LunarNewYear2025:GetAvailableShootingStars(mapName)
    return ClientData.get_data()[Player.Name].moon_2025_shooting_stars.available_stars[mapName]
end

function LunarNewYear2025:FetchStars(mapName)
    while task.wait() and LunarNewYear2025:GetAvailableShootingStars(mapName) ~= 0 do
        for i = 1, 150 do
            RS.API:WaitForChild("MoonAPI/ShootingStarCollected"):FireServer(
                mapName,
                tostring(i)
            )
            task.wait()
        end
    end

    a = ClientData.get_data()[Player.Name].moon_2025_shooting_stars
    if a.special_stars_collected_today < a.special_stars_allowed_today then
        for i = 1, 150 do
            RS.API:WaitForChild("MoonAPI/ShootingStarCollected"):FireServer(
                mapName,
                tostring(i),
                true
            )
            task.wait()
            if a.special_stars_collected_today >= a.special_stars_allowed_today then break end
        end
        
    end
end




return LunarNewYear2025
