local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local CollisionsClient = require(ReplicatedStorage.ClientModules.Game.CollisionsClient)

local Player = Players.LocalPlayer
local getconstants = getconstants or debug.getconstants
local getgc = getgc or get_gc_objects or debug.getgc
local get_thread_identity = get_thread_identity or gti or getthreadidentity or getidentity or syn.get_thread_identity or fluxus.get_thread_identity
local set_thread_identity = set_thread_context or sti or setthreadcontext or setidentity or syn.set_thread_identity or fluxus.set_thread_identity

local SetLocationTP

local Teleport = {}

--//grab teleportation function
for _, v in pairs(getgc()) do
	if type(v) == "function" then
		if getfenv(v).script == game.ReplicatedStorage.ClientModules.Core.InteriorsM.InteriorsM then
			if table.find(getconstants(v), "LocationAPI/SetLocation") then
				SetLocationTP = v
				break
			end
		end
	end
end

local function SetLocationFunc(a, b, c)
	local k = get_thread_identity()
	set_thread_identity(2)
	SetLocationTP(a, b, c)
	set_thread_identity(k)
end

local function floorPart()
	for _, v in workspace:GetChildren() do
		if v.Name == "FloorPart1" then
			return
		end
	end
	local part = Instance.new("Part")
	part.Position = game.Workspace.Interiors:FindFirstChild(
		tostring(game.Workspace.Interiors:FindFirstChildWhichIsA("Model"))
	).Static.Campsite.MarshmallowChair.VintageChair.Union.Position + Vector3.new(0, -3, 0)
	part.Size = Vector3.new(2000, 2, 2000)
	part.Anchored = true
	part.Name = "FloorPart1"
	part.Parent = workspace
end

local function floorPart2()
	for _, v in workspace:GetChildren() do
		if v.Name == "FloorPart3" then
			return
		end
	end
	local part = Instance.new("Part")
	part.Position = game.Workspace.Interiors:FindFirstChild(
		tostring(game.Workspace.Interiors:FindFirstChildWhichIsA("Model"))
	).Static.Campsite.MarshmallowChair.VintageChair.Union.Position + Vector3.new(0, -20, 0)
	part.Size = Vector3.new(2000, 2, 2000)
	part.Anchored = true
	part.Name = "FloorPart3"
	part.Parent = workspace
end

function Teleport.placeFloorOnJoinZone()
	-- workspace.Interiors.Halloween2024Shop.TileSkip.JoinZone.EmitterPart
	for _, v in workspace:GetChildren() do
		if v.Name == "FloorPart2" then
			return
		end
	end

	local part = Instance.new("Part")
	part.Position = game.Workspace.Interiors
		:WaitForChild("Halloween2024Shop")
		:WaitForChild("TileSkip"):WaitForChild("JoinZone")
		:WaitForChild("EmitterPart").Position + Vector3.new(0, -2, 0)
	part.Size = Vector3.new(100, 2, 100)
	part.Anchored = true
	part.Name = "FloorPart2"
	part.Parent = workspace
end

function Teleport.DeleteMainMapParts()
	-- local MainMap = workspace.Interiors:WaitForChild(tostring(workspace.Interiors:FindFirstChildWhichIsA("Model")))
	-- if not MainMap then
	-- 	print("not in mainmap")
	-- 	return
	-- end

	-- MainMap:WaitForChild("Static")
	-- workspace:WaitForChild("StaticMap")

	if workspace:FindFirstChildWhichIsA("Terrain") then
        workspace.Terrain:Clear()
    end

	-- if workspace.StaticMap:FindFirstChild("Balloon") then
	-- 	workspace.StaticMap:FindFirstChild("Balloon"):Destroy()
	-- 	MainMap.Static:FindFirstChild("Campsite"):Destroy()
	-- 	MainMap.Static:FindFirstChild("Bridges"):Destroy()
	-- 	MainMap.Static:FindFirstChild("Boundaries"):Destroy()
	-- 	MainMap.Static:FindFirstChild("Props"):Destroy()
	-- 	MainMap.Static:FindFirstChild("Terrain"):FindFirstChild("Mountains"):Destroy()
	-- 	MainMap.Static:FindFirstChild("Terrain"):FindFirstChild("Road"):Destroy()
	-- 	MainMap.Static:FindFirstChild("Terrain"):FindFirstChild("RiverEdge"):Destroy()
	-- 	MainMap.Static:FindFirstChild("ThemeArea"):Destroy()
	-- 	MainMap.Static:FindFirstChild("Beach"):Destroy()
	-- 	MainMap:FindFirstChild("Park"):Destroy()
		-- MainMap:FindFirstChild("Buildings"):Destroy()
		-- MainMap:FindFirstChild("Event"):Destroy()
	-- end
end

