local ReplicatedStorage = game:GetService("ReplicatedStorage")
local localPlayer = game:GetService("Players").LocalPlayer
local ClientData = require(ReplicatedStorage:WaitForChild("ClientModules"):WaitForChild("Core"):WaitForChild("ClientData"))

local FC2024 = {}

local function createLobby()
    return ReplicatedStorage.API["MinigameAPI/LobbyCreate"]:InvokeServer("frostclaws_revenge")
end

local function startLobby()
    ReplicatedStorage.API["MinigameAPI/LobbyStart"]:FireServer()
end

local function getMinigameId()
    local gameId
    local model = workspace.Interiors:FindFirstChildWhichIsA("Model")
    if not model then
        local count = 0
        repeat
            task.wait(1)
            count += 1
            model = workspace.Interiors:FindFirstChildWhichIsA("Model")
        until model  or count > 30
        if count > 30 then
            print("wouldnt get model")
            return nil
        end
    end

    if model then
        local count = 0
        repeat
            if model.Name:match("FrostclawsRevengeInterior") then
                gameId = model.Name:split("::")[2]
            end
            count += 1
            task.wait(1)
        until gameId or count > 30
    end
  
    return gameId
end

local function hitEnemy(name, gameId)
    local args = {
        [1] = "frostclaws_revenge::"..gameId,
        [2] = "hit_enemies",
        [3] = {
            [1] = name
        },
        [4] = "sword_slash"
    }

    ReplicatedStorage.API["MinigameAPI/MessageServer"]:FireServer(unpack(args))
end

function FC2024.CreateAndStartLobby()
    if not createLobby() then
        createLobby()
    end

    local count = 0
    local name
    repeat
        startLobby()
        count += 1
        task.wait(2)
        local model = workspace.Interiors:FindFirstChildWhichIsA("Model")
        if model then
            name = model.Name:match("FrostclawsRevengeInterior")
            print(name)
        end
    until name == "FrostclawsRevengeInterior" or count > 30
    if count > 30 then
        return false
    end

    return true
end

function FC2024.StartGame()
    local minigameId = getMinigameId()
    if not minigameId then return end

    local isGameActive = true

    while isGameActive do
        for _, v in workspace.Minigames[`FrostclawsRevengeInterior::{minigameId}`]:WaitForChild("FrostclawsRevengeEnemies"):GetChildren() do
            hitEnemy(v.Name, minigameId)
        end
        
        local minigameStateFolder = workspace.StaticMap:FindFirstChild(`frostclaws_revenge::{minigameId}_minigame_state`)
        if not minigameStateFolder then print("game over or no folder") break end
        isGameActive = minigameStateFolder:WaitForChild("is_game_active").Value
        task.wait()
    end

    local count = 0
    repeat
        count += 1
        task.wait(1)
    until not workspace.Minigames:FindFirstChild(`FrostclawsRevengeInterior::{minigameId}`) or count > 30
end

function FC2024.init()
    localPlayer.PlayerGui.FrostclawsRevengeUpgradeApp.Background.Upgrades.ChildAdded:Connect(function(child)
        if child.Name ~= "Upgrade1" then return end
        child:WaitForChild("Icon")
        child.Icon:WaitForChild("Container")
        child.Icon.Container:WaitForChild("Button")
        local count = 0
        repeat
            firesignal(child.Icon.Container.Button.Activated)
            count += 1
            task.wait(1)
        until not localPlayer.PlayerGui.FrostclawsRevengeUpgradeApp.Enabled or count > 15
    end)
end

return FC2024