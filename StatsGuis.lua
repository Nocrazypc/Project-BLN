local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local ClientData = require(ReplicatedStorage:WaitForChild("ClientModules"):WaitForChild("Core"):WaitForChild("ClientData"))

local StatsGuis = {}

local localPlayer = Players.LocalPlayer


local function setupScreenGui()
	local StatsGui = Instance.new("ScreenGui")
	local MainFrame = Instance.new("Frame")
	local UIListLayout = Instance.new("UIListLayout")
	
	StatsGui.Name = "StatsGui"
	StatsGui.ScreenInsets = Enum.ScreenInsets.None
	StatsGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	StatsGui.ResetOnSpawn = false
	StatsGui.Parent = localPlayer:WaitForChild("PlayerGui")

	MainFrame.Name = "MainFrame"
	MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
	MainFrame.BackgroundColor3 = Color3.fromRGB(8, 217, 214)
	MainFrame.BackgroundTransparency = 1
	MainFrame.BorderColor3 = Color3.fromRGB(255, 255, 255)
	MainFrame.BorderSizePixel = 0
	MainFrame.Position = UDim2.new(0.64, 0, 0.48, 0)
	MainFrame.Size = UDim2.new(0.6, 0, 0.7, 0)
	MainFrame.Parent = StatsGui

	UIListLayout.Parent = MainFrame
	UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout.Padding = UDim.new(0, 6)

end

local function setupFrame(name: string)
	local frame = Instance.new("Frame")
	frame.Name = name
	frame.AnchorPoint = Vector2.new(0.5, 0.5)
	frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	frame.BackgroundTransparency = 1
	frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
	frame.BorderSizePixel = 0
	frame.Position = UDim2.new(0.5, 0, 0.119999997, 0)
	frame.Size = UDim2.new(1, 0, 0.25, 0)
	frame.Parent = localPlayer.PlayerGui:WaitForChild("StatsGui"):WaitForChild("MainFrame")
	
	local textLabel = Instance.new("TextLabel")
	textLabel.AnchorPoint = Vector2.new(0.5, 0.5)
	textLabel.BackgroundColor3 = Color3.fromRGB(250, 129, 47)
	textLabel.BackgroundTransparency = 0.25
	textLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
	textLabel.BorderSizePixel = 0
	textLabel.Position = UDim2.new(0.498873174, 0, 0.496309608, 0)
	textLabel.Size = UDim2.new(0.996291697, 0, 0.97639972, 0)
	textLabel.Font = Enum.Font.FredokaOne
	textLabel.Text = "text"
	textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	textLabel.TextScaled = true
	textLabel.TextSize = 14.000
	textLabel.TextWrapped = true
	textLabel.Parent = frame
	
	local UICorner = Instance.new("UICorner")
	UICorner.CornerRadius = UDim.new(0, 12)
	UICorner.Parent = textLabel
end

local startCount = 0
local startBucksAmount = 0
local startTime = nil

setupScreenGui()

setupFrame("TimeFrame")
setupFrame("BucksAndPotionFrame")
setupFrame("TotalFrame")
setupFrame("NameFrame")

local function formatTime(currentTime)
	local hours = math.floor(currentTime / 3600)
	local minutes = math.floor((currentTime % 3600) / 60)
	return string.format("%02d:%02d", hours, minutes)
end

local function formatNumber(num)
	if num >= 1e6 then
		-- Millions
		return string.format("%.1fM", num / 1e6)
	elseif num >= 1e3 then
		-- Thousands
		return string.format("%.0fk", num / 1e3)
	else
		-- Less than a thousand
		return tostring(num)
	end
end


local function bucksAmount()
    return ClientData.get_data()[localPlayer.Name].money or 0
end

local function agePotionCount()
    local count = 0
    for _, v in ClientData.get_data()[localPlayer.Name].inventory.food do
        if v.id == "pet_age_potion" then
            count += 1
        end
    end
    return count
end

startCount = agePotionCount()
startBucksAmount = bucksAmount()
startTime = DateTime.now().UnixTimestamp

function StatsGuis:UpdateText(nameOfFrame: string)
    local MainFrame = localPlayer.PlayerGui.StatsGui.MainFrame

    if nameOfFrame == "TimeFrame" then
        local currentTime = DateTime.now().UnixTimestamp
        local timeElapsed = currentTime - startTime
        MainFrame.TimeFrame.TextLabel.Text = `🕒 {formatTime(timeElapsed)}`
    elseif nameOfFrame == "BucksAndPotionFrame" then
        local potionCount = agePotionCount() - startCount
        local bucks = bucksAmount() - startBucksAmount
        if potionCount <= 0 then potionCount = 0 end
        if bucks <= 0 then bucks = 0 end
        MainFrame.BucksAndPotionFrame.TextLabel.Text = `🧪 {formatNumber(potionCount)} 💰 {formatNumber(bucks)} 🍪 {0}`
    elseif nameOfFrame == "TotalFrame" then
        local potionCount = agePotionCount()
        local bucks = bucksAmount()
        MainFrame.TotalFrame.TextLabel.Text = `🧪 {formatNumber(potionCount)} 💰 {formatNumber(bucks)} 🍪 {0}`
    elseif nameOfFrame == "NameFrame" then
        MainFrame.NameFrame.TextLabel.Text = `🤖 {localPlayer.Name}`
    end
end

return StatsGuis