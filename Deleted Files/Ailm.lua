local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local ClientData = require(ReplicatedStorage:WaitForChild("ClientModules"):WaitForChild("Core"):WaitForChild("ClientData"))

local GetInventory = loadstring(game:HttpGet("https://raw.githubusercontent.com/Nocrazypc/Project-BLN/refs/heads/main/GetInv.lua"))()
local Teleport = loadstring(game:HttpGet("https://raw.githubusercontent.com/Nocrazypc/Project-BLN/refs/heads/main/Tele.lua"))()


local localPlayer = Players.LocalPlayer

local doctorId = nil
local Ailments = {}

-- local ailmentsList = {"beach_party", "salon", "dirty", "thirsty", "hungry", "sleepy",
-- 	"toilet", "play", "walk", "sick", "pizza_party", "school", "bored", "camping", "ride"
-- }

local function FoodAilments(FoodPassOn) --FoodPassOn means "icecream" for this example
	local hasFood = false
	for _, v in ClientData.get_data()[localPlayer.Name].inventory.food do
		if v.id == FoodPassOn then
			hasFood = true
			ReplicatedStorage.API["ToolAPI/Equip"]:InvokeServer(v.unique, {})
			task.wait(1)
           if not ClientData.get("pet_char_wrappers")[1] then --[[print("⚠️ Trying to feed pet but no pet equipped ⚠️")--]] return end
			ReplicatedStorage.API["PetAPI/ConsumeFoodItem"]:FireServer(v.unique, ClientData.get("pet_char_wrappers")[1].pet_unique)
		
			return
		end
	end

	if not hasFood then
		ReplicatedStorage.API["ShopAPI/BuyItem"]:InvokeServer("food", FoodPassOn, {})
		task.wait(1)
		FoodAilments(FoodPassOn)
	end
end

local function useToolOnBaby(uniqueId)
    ReplicatedStorage.API["ToolAPI/ServerUseTool"]:FireServer(uniqueId, "END")
end

local function PianoAilment(pianoId: string, petCharOrPlayerChar: Instance)
	local args = {
		localPlayer,
		pianoId,
		"Seat1",
		{["cframe"] = localPlayer.Character.HumanoidRootPart.CFrame},
        petCharOrPlayerChar
	}
	task.spawn(function()
        ReplicatedStorage.API:FindFirstChild("HousingAPI/ActivateFurniture"):InvokeServer(unpack(args))
    end)
end

local function furnitureAilments(nameId: string, petCharOrPlayerChar: Instance)
    task.spawn(function()
        ReplicatedStorage.API["HousingAPI/ActivateFurniture"]:InvokeServer(
		localPlayer,
		nameId,
		"UseBlock",
		{ ["cframe"] = localPlayer.Character.HumanoidRootPart.CFrame},
		petCharOrPlayerChar
	)
    end)
end

local function isDoctorLoaded()
    local stuckCount = 0
    local isStuck = false

    local doctor = workspace.HouseInteriors.furniture:FindFirstChild("Doctor", true)
    if not doctor then
        repeat
            task.wait(1)
            doctor = workspace.HouseInteriors.furniture:FindFirstChild("Doctor", true)
            stuckCount += 1
            local isStuck = if stuckCount > 30 then true else false
        until doctor or isStuck
    end
    if isStuck then
        --[[print("⚠️ Wasn't able to find Doctor Id ⚠️")--]]
        return false
    end
    return true
end

local function getDoctorId()
    if doctorId then --[[print(`Doctor Id: {doctorId}`)--]] return end
    --print("🩹 Getting Doctor ID 🩹")
    local stuckCount = 0
    local isStuck = false
    ReplicatedStorage.API["LocationAPI/SetLocation"]:FireServer("Hospital")
    task.wait(1)
    local doctor = workspace.HouseInteriors.furniture:FindFirstChild("Doctor", true)
    if not doctor then
        repeat
            task.wait(1)
            doctor = workspace.HouseInteriors.furniture:FindFirstChild("Doctor", true)
            stuckCount += 1
            local isStuck = if stuckCount > 30 then true else false
        until doctor or isStuck
    end
    if isStuck then
        --[[print("⚠️ Wasn't able to find Doctor Id ⚠️")--]]
        return
    end
    if doctor then
        doctorId = doctor:GetAttribute("furniture_unique")
        --[[print(`Found doctor Id: {doctorId}`)--]]
    end