function Teleport.MainMap()
	local isAlreadyOnMainMap = workspace:FindFirstChild("Interiors"):FindFirstChild("center_map_plot", true)
	if isAlreadyOnMainMap then
		return
	end
	CollisionsClient.set_collidable(false)
	Player.Character:WaitForChild("HumanoidRootPart").Anchored = true
	SetLocationFunc("MainMap", "Neighborhood/MainDoor", {})
	workspace.Interiors:WaitForChild(tostring(workspace.Interiors:FindFirstChildWhichIsA("Model")))
	floorPart()
	Player.Character.PrimaryPart.CFrame = workspace
		:WaitForChild("StaticMap")
		:WaitForChild("Campsite")
		:WaitForChild("CampsiteOrigin").CFrame + Vector3.new(math.random(1, 5), 10, math.random(1, 5))
	Player.Character:WaitForChild("HumanoidRootPart").Anchored = false
	Player.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Landed)
	-- Player.Character.Humanoid.WalkSpeed = 0
	Teleport.DeleteMainMapParts()
	task.wait(2)
end

function Teleport.Nursery()
	Player.Character:WaitForChild("HumanoidRootPart").Anchored = true
	SetLocationFunc("Nursery", "MainDoor", {})
	task.wait(1)
	workspace.Interiors:WaitForChild(tostring(workspace.Interiors:FindFirstChildWhichIsA("Model")))
	Player.Character.PrimaryPart.CFrame = workspace.Interiors.Nursery
		:WaitForChild("GumballMachine")
		:WaitForChild("Root").CFrame + Vector3.new(-8, 10, 0)
	Player.Character:WaitForChild("HumanoidRootPart").Anchored = false
	Player.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Landed)
	-- Player.Character.Humanoid.WalkSpeed = 0
end

function Teleport.CampSite()
	Player.Character:WaitForChild("HumanoidRootPart").Anchored = true
	-- local isAlreadyOnMainMap = workspace:FindFirstChild("Interiors"):FindFirstChild("center_map_plot", true)
	-- if not isAlreadyOnMainMap then
	-- 	SetLocationFunc("MainMap", "Neighborhood/MainDoor", {})
	-- end
	SetLocationFunc("MainMap", "Neighborhood/MainDoor", {})
	task.wait(1)
	workspace.Interiors:WaitForChild(tostring(workspace.Interiors:FindFirstChildWhichIsA("Model")))
	floorPart()
	Player.Character.PrimaryPart.CFrame = workspace
		:WaitForChild("StaticMap")
		:WaitForChild("Campsite")
		:WaitForChild("CampsiteOrigin").CFrame + Vector3.new(math.random(1, 5), 10, math.random(1, 5))
	Player.Character:WaitForChild("HumanoidRootPart").Anchored = false
	Player.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Landed)
	-- Player.Character.Humanoid.WalkSpeed = 0
	Teleport.DeleteMainMapParts()
end

function Teleport.CampSite2()
	Player.Character:WaitForChild("HumanoidRootPart").Anchored = true
	local isAlreadyOnMainMap = workspace:FindFirstChild("Interiors"):FindFirstChild("center_map_plot", true)
	if not isAlreadyOnMainMap then
		SetLocationFunc("MainMap", "Neighborhood/MainDoor", {})
	end
	task.wait(1)
	workspace.Interiors:WaitForChild(tostring(workspace.Interiors:FindFirstChildWhichIsA("Model")))
	floorPart2()
	Player.Character.PrimaryPart.CFrame = workspace
		:WaitForChild("StaticMap")
		:WaitForChild("Campsite")
		:WaitForChild("CampsiteOrigin").CFrame + Vector3.new(math.random(1, 5), -15, math.random(55, 60))
	Player.Character:WaitForChild("HumanoidRootPart").Anchored = false
	Player.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Landed)
	-- Player.Character.Humanoid.WalkSpeed = 0
	Teleport.DeleteMainMapParts()
end

function Teleport.BeachParty()
	Player.Character:WaitForChild("HumanoidRootPart").Anchored = true
	-- local isAlreadyOnMainMap = workspace:FindFirstChild("Interiors"):FindFirstChild("center_map_plot", true)
	-- if not isAlreadyOnMainMap then
	-- 	SetLocationFunc("MainMap", "Neighborhood/MainDoor", {})
	-- end
	SetLocationFunc("MainMap", "Neighborhood/MainDoor", {})
	task.wait(1)
	workspace.Interiors:WaitForChild(tostring(workspace.Interiors:FindFirstChildWhichIsA("Model")))
	Player.Character.PrimaryPart.CFrame = workspace.StaticMap.Beach.BeachPartyAilmentTarget.CFrame
		+ Vector3.new(math.random(1, 20), 10, math.random(1, 20))
	Player.Character:WaitForChild("HumanoidRootPart").Anchored = false
	Player.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Landed)
	-- Player.Character.Humanoid.WalkSpeed = 0
	Teleport.DeleteMainMapParts()
end

