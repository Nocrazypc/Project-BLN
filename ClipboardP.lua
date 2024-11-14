local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local ClientData = require(ReplicatedStorage:WaitForChild("ClientModules"):WaitForChild("Core"):WaitForChild("ClientData"))
local InventoryDB = require(ReplicatedStorage:WaitForChild("ClientDB"):WaitForChild("Inventory"):WaitForChild("InventoryDB"))

local Player = Players.LocalPlayer
local debounce = false

local Clipboard = {}

local megaPets = {}
local neonPets = {}
local normalPets = {}
local petList = ""

local petsTable = {}
local petAccessoriesTable = {}
local strollersTable = {}
local foodTable = {}
local transportTable = {}
local toysTable = {}
local giftsTable = {}
local allInventory = ""


local function getPetInfoMega(title: string)
    for _, v in ClientData.get_data()[Player.Name].inventory.pets do
        for _, v2 in InventoryDB.pets do
            if v.id == v2.id and v.properties.mega_neon then
                megaPets[title..v2.name] = (megaPets[title..v2.name] or 0) + 1
            end
        end
    end
    for i, v in megaPets do
        petList = petList..i.." x"..v.."\n"
    end
end

local function getPetInfoNeon(title: string)
    for _, v in ClientData.get_data()[Player.Name].inventory.pets do
        for _, v2 in InventoryDB.pets do
            if v.id == v2.id and v.properties.neon then
                neonPets[title..v2.name] = (neonPets[title..v2.name] or 0) + 1
            end
        end
    end
    for i, v in neonPets do
        petList = petList..i.." x"..v.."\n"
    end
end

local function getPetInfoNormal(title: string)
    for _, v in pairs(ClientData.get_data()[Player.Name].inventory.pets) do
        for _, v2 in InventoryDB.pets do
            if v.id == v2.id and not v.properties.neon and not v.properties.mega_neon then
                normalPets[title..v2.name] = (normalPets[title..v2.name] or 0) + 1
            end
        end
    end
    for i, v in normalPets do
        petList = petList..i.." x"..v.."\n"
    end
end

function Clipboard:CopyPetInfo()
    if debounce then return end
    debounce = true
    getPetInfoMega("[MEGA NEON] ")
    getPetInfoNeon("[NEON] ")
    getPetInfoNormal("[Normal] ")
    setclipboard(petList)
    petList = ""
    task.wait()
    debounce = false
end

--[[ Copy all inventory information ]]
local function getInventoryInfo(tab, tablePassOn)
    for _, v in pairs(ClientData.get_data()[Player.Name].inventory[tab]) do
        if v.id == "practice_dog" then continue end
        tablePassOn[v.id] = (tablePassOn[v.id] or 0) + 1
    end
end

local function getTable(inventoryPassOn, tablePassOn, namePassOn)
    for i, v in tablePassOn do
        for _, v2 in InventoryDB[inventoryPassOn] do
            if i == tostring(v2.id) then
                allInventory = allInventory.."["..namePassOn.."] "..v2.name.." x"..v.."\n"
            end
        end
    end
end

local function getAgeupPotionInfo()
    local count = 0
    for _, v in pairs(ClientData.get_data()[Player.Name].inventory.food) do
        if v.id == "pet_age_potion" then
            count += 1
        end
    end
    return count
end

-- local function getTokenInfo()
--     local count = 0
--     for _, v in pairs(ClientData.get_data()[Player.Name].inventory.toys) do
--         if v.id == "sunshine_2024_sunshine_token" then
--             count += 1
--         end
--     end
--     return count
-- end

local function addComma(amount)
    local formatted = amount
    local k
    while true do
        formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')
        if k == 0 then
            break
        end
    end
    return formatted
end

local function getBucksInfo()
    local potions = getAgeupPotionInfo()
    -- local tokens = getTokenInfo() or 0
    local potionAmount = potions * 0.04

    -- local ponyPassLevel = ClientData.get_data()[Player.Name].battle_pass_manager.show_horse.rewards_claimed
    -- local tickets = ClientData.get_data()[Player.Name].tickets_2024
    local bucks = ClientData.get_data()[Player.Name].money or 0
    local candy = ClientData.get_data()[Player.Name].candy_2024 or 0
    allInventory = allInventory..`{potions} Age-up Potions + {addComma(bucks)} Bucks | Adopt me\n`

    -- local cash = tonumber(bucks) * 0.000037

    -- local currency = string.gsub(Player.PlayerGui.AltCurrencyIndicatorApp.CurrencyIndicator.Container.Amount.Text, ",", "")
    -- local eventCurrency = tonumber(currency) * 0.0000035714  -- $0.05 each box at 14,000 currency per box
    local formatNumber = string.format("%.2f", (potionAmount))

    allInventory = allInventory..`sell for ${tostring(formatNumber)}  {Player.Name}\n\n`
end
    


function Clipboard:CopyAllInventory()
    getInventoryInfo("pets", petsTable)
    getInventoryInfo("pet_accessories", petAccessoriesTable)
    getInventoryInfo("strollers", strollersTable)
    getInventoryInfo("food", foodTable)
    getInventoryInfo("transport", transportTable)
    getInventoryInfo("toys", toysTable)
    getInventoryInfo("gifts", giftsTable)

    getBucksInfo()
    getTable("pets", petsTable, "PET")
    getTable("pet_accessories", petAccessoriesTable, "PET_ACCESSORIE")
    getTable("strollers", strollersTable, "STROLLER")
    getTable("food", foodTable, "FOOD")
    getTable("transport", transportTable, "TRANSPORT")
    getTable("toys", toysTable, "TOY")
    getTable("gifts", giftsTable, "GIFT")


    setclipboard(allInventory)
    allInventory = ""
end

return Clipboard

-- Pets = Pets.."\nYou have a total of: "..TotalPets.." pets"