end

local function useStroller()
	local args = {
		[1] = ClientData.get("pet_char_wrappers")[1].char,
		[2] = localPlayer.Character.StrollerTool.ModelHandle.TouchToSits.TouchToSit
	}
	
	ReplicatedStorage.API:FindFirstChild("AdoptAPI/UseStroller"):InvokeServer(unpack(args))
end

local function babyJump()
	-- ReplicatedStorage.API["AdoptAPI/BabyJump"]:FireServer(Player.Character)
	if localPlayer.Character.Humanoid:GetState() == Enum.HumanoidStateType.Freefall then return end
	localPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
end

local function getUpFromSitting()
    ReplicatedStorage.API["AdoptAPI/BabyJump"]:FireServer(localPlayer.Character)
    task.wait(.1)
end

local function reEquipPet()
    local hasPetChar = false
    local EquipTimeout = 0
	ReplicatedStorage.API["ToolAPI/Unequip"]:InvokeServer(ClientData.get_data()[localPlayer.Name].last_equipped_pets[1], {})
	task.wait(1)
	ReplicatedStorage.API["ToolAPI/Equip"]:InvokeServer(ClientData.get_data()[localPlayer.Name].last_equipped_pets[1], {})
	repeat
        task.wait(1)
        hasPetChar = if ClientData.get("pet_char_wrappers")[1] and ClientData.get("pet_char_wrappers")[1]["char"] then true else false
        EquipTimeout += 1
    until hasPetChar or EquipTimeout >= 10
    if EquipTimeout >= 10 then
        --print(`⚠️ Waited too long for Equipping pet so trying again ⚠️`)
        reEquipPet()
    end
end

local function babyGetFoodAndEat(FoodPassOn)
    local hasFood = false
	for _, v in ClientData.get_data()[localPlayer.Name].inventory.food do
		if v.id == FoodPassOn then
			hasFood = true
			ReplicatedStorage.API["ToolAPI/Equip"]:InvokeServer(v.unique, {})
			task.wait(1)
			useToolOnBaby(v.unique)
			return
		end
	end

	if not hasFood then
		ReplicatedStorage.API["ShopAPI/BuyItem"]:InvokeServer("food", FoodPassOn, {})
		task.wait(1)
		babyGetFoodAndEat(FoodPassOn)
	end
end

local function TEST_pickMysteryTask(mysteryId: string, petUnique: string)
	--print(`mystery id: {mysteryId}`)
    local ailmentsList = {}
    for i, v in ClientData.get_data()[localPlayer.Name].ailments_manager.ailments[petUnique][mysteryId]["components"]["mystery"]["components"] do
        if not v.preference_status then continue end
        for i2, v2 in v.preference_status do
            table.insert(ailmentsList, i)
        end
    end

	for i = 1, 3 do
		for _, ailment in ailmentsList do
			--print(`card: {i}, ailment: {ailment}`)
			ReplicatedStorage.API["AilmentsAPI/ChooseMysteryAilment"]:FireServer(mysteryId, i, ailment)
			task.wait(3)
			if not ClientData.get_data()[localPlayer.Name].ailments_manager.ailments[petUnique][mysteryId] then
				--print(`👉 Picked {ailment} ailment from mystery card 👈`)
				return
			end
		end
	end
end

local function pickMysteryTask(mysteryId: string, petUnique: string)
	--print(`mystery id: {mysteryId}`)
    local ailmentsList = {}
    for i, _ in ClientData.get_data()[localPlayer.Name].ailments_manager.ailments[petUnique][mysteryId]["components"]["mystery"]["components"] do
        table.insert(ailmentsList, i)
    end

	for i = 1, 3 do
		for _, ailment in ailmentsList do
			--print(`card: {i}, ailment: {ailment}`)
			ReplicatedStorage.API["AilmentsAPI/ChooseMysteryAilment"]:FireServer(mysteryId, i, ailment)
			task.wait(3)
			if not ClientData.get_data()[localPlayer.Name].ailments_manager.ailments[petUnique][mysteryId] then
				--print(`👉 Picked {ailment} ailment from mystery card 👈`)
				return
			end
		end
	end
end

