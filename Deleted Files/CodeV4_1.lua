if game.PlaceId ~= 920587237 then
    return
end


-------------- Stats GUIs ---------------
local StatsGuis = loadstring(game:HttpGet("https://raw.githubusercontent.com/Nocrazypc/Project-BLN/refs/heads/main/Stats.lua"))()
StatsGuis:UpdateText("NameFrame")
---- Updater ---
        task.spawn(function()
            while task.wait() do
			StatsGuis:UpdateText("TimeFrame")
			StatsGuis:UpdateText("BucksAndPotionFrame")
            StatsGuis:UpdateText("TotalFrame")
            StatsGuis:UpdateText("TotalFrame1")
            StatsGuis:UpdateText("TotalFrame2") --GingerBread/Candy/Eggs/Compass coins Frame
            task.wait(5) 
            end
        end)


task.wait(20)

pcall(function()
        
for i,v in pairs(game:GetService("Workspace").Interiors:GetDescendants()) do
    if v:IsA("BasePart") then
        v.Transparency = 1 
    end 
end 

game:GetService("Workspace").Interiors.DescendantAdded:Connect(function(v)
    if v:IsA('BasePart') then
        v.Transparency = 1 
    end 
end)
end) 

task.wait(5)

loadstring(game:HttpGet("https://api.jnkie.com/api/v1/luascripts/public/27704cc5af934d43acfc7b3d5adea87d4e97dcf80d4cba271852c74a24818ffc/download"))()



