        local ReplicatedStorage = game:GetService('ReplicatedStorage')
        local ClientData = require(ReplicatedStorage:WaitForChild('ClientModules'):WaitForChild('Core'):WaitForChild('ClientData'))
        local localPlayer = game:GetService('Players').LocalPlayer
        local TaskBoard = {}

        TaskBoard.__index = TaskBoard

        local neonTable = {
            ['neon_fusion'] = true,
            ['mega_neon_fusion'] = true,
        }
        local claimTable = {
            ['hatch_three_eggs'] = {3},
            ['fully_age_three_pets'] = {3},
            ['make_two_trades'] = {2},
            ['equip_two_accessories'] = {2},
            ['buy_three_furniture_items_with_friends_coop_budget'] = {3},
            ['buy_five_furniture_items'] = {5},
            ['buy_fifteen_furniture_items'] = {15},
            ['play_as_a_baby_for_twenty_five_minutes'] = {1500},
            ['play_for_thirty_minutes'] = {1800},
            ['sunshine_2024_playtime'] = {2400},
            ['bonus_week_2024_small_ailments'] = {5},
            ['bonus_week_2024_small_hatch_egg'] = {1},
            ['bonus_week_2024_small_age_potion_drank'] = {1},
            ['bonus_week_2024_small_ailment_orange'] = {1},
            ['bonus_week_2024_medium_ailment_hungry_sleepy_bored'] = {3},
            ['bonus_week_2024_medium_ailment_catch_bored'] = {2},
            ['bonus_week_2024_medium_ailment_toilet_dirty_sleepy'] = {3},
            ['bonus_week_2024_medium_ailment_pizza_hungry'] = {2},
            ['bonus_week_2024_medium_ailment_salon_dirty'] = {2},
            ['bonus_week_2024_medium_ailment_school_ride'] = {2},
            ['bonus_week_2024_medium_ailment_walk_beach'] = {2},
            ['bonus_week_2024_medium_ailments'] = {15},
            ['bonus_week_2024_large_ailments_common'] = {30},
            ['bonus_week_2024_large_ailments_legendary'] = {30},
            ['bonus_week_2024_large_ailments_ultra_rare'] = {30},
            ['bonus_week_2024_large_ailments_uncommon'] = {30},
            ['bonus_week_2024_large_ailments_rare'] = {30},
            ['bonus_week_2024_large_ailments'] = {30},
        }

        function TaskBoard.new()
            local self = setmetatable({}, TaskBoard)

            self.NewTaskBool = true
            self.NewClaimBool = true
            self.NeonTable = neonTable
            self.ClaimTable = claimTable

            return self
        end
        function TaskBoard.QuestCount()
            local Count = 0

            for _, v in pairs(ClientData.get('quest_manager')['quests_cached'])do
                if v['entry_name']:match('teleport') or v['entry_name']:match('navigate') or v['entry_name']:match('nav') or v['entry_name']:match('gosh_2022_sick') then
                    Count = Count + 0
                else
                    Count = Count + 1
                end
            end

            return Count
        end

        local reRollCount = function()
            for _, v in pairs(ClientData.get('quest_manager')['daily_quest_data'])do
                if v == 1 or v == 0 then
                    return v
                end
            end

            return 0
        end

        function TaskBoard:NewTask()
            self.NewTaskBool = false

            for _, v in pairs(ClientData.get('quest_manager')['quests_cached'])do
                if v['entry_name']:match('teleport') then
                    task.wait()
                elseif v['entry_name']:match('tutorial') then
                    ReplicatedStorage.API['QuestAPI/ClaimQuest']:InvokeServer(v['unique_id'])
                    task.wait()
                elseif v['entry_name']:match('celestial_2024_small_open_gift') then
                    ReplicatedStorage.API['ShopAPI/BuyItem']:InvokeServer('gifts', 'smallgift', {})
                    task.wait(1)

                    for _, v in ClientData.get_data()[localPlayer.Name].inventory.gifts do
                        if v['id'] == 'smallgift' then
                            ReplicatedStorage.API['ShopAPI/OpenGift']:InvokeServer(v['unique'])

                            break
                        end
                    end

                    task.wait()
                else
                    if TaskBoard.QuestCount() == 1 then
                        if self.NeonTable[v['entry_name'] ] then
                            ReplicatedStorage.API['QuestAPI/ClaimQuest']:InvokeServer(v['unique_id'])
                            task.wait()
                        elseif not self.NeonTable[v['entry_name'] ] and reRollCount() >= 1 then
                            ReplicatedStorage.API['QuestAPI/RerollQuest']:FireServer(v['unique_id'])
                            task.wait()
                        end
                    elseif TaskBoard.QuestCount() > 1 then
                        if self.NeonTable[v['entry_name'] ] then
                            ReplicatedStorage.API['QuestAPI/ClaimQuest']:InvokeServer(v['unique_id'])
                            task.wait()
                        elseif not self.NeonTable[v['entry_name'] ] and reRollCount() >= 1 then
                            ReplicatedStorage.API['QuestAPI/RerollQuest']:FireServer(v['unique_id'])
                            task.wait()
                        elseif not self.NeonTable[v['entry_name'] ] and reRollCount() <= 0 then
                            ReplicatedStorage.API['QuestAPI/ClaimQuest']:InvokeServer(v['unique_id'])
                            task.wait()
                        end
                    end
                end
            end

            task.wait(1)

            self.NewTaskBool = true
        end
        function TaskBoard:NewClaim()
            self.NewClaimBool = false

            for _, v in pairs(ClientData.get('quest_manager')['quests_cached'])do
                if self.ClaimTable[v['entry_name'] ] then
                    if v['steps_completed'] == self.ClaimTable[v['entry_name'] ][1] then
                        ReplicatedStorage.API['QuestAPI/ClaimQuest']:InvokeServer(v['unique_id'])
                        task.wait()
                    end
                elseif not self.ClaimTable[v['entry_name'] ] and v['steps_completed'] == 1 then
                    ReplicatedStorage.API['QuestAPI/ClaimQuest']:InvokeServer(v['unique_id'])
                    task.wait()
                end
            end

            task.wait(1)

            self.NewClaimBool = true
        end

        return TaskBoard