local function waitForTaskToFinish(ailment: string, petUnique: string)
    --print(`⏳ Waiting for {string.upper(ailment)} to finish ⏳`)
    local count = 0
    repeat
        task.wait(5)
        local taskActive = if ClientData.get_data()[localPlayer.Name].ailments_manager.ailments[petUnique] and ClientData.get_data()[localPlayer.Name].ailments_manager.ailments[petUnique][ailment] then true else false
        count += 5
    until not taskActive or count >= 60
    --if count >= 60 then
        --print(`⚠️ Waited too long for ailment: {ailment}, must be stuck ⚠️`)
    --else
        --print(`🎉 {ailment} task finished 🎉`)
    --end
end

local function waitForJumpingToFinish(ailment: string, petUnique: string)
    --print(`⏳ Waiting for {string.upper(ailment)} to finish ⏳`)
    local stuckCount = tick()
    local isStuck = false
    repeat
        babyJump()
        task.wait(0.2)
        local taskActive = if ClientData.get_data()[localPlayer.Name].ailments_manager.ailments[petUnique] and ClientData.get_data()[localPlayer.Name].ailments_manager.ailments[petUnique][ailment] then true else false
        task.wait(0.1)
        isStuck = if (tick() - stuckCount) >= 120 then true else false
    until not taskActive or isStuck
    --if isStuck then
        --print(`⛔ {ailment} ailment is stuck so exiting task ⛔`)
    --else
        --print(`🎉 {ailment} ailment finished 🎉`)
    --end
end

local function babyWaitForTaskToFinish(ailment: string)
    --print(`⏳ Waiting for BABY {string.upper(ailment)} to finish ⏳`)
    local count = 0
    repeat
        task.wait(5)
        local taskActive = if ClientData.get_data()[localPlayer.Name].ailments_manager.baby_ailments and ClientData.get_data()[localPlayer.Name].ailments_manager.baby_ailments[ailment] then true else false
        count += 5
    until not taskActive or count >= 60
    --if count >= 60 then
        --print(`⚠️ Waited too long for ailment: {ailment}, must be stuck ⚠️`)
    --else
        --print(`🎉 {string.upper(ailment)} task finished 🎉`)
    --end
end


----------------------
--[[ Pet Ailments ]]--
----------------------
function Ailments:HungryAilment()
    --print("🍖 Doing hungry task 🍖")
    FoodAilments("icecream")
    --print("🍖 Finished hungry task 🍖")
end

function Ailments:ThirstyAilment()
    --print("🥛 Doing thirsty task 🥛")
    FoodAilments("water")
    --print("🥛 Finished thirsty task 🥛")
end

function Ailments:SickAilment()
    if doctorId then
        --print("🩹 Doing sick task 🩹")
        ReplicatedStorage.API["LocationAPI/SetLocation"]:FireServer("Hospital")
        if not isDoctorLoaded() then --[[print(`🩹⚠️ Doctor didnt load 🩹⚠️`)--]] return end
        local args = {
            [1] = doctorId,
            [2] = "UseBlock",
            [3] = "Yes",
            [4] = game:GetService("Players").LocalPlayer.Character
        }
        
        ReplicatedStorage.API:FindFirstChild("HousingAPI/ActivateInteriorFurniture"):InvokeServer(unpack(args))
        --print("🩹 SICK task Finished 🩹")
    else
        getDoctorId()
    end
end

function Ailments:SalonAilment(ailment: string, petUnique: string)
    reEquipPet()
    --print("👗 Doing salon task 👗")
    ReplicatedStorage.API["LocationAPI/SetLocation"]:FireServer("Salon")
    waitForTaskToFinish(ailment, petUnique)
end

function Ailments:PizzaPartyAilment(ailment: string, petUnique: string)
    reEquipPet()
    --print("🍕 Doing pizza party task 🍕")
    ReplicatedStorage.API["LocationAPI/SetLocation"]:FireServer("PizzaShop")
    waitForTaskToFinish(ailment, petUnique)
end

function Ailments:SchoolAilment(ailment: string, petUnique: string)
    reEquipPet()
    --print("🏫 Doing school task 🏫")
    ReplicatedStorage.API["LocationAPI/SetLocation"]:FireServer("School")
    waitForTaskToFinish(ailment, petUnique)
end

