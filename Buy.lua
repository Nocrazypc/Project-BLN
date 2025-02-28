        local ReplicatedStorage = game:GetService('ReplicatedStorage')
        local Players = game:GetService('Players')
        local ClientData = require(ReplicatedStorage:WaitForChild('ClientModules'):WaitForChild('Core'):WaitForChild('ClientData'))
        local InventoryDB = require(ReplicatedStorage.ClientDB.Inventory.InventoryDB)
        local localPlayer = Players.LocalPlayer
        local BuyItems = {}



        local function getCategory(nameId)
            if typeof(nameId) ~= 'string' then
                print(`{nameId} is not a string`)

                return
            end

            for _, v in InventoryDB do
                for key, value in v do
                    if key == nameId then
                        return value.category
                    end
                end
            end

            return nil
        end
        local function hasPetMaxAmount(nameId, maxAmount)
            local category = getCategory(nameId)

            if not category then
                return print('no category')
            end

            local count = 0

            for _, pet in ClientData.get_data()[localPlayer.Name].inventory[category]do
                if nameId == pet.id then
                    count += 1
                end
            end

            if count < maxAmount then
                return (maxAmount - count)
            end

            return 0
        end
        local function buyPet(petNameId, howManyToBuy)
            local category = getCategory(petNameId)

            if not category then
                return print('no category')
            end

            for i = 1, howManyToBuy do
                local hasMoney = ReplicatedStorage.API['ShopAPI/BuyItem']:InvokeServer(category, petNameId, {})

                if hasMoney ~= 'success' then
                    return false
                end

                task.wait(0.1)
            end

            return true
        end

        function BuyItems:BuyPets(petsToBuy)
            for _, myPet in ipairs(petsToBuy)do
                local amount = hasPetMaxAmount(myPet.NameId, myPet.MaxAmount)

                print(amount)

                if amount == 0 then
                    print(`has max amount of: {myPet.NameId}, skipping`)

                    continue
                end
                if not buyPet(myPet.NameId, amount) then
                    print(`Has no money to buy more or something went wrong.`)

                    break
                end

                print(`bought all pets needed: {myPet.NameId}`)
            end
        end

        local function openBox(nameId)
            local category = getCategory(nameId)

            for _, v in ClientData.get_data()[localPlayer.Name].inventory[category]do
                if v.id == nameId then
                    ReplicatedStorage.API['LootBoxAPI/ExchangeItemForReward']:InvokeServer(v['id'], v['unique'])
                    task.wait(0.1)
                end
            end
        end

        function BuyItems:OpenItems(nameIdTable)
            if typeof(nameIdTable) ~= 'table' then
                return print(`{nameIdTable} is not a table`)
            end

            for _, v in nameIdTable do
                openBox(v)
            end

            return
        end

return BuyItems
