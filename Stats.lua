local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local ClientData = require(ReplicatedStorage:WaitForChild("ClientModules"):WaitForChild("Core"):WaitForChild("ClientData"))

local StatsGuis = {}

local localPlayer = Players.LocalPlayer
-- Instances:

local StatsGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local NameFrame = Instance.new("Frame")
local TextLabel = Instance.new("TextLabel")
local UICorner = Instance.new("UICorner")
local UIListLayout = Instance.new("UIListLayout")
local TimeFrame = Instance.new("Frame")
local TextLabel_2 = Instance.new("TextLabel")
local UICorner_2 = Instance.new("UICorner")
local BucksAndPotionFrame = Instance.new("Frame")
local TextLabel_3 = Instance.new("TextLabel")
local UICorner_3 = Instance.new("UICorner")
local TotalFrame = Instance.new("Frame")
local TotalFrame1 = Instance.new("Frame")
local TextLabel_4 = Instance.new("TextLabel")
local UICorner_4 = Instance.new("UICorner")

local startCount = 0
local startBucksAmount = 0
local startTime = nil
--Properties:

StatsGui.Name = "StatsGui"
StatsGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
StatsGui.ResetOnSpawn = false
StatsGui.Parent = localPlayer:WaitForChild("PlayerGui")

MainFrame.Name = "MainFrame"
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
MainFrame.BackgroundTransparency = 1.000
MainFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.777189096, 0, 0.443002731, 0)
MainFrame.Size = UDim2.new(0.200000012, 0, 0.300000006, 0)
MainFrame.Parent = StatsGui

NameFrame.Name = "NameFrame"
NameFrame.AnchorPoint = Vector2.new(0.5, 0.5)
NameFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
NameFrame.BackgroundTransparency = 1.000
NameFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
NameFrame.BorderSizePixel = 0
NameFrame.Position = UDim2.new(0.5, 0, 0.119999997, 0)
NameFrame.Size = UDim2.new(1, 0, 0.25, 0)
NameFrame.Parent = MainFrame

TextLabel.AnchorPoint = Vector2.new(0.5, 0.5)
TextLabel.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
TextLabel.BackgroundTransparency = 0.500
TextLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
TextLabel.BorderSizePixel = 0
TextLabel.Position = UDim2.new(0.498873174, 0, 0.496309608, 0)
TextLabel.Size = UDim2.new(0.996291697, 0, 0.97639972, 0)
TextLabel.Font = Enum.Font.FredokaOne
TextLabel.Text = "Name"
TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.TextScaled = true
TextLabel.TextSize = 14.000
TextLabel.TextWrapped = true
TextLabel.Parent = NameFrame

UICorner.CornerRadius = UDim.new(0, 12)
UICorner.Parent = TextLabel

UIListLayout.Parent = MainFrame
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 6)

TimeFrame.Name = "TimeFrame"
TimeFrame.Parent = MainFrame
TimeFrame.AnchorPoint = Vector2.new(0.5, 0.5)
TimeFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TimeFrame.BackgroundTransparency = 1.000
TimeFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
TimeFrame.BorderSizePixel = 0
TimeFrame.Position = UDim2.new(0.5, 0, 0.119999997, 0)
TimeFrame.Size = UDim2.new(1, 0, 0.25, 0)

TextLabel_2.Parent = TimeFrame
TextLabel_2.AnchorPoint = Vector2.new(0.5, 0.5)
TextLabel_2.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
TextLabel_2.BackgroundTransparency = 0.500
TextLabel_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
TextLabel_2.BorderSizePixel = 0
TextLabel_2.Position = UDim2.new(0.498873174, 0, 0.496309608, 0)
TextLabel_2.Size = UDim2.new(0.996291697, 0, 0.97639972, 0)
TextLabel_2.Font = Enum.Font.FredokaOne
TextLabel_2.Text = "Name"
TextLabel_2.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel_2.TextScaled = true
TextLabel_2.TextSize = 14.000
TextLabel_2.TextWrapped = true

UICorner_2.CornerRadius = UDim.new(0, 12)
UICorner_2.Parent = TextLabel_2

BucksAndPotionFrame.Name = "BucksAndPotionFrame"
BucksAndPotionFrame.Parent = MainFrame
BucksAndPotionFrame.AnchorPoint = Vector2.new(0.5, 0.5)
BucksAndPotionFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
BucksAndPotionFrame.BackgroundTransparency = 1.000
BucksAndPotionFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
BucksAndPotionFrame.BorderSizePixel = 0
BucksAndPotionFrame.Position = UDim2.new(0.5, 0, 0.119999997, 0)
BucksAndPotionFrame.Size = UDim2.new(1, 0, 0.25, 0)