function Ailments:BoredAilment(pianoId: string, petUnique: string)
    reEquipPet()
    --print("🥱 Doing bored task 🥱")
    if pianoId then
    if not ClientData.get("pet_char_wrappers")[1] and ClientData.get("pet_char_wrappers")[1]["char"] then return end
        PianoAilment(pianoId, ClientData.get("pet_char_wrappers")[1]["char"])
    else
        Teleport.PlayGround(Vector3.new(20, 10, math.random(15, 30)))
    end
    waitForTaskToFinish("bored", petUnique)
end

function Ailments:SleepyAilment(bedId: string, petUnique: string)
    reEquipPet()
    --print("😴 Doing sleep task 😴")	
    if not ClientData.get("pet_char_wrappers")[1] and ClientData.get("pet_char_wrappers")[1]["char"] then return end
    furnitureAilments(bedId, ClientData.get("pet_char_wrappers")[1]["char"])
    waitForTaskToFinish("sleepy", petUnique)
end

function Ailments:DirtyAilment(showerId: string, petUnique: string)
    reEquipPet()
    --print("🧼 Doing dirty task 🧼")
    if not ClientData.get("pet_char_wrappers")[1] and ClientData.get("pet_char_wrappers")[1]["char"] then return end
    furnitureAilments(showerId, ClientData.get("pet_char_wrappers")[1]["char"])
    waitForTaskToFinish("dirty", petUnique)
end

function Ailments:ToiletAilment(litterBoxId: string, petUnique: string)
    reEquipPet()
    --print("🚽 Doing toilet task 🚽")
    if litterBoxId then
    if not ClientData.get("pet_char_wrappers")[1] and ClientData.get("pet_char_wrappers")[1]["char"] then return end
        furnitureAilments(litterBoxId, ClientData.get("pet_char_wrappers")[1]["char"])
    else
        Teleport.DownloadMainMap()
        task.wait(5)
        localPlayer.Character.HumanoidRootPart.CFrame = workspace.HouseInteriors.furniture:FindFirstChild("AilmentsRefresh2024FireHydrant", true).PrimaryPart.CFrame + Vector3.new(5, 5, 5)
        task.wait(2)
        reEquipPet()
    end
    waitForTaskToFinish("toilet", petUnique)
end

function Ailments:BeachPartyAilment(petUnique: string)
    --print("🏖️ Doing beach party 🏖️")
    ReplicatedStorage.API["ToolAPI/Unequip"]:InvokeServer(ClientData.get_data()[localPlayer.Name].last_equipped_pets[1], {})
    Teleport.BeachParty()
    task.wait(2)
    ReplicatedStorage.API["ToolAPI/Equip"]:InvokeServer(ClientData.get_data()[localPlayer.Name].last_equipped_pets[1], {})
    waitForTaskToFinish("beach_party", petUnique)
end

function Ailments:CampingAilment(petUnique: string)
    --print("🏕️ Doing camping task 🏕️")
    ReplicatedStorage.API["ToolAPI/Unequip"]:InvokeServer(ClientData.get_data()[localPlayer.Name].last_equipped_pets[1], {})
    Teleport.CampSite()
    task.wait(2)
    ReplicatedStorage.API["ToolAPI/Equip"]:InvokeServer(ClientData.get_data()[localPlayer.Name].last_equipped_pets[1], {})
    waitForTaskToFinish("camping", petUnique)
end

function Ailments:WalkAilment(petUnique: string)
    reEquipPet()
    --print("🦮 Doing walking task 🦮")
    if not ClientData.get("pet_char_wrappers")[1] and ClientData.get("pet_char_wrappers")[1]["char"] then return end
    ReplicatedStorage.API["AdoptAPI/HoldBaby"]:FireServer(ClientData.get("pet_char_wrappers")[1]["char"])
    waitForJumpingToFinish("walk", petUnique)	
    if not ClientData.get("pet_char_wrappers")[1] and ClientData.get("pet_char_wrappers")[1]["char"] then return end
    ReplicatedStorage.API:FindFirstChild("AdoptAPI/EjectBaby"):FireServer(ClientData.get("pet_char_wrappers")[1]["char"])
end

function Ailments:RideAilment(strollerId: string, petUnique: string)
    reEquipPet()
    ReplicatedStorage.API:FindFirstChild("ToolAPI/Equip"):InvokeServer(strollerId, {})
    task.wait(1)
    useStroller()
    waitForJumpingToFinish("ride", petUnique)	
    if not ClientData.get("pet_char_wrappers")[1] and ClientData.get("pet_char_wrappers")[1]["char"] then return end
    ReplicatedStorage.API:FindFirstChild("AdoptAPI/EjectBaby"):FireServer(ClientData.get("pet_char_wrappers")[1]["char"])
    -- ReplicatedStorage.API:FindFirstChild("ToolAPI/Unequip"):InvokeServer(strollerId, {})  -- errors
