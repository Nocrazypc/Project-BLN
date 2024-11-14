local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Player = game:GetService("Players").LocalPlayer

local BuyItems = {}

local ClientData = require(ReplicatedStorage:WaitForChild("ClientModules"):WaitForChild("Core"):WaitForChild("ClientData"))

-- local petsToBuy = {
--     {NameId = "halloween_2024_franken_feline", MaxAmount = 48},
--     {NameId = "halloween_2024_sea_skeleton_panda", MaxAmount = 48},
--     {NameId = "halloween_2024_indian_flying_fox", MaxAmount = 80},
--     {NameId = "halloween_2024_headless_horse", MaxAmount = 80},
--     {NameId = "halloween_2024_marabou_stork", MaxAmount = 16},
--     {NameId = "halloween_2024_scarebear", MaxAmount = 16}
-- }

local function hasPetMaxAmount(nameId: string, maxAmount: number)
    local count = 0
    for _, pet in ClientData.get_data()[Player.Name].inventory.pets do
        if nameId == pet.id then
            count += 1
        end
    end
    if count < maxAmount then
        return (maxAmount - count)
    end

    return 0
end

local function buyPet(petNameId: string, howManyToBuy: number)
    for i = 1, howManyToBuy do
        local hasMoney = game.ReplicatedStorage.API["ShopAPI/BuyItem"]:InvokeServer("pets", petNameId, {})
        if hasMoney == "too little money" then
            return false
        end
        task.wait(.1)
    end
    return true
end

function BuyItems:BuyPets(petsToBuy: table)
    for _, myPet in ipairs(petsToBuy) do
        local amount = hasPetMaxAmount(myPet.NameId, myPet.MaxAmount)
        print(amount)
        if amount == 0 then
            print(`has max amount of: {myPet.NameId}, skipping`)
            continue 
        end
        if not buyPet(myPet.NameId, amount) then
            print(`has no money to buy more so breaking out of loop`)
            break 
        end
        print(`bought all pets needed: {myPet.NameId}`)
    end 
end


return BuyItems