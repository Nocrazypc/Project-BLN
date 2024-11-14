local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local ClientData = require(ReplicatedStorage:WaitForChild("ClientModules"):WaitForChild("Core"):WaitForChild("ClientData"))
local InventoryDB = require(ReplicatedStorage:WaitForChild("ClientDB"):WaitForChild("Inventory"):WaitForChild("InventoryDB"))

local Player = Players.LocalPlayer

local GetInventory = {}

function GetInventory:TabId(tabId: string)
    local inventoryTable = {}
    
    for _, v in ClientData.get_data()[Player.Name].inventory[tabId] do
        if v.id == "practice_dog" then continue end
        if table.find(inventoryTable, v.id) then continue end
        table.insert(inventoryTable, v.id)
    end
    
    table.sort(inventoryTable)
    return inventoryTable
end


function GetInventory:GetPetFriendship()
    local level = 0
    local petUnique = nil

    for _, pet in ClientData.get_data()[Player.Name].inventory.pets do
        if pet.id ~= "practice_dog" then continue end
        if pet.properties.friendship_level > level then
            level = pet.properties.friendship_level
            petUnique = pet.unique
        end
    end

    if not petUnique then return false end

    ReplicatedStorage.API["ToolAPI/Equip"]:InvokeServer(petUnique, {})
    getgenv().PetCurrentlyFarming = petUnique
    return true
end


function GetInventory:PetRarityAndAge(rarity: string, age: number)
    local PetageCounter = age or 5
    local isNeon = true
    local petFound = false

    while not petFound do
        for _, pet in ClientData.get_data()[Player.Name].inventory.pets do
            for _, petDB in InventoryDB.pets do
                if rarity == petDB.rarity and pet.id == petDB.id and pet.id ~= "practice_dog" and pet.properties.age == PetageCounter and pet.properties.neon == isNeon then
                    ReplicatedStorage.API["ToolAPI/Equip"]:InvokeServer(pet.unique, {})
                    getgenv().PetCurrentlyFarming = pet.unique
                    return true
                end
            end
        end

        PetageCounter -= 1
        if PetageCounter <= 0 and isNeon then
            PetageCounter = age or 5
            isNeon = nil   -- must to set to nil, false doesnt work

        elseif PetageCounter <= 0 and isNeon == nil then
            return false
        end

        task.wait()
    end
end


function GetInventory:GetUniqueId(tabId, nameId)
    for _, v in ClientData.get_data()[Player.Name].inventory[tabId] do
        if v.id == nameId then
            return v.unique
        end
    end
    return nil
end



return GetInventory