end

function Ailments:PlayAilment(ailment: string, petUnique: string)
    reEquipPet()
    --print("🦴 Doing play task 🦴")
    local toyId = GetInventory:GetUniqueId("toys", "raw_bone")
    if not toyId then
        ReplicatedStorage.API:FindFirstChild("ShopAPI/BuyItem"):InvokeServer("toys", "raw_bone", {})
        task.wait(3)
        toyId = GetInventory:GetUniqueId("toys", "raw_bone")
        if not toyId then --[[print(`⚠️ Doesn't have raw bone so exiting ⚠️`)--]] return end
    end

    local args = {
        [1] = "__Enum_PetObjectCreatorType_1",
        [2] = {
            ["reaction_name"] = "ThrowToyReaction",
            ["unique_id"] = toyId
        }
    }
    local count = 0
    repeat
        --print("🦴 Throwing toy 🦴")
        ReplicatedStorage.API:FindFirstChild("PetObjectAPI/CreatePetObject"):InvokeServer(unpack(args))
        task.wait(10)
        local taskActive = if ClientData.get_data()[localPlayer.Name].ailments_manager.ailments[petUnique] and ClientData.get_data()[localPlayer.Name].ailments_manager.ailments[petUnique][ailment] then true else false
        count += 1
    until not taskActive or count >= 6
    if count >= 6 then
        --print(`Play task got stuck so requiping pet`)
        reEquipPet()
        return
    end
    --print(`🎉 {ailment} ailment finished 🎉`)
end

function Ailments:MysteryAilment(mysteryId: string, petUnique: string)
    --print("❓ Picking mystery task ❓") 
    pickMysteryTask(mysteryId, petUnique)
end


----------------------
--[[ Baby Ailments ]]--
----------------------
function Ailments:BabyHungryAilment()
    --print(`👶🍴 Doing baby hungry task 👶🍴`)
    local stuckCount = 0
    repeat
        babyGetFoodAndEat("icecream")
        stuckCount += 1
        task.wait(1)
    until not ClientData.get_data()[localPlayer.Name].ailments_manager.baby_ailments["hungry"] or stuckCount >= 30
    --if stuckCount >= 30 then
        --print(`⚠️ Waited too long for Baby Hungry. Must be stuck ⚠️`)
    --else
        --print(`👶🍴 Baby hungry task Finished 👶🍴`)
    --end
end

function Ailments:BabyThirstyAilment()
    --print(`👶🥛 Doing baby water task 👶🥛`)
    local stuckCount = 0
    repeat
        babyGetFoodAndEat("water")
        stuckCount += 1
        task.wait(1)
    until not ClientData.get_data()[localPlayer.Name].ailments_manager.baby_ailments["thirsty"] or stuckCount >= 30
    --if stuckCount >= 30 then
        --print(`⚠️ Waited too long for Baby Thirsty. Must be stuck ⚠️`)
    --else
        --print(`👶🥛 Baby water task Finished 👶🥛`)
    --end
end

function Ailments:BabyBoredAilment(pianoId: string)
    --print("👶🥱 Doing bored task 👶🥱")
    getUpFromSitting()
    if pianoId then
        PianoAilment(pianoId, localPlayer.Character)
    else
        Teleport.PlayGround(Vector3.new(20, 10, math.random(15, 30)))
    end
    babyWaitForTaskToFinish("bored")
    getUpFromSitting()
end

function Ailments:BabySleepyAilment(bedId: string)
    --print("👶😴 Doing sleepy task 👶😴")
    getUpFromSitting()
    furnitureAilments(bedId, localPlayer.Character)
    babyWaitForTaskToFinish("sleepy")
    getUpFromSitting()
end

function Ailments:BabyDirtyAilment(showerId: string)
    --print("👶🧼 Doing dirty task 👶🧼")
    getUpFromSitting()
    furnitureAilments(showerId, localPlayer.Character)
    babyWaitForTaskToFinish("dirty")
    getUpFromSitting()
end


return Ailments
