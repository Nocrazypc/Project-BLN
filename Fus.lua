local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local ClientData = require(ReplicatedStorage:WaitForChild("ClientModules"):WaitForChild("Core"):WaitForChild("ClientData"))

local Player = Players.LocalPlayer

local Fusion = {}

local function getFullgrownPets(mega: boolean): table
    local fullgrownTable = {}

    if mega then
        for _, v in ClientData.get_data()[Player.Name].inventory.pets do
            if v.properties.age == 6 and v.properties.neon then
                if not fullgrownTable[v.id] then
                    fullgrownTable[v.id] = {["count"] = 0, ["unique"] = {}}
                end

                fullgrownTable[v.id]["count"] += 1
                table.insert(fullgrownTable[v.id]["unique"], v.unique)

                if fullgrownTable[v.id]["count"] >= 4 then
                    break
                end
            end
        end

    else
        for _, v in ClientData.get_data()[Player.Name].inventory.pets do
            if v.properties.age == 6 and not v.properties.neon and not v.properties.mega_neon then
                if not fullgrownTable[v.id] then
                    fullgrownTable[v.id] = {["count"] = 0, ["unique"] = {}}
                end

                fullgrownTable[v.id]["count"] += 1
                table.insert(fullgrownTable[v.id]["unique"], v.unique)
                
                if fullgrownTable[v.id]["count"] >= 4 then
                    break
                end
            end
        end
    end

    return fullgrownTable
end


function Fusion:MakeMega(bool: boolean)
    repeat
        local fusionReady = {}

        local fullgrownTable = getFullgrownPets(bool)

        for _, valueTable in fullgrownTable do
            if valueTable.count >= 4 then
                table.insert(fusionReady, valueTable.unique[1])
                table.insert(fusionReady, valueTable.unique[2])
                table.insert(fusionReady, valueTable.unique[3])
                table.insert(fusionReady, valueTable.unique[4])
                break
            end
        end

        if #fusionReady >= 4 then
            ReplicatedStorage.API:FindFirstChild("PetAPI/DoNeonFusion"):InvokeServer({unpack(fusionReady)})
        end

    until #fusionReady <= 3
end

return Fusion