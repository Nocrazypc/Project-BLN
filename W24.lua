-----------------------------------------------------------------------------------------------
--[[ Services ]]--
-----------------------------------------------------------------------------------------------
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local UserGameSettings = UserSettings():GetService("UserGameSettings")
local VirtualUser = game:GetService("VirtualUser")
local CoreGui = game:GetService("CoreGui")
local StarterGui = game:GetService("StarterGui")

-----------------------------------------------------------------------------------------------
--[[ Modules ]]--
-----------------------------------------------------------------------------------------------
local ClientData = require(ReplicatedStorage:WaitForChild("ClientModules"):WaitForChild("Core"):WaitForChild("ClientData"))
local RouterClient = require(ReplicatedStorage.ClientModules.Core:WaitForChild("RouterClient"):WaitForChild("RouterClient"))
local CollisionsClient = require(ReplicatedStorage.ClientModules.Game:WaitForChild("CollisionsClient"))


local Player = Players.LocalPlayer

-----------------------------------------------------------------------------------------------
--[[ Private Variables ]]--
-----------------------------------------------------------------------------------------------
local banMessageConnection
local counter = 0
-- local diedCounter = 0
local isInMiniGame = false
local NewTaskBool = true
local NewClaimBool = true

--------------------------------

	local function onTextChangedMiniGame()
		do
			FireButton("Yes")

		end
	end

--------------------------
	local function PlaceFloorAtSpleefMinigame()
		if workspace:FindFirstChild("SpleefLocation") then return end

		local interiorOrigin = workspace:WaitForChild("Interiors"):WaitForChild("SpleefMinigame"):WaitForChild("InteriorOrigin")
		local part = Instance.new("Part")
		part.Position = interiorOrigin.Position
		part.Size = Vector3.new(200, 2, 200)
		part.Anchored = true
		part.Transparency = 0.5
		part.Name = "SpleefLocation"
		part.Parent = workspace
	end

	--// Fires when inside the minigame
	Player.PlayerGui.MinigameInGameApp:GetPropertyChangedSignal("Enabled"):Connect(function()
		if Player.PlayerGui.MinigameInGameApp.Enabled then
			Player.PlayerGui.MinigameInGameApp:WaitForChild("Body")
			Player.PlayerGui.MinigameInGameApp.Body:WaitForChild("Middle")
			Player.PlayerGui.MinigameInGameApp.Body.Middle:WaitForChild("Container")
			Player.PlayerGui.MinigameInGameApp.Body.Middle.Container:WaitForChild("TitleLabel")
			if Player.PlayerGui.MinigameInGameApp.Body.Middle.Container.TitleLabel.Text:match("MELT OFF") then
				isInMiniGame = true
				PlaceFloorAtSpleefMinigame()
				task.wait(2)
				Player.Character.PrimaryPart.CFrame = workspace:WaitForChild("SpleefLocation").CFrame + Vector3.new(0, 5, 0)
			end
		end
	end)


	local function RemoveGameOverButton()
		Player.PlayerGui.MinigameRewardsApp.Body.Button:WaitForChild("Face")
		for _, v in pairs(Player.PlayerGui.MinigameRewardsApp.Body.Button:GetDescendants()) do
			if v.Name == "TextLabel" then
				if v.Text == "NICE!" then
					task.wait(5)
					-- clickGuiButton(v.Parent.Parent, 30, 60)
					firesignal(v.Parent.Parent.MouseButton1Down)
					firesignal(v.Parent.Parent.MouseButton1Click)
					firesignal(v.Parent.Parent.MouseButton1Up)
					break
				end
			end
		end
	end



	-- fires when it ask you if you want to join minigame
	Player.PlayerGui.DialogApp.Dialog.ChildAdded:Connect(function(NormalDialogChild)
		if NormalDialogChild.Name == "NormalDialog" then
			NormalDialogChild:GetPropertyChangedSignal("Visible"):Connect(function()
				if NormalDialogChild.Visible then
					NormalDialogChild:WaitForChild("Info")
					NormalDialogChild.Info:WaitForChild("TextLabel")
					NormalDialogChild.Info.TextLabel:GetPropertyChangedSignal("Text"):Connect(function()
						if Player.PlayerGui.DialogApp.Dialog.NormalDialog.Info.TextLabel.Text:match("Melt Off") then
							onTextChangedMiniGame()
						elseif Player.PlayerGui.DialogApp.Dialog.NormalDialog.Info.TextLabel.Text:match("invitation") then
							game:Shutdown()
						elseif Player.PlayerGui.DialogApp.Dialog.NormalDialog.Info.TextLabel.Text:match("You found a") then
							FireButton("Okay")
						end
					end)
				end
			end)
		end
	end)


	Player.PlayerGui.DialogApp.Dialog.NormalDialog:GetPropertyChangedSignal("Visible"):Connect(function()
		if Player.PlayerGui.DialogApp.Dialog.NormalDialog.Visible then
			Player.PlayerGui.DialogApp.Dialog.NormalDialog:WaitForChild("Info")
			Player.PlayerGui.DialogApp.Dialog.NormalDialog.Info:WaitForChild("TextLabel")
			Player.PlayerGui.DialogApp.Dialog.NormalDialog.Info.TextLabel:GetPropertyChangedSignal("Text"):Connect(function()
				if Player.PlayerGui.DialogApp.Dialog.NormalDialog.Info.TextLabel.Text:match("Melt Off") then
					onTextChangedMiniGame()
				elseif Player.PlayerGui.DialogApp.Dialog.NormalDialog.Info.TextLabel.Text:match("invitation") then
					game:Shutdown()
				elseif Player.PlayerGui.DialogApp.Dialog.NormalDialog.Info.TextLabel.Text:match("You found a") then
					FireButton("Okay")
				end
			end)
		end
	end)

	workspace.StaticMap.spleef_minigame_minigame_state.players_loading:GetPropertyChangedSignal("Value"):Connect(function()
		if workspace.StaticMap.spleef_minigame_minigame_state.players_loading.Value then
			isInMiniGame = true
			task.wait(1)
			ReplicatedStorage.API:FindFirstChild("MinigameAPI/AttemptJoin"):FireServer("spleef_minigame", true)
		end
	end)




	Player.PlayerGui.MinigameRewardsApp.Body:GetPropertyChangedSignal("Visible"):Connect(function()
		if Player.PlayerGui.MinigameRewardsApp.Body.Visible then
			Player.PlayerGui.MinigameRewardsApp.Body:WaitForChild("Button")
			Player.PlayerGui.MinigameRewardsApp.Body.Button:WaitForChild("Face")
			Player.PlayerGui.MinigameRewardsApp.Body.Button.Face:WaitForChild("TextLabel")
			if Player.PlayerGui.MinigameRewardsApp.Body.Button.Face.TextLabel.Text:match("NICE!") then
				Player.Character.HumanoidRootPart.Anchored = false
				RemoveGameOverButton()
				isInMiniGame = false
				--Teleport.FarmingHome()
			end
		end
	end)

--[[	task.delay(30, function()
		while true do
			if isInMiniGame then
				local count = 0
				repeat
					--print(`⏱️ Waiting for 10 secs [inside minigame] ⏱️`)
					count += 10
					task.wait(10)
				until not isInMiniGame or count > 120
				isInMiniGame = false
			end


		end
	end)--]]


		