function Teleport.BeachParty2()
	Player.Character:WaitForChild("HumanoidRootPart").Anchored = true
	local isAlreadyOnMainMap = workspace:FindFirstChild("Interiors"):FindFirstChild("center_map_plot", true)
	if not isAlreadyOnMainMap then
		SetLocationFunc("MainMap", "Neighborhood/MainDoor", {})
	end
	task.wait(1)
	workspace.Interiors:WaitForChild(tostring(workspace.Interiors:FindFirstChildWhichIsA("Model")))
	floorPart2()
	Player.Character.PrimaryPart.CFrame = workspace.StaticMap.Beach.BeachPartyAilmentTarget.CFrame
		+ Vector3.new(-160, -10, 40)
	Player.Character:WaitForChild("HumanoidRootPart").Anchored = false
	Player.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Landed)
	-- Player.Character.Humanoid.WalkSpeed = 0
	Teleport.DeleteMainMapParts()
end

function Teleport.PlayGround(vec: Vector3)
	Player.Character:WaitForChild("HumanoidRootPart").Anchored = true
	-- local isAlreadyOnMainMap = workspace:FindFirstChild("Interiors"):FindFirstChild("center_map_plot", true)
	-- if not isAlreadyOnMainMap then
	-- 	SetLocationFunc("MainMap", "Neighborhood/MainDoor", {})
	-- end
	SetLocationFunc("MainMap", "Neighborhood/MainDoor", {})
	task.wait(1)
	workspace.Interiors:WaitForChild(tostring(workspace.Interiors:FindFirstChildWhichIsA("Model")))
	Player.Character.PrimaryPart.CFrame = workspace
		:WaitForChild("StaticMap")
		:WaitForChild("Park")
		:WaitForChild("Roundabout").PrimaryPart.CFrame + vec

	Player.Character:WaitForChild("HumanoidRootPart").Anchored = false
	Player.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Landed)
	-- Player.Character.Humanoid.WalkSpeed = 0
	Teleport.DeleteMainMapParts()
end

function Teleport.DownloadMainMap()
	Player.Character:WaitForChild("HumanoidRootPart").Anchored = true
	SetLocationFunc("MainMap", "Neighborhood/MainDoor", {})
	task.wait(1)
	workspace.Interiors:WaitForChild(tostring(workspace.Interiors:FindFirstChildWhichIsA("Model")))
	Player.Character.PrimaryPart.CFrame = workspace
		:WaitForChild("StaticMap")
		:WaitForChild("Park")
		:WaitForChild("Roundabout").PrimaryPart.CFrame + Vector3.new(20, 10, math.random(15, 30))

	Player.Character:WaitForChild("HumanoidRootPart").Anchored = false
	Player.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Landed)
	-- Player.Character.Humanoid.WalkSpeed = 0
	Teleport.DeleteMainMapParts()
end

function Teleport.SkyCastle()
	Player.Character:WaitForChild("HumanoidRootPart").Anchored = true
	local isAlreadyOnSkyCastle = workspace:WaitForChild("Interiors"):FindFirstChild("SkyCastle")
	if not isAlreadyOnSkyCastle then
		SetLocationFunc("SkyCastle", "MainDoor", {})
	end
	task.wait(1)
	workspace.Interiors:WaitForChild(tostring(workspace.Interiors:FindFirstChildWhichIsA("Model")))
	
	local skyCastle = workspace.Interiors:FindFirstChild("SkyCastle")
	if not skyCastle then return end
	skyCastle:WaitForChild("Potions")
	skyCastle.Potions:WaitForChild("GrowPotion")
	skyCastle.Potions.GrowPotion:WaitForChild("Part")

	Player.Character.PrimaryPart.CFrame = skyCastle.Potions.GrowPotion.Part.CFrame + Vector3.new(math.random(1, 5), 10, math.random(-5, -1))
	Player.Character:WaitForChild("HumanoidRootPart").Anchored = false
	Player.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Landed)
	-- Player.Character.Humanoid.WalkSpeed = 0
end

function Teleport.Neighborhood()
	Player.Character:WaitForChild("HumanoidRootPart").Anchored = true
	SetLocationFunc("Neighborhood", "MainDoor", {})
	task.wait(1)
	workspace.Interiors:WaitForChild(tostring(workspace.Interiors:FindFirstChildWhichIsA("Model")))
	if not workspace.Interiors:FindFirstChild("Neighborhood!Fall") then return end
	workspace.Interiors["Neighborhood!Fall"]:WaitForChild("InteriorOrigin")
	Player.Character.PrimaryPart.CFrame = workspace.Interiors["Neighborhood!Fall"].InteriorOrigin.CFrame + Vector3.new(0, -10, 0)
	Player.Character:WaitForChild("HumanoidRootPart").Anchored = false
	Player.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Landed)
	-- Player.Character.Humanoid.WalkSpeed = 0
end

return Teleport