TextLabel_4.Parent = BucksAndPotionFrame
TextLabel_4.AnchorPoint = Vector2.new(0.5, 0.5)
TextLabel_4.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
TextLabel_4.BackgroundTransparency = 0.500
TextLabel_4.BorderColor3 = Color3.fromRGB(0, 0, 0)
TextLabel_4.BorderSizePixel = 0
TextLabel_4.Position = UDim2.new(0.498873174, 0, 0.496309608, 0)
TextLabel_4.Size = UDim2.new(0.996291697, 0, 0.97639972, 0)
TextLabel_4.Font = Enum.Font.FredokaOne
TextLabel_4.Text = "Name"
TextLabel_4.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel_4.TextScaled = true
TextLabel_4.TextSize = 14.000
TextLabel_4.TextWrapped = true

UICorner_4.CornerRadius = UDim.new(0, 12)
UICorner_4.Parent = TextLabel_4


TotalFrame.Name = "TotalFrame"
TotalFrame.Parent = MainFrame
TotalFrame.AnchorPoint = Vector2.new(0.5, 0.5)
TotalFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TotalFrame.BackgroundTransparency = 1.000
TotalFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
TotalFrame.BorderSizePixel = 0
TotalFrame.Position = UDim2.new(0.5, 0, 0.119999997, 0)
TotalFrame.Size = UDim2.new(1, 0, 0.25, 0)

TextLabel_3.Parent = TotalFrame
TextLabel_3.AnchorPoint = Vector2.new(0.5, 0.5)
TextLabel_3.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
TextLabel_3.BackgroundTransparency = 0.500
TextLabel_3.BorderColor3 = Color3.fromRGB(0, 0, 0)
TextLabel_3.BorderSizePixel = 0
TextLabel_3.Position = UDim2.new(0.498873174, 0, 0.496309608, 0)
TextLabel_3.Size = UDim2.new(0.996291697, 0, 0.97639972, 0)
TextLabel_3.Font = Enum.Font.FredokaOne
TextLabel_3.Text = "Name"
TextLabel_3.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel_3.TextScaled = true
TextLabel_3.TextSize = 14.000
TextLabel_3.TextWrapped = true

UICorner_3.CornerRadius = UDim.new(0, 12)
UICorner_3.Parent = TextLabel_3

TotalFrame1.Name = "TotalFrame1"
TotalFrame1.Parent = MainFrame
TotalFrame1.AnchorPoint = Vector2.new(0.5, 0.5)
TotalFrame1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TotalFrame1.BackgroundTransparency = 1.000
TotalFrame1.BorderColor3 = Color3.fromRGB(0, 0, 0)
TotalFrame1.BorderSizePixel = 0
TotalFrame1.Position = UDim2.new(0.5, 0, 0.119999997, 0)
TotalFrame1.Size = UDim2.new(1, 0, 0.25, 0)

TextLabel_5.Parent = TotalFrame1
TextLabel_5.AnchorPoint = Vector2.new(0.5, 0.5)
TextLabel_5.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
TextLabel_5.BackgroundTransparency = 0.500
TextLabel_5.BorderColor3 = Color3.fromRGB(0, 0, 0)
TextLabel_5.BorderSizePixel = 0
TextLabel_5.Position = UDim2.new(0.498873174, 0, 0.496309608, 0)
TextLabel_5.Size = UDim2.new(0.996291697, 0, 0.97639972, 0)
TextLabel_5.Font = Enum.Font.FredokaOne
TextLabel_5.Text = "Name"
TextLabel_5.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel_5.TextScaled = true
TextLabel_5.TextSize = 14.000
TextLabel_5.TextWrapped = true

UICorner_5.CornerRadius = UDim.new(0, 12)
UICorner_5.Parent = TextLabel_5


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
        MainFrame.BucksAndPotionFrame.TextLabel.Text = `🧪 {formatNumber(potionCount)} 💰 {formatNumber(bucks)}`
    elseif nameOfFrame == "TotalFrame" then
        local potionCount = agePotionCount()
        local bucks = bucksAmount()
        MainFrame.TotalFrame.TextLabel.Text = `Total 🧪 {formatNumber(potionCount)}`
    elseif nameOfFrame == "TotalFrame1" then
        local bucks = bucksAmount()
        MainFrame.TotalFrame1.TextLabel.Text = `Total 💰 {formatNumber(bucks)}`
    elseif nameOfFrame == "NameFrame" then
        MainFrame.NameFrame.TextLabel.Text = `😎 {localPlayer.Name}`
    end
end

return StatsGuis