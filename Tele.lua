local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local ClientData = require(ReplicatedStorage:WaitForChild("ClientModules"):WaitForChild("Core"):WaitForChild("ClientData"))
local CollisionsClient = require(ReplicatedStorage.ClientModules.Game.CollisionsClient)


local Player = Players.LocalPlayer
local getconstants = getconstants or debug.getconstants
local getgc = getgc or get_gc_objects or debug.getgc
local get_thread_identity = get_thread_identity or gti or getthreadidentity or getidentity or syn.get_thread_identity or fluxus.get_thread_identity
local set_thread_identity = set_thread_context or sti or setthreadcontext or setidentity or syn.set_thread_identity or fluxus.set_thread_identity

local SetLocationTP
local rng = Random.new()

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

function Teleport.PlaceFloorAtFarmingHome()
	if workspace:FindFirstChild("FarmingHomeLocation") then return end

	local part = Instance.new("Part")
	local SurfaceGui = Instance.new("SurfaceGui")
	local TextLabel = Instance.new("TextLabel")

	part.Position = Vector3.new(1000, 0, 1000)
	part.Size = Vector3.new(200, 2, 200)
	part.Anchored = true
        part.Transparency = 1.000
	part.Name = "FarmingHomeLocation"
	part.Parent = workspace

	SurfaceGui.Parent = part
	SurfaceGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	SurfaceGui.AlwaysOnTop = false
	SurfaceGui.CanvasSize = Vector2.new(600, 600)
	SurfaceGui.Face = Enum.NormalId.Top

	TextLabel.Parent = SurfaceGui
	TextLabel.BackgroundColor3 = Color3.fromRGB(50, 200, 0)
	TextLabel.BackgroundTransparency = 0.350
	TextLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
	TextLabel.BorderSizePixel = 0
	TextLabel.Size = UDim2.new(1, 0, 1, 0)
	TextLabel.Font = Enum.Font.SourceSans
	TextLabel.Text = "🍕🍕😋"
	TextLabel.TextColor3 = Color3.fromRGB(0, 0, 0)
	TextLabel.TextScaled = true
	TextLabel.TextSize = 14.000
	TextLabel.TextWrapped = true
end

function Teleport.PlaceFloorAtCampSite()
	if workspace:FindFirstChild("CampingLocation") then return end

	local campsite = workspace.StaticMap.Campsite.CampsiteOrigin
	local part = Instance.new("Part")
	part.Position = campsite.Position + Vector3.new(0, -1, 0)
	part.Size = Vector3.new(200, 2, 200)
	part.Anchored = true
    part.Transparency = 1
	part.Name = "CampingLocation"
	part.Parent = workspace
end

function Teleport.PlaceFloorAtBeachParty()
	if workspace:FindFirstChild("BeachPartyLocation") then return end

	local part = Instance.new("Part")
	part.Position = workspace.StaticMap.Beach.BeachPartyAilmentTarget.Position + Vector3.new(0, -10, 0) --Vector3.new(-240, 0, 40)
	part.Size = Vector3.new(200, 2, 200)
	part.Anchored = true
    part.Transparency = 1
	part.Name = "BeachPartyLocation"
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

function Teleport.DeleteWater()
	if workspace:FindFirstChildWhichIsA("Terrain") then
        workspace.Terrain:Clear()
    end
end


function Teleport.FarmingHome()
	-- local isAlreadyOnMainMap = workspace:FindFirstChild("Interiors"):FindFirstChild("center_map_plot", true)
	-- if isAlreadyOnMainMap then
	-- 	return
	-- end
	-- CollisionsClient.set_collidable(false)
	Player.Character:WaitForChild("HumanoidRootPart").Anchored = true
	-- SetLocationFunc("MainMap", "Neighborhood/MainDoor", {})
	Player.Character.HumanoidRootPart.CFrame = workspace.FarmingHomeLocation.CFrame * CFrame.new(rng:NextInteger(1, 40), 10, rng:NextInteger(1, 40))

	Player.Character:WaitForChild("HumanoidRootPart").Anchored = false
	Player.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Landed)

	Teleport.DeleteWater()
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
	
	Player.Character.PrimaryPart.CFrame = workspace
		:WaitForChild("StaticMap")
		:WaitForChild("Campsite")
		:WaitForChild("CampsiteOrigin").CFrame + Vector3.new(math.random(1, 5), 10, math.random(1, 5))
	Player.Character:WaitForChild("HumanoidRootPart").Anchored = false
	Player.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Landed)
	-- Player.Character.Humanoid.WalkSpeed = 0
	Teleport.DeleteWater()
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
	Teleport.DeleteWater()
	ReplicatedStorage.API["LocationAPI/SetLocation"]:FireServer("MainMap", Player, ClientData.get_data()[Player.Name].LiveOpsMapType)
	task.wait(1)
	Player.Character.PrimaryPart.CFrame = workspace.CampingLocation.CFrame + Vector3.new(rng:NextInteger(1, 30), 5, rng:NextInteger(1, 30))
	Player.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Landed)
end

function Teleport.BeachParty()
	Teleport.DeleteWater()
	ReplicatedStorage.API["LocationAPI/SetLocation"]:FireServer("MainMap", Player, ClientData.get_data()[Player.Name].LiveOpsMapType)
	task.wait(1)
	Player.Character.PrimaryPart.CFrame = workspace.BeachPartyLocation.CFrame + Vector3.new(math.random(1, 30), 5, math.random(1, 30))
	Player.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Landed)
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
	Teleport.DeleteWater()
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
	Teleport.DeleteWater()
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
