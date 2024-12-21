        local ReplicatedStorage = game:GetService('ReplicatedStorage')
        local Players = game:GetService('Players')
        local ClientData = require(ReplicatedStorage:WaitForChild('ClientModules'):WaitForChild('Core'):WaitForChild('ClientData'))
        local InventoryDB = require(ReplicatedStorage:WaitForChild('ClientDB'):WaitForChild('Inventory'):WaitForChild('InventoryDB'))
        local localPlayer = Players.LocalPlayer
        local Clipboard = {}

        Clipboard.__index = Clipboard

        function Clipboard.new()
            local self = setmetatable({}, Clipboard)

            self.Debouce = false
            self.MegaPets = {}
            self.NeonPets = {}
            self.NormalPets = {}
            self.PetList = ''
            self.PetsTable = {}
            self.PetAccessoriesTable = {}
            self.StrollersTable = {}
            self.FoodTable = {}
            self.TransportTable = {}
            self.ToysTable = {}
            self.GiftsTable = {}
            self.AllInventory = ''

            return self
        end

        local getPetInfoMega = function(self, title)
            for _, v in ClientData.get_data()[localPlayer.Name].inventory.pets do
                for _, v2 in InventoryDB.pets do
                    if v.id == v2.id and v.properties.mega_neon then
                        self.MegaPets[title .. v2.name] = (self.MegaPets[title .. v2.name] or 0) + 1
                    end
                end
            end
            for i, v in self.MegaPets do
                self.PetList = self.PetList .. i .. ' x' .. v .. '\n'
            end
        end
        local getPetInfoNeon = function(self, title)
            for _, v in ClientData.get_data()[localPlayer.Name].inventory.pets do
                for _, v2 in InventoryDB.pets do
                    if v.id == v2.id and v.properties.neon then
                        self.NeonPets[title .. v2.name] = (self.NeonPets[title .. v2.name] or 0) + 1
                    end
                end
            end
            for i, v in self.NeonPets do
                self.PetList = self.PetList .. i .. ' x' .. v .. '\n'
            end
        end
        local getPetInfoNormal = function(self, title)
            for _, v in pairs(ClientData.get_data()[localPlayer.Name].inventory.pets)do
                for _, v2 in InventoryDB.pets do
                    if v.id == v2.id and not v.properties.neon and not v.properties.mega_neon then
                        self.NormalPets[title .. v2.name] = (self.NormalPets[title .. v2.name] or 0) + 1
                    end
                end
            end
            for i, v in self.NormalPets do
                self.PetList = self.PetList .. i .. ' x' .. v .. '\n'
            end
        end
        local clearTables = function(self)
            for i, v in self do
                if typeof(v) == 'table' then
                    print(`table {v} cleared`)
                    table.clear(v)
                end
            end
        end

        function Clipboard:CopyPetInfo()
            if self.Debounce then
                return
            end

            self.Debounce = true

            getPetInfoMega(self, '[MEGA NEON] ')
            getPetInfoNeon(self, '[NEON] ')
            getPetInfoNormal(self, '[Normal] ')
            setclipboard(self.PetList)

            self.PetList = ''

            clearTables(self)
            task.wait()

            self.Debounce = false
        end

        local getInventoryInfo = function(tab, tablePassOn)
            for _, v in pairs(ClientData.get_data()[localPlayer.Name].inventory[tab])do
                if v.id == 'practice_dog' then
                    continue
                end

                tablePassOn[v.id] = (tablePassOn[v.id] or 0) + 1
            end
        end
        local getTable = function(
            self,
            inventoryPassOn,
            tablePassOn,
            namePassOn
        )
            for i, v in tablePassOn do
                for _, v2 in InventoryDB[inventoryPassOn]do
                    if i == tostring(v2.id) then
                        self.AllInventory = self.AllInventory .. '[' .. namePassOn .. '] ' .. v2.name .. ' x' .. v .. '\n'
                    end
                end
            end
        end
        local getAgeupPotionInfo = function()
            local count = 0

            for _, v in pairs(ClientData.get_data()[localPlayer.Name].inventory.food)do
                if v.id == 'pet_age_potion' then
                    count += 1
                end
            end

            return count
        end
        local addComma = function(amount)
            local formatted = amount
            local k

            while true do
                formatted, k = string.gsub(formatted, '^(-?%d+)(%d%d%d)', '%1,%2')

                if k == 0 then
                    break
                end
            end

            return formatted
        end
        local getBucksInfo = function(self)
            local potions = getAgeupPotionInfo()
            local potionAmount = potions * 0.04
            local bucks = ClientData.get_data()[localPlayer.Name].money or 0

            self.AllInventory = self.AllInventory .. `{potions} Age-up Potions + {addComma(bucks)} Bucks | Adopt me\n`

            local formatNumber = string.format('%.2f', (potionAmount))

            self.AllInventory = self.AllInventory .. `sell for ${tostring(formatNumber)}  {localPlayer.Name}\n\n`
        end

        function Clipboard:CopyAllInventory()
            getInventoryInfo('pets', self.PetsTable)
            getInventoryInfo('pet_accessories', self.PetAccessoriesTable)
            getInventoryInfo('strollers', self.StrollersTable)
            getInventoryInfo('food', self.FoodTable)
            getInventoryInfo('transport', self.TransportTable)
            getInventoryInfo('toys', self.ToysTable)
            getInventoryInfo('gifts', self.GiftsTable)
            getBucksInfo(self)
            getTable(self, 'pets', self.PetsTable, 'PET')
            getTable(self, 'pet_accessories', self.PetAccessoriesTable, 'PET_ACCESSORIE')
            getTable(self, 'strollers', self.StrollersTable, 'STROLLER')
            getTable(self, 'food', self.FoodTable, 'FOOD')
            getTable(self, 'transport', self.TransportTable, 'TRANSPORT')
            getTable(self, 'toys', self.ToysTable, 'TOY')
            getTable(self, 'gifts', self.GiftsTable, 'GIFT')
            setclipboard(self.AllInventory)

            self.AllInventory = ''

            clearTables(self)
        end

        return Clipboard