local __DARKLUA_BUNDLE_MODULES

__DARKLUA_BUNDLE_MODULES = {
    cache = {},
    load = function(m)
        if not __DARKLUA_BUNDLE_MODULES.cache[m] then
            __DARKLUA_BUNDLE_MODULES.cache[m] = {
                c = __DARKLUA_BUNDLE_MODULES[m](),
            }
        end

        return __DARKLUA_BUNDLE_MODULES.cache[m].c
    end,
}

do
    function __DARKLUA_BUNDLE_MODULES.a()
        local InterfaceBuild = '9NBD'
        local Release = 'Build 1.67'
        local RayfieldFolder = 'Rayfield'
        local ConfigurationFolder = RayfieldFolder .. '/Configurations'
        local ConfigurationExtension = '.rfld'
        local settingsTable = {
            General = {
                rayfieldOpen = {
                    Type = 'bind',
                    Value = 'K',
                    Name = 'Rayfield Keybind',
                },
            },
            System = {
                usageAnalytics = {
                    Type = 'toggle',
                    Value = true,
                    Name = 'Anonymised Analytics',
                },
            },
        }
        local HttpService = game:GetService('HttpService')
        local RunService = game:GetService('RunService')
        local useStudio = RunService:IsStudio() or false
        local settingsCreated = false
        local cachedSettings
        local request = (syn and syn.request) or (fluxus and fluxus.request) or (http and http.request) or http_request or request
        local loadSettings = function()
            local file = nil

            if isfolder and isfolder(RayfieldFolder) then
                if isfile and isfile(RayfieldFolder .. '/settings' .. ConfigurationExtension) then
                    file = readfile(RayfieldFolder .. '/settings' .. ConfigurationExtension)
                end
            end
            if file then
                local success, decodedFile = pcall(function()
                    return HttpService:JSONDecode(file)
                end)

                if success then
                    file = decodedFile
                else
                    file = {}
                end
            else
                file = {}
            end
            if not settingsCreated then
                cachedSettings = file

                return
            end
            if file ~= {} then
                for categoryName, settingCategory in pairs(settingsTable)do
                    if file[categoryName] then
                        for settingName, setting in pairs(settingCategory)do
                            if file[categoryName][settingName] then
                                setting.Value = file[categoryName][settingName].Value

                                setting.Element:Set(setting.Value)
                            end
                        end
                    end
                end
            end
        end

        loadSettings()

        local RayfieldLibrary = {
            Flags = {},
            Theme = {
                Default = {
                    TextColor = Color3.fromRGB(240, 240, 240),
                    Background = Color3.fromRGB(25, 25, 25),
                    Topbar = Color3.fromRGB(34, 34, 34),
                    Shadow = Color3.fromRGB(20, 20, 20),
                    NotificationBackground = Color3.fromRGB(20, 20, 20),
                    NotificationActionsBackground = Color3.fromRGB(230, 230, 230),
                    TabBackground = Color3.fromRGB(80, 80, 80),
                    TabStroke = Color3.fromRGB(85, 85, 85),
                    TabBackgroundSelected = Color3.fromRGB(210, 210, 210),
                    TabTextColor = Color3.fromRGB(240, 240, 240),
                    SelectedTabTextColor = Color3.fromRGB(50, 50, 50),
                    ElementBackground = Color3.fromRGB(35, 35, 35),
                    ElementBackgroundHover = Color3.fromRGB(40, 40, 40),
                    SecondaryElementBackground = Color3.fromRGB(25, 25, 25),
                    ElementStroke = Color3.fromRGB(50, 50, 50),
                    SecondaryElementStroke = Color3.fromRGB(40, 40, 40),
                    SliderBackground = Color3.fromRGB(50, 138, 220),
                    SliderProgress = Color3.fromRGB(50, 138, 220),
                    SliderStroke = Color3.fromRGB(58, 163, 255),
                    ToggleBackground = Color3.fromRGB(30, 30, 30),
                    ToggleEnabled = Color3.fromRGB(0, 146, 214),
                    ToggleDisabled = Color3.fromRGB(100, 100, 100),
                    ToggleEnabledStroke = Color3.fromRGB(0, 170, 255),
                    ToggleDisabledStroke = Color3.fromRGB(125, 125, 125),
                    ToggleEnabledOuterStroke = Color3.fromRGB(100, 100, 100),
                    ToggleDisabledOuterStroke = Color3.fromRGB(65, 65, 65),
                    DropdownSelected = Color3.fromRGB(40, 40, 40),
                    DropdownUnselected = Color3.fromRGB(30, 30, 30),
                    InputBackground = Color3.fromRGB(30, 30, 30),
                    InputStroke = Color3.fromRGB(65, 65, 65),
                    PlaceholderColor = Color3.fromRGB(178, 178, 178),
                },
                Ocean = {
                    TextColor = Color3.fromRGB(230, 240, 240),
                    Background = Color3.fromRGB(20, 30, 30),
                    Topbar = Color3.fromRGB(25, 40, 40),
                    Shadow = Color3.fromRGB(15, 20, 20),
                    NotificationBackground = Color3.fromRGB(25, 35, 35),
                    NotificationActionsBackground = Color3.fromRGB(230, 240, 240),
                    TabBackground = Color3.fromRGB(40, 60, 60),
                    TabStroke = Color3.fromRGB(50, 70, 70),
                    TabBackgroundSelected = Color3.fromRGB(100, 180, 180),
                    TabTextColor = Color3.fromRGB(210, 230, 230),
                    SelectedTabTextColor = Color3.fromRGB(20, 50, 50),
                    ElementBackground = Color3.fromRGB(30, 50, 50),
                    ElementBackgroundHover = Color3.fromRGB(40, 60, 60),
                    SecondaryElementBackground = Color3.fromRGB(30, 45, 45),
                    ElementStroke = Color3.fromRGB(45, 70, 70),
                    SecondaryElementStroke = Color3.fromRGB(40, 65, 65),
                    SliderBackground = Color3.fromRGB(0, 110, 110),
                    SliderProgress = Color3.fromRGB(0, 140, 140),
                    SliderStroke = Color3.fromRGB(0, 160, 160),
                    ToggleBackground = Color3.fromRGB(30, 50, 50),
                    ToggleEnabled = Color3.fromRGB(0, 130, 130),
                    ToggleDisabled = Color3.fromRGB(70, 90, 90),
                    ToggleEnabledStroke = Color3.fromRGB(0, 160, 160),
                    ToggleDisabledStroke = Color3.fromRGB(85, 105, 105),
                    ToggleEnabledOuterStroke = Color3.fromRGB(50, 100, 100),
                    ToggleDisabledOuterStroke = Color3.fromRGB(45, 65, 65),
                    DropdownSelected = Color3.fromRGB(30, 60, 60),
                    DropdownUnselected = Color3.fromRGB(25, 40, 40),
                    InputBackground = Color3.fromRGB(30, 50, 50),
                    InputStroke = Color3.fromRGB(50, 70, 70),
                    PlaceholderColor = Color3.fromRGB(140, 160, 160),
                },
                AmberGlow = {
                    TextColor = Color3.fromRGB(255, 245, 230),
                    Background = Color3.fromRGB(45, 30, 20),
                    Topbar = Color3.fromRGB(55, 40, 25),
                    Shadow = Color3.fromRGB(35, 25, 15),
                    NotificationBackground = Color3.fromRGB(50, 35, 25),
                    NotificationActionsBackground = Color3.fromRGB(245, 230, 215),
                    TabBackground = Color3.fromRGB(75, 50, 35),
                    TabStroke = Color3.fromRGB(90, 60, 45),
                    TabBackgroundSelected = Color3.fromRGB(230, 180, 100),
                    TabTextColor = Color3.fromRGB(250, 220, 200),
                    SelectedTabTextColor = Color3.fromRGB(50, 30, 10),
                    ElementBackground = Color3.fromRGB(60, 45, 35),
                    ElementBackgroundHover = Color3.fromRGB(70, 50, 40),
                    SecondaryElementBackground = Color3.fromRGB(55, 40, 30),
                    ElementStroke = Color3.fromRGB(85, 60, 45),
                    SecondaryElementStroke = Color3.fromRGB(75, 50, 35),
                    SliderBackground = Color3.fromRGB(220, 130, 60),
                    SliderProgress = Color3.fromRGB(250, 150, 75),
                    SliderStroke = Color3.fromRGB(255, 170, 85),
                    ToggleBackground = Color3.fromRGB(55, 40, 30),
                    ToggleEnabled = Color3.fromRGB(240, 130, 30),
                    ToggleDisabled = Color3.fromRGB(90, 70, 60),
                    ToggleEnabledStroke = Color3.fromRGB(255, 160, 50),
                    ToggleDisabledStroke = Color3.fromRGB(110, 85, 75),
                    ToggleEnabledOuterStroke = Color3.fromRGB(200, 100, 50),
                    ToggleDisabledOuterStroke = Color3.fromRGB(75, 60, 55),
                    DropdownSelected = Color3.fromRGB(70, 50, 40),
                    DropdownUnselected = Color3.fromRGB(55, 40, 30),
                    InputBackground = Color3.fromRGB(60, 45, 35),
                    InputStroke = Color3.fromRGB(90, 65, 50),
                    PlaceholderColor = Color3.fromRGB(190, 150, 130),
                },
                Light = {
                    TextColor = Color3.fromRGB(40, 40, 40),
                    Background = Color3.fromRGB(245, 245, 245),
                    Topbar = Color3.fromRGB(230, 230, 230),
                    Shadow = Color3.fromRGB(200, 200, 200),
                    NotificationBackground = Color3.fromRGB(250, 250, 250),
                    NotificationActionsBackground = Color3.fromRGB(240, 240, 240),
                    TabBackground = Color3.fromRGB(235, 235, 235),
                    TabStroke = Color3.fromRGB(215, 215, 215),
                    TabBackgroundSelected = Color3.fromRGB(255, 255, 255),
                    TabTextColor = Color3.fromRGB(80, 80, 80),
                    SelectedTabTextColor = Color3.fromRGB(0, 0, 0),
                    ElementBackground = Color3.fromRGB(240, 240, 240),
                    ElementBackgroundHover = Color3.fromRGB(225, 225, 225),
                    SecondaryElementBackground = Color3.fromRGB(235, 235, 235),
                    ElementStroke = Color3.fromRGB(210, 210, 210),
                    SecondaryElementStroke = Color3.fromRGB(210, 210, 210),
                    SliderBackground = Color3.fromRGB(150, 180, 220),
                    SliderProgress = Color3.fromRGB(100, 150, 200),
                    SliderStroke = Color3.fromRGB(120, 170, 220),
                    ToggleBackground = Color3.fromRGB(220, 220, 220),
                    ToggleEnabled = Color3.fromRGB(0, 146, 214),
                    ToggleDisabled = Color3.fromRGB(150, 150, 150),
                    ToggleEnabledStroke = Color3.fromRGB(0, 170, 255),
                    ToggleDisabledStroke = Color3.fromRGB(170, 170, 170),
                    ToggleEnabledOuterStroke = Color3.fromRGB(100, 100, 100),
                    ToggleDisabledOuterStroke = Color3.fromRGB(180, 180, 180),
                    DropdownSelected = Color3.fromRGB(230, 230, 230),
                    DropdownUnselected = Color3.fromRGB(220, 220, 220),
                    InputBackground = Color3.fromRGB(240, 240, 240),
                    InputStroke = Color3.fromRGB(180, 180, 180),
                    PlaceholderColor = Color3.fromRGB(140, 140, 140),
                },
                Amethyst = {
                    TextColor = Color3.fromRGB(240, 240, 240),
                    Background = Color3.fromRGB(30, 20, 40),
                    Topbar = Color3.fromRGB(40, 25, 50),
                    Shadow = Color3.fromRGB(20, 15, 30),
                    NotificationBackground = Color3.fromRGB(35, 20, 40),
                    NotificationActionsBackground = Color3.fromRGB(240, 240, 250),
                    TabBackground = Color3.fromRGB(60, 40, 80),
                    TabStroke = Color3.fromRGB(70, 45, 90),
                    TabBackgroundSelected = Color3.fromRGB(180, 140, 200),
                    TabTextColor = Color3.fromRGB(230, 230, 240),
                    SelectedTabTextColor = Color3.fromRGB(50, 20, 50),
                    ElementBackground = Color3.fromRGB(45, 30, 60),
                    ElementBackgroundHover = Color3.fromRGB(50, 35, 70),
                    SecondaryElementBackground = Color3.fromRGB(40, 30, 55),
                    ElementStroke = Color3.fromRGB(70, 50, 85),
                    SecondaryElementStroke = Color3.fromRGB(65, 45, 80),
                    SliderBackground = Color3.fromRGB(100, 60, 150),
                    SliderProgress = Color3.fromRGB(130, 80, 180),
                    SliderStroke = Color3.fromRGB(150, 100, 200),
                    ToggleBackground = Color3.fromRGB(45, 30, 55),
                    ToggleEnabled = Color3.fromRGB(120, 60, 150),
                    ToggleDisabled = Color3.fromRGB(94, 47, 117),
                    ToggleEnabledStroke = Color3.fromRGB(140, 80, 170),
                    ToggleDisabledStroke = Color3.fromRGB(124, 71, 150),
                    ToggleEnabledOuterStroke = Color3.fromRGB(90, 40, 120),
                    ToggleDisabledOuterStroke = Color3.fromRGB(80, 50, 110),
                    DropdownSelected = Color3.fromRGB(50, 35, 70),
                    DropdownUnselected = Color3.fromRGB(35, 25, 50),
                    InputBackground = Color3.fromRGB(45, 30, 60),
                    InputStroke = Color3.fromRGB(80, 50, 110),
                    PlaceholderColor = Color3.fromRGB(178, 150, 200),
                },
                Green = {
                    TextColor = Color3.fromRGB(30, 60, 30),
                    Background = Color3.fromRGB(235, 245, 235),
                    Topbar = Color3.fromRGB(210, 230, 210),
                    Shadow = Color3.fromRGB(200, 220, 200),
                    NotificationBackground = Color3.fromRGB(240, 250, 240),
                    NotificationActionsBackground = Color3.fromRGB(220, 235, 220),
                    TabBackground = Color3.fromRGB(215, 235, 215),
                    TabStroke = Color3.fromRGB(190, 210, 190),
                    TabBackgroundSelected = Color3.fromRGB(245, 255, 245),
                    TabTextColor = Color3.fromRGB(50, 80, 50),
                    SelectedTabTextColor = Color3.fromRGB(20, 60, 20),
                    ElementBackground = Color3.fromRGB(225, 240, 225),
                    ElementBackgroundHover = Color3.fromRGB(210, 225, 210),
                    SecondaryElementBackground = Color3.fromRGB(235, 245, 235),
                    ElementStroke = Color3.fromRGB(180, 200, 180),
                    SecondaryElementStroke = Color3.fromRGB(180, 200, 180),
                    SliderBackground = Color3.fromRGB(90, 160, 90),
                    SliderProgress = Color3.fromRGB(70, 130, 70),
                    SliderStroke = Color3.fromRGB(100, 180, 100),
                    ToggleBackground = Color3.fromRGB(215, 235, 215),
                    ToggleEnabled = Color3.fromRGB(60, 130, 60),
                    ToggleDisabled = Color3.fromRGB(150, 175, 150),
                    ToggleEnabledStroke = Color3.fromRGB(80, 150, 80),
                    ToggleDisabledStroke = Color3.fromRGB(130, 150, 130),
                    ToggleEnabledOuterStroke = Color3.fromRGB(100, 160, 100),
                    ToggleDisabledOuterStroke = Color3.fromRGB(160, 180, 160),
                    DropdownSelected = Color3.fromRGB(225, 240, 225),
                    DropdownUnselected = Color3.fromRGB(210, 225, 210),
                    InputBackground = Color3.fromRGB(235, 245, 235),
                    InputStroke = Color3.fromRGB(180, 200, 180),
                    PlaceholderColor = Color3.fromRGB(120, 140, 120),
                },
                Bloom = {
                    TextColor = Color3.fromRGB(60, 40, 50),
                    Background = Color3.fromRGB(255, 240, 245),
                    Topbar = Color3.fromRGB(250, 220, 225),
                    Shadow = Color3.fromRGB(230, 190, 195),
                    NotificationBackground = Color3.fromRGB(255, 235, 240),
                    NotificationActionsBackground = Color3.fromRGB(245, 215, 225),
                    TabBackground = Color3.fromRGB(240, 210, 220),
                    TabStroke = Color3.fromRGB(230, 200, 210),
                    TabBackgroundSelected = Color3.fromRGB(255, 225, 235),
                    TabTextColor = Color3.fromRGB(80, 40, 60),
                    SelectedTabTextColor = Color3.fromRGB(50, 30, 50),
                    ElementBackground = Color3.fromRGB(255, 235, 240),
                    ElementBackgroundHover = Color3.fromRGB(245, 220, 230),
                    SecondaryElementBackground = Color3.fromRGB(255, 235, 240),
                    ElementStroke = Color3.fromRGB(230, 200, 210),
                    SecondaryElementStroke = Color3.fromRGB(230, 200, 210),
                    SliderBackground = Color3.fromRGB(240, 130, 160),
                    SliderProgress = Color3.fromRGB(250, 160, 180),
                    SliderStroke = Color3.fromRGB(255, 180, 200),
                    ToggleBackground = Color3.fromRGB(240, 210, 220),
                    ToggleEnabled = Color3.fromRGB(255, 140, 170),
                    ToggleDisabled = Color3.fromRGB(200, 180, 185),
                    ToggleEnabledStroke = Color3.fromRGB(250, 160, 190),
                    ToggleDisabledStroke = Color3.fromRGB(210, 180, 190),
                    ToggleEnabledOuterStroke = Color3.fromRGB(220, 160, 180),
                    ToggleDisabledOuterStroke = Color3.fromRGB(190, 170, 180),
                    DropdownSelected = Color3.fromRGB(250, 220, 225),
                    DropdownUnselected = Color3.fromRGB(240, 210, 220),
                    InputBackground = Color3.fromRGB(255, 235, 240),
                    InputStroke = Color3.fromRGB(220, 190, 200),
                    PlaceholderColor = Color3.fromRGB(170, 130, 140),
                },
                DarkBlue = {
                    TextColor = Color3.fromRGB(230, 230, 230),
                    Background = Color3.fromRGB(20, 25, 30),
                    Topbar = Color3.fromRGB(30, 35, 40),
                    Shadow = Color3.fromRGB(15, 20, 25),
                    NotificationBackground = Color3.fromRGB(25, 30, 35),
                    NotificationActionsBackground = Color3.fromRGB(45, 50, 55),
                    TabBackground = Color3.fromRGB(35, 40, 45),
                    TabStroke = Color3.fromRGB(45, 50, 60),
                    TabBackgroundSelected = Color3.fromRGB(40, 70, 100),
                    TabTextColor = Color3.fromRGB(200, 200, 200),
                    SelectedTabTextColor = Color3.fromRGB(255, 255, 255),
                    ElementBackground = Color3.fromRGB(30, 35, 40),
                    ElementBackgroundHover = Color3.fromRGB(40, 45, 50),
                    SecondaryElementBackground = Color3.fromRGB(35, 40, 45),
                    ElementStroke = Color3.fromRGB(45, 50, 60),
                    SecondaryElementStroke = Color3.fromRGB(40, 45, 55),
                    SliderBackground = Color3.fromRGB(0, 90, 180),
                    SliderProgress = Color3.fromRGB(0, 120, 210),
                    SliderStroke = Color3.fromRGB(0, 150, 240),
                    ToggleBackground = Color3.fromRGB(35, 40, 45),
                    ToggleEnabled = Color3.fromRGB(0, 120, 210),
                    ToggleDisabled = Color3.fromRGB(70, 70, 80),
                    ToggleEnabledStroke = Color3.fromRGB(0, 150, 240),
                    ToggleDisabledStroke = Color3.fromRGB(75, 75, 85),
                    ToggleEnabledOuterStroke = Color3.fromRGB(20, 100, 180),
                    ToggleDisabledOuterStroke = Color3.fromRGB(55, 55, 65),
                    DropdownSelected = Color3.fromRGB(30, 70, 90),
                    DropdownUnselected = Color3.fromRGB(25, 30, 35),
                    InputBackground = Color3.fromRGB(25, 30, 35),
                    InputStroke = Color3.fromRGB(45, 50, 60),
                    PlaceholderColor = Color3.fromRGB(150, 150, 160),
                },
                Serenity = {
                    TextColor = Color3.fromRGB(50, 55, 60),
                    Background = Color3.fromRGB(240, 245, 250),
                    Topbar = Color3.fromRGB(215, 225, 235),
                    Shadow = Color3.fromRGB(200, 210, 220),
                    NotificationBackground = Color3.fromRGB(210, 220, 230),
                    NotificationActionsBackground = Color3.fromRGB(225, 230, 240),
                    TabBackground = Color3.fromRGB(200, 210, 220),
                    TabStroke = Color3.fromRGB(180, 190, 200),
                    TabBackgroundSelected = Color3.fromRGB(175, 185, 200),
                    TabTextColor = Color3.fromRGB(50, 55, 60),
                    SelectedTabTextColor = Color3.fromRGB(30, 35, 40),
                    ElementBackground = Color3.fromRGB(210, 220, 230),
                    ElementBackgroundHover = Color3.fromRGB(220, 230, 240),
                    SecondaryElementBackground = Color3.fromRGB(200, 210, 220),
                    ElementStroke = Color3.fromRGB(190, 200, 210),
                    SecondaryElementStroke = Color3.fromRGB(180, 190, 200),
                    SliderBackground = Color3.fromRGB(200, 220, 235),
                    SliderProgress = Color3.fromRGB(70, 130, 180),
                    SliderStroke = Color3.fromRGB(150, 180, 220),
                    ToggleBackground = Color3.fromRGB(210, 220, 230),
                    ToggleEnabled = Color3.fromRGB(70, 160, 210),
                    ToggleDisabled = Color3.fromRGB(180, 180, 180),
                    ToggleEnabledStroke = Color3.fromRGB(60, 150, 200),
                    ToggleDisabledStroke = Color3.fromRGB(140, 140, 140),
                    ToggleEnabledOuterStroke = Color3.fromRGB(100, 120, 140),
                    ToggleDisabledOuterStroke = Color3.fromRGB(120, 120, 130),
                    DropdownSelected = Color3.fromRGB(220, 230, 240),
                    DropdownUnselected = Color3.fromRGB(200, 210, 220),
                    InputBackground = Color3.fromRGB(220, 230, 240),
                    InputStroke = Color3.fromRGB(180, 190, 200),
                    PlaceholderColor = Color3.fromRGB(150, 150, 150),
                },
            },
        }
        local CoreGui = game:GetService('CoreGui')
        local Players = game:GetService('Players')
        local TweenService = game:GetService('TweenService')
        local UserInputService = game:GetService('UserInputService')
        local Rayfield = useStudio and script.Parent:FindFirstChild('Rayfield') or game:GetObjects('rbxassetid://10804731440')[1]
        local buildAttempts = 0
        local correctBuild = false
        local warned
        local globalLoaded

        repeat
            if Rayfield:FindFirstChild('Build') and Rayfield.Build.Value == InterfaceBuild then
                correctBuild = true

                break
            end

            correctBuild = false

            if not warned then
                warn('Rayfield | Build Mismatch')
                print(
[[Rayfield may encounter issues as you are running an incompatible interface version (]] .. ((Rayfield:FindFirstChild('Build') and Rayfield.Build.Value) or 'No Build') .. 
[[).

This version of Rayfield is intended for interface build ]] .. InterfaceBuild .. '.')

                warned = true
            end

            toDestroy, Rayfield = Rayfield, useStudio and script.Parent:FindFirstChild('Rayfield') or game:GetObjects('rbxassetid://10804731440')[1]

            if toDestroy and not useStudio then
                toDestroy:Destroy()
            end

            buildAttempts = buildAttempts + 1
        until buildAttempts >= 2

        Rayfield.Enabled = false

        if gethui then
            Rayfield.Parent = gethui()
        elseif syn and syn.protect_gui then
            syn.protect_gui(Rayfield)

            Rayfield.Parent = CoreGui
        elseif not useStudio and CoreGui:FindFirstChild('RobloxGui') then
            Rayfield.Parent = CoreGui:FindFirstChild('RobloxGui')
        elseif not useStudio then
            Rayfield.Parent = CoreGui
        end
        if gethui then
            for _, Interface in ipairs(gethui():GetChildren())do
                if Interface.Name == Rayfield.Name and Interface ~= Rayfield then
                    Interface.Enabled = false
                    Interface.Name = 'Rayfield-Old'
                end
            end
        elseif not useStudio then
            for _, Interface in ipairs(CoreGui:GetChildren())do
                if Interface.Name == Rayfield.Name and Interface ~= Rayfield then
                    Interface.Enabled = false
                    Interface.Name = 'Rayfield-Old'
                end
            end
        end

        local minSize = Vector2.new(1024, 768)
        local useMobileSizing

        if Rayfield.AbsoluteSize.X < minSize.X and Rayfield.AbsoluteSize.Y < minSize.Y then
            useMobileSizing = true
        end
        if UserInputService.TouchEnabled then
            useMobilePrompt = true
        end

        local Main = Rayfield.Main
        local MPrompt = Rayfield:FindFirstChild('Prompt')
        local Topbar = Main.Topbar
        local Elements = Main.Elements
        local LoadingFrame = Main.LoadingFrame
        local TabList = Main.TabList
        local dragBar = Rayfield:FindFirstChild('Drag')
        local dragInteract = dragBar and dragBar.Interact or nil
        local dragBarCosmetic = dragBar and dragBar.Drag or nil
        local dragOffset = 255
        local dragOffsetMobile = 150

        Rayfield.DisplayOrder = 100
        LoadingFrame.Version.Text = Release

        local Icons = useStudio and require(script.Parent.icons) or loadstring(game:HttpGet(
[[https://raw.githubusercontent.com/SiriusSoftwareLtd/Rayfield/refs/heads/main/icons.lua]]))()
        local CFileName = nil
        local CEnabled = false
        local Minimised = false
        local Hidden = false
        local Debounce = false
        local searchOpen = false
        local Notifications = Rayfield.Notifications
        local SelectedTheme = RayfieldLibrary.Theme.Default
        local ChangeTheme = function(Theme)
            if typeof(Theme) == 'string' then
                SelectedTheme = RayfieldLibrary.Theme[Theme]
            elseif typeof(Theme) == 'table' then
                SelectedTheme = Theme
            end

            Rayfield.Main.BackgroundColor3 = SelectedTheme.Background
            Rayfield.Main.Topbar.BackgroundColor3 = SelectedTheme.Topbar
            Rayfield.Main.Topbar.CornerRepair.BackgroundColor3 = SelectedTheme.Topbar
            Rayfield.Main.Shadow.Image.ImageColor3 = SelectedTheme.Shadow
            Rayfield.Main.Topbar.ChangeSize.ImageColor3 = SelectedTheme.TextColor
            Rayfield.Main.Topbar.Hide.ImageColor3 = SelectedTheme.TextColor
            Rayfield.Main.Topbar.Search.ImageColor3 = SelectedTheme.TextColor

            if Topbar:FindFirstChild('Settings') then
                Rayfield.Main.Topbar.Settings.ImageColor3 = SelectedTheme.TextColor
                Rayfield.Main.Topbar.Divider.BackgroundColor3 = SelectedTheme.ElementStroke
            end

            Main.Search.BackgroundColor3 = SelectedTheme.TextColor
            Main.Search.Shadow.ImageColor3 = SelectedTheme.TextColor
            Main.Search.Search.ImageColor3 = SelectedTheme.TextColor
            Main.Search.Input.PlaceholderColor3 = SelectedTheme.TextColor
            Main.Search.UIStroke.Color = SelectedTheme.SecondaryElementStroke

            if Main:FindFirstChild('Notice') then
                Main.Notice.BackgroundColor3 = SelectedTheme.Background
            end

            for _, text in ipairs(Rayfield:GetDescendants())do
                if text.Parent.Parent ~= Notifications then
                    if text:IsA('TextLabel') or text:IsA('TextBox') then
                        text.TextColor3 = SelectedTheme.TextColor
                    end
                end
            end
            for _, TabPage in ipairs(Elements:GetChildren())do
                for _, Element in ipairs(TabPage:GetChildren())do
                    if Element.ClassName == 'Frame' and Element.Name ~= 'Placeholder' and Element.Name ~= 'SectionSpacing' and Element.Name ~= 'Divider' and Element.Name ~= 'SectionTitle' and Element.Name ~= 'SearchTitle-fsefsefesfsefesfesfThanks' then
                        Element.BackgroundColor3 = SelectedTheme.ElementBackground
                        Element.UIStroke.Color = SelectedTheme.ElementStroke
                    end
                end
            end
        end
        local getIcon = function(name)
            name = (string.match(string.lower(name), '^%s*(.*)%s*$'))

            local sizedicons = Icons['48px']
            local r = sizedicons[name]

            if not r then
                error('Lucide Icons: Failed to find icon by the name of "' .. name .. '.', 2)
            end

            local rirs = r[2]
            local riro = r[3]

            if type(r[1]) ~= 'number' or type(rirs) ~= 'table' or type(riro) ~= 'table' then
                error(
[[Lucide Icons: Internal error: Invalid auto-generated asset entry]])
            end

            local irs = Vector2.new(rirs[1], rirs[2])
            local iro = Vector2.new(riro[1], riro[2])
            local asset = {
                id = r[1],
                imageRectSize = irs,
                imageRectOffset = iro,
            }

            return asset
        end
        local makeDraggable = function(
            object,
            dragObject,
            enableTaptic,
            tapticOffset
        )
            local dragging = false
            local relative = nil
            local offset = Vector2.zero
            local screenGui = object:FindFirstAncestorWhichIsA('ScreenGui')

            if screenGui and screenGui.IgnoreGuiInset then
                offset = offset + game:GetService('GuiService'):GetGuiInset()
            end

            local connectFunctions = function()
                if dragBar and enableTaptic then
                    dragBar.MouseEnter:Connect(function()
                        if not dragging and not Hidden then
                            TweenService:Create(dragBarCosmetic, TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                                BackgroundTransparency = 0.5,
                                Size = UDim2.new(0, 120, 0, 4),
                            }):Play()
                        end
                    end)
                    dragBar.MouseLeave:Connect(function()
                        if not dragging and not Hidden then
                            TweenService:Create(dragBarCosmetic, TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                                BackgroundTransparency = 0.7,
                                Size = UDim2.new(0, 100, 0, 4),
                            }):Play()
                        end
                    end)
                end
            end

            connectFunctions()
            dragObject.InputBegan:Connect(function(input, processed)
                if processed then
                    return
                end

                local inputType = input.UserInputType.Name

                if inputType == 'MouseButton1' or inputType == 'Touch' then
                    dragging = true
                    relative = object.AbsolutePosition + object.AbsoluteSize * object.AnchorPoint - UserInputService:GetMouseLocation()

                    if enableTaptic and not Hidden then
                        TweenService:Create(dragBarCosmetic, TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                            Size = UDim2.new(0, 110, 0, 4),
                            BackgroundTransparency = 0,
                        }):Play()
                    end
                end
            end)

            local inputEnded = UserInputService.InputEnded:Connect(function(
                input
            )
                if not dragging then
                    return
                end

                local inputType = input.UserInputType.Name

                if inputType == 'MouseButton1' or inputType == 'Touch' then
                    dragging = false

                    connectFunctions()

                    if enableTaptic and not Hidden then
                        TweenService:Create(dragBarCosmetic, TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                            Size = UDim2.new(0, 100, 0, 4),
                            BackgroundTransparency = 0.7,
                        }):Play()
                    end
                end
            end)
            local renderStepped = RunService.RenderStepped:Connect(function()
                if dragging and not Hidden then
                    local position = UserInputService:GetMouseLocation() + relative + offset

                    if enableTaptic and tapticOffset then
                        TweenService:Create(object, TweenInfo.new(0.4, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
                            Position = UDim2.fromOffset(position.X, position.Y),
                        }):Play()
                        TweenService:Create(dragObject.Parent, TweenInfo.new(0.05, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
                            Position = UDim2.fromOffset(position.X, position.Y + ((useMobileSizing and tapticOffset[2]) or tapticOffset[1])),
                        }):Play()
                    else
                        if dragBar and tapticOffset then
                            dragBar.Position = UDim2.fromOffset(position.X, position.Y + ((useMobileSizing and tapticOffset[2]) or tapticOffset[1]))
                        end

                        object.Position = UDim2.fromOffset(position.X, position.Y)
                    end
                end
            end)

            object.Destroying:Connect(function()
                if inputEnded then
                    inputEnded:Disconnect()
                end
                if renderStepped then
                    renderStepped:Disconnect()
                end
            end)
        end
        local PackColor = function(Color)
            return {
                R = Color.R * 255,
                G = Color.G * 255,
                B = Color.B * 255,
            }
        end
        local UnpackColor = function(Color)
            return Color3.fromRGB(Color.R, Color.G, Color.B)
        end
        local LoadConfiguration = function(Configuration)
            local Data = HttpService:JSONDecode(Configuration)
            local changed

            for FlagName, Flag in pairs(RayfieldLibrary.Flags)do
                local FlagValue = Data[FlagName]

                if (typeof(FlagValue) == 'boolean' and FlagValue == false) or FlagValue then
                    task.spawn(function()
                        if Flag.Type == 'ColorPicker' then
                            changed = true

                            Flag:Set(UnpackColor(FlagValue))
                        else
                            if (Flag.CurrentValue or Flag.CurrentKeybind or Flag.CurrentOption or Flag.Color) ~= FlagValue then
                                changed = true

                                Flag:Set(FlagValue)
                            end
                        end
                    end)
                else
                    warn("Rayfield | Unable to find '" .. FlagName .. "' in the save file.")
                    print(
[[The error above may not be an issue if new elements have been added or not been set values.]])
                end
            end

            return changed
        end
        local SaveConfiguration = function()
            if not CEnabled or not globalLoaded then
                return
            end
            if debugX then
                print('Saving')
            end

            local Data = {}

            for i, v in pairs(RayfieldLibrary.Flags)do
                if v.Type == 'ColorPicker' then
                    Data[i] = PackColor(v.Color)
                else
                    if typeof(v.CurrentValue) == 'boolean' then
                        if v.CurrentValue == false then
                            Data[i] = false
                        else
                            Data[i] = v.CurrentValue or v.CurrentKeybind or v.CurrentOption or v.Color
                        end
                    else
                        Data[i] = v.CurrentValue or v.CurrentKeybind or v.CurrentOption or v.Color
                    end
                end
            end

            if useStudio then
                if script.Parent:FindFirstChild('configuration') then
                    script.Parent.configuration:Destroy()
                end

                local ScreenGui = Instance.new('ScreenGui')

                ScreenGui.Parent = script.Parent
                ScreenGui.Name = 'configuration'

                local TextBox = Instance.new('TextBox')

                TextBox.Parent = ScreenGui
                TextBox.Size = UDim2.new(0, 800, 0, 50)
                TextBox.AnchorPoint = Vector2.new(0.5, 0)
                TextBox.Position = UDim2.new(0.5, 0, 0, 30)
                TextBox.Text = HttpService:JSONEncode(Data)
                TextBox.ClearTextOnFocus = false
            end
            if debugX then
                warn(HttpService:JSONEncode(Data))
            end
            if writefile then
                writefile(ConfigurationFolder .. '/' .. CFileName .. ConfigurationExtension, tostring(HttpService:JSONEncode(Data)))
            end
        end

        function RayfieldLibrary:Notify(data)
            task.spawn(function()
                local newNotification = Notifications.Template:Clone()

                newNotification.Name = data.Title or 'No Title Provided'
                newNotification.Parent = Notifications
                newNotification.LayoutOrder = #Notifications:GetChildren()
                newNotification.Visible = false
                newNotification.Title.Text = data.Title or 'Unknown Title'
                newNotification.Description.Text = data.Content or 'Unknown Content'

                if data.Image then
                    if typeof(data.Image) == 'string' then
                        local asset = getIcon(data.Image)

                        newNotification.Icon.Image = 'rbxassetid://' .. asset.id
                        newNotification.Icon.ImageRectOffset = asset.imageRectOffset
                        newNotification.Icon.ImageRectSize = asset.imageRectSize
                    else
                        newNotification.Icon.Image = 'rbxassetid://' .. (data.Image or 0)
                    end
                else
                    newNotification.Icon.Image = 'rbxassetid://0'
                end

                newNotification.Title.TextColor3 = SelectedTheme.TextColor
                newNotification.Description.TextColor3 = SelectedTheme.TextColor
                newNotification.BackgroundColor3 = SelectedTheme.Background
                newNotification.UIStroke.Color = SelectedTheme.TextColor
                newNotification.Icon.ImageColor3 = SelectedTheme.TextColor
                newNotification.BackgroundTransparency = 1
                newNotification.Title.TextTransparency = 1
                newNotification.Description.TextTransparency = 1
                newNotification.UIStroke.Transparency = 1
                newNotification.Shadow.ImageTransparency = 1
                newNotification.Size = UDim2.new(1, 0, 0, 800)
                newNotification.Icon.ImageTransparency = 1
                newNotification.Icon.BackgroundTransparency = 1

                task.wait()

                newNotification.Visible = true

                if data.Actions then
                    warn('Rayfield | Not seeing your actions in notifications?')
                    print(
[[Notification Actions are being sunset for now, keep up to date on when they're back in the discord. (sirius.menu/discord)]])
                end

                local bounds = {
                    newNotification.Title.TextBounds.Y,
                    newNotification.Description.TextBounds.Y,
                }

                newNotification.Size = UDim2.new(1, -60, 0, -Notifications:FindFirstChild('UIListLayout').Padding.Offset)
                newNotification.Icon.Size = UDim2.new(0, 32, 0, 32)
                newNotification.Icon.Position = UDim2.new(0, 20, 0.5, 0)

                TweenService:Create(newNotification, TweenInfo.new(0.6, Enum.EasingStyle.Exponential), {
                    Size = UDim2.new(1, 0, 0, math.max(bounds[1] + bounds[2] + 31, 60)),
                }):Play()
                task.wait(0.15)
                TweenService:Create(newNotification, TweenInfo.new(0.4, Enum.EasingStyle.Exponential), {BackgroundTransparency = 0.45}):Play()
                TweenService:Create(newNotification.Title, TweenInfo.new(0.3, Enum.EasingStyle.Exponential), {TextTransparency = 0}):Play()
                task.wait(0.05)
                TweenService:Create(newNotification.Icon, TweenInfo.new(0.3, Enum.EasingStyle.Exponential), {ImageTransparency = 0}):Play()
                task.wait(0.05)
                TweenService:Create(newNotification.Description, TweenInfo.new(0.3, Enum.EasingStyle.Exponential), {TextTransparency = 0.35}):Play()
                TweenService:Create(newNotification.UIStroke, TweenInfo.new(0.4, Enum.EasingStyle.Exponential), {Transparency = 0.95}):Play()
                TweenService:Create(newNotification.Shadow, TweenInfo.new(0.3, Enum.EasingStyle.Exponential), {ImageTransparency = 0.82}):Play()

                local waitDuration = math.min(math.max((#newNotification.Description.Text * 0.1) + 2.5, 3), 10)

                task.wait(data.Duration or waitDuration)

                newNotification.Icon.Visible = false

                TweenService:Create(newNotification, TweenInfo.new(0.4, Enum.EasingStyle.Exponential), {BackgroundTransparency = 1}):Play()
                TweenService:Create(newNotification.UIStroke, TweenInfo.new(0.4, Enum.EasingStyle.Exponential), {Transparency = 1}):Play()
                TweenService:Create(newNotification.Shadow, TweenInfo.new(0.3, Enum.EasingStyle.Exponential), {ImageTransparency = 1}):Play()
                TweenService:Create(newNotification.Title, TweenInfo.new(0.3, Enum.EasingStyle.Exponential), {TextTransparency = 1}):Play()
                TweenService:Create(newNotification.Description, TweenInfo.new(0.3, Enum.EasingStyle.Exponential), {TextTransparency = 1}):Play()
                TweenService:Create(newNotification, TweenInfo.new(1, Enum.EasingStyle.Exponential), {
                    Size = UDim2.new(1, -90, 0, 0),
                }):Play()
                task.wait(1)
                TweenService:Create(newNotification, TweenInfo.new(1, Enum.EasingStyle.Exponential), {
                    Size = UDim2.new(1, -90, 0, -Notifications:FindFirstChild('UIListLayout').Padding.Offset),
                }):Play()

                newNotification.Visible = false

                newNotification:Destroy()
            end)
        end

        local openSearch = function()
            searchOpen = true
            Main.Search.BackgroundTransparency = 1
            Main.Search.Shadow.ImageTransparency = 1
            Main.Search.Input.TextTransparency = 1
            Main.Search.Search.ImageTransparency = 1
            Main.Search.UIStroke.Transparency = 1
            Main.Search.Size = UDim2.new(1, 0, 0, 80)
            Main.Search.Position = UDim2.new(0.5, 0, 0, 70)
            Main.Search.Input.Interactable = true
            Main.Search.Visible = true

            for _, tabbtn in ipairs(TabList:GetChildren())do
                if tabbtn.ClassName == 'Frame' and tabbtn.Name ~= 'Placeholder' then
                    tabbtn.Interact.Visible = false

                    TweenService:Create(tabbtn, TweenInfo.new(0.3, Enum.EasingStyle.Exponential), {BackgroundTransparency = 1}):Play()
                    TweenService:Create(tabbtn.Title, TweenInfo.new(0.3, Enum.EasingStyle.Exponential), {TextTransparency = 1}):Play()
                    TweenService:Create(tabbtn.Image, TweenInfo.new(0.3, Enum.EasingStyle.Exponential), {ImageTransparency = 1}):Play()
                    TweenService:Create(tabbtn.UIStroke, TweenInfo.new(0.3, Enum.EasingStyle.Exponential), {Transparency = 1}):Play()
                end
            end

            Main.Search.Input:CaptureFocus()
            TweenService:Create(Main.Search.Shadow, TweenInfo.new(0.05, Enum.EasingStyle.Quint), {ImageTransparency = 0.95}):Play()
            TweenService:Create(Main.Search, TweenInfo.new(0.3, Enum.EasingStyle.Exponential), {
                Position = UDim2.new(0.5, 0, 0, 57),
                BackgroundTransparency = 0.9,
            }):Play()
            TweenService:Create(Main.Search.UIStroke, TweenInfo.new(0.3, Enum.EasingStyle.Exponential), {Transparency = 0.8}):Play()
            TweenService:Create(Main.Search.Input, TweenInfo.new(0.3, Enum.EasingStyle.Exponential), {TextTransparency = 0.2}):Play()
            TweenService:Create(Main.Search.Search, TweenInfo.new(0.3, Enum.EasingStyle.Exponential), {ImageTransparency = 0.5}):Play()
            TweenService:Create(Main.Search, TweenInfo.new(0.5, Enum.EasingStyle.Exponential), {
                Size = UDim2.new(1, -35, 0, 35),
            }):Play()
        end
        local closeSearch = function()
            searchOpen = false

            TweenService:Create(Main.Search, TweenInfo.new(0.35, Enum.EasingStyle.Quint), {
                BackgroundTransparency = 1,
                Size = UDim2.new(1, -55, 0, 30),
            }):Play()
            TweenService:Create(Main.Search.Search, TweenInfo.new(0.15, Enum.EasingStyle.Quint), {ImageTransparency = 1}):Play()
            TweenService:Create(Main.Search.Shadow, TweenInfo.new(0.15, Enum.EasingStyle.Quint), {ImageTransparency = 1}):Play()
            TweenService:Create(Main.Search.UIStroke, TweenInfo.new(0.15, Enum.EasingStyle.Quint), {Transparency = 1}):Play()
            TweenService:Create(Main.Search.Input, TweenInfo.new(0.15, Enum.EasingStyle.Quint), {TextTransparency = 1}):Play()

            for _, tabbtn in ipairs(TabList:GetChildren())do
                if tabbtn.ClassName == 'Frame' and tabbtn.Name ~= 'Placeholder' then
                    tabbtn.Interact.Visible = true

                    if tostring(Elements.UIPageLayout.CurrentPage) == tabbtn.Title.Text then
                        TweenService:Create(tabbtn, TweenInfo.new(0.3, Enum.EasingStyle.Exponential), {BackgroundTransparency = 0}):Play()
                        TweenService:Create(tabbtn.Image, TweenInfo.new(0.3, Enum.EasingStyle.Exponential), {ImageTransparency = 0}):Play()
                        TweenService:Create(tabbtn.Title, TweenInfo.new(0.3, Enum.EasingStyle.Exponential), {TextTransparency = 0}):Play()
                        TweenService:Create(tabbtn.UIStroke, TweenInfo.new(0.3, Enum.EasingStyle.Exponential), {Transparency = 1}):Play()
                    else
                        TweenService:Create(tabbtn, TweenInfo.new(0.3, Enum.EasingStyle.Exponential), {BackgroundTransparency = 0.7}):Play()
                        TweenService:Create(tabbtn.Image, TweenInfo.new(0.3, Enum.EasingStyle.Exponential), {ImageTransparency = 0.2}):Play()
                        TweenService:Create(tabbtn.Title, TweenInfo.new(0.3, Enum.EasingStyle.Exponential), {TextTransparency = 0.2}):Play()
                        TweenService:Create(tabbtn.UIStroke, TweenInfo.new(0.3, Enum.EasingStyle.Exponential), {Transparency = 0.5}):Play()
                    end
                end
            end

            Main.Search.Input.Text = ''
            Main.Search.Input.Interactable = false
        end
        local Hide = function(notify)
            if MPrompt then
                MPrompt.Title.TextColor3 = Color3.fromRGB(255, 255, 255)
                MPrompt.Position = UDim2.new(0.5, 0, 0, -50)
                MPrompt.Size = UDim2.new(0, 40, 0, 10)
                MPrompt.BackgroundTransparency = 1
                MPrompt.Title.TextTransparency = 1
                MPrompt.Visible = true
            end

            task.spawn(closeSearch)

            Debounce = true

            if notify then
                if useMobilePrompt then
                    RayfieldLibrary:Notify({
                        Title = 'Interface Hidden',
                        Content = 
[[The interface has been hidden, you can unhide the interface by tapping 'Show Rayfield'.]],
                        Duration = 7,
                        Image = 4400697855,
                    })
                else
                    RayfieldLibrary:Notify({
                        Title = 'Interface Hidden',
                        Content = string.format(
[[The interface has been hidden, you can unhide the interface by tapping %s.]], tostring(settingsTable.General.rayfieldOpen.Value or 'K')),
                        Duration = 7,
                        Image = 4400697855,
                    })
                end
            end

            TweenService:Create(Main, TweenInfo.new(0.5, Enum.EasingStyle.Exponential), {
                Size = UDim2.new(0, 470, 0, 0),
            }):Play()
            TweenService:Create(Main.Topbar, TweenInfo.new(0.5, Enum.EasingStyle.Exponential), {
                Size = UDim2.new(0, 470, 0, 45),
            }):Play()
            TweenService:Create(Main, TweenInfo.new(0.5, Enum.EasingStyle.Exponential), {BackgroundTransparency = 1}):Play()
            TweenService:Create(Main.Topbar, TweenInfo.new(0.5, Enum.EasingStyle.Exponential), {BackgroundTransparency = 1}):Play()
            TweenService:Create(Main.Topbar.Divider, TweenInfo.new(0.5, Enum.EasingStyle.Exponential), {BackgroundTransparency = 1}):Play()
            TweenService:Create(Main.Topbar.CornerRepair, TweenInfo.new(0.3, Enum.EasingStyle.Exponential), {BackgroundTransparency = 1}):Play()
            TweenService:Create(Main.Topbar.Title, TweenInfo.new(0.5, Enum.EasingStyle.Exponential), {TextTransparency = 1}):Play()
            TweenService:Create(Main.Shadow.Image, TweenInfo.new(0.5, Enum.EasingStyle.Exponential), {ImageTransparency = 1}):Play()
            TweenService:Create(Topbar.UIStroke, TweenInfo.new(0.5, Enum.EasingStyle.Exponential), {Transparency = 1}):Play()
            TweenService:Create(dragBarCosmetic, TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {BackgroundTransparency = 1}):Play()

            if useMobilePrompt and MPrompt then
                TweenService:Create(MPrompt, TweenInfo.new(0.5, Enum.EasingStyle.Exponential), {
                    Size = UDim2.new(0, 120, 0, 30),
                    Position = UDim2.new(0.5, 0, 0, 20),
                    BackgroundTransparency = 0.3,
                }):Play()
                TweenService:Create(MPrompt.Title, TweenInfo.new(0.5, Enum.EasingStyle.Exponential), {TextTransparency = 0.3}):Play()
            end

            for _, TopbarButton in ipairs(Topbar:GetChildren())do
                if TopbarButton.ClassName == 'ImageButton' then
                    TweenService:Create(TopbarButton, TweenInfo.new(0.5, Enum.EasingStyle.Exponential), {ImageTransparency = 1}):Play()
                end
            end
            for _, tabbtn in ipairs(TabList:GetChildren())do
                if tabbtn.ClassName == 'Frame' and tabbtn.Name ~= 'Placeholder' then
                    TweenService:Create(tabbtn, TweenInfo.new(0.3, Enum.EasingStyle.Exponential), {BackgroundTransparency = 1}):Play()
                    TweenService:Create(tabbtn.Title, TweenInfo.new(0.3, Enum.EasingStyle.Exponential), {TextTransparency = 1}):Play()
                    TweenService:Create(tabbtn.Image, TweenInfo.new(0.3, Enum.EasingStyle.Exponential), {ImageTransparency = 1}):Play()
                    TweenService:Create(tabbtn.UIStroke, TweenInfo.new(0.3, Enum.EasingStyle.Exponential), {Transparency = 1}):Play()
                end
            end

            dragInteract.Visible = false

            for _, tab in ipairs(Elements:GetChildren())do
                if tab.Name ~= 'Template' and tab.ClassName == 'ScrollingFrame' and tab.Name ~= 'Placeholder' then
                    for _, element in ipairs(tab:GetChildren())do
                        if element.ClassName == 'Frame' then
                            if element.Name ~= 'SectionSpacing' and element.Name ~= 'Placeholder' then
                                if element.Name == 'SectionTitle' or element.Name == 'SearchTitle-fsefsefesfsefesfesfThanks' then
                                    TweenService:Create(element.Title, TweenInfo.new(0.3, Enum.EasingStyle.Exponential), {TextTransparency = 1}):Play()
                                elseif element.Name == 'Divider' then
                                    TweenService:Create(element.Divider, TweenInfo.new(0.3, Enum.EasingStyle.Exponential), {BackgroundTransparency = 1}):Play()
                                else
                                    TweenService:Create(element, TweenInfo.new(0.3, Enum.EasingStyle.Exponential), {BackgroundTransparency = 1}):Play()
                                    TweenService:Create(element.UIStroke, TweenInfo.new(0.3, Enum.EasingStyle.Exponential), {Transparency = 1}):Play()
                                    TweenService:Create(element.Title, TweenInfo.new(0.3, Enum.EasingStyle.Exponential), {TextTransparency = 1}):Play()
                                end

                                for _, child in ipairs(element:GetChildren())do
                                    if child.ClassName == 'Frame' or child.ClassName == 'TextLabel' or child.ClassName == 'TextBox' or child.ClassName == 'ImageButton' or child.ClassName == 'ImageLabel' then
                                        child.Visible = false
                                    end
                                end
                            end
                        end
                    end
                end
            end

            task.wait(0.5)

            Main.Visible = false
            Debounce = false
        end
        local Maximise = function()
            Debounce = true
            Topbar.ChangeSize.Image = 'rbxassetid://10137941941'

            TweenService:Create(Topbar.UIStroke, TweenInfo.new(0.5, Enum.EasingStyle.Exponential), {Transparency = 1}):Play()
            TweenService:Create(Main.Shadow.Image, TweenInfo.new(0.5, Enum.EasingStyle.Exponential), {ImageTransparency = 0.6}):Play()
            TweenService:Create(Topbar.CornerRepair, TweenInfo.new(0.5, Enum.EasingStyle.Exponential), {BackgroundTransparency = 0}):Play()
            TweenService:Create(Topbar.Divider, TweenInfo.new(0.5, Enum.EasingStyle.Exponential), {BackgroundTransparency = 0}):Play()
            TweenService:Create(dragBarCosmetic, TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {BackgroundTransparency = 0.7}):Play()
            TweenService:Create(Main, TweenInfo.new(0.5, Enum.EasingStyle.Exponential), {
                Size = useMobileSizing and UDim2.new(0, 500, 0, 275) or UDim2.new(0, 500, 0, 475),
            }):Play()
            TweenService:Create(Topbar, TweenInfo.new(0.5, Enum.EasingStyle.Exponential), {
                Size = UDim2.new(0, 500, 0, 45),
            }):Play()

            TabList.Visible = true

            task.wait(0.2)

            Elements.Visible = true

            for _, tab in ipairs(Elements:GetChildren())do
                if tab.Name ~= 'Template' and tab.ClassName == 'ScrollingFrame' and tab.Name ~= 'Placeholder' then
                    for _, element in ipairs(tab:GetChildren())do
                        if element.ClassName == 'Frame' then
                            if element.Name ~= 'SectionSpacing' and element.Name ~= 'Placeholder' then
                                if element.Name == 'SectionTitle' or element.Name == 'SearchTitle-fsefsefesfsefesfesfThanks' then
                                    TweenService:Create(element.Title, TweenInfo.new(0.3, Enum.EasingStyle.Exponential), {TextTransparency = 0.4}):Play()
                                elseif element.Name == 'Divider' then
                                    TweenService:Create(element.Divider, TweenInfo.new(0.3, Enum.EasingStyle.Exponential), {BackgroundTransparency = 0.85}):Play()
                                else
                                    TweenService:Create(element, TweenInfo.new(0.3, Enum.EasingStyle.Exponential), {BackgroundTransparency = 0}):Play()
                                    TweenService:Create(element.UIStroke, TweenInfo.new(0.3, Enum.EasingStyle.Exponential), {Transparency = 0}):Play()
                                    TweenService:Create(element.Title, TweenInfo.new(0.3, Enum.EasingStyle.Exponential), {TextTransparency = 0}):Play()
                                end

                                for _, child in ipairs(element:GetChildren())do
                                    if child.ClassName == 'Frame' or child.ClassName == 'TextLabel' or child.ClassName == 'TextBox' or child.ClassName == 'ImageButton' or child.ClassName == 'ImageLabel' then
                                        child.Visible = true
                                    end
                                end
                            end
                        end
                    end
                end
            end

            task.wait(0.1)

            for _, tabbtn in ipairs(TabList:GetChildren())do
                if tabbtn.ClassName == 'Frame' and tabbtn.Name ~= 'Placeholder' then
                    if tostring(Elements.UIPageLayout.CurrentPage) == tabbtn.Title.Text then
                        TweenService:Create(tabbtn, TweenInfo.new(0.3, Enum.EasingStyle.Exponential), {BackgroundTransparency = 0}):Play()
                        TweenService:Create(tabbtn.Image, TweenInfo.new(0.3, Enum.EasingStyle.Exponential), {ImageTransparency = 0}):Play()
                        TweenService:Create(tabbtn.Title, TweenInfo.new(0.3, Enum.EasingStyle.Exponential), {TextTransparency = 0}):Play()
                        TweenService:Create(tabbtn.UIStroke, TweenInfo.new(0.3, Enum.EasingStyle.Exponential), {Transparency = 1}):Play()
                    else
                        TweenService:Create(tabbtn, TweenInfo.new(0.3, Enum.EasingStyle.Exponential), {BackgroundTransparency = 0.7}):Play()
                        TweenService:Create(tabbtn.Image, TweenInfo.new(0.3, Enum.EasingStyle.Exponential), {ImageTransparency = 0.2}):Play()
                        TweenService:Create(tabbtn.Title, TweenInfo.new(0.3, Enum.EasingStyle.Exponential), {TextTransparency = 0.2}):Play()
                        TweenService:Create(tabbtn.UIStroke, TweenInfo.new(0.3, Enum.EasingStyle.Exponential), {Transparency = 0.5}):Play()
                    end
                end
            end

            task.wait(0.5)

            Debounce = false
        end
        local Unhide = function()
            Debounce = true
            Main.Position = UDim2.new(0.5, 0, 0.5, 0)
            Main.Visible = true

            TweenService:Create(Main, TweenInfo.new(0.5, Enum.EasingStyle.Exponential), {
                Size = useMobileSizing and UDim2.new(0, 500, 0, 275) or UDim2.new(0, 500, 0, 475),
            }):Play()
            TweenService:Create(Main.Topbar, TweenInfo.new(0.5, Enum.EasingStyle.Exponential), {
                Size = UDim2.new(0, 500, 0, 45),
            }):Play()
            TweenService:Create(Main.Shadow.Image, TweenInfo.new(0.7, Enum.EasingStyle.Exponential), {ImageTransparency = 0.6}):Play()
            TweenService:Create(Main, TweenInfo.new(0.5, Enum.EasingStyle.Exponential), {BackgroundTransparency = 0}):Play()
            TweenService:Create(Main.Topbar, TweenInfo.new(0.5, Enum.EasingStyle.Exponential), {BackgroundTransparency = 0}):Play()
            TweenService:Create(Main.Topbar.Divider, TweenInfo.new(0.5, Enum.EasingStyle.Exponential), {BackgroundTransparency = 0}):Play()
            TweenService:Create(Main.Topbar.CornerRepair, TweenInfo.new(0.5, Enum.EasingStyle.Exponential), {BackgroundTransparency = 0}):Play()
            TweenService:Create(Main.Topbar.Title, TweenInfo.new(0.5, Enum.EasingStyle.Exponential), {TextTransparency = 0}):Play()

            if MPrompt then
                TweenService:Create(MPrompt, TweenInfo.new(0.5, Enum.EasingStyle.Exponential), {
                    Size = UDim2.new(0, 40, 0, 10),
                    Position = UDim2.new(0.5, 0, 0, -50),
                    BackgroundTransparency = 1,
                }):Play()
                TweenService:Create(MPrompt.Title, TweenInfo.new(0.5, Enum.EasingStyle.Exponential), {TextTransparency = 1}):Play()
                task.spawn(function()
                    task.wait(0.5)

                    MPrompt.Visible = false
                end)
            end
            if Minimised then
                task.spawn(Maximise)
            end

            dragBar.Position = useMobileSizing and UDim2.new(0.5, 0, 0.5, dragOffsetMobile) or UDim2.new(0.5, 0, 0.5, dragOffset)
            dragInteract.Visible = true

            for _, TopbarButton in ipairs(Topbar:GetChildren())do
                if TopbarButton.ClassName == 'ImageButton' then
                    if TopbarButton.Name == 'Icon' then
                        TweenService:Create(TopbarButton, TweenInfo.new(0.7, Enum.EasingStyle.Exponential), {ImageTransparency = 0}):Play()
                    else
                        TweenService:Create(TopbarButton, TweenInfo.new(0.7, Enum.EasingStyle.Exponential), {ImageTransparency = 0.8}):Play()
                    end
                end
            end
            for _, tabbtn in ipairs(TabList:GetChildren())do
                if tabbtn.ClassName == 'Frame' and tabbtn.Name ~= 'Placeholder' then
                    if tostring(Elements.UIPageLayout.CurrentPage) == tabbtn.Title.Text then
                        TweenService:Create(tabbtn, TweenInfo.new(0.3, Enum.EasingStyle.Exponential), {BackgroundTransparency = 0}):Play()
                        TweenService:Create(tabbtn.Title, TweenInfo.new(0.3, Enum.EasingStyle.Exponential), {TextTransparency = 0}):Play()
                        TweenService:Create(tabbtn.Image, TweenInfo.new(0.3, Enum.EasingStyle.Exponential), {ImageTransparency = 0}):Play()
                        TweenService:Create(tabbtn.UIStroke, TweenInfo.new(0.3, Enum.EasingStyle.Exponential), {Transparency = 1}):Play()
                    else
                        TweenService:Create(tabbtn, TweenInfo.new(0.3, Enum.EasingStyle.Exponential), {BackgroundTransparency = 0.7}):Play()
                        TweenService:Create(tabbtn.Image, TweenInfo.new(0.3, Enum.EasingStyle.Exponential), {ImageTransparency = 0.2}):Play()
                        TweenService:Create(tabbtn.Title, TweenInfo.new(0.3, Enum.EasingStyle.Exponential), {TextTransparency = 0.2}):Play()
                        TweenService:Create(tabbtn.UIStroke, TweenInfo.new(0.3, Enum.EasingStyle.Exponential), {Transparency = 0.5}):Play()
                    end
                end
            end
            for _, tab in ipairs(Elements:GetChildren())do
                if tab.Name ~= 'Template' and tab.ClassName == 'ScrollingFrame' and tab.Name ~= 'Placeholder' then
                    for _, element in ipairs(tab:GetChildren())do
                        if element.ClassName == 'Frame' then
                            if element.Name ~= 'SectionSpacing' and element.Name ~= 'Placeholder' then
                                if element.Name == 'SectionTitle' or element.Name == 'SearchTitle-fsefsefesfsefesfesfThanks' then
                                    TweenService:Create(element.Title, TweenInfo.new(0.3, Enum.EasingStyle.Exponential), {TextTransparency = 0.4}):Play()
                                elseif element.Name == 'Divider' then
                                    TweenService:Create(element.Divider, TweenInfo.new(0.3, Enum.EasingStyle.Exponential), {BackgroundTransparency = 0.85}):Play()
                                else
                                    TweenService:Create(element, TweenInfo.new(0.3, Enum.EasingStyle.Exponential), {BackgroundTransparency = 0}):Play()
                                    TweenService:Create(element.UIStroke, TweenInfo.new(0.3, Enum.EasingStyle.Exponential), {Transparency = 0}):Play()
                                    TweenService:Create(element.Title, TweenInfo.new(0.3, Enum.EasingStyle.Exponential), {TextTransparency = 0}):Play()
                                end

                                for _, child in ipairs(element:GetChildren())do
                                    if child.ClassName == 'Frame' or child.ClassName == 'TextLabel' or child.ClassName == 'TextBox' or child.ClassName == 'ImageButton' or child.ClassName == 'ImageLabel' then
                                        child.Visible = true
                                    end
                                end
                            end
                        end
                    end
                end
            end

            TweenService:Create(dragBarCosmetic, TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {BackgroundTransparency = 0.5}):Play()
            task.wait(0.5)

            Minimised = false
            Debounce = false
        end
        local Minimise = function()
            Debounce = true
            Topbar.ChangeSize.Image = 'rbxassetid://11036884234'
            Topbar.UIStroke.Color = SelectedTheme.ElementStroke

            task.spawn(closeSearch)

            for _, tabbtn in ipairs(TabList:GetChildren())do
                if tabbtn.ClassName == 'Frame' and tabbtn.Name ~= 'Placeholder' then
                    TweenService:Create(tabbtn, TweenInfo.new(0.3, Enum.EasingStyle.Exponential), {BackgroundTransparency = 1}):Play()
                    TweenService:Create(tabbtn.Image, TweenInfo.new(0.3, Enum.EasingStyle.Exponential), {ImageTransparency = 1}):Play()
                    TweenService:Create(tabbtn.Title, TweenInfo.new(0.3, Enum.EasingStyle.Exponential), {TextTransparency = 1}):Play()
                    TweenService:Create(tabbtn.UIStroke, TweenInfo.new(0.3, Enum.EasingStyle.Exponential), {Transparency = 1}):Play()
                end
            end
            for _, tab in ipairs(Elements:GetChildren())do
                if tab.Name ~= 'Template' and tab.ClassName == 'ScrollingFrame' and tab.Name ~= 'Placeholder' then
                    for _, element in ipairs(tab:GetChildren())do
                        if element.ClassName == 'Frame' then
                            if element.Name ~= 'SectionSpacing' and element.Name ~= 'Placeholder' then
                                if element.Name == 'SectionTitle' or element.Name == 'SearchTitle-fsefsefesfsefesfesfThanks' then
                                    TweenService:Create(element.Title, TweenInfo.new(0.3, Enum.EasingStyle.Exponential), {TextTransparency = 1}):Play()
                                elseif element.Name == 'Divider' then
                                    TweenService:Create(element.Divider, TweenInfo.new(0.3, Enum.EasingStyle.Exponential), {BackgroundTransparency = 1}):Play()
                                else
                                    TweenService:Create(element, TweenInfo.new(0.3, Enum.EasingStyle.Exponential), {BackgroundTransparency = 1}):Play()
                                    TweenService:Create(element.UIStroke, TweenInfo.new(0.3, Enum.EasingStyle.Exponential), {Transparency = 1}):Play()
                                    TweenService:Create(element.Title, TweenInfo.new(0.3, Enum.EasingStyle.Exponential), {TextTransparency = 1}):Play()
                                end

                                for _, child in ipairs(element:GetChildren())do
                                    if child.ClassName == 'Frame' or child.ClassName == 'TextLabel' or child.ClassName == 'TextBox' or child.ClassName == 'ImageButton' or child.ClassName == 'ImageLabel' then
                                        child.Visible = false
                                    end
                                end
                            end
                        end
                    end
                end
            end

            TweenService:Create(dragBarCosmetic, TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {BackgroundTransparency = 1}):Play()
            TweenService:Create(Topbar.UIStroke, TweenInfo.new(0.5, Enum.EasingStyle.Exponential), {Transparency = 0}):Play()
            TweenService:Create(Main.Shadow.Image, TweenInfo.new(0.5, Enum.EasingStyle.Exponential), {ImageTransparency = 1}):Play()
            TweenService:Create(Topbar.CornerRepair, TweenInfo.new(0.5, Enum.EasingStyle.Exponential), {BackgroundTransparency = 1}):Play()
            TweenService:Create(Topbar.Divider, TweenInfo.new(0.5, Enum.EasingStyle.Exponential), {BackgroundTransparency = 1}):Play()
            TweenService:Create(Main, TweenInfo.new(0.5, Enum.EasingStyle.Exponential), {
                Size = UDim2.new(0, 495, 0, 45),
            }):Play()
            TweenService:Create(Topbar, TweenInfo.new(0.5, Enum.EasingStyle.Exponential), {
                Size = UDim2.new(0, 495, 0, 45),
            }):Play()
            task.wait(0.3)

            Elements.Visible = false
            TabList.Visible = false

            task.wait(0.2)

            Debounce = false
        end
        local updateSettings = function()
            local encoded
            local success, err = pcall(function()
                encoded = HttpService:JSONEncode(settingsTable)
            end)

            if success then
                if useStudio then
                    if script.Parent['get.val'] then
                        script.Parent['get.val'].Value = encoded
                    end
                end
                if writefile then
                    writefile(RayfieldFolder .. '/settings' .. ConfigurationExtension, encoded)
                end
            end
        end
        local createSettings = function(window)
            if not (writefile and isfile and readfile and isfolder and makefolder) and not useStudio then
                if Topbar['Settings'] then
                    Topbar.Settings.Visible = false
                end

                Topbar['Search'].Position = UDim2.new(1, -75, 0.5, 0)

                warn(
[[Can't create settings as no file-saving functionality is available.]])

                return
            end

            local newTab = window:CreateTab('Rayfield Settings', 0, true)

            if TabList['Rayfield Settings'] then
                TabList['Rayfield Settings'].LayoutOrder = 1000
            end
            if Elements['Rayfield Settings'] then
                Elements['Rayfield Settings'].LayoutOrder = 1000
            end

            for categoryName, settingCategory in pairs(settingsTable)do
                newTab:CreateSection(categoryName)

                for _, setting in pairs(settingCategory)do
                    if setting.Type == 'input' then
                        setting.Element = newTab:CreateInput({
                            Name = setting.Name,
                            CurrentValue = setting.Value,
                            PlaceholderText = setting.Placeholder,
                            Ext = true,
                            RemoveTextAfterFocusLost = setting.ClearOnFocus,
                            Callback = function(Value)
                                setting.Value = Value

                                updateSettings()
                            end,
                        })
                    elseif setting.Type == 'toggle' then
                        setting.Element = newTab:CreateToggle({
                            Name = setting.Name,
                            CurrentValue = setting.Value,
                            Ext = true,
                            Callback = function(Value)
                                setting.Value = Value

                                updateSettings()
                            end,
                        })
                    elseif setting.Type == 'bind' then
                        setting.Element = newTab:CreateKeybind({
                            Name = setting.Name,
                            CurrentKeybind = setting.Value,
                            HoldToInteract = false,
                            Ext = true,
                            CallOnChange = true,
                            Callback = function(Value)
                                setting.Value = Value

                                updateSettings()
                            end,
                        })
                    end
                end
            end

            settingsCreated = true

            loadSettings()
            updateSettings()
        end

        function RayfieldLibrary:CreateWindow(Settings)
            if not correctBuild and not Settings.DisableBuildWarnings then
                task.delay(3, function()
                    RayfieldLibrary:Notify({
                        Title = 'Build Mismatch',
                        Content = 
[[Rayfield may encounter issues as you are running an incompatible interface version (]] .. ((Rayfield:FindFirstChild('Build') and Rayfield.Build.Value) or 'No Build') .. 
[[).

This version of Rayfield is intended for interface build ]] .. InterfaceBuild .. '.\n\nTry rejoining and then run the script twice.',
                        Image = 4335487866,
                        Duration = 15,
                    })
                end)
            end
            if isfolder and not isfolder(RayfieldFolder) then
                makefolder(RayfieldFolder)
            end

            local Passthrough = false

            Topbar.Title.Text = Settings.Name
            Main.Size = UDim2.new(0, 420, 0, 100)
            Main.Visible = true
            Main.BackgroundTransparency = 1

            if Main:FindFirstChild('Notice') then
                Main.Notice.Visible = false
            end

            Main.Shadow.Image.ImageTransparency = 1
            LoadingFrame.Title.TextTransparency = 1
            LoadingFrame.Subtitle.TextTransparency = 1
            LoadingFrame.Version.TextTransparency = 1
            LoadingFrame.Title.Text = Settings.LoadingTitle or 'Rayfield'
            LoadingFrame.Subtitle.Text = Settings.LoadingSubtitle or 'Interface Suite'

            if Settings.LoadingTitle ~= 'Rayfield Interface Suite' then
                LoadingFrame.Version.Text = 'Rayfield UI'
            end
            if Settings.Icon and Settings.Icon ~= 0 and Topbar:FindFirstChild('Icon') then
                Topbar.Icon.Visible = true
                Topbar.Title.Position = UDim2.new(0, 47, 0.5, 0)

                if Settings.Icon then
                    if typeof(Settings.Icon) == 'string' then
                        local asset = getIcon(Settings.Icon)

                        Topbar.Icon.Image = 'rbxassetid://' .. asset.id
                        Topbar.Icon.ImageRectOffset = asset.imageRectOffset
                        Topbar.Icon.ImageRectSize = asset.imageRectSize
                    else
                        Topbar.Icon.Image = 'rbxassetid://' .. (Settings.Icon or 0)
                    end
                else
                    Topbar.Icon.Image = 'rbxassetid://0'
                end
            end
            if dragBar then
                dragBar.Visible = false
                dragBarCosmetic.BackgroundTransparency = 1
                dragBar.Visible = true
            end
            if Settings.Theme then
                local success, result = pcall(ChangeTheme, Settings.Theme)

                if not success then
                    local success, result2 = pcall(ChangeTheme, 'Default')

                    if not success then
                        warn('CRITICAL ERROR - NO DEFAULT THEME')
                        print(result2)
                    end

                    warn('issue rendering theme. no theme on file')
                    print(result)
                end
            end

            Topbar.Visible = false
            Elements.Visible = false
            LoadingFrame.Visible = true

            if not Settings.DisableRayfieldPrompts then
                task.spawn(function()
                    while true do
                        task.wait(math.random(180, 600))
                        RayfieldLibrary:Notify({
                            Title = 'Rayfield Interface',
                            Content = 'Enjoying this UI library? Find it at sirius.menu/discord',
                            Duration = 7,
                            Image = 4370033185,
                        })
                    end
                end)
            end

            pcall(function()
                if not Settings.ConfigurationSaving.FileName then
                    Settings.ConfigurationSaving.FileName = tostring(game.PlaceId)
                end
                if Settings.ConfigurationSaving.Enabled == nil then
                    Settings.ConfigurationSaving.Enabled = false
                end

                CFileName = Settings.ConfigurationSaving.FileName
                ConfigurationFolder = Settings.ConfigurationSaving.FolderName or ConfigurationFolder
                CEnabled = Settings.ConfigurationSaving.Enabled

                if Settings.ConfigurationSaving.Enabled then
                    if not isfolder(ConfigurationFolder) then
                        makefolder(ConfigurationFolder)
                    end
                end
            end)
            makeDraggable(Main, Topbar, false, {dragOffset, dragOffsetMobile})

            if dragBar then
                dragBar.Position = useMobileSizing and UDim2.new(0.5, 0, 0.5, dragOffsetMobile) or UDim2.new(0.5, 0, 0.5, dragOffset)

                makeDraggable(Main, dragInteract, true, {dragOffset, dragOffsetMobile})
            end

            for _, TabButton in ipairs(TabList:GetChildren())do
                if TabButton.ClassName == 'Frame' and TabButton.Name ~= 'Placeholder' then
                    TabButton.BackgroundTransparency = 1
                    TabButton.Title.TextTransparency = 1
                    TabButton.Image.ImageTransparency = 1
                    TabButton.UIStroke.Transparency = 1
                end
            end

            if Settings.Discord and not useStudio then
                if isfolder and not isfolder(RayfieldFolder .. '/Discord Invites') then
                    makefolder(RayfieldFolder .. '/Discord Invites')
                end
                if isfile and not isfile(RayfieldFolder .. '/Discord Invites' .. '/' .. Settings.Discord.Invite .. ConfigurationExtension) then
                    if request then
                        pcall(function()
                            request({
                                Url = 'http://127.0.0.1:6463/rpc?v=1',
                                Method = 'POST',
                                Headers = {
                                    ['Content-Type'] = 'application/json',
                                    Origin = 'https://discord.com',
                                },
                                Body = HttpService:JSONEncode({
                                    cmd = 'INVITE_BROWSER',
                                    nonce = HttpService:GenerateGUID(false),
                                    args = {
                                        code = Settings.Discord.Invite,
                                    },
                                }),
                            })
                        end)
                    end
                    if Settings.Discord.RememberJoins then
                        writefile(RayfieldFolder .. '/Discord Invites' .. '/' .. Settings.Discord.Invite .. ConfigurationExtension, 
[[Rayfield RememberJoins is true for this invite, this invite will not ask you to join again]])
                    end
                end
            end
            if Settings.KeySystem then
                if not Settings.KeySettings then
                    Passthrough = true

                    return
                end
                if isfolder and not isfolder(RayfieldFolder .. '/Key System') then
                    makefolder(RayfieldFolder .. '/Key System')
                end
                if typeof(Settings.KeySettings.Key) == 'string' then
                    Settings.KeySettings.Key = {
                        Settings.KeySettings.Key,
                    }
                end
                if Settings.KeySettings.GrabKeyFromSite then
                    for i, Key in ipairs(Settings.KeySettings.Key)do
                        local Success, Response = pcall(function()
                            Settings.KeySettings.Key[i] = tostring(game:HttpGet(Key):gsub('[\n\r]', ' '))
                            Settings.KeySettings.Key[i] = string.gsub(Settings.KeySettings.Key[i], ' ', '')
                        end)

                        if not Success then
                            print('Rayfield | ' .. Key .. ' Error ' .. tostring(Response))
                            warn(
[[Check docs.sirius.menu for help with Rayfield specific development.]])
                        end
                    end
                end
                if not Settings.KeySettings.FileName then
                    Settings.KeySettings.FileName = 'No file name specified'
                end
                if isfile and isfile(RayfieldFolder .. '/Key System' .. '/' .. Settings.KeySettings.FileName .. ConfigurationExtension) then
                    for _, MKey in ipairs(Settings.KeySettings.Key)do
                        if string.find(readfile(RayfieldFolder .. '/Key System' .. '/' .. Settings.KeySettings.FileName .. ConfigurationExtension), MKey) then
                            Passthrough = true
                        end
                    end
                end
                if not Passthrough then
                    local AttemptsRemaining = math.random(2, 5)

                    Rayfield.Enabled = false

                    local KeyUI = useStudio and script.Parent:FindFirstChild('Key') or game:GetObjects('rbxassetid://11380036235')[1]

                    KeyUI.Enabled = true

                    if gethui then
                        KeyUI.Parent = gethui()
                    elseif syn and syn.protect_gui then
                        syn.protect_gui(KeyUI)

                        KeyUI.Parent = CoreGui
                    elseif not useStudio and CoreGui:FindFirstChild('RobloxGui') then
                        KeyUI.Parent = CoreGui:FindFirstChild('RobloxGui')
                    elseif not useStudio then
                        KeyUI.Parent = CoreGui
                    end
                    if gethui then
                        for _, Interface in ipairs(gethui():GetChildren())do
                            if Interface.Name == KeyUI.Name and Interface ~= KeyUI then
                                Interface.Enabled = false
                                Interface.Name = 'KeyUI-Old'
                            end
                        end
                    elseif not useStudio then
                        for _, Interface in ipairs(CoreGui:GetChildren())do
                            if Interface.Name == KeyUI.Name and Interface ~= KeyUI then
                                Interface.Enabled = false
                                Interface.Name = 'KeyUI-Old'
                            end
                        end
                    end

                    local KeyMain = KeyUI.Main

                    KeyMain.Title.Text = Settings.KeySettings.Title or Settings.Name
                    KeyMain.Subtitle.Text = Settings.KeySettings.Subtitle or 'Key System'
                    KeyMain.NoteMessage.Text = Settings.KeySettings.Note or 'No instructions'
                    KeyMain.Size = UDim2.new(0, 467, 0, 175)
                    KeyMain.BackgroundTransparency = 1
                    KeyMain.Shadow.Image.ImageTransparency = 1
                    KeyMain.Title.TextTransparency = 1
                    KeyMain.Subtitle.TextTransparency = 1
                    KeyMain.KeyNote.TextTransparency = 1
                    KeyMain.Input.BackgroundTransparency = 1
                    KeyMain.Input.UIStroke.Transparency = 1
                    KeyMain.Input.InputBox.TextTransparency = 1
                    KeyMain.NoteTitle.TextTransparency = 1
                    KeyMain.NoteMessage.TextTransparency = 1
                    KeyMain.Hide.ImageTransparency = 1

                    TweenService:Create(KeyMain, TweenInfo.new(0.6, Enum.EasingStyle.Exponential), {BackgroundTransparency = 0}):Play()
                    TweenService:Create(KeyMain, TweenInfo.new(0.6, Enum.EasingStyle.Exponential), {
                        Size = UDim2.new(0, 500, 0, 187),
                    }):Play()
                    TweenService:Create(KeyMain.Shadow.Image, TweenInfo.new(0.5, Enum.EasingStyle.Exponential), {ImageTransparency = 0.5}):Play()
                    task.wait(0.05)
                    TweenService:Create(KeyMain.Title, TweenInfo.new(0.4, Enum.EasingStyle.Exponential), {TextTransparency = 0}):Play()
                    TweenService:Create(KeyMain.Subtitle, TweenInfo.new(0.5, Enum.EasingStyle.Exponential), {TextTransparency = 0}):Play()
                    task.wait(0.05)
                    TweenService:Create(KeyMain.KeyNote, TweenInfo.new(0.5, Enum.EasingStyle.Exponential), {TextTransparency = 0}):Play()
                    TweenService:Create(KeyMain.Input, TweenInfo.new(0.5, Enum.EasingStyle.Exponential), {BackgroundTransparency = 0}):Play()
                    TweenService:Create(KeyMain.Input.UIStroke, TweenInfo.new(0.5, Enum.EasingStyle.Exponential), {Transparency = 0}):Play()
                    TweenService:Create(KeyMain.Input.InputBox, TweenInfo.new(0.5, Enum.EasingStyle.Exponential), {TextTransparency = 0}):Play()
                    task.wait(0.05)
                    TweenService:Create(KeyMain.NoteTitle, TweenInfo.new(0.4, Enum.EasingStyle.Exponential), {TextTransparency = 0}):Play()
                    TweenService:Create(KeyMain.NoteMessage, TweenInfo.new(0.4, Enum.EasingStyle.Exponential), {TextTransparency = 0}):Play()
                    task.wait(0.15)
                    TweenService:Create(KeyMain.Hide, TweenInfo.new(0.4, Enum.EasingStyle.Exponential), {ImageTransparency = 0.3}):Play()
                    KeyUI.Main.Input.InputBox.FocusLost:Connect(function()
                        if #KeyUI.Main.Input.InputBox.Text == 0 then
                            return
                        end

                        local KeyFound = false
                        local FoundKey = ''

                        for _, MKey in ipairs(Settings.KeySettings.Key)do
                            if KeyMain.Input.InputBox.Text == MKey then
                                KeyFound = true
                                FoundKey = MKey
                            end
                        end

                        if KeyFound then
                            TweenService:Create(KeyMain, TweenInfo.new(0.6, Enum.EasingStyle.Exponential), {BackgroundTransparency = 1}):Play()
                            TweenService:Create(KeyMain, TweenInfo.new(0.6, Enum.EasingStyle.Exponential), {
                                Size = UDim2.new(0, 467, 0, 175),
                            }):Play()
                            TweenService:Create(KeyMain.Shadow.Image, TweenInfo.new(0.5, Enum.EasingStyle.Exponential), {ImageTransparency = 1}):Play()
                            TweenService:Create(KeyMain.Title, TweenInfo.new(0.4, Enum.EasingStyle.Exponential), {TextTransparency = 1}):Play()
                            TweenService:Create(KeyMain.Subtitle, TweenInfo.new(0.5, Enum.EasingStyle.Exponential), {TextTransparency = 1}):Play()
                            TweenService:Create(KeyMain.KeyNote, TweenInfo.new(0.5, Enum.EasingStyle.Exponential), {TextTransparency = 1}):Play()
                            TweenService:Create(KeyMain.Input, TweenInfo.new(0.5, Enum.EasingStyle.Exponential), {BackgroundTransparency = 1}):Play()
                            TweenService:Create(KeyMain.Input.UIStroke, TweenInfo.new(0.5, Enum.EasingStyle.Exponential), {Transparency = 1}):Play()
                            TweenService:Create(KeyMain.Input.InputBox, TweenInfo.new(0.5, Enum.EasingStyle.Exponential), {TextTransparency = 1}):Play()
                            TweenService:Create(KeyMain.NoteTitle, TweenInfo.new(0.4, Enum.EasingStyle.Exponential), {TextTransparency = 1}):Play()
                            TweenService:Create(KeyMain.NoteMessage, TweenInfo.new(0.4, Enum.EasingStyle.Exponential), {TextTransparency = 1}):Play()
                            TweenService:Create(KeyMain.Hide, TweenInfo.new(0.4, Enum.EasingStyle.Exponential), {ImageTransparency = 1}):Play()
                            task.wait(0.51)

                            Passthrough = true
                            KeyMain.Visible = false

                            if Settings.KeySettings.SaveKey then
                                if writefile then
                                    writefile(RayfieldFolder .. '/Key System' .. '/' .. Settings.KeySettings.FileName .. ConfigurationExtension, FoundKey)
                                end

                                RayfieldLibrary:Notify({
                                    Title = 'Key System',
                                    Content = 'The key for this script has been saved successfully.',
                                    Image = 3605522284,
                                })
                            end
                        else
                            if AttemptsRemaining == 0 then
                                TweenService:Create(KeyMain, TweenInfo.new(0.6, Enum.EasingStyle.Exponential), {BackgroundTransparency = 1}):Play()
                                TweenService:Create(KeyMain, TweenInfo.new(0.6, Enum.EasingStyle.Exponential), {
                                    Size = UDim2.new(0, 467, 0, 175),
                                }):Play()
                                TweenService:Create(KeyMain.Shadow.Image, TweenInfo.new(0.5, Enum.EasingStyle.Exponential), {ImageTransparency = 1}):Play()
                                TweenService:Create(KeyMain.Title, TweenInfo.new(0.4, Enum.EasingStyle.Exponential), {TextTransparency = 1}):Play()
                                TweenService:Create(KeyMain.Subtitle, TweenInfo.new(0.5, Enum.EasingStyle.Exponential), {TextTransparency = 1}):Play()
                                TweenService:Create(KeyMain.KeyNote, TweenInfo.new(0.5, Enum.EasingStyle.Exponential), {TextTransparency = 1}):Play()
                                TweenService:Create(KeyMain.Input, TweenInfo.new(0.5, Enum.EasingStyle.Exponential), {BackgroundTransparency = 1}):Play()
                                TweenService:Create(KeyMain.Input.UIStroke, TweenInfo.new(0.5, Enum.EasingStyle.Exponential), {Transparency = 1}):Play()
                                TweenService:Create(KeyMain.Input.InputBox, TweenInfo.new(0.5, Enum.EasingStyle.Exponential), {TextTransparency = 1}):Play()
                                TweenService:Create(KeyMain.NoteTitle, TweenInfo.new(0.4, Enum.EasingStyle.Exponential), {TextTransparency = 1}):Play()
                                TweenService:Create(KeyMain.NoteMessage, TweenInfo.new(0.4, Enum.EasingStyle.Exponential), {TextTransparency = 1}):Play()
                                TweenService:Create(KeyMain.Hide, TweenInfo.new(0.4, Enum.EasingStyle.Exponential), {ImageTransparency = 1}):Play()
                                task.wait(0.45)
                                Players.LocalPlayer:Kick('No Attempts Remaining')
                                game:Shutdown()
                            end

                            KeyMain.Input.InputBox.Text = ''
                            AttemptsRemaining = AttemptsRemaining - 1

                            TweenService:Create(KeyMain, TweenInfo.new(0.6, Enum.EasingStyle.Exponential), {
                                Size = UDim2.new(0, 467, 0, 175),
                            }):Play()
                            TweenService:Create(KeyMain, TweenInfo.new(0.4, Enum.EasingStyle.Elastic), {
                                Position = UDim2.new(0.495, 0, 0.5, 0),
                            }):Play()
                            task.wait(0.1)
                            TweenService:Create(KeyMain, TweenInfo.new(0.4, Enum.EasingStyle.Elastic), {
                                Position = UDim2.new(0.505, 0, 0.5, 0),
                            }):Play()
                            task.wait(0.1)
                            TweenService:Create(KeyMain, TweenInfo.new(0.4, Enum.EasingStyle.Exponential), {
                                Position = UDim2.new(0.5, 0, 0.5, 0),
                            }):Play()
                            TweenService:Create(KeyMain, TweenInfo.new(0.6, Enum.EasingStyle.Exponential), {
                                Size = UDim2.new(0, 500, 0, 187),
                            }):Play()
                        end
                    end)
                    KeyMain.Hide.MouseButton1Click:Connect(function()
                        TweenService:Create(KeyMain, TweenInfo.new(0.6, Enum.EasingStyle.Exponential), {BackgroundTransparency = 1}):Play()
                        TweenService:Create(KeyMain, TweenInfo.new(0.6, Enum.EasingStyle.Exponential), {
                            Size = UDim2.new(0, 467, 0, 175),
                        }):Play()
                        TweenService:Create(KeyMain.Shadow.Image, TweenInfo.new(0.5, Enum.EasingStyle.Exponential), {ImageTransparency = 1}):Play()
                        TweenService:Create(KeyMain.Title, TweenInfo.new(0.4, Enum.EasingStyle.Exponential), {TextTransparency = 1}):Play()
                        TweenService:Create(KeyMain.Subtitle, TweenInfo.new(0.5, Enum.EasingStyle.Exponential), {TextTransparency = 1}):Play()
                        TweenService:Create(KeyMain.KeyNote, TweenInfo.new(0.5, Enum.EasingStyle.Exponential), {TextTransparency = 1}):Play()
                        TweenService:Create(KeyMain.Input, TweenInfo.new(0.5, Enum.EasingStyle.Exponential), {BackgroundTransparency = 1}):Play()
                        TweenService:Create(KeyMain.Input.UIStroke, TweenInfo.new(0.5, Enum.EasingStyle.Exponential), {Transparency = 1}):Play()
                        TweenService:Create(KeyMain.Input.InputBox, TweenInfo.new(0.5, Enum.EasingStyle.Exponential), {TextTransparency = 1}):Play()
                        TweenService:Create(KeyMain.NoteTitle, TweenInfo.new(0.4, Enum.EasingStyle.Exponential), {TextTransparency = 1}):Play()
                        TweenService:Create(KeyMain.NoteMessage, TweenInfo.new(0.4, Enum.EasingStyle.Exponential), {TextTransparency = 1}):Play()
                        TweenService:Create(KeyMain.Hide, TweenInfo.new(0.4, Enum.EasingStyle.Exponential), {ImageTransparency = 1}):Play()
                        task.wait(0.51)
                        RayfieldLibrary:Destroy()
                        KeyUI:Destroy()
                    end)
                else
                    Passthrough = true
                end
            end
            if Settings.KeySystem then
                repeat
                    task.wait()
                until Passthrough
            end

            Notifications.Template.Visible = false
            Notifications.Visible = true
            Rayfield.Enabled = true

            task.wait(0.5)
            TweenService:Create(Main, TweenInfo.new(0.7, Enum.EasingStyle.Exponential), {BackgroundTransparency = 0}):Play()
            TweenService:Create(Main.Shadow.Image, TweenInfo.new(0.7, Enum.EasingStyle.Exponential), {ImageTransparency = 0.6}):Play()
            task.wait(0.1)
            TweenService:Create(LoadingFrame.Title, TweenInfo.new(0.7, Enum.EasingStyle.Exponential), {TextTransparency = 0}):Play()
            task.wait(0.05)
            TweenService:Create(LoadingFrame.Subtitle, TweenInfo.new(0.7, Enum.EasingStyle.Exponential), {TextTransparency = 0}):Play()
            task.wait(0.05)
            TweenService:Create(LoadingFrame.Version, TweenInfo.new(0.7, Enum.EasingStyle.Exponential), {TextTransparency = 0}):Play()

            Elements.Template.LayoutOrder = 100000
            Elements.Template.Visible = false
            Elements.UIPageLayout.FillDirection = Enum.FillDirection.Horizontal
            TabList.Template.Visible = false

            local FirstTab = false
            local Window = {}

            function Window:CreateTab(Name, Image, Ext)
                local SDone = false
                local TabButton = TabList.Template:Clone()

                TabButton.Name = Name
                TabButton.Title.Text = Name
                TabButton.Parent = TabList
                TabButton.Title.TextWrapped = false
                TabButton.Size = UDim2.new(0, TabButton.Title.TextBounds.X + 30, 0, 30)

                if Image and Image ~= 0 then
                    if typeof(Image) == 'string' then
                        local asset = getIcon(Image)

                        TabButton.Image.Image = 'rbxassetid://' .. asset.id
                        TabButton.Image.ImageRectOffset = asset.imageRectOffset
                        TabButton.Image.ImageRectSize = asset.imageRectSize
                    else
                        TabButton.Image.Image = 'rbxassetid://' .. Image
                    end

                    TabButton.Title.AnchorPoint = Vector2.new(0, 0.5)
                    TabButton.Title.Position = UDim2.new(0, 37, 0.5, 0)
                    TabButton.Image.Visible = true
                    TabButton.Title.TextXAlignment = Enum.TextXAlignment.Left
                    TabButton.Size = UDim2.new(0, TabButton.Title.TextBounds.X + 52, 0, 30)
                end

                TabButton.BackgroundTransparency = 1
                TabButton.Title.TextTransparency = 1
                TabButton.Image.ImageTransparency = 1
                TabButton.UIStroke.Transparency = 1
                TabButton.Visible = not Ext or false

                local TabPage = Elements.Template:Clone()

                TabPage.Name = Name
                TabPage.Visible = true
                TabPage.LayoutOrder = #Elements:GetChildren() or Ext and 10000

                for _, TemplateElement in ipairs(TabPage:GetChildren())do
                    if TemplateElement.ClassName == 'Frame' and TemplateElement.Name ~= 'Placeholder' then
                        TemplateElement:Destroy()
                    end
                end

                TabPage.Parent = Elements

                if not FirstTab and not Ext then
                    Elements.UIPageLayout.Animated = false

                    Elements.UIPageLayout:JumpTo(TabPage)

                    Elements.UIPageLayout.Animated = true
                end

                TabButton.UIStroke.Color = SelectedTheme.TabStroke

                if Elements.UIPageLayout.CurrentPage == TabPage then
                    TabButton.BackgroundColor3 = SelectedTheme.TabBackgroundSelected
                    TabButton.Image.ImageColor3 = SelectedTheme.SelectedTabTextColor
                    TabButton.Title.TextColor3 = SelectedTheme.SelectedTabTextColor
                else
                    TabButton.BackgroundColor3 = SelectedTheme.TabBackground
                    TabButton.Image.ImageColor3 = SelectedTheme.TabTextColor
                    TabButton.Title.TextColor3 = SelectedTheme.TabTextColor
                end

                task.wait(0.1)

                if FirstTab or Ext then
                    TabButton.BackgroundColor3 = SelectedTheme.TabBackground
                    TabButton.Image.ImageColor3 = SelectedTheme.TabTextColor
                    TabButton.Title.TextColor3 = SelectedTheme.TabTextColor

                    TweenService:Create(TabButton, TweenInfo.new(0.7, Enum.EasingStyle.Exponential), {BackgroundTransparency = 0.7}):Play()
                    TweenService:Create(TabButton.Title, TweenInfo.new(0.7, Enum.EasingStyle.Exponential), {TextTransparency = 0.2}):Play()
                    TweenService:Create(TabButton.Image, TweenInfo.new(0.7, Enum.EasingStyle.Exponential), {ImageTransparency = 0.2}):Play()
                    TweenService:Create(TabButton.UIStroke, TweenInfo.new(0.7, Enum.EasingStyle.Exponential), {Transparency = 0.5}):Play()
                elseif not Ext then
                    FirstTab = Name
                    TabButton.BackgroundColor3 = SelectedTheme.TabBackgroundSelected
                    TabButton.Image.ImageColor3 = SelectedTheme.SelectedTabTextColor
                    TabButton.Title.TextColor3 = SelectedTheme.SelectedTabTextColor

                    TweenService:Create(TabButton.Image, TweenInfo.new(0.7, Enum.EasingStyle.Exponential), {ImageTransparency = 0}):Play()
                    TweenService:Create(TabButton, TweenInfo.new(0.7, Enum.EasingStyle.Exponential), {BackgroundTransparency = 0}):Play()
                    TweenService:Create(TabButton.Title, TweenInfo.new(0.7, Enum.EasingStyle.Exponential), {TextTransparency = 0}):Play()
                end

                TabButton.Interact.MouseButton1Click:Connect(function()
                    if Minimised then
                        return
                    end

                    TweenService:Create(TabButton, TweenInfo.new(0.7, Enum.EasingStyle.Exponential), {BackgroundTransparency = 0}):Play()
                    TweenService:Create(TabButton.UIStroke, TweenInfo.new(0.7, Enum.EasingStyle.Exponential), {Transparency = 1}):Play()
                    TweenService:Create(TabButton.Title, TweenInfo.new(0.7, Enum.EasingStyle.Exponential), {TextTransparency = 0}):Play()
                    TweenService:Create(TabButton.Image, TweenInfo.new(0.7, Enum.EasingStyle.Exponential), {ImageTransparency = 0}):Play()
                    TweenService:Create(TabButton, TweenInfo.new(0.7, Enum.EasingStyle.Exponential), {
                        BackgroundColor3 = SelectedTheme.TabBackgroundSelected,
                    }):Play()
                    TweenService:Create(TabButton.Title, TweenInfo.new(0.7, Enum.EasingStyle.Exponential), {
                        TextColor3 = SelectedTheme.SelectedTabTextColor,
                    }):Play()
                    TweenService:Create(TabButton.Image, TweenInfo.new(0.7, Enum.EasingStyle.Exponential), {
                        ImageColor3 = SelectedTheme.SelectedTabTextColor,
                    }):Play()

                    for _, OtherTabButton in ipairs(TabList:GetChildren())do
                        if OtherTabButton.Name ~= 'Template' and OtherTabButton.ClassName == 'Frame' and OtherTabButton ~= TabButton and OtherTabButton.Name ~= 'Placeholder' then
                            TweenService:Create(OtherTabButton, TweenInfo.new(0.7, Enum.EasingStyle.Exponential), {
                                BackgroundColor3 = SelectedTheme.TabBackground,
                            }):Play()
                            TweenService:Create(OtherTabButton.Title, TweenInfo.new(0.7, Enum.EasingStyle.Exponential), {
                                TextColor3 = SelectedTheme.TabTextColor,
                            }):Play()
                            TweenService:Create(OtherTabButton.Image, TweenInfo.new(0.7, Enum.EasingStyle.Exponential), {
                                ImageColor3 = SelectedTheme.TabTextColor,
                            }):Play()
                            TweenService:Create(OtherTabButton, TweenInfo.new(0.7, Enum.EasingStyle.Exponential), {BackgroundTransparency = 0.7}):Play()
                            TweenService:Create(OtherTabButton.Title, TweenInfo.new(0.7, Enum.EasingStyle.Exponential), {TextTransparency = 0.2}):Play()
                            TweenService:Create(OtherTabButton.Image, TweenInfo.new(0.7, Enum.EasingStyle.Exponential), {ImageTransparency = 0.2}):Play()
                            TweenService:Create(OtherTabButton.UIStroke, TweenInfo.new(0.7, Enum.EasingStyle.Exponential), {Transparency = 0.5}):Play()
                        end
                    end

                    if Elements.UIPageLayout.CurrentPage ~= TabPage then
                        Elements.UIPageLayout:JumpTo(TabPage)
                    end
                end)

                local Tab = {}

                function Tab:CreateButton(ButtonSettings)
                    local ButtonValue = {}
                    local Button = Elements.Template.Button:Clone()

                    Button.Name = ButtonSettings.Name
                    Button.Title.Text = ButtonSettings.Name
                    Button.Visible = true
                    Button.Parent = TabPage
                    Button.BackgroundTransparency = 1
                    Button.UIStroke.Transparency = 1
                    Button.Title.TextTransparency = 1

                    TweenService:Create(Button, TweenInfo.new(0.7, Enum.EasingStyle.Exponential), {BackgroundTransparency = 0}):Play()
                    TweenService:Create(Button.UIStroke, TweenInfo.new(0.7, Enum.EasingStyle.Exponential), {Transparency = 0}):Play()
                    TweenService:Create(Button.Title, TweenInfo.new(0.7, Enum.EasingStyle.Exponential), {TextTransparency = 0}):Play()
                    Button.Interact.MouseButton1Click:Connect(function()
                        local Success, Response = pcall(ButtonSettings.Callback)

                        if not Success then
                            TweenService:Create(Button, TweenInfo.new(0.6, Enum.EasingStyle.Exponential), {
                                BackgroundColor3 = Color3.fromRGB(85, 0, 0),
                            }):Play()
                            TweenService:Create(Button.ElementIndicator, TweenInfo.new(0.6, Enum.EasingStyle.Exponential), {TextTransparency = 1}):Play()
                            TweenService:Create(Button.UIStroke, TweenInfo.new(0.6, Enum.EasingStyle.Exponential), {Transparency = 1}):Play()

                            Button.Title.Text = 'Callback Error'

                            print('Rayfield | ' .. ButtonSettings.Name .. ' Callback Error ' .. tostring(Response))
                            warn(
[[Check docs.sirius.menu for help with Rayfield specific development.]])
                            task.wait(0.5)

                            Button.Title.Text = ButtonSettings.Name

                            TweenService:Create(Button, TweenInfo.new(0.6, Enum.EasingStyle.Exponential), {
                                BackgroundColor3 = SelectedTheme.ElementBackground,
                            }):Play()
                            TweenService:Create(Button.ElementIndicator, TweenInfo.new(0.6, Enum.EasingStyle.Exponential), {TextTransparency = 0.9}):Play()
                            TweenService:Create(Button.UIStroke, TweenInfo.new(0.6, Enum.EasingStyle.Exponential), {Transparency = 0}):Play()
                        else
                            if not ButtonSettings.Ext then
                                SaveConfiguration()
                            end

                            TweenService:Create(Button, TweenInfo.new(0.6, Enum.EasingStyle.Exponential), {
                                BackgroundColor3 = SelectedTheme.ElementBackgroundHover,
                            }):Play()
                            TweenService:Create(Button.ElementIndicator, TweenInfo.new(0.6, Enum.EasingStyle.Exponential), {TextTransparency = 1}):Play()
                            TweenService:Create(Button.UIStroke, TweenInfo.new(0.6, Enum.EasingStyle.Exponential), {Transparency = 1}):Play()
                            task.wait(0.2)
                            TweenService:Create(Button, TweenInfo.new(0.6, Enum.EasingStyle.Exponential), {
                                BackgroundColor3 = SelectedTheme.ElementBackground,
                            }):Play()
                            TweenService:Create(Button.ElementIndicator, TweenInfo.new(0.6, Enum.EasingStyle.Exponential), {TextTransparency = 0.9}):Play()
                            TweenService:Create(Button.UIStroke, TweenInfo.new(0.6, Enum.EasingStyle.Exponential), {Transparency = 0}):Play()
                        end
                    end)
                    Button.MouseEnter:Connect(function()
                        TweenService:Create(Button, TweenInfo.new(0.6, Enum.EasingStyle.Exponential), {
                            BackgroundColor3 = SelectedTheme.ElementBackgroundHover,
                        }):Play()
                        TweenService:Create(Button.ElementIndicator, TweenInfo.new(0.6, Enum.EasingStyle.Exponential), {TextTransparency = 0.7}):Play()
                    end)
                    Button.MouseLeave:Connect(function()
                        TweenService:Create(Button, TweenInfo.new(0.6, Enum.EasingStyle.Exponential), {
                            BackgroundColor3 = SelectedTheme.ElementBackground,
                        }):Play()
                        TweenService:Create(Button.ElementIndicator, TweenInfo.new(0.6, Enum.EasingStyle.Exponential), {TextTransparency = 0.9}):Play()
                    end)

                    function ButtonValue:Set(NewButton)
                        Button.Title.Text = NewButton
                        Button.Name = NewButton
                    end

                    return ButtonValue
                end
                function Tab:CreateColorPicker(ColorPickerSettings)
                    ColorPickerSettings.Type = 'ColorPicker'

                    local ColorPicker = Elements.Template.ColorPicker:Clone()
                    local Background = ColorPicker.CPBackground
                    local Display = Background.Display
                    local Main = Background.MainCP
                    local Slider = ColorPicker.ColorSlider

                    ColorPicker.ClipsDescendants = true
                    ColorPicker.Name = ColorPickerSettings.Name
                    ColorPicker.Title.Text = ColorPickerSettings.Name
                    ColorPicker.Visible = true
                    ColorPicker.Parent = TabPage
                    ColorPicker.Size = UDim2.new(1, -10, 0, 45)
                    Background.Size = UDim2.new(0, 39, 0, 22)
                    Display.BackgroundTransparency = 0
                    Main.MainPoint.ImageTransparency = 1
                    ColorPicker.Interact.Size = UDim2.new(1, 0, 1, 0)
                    ColorPicker.Interact.Position = UDim2.new(0.5, 0, 0.5, 0)
                    ColorPicker.RGB.Position = UDim2.new(0, 17, 0, 70)
                    ColorPicker.HexInput.Position = UDim2.new(0, 17, 0, 90)
                    Main.ImageTransparency = 1
                    Background.BackgroundTransparency = 1

                    for _, rgbinput in ipairs(ColorPicker.RGB:GetChildren())do
                        if rgbinput:IsA('Frame') then
                            rgbinput.BackgroundColor3 = SelectedTheme.InputBackground
                            rgbinput.UIStroke.Color = SelectedTheme.InputStroke
                        end
                    end

                    ColorPicker.HexInput.BackgroundColor3 = SelectedTheme.InputBackground
                    ColorPicker.HexInput.UIStroke.Color = SelectedTheme.InputStroke

                    local opened = false
                    local mouse = Players.LocalPlayer:GetMouse()

                    Main.Image = 'http://www.roblox.com/asset/?id=11415645739'

                    local mainDragging = false
                    local sliderDragging = false

                    ColorPicker.Interact.MouseButton1Down:Connect(function()
                        task.spawn(function()
                            TweenService:Create(ColorPicker, TweenInfo.new(0.6, Enum.EasingStyle.Exponential), {
                                BackgroundColor3 = SelectedTheme.ElementBackgroundHover,
                            }):Play()
                            TweenService:Create(ColorPicker.UIStroke, TweenInfo.new(0.6, Enum.EasingStyle.Exponential), {Transparency = 1}):Play()
                            task.wait(0.2)
                            TweenService:Create(ColorPicker, TweenInfo.new(0.6, Enum.EasingStyle.Exponential), {
                                BackgroundColor3 = SelectedTheme.ElementBackground,
                            }):Play()
                            TweenService:Create(ColorPicker.UIStroke, TweenInfo.new(0.6, Enum.EasingStyle.Exponential), {Transparency = 0}):Play()
                        end)

                        if not opened then
                            opened = true

                            TweenService:Create(Background, TweenInfo.new(0.45, Enum.EasingStyle.Exponential), {
                                Size = UDim2.new(0, 18, 0, 15),
                            }):Play()
                            task.wait(0.1)
                            TweenService:Create(ColorPicker, TweenInfo.new(0.6, Enum.EasingStyle.Exponential), {
                                Size = UDim2.new(1, -10, 0, 120),
                            }):Play()
                            TweenService:Create(Background, TweenInfo.new(0.6, Enum.EasingStyle.Exponential), {
                                Size = UDim2.new(0, 173, 0, 86),
                            }):Play()
                            TweenService:Create(Display, TweenInfo.new(0.6, Enum.EasingStyle.Exponential), {BackgroundTransparency = 1}):Play()
                            TweenService:Create(ColorPicker.Interact, TweenInfo.new(0.6, Enum.EasingStyle.Exponential), {
                                Position = UDim2.new(0.289, 0, 0.5, 0),
                            }):Play()
                            TweenService:Create(ColorPicker.RGB, TweenInfo.new(0.8, Enum.EasingStyle.Exponential), {
                                Position = UDim2.new(0, 17, 0, 40),
                            }):Play()
                            TweenService:Create(ColorPicker.HexInput, TweenInfo.new(0.5, Enum.EasingStyle.Exponential), {
                                Position = UDim2.new(0, 17, 0, 73),
                            }):Play()
                            TweenService:Create(ColorPicker.Interact, TweenInfo.new(0.6, Enum.EasingStyle.Exponential), {
                                Size = UDim2.new(0.574, 0, 1, 0),
                            }):Play()
                            TweenService:Create(Main.MainPoint, TweenInfo.new(0.2, Enum.EasingStyle.Exponential), {ImageTransparency = 0}):Play()
                            TweenService:Create(Main, TweenInfo.new(0.2, Enum.EasingStyle.Exponential), {
                                ImageTransparency = SelectedTheme ~= RayfieldLibrary.Theme.Default and 0.25 or 0.1,
                            }):Play()
                            TweenService:Create(Background, TweenInfo.new(0.6, Enum.EasingStyle.Exponential), {BackgroundTransparency = 0}):Play()
                        else
                            opened = false

                            TweenService:Create(ColorPicker, TweenInfo.new(0.6, Enum.EasingStyle.Exponential), {
                                Size = UDim2.new(1, -10, 0, 45),
                            }):Play()
                            TweenService:Create(Background, TweenInfo.new(0.6, Enum.EasingStyle.Exponential), {
                                Size = UDim2.new(0, 39, 0, 22),
                            }):Play()
                            TweenService:Create(ColorPicker.Interact, TweenInfo.new(0.6, Enum.EasingStyle.Exponential), {
                                Size = UDim2.new(1, 0, 1, 0),
                            }):Play()
                            TweenService:Create(ColorPicker.Interact, TweenInfo.new(0.6, Enum.EasingStyle.Exponential), {
                                Position = UDim2.new(0.5, 0, 0.5, 0),
                            }):Play()
                            TweenService:Create(ColorPicker.RGB, TweenInfo.new(0.6, Enum.EasingStyle.Exponential), {
                                Position = UDim2.new(0, 17, 0, 70),
                            }):Play()
                            TweenService:Create(ColorPicker.HexInput, TweenInfo.new(0.5, Enum.EasingStyle.Exponential), {
                                Position = UDim2.new(0, 17, 0, 90),
                            }):Play()
                            TweenService:Create(Display, TweenInfo.new(0.6, Enum.EasingStyle.Exponential), {BackgroundTransparency = 0}):Play()
                            TweenService:Create(Main.MainPoint, TweenInfo.new(0.2, Enum.EasingStyle.Exponential), {ImageTransparency = 1}):Play()
                            TweenService:Create(Main, TweenInfo.new(0.2, Enum.EasingStyle.Exponential), {ImageTransparency = 1}):Play()
                            TweenService:Create(Background, TweenInfo.new(0.6, Enum.EasingStyle.Exponential), {BackgroundTransparency = 1}):Play()
                        end
                    end)
                    UserInputService.InputEnded:Connect(function(
                        input,
                        gameProcessed
                    )
                        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                            mainDragging = false
                            sliderDragging = false
                        end
                    end)
                    Main.MouseButton1Down:Connect(function()
                        if opened then
                            mainDragging = true
                        end
                    end)
                    Main.MainPoint.MouseButton1Down:Connect(function()
                        if opened then
                            mainDragging = true
                        end
                    end)
                    Slider.MouseButton1Down:Connect(function()
                        sliderDragging = true
                    end)
                    Slider.SliderPoint.MouseButton1Down:Connect(function()
                        sliderDragging = true
                    end)

                    local h, s, v = ColorPickerSettings.Color:ToHSV()
                    local color = Color3.fromHSV(h, s, v)
                    local hex = string.format('#%02X%02X%02X', color.R * 0xff, color.G * 0xff, color.B * 0xff)

                    ColorPicker.HexInput.InputBox.Text = hex

                    local setDisplay = function()
                        Main.MainPoint.Position = UDim2.new(s, -Main.MainPoint.AbsoluteSize.X / 2, 1 - v, 
-Main.MainPoint.AbsoluteSize.Y / 2)
                        Main.MainPoint.ImageColor3 = Color3.fromHSV(h, s, v)
                        Background.BackgroundColor3 = Color3.fromHSV(h, 1, 1)
                        Display.BackgroundColor3 = Color3.fromHSV(h, s, v)

                        local x = h * Slider.AbsoluteSize.X

                        Slider.SliderPoint.Position = UDim2.new(0, x - Slider.SliderPoint.AbsoluteSize.X / 2, 0.5, 0)
                        Slider.SliderPoint.ImageColor3 = Color3.fromHSV(h, 1, 1)

                        local color = Color3.fromHSV(h, s, v)
                        local r, g, b = math.floor((color.R * 255) + 0.5), math.floor((color.G * 255) + 0.5), math.floor((color.B * 255) + 0.5)

                        ColorPicker.RGB.RInput.InputBox.Text = tostring(r)
                        ColorPicker.RGB.GInput.InputBox.Text = tostring(g)
                        ColorPicker.RGB.BInput.InputBox.Text = tostring(b)
                        hex = string.format('#%02X%02X%02X', color.R * 0xff, color.G * 0xff, color.B * 0xff)
                        ColorPicker.HexInput.InputBox.Text = hex
                    end

                    setDisplay()
                    ColorPicker.HexInput.InputBox.FocusLost:Connect(function()
                        if not pcall(function()
                            local r, g, b = string.match(ColorPicker.HexInput.InputBox.Text, '^#?(%w%w)(%w%w)(%w%w)$')
                            local rgbColor = Color3.fromRGB(tonumber(r, 16), tonumber(g, 16), tonumber(b, 16))

                            h, s, v = rgbColor:ToHSV()
                            hex = ColorPicker.HexInput.InputBox.Text

                            setDisplay()

                            ColorPickerSettings.Color = rgbColor
                        end) then
                            ColorPicker.HexInput.InputBox.Text = hex
                        end

                        pcall(function()
                            ColorPickerSettings.Callback(Color3.fromHSV(h, s, v))
                        end)

                        local r, g, b = math.floor((h * 255) + 0.5), math.floor((s * 255) + 0.5), math.floor((v * 255) + 0.5)

                        ColorPickerSettings.Color = Color3.fromRGB(r, g, b)

                        if not ColorPickerSettings.Ext then
                            SaveConfiguration()
                        end
                    end)

                    local rgbBoxes = function(box, toChange)
                        local value = tonumber(box.Text)
                        local color = Color3.fromHSV(h, s, v)
                        local oldR, oldG, oldB = math.floor((color.R * 255) + 0.5), math.floor((color.G * 255) + 0.5), math.floor((color.B * 255) + 0.5)
                        local save

                        if toChange == 'R' then
                            save = oldR
                            oldR = value
                        elseif toChange == 'G' then
                            save = oldG
                            oldG = value
                        else
                            save = oldB
                            oldB = value
                        end
                        if value then
                            value = math.clamp(value, 0, 255)
                            h, s, v = Color3.fromRGB(oldR, oldG, oldB):ToHSV()

                            setDisplay()
                        else
                            box.Text = tostring(save)
                        end

                        local r, g, b = math.floor((h * 255) + 0.5), math.floor((s * 255) + 0.5), math.floor((v * 255) + 0.5)

                        ColorPickerSettings.Color = Color3.fromRGB(r, g, b)

                        if not ColorPickerSettings.Ext then
                            SaveConfiguration()
                        end
                    end

                    ColorPicker.RGB.RInput.InputBox.FocusLost:connect(function()
                        rgbBoxes(ColorPicker.RGB.RInput.InputBox, 'R')
                        pcall(function()
                            ColorPickerSettings.Callback(Color3.fromHSV(h, s, v))
                        end)
                    end)
                    ColorPicker.RGB.GInput.InputBox.FocusLost:connect(function()
                        rgbBoxes(ColorPicker.RGB.GInput.InputBox, 'G')
                        pcall(function()
                            ColorPickerSettings.Callback(Color3.fromHSV(h, s, v))
                        end)
                    end)
                    ColorPicker.RGB.BInput.InputBox.FocusLost:connect(function()
                        rgbBoxes(ColorPicker.RGB.BInput.InputBox, 'B')
                        pcall(function()
                            ColorPickerSettings.Callback(Color3.fromHSV(h, s, v))
                        end)
                    end)
                    RunService.RenderStepped:connect(function()
                        if mainDragging then
                            local localX = math.clamp(mouse.X - Main.AbsolutePosition.X, 0, Main.AbsoluteSize.X)
                            local localY = math.clamp(mouse.Y - Main.AbsolutePosition.Y, 0, Main.AbsoluteSize.Y)

                            Main.MainPoint.Position = UDim2.new(0, localX - Main.MainPoint.AbsoluteSize.X / 2, 0, localY - Main.MainPoint.AbsoluteSize.Y / 2)
                            s = localX / Main.AbsoluteSize.X
                            v = 1 - (localY / Main.AbsoluteSize.Y)
                            Display.BackgroundColor3 = Color3.fromHSV(h, s, v)
                            Main.MainPoint.ImageColor3 = Color3.fromHSV(h, s, v)
                            Background.BackgroundColor3 = Color3.fromHSV(h, 1, 1)

                            local color = Color3.fromHSV(h, s, v)
                            local r, g, b = math.floor((color.R * 255) + 0.5), math.floor((color.G * 255) + 0.5), math.floor((color.B * 255) + 0.5)

                            ColorPicker.RGB.RInput.InputBox.Text = tostring(r)
                            ColorPicker.RGB.GInput.InputBox.Text = tostring(g)
                            ColorPicker.RGB.BInput.InputBox.Text = tostring(b)
                            ColorPicker.HexInput.InputBox.Text = string.format('#%02X%02X%02X', color.R * 0xff, color.G * 0xff, color.B * 0xff)

                            pcall(function()
                                ColorPickerSettings.Callback(Color3.fromHSV(h, s, v))
                            end)

                            ColorPickerSettings.Color = Color3.fromRGB(r, g, b)

                            if not ColorPickerSettings.Ext then
                                SaveConfiguration()
                            end
                        end
                        if sliderDragging then
                            local localX = math.clamp(mouse.X - Slider.AbsolutePosition.X, 0, Slider.AbsoluteSize.X)

                            h = localX / Slider.AbsoluteSize.X
                            Display.BackgroundColor3 = Color3.fromHSV(h, s, v)
                            Slider.SliderPoint.Position = UDim2.new(0, localX - Slider.SliderPoint.AbsoluteSize.X / 2, 0.5, 0)
                            Slider.SliderPoint.ImageColor3 = Color3.fromHSV(h, 1, 1)
                            Background.BackgroundColor3 = Color3.fromHSV(h, 1, 1)
                            Main.MainPoint.ImageColor3 = Color3.fromHSV(h, s, v)

                            local color = Color3.fromHSV(h, s, v)
                            local r, g, b = math.floor((color.R * 255) + 0.5), math.floor((color.G * 255) + 0.5), math.floor((color.B * 255) + 0.5)

                            ColorPicker.RGB.RInput.InputBox.Text = tostring(r)
                            ColorPicker.RGB.GInput.InputBox.Text = tostring(g)
                            ColorPicker.RGB.BInput.InputBox.Text = tostring(b)
                            ColorPicker.HexInput.InputBox.Text = string.format('#%02X%02X%02X', color.R * 0xff, color.G * 0xff, color.B * 0xff)

                            pcall(function()
                                ColorPickerSettings.Callback(Color3.fromHSV(h, s, v))
                            end)

                            ColorPickerSettings.Color = Color3.fromRGB(r, g, b)

                            if not ColorPickerSettings.Ext then
                                SaveConfiguration()
                            end
                        end
                    end)

                    if Settings.ConfigurationSaving then
                        if Settings.ConfigurationSaving.Enabled and ColorPickerSettings.Flag then
                            RayfieldLibrary.Flags[ColorPickerSettings.Flag] = ColorPickerSettings
                        end
                    end

                    function ColorPickerSettings:Set(RGBColor)
                        ColorPickerSettings.Color = RGBColor
                        h, s, v = ColorPickerSettings.Color:ToHSV()
                        color = Color3.fromHSV(h, s, v)

                        setDisplay()
                    end

                    ColorPicker.MouseEnter:Connect(function()
                        TweenService:Create(ColorPicker, TweenInfo.new(0.6, Enum.EasingStyle.Exponential), {
                            BackgroundColor3 = SelectedTheme.ElementBackgroundHover,
                        }):Play()
                    end)
                    ColorPicker.MouseLeave:Connect(function()
                        TweenService:Create(ColorPicker, TweenInfo.new(0.6, Enum.EasingStyle.Exponential), {
                            BackgroundColor3 = SelectedTheme.ElementBackground,
                        }):Play()
                    end)
                    Rayfield.Main:GetPropertyChangedSignal('BackgroundColor3'):Connect(function(
                    )
                        for _, rgbinput in ipairs(ColorPicker.RGB:GetChildren())do
                            if rgbinput:IsA('Frame') then
                                rgbinput.BackgroundColor3 = SelectedTheme.InputBackground
                                rgbinput.UIStroke.Color = SelectedTheme.InputStroke
                            end
                        end

                        ColorPicker.HexInput.BackgroundColor3 = SelectedTheme.InputBackground
                        ColorPicker.HexInput.UIStroke.Color = SelectedTheme.InputStroke
                    end)

                    return ColorPickerSettings
                end
                function Tab:CreateSection(SectionName)
                    local SectionValue = {}

                    if SDone then
                        local SectionSpace = Elements.Template.SectionSpacing:Clone()

                        SectionSpace.Visible = true
                        SectionSpace.Parent = TabPage
                    end

                    local Section = Elements.Template.SectionTitle:Clone()

                    Section.Title.Text = SectionName
                    Section.Visible = true
                    Section.Parent = TabPage
                    Section.Title.TextTransparency = 1

                    TweenService:Create(Section.Title, TweenInfo.new(0.7, Enum.EasingStyle.Exponential), {TextTransparency = 0.4}):Play()

                    function SectionValue:Set(NewSection)
                        Section.Title.Text = NewSection
                    end

                    SDone = true

                    return SectionValue
                end
                function Tab:CreateDivider()
                    local DividerValue = {}
                    local Divider = Elements.Template.Divider:Clone()

                    Divider.Visible = true
                    Divider.Parent = TabPage
                    Divider.Divider.BackgroundTransparency = 1

                    TweenService:Create(Divider.Divider, TweenInfo.new(0.5, Enum.EasingStyle.Exponential), {BackgroundTransparency = 0.85}):Play()

                    function DividerValue:Set(Value)
                        Divider.Visible = Value
                    end

                    return DividerValue
                end
                function Tab:CreateLabel(LabelText, Icon, Color, IgnoreTheme)
                    local LabelValue = {}
                    local Label = Elements.Template.Label:Clone()

                    Label.Title.Text = LabelText
                    Label.Visible = true
                    Label.Parent = TabPage
                    Label.BackgroundColor3 = Color or SelectedTheme.SecondaryElementBackground
                    Label.UIStroke.Color = Color or SelectedTheme.SecondaryElementStroke

                    if Icon then
                        if typeof(Icon) == 'string' then
                            local asset = getIcon(Icon)

                            Label.Icon.Image = 'rbxassetid://' .. asset.id
                            Label.Icon.ImageRectOffset = asset.imageRectOffset
                            Label.Icon.ImageRectSize = asset.imageRectSize
                        else
                            Label.Icon.Image = 'rbxassetid://' .. (Icon or 0)
                        end
                    else
                        Label.Icon.Image = 'rbxassetid://0'
                    end
                    if Icon and Label:FindFirstChild('Icon') then
                        Label.Title.Position = UDim2.new(0, 45, 0.5, 0)
                        Label.Title.Size = UDim2.new(1, -100, 0, 14)

                        if Icon then
                            if typeof(Icon) == 'string' then
                                local asset = getIcon(Icon)

                                Label.Icon.Image = 'rbxassetid://' .. asset.id
                                Label.Icon.ImageRectOffset = asset.imageRectOffset
                                Label.Icon.ImageRectSize = asset.imageRectSize
                            else
                                Label.Icon.Image = 'rbxassetid://' .. (Icon or 0)
                            end
                        else
                            Label.Icon.Image = 'rbxassetid://0'
                        end

                        Label.Icon.Visible = true
                    end

                    Label.Icon.ImageTransparency = 1
                    Label.BackgroundTransparency = 1
                    Label.UIStroke.Transparency = 1
                    Label.Title.TextTransparency = 1

                    TweenService:Create(Label, TweenInfo.new(0.7, Enum.EasingStyle.Exponential), {
                        BackgroundTransparency = Color and 0.8 or 0,
                    }):Play()
                    TweenService:Create(Label.UIStroke, TweenInfo.new(0.7, Enum.EasingStyle.Exponential), {
                        Transparency = Color and 0.7 or 0,
                    }):Play()
                    TweenService:Create(Label.Icon, TweenInfo.new(0.7, Enum.EasingStyle.Exponential), {ImageTransparency = 0.2}):Play()
                    TweenService:Create(Label.Title, TweenInfo.new(0.7, Enum.EasingStyle.Exponential), {
                        TextTransparency = Color and 0.2 or 0,
                    }):Play()

                    function LabelValue:Set(NewLabel, Icon, Color)
                        Label.Title.Text = NewLabel

                        if Color then
                            Label.BackgroundColor3 = Color or SelectedTheme.SecondaryElementBackground
                            Label.UIStroke.Color = Color or SelectedTheme.SecondaryElementStroke
                        end
                        if Icon and Label:FindFirstChild('Icon') then
                            Label.Title.Position = UDim2.new(0, 45, 0.5, 0)
                            Label.Title.Size = UDim2.new(1, -100, 0, 14)

                            if Icon then
                                if typeof(Icon) == 'string' then
                                    local asset = getIcon(Icon)

                                    Label.Icon.Image = 'rbxassetid://' .. asset.id
                                    Label.Icon.ImageRectOffset = asset.imageRectOffset
                                    Label.Icon.ImageRectSize = asset.imageRectSize
                                else
                                    Label.Icon.Image = 'rbxassetid://' .. (Icon or 0)
                                end
                            else
                                Label.Icon.Image = 'rbxassetid://0'
                            end

                            Label.Icon.Visible = true
                        end
                    end

                    Rayfield.Main:GetPropertyChangedSignal('BackgroundColor3'):Connect(function(
                    )
                        Label.BackgroundColor3 = IgnoreTheme and (Color or Label.BackgroundColor3) or SelectedTheme.SecondaryElementBackground
                        Label.UIStroke.Color = IgnoreTheme and (Color or Label.BackgroundColor3) or SelectedTheme.SecondaryElementStroke
                    end)

                    return LabelValue
                end
                function Tab:CreateParagraph(ParagraphSettings)
                    local ParagraphValue = {}
                    local Paragraph = Elements.Template.Paragraph:Clone()

                    Paragraph.Title.Text = ParagraphSettings.Title
                    Paragraph.Content.Text = ParagraphSettings.Content
                    Paragraph.Visible = true
                    Paragraph.Parent = TabPage
                    Paragraph.BackgroundTransparency = 1
                    Paragraph.UIStroke.Transparency = 1
                    Paragraph.Title.TextTransparency = 1
                    Paragraph.Content.TextTransparency = 1
                    Paragraph.BackgroundColor3 = SelectedTheme.SecondaryElementBackground
                    Paragraph.UIStroke.Color = SelectedTheme.SecondaryElementStroke

                    TweenService:Create(Paragraph, TweenInfo.new(0.7, Enum.EasingStyle.Exponential), {BackgroundTransparency = 0}):Play()
                    TweenService:Create(Paragraph.UIStroke, TweenInfo.new(0.7, Enum.EasingStyle.Exponential), {Transparency = 0}):Play()
                    TweenService:Create(Paragraph.Title, TweenInfo.new(0.7, Enum.EasingStyle.Exponential), {TextTransparency = 0}):Play()
                    TweenService:Create(Paragraph.Content, TweenInfo.new(0.7, Enum.EasingStyle.Exponential), {TextTransparency = 0}):Play()

                    function ParagraphValue:Set(NewParagraphSettings)
                        Paragraph.Title.Text = NewParagraphSettings.Title
                        Paragraph.Content.Text = NewParagraphSettings.Content
                    end

                    Rayfield.Main:GetPropertyChangedSignal('BackgroundColor3'):Connect(function(
                    )
                        Paragraph.BackgroundColor3 = SelectedTheme.SecondaryElementBackground
                        Paragraph.UIStroke.Color = SelectedTheme.SecondaryElementStroke
                    end)

                    return ParagraphValue
                end
                function Tab:CreateInput(InputSettings)
                    local Input = Elements.Template.Input:Clone()

                    Input.Name = InputSettings.Name
                    Input.Title.Text = InputSettings.Name
                    Input.Visible = true
                    Input.Parent = TabPage
                    Input.BackgroundTransparency = 1
                    Input.UIStroke.Transparency = 1
                    Input.Title.TextTransparency = 1
                    Input.InputFrame.InputBox.Text = InputSettings.CurrentValue or ''
                    Input.InputFrame.BackgroundColor3 = SelectedTheme.InputBackground
                    Input.InputFrame.UIStroke.Color = SelectedTheme.InputStroke

                    TweenService:Create(Input, TweenInfo.new(0.7, Enum.EasingStyle.Exponential), {BackgroundTransparency = 0}):Play()
                    TweenService:Create(Input.UIStroke, TweenInfo.new(0.7, Enum.EasingStyle.Exponential), {Transparency = 0}):Play()
                    TweenService:Create(Input.Title, TweenInfo.new(0.7, Enum.EasingStyle.Exponential), {TextTransparency = 0}):Play()

                    Input.InputFrame.InputBox.PlaceholderText = InputSettings.PlaceholderText
                    Input.InputFrame.Size = UDim2.new(0, Input.InputFrame.InputBox.TextBounds.X + 24, 0, 30)

                    Input.InputFrame.InputBox.FocusLost:Connect(function()
                        local Success, Response = pcall(function()
                            InputSettings.Callback(Input.InputFrame.InputBox.Text)

                            InputSettings.CurrentValue = Input.InputFrame.InputBox.Text
                        end)

                        if not Success then
                            TweenService:Create(Input, TweenInfo.new(0.6, Enum.EasingStyle.Exponential), {
                                BackgroundColor3 = Color3.fromRGB(85, 0, 0),
                            }):Play()
                            TweenService:Create(Input.UIStroke, TweenInfo.new(0.6, Enum.EasingStyle.Exponential), {Transparency = 1}):Play()

                            Input.Title.Text = 'Callback Error'

                            print('Rayfield | ' .. InputSettings.Name .. ' Callback Error ' .. tostring(Response))
                            warn(
[[Check docs.sirius.menu for help with Rayfield specific development.]])
                            task.wait(0.5)

                            Input.Title.Text = InputSettings.Name

                            TweenService:Create(Input, TweenInfo.new(0.6, Enum.EasingStyle.Exponential), {
                                BackgroundColor3 = SelectedTheme.ElementBackground,
                            }):Play()
                            TweenService:Create(Input.UIStroke, TweenInfo.new(0.6, Enum.EasingStyle.Exponential), {Transparency = 0}):Play()
                        end
                        if InputSettings.RemoveTextAfterFocusLost then
                            Input.InputFrame.InputBox.Text = ''
                        end
                        if not InputSettings.Ext then
                            SaveConfiguration()
                        end
                    end)
                    Input.MouseEnter:Connect(function()
                        TweenService:Create(Input, TweenInfo.new(0.6, Enum.EasingStyle.Exponential), {
                            BackgroundColor3 = SelectedTheme.ElementBackgroundHover,
                        }):Play()
                    end)
                    Input.MouseLeave:Connect(function()
                        TweenService:Create(Input, TweenInfo.new(0.6, Enum.EasingStyle.Exponential), {
                            BackgroundColor3 = SelectedTheme.ElementBackground,
                        }):Play()
                    end)
                    Input.InputFrame.InputBox:GetPropertyChangedSignal('Text'):Connect(function(
                    )
                        TweenService:Create(Input.InputFrame, TweenInfo.new(0.55, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
                            Size = UDim2.new(0, Input.InputFrame.InputBox.TextBounds.X + 24, 0, 30),
                        }):Play()
                    end)

                    function InputSettings:Set(text)
                        Input.InputFrame.InputBox.Text = text
                        InputSettings.CurrentValue = text

                        pcall(function()
                            InputSettings.Callback(text)
                        end)

                        if not InputSettings.Ext then
                            SaveConfiguration()
                        end
                    end

                    if Settings.ConfigurationSaving then
                        if Settings.ConfigurationSaving.Enabled and InputSettings.Flag then
                            RayfieldLibrary.Flags[InputSettings.Flag] = InputSettings
                        end
                    end

                    Rayfield.Main:GetPropertyChangedSignal('BackgroundColor3'):Connect(function(
                    )
                        Input.InputFrame.BackgroundColor3 = SelectedTheme.InputBackground
                        Input.InputFrame.UIStroke.Color = SelectedTheme.InputStroke
                    end)

                    return InputSettings
                end
                function Tab:CreateDropdown(DropdownSettings)
                    local Dropdown = Elements.Template.Dropdown:Clone()

                    if string.find(DropdownSettings.Name, 'closed') then
                        Dropdown.Name = 'Dropdown'
                    else
                        Dropdown.Name = DropdownSettings.Name
                    end

                    Dropdown.Title.Text = DropdownSettings.Name
                    Dropdown.Visible = true
                    Dropdown.Parent = TabPage
                    Dropdown.List.Visible = false

                    if DropdownSettings.CurrentOption then
                        if type(DropdownSettings.CurrentOption) == 'string' then
                            DropdownSettings.CurrentOption = {
                                DropdownSettings.CurrentOption,
                            }
                        end
                        if not DropdownSettings.MultipleOptions and type(DropdownSettings.CurrentOption) == 'table' then
                            DropdownSettings.CurrentOption = {
                                DropdownSettings.CurrentOption[1],
                            }
                        end
                    else
                        DropdownSettings.CurrentOption = {}
                    end
                    if DropdownSettings.MultipleOptions then
                        if DropdownSettings.CurrentOption and type(DropdownSettings.CurrentOption) == 'table' then
                            if #DropdownSettings.CurrentOption == 1 then
                                Dropdown.Selected.Text = DropdownSettings.CurrentOption[1]
                            elseif #DropdownSettings.CurrentOption == 0 then
                                Dropdown.Selected.Text = 'None'
                            else
                                Dropdown.Selected.Text = 'Various'
                            end
                        else
                            DropdownSettings.CurrentOption = {}
                            Dropdown.Selected.Text = 'None'
                        end
                    else
                        Dropdown.Selected.Text = DropdownSettings.CurrentOption[1] or 'None'
                    end

                    Dropdown.Toggle.ImageColor3 = SelectedTheme.TextColor

                    TweenService:Create(Dropdown, TweenInfo.new(0.4, Enum.EasingStyle.Exponential), {
                        BackgroundColor3 = SelectedTheme.ElementBackground,
                    }):Play()

                    Dropdown.BackgroundTransparency = 1
                    Dropdown.UIStroke.Transparency = 1
                    Dropdown.Title.TextTransparency = 1
                    Dropdown.Size = UDim2.new(1, -10, 0, 45)

                    TweenService:Create(Dropdown, TweenInfo.new(0.7, Enum.EasingStyle.Exponential), {BackgroundTransparency = 0}):Play()
                    TweenService:Create(Dropdown.UIStroke, TweenInfo.new(0.7, Enum.EasingStyle.Exponential), {Transparency = 0}):Play()
                    TweenService:Create(Dropdown.Title, TweenInfo.new(0.7, Enum.EasingStyle.Exponential), {TextTransparency = 0}):Play()

                    for _, ununusedoption in ipairs(Dropdown.List:GetChildren())do
                        if ununusedoption.ClassName == 'Frame' and ununusedoption.Name ~= 'Placeholder' then
                            ununusedoption:Destroy()
                        end
                    end

                    Dropdown.Toggle.Rotation = 180

                    Dropdown.Interact.MouseButton1Click:Connect(function()
                        TweenService:Create(Dropdown, TweenInfo.new(0.4, Enum.EasingStyle.Exponential), {
                            BackgroundColor3 = SelectedTheme.ElementBackgroundHover,
                        }):Play()
                        TweenService:Create(Dropdown.UIStroke, TweenInfo.new(0.4, Enum.EasingStyle.Exponential), {Transparency = 1}):Play()
                        task.wait(0.1)
                        TweenService:Create(Dropdown, TweenInfo.new(0.4, Enum.EasingStyle.Exponential), {
                            BackgroundColor3 = SelectedTheme.ElementBackground,
                        }):Play()
                        TweenService:Create(Dropdown.UIStroke, TweenInfo.new(0.4, Enum.EasingStyle.Exponential), {Transparency = 0}):Play()

                        if Debounce then
                            return
                        end
                        if Dropdown.List.Visible then
                            Debounce = true

                            TweenService:Create(Dropdown, TweenInfo.new(0.5, Enum.EasingStyle.Exponential), {
                                Size = UDim2.new(1, -10, 0, 45),
                            }):Play()

                            for _, DropdownOpt in ipairs(Dropdown.List:GetChildren())do
                                if DropdownOpt.ClassName == 'Frame' and DropdownOpt.Name ~= 'Placeholder' then
                                    TweenService:Create(DropdownOpt, TweenInfo.new(0.3, Enum.EasingStyle.Exponential), {BackgroundTransparency = 1}):Play()
                                    TweenService:Create(DropdownOpt.UIStroke, TweenInfo.new(0.3, Enum.EasingStyle.Exponential), {Transparency = 1}):Play()
                                    TweenService:Create(DropdownOpt.Title, TweenInfo.new(0.3, Enum.EasingStyle.Exponential), {TextTransparency = 1}):Play()
                                end
                            end

                            TweenService:Create(Dropdown.List, TweenInfo.new(0.3, Enum.EasingStyle.Exponential), {ScrollBarImageTransparency = 1}):Play()
                            TweenService:Create(Dropdown.Toggle, TweenInfo.new(0.7, Enum.EasingStyle.Exponential), {Rotation = 180}):Play()
                            task.wait(0.35)

                            Dropdown.List.Visible = false
                            Debounce = false
                        else
                            TweenService:Create(Dropdown, TweenInfo.new(0.5, Enum.EasingStyle.Exponential), {
                                Size = UDim2.new(1, -10, 0, 180),
                            }):Play()

                            Dropdown.List.Visible = true

                            TweenService:Create(Dropdown.List, TweenInfo.new(0.3, Enum.EasingStyle.Exponential), {ScrollBarImageTransparency = 0.7}):Play()
                            TweenService:Create(Dropdown.Toggle, TweenInfo.new(0.7, Enum.EasingStyle.Exponential), {Rotation = 0}):Play()

                            for _, DropdownOpt in ipairs(Dropdown.List:GetChildren())do
                                if DropdownOpt.ClassName == 'Frame' and DropdownOpt.Name ~= 'Placeholder' then
                                    if DropdownOpt.Name ~= Dropdown.Selected.Text then
                                        TweenService:Create(DropdownOpt.UIStroke, TweenInfo.new(0.3, Enum.EasingStyle.Exponential), {Transparency = 0}):Play()
                                    end

                                    TweenService:Create(DropdownOpt, TweenInfo.new(0.3, Enum.EasingStyle.Exponential), {BackgroundTransparency = 0}):Play()
                                    TweenService:Create(DropdownOpt.Title, TweenInfo.new(0.3, Enum.EasingStyle.Exponential), {TextTransparency = 0}):Play()
                                end
                            end
                        end
                    end)
                    Dropdown.MouseEnter:Connect(function()
                        if not Dropdown.List.Visible then
                            TweenService:Create(Dropdown, TweenInfo.new(0.6, Enum.EasingStyle.Exponential), {
                                BackgroundColor3 = SelectedTheme.ElementBackgroundHover,
                            }):Play()
                        end
                    end)
                    Dropdown.MouseLeave:Connect(function()
                        TweenService:Create(Dropdown, TweenInfo.new(0.6, Enum.EasingStyle.Exponential), {
                            BackgroundColor3 = SelectedTheme.ElementBackground,
                        }):Play()
                    end)

                    local SetDropdownOptions = function()
                        for _, Option in ipairs(DropdownSettings.Options)do
                            local DropdownOption = Elements.Template.Dropdown.List.Template:Clone()

                            DropdownOption.Name = Option
                            DropdownOption.Title.Text = Option
                            DropdownOption.Parent = Dropdown.List
                            DropdownOption.Visible = true
                            DropdownOption.BackgroundTransparency = 1
                            DropdownOption.UIStroke.Transparency = 1
                            DropdownOption.Title.TextTransparency = 1
                            DropdownOption.Interact.ZIndex = 50

                            DropdownOption.Interact.MouseButton1Click:Connect(function(
                            )
                                if not DropdownSettings.MultipleOptions and table.find(DropdownSettings.CurrentOption, Option) then
                                    return
                                end
                                if table.find(DropdownSettings.CurrentOption, Option) then
                                    table.remove(DropdownSettings.CurrentOption, table.find(DropdownSettings.CurrentOption, Option))

                                    if DropdownSettings.MultipleOptions then
                                        if #DropdownSettings.CurrentOption == 1 then
                                            Dropdown.Selected.Text = DropdownSettings.CurrentOption[1]
                                        elseif #DropdownSettings.CurrentOption == 0 then
                                            Dropdown.Selected.Text = 'None'
                                        else
                                            Dropdown.Selected.Text = 'Various'
                                        end
                                    else
                                        Dropdown.Selected.Text = DropdownSettings.CurrentOption[1]
                                    end
                                else
                                    if not DropdownSettings.MultipleOptions then
                                        table.clear(DropdownSettings.CurrentOption)
                                    end

                                    table.insert(DropdownSettings.CurrentOption, Option)

                                    if DropdownSettings.MultipleOptions then
                                        if #DropdownSettings.CurrentOption == 1 then
                                            Dropdown.Selected.Text = DropdownSettings.CurrentOption[1]
                                        elseif #DropdownSettings.CurrentOption == 0 then
                                            Dropdown.Selected.Text = 'None'
                                        else
                                            Dropdown.Selected.Text = 'Various'
                                        end
                                    else
                                        Dropdown.Selected.Text = DropdownSettings.CurrentOption[1]
                                    end

                                    TweenService:Create(DropdownOption.UIStroke, TweenInfo.new(0.3, Enum.EasingStyle.Exponential), {Transparency = 1}):Play()
                                    TweenService:Create(DropdownOption, TweenInfo.new(0.3, Enum.EasingStyle.Exponential), {
                                        BackgroundColor3 = SelectedTheme.DropdownSelected,
                                    }):Play()

                                    Debounce = true
                                end

                                local Success, Response = pcall(function()
                                    DropdownSettings.Callback(DropdownSettings.CurrentOption)
                                end)

                                if not Success then
                                    TweenService:Create(Dropdown, TweenInfo.new(0.6, Enum.EasingStyle.Exponential), {
                                        BackgroundColor3 = Color3.fromRGB(85, 0, 0),
                                    }):Play()
                                    TweenService:Create(Dropdown.UIStroke, TweenInfo.new(0.6, Enum.EasingStyle.Exponential), {Transparency = 1}):Play()

                                    Dropdown.Title.Text = 'Callback Error'

                                    print('Rayfield | ' .. DropdownSettings.Name .. ' Callback Error ' .. tostring(Response))
                                    warn(
[[Check docs.sirius.menu for help with Rayfield specific development.]])
                                    task.wait(0.5)

                                    Dropdown.Title.Text = DropdownSettings.Name

                                    TweenService:Create(Dropdown, TweenInfo.new(0.6, Enum.EasingStyle.Exponential), {
                                        BackgroundColor3 = SelectedTheme.ElementBackground,
                                    }):Play()
                                    TweenService:Create(Dropdown.UIStroke, TweenInfo.new(0.6, Enum.EasingStyle.Exponential), {Transparency = 0}):Play()
                                end

                                for _, droption in ipairs(Dropdown.List:GetChildren())do
                                    if droption.ClassName == 'Frame' and droption.Name ~= 'Placeholder' and not table.find(DropdownSettings.CurrentOption, droption.Name) then
                                        TweenService:Create(droption, TweenInfo.new(0.3, Enum.EasingStyle.Exponential), {
                                            BackgroundColor3 = SelectedTheme.DropdownUnselected,
                                        }):Play()
                                    end
                                end

                                if not DropdownSettings.MultipleOptions then
                                    task.wait(0.1)
                                    TweenService:Create(Dropdown, TweenInfo.new(0.5, Enum.EasingStyle.Exponential), {
                                        Size = UDim2.new(1, -10, 0, 45),
                                    }):Play()

                                    for _, DropdownOpt in ipairs(Dropdown.List:GetChildren())do
                                        if DropdownOpt.ClassName == 'Frame' and DropdownOpt.Name ~= 'Placeholder' then
                                            TweenService:Create(DropdownOpt, TweenInfo.new(0.3, Enum.EasingStyle.Exponential), {BackgroundTransparency = 1}):Play()
                                            TweenService:Create(DropdownOpt.UIStroke, TweenInfo.new(0.3, Enum.EasingStyle.Exponential), {Transparency = 1}):Play()
                                            TweenService:Create(DropdownOpt.Title, TweenInfo.new(0.3, Enum.EasingStyle.Exponential), {TextTransparency = 1}):Play()
                                        end
                                    end

                                    TweenService:Create(Dropdown.List, TweenInfo.new(0.3, Enum.EasingStyle.Exponential), {ScrollBarImageTransparency = 1}):Play()
                                    TweenService:Create(Dropdown.Toggle, TweenInfo.new(0.7, Enum.EasingStyle.Exponential), {Rotation = 180}):Play()
                                    task.wait(0.35)

                                    Dropdown.List.Visible = false
                                end

                                Debounce = false

                                if not DropdownSettings.Ext then
                                    SaveConfiguration()
                                end
                            end)
                            Rayfield.Main:GetPropertyChangedSignal('BackgroundColor3'):Connect(function(
                            )
                                DropdownOption.UIStroke.Color = SelectedTheme.ElementStroke
                            end)
                        end
                    end

                    SetDropdownOptions()

                    for _, droption in ipairs(Dropdown.List:GetChildren())do
                        if droption.ClassName == 'Frame' and droption.Name ~= 'Placeholder' then
                            if not table.find(DropdownSettings.CurrentOption, droption.Name) then
                                droption.BackgroundColor3 = SelectedTheme.DropdownUnselected
                            else
                                droption.BackgroundColor3 = SelectedTheme.DropdownSelected
                            end

                            Rayfield.Main:GetPropertyChangedSignal('BackgroundColor3'):Connect(function(
                            )
                                if not table.find(DropdownSettings.CurrentOption, droption.Name) then
                                    droption.BackgroundColor3 = SelectedTheme.DropdownUnselected
                                else
                                    droption.BackgroundColor3 = SelectedTheme.DropdownSelected
                                end
                            end)
                        end
                    end

                    function DropdownSettings:Set(NewOption)
                        DropdownSettings.CurrentOption = NewOption

                        if typeof(DropdownSettings.CurrentOption) == 'string' then
                            DropdownSettings.CurrentOption = {
                                DropdownSettings.CurrentOption,
                            }
                        end
                        if not DropdownSettings.MultipleOptions then
                            DropdownSettings.CurrentOption = {
                                DropdownSettings.CurrentOption[1],
                            }
                        end
                        if DropdownSettings.MultipleOptions then
                            if #DropdownSettings.CurrentOption == 1 then
                                Dropdown.Selected.Text = DropdownSettings.CurrentOption[1]
                            elseif #DropdownSettings.CurrentOption == 0 then
                                Dropdown.Selected.Text = 'None'
                            else
                                Dropdown.Selected.Text = 'Various'
                            end
                        else
                            Dropdown.Selected.Text = DropdownSettings.CurrentOption[1]
                        end

                        local Success, Response = pcall(function()
                            DropdownSettings.Callback(NewOption)
                        end)

                        if not Success then
                            TweenService:Create(Dropdown, TweenInfo.new(0.6, Enum.EasingStyle.Exponential), {
                                BackgroundColor3 = Color3.fromRGB(85, 0, 0),
                            }):Play()
                            TweenService:Create(Dropdown.UIStroke, TweenInfo.new(0.6, Enum.EasingStyle.Exponential), {Transparency = 1}):Play()

                            Dropdown.Title.Text = 'Callback Error'

                            print('Rayfield | ' .. DropdownSettings.Name .. ' Callback Error ' .. tostring(Response))
                            warn(
[[Check docs.sirius.menu for help with Rayfield specific development.]])
                            task.wait(0.5)

                            Dropdown.Title.Text = DropdownSettings.Name

                            TweenService:Create(Dropdown, TweenInfo.new(0.6, Enum.EasingStyle.Exponential), {
                                BackgroundColor3 = SelectedTheme.ElementBackground,
                            }):Play()
                            TweenService:Create(Dropdown.UIStroke, TweenInfo.new(0.6, Enum.EasingStyle.Exponential), {Transparency = 0}):Play()
                        end

                        for _, droption in ipairs(Dropdown.List:GetChildren())do
                            if droption.ClassName == 'Frame' and droption.Name ~= 'Placeholder' then
                                if not table.find(DropdownSettings.CurrentOption, droption.Name) then
                                    droption.BackgroundColor3 = SelectedTheme.DropdownUnselected
                                else
                                    droption.BackgroundColor3 = SelectedTheme.DropdownSelected
                                end
                            end
                        end
                    end
                    function DropdownSettings:Refresh(optionsTable)
                        DropdownSettings.Options = optionsTable

                        for _, option in Dropdown.List:GetChildren()do
                            if option.ClassName == 'Frame' and option.Name ~= 'Placeholder' then
                                option:Destroy()
                            end
                        end

                        SetDropdownOptions()
                    end

                    if Settings.ConfigurationSaving then
                        if Settings.ConfigurationSaving.Enabled and DropdownSettings.Flag then
                            RayfieldLibrary.Flags[DropdownSettings.Flag] = DropdownSettings
                        end
                    end

                    Rayfield.Main:GetPropertyChangedSignal('BackgroundColor3'):Connect(function(
                    )
                        Dropdown.Toggle.ImageColor3 = SelectedTheme.TextColor

                        TweenService:Create(Dropdown, TweenInfo.new(0.4, Enum.EasingStyle.Exponential), {
                            BackgroundColor3 = SelectedTheme.ElementBackground,
                        }):Play()
                    end)

                    return DropdownSettings
                end
                function Tab:CreateKeybind(KeybindSettings)
                    local CheckingForKey = false
                    local Keybind = Elements.Template.Keybind:Clone()

                    Keybind.Name = KeybindSettings.Name
                    Keybind.Title.Text = KeybindSettings.Name
                    Keybind.Visible = true
                    Keybind.Parent = TabPage
                    Keybind.BackgroundTransparency = 1
                    Keybind.UIStroke.Transparency = 1
                    Keybind.Title.TextTransparency = 1
                    Keybind.KeybindFrame.BackgroundColor3 = SelectedTheme.InputBackground
                    Keybind.KeybindFrame.UIStroke.Color = SelectedTheme.InputStroke

                    TweenService:Create(Keybind, TweenInfo.new(0.7, Enum.EasingStyle.Exponential), {BackgroundTransparency = 0}):Play()
                    TweenService:Create(Keybind.UIStroke, TweenInfo.new(0.7, Enum.EasingStyle.Exponential), {Transparency = 0}):Play()
                    TweenService:Create(Keybind.Title, TweenInfo.new(0.7, Enum.EasingStyle.Exponential), {TextTransparency = 0}):Play()

                    Keybind.KeybindFrame.KeybindBox.Text = KeybindSettings.CurrentKeybind
                    Keybind.KeybindFrame.Size = UDim2.new(0, Keybind.KeybindFrame.KeybindBox.TextBounds.X + 24, 0, 30)

                    Keybind.KeybindFrame.KeybindBox.Focused:Connect(function()
                        CheckingForKey = true
                        Keybind.KeybindFrame.KeybindBox.Text = ''
                    end)
                    Keybind.KeybindFrame.KeybindBox.FocusLost:Connect(function()
                        CheckingForKey = false

                        if Keybind.KeybindFrame.KeybindBox.Text == nil or '' then
                            Keybind.KeybindFrame.KeybindBox.Text = KeybindSettings.CurrentKeybind

                            if not KeybindSettings.Ext then
                                SaveConfiguration()
                            end
                        end
                    end)
                    Keybind.MouseEnter:Connect(function()
                        TweenService:Create(Keybind, TweenInfo.new(0.6, Enum.EasingStyle.Exponential), {
                            BackgroundColor3 = SelectedTheme.ElementBackgroundHover,
                        }):Play()
                    end)
                    Keybind.MouseLeave:Connect(function()
                        TweenService:Create(Keybind, TweenInfo.new(0.6, Enum.EasingStyle.Exponential), {
                            BackgroundColor3 = SelectedTheme.ElementBackground,
                        }):Play()
                    end)
                    UserInputService.InputBegan:Connect(function(
                        input,
                        processed
                    )
                        if CheckingForKey then
                            if input.KeyCode ~= Enum.KeyCode.Unknown then
                                local SplitMessage = string.split(tostring(input.KeyCode), '.')
                                local NewKeyNoEnum = SplitMessage[3]

                                Keybind.KeybindFrame.KeybindBox.Text = tostring(NewKeyNoEnum)
                                KeybindSettings.CurrentKeybind = tostring(NewKeyNoEnum)

                                Keybind.KeybindFrame.KeybindBox:ReleaseFocus()

                                if not KeybindSettings.Ext then
                                    SaveConfiguration()
                                end
                                if KeybindSettings.CallOnChange then
                                    KeybindSettings.Callback(tostring(NewKeyNoEnum))
                                end
                            end
                        elseif not KeybindSettings.CallOnChange and KeybindSettings.CurrentKeybind ~= nil and (input.KeyCode == Enum.KeyCode[KeybindSettings.CurrentKeybind] and not processed) then
                            local Held = true
                            local Connection

                            Connection = input.Changed:Connect(function(prop)
                                if prop == 'UserInputState' then
                                    Connection:Disconnect()

                                    Held = false
                                end
                            end)

                            if not KeybindSettings.HoldToInteract then
                                local Success, Response = pcall(KeybindSettings.Callback)

                                if not Success then
                                    TweenService:Create(Keybind, TweenInfo.new(0.6, Enum.EasingStyle.Exponential), {
                                        BackgroundColor3 = Color3.fromRGB(85, 0, 0),
                                    }):Play()
                                    TweenService:Create(Keybind.UIStroke, TweenInfo.new(0.6, Enum.EasingStyle.Exponential), {Transparency = 1}):Play()

                                    Keybind.Title.Text = 'Callback Error'

                                    print('Rayfield | ' .. KeybindSettings.Name .. ' Callback Error ' .. tostring(Response))
                                    warn(
[[Check docs.sirius.menu for help with Rayfield specific development.]])
                                    task.wait(0.5)

                                    Keybind.Title.Text = KeybindSettings.Name

                                    TweenService:Create(Keybind, TweenInfo.new(0.6, Enum.EasingStyle.Exponential), {
                                        BackgroundColor3 = SelectedTheme.ElementBackground,
                                    }):Play()
                                    TweenService:Create(Keybind.UIStroke, TweenInfo.new(0.6, Enum.EasingStyle.Exponential), {Transparency = 0}):Play()
                                end
                            else
                                task.wait(0.25)

                                if Held then
                                    local Loop

                                    Loop = RunService.Stepped:Connect(function()
                                        if not Held then
                                            KeybindSettings.Callback(false)
                                            Loop:Disconnect()
                                        else
                                            KeybindSettings.Callback(true)
                                        end
                                    end)
                                end
                            end
                        end
                    end)
                    Keybind.KeybindFrame.KeybindBox:GetPropertyChangedSignal('Text'):Connect(function(
                    )
                        TweenService:Create(Keybind.KeybindFrame, TweenInfo.new(0.55, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
                            Size = UDim2.new(0, Keybind.KeybindFrame.KeybindBox.TextBounds.X + 24, 0, 30),
                        }):Play()
                    end)

                    function KeybindSettings:Set(NewKeybind)
                        Keybind.KeybindFrame.KeybindBox.Text = tostring(NewKeybind)
                        KeybindSettings.CurrentKeybind = tostring(NewKeybind)

                        Keybind.KeybindFrame.KeybindBox:ReleaseFocus()

                        if not KeybindSettings.Ext then
                            SaveConfiguration()
                        end
                        if KeybindSettings.CallOnChange then
                            KeybindSettings.Callback(tostring(NewKeybind))
                        end
                    end

                    if Settings.ConfigurationSaving then
                        if Settings.ConfigurationSaving.Enabled and KeybindSettings.Flag then
                            RayfieldLibrary.Flags[KeybindSettings.Flag] = KeybindSettings
                        end
                    end

                    Rayfield.Main:GetPropertyChangedSignal('BackgroundColor3'):Connect(function(
                    )
                        Keybind.KeybindFrame.BackgroundColor3 = SelectedTheme.InputBackground
                        Keybind.KeybindFrame.UIStroke.Color = SelectedTheme.InputStroke
                    end)

                    return KeybindSettings
                end
                function Tab:CreateToggle(ToggleSettings)
                    local Toggle = Elements.Template.Toggle:Clone()

                    Toggle.Name = ToggleSettings.Name
                    Toggle.Title.Text = ToggleSettings.Name
                    Toggle.Visible = true
                    Toggle.Parent = TabPage
                    Toggle.BackgroundTransparency = 1
                    Toggle.UIStroke.Transparency = 1
                    Toggle.Title.TextTransparency = 1
                    Toggle.Switch.BackgroundColor3 = SelectedTheme.ToggleBackground

                    if SelectedTheme ~= RayfieldLibrary.Theme.Default then
                        Toggle.Switch.Shadow.Visible = false
                    end

                    TweenService:Create(Toggle, TweenInfo.new(0.7, Enum.EasingStyle.Exponential), {BackgroundTransparency = 0}):Play()
                    TweenService:Create(Toggle.UIStroke, TweenInfo.new(0.7, Enum.EasingStyle.Exponential), {Transparency = 0}):Play()
                    TweenService:Create(Toggle.Title, TweenInfo.new(0.7, Enum.EasingStyle.Exponential), {TextTransparency = 0}):Play()

                    if ToggleSettings.CurrentValue == true then
                        Toggle.Switch.Indicator.Position = UDim2.new(1, -20, 0.5, 0)
                        Toggle.Switch.Indicator.UIStroke.Color = SelectedTheme.ToggleEnabledStroke
                        Toggle.Switch.Indicator.BackgroundColor3 = SelectedTheme.ToggleEnabled
                        Toggle.Switch.UIStroke.Color = SelectedTheme.ToggleEnabledOuterStroke
                    else
                        Toggle.Switch.Indicator.Position = UDim2.new(1, -40, 0.5, 0)
                        Toggle.Switch.Indicator.UIStroke.Color = SelectedTheme.ToggleDisabledStroke
                        Toggle.Switch.Indicator.BackgroundColor3 = SelectedTheme.ToggleDisabled
                        Toggle.Switch.UIStroke.Color = SelectedTheme.ToggleDisabledOuterStroke
                    end

                    Toggle.MouseEnter:Connect(function()
                        TweenService:Create(Toggle, TweenInfo.new(0.6, Enum.EasingStyle.Exponential), {
                            BackgroundColor3 = SelectedTheme.ElementBackgroundHover,
                        }):Play()
                    end)
                    Toggle.MouseLeave:Connect(function()
                        TweenService:Create(Toggle, TweenInfo.new(0.6, Enum.EasingStyle.Exponential), {
                            BackgroundColor3 = SelectedTheme.ElementBackground,
                        }):Play()
                    end)
                    Toggle.Interact.MouseButton1Click:Connect(function()
                        if ToggleSettings.CurrentValue == true then
                            ToggleSettings.CurrentValue = false

                            TweenService:Create(Toggle, TweenInfo.new(0.6, Enum.EasingStyle.Exponential), {
                                BackgroundColor3 = SelectedTheme.ElementBackgroundHover,
                            }):Play()
                            TweenService:Create(Toggle.UIStroke, TweenInfo.new(0.6, Enum.EasingStyle.Exponential), {Transparency = 1}):Play()
                            TweenService:Create(Toggle.Switch.Indicator, TweenInfo.new(0.45, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                                Position = UDim2.new(1, -40, 0.5, 0),
                            }):Play()
                            TweenService:Create(Toggle.Switch.Indicator.UIStroke, TweenInfo.new(0.55, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
                                Color = SelectedTheme.ToggleDisabledStroke,
                            }):Play()
                            TweenService:Create(Toggle.Switch.Indicator, TweenInfo.new(0.8, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
                                BackgroundColor3 = SelectedTheme.ToggleDisabled,
                            }):Play()
                            TweenService:Create(Toggle.Switch.UIStroke, TweenInfo.new(0.55, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
                                Color = SelectedTheme.ToggleDisabledOuterStroke,
                            }):Play()
                            TweenService:Create(Toggle, TweenInfo.new(0.6, Enum.EasingStyle.Exponential), {
                                BackgroundColor3 = SelectedTheme.ElementBackground,
                            }):Play()
                            TweenService:Create(Toggle.UIStroke, TweenInfo.new(0.6, Enum.EasingStyle.Exponential), {Transparency = 0}):Play()
                        else
                            ToggleSettings.CurrentValue = true

                            TweenService:Create(Toggle, TweenInfo.new(0.6, Enum.EasingStyle.Exponential), {
                                BackgroundColor3 = SelectedTheme.ElementBackgroundHover,
                            }):Play()
                            TweenService:Create(Toggle.UIStroke, TweenInfo.new(0.6, Enum.EasingStyle.Exponential), {Transparency = 1}):Play()
                            TweenService:Create(Toggle.Switch.Indicator, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                                Position = UDim2.new(1, -20, 0.5, 0),
                            }):Play()
                            TweenService:Create(Toggle.Switch.Indicator.UIStroke, TweenInfo.new(0.55, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
                                Color = SelectedTheme.ToggleEnabledStroke,
                            }):Play()
                            TweenService:Create(Toggle.Switch.Indicator, TweenInfo.new(0.8, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
                                BackgroundColor3 = SelectedTheme.ToggleEnabled,
                            }):Play()
                            TweenService:Create(Toggle.Switch.UIStroke, TweenInfo.new(0.55, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
                                Color = SelectedTheme.ToggleEnabledOuterStroke,
                            }):Play()
                            TweenService:Create(Toggle, TweenInfo.new(0.6, Enum.EasingStyle.Exponential), {
                                BackgroundColor3 = SelectedTheme.ElementBackground,
                            }):Play()
                            TweenService:Create(Toggle.UIStroke, TweenInfo.new(0.6, Enum.EasingStyle.Exponential), {Transparency = 0}):Play()
                        end

                        local Success, Response = pcall(function()
                            ToggleSettings.Callback(ToggleSettings.CurrentValue)
                        end)

                        if not Success then
                            TweenService:Create(Toggle, TweenInfo.new(0.6, Enum.EasingStyle.Exponential), {
                                BackgroundColor3 = Color3.fromRGB(85, 0, 0),
                            }):Play()
                            TweenService:Create(Toggle.UIStroke, TweenInfo.new(0.6, Enum.EasingStyle.Exponential), {Transparency = 1}):Play()

                            Toggle.Title.Text = 'Callback Error'

                            print('Rayfield | ' .. ToggleSettings.Name .. ' Callback Error ' .. tostring(Response))
                            warn(
[[Check docs.sirius.menu for help with Rayfield specific development.]])
                            task.wait(0.5)

                            Toggle.Title.Text = ToggleSettings.Name

                            TweenService:Create(Toggle, TweenInfo.new(0.6, Enum.EasingStyle.Exponential), {
                                BackgroundColor3 = SelectedTheme.ElementBackground,
                            }):Play()
                            TweenService:Create(Toggle.UIStroke, TweenInfo.new(0.6, Enum.EasingStyle.Exponential), {Transparency = 0}):Play()
                        end
                        if not ToggleSettings.Ext then
                            SaveConfiguration()
                        end
                    end)

                    function ToggleSettings:Set(NewToggleValue)
                        if NewToggleValue == true then
                            ToggleSettings.CurrentValue = true

                            TweenService:Create(Toggle, TweenInfo.new(0.6, Enum.EasingStyle.Exponential), {
                                BackgroundColor3 = SelectedTheme.ElementBackgroundHover,
                            }):Play()
                            TweenService:Create(Toggle.UIStroke, TweenInfo.new(0.6, Enum.EasingStyle.Exponential), {Transparency = 1}):Play()
                            TweenService:Create(Toggle.Switch.Indicator, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                                Position = UDim2.new(1, -20, 0.5, 0),
                            }):Play()
                            TweenService:Create(Toggle.Switch.Indicator, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                                Size = UDim2.new(0, 12, 0, 12),
                            }):Play()
                            TweenService:Create(Toggle.Switch.Indicator.UIStroke, TweenInfo.new(0.55, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
                                Color = SelectedTheme.ToggleEnabledStroke,
                            }):Play()
                            TweenService:Create(Toggle.Switch.Indicator, TweenInfo.new(0.8, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
                                BackgroundColor3 = SelectedTheme.ToggleEnabled,
                            }):Play()
                            TweenService:Create(Toggle.Switch.UIStroke, TweenInfo.new(0.55, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
                                Color = SelectedTheme.ToggleEnabledOuterStroke,
                            }):Play()
                            TweenService:Create(Toggle.Switch.Indicator, TweenInfo.new(0.45, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                                Size = UDim2.new(0, 17, 0, 17),
                            }):Play()
                            TweenService:Create(Toggle, TweenInfo.new(0.6, Enum.EasingStyle.Exponential), {
                                BackgroundColor3 = SelectedTheme.ElementBackground,
                            }):Play()
                            TweenService:Create(Toggle.UIStroke, TweenInfo.new(0.6, Enum.EasingStyle.Exponential), {Transparency = 0}):Play()
                        else
                            ToggleSettings.CurrentValue = false

                            TweenService:Create(Toggle, TweenInfo.new(0.6, Enum.EasingStyle.Exponential), {
                                BackgroundColor3 = SelectedTheme.ElementBackgroundHover,
                            }):Play()
                            TweenService:Create(Toggle.UIStroke, TweenInfo.new(0.6, Enum.EasingStyle.Exponential), {Transparency = 1}):Play()
                            TweenService:Create(Toggle.Switch.Indicator, TweenInfo.new(0.45, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                                Position = UDim2.new(1, -40, 0.5, 0),
                            }):Play()
                            TweenService:Create(Toggle.Switch.Indicator, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                                Size = UDim2.new(0, 12, 0, 12),
                            }):Play()
                            TweenService:Create(Toggle.Switch.Indicator.UIStroke, TweenInfo.new(0.55, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
                                Color = SelectedTheme.ToggleDisabledStroke,
                            }):Play()
                            TweenService:Create(Toggle.Switch.Indicator, TweenInfo.new(0.8, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
                                BackgroundColor3 = SelectedTheme.ToggleDisabled,
                            }):Play()
                            TweenService:Create(Toggle.Switch.UIStroke, TweenInfo.new(0.55, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
                                Color = SelectedTheme.ToggleDisabledOuterStroke,
                            }):Play()
                            TweenService:Create(Toggle.Switch.Indicator, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                                Size = UDim2.new(0, 17, 0, 17),
                            }):Play()
                            TweenService:Create(Toggle, TweenInfo.new(0.6, Enum.EasingStyle.Exponential), {
                                BackgroundColor3 = SelectedTheme.ElementBackground,
                            }):Play()
                            TweenService:Create(Toggle.UIStroke, TweenInfo.new(0.6, Enum.EasingStyle.Exponential), {Transparency = 0}):Play()
                        end

                        local Success, Response = pcall(function()
                            ToggleSettings.Callback(ToggleSettings.CurrentValue)
                        end)

                        if not Success then
                            TweenService:Create(Toggle, TweenInfo.new(0.6, Enum.EasingStyle.Exponential), {
                                BackgroundColor3 = Color3.fromRGB(85, 0, 0),
                            }):Play()
                            TweenService:Create(Toggle.UIStroke, TweenInfo.new(0.6, Enum.EasingStyle.Exponential), {Transparency = 1}):Play()

                            Toggle.Title.Text = 'Callback Error'

                            print('Rayfield | ' .. ToggleSettings.Name .. ' Callback Error ' .. tostring(Response))
                            warn(
[[Check docs.sirius.menu for help with Rayfield specific development.]])
                            task.wait(0.5)

                            Toggle.Title.Text = ToggleSettings.Name

                            TweenService:Create(Toggle, TweenInfo.new(0.6, Enum.EasingStyle.Exponential), {
                                BackgroundColor3 = SelectedTheme.ElementBackground,
                            }):Play()
                            TweenService:Create(Toggle.UIStroke, TweenInfo.new(0.6, Enum.EasingStyle.Exponential), {Transparency = 0}):Play()
                        end
                        if not ToggleSettings.Ext then
                            SaveConfiguration()
                        end
                    end

                    if not ToggleSettings.Ext then
                        if Settings.ConfigurationSaving then
                            if Settings.ConfigurationSaving.Enabled and ToggleSettings.Flag then
                                RayfieldLibrary.Flags[ToggleSettings.Flag] = ToggleSettings
                            end
                        end
                    end

                    Rayfield.Main:GetPropertyChangedSignal('BackgroundColor3'):Connect(function(
                    )
                        Toggle.Switch.BackgroundColor3 = SelectedTheme.ToggleBackground

                        if SelectedTheme ~= RayfieldLibrary.Theme.Default then
                            Toggle.Switch.Shadow.Visible = false
                        end

                        task.wait()

                        if not ToggleSettings.CurrentValue then
                            Toggle.Switch.Indicator.UIStroke.Color = SelectedTheme.ToggleDisabledStroke
                            Toggle.Switch.Indicator.BackgroundColor3 = SelectedTheme.ToggleDisabled
                            Toggle.Switch.UIStroke.Color = SelectedTheme.ToggleDisabledOuterStroke
                        else
                            Toggle.Switch.Indicator.UIStroke.Color = SelectedTheme.ToggleEnabledStroke
                            Toggle.Switch.Indicator.BackgroundColor3 = SelectedTheme.ToggleEnabled
                            Toggle.Switch.UIStroke.Color = SelectedTheme.ToggleEnabledOuterStroke
                        end
                    end)

                    return ToggleSettings
                end
                function Tab:CreateSlider(SliderSettings)
                    local SLDragging = false
                    local Slider = Elements.Template.Slider:Clone()

                    Slider.Name = SliderSettings.Name
                    Slider.Title.Text = SliderSettings.Name
                    Slider.Visible = true
                    Slider.Parent = TabPage
                    Slider.BackgroundTransparency = 1
                    Slider.UIStroke.Transparency = 1
                    Slider.Title.TextTransparency = 1

                    if SelectedTheme ~= RayfieldLibrary.Theme.Default then
                        Slider.Main.Shadow.Visible = false
                    end

                    Slider.Main.BackgroundColor3 = SelectedTheme.SliderBackground
                    Slider.Main.UIStroke.Color = SelectedTheme.SliderStroke
                    Slider.Main.Progress.UIStroke.Color = SelectedTheme.SliderStroke
                    Slider.Main.Progress.BackgroundColor3 = SelectedTheme.SliderProgress

                    TweenService:Create(Slider, TweenInfo.new(0.7, Enum.EasingStyle.Exponential), {BackgroundTransparency = 0}):Play()
                    TweenService:Create(Slider.UIStroke, TweenInfo.new(0.7, Enum.EasingStyle.Exponential), {Transparency = 0}):Play()
                    TweenService:Create(Slider.Title, TweenInfo.new(0.7, Enum.EasingStyle.Exponential), {TextTransparency = 0}):Play()

                    Slider.Main.Progress.Size = UDim2.new(0, Slider.Main.AbsoluteSize.X * ((SliderSettings.CurrentValue + SliderSettings.Range[1]) / (SliderSettings.Range[2] - SliderSettings.Range[1])) > 5 and Slider.Main.AbsoluteSize.X * (SliderSettings.CurrentValue / (SliderSettings.Range[2] - SliderSettings.Range[1])) or 5, 1, 0)

                    if not SliderSettings.Suffix then
                        Slider.Main.Information.Text = tostring(SliderSettings.CurrentValue)
                    else
                        Slider.Main.Information.Text = tostring(SliderSettings.CurrentValue) .. ' ' .. SliderSettings.Suffix
                    end

                    Slider.MouseEnter:Connect(function()
                        TweenService:Create(Slider, TweenInfo.new(0.6, Enum.EasingStyle.Exponential), {
                            BackgroundColor3 = SelectedTheme.ElementBackgroundHover,
                        }):Play()
                    end)
                    Slider.MouseLeave:Connect(function()
                        TweenService:Create(Slider, TweenInfo.new(0.6, Enum.EasingStyle.Exponential), {
                            BackgroundColor3 = SelectedTheme.ElementBackground,
                        }):Play()
                    end)
                    Slider.Main.Interact.InputBegan:Connect(function(Input)
                        if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
                            TweenService:Create(Slider.Main.UIStroke, TweenInfo.new(0.6, Enum.EasingStyle.Exponential), {Transparency = 1}):Play()
                            TweenService:Create(Slider.Main.Progress.UIStroke, TweenInfo.new(0.6, Enum.EasingStyle.Exponential), {Transparency = 1}):Play()

                            SLDragging = true
                        end
                    end)
                    Slider.Main.Interact.InputEnded:Connect(function(Input)
                        if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
                            TweenService:Create(Slider.Main.UIStroke, TweenInfo.new(0.6, Enum.EasingStyle.Exponential), {Transparency = 0.4}):Play()
                            TweenService:Create(Slider.Main.Progress.UIStroke, TweenInfo.new(0.6, Enum.EasingStyle.Exponential), {Transparency = 0.3}):Play()

                            SLDragging = false
                        end
                    end)
                    Slider.Main.Interact.MouseButton1Down:Connect(function(X)
                        local Current = Slider.Main.Progress.AbsolutePosition.X + Slider.Main.Progress.AbsoluteSize.X
                        local Start = Current
                        local Location = X
                        local Loop

                        Loop = RunService.Stepped:Connect(function()
                            if SLDragging then
                                Location = UserInputService:GetMouseLocation().X
                                Current = Current + 0.025 * (Location - Start)

                                if Location < Slider.Main.AbsolutePosition.X then
                                    Location = Slider.Main.AbsolutePosition.X
                                elseif Location > Slider.Main.AbsolutePosition.X + Slider.Main.AbsoluteSize.X then
                                    Location = Slider.Main.AbsolutePosition.X + Slider.Main.AbsoluteSize.X
                                end
                                if Current < Slider.Main.AbsolutePosition.X + 5 then
                                    Current = Slider.Main.AbsolutePosition.X + 5
                                elseif Current > Slider.Main.AbsolutePosition.X + Slider.Main.AbsoluteSize.X then
                                    Current = Slider.Main.AbsolutePosition.X + Slider.Main.AbsoluteSize.X
                                end
                                if Current <= Location and (Location - Start) < 0 then
                                    Start = Location
                                elseif Current >= Location and (Location - Start) > 0 then
                                    Start = Location
                                end

                                TweenService:Create(Slider.Main.Progress, TweenInfo.new(0.45, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
                                    Size = UDim2.new(0, Current - Slider.Main.AbsolutePosition.X, 1, 0),
                                }):Play()

                                local NewValue = SliderSettings.Range[1] + (Location - Slider.Main.AbsolutePosition.X) / Slider.Main.AbsoluteSize.X * (SliderSettings.Range[2] - SliderSettings.Range[1])

                                NewValue = math.floor(NewValue / SliderSettings.Increment + 0.5) * (SliderSettings.Increment * 10000000) / 10000000
                                NewValue = math.clamp(NewValue, SliderSettings.Range[1], SliderSettings.Range[2])

                                if not SliderSettings.Suffix then
                                    Slider.Main.Information.Text = tostring(NewValue)
                                else
                                    Slider.Main.Information.Text = tostring(NewValue) .. ' ' .. SliderSettings.Suffix
                                end
                                if SliderSettings.CurrentValue ~= NewValue then
                                    local Success, Response = pcall(function()
                                        SliderSettings.Callback(NewValue)
                                    end)

                                    if not Success then
                                        TweenService:Create(Slider, TweenInfo.new(0.6, Enum.EasingStyle.Exponential), {
                                            BackgroundColor3 = Color3.fromRGB(85, 0, 0),
                                        }):Play()
                                        TweenService:Create(Slider.UIStroke, TweenInfo.new(0.6, Enum.EasingStyle.Exponential), {Transparency = 1}):Play()

                                        Slider.Title.Text = 'Callback Error'

                                        print('Rayfield | ' .. SliderSettings.Name .. ' Callback Error ' .. tostring(Response))
                                        warn(
[[Check docs.sirius.menu for help with Rayfield specific development.]])
                                        task.wait(0.5)

                                        Slider.Title.Text = SliderSettings.Name

                                        TweenService:Create(Slider, TweenInfo.new(0.6, Enum.EasingStyle.Exponential), {
                                            BackgroundColor3 = SelectedTheme.ElementBackground,
                                        }):Play()
                                        TweenService:Create(Slider.UIStroke, TweenInfo.new(0.6, Enum.EasingStyle.Exponential), {Transparency = 0}):Play()
                                    end

                                    SliderSettings.CurrentValue = NewValue

                                    if not SliderSettings.Ext then
                                        SaveConfiguration()
                                    end
                                end
                            else
                                TweenService:Create(Slider.Main.Progress, TweenInfo.new(0.3, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
                                    Size = UDim2.new(0, Location - Slider.Main.AbsolutePosition.X > 5 and Location - Slider.Main.AbsolutePosition.X or 5, 1, 0),
                                }):Play()
                                Loop:Disconnect()
                            end
                        end)
                    end)

                    function SliderSettings:Set(NewVal)
                        local NewVal = math.clamp(NewVal, SliderSettings.Range[1], SliderSettings.Range[2])

                        TweenService:Create(Slider.Main.Progress, TweenInfo.new(0.45, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
                            Size = UDim2.new(0, Slider.Main.AbsoluteSize.X * ((NewVal + SliderSettings.Range[1]) / (SliderSettings.Range[2] - SliderSettings.Range[1])) > 5 and Slider.Main.AbsoluteSize.X * (NewVal / (SliderSettings.Range[2] - SliderSettings.Range[1])) or 5, 1, 0),
                        }):Play()

                        Slider.Main.Information.Text = tostring(NewVal) .. ' ' .. (SliderSettings.Suffix or '')

                        local Success, Response = pcall(function()
                            SliderSettings.Callback(NewVal)
                        end)

                        if not Success then
                            TweenService:Create(Slider, TweenInfo.new(0.6, Enum.EasingStyle.Exponential), {
                                BackgroundColor3 = Color3.fromRGB(85, 0, 0),
                            }):Play()
                            TweenService:Create(Slider.UIStroke, TweenInfo.new(0.6, Enum.EasingStyle.Exponential), {Transparency = 1}):Play()

                            Slider.Title.Text = 'Callback Error'

                            print('Rayfield | ' .. SliderSettings.Name .. ' Callback Error ' .. tostring(Response))
                            warn(
[[Check docs.sirius.menu for help with Rayfield specific development.]])
                            task.wait(0.5)

                            Slider.Title.Text = SliderSettings.Name

                            TweenService:Create(Slider, TweenInfo.new(0.6, Enum.EasingStyle.Exponential), {
                                BackgroundColor3 = SelectedTheme.ElementBackground,
                            }):Play()
                            TweenService:Create(Slider.UIStroke, TweenInfo.new(0.6, Enum.EasingStyle.Exponential), {Transparency = 0}):Play()
                        end

                        SliderSettings.CurrentValue = NewVal

                        if not SliderSettings.Ext then
                            SaveConfiguration()
                        end
                    end

                    if Settings.ConfigurationSaving then
                        if Settings.ConfigurationSaving.Enabled and SliderSettings.Flag then
                            RayfieldLibrary.Flags[SliderSettings.Flag] = SliderSettings
                        end
                    end

                    Rayfield.Main:GetPropertyChangedSignal('BackgroundColor3'):Connect(function(
                    )
                        if SelectedTheme ~= RayfieldLibrary.Theme.Default then
                            Slider.Main.Shadow.Visible = false
                        end

                        Slider.Main.BackgroundColor3 = SelectedTheme.SliderBackground
                        Slider.Main.UIStroke.Color = SelectedTheme.SliderStroke
                        Slider.Main.Progress.UIStroke.Color = SelectedTheme.SliderStroke
                        Slider.Main.Progress.BackgroundColor3 = SelectedTheme.SliderProgress
                    end)

                    return SliderSettings
                end

                Rayfield.Main:GetPropertyChangedSignal('BackgroundColor3'):Connect(function(
                )
                    TabButton.UIStroke.Color = SelectedTheme.TabStroke

                    if Elements.UIPageLayout.CurrentPage == TabPage then
                        TabButton.BackgroundColor3 = SelectedTheme.TabBackgroundSelected
                        TabButton.Image.ImageColor3 = SelectedTheme.SelectedTabTextColor
                        TabButton.Title.TextColor3 = SelectedTheme.SelectedTabTextColor
                    else
                        TabButton.BackgroundColor3 = SelectedTheme.TabBackground
                        TabButton.Image.ImageColor3 = SelectedTheme.TabTextColor
                        TabButton.Title.TextColor3 = SelectedTheme.TabTextColor
                    end
                end)

                return Tab
            end

            Elements.Visible = true

            task.wait(1.1)
            TweenService:Create(Main, TweenInfo.new(0.7, Enum.EasingStyle.Exponential, Enum.EasingDirection.InOut), {
                Size = UDim2.new(0, 390, 0, 90),
            }):Play()
            task.wait(0.3)
            TweenService:Create(LoadingFrame.Title, TweenInfo.new(0.2, Enum.EasingStyle.Exponential), {TextTransparency = 1}):Play()
            TweenService:Create(LoadingFrame.Subtitle, TweenInfo.new(0.2, Enum.EasingStyle.Exponential), {TextTransparency = 1}):Play()
            TweenService:Create(LoadingFrame.Version, TweenInfo.new(0.2, Enum.EasingStyle.Exponential), {TextTransparency = 1}):Play()
            task.wait(0.1)
            TweenService:Create(Main, TweenInfo.new(0.6, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
                Size = useMobileSizing and UDim2.new(0, 500, 0, 275) or UDim2.new(0, 500, 0, 475),
            }):Play()
            TweenService:Create(Main.Shadow.Image, TweenInfo.new(0.5, Enum.EasingStyle.Exponential), {ImageTransparency = 0.6}):Play()

            Topbar.BackgroundTransparency = 1
            Topbar.Divider.Size = UDim2.new(0, 0, 0, 1)
            Topbar.Divider.BackgroundColor3 = SelectedTheme.ElementStroke
            Topbar.CornerRepair.BackgroundTransparency = 1
            Topbar.Title.TextTransparency = 1
            Topbar.Search.ImageTransparency = 1

            if Topbar:FindFirstChild('Settings') then
                Topbar.Settings.ImageTransparency = 1
            end

            Topbar.ChangeSize.ImageTransparency = 1
            Topbar.Hide.ImageTransparency = 1

            task.wait(0.5)

            Topbar.Visible = true

            TweenService:Create(Topbar, TweenInfo.new(0.7, Enum.EasingStyle.Exponential), {BackgroundTransparency = 0}):Play()
            TweenService:Create(Topbar.CornerRepair, TweenInfo.new(0.7, Enum.EasingStyle.Exponential), {BackgroundTransparency = 0}):Play()
            task.wait(0.1)
            TweenService:Create(Topbar.Divider, TweenInfo.new(1, Enum.EasingStyle.Exponential), {
                Size = UDim2.new(1, 0, 0, 1),
            }):Play()
            TweenService:Create(Topbar.Title, TweenInfo.new(0.6, Enum.EasingStyle.Exponential), {TextTransparency = 0}):Play()
            task.wait(0.05)
            TweenService:Create(Topbar.Search, TweenInfo.new(0.6, Enum.EasingStyle.Exponential), {ImageTransparency = 0.8}):Play()
            task.wait(0.05)

            if Topbar:FindFirstChild('Settings') then
                TweenService:Create(Topbar.Settings, TweenInfo.new(0.6, Enum.EasingStyle.Exponential), {ImageTransparency = 0.8}):Play()
                task.wait(0.05)
            end

            TweenService:Create(Topbar.ChangeSize, TweenInfo.new(0.6, Enum.EasingStyle.Exponential), {ImageTransparency = 0.8}):Play()
            task.wait(0.05)
            TweenService:Create(Topbar.Hide, TweenInfo.new(0.6, Enum.EasingStyle.Exponential), {ImageTransparency = 0.8}):Play()
            task.wait(0.3)

            if dragBar then
                TweenService:Create(dragBarCosmetic, TweenInfo.new(0.6, Enum.EasingStyle.Exponential), {BackgroundTransparency = 0.7}):Play()
            end

            function Window.ModifyTheme(NewTheme)
                local success = pcall(ChangeTheme, NewTheme)

                if not success then
                    RayfieldLibrary:Notify({
                        Title = 'Unable to Change Theme',
                        Content = 'We are unable find a theme on file.',
                        Image = 4400704299,
                    })
                else
                    RayfieldLibrary:Notify({
                        Title = 'Theme Changed',
                        Content = 'Successfully changed theme to ' .. (typeof(NewTheme) == 'string' and NewTheme or 'Custom Theme') .. '.',
                        Image = 4483362748,
                    })
                end
            end

            createSettings(Window)

            return Window
        end

        local setVisibility = function(visibility, notify)
            if Debounce then
                return
            end
            if visibility then
                Hidden = false

                Unhide()
            else
                Hidden = true

                Hide(notify)
            end
        end

        function RayfieldLibrary:SetVisibility(visibility)
            setVisibility(visibility, false)
        end
        function RayfieldLibrary:IsVisible()
            return not Hidden
        end
        function RayfieldLibrary:Destroy()
            hideHotkeyConnection:Disconnect()
            Rayfield:Destroy()
        end

        Topbar.ChangeSize.MouseButton1Click:Connect(function()
            if Debounce then
                return
            end
            if Minimised then
                Minimised = false

                Maximise()
            else
                Minimised = true

                Minimise()
            end
        end)
        Main.Search.Input:GetPropertyChangedSignal('Text'):Connect(function()
            if #Main.Search.Input.Text > 0 then
                if not Elements.UIPageLayout.CurrentPage:FindFirstChild('SearchTitle-fsefsefesfsefesfesfThanks') then
                    local searchTitle = Elements.Template.SectionTitle:Clone()

                    searchTitle.Parent = Elements.UIPageLayout.CurrentPage
                    searchTitle.Name = 'SearchTitle-fsefsefesfsefesfesfThanks'
                    searchTitle.LayoutOrder = -100
                    searchTitle.Title.Text = "Results from '" .. Elements.UIPageLayout.CurrentPage.Name .. "'"
                    searchTitle.Visible = true
                end
            else
                local searchTitle = Elements.UIPageLayout.CurrentPage:FindFirstChild('SearchTitle-fsefsefesfsefesfesfThanks')

                if searchTitle then
                    searchTitle:Destroy()
                end
            end

            for _, element in ipairs(Elements.UIPageLayout.CurrentPage:GetChildren())do
                if element.ClassName ~= 'UIListLayout' and element.Name ~= 'Placeholder' and element.Name ~= 'SearchTitle-fsefsefesfsefesfesfThanks' then
                    if element.Name == 'SectionTitle' then
                        if #Main.Search.Input.Text == 0 then
                            element.Visible = true
                        else
                            element.Visible = false
                        end
                    else
                        if string.lower(element.Name):find(string.lower(Main.Search.Input.Text), 1, true) then
                            element.Visible = true
                        else
                            element.Visible = false
                        end
                    end
                end
            end
        end)
        Main.Search.Input.FocusLost:Connect(function(enterPressed)
            if #Main.Search.Input.Text == 0 and searchOpen then
                task.wait(0.12)
                closeSearch()
            end
        end)
        Topbar.Search.MouseButton1Click:Connect(function()
            task.spawn(function()
                if searchOpen then
                    closeSearch()
                else
                    openSearch()
                end
            end)
        end)

        if Topbar:FindFirstChild('Settings') then
            Topbar.Settings.MouseButton1Click:Connect(function()
                task.spawn(function()
                    for _, OtherTabButton in ipairs(TabList:GetChildren())do
                        if OtherTabButton.Name ~= 'Template' and OtherTabButton.ClassName == 'Frame' and OtherTabButton.Name ~= 'Placeholder' then
                            TweenService:Create(OtherTabButton, TweenInfo.new(0.7, Enum.EasingStyle.Exponential), {
                                BackgroundColor3 = SelectedTheme.TabBackground,
                            }):Play()
                            TweenService:Create(OtherTabButton.Title, TweenInfo.new(0.7, Enum.EasingStyle.Exponential), {
                                TextColor3 = SelectedTheme.TabTextColor,
                            }):Play()
                            TweenService:Create(OtherTabButton.Image, TweenInfo.new(0.7, Enum.EasingStyle.Exponential), {
                                ImageColor3 = SelectedTheme.TabTextColor,
                            }):Play()
                            TweenService:Create(OtherTabButton, TweenInfo.new(0.7, Enum.EasingStyle.Exponential), {BackgroundTransparency = 0.7}):Play()
                            TweenService:Create(OtherTabButton.Title, TweenInfo.new(0.7, Enum.EasingStyle.Exponential), {TextTransparency = 0.2}):Play()
                            TweenService:Create(OtherTabButton.Image, TweenInfo.new(0.7, Enum.EasingStyle.Exponential), {ImageTransparency = 0.2}):Play()
                            TweenService:Create(OtherTabButton.UIStroke, TweenInfo.new(0.7, Enum.EasingStyle.Exponential), {Transparency = 0.5}):Play()
                        end
                    end

                    Elements.UIPageLayout:JumpTo(Elements['Rayfield Settings'])
                end)
            end)
        end

        Topbar.Hide.MouseButton1Click:Connect(function()
            setVisibility(Hidden, not useMobileSizing)
        end)

        hideHotkeyConnection = UserInputService.InputBegan:Connect(function(
            input,
            processed
        )
            if input.KeyCode == Enum.KeyCode[settingsTable.General.rayfieldOpen.Value or 'K'] and not processed then
                if Debounce then
                    return
                end
                if Hidden then
                    Hidden = false

                    Unhide()
                else
                    Hidden = true

                    Hide()
                end
            end
        end)

        if MPrompt then
            MPrompt.Interact.MouseButton1Click:Connect(function()
                if Debounce then
                    return
                end
                if Hidden then
                    Hidden = false

                    Unhide()
                end
            end)
        end

        for _, TopbarButton in ipairs(Topbar:GetChildren())do
            if TopbarButton.ClassName == 'ImageButton' and TopbarButton.Name ~= 'Icon' then
                TopbarButton.MouseEnter:Connect(function()
                    TweenService:Create(TopbarButton, TweenInfo.new(0.7, Enum.EasingStyle.Exponential), {ImageTransparency = 0}):Play()
                end)
                TopbarButton.MouseLeave:Connect(function()
                    TweenService:Create(TopbarButton, TweenInfo.new(0.7, Enum.EasingStyle.Exponential), {ImageTransparency = 0.8}):Play()
                end)
            end
        end

        function RayfieldLibrary:LoadConfiguration()
            local config

            if debugX then
                warn('Loading Configuration')
            end
            if useStudio then
                config = 
[[{"Toggle1adwawd":true,"ColorPicker1awd":{"B":255,"G":255,"R":255},"Slider1dawd":100,"ColorPicfsefker1":{"B":255,"G":255,"R":255},"Slidefefsr1":80,"dawdawd":"","Input1":"hh","Keybind1":"B","Dropdown1":["Ocean"]}]]
            end
            if CEnabled then
                local notified
                local loaded
                local success, result = pcall(function()
                    if useStudio and config then
                        loaded = LoadConfiguration(config)

                        return
                    end
                    if isfile then
                        if isfile(ConfigurationFolder .. '/' .. CFileName .. ConfigurationExtension) then
                            loaded = LoadConfiguration(readfile(ConfigurationFolder .. '/' .. CFileName .. ConfigurationExtension))
                        end
                    else
                        notified = true

                        RayfieldLibrary:Notify({
                            Title = 'Rayfield Configurations',
                            Content = 
[[We couldn't enable Configuration Saving as you are not using software with filesystem support.]],
                            Image = 4384402990,
                        })
                    end
                end)

                if success and loaded and not notified then
                    RayfieldLibrary:Notify({
                        Title = 'Rayfield Configurations',
                        Content = 
[[The configuration file for this script has been loaded from a previous session.]],
                        Image = 4384403532,
                    })
                elseif not success and not notified then
                    warn('Rayfield Configurations Error | ' .. tostring(result))
                    RayfieldLibrary:Notify({
                        Title = 'Rayfield Configurations',
                        Content = 
[[We've encountered an issue loading your configuration correctly.

Check the Developer Console for more information.]],
                        Image = 4384402990,
                    })
                end
            end

            globalLoaded = true
        end

        if CEnabled and Main:FindFirstChild('Notice') then
            Main.Notice.BackgroundTransparency = 1
            Main.Notice.Title.TextTransparency = 1
            Main.Notice.Size = UDim2.new(0, 0, 0, 0)
            Main.Notice.Position = UDim2.new(0.5, 0, 0, -100)
            Main.Notice.Visible = true

            TweenService:Create(Main.Notice, TweenInfo.new(0.5, Enum.EasingStyle.Exponential, Enum.EasingDirection.InOut), {
                Size = UDim2.new(0, 280, 0, 35),
                Position = UDim2.new(0.5, 0, 0, -50),
                BackgroundTransparency = 0.5,
            }):Play()
            TweenService:Create(Main.Notice.Title, TweenInfo.new(0.5, Enum.EasingStyle.Exponential), {TextTransparency = 0.1}):Play()
        end

        task.delay(4, function()
            RayfieldLibrary.LoadConfiguration()

            if Main:FindFirstChild('Notice') and Main.Notice.Visible then
                TweenService:Create(Main.Notice, TweenInfo.new(0.5, Enum.EasingStyle.Exponential, Enum.EasingDirection.InOut), {
                    Size = UDim2.new(0, 100, 0, 25),
                    Position = UDim2.new(0.5, 0, 0, -100),
                    BackgroundTransparency = 1,
                }):Play()
                TweenService:Create(Main.Notice.Title, TweenInfo.new(0.3, Enum.EasingStyle.Exponential), {TextTransparency = 1}):Play()
                task.wait(0.5)

                Main.Notice.Visible = false
            end
        end)

        return RayfieldLibrary
    end
    function __DARKLUA_BUNDLE_MODULES.b()
        local ReplicatedStorage = game:GetService('ReplicatedStorage')
        local VirtualInputManager = game:GetService('VirtualInputManager')
        local ClientData = require(ReplicatedStorage:WaitForChild('ClientModules'):WaitForChild('Core'):WaitForChild('ClientData'))
        local Misc = {}

        function Misc.ClickGuiButton(button, xOffset1, yOffset1)
            if typeof(button) ~= 'Instance' then
                return print('button is not a Instance')
            end

            local xOffset = xOffset1 or 60
            local yOffset = yOffset1 or 60

            task.wait()
            VirtualInputManager:SendMouseButtonEvent(button.AbsolutePosition.X + xOffset, button.AbsolutePosition.Y + yOffset, 0, true, game, 1)
            task.wait()
            VirtualInputManager:SendMouseButtonEvent(button.AbsolutePosition.X + xOffset, button.AbsolutePosition.Y + yOffset, 0, false, game, 1)
            task.wait()

            return
        end
        function Misc.WaitForPetToEquip()
            local hasPetChar = nil
            local stuckTimer = 0

            repeat
                task.wait(1)

                hasPetChar = ClientData.get('pet_char_wrappers') and ClientData.get('pet_char_wrappers')[1] and ClientData.get('pet_char_wrappers')[1].pet_unique and true or false
                stuckTimer = stuckTimer + 1
            until hasPetChar or stuckTimer > 20

            if stuckTimer > 20 then
                return false
            end

            return true
        end
        function Misc.IsPetEquipped(whichPet)
            local petIndex = ClientData.get('pet_char_wrappers')[whichPet]

            if not petIndex then
                return
            end
            if not petIndex['pet_unique'] then
                return
            end
        end
        function Misc.UnEquip(petUnique, EquipAsLast)
            local success, errorMessage = pcall(function()
                ReplicatedStorage.API['ToolAPI/Unequip']:InvokeServer(petUnique, {
                    ['equip_as_last'] = EquipAsLast,
                })
            end)

            if not success then
                print('Failed to Unequip pet:', errorMessage)

                return false
            end

            return true
        end
        function Misc.Equip(petUnique, EquipAsLast)
            local success, errorMessage = pcall(function()
                ReplicatedStorage.API['ToolAPI/Equip']:InvokeServer(petUnique, {
                    ['equip_as_last'] = EquipAsLast,
                })
            end)

            if not success then
                print('Failed to equip pet:', errorMessage)

                return false
            end

            return true
        end
        function Misc.ReEquipPet(whichPet)
            local hasPetChar = false
            local EquipTimeout = 0

            if not ClientData.get('pet_char_wrappers') then
                return false
            end
            if not ClientData.get('pet_char_wrappers')[whichPet] then
                return false
            end

            local petUnique = ClientData.get('pet_char_wrappers')[whichPet].pet_unique

            if whichPet == 1 then
                if not Misc.UnEquip(petUnique, false) then
                    return false
                end

                task.wait(1)

                if not Misc.Equip(petUnique, false) then
                    return false
                end
            elseif whichPet == 2 then
                if not Misc.UnEquip(petUnique, true) then
                    return false
                end

                task.wait(1)

                if not Misc.Equip(petUnique, true) then
                    return false
                end
            end

            repeat
                task.wait(1)

                hasPetChar = ClientData.get('pet_char_wrappers') and ClientData.get('pet_char_wrappers')[whichPet] and ClientData.get('pet_char_wrappers')[whichPet]['char'] and true or false
                EquipTimeout = EquipTimeout + 1
            until hasPetChar or EquipTimeout >= 20

            if EquipTimeout >= 20 then
                print('\u{26a0}\u{fe0f} Waited too long for Equipping pet \u{26a0}\u{fe0f}')

                return false
            end

            Misc.DebugModePrint(string.format('ReEquipPet: success in equipping %s', tostring(whichPet)))

            return true
        end
        function Misc.DebugModePrint(message)
            if getgenv().debugMode then
                print(message)
            end
        end

        return Misc
    end
    function __DARKLUA_BUNDLE_MODULES.c()
        local ReplicatedStorage = game:GetService('ReplicatedStorage')
        local Players = game:GetService('Players')
        local ClientData = require(ReplicatedStorage:WaitForChild('ClientModules'):WaitForChild('Core'):WaitForChild('ClientData'))
        local localPlayer = Players.LocalPlayer
        local Fusion = {}
        local getFullgrownPets = function(mega)
            local fullgrownTable = {}

            if mega then
                for _, v in ClientData.get_data()[localPlayer.Name].inventory.pets do
                    if v.properties.age == 6 and v.properties.neon then
                        if not fullgrownTable[v.id] then
                            fullgrownTable[v.id] = {
                                ['count'] = 0,
                                ['unique'] = {},
                            }
                        end

                        do
                            local __DARKLUA_VAR = fullgrownTable[v.id]

                            __DARKLUA_VAR['count'] = __DARKLUA_VAR['count'] + 1
                        end

                        table.insert(fullgrownTable[v.id]['unique'], v.unique)

                        if fullgrownTable[v.id]['count'] >= 4 then
                            break
                        end
                    end
                end
            else
                for _, v in ClientData.get_data()[localPlayer.Name].inventory.pets do
                    if v.properties.age == 6 and not v.properties.neon and not v.properties.mega_neon then
                        if not fullgrownTable[v.id] then
                            fullgrownTable[v.id] = {
                                ['count'] = 0,
                                ['unique'] = {},
                            }
                        end

                        do
                            local __DARKLUA_VAR = fullgrownTable[v.id]

                            __DARKLUA_VAR['count'] = __DARKLUA_VAR['count'] + 1
                        end

                        table.insert(fullgrownTable[v.id]['unique'], v.unique)

                        if fullgrownTable[v.id]['count'] >= 4 then
                            break
                        end
                    end
                end
            end

            return fullgrownTable
        end

        function Fusion:MakeMega(bool)
            repeat
                local fusionReady = {}
                local fullgrownTable = getFullgrownPets(bool)

                for _, valueTable in fullgrownTable do
                    if valueTable.count >= 4 then
                        table.insert(fusionReady, valueTable.unique[1])
                        table.insert(fusionReady, valueTable.unique[2])
                        table.insert(fusionReady, valueTable.unique[3])
                        table.insert(fusionReady, valueTable.unique[4])

                        break
                    end
                end

                if #fusionReady >= 4 then
                    ReplicatedStorage.API:FindFirstChild('PetAPI/DoNeonFusion'):InvokeServer({
                        unpack(fusionReady),
                    })
                    task.wait()
                end
            until #fusionReady <= 3

            print('\u{1f389} DONE FUSING \u{1f389}')
        end

        return Fusion
    end
    function __DARKLUA_BUNDLE_MODULES.d()
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
    end
    function __DARKLUA_BUNDLE_MODULES.e()
        local ReplicatedStorage = game:GetService('ReplicatedStorage')
        local Players = game:GetService('Players')
        local ClientData = require(ReplicatedStorage:WaitForChild('ClientModules'):WaitForChild('Core'):WaitForChild('ClientData'))
        local InventoryDB = require(ReplicatedStorage:WaitForChild('ClientDB'):WaitForChild('Inventory'):WaitForChild('InventoryDB'))
        local localPlayer = Players.LocalPlayer
        local GetInventory = {}
        local blackListIds = {
            'practice_dog',
            'spring_2025_minigame_spiked_kaijunior',
            'spring_2025_minigame_scorching_kaijunior',
            'spring_2025_minigame_toxic_kaijunior',
            'spring_2025_minigame_spotted_kaijunior',
        }
        local equipWhichPet = function(whichPet, petUnique)
            if whichPet == 1 then
                ReplicatedStorage.API['ToolAPI/Equip']:InvokeServer(petUnique, {
                    ['equip_as_last'] = false,
                })

                getgenv().petCurrentlyFarming1 = petUnique

                print(string.format('equipWhichPet: %s', tostring(getgenv().petCurrentlyFarming1)))

                return true
            elseif whichPet == 2 then
                ReplicatedStorage.API['ToolAPI/Equip']:InvokeServer(petUnique, {
                    ['equip_as_last'] = true,
                })

                getgenv().petCurrentlyFarming2 = petUnique

                print(string.format('equipWhichPet: %s', tostring(getgenv().petCurrentlyFarming2)))

                return true
            end

            return false
        end

        function GetInventory:GetAll()
            return ClientData.get_data()[localPlayer.Name].inventory
        end
        function GetInventory:TabId(tabId)
            local inventoryTable = {}

            for _, v in ClientData.get_data()[localPlayer.Name].inventory[tabId]do
                if table.find(blackListIds, v.id) then
                    continue
                end
                if table.find(inventoryTable, v.id) then
                    continue
                end

                table.insert(inventoryTable, v.id)
            end

            table.sort(inventoryTable)

            return inventoryTable
        end
        function GetInventory:IsFarmingSelectedPet(hasProHandler)
            if hasProHandler then
                if not ClientData.get('pet_char_wrappers')[2] then
                    return
                end
                if getgenv().petCurrentlyFarming2 == ClientData.get('pet_char_wrappers')[2]['pet_unique'] then
                    return
                end

                print('current pet equipped (2) is not the same pet as selected..')
                print(ReplicatedStorage.API['ToolAPI/Equip']:InvokeServer(getgenv().petCurrentlyFarming2, {}))
            end
            if not ClientData.get('pet_char_wrappers')[1] then
                return
            end
            if getgenv().petCurrentlyFarming1 == ClientData.get('pet_char_wrappers')[1]['pet_unique'] then
                return
            end

            print('current pet equipped (1) is not the same pet as selected..')
            ReplicatedStorage.API['ToolAPI/Equip']:InvokeServer(getgenv().petCurrentlyFarming1, {})
            task.wait(2)

            return
        end
        function GetInventory:GetPetFriendship(whichPet)
            local level = 0
            local petUnique = nil

            for _, pet in ClientData.get_data()[localPlayer.Name].inventory.pets do
                if table.find(blackListIds, pet.id) then
                    continue
                end
                if not pet.properties then
                    continue
                end
                if not pet.properties.friendship_level then
                    continue
                end
                if pet.properties.friendship_level > level then
                    if pet.unique == getgenv().petCurrentlyFarming1 then
                        continue
                    end
                    if pet.unique == getgenv().petCurrentlyFarming2 then
                        continue
                    end

                    level = pet.properties.friendship_level
                    petUnique = pet.unique
                end
            end

            if not petUnique then
                return false
            end

            equipWhichPet(whichPet, petUnique)
            print(string.format('Found pet with friendship level: %s, equipped on: %s', tostring(level), tostring(whichPet)))

            return true
        end
        function GetInventory:GetHighestGrownPet(age, whichPet)
            local PetageCounter = age
            local isNeon = true
            local petFound = false

            while not petFound do
                for _, pet in ClientData.get_data()[localPlayer.Name].inventory.pets do
                    if table.find(blackListIds, pet.id) then
                        continue
                    end
                    if pet.properties.age == PetageCounter and pet.properties.neon == isNeon then
                        if pet.unique == getgenv().petCurrentlyFarming1 then
                            continue
                        end
                        if pet.unique == getgenv().petCurrentlyFarming2 then
                            continue
                        end

                        print(string.format('GetHighestGrownPet: %s', tostring(whichPet)))
                        equipWhichPet(whichPet, pet.unique)

                        return true
                    end
                end

                PetageCounter = PetageCounter - 1

                if PetageCounter <= 0 and isNeon then
                    PetageCounter = age
                    isNeon = nil
                elseif PetageCounter <= 0 and isNeon == nil then
                    return false
                end

                task.wait()
            end

            return false
        end
        function GetInventory:PetRarityAndAge(rarity, age, whichPet)
            local PetageCounter = age
            local isNeon = true
            local petFound = false

            while not petFound do
                for _, pet in ClientData.get_data()[localPlayer.Name].inventory.pets do
                    for _, petDB in InventoryDB.pets do
                        if table.find(blackListIds, pet.id) then
                            continue
                        end
                        if rarity == petDB.rarity and pet.id == petDB.id and pet.properties.age == PetageCounter and pet.properties.neon == isNeon then
                            if pet.unique == getgenv().petCurrentlyFarming1 then
                                continue
                            end
                            if pet.unique == getgenv().petCurrentlyFarming2 then
                                continue
                            end

                            print(string.format('PetRarityAndAge: %s', tostring(whichPet)))
                            equipWhichPet(whichPet, pet.unique)

                            return true
                        end
                    end
                end

                PetageCounter = PetageCounter - 1

                if PetageCounter <= 0 and isNeon then
                    PetageCounter = age
                    isNeon = nil
                elseif PetageCounter <= 0 and isNeon == nil then
                    return false
                end

                task.wait()
            end

            return false
        end
        function GetInventory:CheckForPetAndEquip(nameId, whichPet)
            local level = 0
            local petUnique = nil

            for _, pet in ClientData.get_data()[localPlayer.Name].inventory['pets']do
                if pet.id == nameId then
                    if not pet.properties then
                        continue
                    end
                    if not pet.properties.friendship_level then
                        continue
                    end
                    if pet.properties.friendship_level > level then
                        if pet.unique == getgenv().petCurrentlyFarming1 then
                            continue
                        end
                        if pet.unique == getgenv().petCurrentlyFarming2 then
                            continue
                        end

                        level = pet.properties.friendship_level
                        petUnique = pet.unique
                    end
                end
            end

            if petUnique then
                equipWhichPet(whichPet, petUnique)
                print(string.format('Found pet with friendship level: %s, equipped on: %s', tostring(level), tostring(whichPet)))

                return true
            end

            local PetageCounter = 6
            local isNeon = true
            local petFound = false

            while not petFound do
                for _, pet in ClientData.get_data()[localPlayer.Name].inventory.pets do
                    if pet.id == nameId and pet.properties.age == PetageCounter and pet.properties.neon == isNeon then
                        if pet.unique == getgenv().petCurrentlyFarming1 then
                            continue
                        end
                        if pet.unique == getgenv().petCurrentlyFarming2 then
                            continue
                        end

                        print(string.format('GetHighestGrownPet: %s', tostring(whichPet)))
                        equipWhichPet(whichPet, pet.unique)

                        return true
                    end
                end

                PetageCounter = PetageCounter - 1

                if PetageCounter <= 0 and isNeon then
                    PetageCounter = 6
                    isNeon = nil
                elseif PetageCounter <= 0 and isNeon == nil then
                    return false
                end

                task.wait()
            end

            return false
        end
        function GetInventory:GetUniqueId(tabId, nameId)
            for _, v in ClientData.get_data()[localPlayer.Name].inventory[tabId]do
                if v.id == nameId then
                    return v.unique
                end
            end

            return nil
        end
        function GetInventory:IsPetInInventory(tabId, uniqueId)
            for _, v in ClientData.get_data()[localPlayer.Name].inventory[tabId]do
                if v.unique == uniqueId then
                    return true
                end
            end

            return false
        end
        function GetInventory:PriorityEgg(whichPet)
            for _, v in ipairs(getgenv().SETTINGS.HATCH_EGG_PRIORITY_NAMES)do
                for _, v2 in ClientData.get_data()[localPlayer.Name].inventory.pets do
                    if table.find(blackListIds, v2.id) then
                        continue
                    end
                    if v == v2.id then
                        if v2.unique == getgenv().petCurrentlyFarming1 then
                            continue
                        end
                        if v2.unique == getgenv().petCurrentlyFarming2 then
                            continue
                        end

                        equipWhichPet(whichPet, v2.unique)

                        return true
                    end
                end
            end

            return false
        end
        function GetInventory:GetPetEggs()
            local eggs = {}

            for i, v in InventoryDB.pets do
                if v.is_egg then
                    table.insert(eggs, v.id)
                end
            end

            return eggs
        end
        function GetInventory:GetNeonPet(whichPet)
            local Petage = 5
            local isNeon = true
            local found_pet = false

            while not found_pet do
                for _, v in ClientData.get_data()[localPlayer.Name].inventory.pets do
                    if table.find(blackListIds, v.id) then
                        continue
                    end
                    if v.properties.age == Petage and v.properties.neon == isNeon then
                        if v.unique == getgenv().petCurrentlyFarming1 then
                            continue
                        end
                        if v.unique == getgenv().petCurrentlyFarming2 then
                            continue
                        end

                        print(string.format('GetNeonPet: %s', tostring(whichPet)))
                        equipWhichPet(whichPet, v.unique)

                        return true
                    end
                end

                if not found_pet then
                    Petage = Petage - 1

                    if Petage == 0 and isNeon == true then
                        return false
                    end
                end

                task.wait()
            end

            return false
        end
        function GetInventory:PriorityPet(whichPet)
            local Petage = 5
            local isNeon = true
            local found_pet = false

            while found_pet == false do
                for _, v in ipairs(getgenv().SETTINGS.PET_ONLY_PRIORITY_NAMES)do
                    for _, v2 in pairs(ClientData.get_data()[localPlayer.Name].inventory.pets)do
                        if v2.unique == getgenv().petCurrentlyFarming1 then
                            continue
                        end
                        if v2.unique == getgenv().petCurrentlyFarming2 then
                            continue
                        end
                        if table.find(blackListIds, v2.id) then
                            continue
                        end
                        if v == v2.id and v2.properties.age == Petage and v2.properties.neon == isNeon then
                            print('PriorityPet:')
                            equipWhichPet(whichPet, v2.unique)

                            return true
                        end
                    end
                end

                if found_pet == false then
                    Petage = Petage - 1

                    if Petage == 0 and isNeon == true then
                        Petage = 5
                        isNeon = nil
                    elseif Petage == 0 and isNeon == nil then
                        return false
                    end
                end

                task.wait()
            end

            return false
        end

        return GetInventory
    end
    function __DARKLUA_BUNDLE_MODULES.f()
        local ReplicatedStorage = game:GetService('ReplicatedStorage')
        local Players = game:GetService('Players')
        local localPlayer = Players.LocalPlayer
        local ClientData = require(ReplicatedStorage:WaitForChild('ClientModules'):WaitForChild('Core'):WaitForChild('ClientData'))
        local InventoryDB = require(ReplicatedStorage:WaitForChild('ClientDB'):WaitForChild('Inventory'):WaitForChild('InventoryDB'))
        local Trade = {}
        local lowTierRarity = {
            'common',
            'uncommon',
            'rare',
            'ultra_rare',
        }
        local excludePets = {
            'practice_dog',
            'starter_egg',
            'dog',
            'cat',
        }
        local inActiveTrade = function()
            local timeOut = 60

            repeat
                task.wait(1)

                timeOut = timeOut - 1
            until ClientData.get_data()[localPlayer.Name].in_active_trade or timeOut <= 0

            if timeOut <= 0 then
                return
            end
            if #ClientData.get_data()[localPlayer.Name].trade.sender_offer.items >= 18 then
                return
            end
        end

        function Trade:AcceptNegotiationAndConfirm()
            local timeOut = 30

            repeat
                task.wait(1)

                if ClientData.get_data()[localPlayer.Name].in_active_trade then
                    if ClientData.get_data()[localPlayer.Name].trade.current_stage == 'negotiation' then
                        if not ClientData.get_data()[localPlayer.Name].trade.sender_offer.negotiated then
                            ReplicatedStorage.API:FindFirstChild('TradeAPI/AcceptNegotiation'):FireServer()
                        end
                    end
                    if #ClientData.get_data()[localPlayer.Name].trade.sender_offer.items == 0 and #ClientData.get_data()[localPlayer.Name].trade.recipient_offer.items == 0 then
                        ReplicatedStorage.API:FindFirstChild('TradeAPI/DeclineTrade'):FireServer()

                        return false
                    end
                    if ClientData.get_data()[localPlayer.Name].trade.current_stage == 'confirmation' then
                        if not ClientData.get_data()[localPlayer.Name].trade.sender_offer.confirmed then
                            ReplicatedStorage.API:FindFirstChild('TradeAPI/ConfirmTrade'):FireServer()
                        end
                    end
                end

                timeOut = timeOut - 1
            until not ClientData.get_data()[localPlayer.Name].in_active_trade or timeOut <= 0

            return true
        end

        local isMulesInGame = function(playerMulesTable)
            for _, player in Players:GetPlayers()do
                if player.Name == localPlayer.Name then
                    continue
                end
                if table.find(playerMulesTable, player.Name) then
                    return true
                end
            end

            return false
        end
        local getMuleNotCurrentlyTrading = function(playerTable)
            for _, playerName in playerTable do
                if ClientData.get_data()[playerName] and not ClientData.get_data()[playerName].in_active_trade then
                    return playerName
                end
            end

            return false
        end

        function Trade:SendTradeRequest(playerTable)
            if typeof(playerTable) ~= 'table' then
                return
            end

            while isMulesInGame(playerTable) and not localPlayer.PlayerGui.TradeApp.Frame.Visible do
                local selectedPlayer = getMuleNotCurrentlyTrading(playerTable)

                if selectedPlayer then
                    ReplicatedStorage.API:FindFirstChild('TradeAPI/SendTradeRequest'):FireServer(Players[selectedPlayer])
                end

                task.wait(math.random(5, 10))
            end

            if localPlayer.PlayerGui.TradeApp.Frame.Visible then
                return true
            else
                return false
            end
        end
        function Trade:SelectTabAndTrade(tab, selectedItem)
            inActiveTrade()

            for _, item in ClientData.get_data()[localPlayer.Name].inventory[tab]do
                if item.id == selectedItem then
                    if not ClientData.get_data()[localPlayer.Name].in_active_trade then
                        return
                    end

                    ReplicatedStorage.API:FindFirstChild('TradeAPI/AddItemToOffer'):FireServer(item.unique)

                    if #ClientData.get_data()[localPlayer.Name].trade.sender_offer.items >= 18 then
                        return
                    end

                    task.wait(0.1)
                end
            end
        end
        function Trade:NeonNewbornToPostteen()
            inActiveTrade()

            for _, pet in ClientData.get_data()[localPlayer.Name].inventory.pets do
                if table.find(excludePets, pet.id) then
                    continue
                end
                if pet.properties.age <= 5 and pet.properties.neon then
                    if not ClientData.get_data()[localPlayer.Name].in_active_trade then
                        return
                    end

                    ReplicatedStorage.API['TradeAPI/AddItemToOffer']:FireServer(pet.unique)

                    if #ClientData.get_data()[localPlayer.Name].trade.sender_offer.items >= 18 then
                        return
                    end

                    task.wait(0.1)
                end
            end
        end

        local convertPetAges = function(options)
            local agesNumber = {}

            for _, v in options['ages']do
                if v == 'Newborn/Reborn' then
                    table.insert(agesNumber, 1)
                elseif v == 'Junior/Twinkle' then
                    table.insert(agesNumber, 2)
                elseif v == 'Pre_Teen/Sparkle' then
                    table.insert(agesNumber, 3)
                elseif v == 'Teen/Flare' then
                    table.insert(agesNumber, 4)
                elseif v == 'Post_Teen/Sunshine' then
                    table.insert(agesNumber, 5)
                elseif v == 'Full_Grown/Luminous' then
                    table.insert(agesNumber, 6)
                end
            end

            return agesNumber
        end
        local MultipleOptionsTradeLoop = function(
            newOptions,
            isNeon,
            isMegaNeon
        )
            local raritys = newOptions['rarity']
            local ages = newOptions['ages']
            local waitForAdded = 0

            for _, petDB in InventoryDB.pets do
                for _, pet in ClientData.get_data()[localPlayer.Name].inventory.pets do
                    if table.find(excludePets, pet.id) then
                        continue
                    end
                    if petDB.id ~= pet.id then
                        continue
                    end
                    if not table.find(raritys, petDB.rarity) then
                        continue
                    end
                    if not table.find(ages, pet.properties.age) then
                        continue
                    end
                    if pet.properties.neon == isNeon and pet.properties.mega_neon == isMegaNeon then
                        if not ClientData.get_data()[localPlayer.Name].in_active_trade then
                            return false
                        end
                        if #ClientData.get_data()[localPlayer.Name].trade.sender_offer.items >= 18 then
                            return true
                        end

                        ReplicatedStorage.API['TradeAPI/AddItemToOffer']:FireServer(pet.unique)

                        waitForAdded = waitForAdded + 1

                        repeat
                            task.wait(0.1)
                        until #ClientData.get_data()[localPlayer.Name].trade.sender_offer.items >= waitForAdded or not ClientData.get_data()[localPlayer.Name].in_active_trade
                    end
                end
            end

            if not ClientData.get_data()[localPlayer.Name].in_active_trade then
                return false
            end
            if #ClientData.get_data()[localPlayer.Name].trade.sender_offer.items >= 1 then
                return true
            else
                return false
            end
        end

        function Trade:MultipleOptions(options)
            if typeof(options) ~= 'table' then
                return
            end

            local newOptions = table.clone(options)
            local isNormal = table.find(newOptions['neons'], 'normal') and true or nil
            local isNeon = table.find(newOptions['neons'], 'neon') and true or nil
            local isMegaNeon = table.find(newOptions['neons'], 'mega_neon') and true or nil

            newOptions['ages'] = convertPetAges(newOptions)

            inActiveTrade()

            if isNormal then
                if MultipleOptionsTradeLoop(newOptions, nil, nil) then
                    return
                end
            end
            if isNeon then
                if MultipleOptionsTradeLoop(newOptions, true, nil) then
                    return
                end
            end
            if isMegaNeon then
                if MultipleOptionsTradeLoop(newOptions, nil, true) then
                    return
                end
            end

            return
        end
        function Trade:LowTiers()
            inActiveTrade()

            for _, petDB in InventoryDB.pets do
                for _, pet in ClientData.get_data()[localPlayer.Name].inventory.pets do
                    if table.find(excludePets, pet.id) then
                        continue
                    end
                    if petDB.id == pet.id and table.find(lowTierRarity, petDB.rarity) and pet.properties.age <= 5 and not pet.properties.neon and not pet.properties.mega_neon then
                        if not ClientData.get_data()[localPlayer.Name].in_active_trade then
                            return
                        end

                        ReplicatedStorage.API['TradeAPI/AddItemToOffer']:FireServer(pet.unique)

                        if #ClientData.get_data()[localPlayer.Name].trade.sender_offer.items >= 18 then
                            return
                        end

                        task.wait(0.1)
                    end
                end
            end
        end
        function Trade:NewbornToPostteen(rarity)
            inActiveTrade()

            for _, petDB in InventoryDB.pets do
                for _, pet in ClientData.get_data()[localPlayer.Name].inventory.pets do
                    if table.find(excludePets, pet.id) then
                        continue
                    end
                    if petDB.id == pet.id and petDB.rarity == rarity and pet.properties.age <= 5 and not pet.properties.neon and not pet.properties.mega_neon then
                        if not ClientData.get_data()[localPlayer.Name].in_active_trade then
                            return
                        end

                        ReplicatedStorage.API['TradeAPI/AddItemToOffer']:FireServer(pet.unique)

                        if #ClientData.get_data()[localPlayer.Name].trade.sender_offer.items >= 18 then
                            return
                        end

                        task.wait(0.1)
                    end
                end
            end
        end
        function Trade:NewbornToPostteenByPetId(petIds)
            if typeof(petIds) ~= 'table' then
                return
            end

            inActiveTrade()

            for _, pet in ClientData.get_data()[localPlayer.Name].inventory.pets do
                if table.find(excludePets, pet.id) then
                    continue
                end
                if table.find(petIds, pet.id) and pet.properties.age <= 5 and not pet.properties.mega_neon then
                    if not ClientData.get_data()[localPlayer.Name].in_active_trade then
                        return
                    end

                    ReplicatedStorage.API['TradeAPI/AddItemToOffer']:FireServer(pet.unique)

                    if #ClientData.get_data()[localPlayer.Name].trade.sender_offer.items >= 18 then
                        return
                    end

                    task.wait(0.1)
                end
            end
        end
        function Trade:FullgrownAndAnyNeonsAndMegas()
            inActiveTrade()

            for _, pet in ClientData.get_data()[localPlayer.Name].inventory.pets do
                if pet.properties.age == 6 or pet.properties.neon or pet.properties.mega_neon then
                    if not ClientData.get_data()[localPlayer.Name].in_active_trade then
                        return
                    end

                    ReplicatedStorage.API['TradeAPI/AddItemToOffer']:FireServer(pet.unique)

                    if #ClientData.get_data()[localPlayer.Name].trade.sender_offer.items >= 18 then
                        return
                    end

                    task.wait(0.1)
                end
            end
        end
        function Trade:Fullgrown()
            inActiveTrade()

            for _, pet in ClientData.get_data()[localPlayer.Name].inventory.pets do
                if pet.properties.age == 6 or (pet.properties.age == 6 and pet.properties.neon) or pet.properties.mega_neon then
                    if not ClientData.get_data()[localPlayer.Name].in_active_trade then
                        return
                    end

                    ReplicatedStorage.API['TradeAPI/AddItemToOffer']:FireServer(pet.unique)

                    if #ClientData.get_data()[localPlayer.Name].trade.sender_offer.items >= 18 then
                        return
                    end

                    task.wait(0.1)
                end
            end
        end
        function Trade:AllPetsOfSameRarity(rarity)
            inActiveTrade()

            for _, petDB in InventoryDB.pets do
                for _, pet in ClientData.get_data()[localPlayer.Name].inventory.pets do
                    if table.find(excludePets, pet.id) then
                        continue
                    end
                    if petDB.id == pet.id and petDB.rarity == rarity then
                        if not ClientData.get_data()[localPlayer.Name].in_active_trade then
                            return
                        end

                        ReplicatedStorage.API['TradeAPI/AddItemToOffer']:FireServer(pet.unique)

                        if #ClientData.get_data()[localPlayer.Name].trade.sender_offer.items >= 18 then
                            return
                        end

                        task.wait(0.1)
                    end
                end
            end
        end
        function Trade:AutoAcceptTrade()
            if ClientData.get_data()[localPlayer.Name].in_active_trade then
                if ClientData.get_data()[localPlayer.Name].trade.sender_offer.negotiated then
                    ReplicatedStorage.API:FindFirstChild('TradeAPI/AcceptNegotiation'):FireServer()
                end
                if ClientData.get_data()[localPlayer.Name].trade.sender_offer.confirmed then
                    ReplicatedStorage.API:FindFirstChild('TradeAPI/ConfirmTrade'):FireServer()
                end
            end
        end
        function Trade:AllInventory(TabPassOn)
            inActiveTrade()

            for _, item in ClientData.get_data()[localPlayer.Name].inventory[TabPassOn]do
                if table.find(excludePets, item.id) then
                    continue
                end
                if not ClientData.get_data()[localPlayer.Name].in_active_trade then
                    return
                end

                ReplicatedStorage.API['TradeAPI/AddItemToOffer']:FireServer(item.unique)

                if #ClientData.get_data()[localPlayer.Name].trade.sender_offer.items >= 18 then
                    return
                end

                task.wait(0.1)
            end
        end
        function Trade:AllPets()
            inActiveTrade()

            for _, pet in ClientData.get_data()[localPlayer.Name].inventory.pets do
                if table.find(excludePets, pet.id) then
                    continue
                end
                if not ClientData.get_data()[localPlayer.Name].in_active_trade then
                    return
                end

                ReplicatedStorage.API['TradeAPI/AddItemToOffer']:FireServer(pet.unique)

                if #ClientData.get_data()[localPlayer.Name].trade.sender_offer.items >= 18 then
                    return
                end

                task.wait(0.1)
            end
        end
        function Trade:AllNeons(version)
            inActiveTrade()

            for _, pet in ClientData.get_data()[localPlayer.Name].inventory.pets do
                if pet.properties[version] then
                    if not ClientData.get_data()[localPlayer.Name].in_active_trade then
                        return
                    end

                    ReplicatedStorage.API['TradeAPI/AddItemToOffer']:FireServer(pet.unique)

                    if #ClientData.get_data()[localPlayer.Name].trade.sender_offer.items >= 18 then
                        return
                    end

                    task.wait(0.1)
                end
            end
        end
        function Trade:CheckInventory()
            if not isMulesInGame(getgenv().SETTINGS.TRADE_COLLECTOR_NAME) then
                print('Collecters no longer ingame')

                return false
            end
            if getgenv().SETTINGS.TRADE_ONLY_LUMINOUS_MEGA then
                for _, v in ClientData.get_data()[localPlayer.Name].inventory do
                    for _, item in v do
                        if table.find(excludePets, item.id) then
                            continue
                        end
                        if table.find(getgenv().SETTINGS.TRADE_LIST, item.id) or (item.properties.neon and item.properties.age == 6) or item.properties.mega_neon then
                            return true
                        end
                    end
                end
            else
                for _, v in ClientData.get_data()[localPlayer.Name].inventory do
                    for _, item in v do
                        if table.find(excludePets, item.id) then
                            continue
                        end
                        if table.find(getgenv().SETTINGS.TRADE_LIST, item.id) or item.properties.age == 6 or item.properties.neon or item.properties.mega_neon then
                            return true
                        end
                    end
                end
            end

            return false
        end
        function Trade:TradeCollector(namePassOn)
            local isInventoryFull = false

            if typeof(namePassOn) ~= 'table' then
                return print(string.format('\u{1f6ab} %s is not a table', tostring(namePassOn)))
            end
            if typeof(getgenv().SETTINGS.TRADE_LIST) ~= 'table' then
                return print('TRADE_LIST is not a table')
            end
            if table.find(namePassOn, localPlayer.Name) then
                return print('\u{1f6ab} MULE CANNOT TRADE ITSELF OR OTHER MULES')
            end

            while getgenv().SETTINGS.ENABLE_TRADE_COLLECTOR do
                if not isMulesInGame(getgenv().SETTINGS.TRADE_COLLECTOR_NAME) then
                    return print('\u{26a0}\u{fe0f} MULE NOT INGAME \u{26a0}\u{fe0f}')
                end
                if not Trade:CheckInventory() then
                    return print('\u{1f6ab} NO ITEMS TO TRADE')
                end
                if not Trade:SendTradeRequest(namePassOn) then
                    return print('\u{26a0}\u{fe0f} PLAYER YOU WERE TRADING LEFT GAME \u{26a0}\u{fe0f}')
                end
                if getgenv().SETTINGS.TRADE_ONLY_LUMINOUS_MEGA then
                    for _, v in ClientData.get_data()[localPlayer.Name].inventory do
                        if isInventoryFull then
                            break
                        end

                        for _, item in v do
                            if table.find(getgenv().SETTINGS.TRADE_LIST, item.id) or (item.properties.neon and item.properties.age == 6) or item.properties.mega_neon then
                                if table.find(excludePets, item.id) then
                                    continue
                                end
                                if not ClientData.get_data()[localPlayer.Name].in_active_trade then
                                    return
                                end

                                ReplicatedStorage.API:FindFirstChild('TradeAPI/AddItemToOffer'):FireServer(item.unique)

                                if #ClientData.get_data()[localPlayer.Name].trade.sender_offer.items >= 18 then
                                    isInventoryFull = true

                                    break
                                end

                                task.wait(0.1)
                            end
                        end

                        if isInventoryFull then
                            break
                        end
                    end
                else
                    for _, v in ClientData.get_data()[localPlayer.Name].inventory do
                        if isInventoryFull then
                            break
                        end

                        for _, item in v do
                            if table.find(getgenv().SETTINGS.TRADE_LIST, item.id) or item.properties.age == 6 or item.properties.neon or item.properties.mega_neon then
                                if table.find(excludePets, item.id) then
                                    continue
                                end
                                if not ClientData.get_data()[localPlayer.Name].in_active_trade then
                                    return
                                end

                                ReplicatedStorage.API:FindFirstChild('TradeAPI/AddItemToOffer'):FireServer(item.unique)

                                if #ClientData.get_data()[localPlayer.Name].trade.sender_offer.items >= 18 then
                                    isInventoryFull = true

                                    break
                                end

                                task.wait(0.1)
                            end
                        end

                        if isInventoryFull then
                            break
                        end
                    end
                end

                local hasPets = Trade:AcceptNegotiationAndConfirm()

                if not hasPets then
                    print('\u{1f389} DONE TRADING ITEMS \u{1f389}')

                    return
                end

                isInventoryFull = false
            end

            return
        end

        return Trade
    end
    function __DARKLUA_BUNDLE_MODULES.g()
        local ReplicatedStorage = game:GetService('ReplicatedStorage')
        local Workspace = game:GetService('Workspace')
        local Players = game:GetService('Players')
        local ClientData = require(ReplicatedStorage:WaitForChild('ClientModules'):WaitForChild('Core'):WaitForChild('ClientData'))
        local CollisionsClient = require(ReplicatedStorage.ClientModules.Game.CollisionsClient)
        local Player = Players.LocalPlayer
        local getconstants = getconstants or debug.getconstants
        local getgc = getgc or get_gc_objects or debug.getgc
        local get_thread_identity = getthreadidentity or get_thread_identity or gti or getidentity or syn.get_thread_identity or fluxus.get_thread_identity
        local set_thread_identity = setthreadidentity or set_thread_context or sti or setthreadcontext or setidentity or syn.set_thread_identity or fluxus.set_thread_identity
        local SetLocationTP
        local rng = Random.new()
        local Teleport = {}

        for _, v in pairs(getgc())do
            if type(v) == 'function' then
                if getfenv(v).script == ReplicatedStorage.ClientModules.Core.InteriorsM.InteriorsM then
                    if table.find(getconstants(v), 'LocationAPI/SetLocation') then
                        SetLocationTP = v

                        break
                    end
                end
            end
        end

        local SetLocationFunc = function(a, b, c)
            local k = get_thread_identity()

            set_thread_identity(2)
            SetLocationTP(a, b, c)
            set_thread_identity(k)
        end

        function Teleport.PlaceFloorAtFarmingHome()
            if Workspace:FindFirstChild('FarmingHomeLocation') then
                return
            end

            local part = Instance.new('Part')
            local SurfaceGui = Instance.new('SurfaceGui')
            local TextLabel = Instance.new('TextLabel')

            part.Position = Vector3.new(1000, 0, 1000)
            part.Size = Vector3.new(200, 2, 200)
            part.Anchored = true
            part.Transparency = 1
            part.Name = 'FarmingHomeLocation'
            part.Parent = Workspace
            SurfaceGui.Parent = part
            SurfaceGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
            SurfaceGui.AlwaysOnTop = false
            SurfaceGui.CanvasSize = Vector2.new(600, 600)
            SurfaceGui.Face = Enum.NormalId.Top
            TextLabel.Parent = SurfaceGui
            TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            TextLabel.BackgroundTransparency = 1
            TextLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
            TextLabel.BorderSizePixel = 0
            TextLabel.Size = UDim2.new(1, 0, 1, 0)
            TextLabel.Font = Enum.Font.SourceSans
            TextLabel.Text = '\u{1f3e1}'
            TextLabel.TextColor3 = Color3.fromRGB(0, 0, 0)
            TextLabel.TextScaled = true
            TextLabel.TextSize = 14
            TextLabel.TextWrapped = true
        end
        function Teleport.PlaceFloorAtCampSite()
            if Workspace:FindFirstChild('CampingLocation') then
                return
            end

            local campsite = Workspace.StaticMap.Campsite.CampsiteOrigin
            local part = Instance.new('Part')

            part.Position = campsite.Position + Vector3.new(0, -1, 0)
            part.Size = Vector3.new(200, 2, 200)
            part.Anchored = true
            part.Transparency = 1
            part.Name = 'CampingLocation'
            part.Parent = Workspace
        end
        function Teleport.PlaceFloorAtBeachParty()
            if Workspace:FindFirstChild('BeachPartyLocation') then
                return
            end

            local part = Instance.new('Part')

            part.Position = Workspace.StaticMap.Beach.BeachPartyAilmentTarget.Position + Vector3.new(0, 
-10, 0)
            part.Size = Vector3.new(200, 2, 200)
            part.Anchored = true
            part.Transparency = 1
            part.Name = 'BeachPartyLocation'
            part.Parent = Workspace
        end
        function Teleport.placeFloorOnJoinZone()
            for _, v in Workspace:GetChildren()do
                if v.Name == 'FloorPart2' then
                    return
                end
            end

            local part = Instance.new('Part')

            part.Position = game.Workspace.Interiors:WaitForChild('Halloween2024Shop'):WaitForChild('TileSkip'):WaitForChild('JoinZone'):WaitForChild('EmitterPart').Position + Vector3.new(0, 
-2, 0)
            part.Size = Vector3.new(100, 2, 100)
            part.Anchored = true
            part.Name = 'FloorPart2'
            part.Parent = Workspace
        end
        function Teleport.DeleteWater()
            if Workspace:FindFirstChildWhichIsA('Terrain') then
                Workspace.Terrain:Clear()
            end
        end
        function Teleport.FarmingHome()
            Player.Character:WaitForChild('HumanoidRootPart').Anchored = true
            Player.Character.HumanoidRootPart.CFrame = Workspace.FarmingHomeLocation.CFrame * CFrame.new(rng:NextInteger(1, 40), 10, rng:NextInteger(1, 40))
            Player.Character:WaitForChild('HumanoidRootPart').Anchored = false

            Player.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Landed)
            Teleport.DeleteWater()
        end
        function Teleport.MainMap()
            local isAlreadyOnMainMap = Workspace:FindFirstChild('Interiors'):FindFirstChild('center_map_plot', true)

            if isAlreadyOnMainMap then
                return
            end

            CollisionsClient.set_collidable(false)

            Player.Character:WaitForChild('HumanoidRootPart').Anchored = true

            SetLocationFunc('MainMap', 'Neighborhood/MainDoor', {})
            Workspace.Interiors:WaitForChild(tostring(Workspace.Interiors:FindFirstChildWhichIsA('Model')))

            Player.Character.PrimaryPart.CFrame = Workspace:WaitForChild('StaticMap'):WaitForChild('Campsite'):WaitForChild('CampsiteOrigin').CFrame + Vector3.new(math.random(1, 5), 10, math.random(1, 5))
            Player.Character:WaitForChild('HumanoidRootPart').Anchored = false

            Player.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Landed)
            Teleport.DeleteWater()
            task.wait(2)
        end
        function Teleport.Nursery()
            Player.Character:WaitForChild('HumanoidRootPart').Anchored = true

            SetLocationFunc('Nursery', 'MainDoor', {})
            task.wait(1)
            Workspace.Interiors:WaitForChild(tostring(Workspace.Interiors:FindFirstChildWhichIsA('Model')))

            Player.Character.PrimaryPart.CFrame = Workspace.Interiors.Nursery:WaitForChild('GumballMachine'):WaitForChild('Root').CFrame + Vector3.new(
-8, 10, 0)
            Player.Character:WaitForChild('HumanoidRootPart').Anchored = false

            Player.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Landed)
        end
        function Teleport.CampSite()
            Teleport.DeleteWater()
            ReplicatedStorage.API['LocationAPI/SetLocation']:FireServer('MainMap', Player, ClientData.get_data()[Player.Name].LiveOpsMapType)
            task.wait(1)

            Player.Character.PrimaryPart.CFrame = Workspace.CampingLocation.CFrame + Vector3.new(rng:NextInteger(1, 30), 5, rng:NextInteger(1, 30))

            Player.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Landed)
        end
        function Teleport.BeachParty()
            Teleport.DeleteWater()
            ReplicatedStorage.API['LocationAPI/SetLocation']:FireServer('MainMap', Player, ClientData.get_data()[Player.Name].LiveOpsMapType)
            task.wait(1)

            Player.Character.PrimaryPart.CFrame = Workspace.BeachPartyLocation.CFrame + Vector3.new(math.random(1, 30), 5, math.random(1, 30))

            Player.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Landed)
        end
        function Teleport.PlayGround(vec)
            Player.Character:WaitForChild('HumanoidRootPart').Anchored = true

            SetLocationFunc('MainMap', 'Neighborhood/MainDoor', {})
            task.wait(1)
            Workspace.Interiors:WaitForChild(tostring(Workspace.Interiors:FindFirstChildWhichIsA('Model')))

            Player.Character.PrimaryPart.CFrame = Workspace:WaitForChild('StaticMap'):WaitForChild('Park'):WaitForChild('Roundabout').PrimaryPart.CFrame + vec
            Player.Character:WaitForChild('HumanoidRootPart').Anchored = false

            Player.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Landed)
            Teleport.DeleteWater()
        end
        function Teleport.DownloadMainMap()
            local interiors = Workspace:WaitForChild('Interiors', 30)

            if not interiors then
                return
            end

            local isAlreadyOnMainMap = interiors:FindFirstChild('center_map_plot', true)

            if isAlreadyOnMainMap then
                return false
            end

            Player.Character:WaitForChild('HumanoidRootPart').Anchored = true

            SetLocationFunc('MainMap', 'Neighborhood/MainDoor', {})
            task.wait(1)
            Workspace.Interiors:WaitForChild(tostring(Workspace.Interiors:FindFirstChildWhichIsA('Model')))

            Player.Character:WaitForChild('HumanoidRootPart').Anchored = false

            Player.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Landed)
            Teleport.DeleteWater()

            return true
        end
        function Teleport.MoonZone()
            Player.Character:WaitForChild('HumanoidRootPart').Anchored = true

            SetLocationFunc('MoonInterior', 'MainDoor', {})
            task.wait(1)
            Workspace.Interiors:WaitForChild(tostring(Workspace.Interiors:FindFirstChildWhichIsA('Model')))

            Player.Character:WaitForChild('HumanoidRootPart').Anchored = false

            Player.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Landed)
        end
        function Teleport.SkyCastle()
            Player.Character:WaitForChild('HumanoidRootPart').Anchored = true

            local isAlreadyOnSkyCastle = Workspace:WaitForChild('Interiors'):FindFirstChild('SkyCastle')

            if not isAlreadyOnSkyCastle then
                SetLocationFunc('SkyCastle', 'MainDoor', {})
            end

            task.wait(1)
            Workspace.Interiors:WaitForChild(tostring(Workspace.Interiors:FindFirstChildWhichIsA('Model')))

            local skyCastle = Workspace.Interiors:FindFirstChild('SkyCastle')

            if not skyCastle then
                return
            end

            skyCastle:WaitForChild('Potions')
            skyCastle.Potions:WaitForChild('GrowPotion')
            skyCastle.Potions.GrowPotion:WaitForChild('Part')

            Player.Character.PrimaryPart.CFrame = skyCastle.Potions.GrowPotion.Part.CFrame + Vector3.new(math.random(1, 5), 10, math.random(
-5, -1))
            Player.Character:WaitForChild('HumanoidRootPart').Anchored = false

            Player.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Landed)
        end
        function Teleport.Neighborhood()
            Player.Character:WaitForChild('HumanoidRootPart').Anchored = true

            SetLocationFunc('Neighborhood', 'MainDoor', {})
            task.wait(1)
            Workspace.Interiors:WaitForChild(tostring(Workspace.Interiors:FindFirstChildWhichIsA('Model')))

            if not Workspace.Interiors:FindFirstChild('Neighborhood!Fall') then
                return
            end

            Workspace.Interiors['Neighborhood!Fall']:WaitForChild('InteriorOrigin')

            Player.Character.PrimaryPart.CFrame = Workspace.Interiors['Neighborhood!Fall'].InteriorOrigin.CFrame + Vector3.new(0, 
-10, 0)
            Player.Character:WaitForChild('HumanoidRootPart').Anchored = false

            Player.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Landed)
        end

        return Teleport
    end
    function __DARKLUA_BUNDLE_MODULES.h()
        local ReplicatedStorage = game:GetService('ReplicatedStorage')
        local Players = game:GetService('Players')
        local ClientData = require(ReplicatedStorage:WaitForChild('ClientModules'):WaitForChild('Core'):WaitForChild('ClientData'))
        local InventoryDB = require(ReplicatedStorage.ClientDB.Inventory.InventoryDB)
        local localPlayer = Players.LocalPlayer
        local BuyItems = {}
        local getItemInfo = function(nameId)
            if typeof(nameId) ~= 'string' then
                print(string.format('%s is not a string', tostring(nameId)))

                return
            end

            for _, v in InventoryDB do
                for key, value in v do
                    if key == nameId then
                        return value
                    end
                end
            end

            return nil
        end
        local getAmountToBuy = function(nameId, maxAmount)
            local itemValues = getItemInfo(nameId)

            if not itemValues then
                return print('no category')
            end

            local count = 0

            for _, pet in ClientData.get_data()[localPlayer.Name].inventory[itemValues.category]do
                if nameId == pet.id then
                    count = count + 1
                end
            end

            if count < maxAmount then
                return (maxAmount - count)
            end

            return 0
        end
        local getAmountToPurchase = function(valuesTable, amount)
            local currency = ClientData.get_data()[localPlayer.Name][valuesTable.currency_id] or ClientData.get_data()[localPlayer.Name]['money']

            print('===========================')

            if not currency then
                print('NO CURRENCY ON PLAYER')

                return 0
            end

            print(string.format('currency %s', tostring(currency)))

            local count = 0

            for _ = 1, amount do
                local moneyLeft = currency - valuesTable.cost

                if moneyLeft <= 0 then
                    break
                end

                currency = moneyLeft
                count = count + 1
            end

            return count
        end
        local buyPet = function(valuesTable, howManyToBuy)
            print(string.format('CAN BUY %s', tostring(howManyToBuy)))

            local hasMoney = ReplicatedStorage.API['ShopAPI/BuyItem']:InvokeServer(valuesTable.category, valuesTable.id, {
                ['buy_count'] = howManyToBuy,
            })

            if hasMoney ~= 'success' then
                return false
            end

            return true
        end

        function BuyItems:StartBuyItems(itemToBuy)
            for _, value in ipairs(itemToBuy)do
                while true do
                    local itemValues = getItemInfo(value.NameId)
                    local amount = getAmountToBuy(value.NameId, value.MaxAmount)

                    if amount == 0 then
                        print(string.format('has max amount of: %s, skipping', tostring(value.NameId)))

                        break
                    end

                    local amountPurchase = getAmountToPurchase(itemValues, amount)

                    if amountPurchase == 0 then
                        print(string.format('amount to purchase is: %s', tostring(amountPurchase)))

                        break
                    end
                    if not buyPet(itemValues, amountPurchase) then
                        print('Has no money to buy more or something went wrong.')

                        break
                    end

                    task.wait()
                end
            end
        end

        local openBox = function(nameId)
            local itemValues = getItemInfo(nameId)

            for _, v in ClientData.get_data()[localPlayer.Name].inventory[itemValues.category]do
                if v.id == nameId then
                    ReplicatedStorage.API['LootBoxAPI/ExchangeItemForReward']:InvokeServer(v['id'], v['unique'])
                    task.wait(0.1)
                end
            end
        end

        function BuyItems:OpenItems(nameIdTable)
            if typeof(nameIdTable) ~= 'table' then
                return print(string.format('%s is not a table', tostring(nameIdTable)))
            end

            for _, v in nameIdTable do
                openBox(v)
            end

            return
        end

        return BuyItems
    end
    function __DARKLUA_BUNDLE_MODULES.i()
        local ReplicatedStorage = game:GetService('ReplicatedStorage')
        local Workspace = game:GetService('Workspace')
        local Players = game:GetService('Players')
        local Misc = __DARKLUA_BUNDLE_MODULES.load('b')
        local Bypass = require(ReplicatedStorage:WaitForChild('Fsys')).load
        local ClientData = require(ReplicatedStorage:WaitForChild('ClientModules'):WaitForChild('Core'):WaitForChild('ClientData'))
        local GetInventory = __DARKLUA_BUNDLE_MODULES.load('e')
        local Teleport = __DARKLUA_BUNDLE_MODULES.load('g')
        local localPlayer = Players.LocalPlayer
        local doctorId = nil
        local Ailments = {}

        Ailments.whichPet = 1

        local checkPetEquipped = function()
            if ClientData.get('pet_char_wrappers') and ClientData.get('pet_char_wrappers')[Ailments.whichPet] and ClientData.get('pet_char_wrappers')[Ailments.whichPet]['char'] then
                return true
            end

            return false
        end
        local consumeFood = function()
            local foodItem = Workspace.PetObjects:WaitForChild(tostring(Workspace.PetObjects:FindFirstChildWhichIsA('Model')), 10)

            if not foodItem then
                print('NO food item in workspace')

                return
            end
            if not checkPetEquipped() then
                return
            end

            ReplicatedStorage.API['PetAPI/ConsumeFoodObject']:FireServer(foodItem, ClientData.get('pet_char_wrappers')[Ailments.whichPet].pet_unique)
        end

        local function FoodAilments(FoodPassOn)
            local hasFood = false

            for _, v in ClientData.get_data()[localPlayer.Name].inventory.food do
                if v.id == FoodPassOn then
                    hasFood = true

                    if not checkPetEquipped() then
                        Misc.DebugModePrint('\u{26a0}\u{fe0f} Trying to feed pet but no pet equipped \u{26a0}\u{fe0f}')

                        return
                    end

                    local args = {
                        [1] = '__Enum_PetObjectCreatorType_2',
                        [2] = {
                            ['pet_unique'] = ClientData.get('pet_char_wrappers')[Ailments.whichPet].pet_unique,
                            ['unique_id'] = v.unique,
                        },
                    }

                    ReplicatedStorage.API['PetObjectAPI/CreatePetObject']:InvokeServer(unpack(args))
                    consumeFood()

                    return
                end
            end

            if not hasFood then
                ReplicatedStorage.API['ShopAPI/BuyItem']:InvokeServer('food', FoodPassOn, {})
                task.wait(1)
                FoodAilments(FoodPassOn)
            end
        end

        local useToolOnBaby = function(uniqueId)
            ReplicatedStorage.API['ToolAPI/ServerUseTool']:FireServer(uniqueId, 'END')
        end
        local PianoAilment = function(pianoId, petCharOrPlayerChar)
            local args = {
                localPlayer,
                pianoId,
                'Seat1',
                {
                    ['cframe'] = localPlayer.Character.HumanoidRootPart.CFrame,
                },
                petCharOrPlayerChar,
            }

            task.spawn(function()
                ReplicatedStorage.API:FindFirstChild('HousingAPI/ActivateFurniture'):InvokeServer(unpack(args))
            end)
        end
        local furnitureAilments = function(nameId, petCharOrPlayerChar)
            task.spawn(function()
                ReplicatedStorage.API['HousingAPI/ActivateFurniture']:InvokeServer(localPlayer, nameId, 'UseBlock', {
                    ['cframe'] = localPlayer.Character.HumanoidRootPart.CFrame,
                }, petCharOrPlayerChar)
            end)
        end
        local isDoctorLoaded = function()
            local stuckCount = 0
            local isStuck = false
            local doctor = Workspace.HouseInteriors.furniture:FindFirstChild('Doctor', true)

            if not doctor then
                repeat
                    task.wait(1)

                    doctor = Workspace.HouseInteriors.furniture:FindFirstChild('Doctor', true)
                    stuckCount = stuckCount + 1
                    isStuck = stuckCount > 30 and true or false
                until doctor or isStuck
            end
            if isStuck then
                Misc.DebugModePrint("\u{26a0}\u{fe0f} Wasn't able to find Doctor Id \u{26a0}\u{fe0f}")

                return false
            end

            return true
        end
        local getDoctorId = function()
            if doctorId then
                Misc.DebugModePrint(string.format('Doctor Id: %s', tostring(doctorId)))

                return
            end

            Misc.DebugModePrint('\u{1fa79} Getting Doctor ID \u{1fa79}')

            local stuckCount = 0
            local isStuck = false

            ReplicatedStorage.API['LocationAPI/SetLocation']:FireServer('Hospital')
            task.wait(1)

            local doctor = Workspace.HouseInteriors.furniture:FindFirstChild('Doctor', true)

            if not doctor then
                repeat
                    task.wait(1)

                    doctor = Workspace.HouseInteriors.furniture:FindFirstChild('Doctor', true)
                    stuckCount = stuckCount + 1
                    isStuck = stuckCount > 30 and true or false
                until doctor or isStuck
            end
            if isStuck then
                Misc.DebugModePrint("\u{26a0}\u{fe0f} Wasn't able to find Doctor Id \u{26a0}\u{fe0f}")

                return
            end
            if doctor then
                doctorId = doctor:GetAttribute('furniture_unique')

                if doctorId then
                    Misc.DebugModePrint(string.format('Found doctor Id: %s', tostring(doctorId)))
                end
            end
        end
        local useStroller = function()
            local strollerTool = localPlayer.Character:FindFirstChild('StrollerTool')

            if not strollerTool then
                return false
            end

            local args = {
                [1] = ClientData.get('pet_char_wrappers')[Ailments.whichPet].char,
                [2] = localPlayer.Character.StrollerTool.ModelHandle.TouchToSits.TouchToSit,
            }

            ReplicatedStorage.API:FindFirstChild('AdoptAPI/UseStroller'):InvokeServer(unpack(args))

            return true
        end
        local babyJump = function()
            if localPlayer.Character.Humanoid:GetState() == Enum.HumanoidStateType.Freefall then
                return
            end

            localPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
        end
        local getUpFromSitting = function()
            ReplicatedStorage.API['AdoptAPI/ExitSeatStates']:FireServer()
            task.wait(1)
            Misc.DebugModePrint('Exited from seat')
        end

        local function babyGetFoodAndEat(FoodPassOn)
            local hasFood = false

            for _, v in ClientData.get_data()[localPlayer.Name].inventory.food do
                if v.id == FoodPassOn then
                    hasFood = true

                    ReplicatedStorage.API['ToolAPI/Equip']:InvokeServer(v.unique, {})
                    task.wait(1)
                    useToolOnBaby(v.unique)

                    return
                end
            end

            if not hasFood then
                ReplicatedStorage.API['ShopAPI/BuyItem']:InvokeServer('food', FoodPassOn, {})
                task.wait(1)
                babyGetFoodAndEat(FoodPassOn)
            end
        end

        local pickMysteryTask = function(mysteryId, petUnique)
            Misc.DebugModePrint(string.format('mystery id: %s', tostring(mysteryId)))

            local ailmentsList = {}

            for i, _ in ClientData.get_data()[localPlayer.Name].ailments_manager.ailments[petUnique][mysteryId]['components']['mystery']['components']do
                table.insert(ailmentsList, i)
            end

            for i = 1, 3 do
                for _, ailment in ailmentsList do
                    Misc.DebugModePrint(string.format('card: %s, ailment: %s', tostring(i), tostring(ailment)))
                    ReplicatedStorage.API['AilmentsAPI/ChooseMysteryAilment']:FireServer(petUnique, 'mystery', i, ailment)
                    task.wait(3)

                    if not ClientData.get_data()[localPlayer.Name].ailments_manager.ailments[petUnique][mysteryId] then
                        Misc.DebugModePrint(string.format('\u{1f449} Picked %s ailment from mystery card \u{1f448}', tostring(ailment)))

                        return
                    end
                end
            end
        end
        local waitForTaskToFinish = function(ailment, petUnique)
            Misc.DebugModePrint(string.format('\u{23f3} Waiting for %s to finish \u{23f3}', tostring(string.upper(ailment))))

            local count = 0

            repeat
                task.wait(5)

                local taskActive = ClientData.get_data()[localPlayer.Name].ailments_manager.ailments[petUnique] and ClientData.get_data()[localPlayer.Name].ailments_manager.ailments[petUnique][ailment] and true or false

                count = count + 5
            until not taskActive or count >= 60

            if count >= 60 then
                Misc.DebugModePrint(string.format('\u{26a0}\u{fe0f} Waited too long for ailment: %s, must be stuck \u{26a0}\u{fe0f}', tostring(ailment)))
                Misc.ReEquipPet(1)
                Misc.ReEquipPet(2)
            else
                Misc.DebugModePrint(string.format('\u{1f389} %s task finished \u{1f389}', tostring(ailment)))
            end
        end
        local waitForJumpingToFinish = function(ailment, petUnique)
            Misc.DebugModePrint(string.format('\u{23f3} Waiting for %s to finish \u{23f3}', tostring(string.upper(ailment))))

            local stuckCount = tick()
            local isStuck = false

            repeat
                babyJump()
                task.wait(0.2)

                local taskActive = ClientData.get_data()[localPlayer.Name].ailments_manager.ailments[petUnique] and ClientData.get_data()[localPlayer.Name].ailments_manager.ailments[petUnique][ailment] and true or false

                task.wait(0.1)

                isStuck = (tick() - stuckCount) >= 120 and true or false
            until not taskActive or isStuck

            if isStuck then
                Misc.DebugModePrint(string.format('\u{26d4} %s ailment is stuck so exiting task \u{26d4}', tostring(ailment)))
            else
                Misc.DebugModePrint(string.format('\u{1f389} %s ailment finished \u{1f389}', tostring(ailment)))
            end
        end
        local babyWaitForTaskToFinish = function(ailment)
            Misc.DebugModePrint(string.format('\u{23f3} Waiting for BABY %s to finish \u{23f3}', tostring(string.upper(ailment))))

            local count = 0

            repeat
                task.wait(5)

                local taskActive = ClientData.get_data()[localPlayer.Name].ailments_manager.baby_ailments and ClientData.get_data()[localPlayer.Name].ailments_manager.baby_ailments[ailment] and true or false

                count = count + 5
            until not taskActive or count >= 60

            if count >= 60 then
                Misc.DebugModePrint(string.format('\u{26a0}\u{fe0f} Waited too long for ailment: %s, must be stuck \u{26a0}\u{fe0f}', tostring(ailment)))
            else
                Misc.DebugModePrint(string.format('\u{1f389} %s task finished \u{1f389}', tostring(string.upper(ailment))))
            end
        end

        function Ailments:HungryAilment()
            Misc.DebugModePrint(string.format('\u{1f356} Doing hungry task on %s \u{1f356}', tostring(Ailments.whichPet)))
            Misc.ReEquipPet(Ailments.whichPet)
            FoodAilments('icecream')
            Misc.DebugModePrint(string.format('\u{1f356} Finished hungry task on %s \u{1f356}', tostring(Ailments.whichPet)))
        end
        function Ailments:ThirstyAilment()
            Misc.DebugModePrint(string.format('\u{1f95b} Doing thirsty task on %s \u{1f95b}', tostring(Ailments.whichPet)))
            Misc.ReEquipPet(Ailments.whichPet)
            FoodAilments('water')
            Misc.DebugModePrint(string.format('\u{1f95b} Finished thirsty task on %s \u{1f95b}', tostring(Ailments.whichPet)))
        end
        function Ailments:SickAilment()
            Misc.ReEquipPet(Ailments.whichPet)

            if doctorId then
                Misc.DebugModePrint(string.format('\u{1fa79} Doing sick task on %s \u{1fa79}', tostring(Ailments.whichPet)))
                ReplicatedStorage.API['LocationAPI/SetLocation']:FireServer('Hospital')

                if not isDoctorLoaded() then
                    Misc.DebugModePrint(string.format('\u{1fa79}\u{26a0}\u{fe0f} Doctor didnt load on %s \u{1fa79}\u{26a0}\u{fe0f}', tostring(Ailments.whichPet)))

                    return
                end

                local args = {
                    [1] = doctorId,
                    [2] = 'UseBlock',
                    [3] = 'Yes',
                    [4] = game:GetService('Players').LocalPlayer.Character,
                }

                ReplicatedStorage.API:FindFirstChild('HousingAPI/ActivateInteriorFurniture'):InvokeServer(unpack(args))
                Misc.DebugModePrint(string.format('\u{1fa79} SICK task Finished on %s \u{1fa79}', tostring(Ailments.whichPet)))
            else
                getDoctorId()
            end
        end
        function Ailments:PetMeAilment()
            Misc.ReEquipPet(Ailments.whichPet)
            Misc.DebugModePrint(string.format('\u{1f431} Doing pet me task on %s \u{1f431}', tostring(Ailments.whichPet)))

            if not checkPetEquipped() then
                return
            end

            ReplicatedStorage.API['AdoptAPI/FocusPet']:FireServer(ClientData.get('pet_char_wrappers')[Ailments.whichPet].char)
            task.wait(1)

            if not checkPetEquipped() then
                return
            end

            ReplicatedStorage.API['PetAPI/ReplicateActivePerformances']:FireServer(ClientData.get('pet_char_wrappers')[Ailments.whichPet].char, {
                ['FocusPet'] = true,
                ['Petting'] = true,
            })
            task.wait(1)

            if not checkPetEquipped() then
                return
            end

            Bypass('RouterClient').get('AilmentsAPI/ProgressPetMeAilment'):FireServer(ClientData.get('pet_char_wrappers')[Ailments.whichPet].pet_unique)
            Misc.DebugModePrint('\u{1f431} RAN PETME AILMENT \u{1f431}')
        end
        function Ailments:SalonAilment(ailment, petUnique)
            Misc.ReEquipPet(Ailments.whichPet)
            Misc.DebugModePrint(string.format('\u{1f457} Doing salon task on %s \u{1f457}', tostring(Ailments.whichPet)))
            ReplicatedStorage.API['LocationAPI/SetLocation']:FireServer('Salon')
            waitForTaskToFinish(ailment, petUnique)
            Misc.DebugModePrint(string.format('\u{1f457} Finished salon task on %s \u{1f457}', tostring(Ailments.whichPet)))
        end
        function Ailments:MoonAilment(ailment, petUnique)
            Misc.ReEquipPet(Ailments.whichPet)
            Misc.DebugModePrint(string.format('\u{1f31a} Doing moon task on %s \u{1f31a}', tostring(Ailments.whichPet)))
            ReplicatedStorage.API['LocationAPI/SetLocation']:FireServer('MoonInterior')
            waitForTaskToFinish(ailment, petUnique)
            Misc.DebugModePrint(string.format('\u{1f31a} Doing moon task on %s \u{1f31a}', tostring(Ailments.whichPet)))
        end
        function Ailments:PizzaPartyAilment(ailment, petUnique)
            Misc.ReEquipPet(Ailments.whichPet)
            Misc.DebugModePrint(string.format('\u{1f355} Doing pizza party task on %s \u{1f355}', tostring(Ailments.whichPet)))
            ReplicatedStorage.API['LocationAPI/SetLocation']:FireServer('PizzaShop')
            waitForTaskToFinish(ailment, petUnique)
            Misc.DebugModePrint(string.format('\u{1f355} Finished pizza party task on %s \u{1f355}', tostring(Ailments.whichPet)))
        end
        function Ailments:SchoolAilment(ailment, petUnique)
            Misc.ReEquipPet(Ailments.whichPet)
            Misc.DebugModePrint(string.format('\u{1f3eb} Doing school task on %s \u{1f3eb}', tostring(Ailments.whichPet)))
            ReplicatedStorage.API['LocationAPI/SetLocation']:FireServer('School')
            waitForTaskToFinish(ailment, petUnique)
            Misc.DebugModePrint(string.format('\u{1f3eb} Finished school task on %s \u{1f3eb}', tostring(Ailments.whichPet)))
        end
        function Ailments:BoredAilment(pianoId, petUnique)
            Misc.ReEquipPet(Ailments.whichPet)
            Misc.DebugModePrint(string.format('\u{1f971} Doing bored task on %s \u{1f971}', tostring(Ailments.whichPet)))

            if pianoId then
                if not checkPetEquipped() then
                    return
                end

                PianoAilment(pianoId, ClientData.get('pet_char_wrappers')[Ailments.whichPet]['char'])
            else
                Teleport.PlayGround(Vector3.new(20, 10, math.random(15, 30)))
            end

            waitForTaskToFinish('bored', petUnique)
            Misc.DebugModePrint(string.format('\u{1f971} Finished bored task on %s \u{1f971}', tostring(Ailments.whichPet)))
        end
        function Ailments:SleepyAilment(bedId, petUnique)
            Misc.ReEquipPet(Ailments.whichPet)
            Misc.DebugModePrint(string.format('\u{1f634} Doing sleep task on %s \u{1f634}', tostring(Ailments.whichPet)))

            if not checkPetEquipped() then
                return
            end

            furnitureAilments(bedId, ClientData.get('pet_char_wrappers')[Ailments.whichPet]['char'])
            waitForTaskToFinish('sleepy', petUnique)
        end
        function Ailments:DirtyAilment(showerId, petUnique)
            Misc.ReEquipPet(Ailments.whichPet)
            Misc.DebugModePrint(string.format('\u{1f9fc} Doing dirty task on %s \u{1f9fc}', tostring(Ailments.whichPet)))

            if not checkPetEquipped() then
                return
            end

            furnitureAilments(showerId, ClientData.get('pet_char_wrappers')[Ailments.whichPet]['char'])
            waitForTaskToFinish('dirty', petUnique)
        end
        function Ailments:ToiletAilment(litterBoxId, petUnique)
            Misc.ReEquipPet(Ailments.whichPet)
            Misc.DebugModePrint(string.format('\u{1f6bd} Doing toilet task on %s \u{1f6bd}', tostring(Ailments.whichPet)))

            if litterBoxId then
                if not checkPetEquipped() then
                    return
                end

                furnitureAilments(litterBoxId, ClientData.get('pet_char_wrappers')[Ailments.whichPet]['char'])
            else
                Teleport.DownloadMainMap()
                task.wait(5)

                localPlayer.Character.HumanoidRootPart.CFrame = Workspace.HouseInteriors.furniture:FindFirstChild('AilmentsRefresh2024FireHydrant', true).PrimaryPart.CFrame + Vector3.new(5, 5, 5)

                task.wait(2)
                Misc.ReEquipPet(Ailments.whichPet)
            end

            waitForTaskToFinish('toilet', petUnique)
        end
        function Ailments:BeachPartyAilment(petUnique)
            Misc.DebugModePrint(string.format('\u{1f3d6}\u{fe0f} Doing beach party on %s \u{1f3d6}\u{fe0f}', tostring(Ailments.whichPet)))
            Teleport.BeachParty()
            task.wait(2)
            Misc.ReEquipPet(Ailments.whichPet)
            waitForTaskToFinish('beach_party', petUnique)
        end
        function Ailments:CampingAilment(petUnique)
            Misc.DebugModePrint(string.format('\u{1f3d5}\u{fe0f} Doing camping task on %s \u{1f3d5}\u{fe0f}', tostring(Ailments.whichPet)))
            Teleport.CampSite()
            task.wait(2)
            Misc.ReEquipPet(Ailments.whichPet)
            waitForTaskToFinish('camping', petUnique)
        end
        function Ailments:WalkAilment(petUnique)
            Misc.ReEquipPet(Ailments.whichPet)
            Misc.DebugModePrint(string.format('\u{1f9ae} Doing walking task on %s \u{1f9ae}', tostring(Ailments.whichPet)))

            if not checkPetEquipped() then
                return
            end

            ReplicatedStorage.API['AdoptAPI/HoldBaby']:FireServer(ClientData.get('pet_char_wrappers')[Ailments.whichPet]['char'])
            waitForJumpingToFinish('walk', petUnique)

            if not checkPetEquipped() then
                return
            end

            ReplicatedStorage.API:FindFirstChild('AdoptAPI/EjectBaby'):FireServer(ClientData.get('pet_char_wrappers')[Ailments.whichPet]['char'])
        end
        function Ailments:RideAilment(strollerId, petUnique)
            Misc.ReEquipPet(Ailments.whichPet)
            Misc.DebugModePrint(string.format('\u{1f697} Doing ride task on %s \u{1f697}', tostring(Ailments.whichPet)))
            ReplicatedStorage.API:FindFirstChild('ToolAPI/Equip'):InvokeServer(strollerId, {})
            task.wait(1)

            if not checkPetEquipped() then
                return
            end
            if not useStroller() then
                return
            end

            waitForJumpingToFinish('ride', petUnique)

            if not checkPetEquipped() then
                return
            end

            ReplicatedStorage.API:FindFirstChild('AdoptAPI/EjectBaby'):FireServer(ClientData.get('pet_char_wrappers')[Ailments.whichPet]['char'])
        end
        function Ailments:PlayAilment(ailment, petUnique)
            Misc.ReEquipPet(Ailments.whichPet)
            Misc.DebugModePrint(string.format('\u{1f9b4} Doing play task on %s \u{1f9b4}', tostring(Ailments.whichPet)))

            local toyId = GetInventory:GetUniqueId('toys', 'squeaky_bone')

            if not toyId then
                ReplicatedStorage.API:FindFirstChild('ShopAPI/BuyItem'):InvokeServer('toys', 'raw_bone', {})
                task.wait(3)

                toyId = GetInventory:GetUniqueId('toys', 'raw_bone')

                if not toyId then
                    Misc.DebugModePrint("\u{26a0}\u{fe0f} Doesn't have raw bone so exiting \u{26a0}\u{fe0f}")

                    return false
                end
            end

            local args = {
                [1] = '__Enum_PetObjectCreatorType_1',
                [2] = {
                    ['reaction_name'] = 'ThrowToyReaction',
                    ['unique_id'] = toyId,
                },
            }
            local count = 0

            repeat
                Misc.DebugModePrint('\u{1f9b4} Throwing toy \u{1f9b4}')
                ReplicatedStorage.API:FindFirstChild('PetObjectAPI/CreatePetObject'):InvokeServer(unpack(args))
                task.wait(10)

                local taskActive = ClientData.get_data()[localPlayer.Name].ailments_manager.ailments[petUnique] and ClientData.get_data()[localPlayer.Name].ailments_manager.ailments[petUnique][ailment] and true or false

                count = count + 1
            until not taskActive or count >= 6

            if count >= 6 then
                Misc.DebugModePrint('Play task got stuck so requiping pet')
                Misc.ReEquipPet(Ailments.whichPet)

                return false
            end

            Misc.DebugModePrint(string.format('\u{1f9b4} Finished play task on %s \u{1f9b4}', tostring(Ailments.whichPet)))

            return true
        end
        function Ailments:MysteryAilment(mysteryId, petUnique)
            Misc.DebugModePrint('\u{2753} Picking mystery task \u{2753}')
            pickMysteryTask(mysteryId, petUnique)
        end
        function Ailments:BabyHungryAilment()
            Misc.DebugModePrint('\u{1f476}\u{1f374} Doing baby hungry task \u{1f476}\u{1f374}')

            local stuckCount = 0

            repeat
                babyGetFoodAndEat('icecream')

                stuckCount = stuckCount + 1

                task.wait(1)
            until not ClientData.get_data()[localPlayer.Name].ailments_manager.baby_ailments['hungry'] or stuckCount >= 30

            if stuckCount >= 30 then
                Misc.DebugModePrint('\u{26a0}\u{fe0f} Waited too long for Baby Hungry. Must be stuck \u{26a0}\u{fe0f}')
            else
                Misc.DebugModePrint('\u{1f476}\u{1f374} Baby hungry task Finished \u{1f476}\u{1f374}')
            end
        end
        function Ailments:BabyThirstyAilment()
            Misc.DebugModePrint('\u{1f476}\u{1f95b} Doing baby water task \u{1f476}\u{1f95b}')

            local stuckCount = 0

            repeat
                babyGetFoodAndEat('lemonade')

                stuckCount = stuckCount + 1

                task.wait(1)
            until not ClientData.get_data()[localPlayer.Name].ailments_manager.baby_ailments['thirsty'] or stuckCount >= 30

            if stuckCount >= 30 then
                Misc.DebugModePrint('\u{26a0}\u{fe0f} Waited too long for Baby Thirsty. Must be stuck \u{26a0}\u{fe0f}')
            else
                Misc.DebugModePrint('\u{1f476}\u{1f95b} Baby water task Finished \u{1f476}\u{1f95b}')
            end
        end
        function Ailments:BabyBoredAilment(pianoId)
            Misc.DebugModePrint('\u{1f476}\u{1f971} Doing bored task \u{1f476}\u{1f971}')
            getUpFromSitting()

            if pianoId then
                PianoAilment(pianoId, localPlayer.Character)
            else
                Teleport.PlayGround(Vector3.new(20, 10, math.random(15, 30)))
            end

            babyWaitForTaskToFinish('bored')
            getUpFromSitting()
        end
        function Ailments:BabySleepyAilment(bedId)
            Misc.DebugModePrint('\u{1f476}\u{1f634} Doing sleepy task \u{1f476}\u{1f634}')
            getUpFromSitting()
            furnitureAilments(bedId, localPlayer.Character)
            babyWaitForTaskToFinish('sleepy')
            getUpFromSitting()
        end
        function Ailments:BabyDirtyAilment(showerId)
            Misc.DebugModePrint('\u{1f476}\u{1f9fc} Doing dirty task \u{1f476}\u{1f9fc}')
            getUpFromSitting()
            furnitureAilments(showerId, localPlayer.Character)
            babyWaitForTaskToFinish('dirty')
            getUpFromSitting()
        end

        return Ailments
    end
    function __DARKLUA_BUNDLE_MODULES.j()
        local ReplicatedStorage = game:GetService('ReplicatedStorage')
        local Players = game:GetService('Players')
        local ClientData = require(ReplicatedStorage:WaitForChild('ClientModules'):WaitForChild('Core'):WaitForChild('ClientData'))
        local localPlayer = Players.LocalPlayer
        local StatsGuis2 = {}

        StatsGuis2.__index = StatsGuis2

        local formatTime = function(currentTime)
            local hours = math.floor(currentTime / 3600)
            local minutes = math.floor((currentTime % 3600) / 60)
            local seconds = currentTime % 60

            if hours >= 10 then
                game:Shutdown()
            end

            return string.format('%02d:%02d:%02d', hours, minutes, seconds)
        end
        local formatNumber = function(num)
            if num >= 1e6 then
                return string.format('%.2fM', num / 1e6)
            elseif num >= 1e3 then
                return string.format('%.1fK', num / 1e3)
            else
                return string.format('%.0f', num)
            end
        end
        local bucksAmount = function()
            return ClientData.get_data()[localPlayer.Name].money or 0
        end
        local eventCurrencyAmount = function()
            return ClientData.get_data()[localPlayer.Name].cherry_blossoms_2025 or 0
        end
        local foodItemCount = function(nameId)
            local count = 0

            for _, v in ClientData.get_data()[localPlayer.Name].inventory.food do
                if v.id == nameId then
                    count = count + 1
                end
            end

            return count
        end

        function StatsGuis2.new(name)
            local self = setmetatable({}, StatsGuis2)

            self.label = Instance.new('TextLabel')
            self.UICorner = Instance.new('UICorner')
            self.label.Name = name
            self.label.BackgroundColor3 = Color3.fromRGB(250, 129, 47)
            self.label.BackgroundTransparency = 0.25
            self.label.BorderColor3 = Color3.fromRGB(0, 0, 0)
            self.label.BorderSizePixel = 0
            self.label.Size = UDim2.new(0.330000013, 0, 0.486617982, 0)
            self.label.Font = Enum.Font.FredokaOne
            self.label.RichText = false
            self.label.Text = ''
            self.label.TextColor3 = Color3.fromRGB(255, 255, 255)
            self.label.TextScaled = true
            self.label.TextSize = 14
            self.label.TextStrokeTransparency = 0
            self.label.TextWrapped = true
            self.label.Parent = Players.LocalPlayer.PlayerGui.StatsGui.MainFrame.MiddleFrame
            self.UICorner.CornerRadius = UDim.new(0, 16)
            self.UICorner.Parent = self.label
            self.Debounce = false

            return self
        end
        function StatsGuis2.Setup()
            local StatsGui = Instance.new('ScreenGui')
            local MainFrame = Instance.new('Frame')
            local TimeLabel = Instance.new('TextLabel')
            local UICorner = Instance.new('UICorner')
            local MiddleFrame = Instance.new('Frame')
            local UIGridLayout = Instance.new('UIGridLayout')
            local TextButton = Instance.new('TextButton')

            StatsGui.Name = 'StatsGui'
            StatsGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
            StatsGui.Parent = Players.LocalPlayer:WaitForChild('PlayerGui')
            MainFrame.Name = 'MainFrame'
            MainFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            MainFrame.BackgroundTransparency = 1
            MainFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
            MainFrame.BorderSizePixel = 0
            MainFrame.Position = UDim2.new(0.276041657, 0, 0.0577475652, 0)
            MainFrame.Size = UDim2.new(0.674468458, 0, 0.795313776, 0)
            MainFrame.Parent = StatsGui
            TimeLabel.Name = 'TimeLabel'
            TimeLabel.BackgroundColor3 = Color3.fromRGB(250, 129, 47)
            TimeLabel.BackgroundTransparency = 0.25
            TimeLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
            TimeLabel.BorderSizePixel = 0
            TimeLabel.Size = UDim2.new(1, 0, 0.200000018, 0)
            TimeLabel.Font = Enum.Font.FredokaOne
            TimeLabel.RichText = false
            TimeLabel.Text = '\u{23f1}\u{fe0f} time'
            TimeLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
            TimeLabel.TextScaled = true
            TimeLabel.TextSize = 14
            TimeLabel.TextStrokeTransparency = 0
            TimeLabel.TextWrapped = true
            TimeLabel.Parent = MainFrame
            UICorner.CornerRadius = UDim.new(0, 16)
            UICorner.Parent = TimeLabel
            MiddleFrame.Name = 'MiddleFrame'
            MiddleFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            MiddleFrame.BackgroundTransparency = 1
            MiddleFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
            MiddleFrame.BorderSizePixel = 0
            MiddleFrame.Position = UDim2.new(0, 0, 0.219711155, 0)
            MiddleFrame.Size = UDim2.new(0.999243617, 0, 0.55549103, 0)
            MiddleFrame.Parent = MainFrame
            UIGridLayout.SortOrder = Enum.SortOrder.LayoutOrder
            UIGridLayout.CellPadding = UDim2.new(0.00999999978, 0, 0.00999999978, 0)
            UIGridLayout.CellSize = UDim2.new(0.242, 0, 0.5, 0)
            UIGridLayout.FillDirectionMaxCells = 0
            UIGridLayout.Parent = MiddleFrame
            TextButton.AnchorPoint = Vector2.new(0.5, 0.5)
            TextButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            TextButton.BackgroundTransparency = 1
            TextButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
            TextButton.BorderSizePixel = 0
            TextButton.Position = UDim2.new(0.33, 0, 0.018, 0)
            TextButton.Size = UDim2.new(0.1, 0, 0.1, 0)
            TextButton.Font = Enum.Font.FredokaOne
            TextButton.Text = '\u{1f648}'
            TextButton.TextColor3 = Color3.fromRGB(0, 0, 0)
            TextButton.TextScaled = true
            TextButton.TextSize = 14
            TextButton.TextWrapped = true
            TextButton.TextXAlignment = Enum.TextXAlignment.Left
            TextButton.Parent = StatsGui

            local TIME_SAVED = nil

            TimeLabel.MouseEnter:Connect(function()
                TIME_SAVED = TimeLabel.Text
                TimeLabel.Text = string.format('\u{1f916} %s', tostring(localPlayer.Name))
            end)
            TimeLabel.MouseLeave:Connect(function()
                TimeLabel.Text = TIME_SAVED
            end)

            local isVisible = true

            TextButton.Activated:Connect(function()
                isVisible = not isVisible
                MainFrame.Visible = isVisible
            end)
        end
        function StatsGuis2:CopyInventoryButton(CopyInventorySettings)
            local CopyInventoryButton = Instance.new('TextButton')

            CopyInventoryButton.AnchorPoint = Vector2.new(0.5, 0.5)
            CopyInventoryButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            CopyInventoryButton.BackgroundTransparency = 1
            CopyInventoryButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
            CopyInventoryButton.BorderSizePixel = 0
            CopyInventoryButton.Position = UDim2.new(0.68, 0, 0.88, 0)
            CopyInventoryButton.Size = UDim2.new(0.2, 0, 0.2, 0)
            CopyInventoryButton.Font = Enum.Font.FredokaOne
            CopyInventoryButton.Text = '\u{1f4cb}'
            CopyInventoryButton.TextColor3 = Color3.fromRGB(0, 0, 0)
            CopyInventoryButton.TextScaled = true
            CopyInventoryButton.TextSize = 14
            CopyInventoryButton.TextWrapped = true
            CopyInventoryButton.TextXAlignment = Enum.TextXAlignment.Left
            CopyInventoryButton.Parent = Players.LocalPlayer:WaitForChild('PlayerGui'):WaitForChild('StatsGui')

            CopyInventoryButton.Activated:Connect(function()
                if self.Debounce then
                    print('\u{1f6ab} button is on cooldown \u{1f6ab}')

                    return
                end

                self.Debounce = true

                CopyInventorySettings.callback()

                CopyInventoryButton.Text = '\u{2705}'

                task.wait(1)

                CopyInventoryButton.Text = '\u{1f4cb}'
                self.Debounce = false
            end)
        end
        function StatsGuis2:UpdateTextFor(labelName, amount)
            if labelName == 'TimeLabel' then
                local currentTime = DateTime.now().UnixTimestamp
                local timeElapsed = currentTime - amount

                Players.LocalPlayer.PlayerGui.StatsGui.MainFrame.TimeLabel.Text = string.format('\u{23f1}\u{fe0f} %s', tostring(formatTime(timeElapsed)))
            elseif labelName == 'TempPotions' then
                self.label.Text = string.format('\u{1f9ea} %s', tostring(formatNumber(amount)))
            elseif labelName == 'TempTinyPotions' then
                self.label.Text = string.format('\u{2697}\u{fe0f} %s', tostring(formatNumber(amount)))
            elseif labelName == 'TempBucks' then
                self.label.Text = string.format('\u{1f4b0} %s', tostring(formatNumber(amount)))
            elseif labelName == 'TempEventCurrency' then
                self.label.Text = string.format('\u{1f338} %s', tostring(formatNumber(amount)))
            elseif labelName == 'TotalPotions' then
                local formatted = formatNumber(foodItemCount('pet_age_potion'))

                self.label.Text = string.format('\u{1f9ea} %s', tostring(formatted))
            elseif labelName == 'TotalTinyPotions' then
                local formatted = formatNumber(foodItemCount('tiny_pet_age_potion'))

                self.label.Text = string.format('\u{2697}\u{fe0f} %s', tostring(formatted))
            elseif labelName == 'TotalBucks' then
                local formatted = formatNumber(bucksAmount())

                self.label.Text = string.format('\u{1f4b0} %s', tostring(formatted))
            elseif labelName == 'TotalEventCurrency' then
                local formatted = formatNumber(eventCurrencyAmount())

                self.label.Text = string.format('\u{1f338} %s', tostring(formatted))
            elseif labelName == 'TotalShiverBaits' then
                local formatted = formatNumber(foodItemCount('ice_dimension_2025_shiver_cone_bait'))

                self.label.Text = string.format('\u{1f43a} %s', tostring(formatted))
            elseif labelName == 'TotalSubzeroBaits' then
                local formatted = formatNumber(foodItemCount('ice_dimension_2025_subzero_popsicle_bait'))

                self.label.Text = string.format('\u{1f982} %s', tostring(formatted))
            end
        end

        return StatsGuis2
    end
    function __DARKLUA_BUNDLE_MODULES.k()
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
                    print(string.format('table %s cleared', tostring(v)))
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
                    count = count + 1
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

            self.AllInventory = self.AllInventory .. string.format('%s Age-up Potions + %s Bucks | Adopt me\n', tostring(potions), tostring(addComma(bucks)))

            local formatNumber = string.format('%.2f', (potionAmount))

            self.AllInventory = self.AllInventory .. string.format('sell for $%s  %s\n\n', tostring(tostring(formatNumber)), tostring(localPlayer.Name))
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
    end
    function __DARKLUA_BUNDLE_MODULES.l()
        local ReplicatedStorage = game:GetService('ReplicatedStorage')
        local TradeLicense = {}

        function TradeLicense.Get(clientData, playerName)
            for _, v in clientData.get_data()[playerName].inventory.toys do
                if v.id == 'trade_license' then
                    return
                end
            end

            local success, errorMessage = pcall(function()
                ReplicatedStorage.API:FindFirstChild('SettingsAPI/SetBooleanFlag'):FireServer('has_talked_to_trade_quest_npc', true)
                task.wait(1)
                ReplicatedStorage.API:FindFirstChild('TradeAPI/BeginQuiz'):FireServer()
                task.wait(1)

                for _, v in pairs(clientData.get('trade_license_quiz_manager')['quiz'])do
                    ReplicatedStorage.API:FindFirstChild('TradeAPI/AnswerQuizQuestion'):FireServer(v['answer'])
                end
            end)

            if not success then
                print(errorMessage)
            end
        end

        return TradeLicense
    end
    function __DARKLUA_BUNDLE_MODULES.m()
        local ReplicatedStorage = game:GetService('ReplicatedStorage')

        game:GetService('Workspace')

        local Players = game:GetService('Players')
        local localPlayer = Players.LocalPlayer
        local Fusion = __DARKLUA_BUNDLE_MODULES.load('c')
        local PetPotionEffectsDB = require(ReplicatedStorage:WaitForChild('ClientDB'):WaitForChild('PetPotionEffectsDB'))
        local ClientData = require(ReplicatedStorage:WaitForChild('ClientModules'):WaitForChild('Core'):WaitForChild('ClientData'))
        local BulkPotions = {}

        BulkPotions.__index = BulkPotions

        function BulkPotions.new()
            local self = setmetatable({}, BulkPotions)

            self.SameUnqiue = {}
            self.SameUnqiueCount = 0
            self.StopAging = false
            self.EggsTable = {}
            self.PetAge = 0
            self.PetUniqueId = nil

            return self
        end

        local waitForPetToEquip = function()
            local startTime = DateTime.now().UnixTimestamp
            local isStuck = false

            repeat
                task.wait()

                local isEquipped = ClientData.get('pet_char_wrappers')[1]
                local currentTime = DateTime.now().UnixTimestamp

                if currentTime - startTime >= 10 then
                    isStuck = true
                end
            until isEquipped or isStuck

            if isStuck then
                print('Unable to equip pet')

                return false
            end

            print('Pet is Equipped')

            return true
        end

        function BulkPotions:IsPetNormal(petName)
            self.PetAge = 0
            self.PetUniqueId = nil

            for _, v in ClientData.get_data()[localPlayer.Name].inventory.pets do
                if v.id == petName and v.id ~= 'practice_dog' and v.properties.age ~= 6 and not v.properties.mega_neon then
                    if self.PetAge < v.properties.age then
                        self.PetAge = v.properties.age
                        self.PetUniqueId = v.unique
                    end
                end
            end

            if self.PetUniqueId then
                ReplicatedStorage.API['ToolAPI/Unequip']:InvokeServer(self.PetUniqueId, {
                    ['use_sound_delay'] = true,
                })
                task.wait(1)
                ReplicatedStorage.API['ToolAPI/Equip']:InvokeServer(self.PetUniqueId, {
                    ['use_sound_delay'] = true,
                })
                waitForPetToEquip()
                print(string.format('pet age: %s, and NORMAL', tostring(self.PetAge)))

                return true
            end

            return false
        end
        function BulkPotions:IsPetNeon(petName)
            self.PetAge = 0
            self.PetUniqueId = nil

            for _, v in ClientData.get_data()[localPlayer.Name].inventory.pets do
                if v.id == petName and v.id ~= 'practice_dog' and v.properties.age ~= 6 and v.properties.neon and not v.properties.mega_neon then
                    if self.PetAge < v.properties.age then
                        self.PetAge = v.properties.age
                        self.PetUniqueId = v.unique
                    end
                end
            end

            if self.PetUniqueId then
                ReplicatedStorage.API['ToolAPI/Unequip']:InvokeServer(self.PetUniqueId, {
                    ['use_sound_delay'] = true,
                })
                task.wait(1)
                ReplicatedStorage.API['ToolAPI/Equip']:InvokeServer(self.PetUniqueId, {
                    ['use_sound_delay'] = true,
                })
                waitForPetToEquip()
                print(string.format('pet age: %s and NEON', tostring(self.PetAge)))

                return true
            end
            if self:IsPetNormal(petName) then
                return true
            else
                return false
            end
        end

        local agePotionCount = function(nameId)
            local count = 0

            for _, v in ClientData.get_data()[localPlayer.Name].inventory.food do
                if v.id == nameId then
                    count = count + 1
                end
            end

            return count
        end
        local getPotionUniques = function(nameId)
            local potions = {}
            local amountNeeded = PetPotionEffectsDB[nameId].multi_use_count(ClientData.get('pet_char_wrappers')[1], ClientData.get_data()[localPlayer.Name].inventory.pets[ClientData.get('pet_char_wrappers')[1].pet_unique])

            if amountNeeded <= 0 then
                return potions
            end

            for _, v in ClientData.get_data()[localPlayer.Name].inventory.food do
                if v.id == nameId then
                    table.insert(potions, v.unique)

                    amountNeeded = amountNeeded - 1

                    if amountNeeded <= 0 then
                        break
                    end
                end
            end

            return potions
        end

        function BulkPotions:IsSameUnique()
            for _, v in ClientData.get_data()[localPlayer.Name].inventory.food do
                if v.id == 'pet_age_potion' or v.id == 'tiny_pet_age_potion' then
                    if table.find(self.SameUnqiue, v.unique) then
                        print('has same unqiue age up potion')

                        self.SameUnqiueCount = self.SameUnqiueCount + 1

                        if self.SameUnqiueCount >= 15 then
                            print('\u{26a0}\u{fe0f} SAME POTION HAS BEEN TRIED 15 TIMES. MUST BE STUCK \u{26a0}\u{fe0f}')

                            self.SameUnqiueCount = 0
                            self.SameUnqiue = {}
                        end

                        task.wait(1)

                        return true
                    end
                end
            end

            self.SameUnqiueCount = 0
            self.SameUnqiue = {}

            return false
        end
        function BulkPotions:SetEggTable(newEggTable)
            self.EggsTable = newEggTable
        end
        function BulkPotions:IsEgg()
            local EquipTimeout = 0
            local hasPetChar = false

            repeat
                task.wait(1)

                hasPetChar = ClientData.get('pet_char_wrappers')[1] and ClientData.get('pet_char_wrappers')[1]['char'] and true or false
                EquipTimeout = EquipTimeout + 1
            until hasPetChar or EquipTimeout >= 30

            if EquipTimeout >= 30 then
                print('\u{26a0}\u{fe0f} Waited too long for Equipping pet so Stopping aging \u{26a0}\u{fe0f}')

                self.StopAging = true

                return true
            end

            local isEgg = table.find(self.EggsTable, ClientData.get('pet_char_wrappers')[1]['pet_id']) and true or false

            return isEgg
        end

        local createPotionObject = function(potionTable)
            local args = {}

            if #potionTable == 1 then
                args = {
                    [1] = '__Enum_PetObjectCreatorType_2',
                    [2] = {
                        ['pet_unique'] = ClientData.get('pet_char_wrappers')[1].pet_unique,
                        ['unique_id'] = potionTable[1],
                        ['additional_consume_uniques'] = {},
                    },
                }
            elseif #potionTable >= 2 then
                local newpotionTable = table.clone(potionTable)

                table.remove(newpotionTable, 1)

                args = {
                    [1] = '__Enum_PetObjectCreatorType_2',
                    [2] = {
                        ['pet_unique'] = ClientData.get('pet_char_wrappers')[1].pet_unique,
                        ['unique_id'] = potionTable[1],
                        ['additional_consume_uniques'] = newpotionTable,
                    },
                }
            end

            return ReplicatedStorage.API['PetObjectAPI/CreatePetObject']:InvokeServer(unpack(args))
        end

        function BulkPotions:FeedAgePotion()
            if self:IsEgg() then
                return print('Pet Equipped is a EGG! or No pet Equipped')
            end
            if self:IsSameUnique() then
                return
            end

            self.SameUnqiueCount = 0

            local TotalPotions = localPlayer.PlayerGui.StatsGui.MainFrame.MiddleFrame.TotalPotions
            local potionUniques = getPotionUniques('pet_age_potion')

            if #potionUniques <= 0 then
                return
            end

            self.SameUnqiue = potionUniques

            print(string.format('USING POTIONS: %s', tostring(#potionUniques)))
            print(createPotionObject(potionUniques))
            task.wait(2)

            TotalPotions.Text = string.format('\u{1f9ea} %s', tostring(agePotionCount('pet_age_potion')))

            return
        end

        local hasAgeUpPotion = function()
            for _, v in ClientData.get_data()[localPlayer.Name].inventory.food do
                if v.id == 'pet_age_potion' or v.id == 'tiny_pet_age_potion' then
                    return true
                end
            end

            return false
        end

        function BulkPotions:AgeAllPetsOfSameName(petId)
            if getgenv().SETTINGS.PET_AUTO_FUSION then
                Fusion:MakeMega(false)
                Fusion:MakeMega(true)
            end

            local hasPet = self:IsPetNeon(petId)

            if not hasPet then
                return print(string.format('no %s so moving to next pet or stopping', tostring(petId)))
            end

            while true do
                local isEgg = self:IsEgg()

                if isEgg then
                    return print('Pet Equipped is an EGG, Stopping')
                end

                local age = ClientData.get('pet_char_wrappers')[1]['pet_progression']['age']

                if age >= 6 then
                    print("pet's age is 6")

                    break
                end

                local hasAgeUpPotion = hasAgeUpPotion()

                if not hasAgeUpPotion then
                    self.StopAging = true

                    print('no more age up potions')

                    return
                end

                self:FeedAgePotion()
                task.wait()
            end

            if self.StopAging then
                return
            end

            self:AgeAllPetsOfSameName(petId)

            return
        end
        function BulkPotions:StartAgingPets(petsTable)
            if typeof(petsTable) ~= 'table' then
                print('is not a table')

                return
            end

            for _, petId in ipairs(petsTable)do
                if self.StopAging then
                    print('stop aging is true, so stopped')

                    return
                end

                self:AgeAllPetsOfSameName(petId)
            end
        end

        return BulkPotions
    end
    function __DARKLUA_BUNDLE_MODULES.n()
        local ReplicatedStorage = game:GetService('ReplicatedStorage')
        local LegacyTutorial = require(ReplicatedStorage.ClientModules:WaitForChild('Game'):WaitForChild('Tutorial'):WaitForChild('LegacyTutorial'))
        local ClientData = require(ReplicatedStorage:WaitForChild('ClientModules'):WaitForChild('Core'):WaitForChild('ClientData'))
        local localPlayer = game:GetService('Players').LocalPlayer
        local Tutorials = {}

        function Tutorials.CompleteStarterTutorial()
            local success, errorMessage = pcall(function()
                task.wait(10)
                print('START DOING TUTORIAL')
                LegacyTutorial.cancel_tutorial()
                task.wait(5)
                ReplicatedStorage.API['LegacyTutorialAPI/MarkTutorialCompleted']:FireServer()
                print('MarkTutorialCompleted')
                task.wait(5)
                ReplicatedStorage.API['LegacyTutorialAPI/EquipTutorialEgg']:FireServer()
                print('EquipTutorialEgg')
                task.wait(5)
                ReplicatedStorage.API['LegacyTutorialAPI/AddTutorialQuest']:FireServer()
                print('AddTutorialQuest')
                task.wait(5)
                ReplicatedStorage.API['LegacyTutorialAPI/AddHungryAilmentToTutorialEgg']:FireServer()
                print('AddHungryAilmentToTutorialEgg')
                task.wait(5)

                local feedStartEgg = function(SandwichPassOn)
                    local Foodid2

                    for _, v in pairs(ClientData.get_data()[localPlayer.Name].inventory.food)do
                        if v.id == SandwichPassOn then
                            Foodid2 = v.unique

                            break
                        end
                    end

                    ReplicatedStorage.API['ToolAPI/Equip']:InvokeServer(Foodid2, {
                        ['use_sound_delay'] = true,
                    })
                    task.wait(1)

                    local args = {
                        [1] = '__Enum_PetObjectCreatorType_2',
                        [2] = {
                            ['pet_unique'] = ClientData.get('pet_char_wrappers')[1].pet_unique,
                            ['unique_id'] = Foodid2,
                        },
                    }

                    ReplicatedStorage.API['PetObjectAPI/CreatePetObject']:InvokeServer(unpack(args))
                end

                feedStartEgg('sandwich-default')
            end)

            print('tutorial', success, errorMessage)
        end
        function Tutorials.CompleteNewStarterTutorial()
            local success, errorMessage = pcall(function()
                task.wait(10)
                ReplicatedStorage.API['TutorialAPI/ReportDiscreteStep']:FireServer('npc_interaction')
                task.wait(2)
                ReplicatedStorage.API['TutorialAPI/ChoosePet']:FireServer('dog')
                task.wait(2)
                ReplicatedStorage.API['TutorialAPI/ReportDiscreteStep']:FireServer('cured_dirty_ailment')
                task.wait(2)
                ReplicatedStorage.API['TutorialAPI/ReportTutorialCompleted']:FireServer()
                task.wait(2)
                LegacyTutorial.cancel_tutorial()
                task.wait(2)
                ReplicatedStorage.API['LegacyTutorialAPI/MarkTutorialCompleted']:FireServer()
                task.wait(2)
                localPlayer:Kick('Finished tutorial?')
            end)

            print('tutorial', success, errorMessage)
        end

        return Tutorials
    end
    function __DARKLUA_BUNDLE_MODULES.o()
        local Workspace = game:GetService('Workspace')
        local Terrain = Workspace:WaitForChild('Terrain')
        local Lighting = game:GetService('Lighting')

        PotatoMode = {}

        local lowSpecTerrain = function()
            Terrain.WaterReflectance = 0
            Terrain.WaterTransparency = 1
            Terrain.WaterWaveSize = 0
            Terrain.WaterWaveSpeed = 0
        end
        local lowSpecLighting = function()
            Lighting.Brightness = 0
            Lighting.GlobalShadows = false
            Lighting.FogEnd = math.huge
            Lighting.FogStart = 0
        end
        local lowSpecTextures = function(v)
            if v:IsA('Part') then
                v.Material = Enum.Material.Plastic
                v.EnableFluidForces = false
                v.CastShadow = false
                v.Reflectance = 0
            elseif v:IsA('BasePart') and not v:IsA('MeshPart') then
                v.Material = Enum.Material.Plastic
                v.Reflectance = 0
            elseif v:IsA('Decal') or v:IsA('Texture') then
                v.Transparency = 1
            elseif v:IsA('ParticleEmitter') or v:IsA('Trail') then
                v.Lifetime = NumberRange.new(0)
            elseif v:IsA('Explosion') then
                v.BlastPressure = 1
                v.BlastRadius = 1
            elseif v:IsA('Fire') or v:IsA('SpotLight') or v:IsA('Smoke') or v:IsA('Sparkles') then
                v.Enabled = false
            elseif v:IsA('MeshPart') then
                v.Material = Enum.Material.Plastic
                v.EnableFluidForces = false
                v.CastShadow = false
                v.Reflectance = 0
                v.TextureID = '10385902758728957'
            elseif v:IsA('SpecialMesh') then
                v.TextureId = 0
            elseif v:IsA('ShirtGraphic') then
                v.Graphic = 1
            elseif v:IsA('Shirt') or v:IsA('Pants') then
                v[v.ClassName .. 'Template'] = 1
            end
        end

        function PotatoMode.Start()
            lowSpecTerrain()
            lowSpecLighting()
            sethiddenproperty(Lighting, 'Technology', 2)
            sethiddenproperty(Terrain, 'Decoration', false)
            sethiddenproperty(Workspace, 'StreamingMinRadius', 32)
            sethiddenproperty(Workspace, 'StreamingTargetRadius', 32)
            Lighting:ClearAllChildren()

            for _, v in pairs(Workspace:GetDescendants())do
                lowSpecTextures(v)
            end

            Workspace.DescendantAdded:Connect(function(v)
                lowSpecTextures(v)
            end)
        end

        return PotatoMode
    end
    function __DARKLUA_BUNDLE_MODULES.p()
        local Workspace = game:GetService('Workspace')
        local ReplicatedStorage = game:GetService('ReplicatedStorage')
        local Players = game:GetService('Players')
        local localPlayer = Players.LocalPlayer
        local ClientData = require(ReplicatedStorage:WaitForChild('ClientModules'):WaitForChild('Core'):WaitForChild('ClientData'))
        local Spring2025 = {}
        local createAFKPlateform = function()
            if Workspace:FindFirstChild('BlossomAFKLocation') then
                return
            end

            local part = Instance.new('Part')
            local SurfaceGui = Instance.new('SurfaceGui')
            local TextLabel = Instance.new('TextLabel')

            part.Position = Workspace.StaticMap.Springfest2025.CherryBlossomViewingArea.Position
            part.Size = Vector3.new(200, 2, 200)
            part.Anchored = true
            part.Transparency = 1
            part.Name = 'BlossomAFKLocation'
            part.Parent = Workspace
            SurfaceGui.Parent = part
            SurfaceGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
            SurfaceGui.AlwaysOnTop = false
            SurfaceGui.CanvasSize = Vector2.new(600, 600)
            SurfaceGui.Face = Enum.NormalId.Top
            TextLabel.Parent = SurfaceGui
            TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            TextLabel.BackgroundTransparency = 1
            TextLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
            TextLabel.BorderSizePixel = 0
            TextLabel.Size = UDim2.new(1, 0, 1, 0)
            TextLabel.Font = Enum.Font.SourceSans
            TextLabel.Text = '\u{1f3e1}'
            TextLabel.TextColor3 = Color3.fromRGB(0, 0, 0)
            TextLabel.TextScaled = true
            TextLabel.TextSize = 14
            TextLabel.TextWrapped = true

            task.wait(1)
        end
        local getGlider = function(shakedownInterior)
            local gliderInteractions = shakedownInterior:WaitForChild('GliderInteractions', 15)

            if not gliderInteractions then
                return
            end

            local defaultGlider = gliderInteractions:WaitForChild('spring_2025_default_paraglider', 15)

            if not defaultGlider then
                return
            end

            local gliderCollision = defaultGlider:WaitForChild('Collision', 15)

            if not gliderCollision then
                return
            end
            if not gliderCollision:WaitForChild('TouchInterest', 15) then
                return
            end

            local character = localPlayer.Character or localPlayer.CharacterAdded:Wait()

            if not character then
                return
            end

            local humanoidRootPart = character:WaitForChild('HumanoidRootPart')

            firetouchinterest(humanoidRootPart, gliderCollision, 0)
        end

        function Spring2025.Teleport()
            createAFKPlateform()

            localPlayer.Character:WaitForChild('HumanoidRootPart').Anchored = true
            localPlayer.Character.HumanoidRootPart.CFrame = Workspace.BlossomAFKLocation.CFrame * CFrame.new(math.random(1, 40), 10, math.random(1, 40))
            localPlayer.Character:WaitForChild('HumanoidRootPart').Anchored = false

            localPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Landed)
            ReplicatedStorage.API['LocationAPI/SetLocation']:FireServer('MainMap', localPlayer, ClientData.get_data()[localPlayer.Name].LiveOpsMapType)
        end
        function Spring2025.StartSakuraSwoop()
            local isGameActive = Workspace.StaticMap.blossom_shakedown_minigame_state.is_game_active
            local interior = Workspace.Interiors:WaitForChild('BlossomShakedownInterior', 15)

            getGlider(interior)

            if not interior then
                return
            end

            local ringsFolder = interior:WaitForChild('Rings', 15)

            if not ringsFolder then
                return
            end

            for i, v in ringsFolder:GetDescendants()do
                if not isGameActive.Value then
                    return
                end
                if not v:IsA('Model') then
                    continue
                end

                local args = {
                    [1] = 'blossom_shakedown',
                    [2] = 'petal_ring_flown_through',
                    [3] = v.Name,
                }

                ReplicatedStorage.API['MinigameAPI/MessageServer']:FireServer(unpack(args))
                task.wait(0.1)
            end
        end

        local findMinigameState = function(mapName)
            local staticMap = workspace:FindFirstChild('StaticMap')

            if not staticMap then
                return nil
            end

            for _, child in ipairs(staticMap:GetChildren())do
                if child:IsA('Folder') and string.match(child.Name, '^' .. mapName .. '::[%w%-]+_minigame_state$') then
                    if child:FindFirstChild('player_user_ids') and string.find(child.player_user_ids.Value, localPlayer.UserId) then
                        return string.gsub(child.Name, '_minigame_state', '')
                    end
                end
            end

            return nil
        end
        local getBuildingFolder = function(model)
            for _, v in model.Programmed.Map:GetChildren()do
                if v.Name == 'Buildings' and v:IsA('Folder') then
                    return v
                end
            end

            return nil
        end

        function Spring2025.StartTearUpToykyo()
            local minigameName = findMinigameState('tear_up_toykyo')

            if minigameName then
                print('Found:', minigameName)
            else
                print('Minigame state not found!')

                return
            end

            local model = Workspace.Interiors:FindFirstChildWhichIsA('Model')

            if not model then
                return print('No model')
            end

            local buildingFolder = getBuildingFolder(model)

            if not buildingFolder then
                return print('No building folder')
            end

            local character = localPlayer.Character or localPlayer.CharacterAdded:Wait()

            if not character then
                return print('No Char')
            end

            local humanoidRootPart = character:WaitForChild('HumanoidRootPart', 10)

            if not humanoidRootPart then
                return print('No HumanoidRootPart')
            end

            while Workspace.StaticMap.tear_up_toykyo_minigame_state.is_game_active.Value do
                for _, v in buildingFolder:GetChildren()do
                    if not v.PrimaryPart then
                        continue
                    end
                    if v:GetAttribute('Desaturated') then
                        continue
                    end

                    local distance = (v.PrimaryPart.Position - humanoidRootPart.Position).Magnitude

                    if distance > 250 then
                        continue
                    end

                    local id = v:GetAttribute('DestructibleID')

                    if not id then
                        continue
                    end

                    local points = localPlayer:GetAttribute('KaijuDestruction')

                    if points and points > 15000 then
                        return print('DONE TEAR')
                    end

                    local args = {
                        [1] = minigameName,
                        [2] = 'building_destroyed',
                        [3] = id,
                    }

                    ReplicatedStorage.API['MinigameAPI/MessageServer']:FireServer(unpack(args))
                    task.wait()
                end

                task.wait()
            end

            print('DONE TEAR')

            return
        end

        return Spring2025
    end
end

if not game:IsLoaded() then
    game.Loaded:Wait()
end
if game.PlaceId ~= 920587237 then
    return
end

local Players = game:GetService('Players')
local Workspace = game:GetService('Workspace')
local ReplicatedStorage = game:GetService('ReplicatedStorage')
local UserInputService = game:GetService('UserInputService')
local VirtualInputManager = game:GetService('VirtualInputManager')
local UserGameSettings = UserSettings():GetService('UserGameSettings')

UserGameSettings.GraphicsQualityLevel = 1
UserGameSettings.MasterVolume = 0

local VirtualUser = game:GetService('VirtualUser')
local StarterGui = game:GetService('StarterGui')
local localPlayer = Players.LocalPlayer

localPlayer:WaitForChild('PlayerGui', 600)
localPlayer.PlayerGui:WaitForChild('NewsApp', 600)

local PickColorConn
local RoleChooserDialogConnection
local RobuxProductDialogConnection1
local RobuxProductDialogConnection2
local DailyClaimConnection
local isProHandler = false
local counter = 0
local isInMiniGame = false

getgenv().isBuyingOrAging = false

local hasStartedFarming = false
local discordCooldown = false
local debounce = false
local startTime
local startPotionAmount = 0
local startTinyPotionAmount = 0
local startEventCurrencyAmount = 0
local potionsGained = 0
local tinyPotionsGained = 0
local bucksGained = 0
local eventCurrencyGained = 0
local Bed
local Shower
local Piano
local NormalLure
local LitterBox
local strollerId
local baitUnique
local selectedPlayer
local selectedPet
local selectedGift
local selectedToy
local selectedFood

getgenv().auto_accept_trade = false
getgenv().auto_trade_all_pets = false
getgenv().auto_trade_fullgrown_neon_and_mega = false
getgenv().auto_trade_multi_choice = false
getgenv().auto_trade_custom = false
getgenv().auto_trade_semi_auto = false
getgenv().auto_trade_lowtier_pets = false
getgenv().auto_trade_rarity_pets = false
getgenv().auto_farm = false
getgenv().auto_make_neon = false
getgenv().auto_trade_Legendary = false
getgenv().auto_trade_custom_gifts = false
getgenv().auto_trade_all_neons = false
getgenv().auto_trade_eggs = false
getgenv().auto_trade_all_inventory = false
getgenv().feedAgeUpPotionToggle = false
getgenv().debugMode = false
getgenv().petCurrentlyFarming1 = nil
getgenv().petCurrentlyFarming2 = nil

local Egg2Buy = getgenv().SETTINGS.PET_TO_BUY
local PetToggle
local TradeAllInventory
local AllPetsToggle
local LegendaryToggle
local FullgrownToggle
local MultipleChoiceToggle
local AnyNeonToggle
local TradeAllMegas
local TradeAllNeons
local LowTierToggle
local RarityToggle
local GiftToggle
local ToyToggle
local FoodToggle
local DailyRewardTable = {
    [9] = 'reward_1',
    [30] = 'reward_2',
    [90] = 'reward_3',
    [140] = 'reward_4',
    [180] = 'reward_5',
    [210] = 'reward_6',
    [230] = 'reward_7',
    [280] = 'reward_8',
    [300] = 'reward_9',
    [320] = 'reward_10',
    [360] = 'reward_11',
    [400] = 'reward_12',
    [460] = 'reward_13',
    [500] = 'reward_14',
    [550] = 'reward_15',
    [600] = 'reward_16',
    [660] = 'reward_17',
}
local DailyRewardTable2 = {
    [9] = 'reward_1',
    [65] = 'reward_2',
    [120] = 'reward_3',
    [180] = 'reward_4',
    [225] = 'reward_5',
    [280] = 'reward_6',
    [340] = 'reward_7',
    [400] = 'reward_8',
    [450] = 'reward_9',
    [520] = 'reward_10',
    [600] = 'reward_11',
    [660] = 'reward_12',
}
local petRaritys = {
    'common',
    'uncommon',
    'rare',
    'ultra_rare',
    'legendary',
}
local petAges = {
    'Newborn/Reborn',
    'Junior/Twinkle',
    'Pre_Teen/Sparkle',
    'Teen/Flare',
    'Post_Teen/Sunshine',
    'Full_Grown/Luminous',
}
local petNeons = {
    'normal',
    'neon',
    'mega_neon',
}
local multipleOptionsTable = {
    ['rarity'] = {},
    ['ages'] = {},
    ['neons'] = {},
}
local ClientData = require(ReplicatedStorage:WaitForChild('ClientModules'):WaitForChild('Core'):WaitForChild('ClientData'))
local RouterClient = require(ReplicatedStorage.ClientModules.Core:WaitForChild('RouterClient'):WaitForChild('RouterClient'))
local CollisionsClient = require(ReplicatedStorage.ClientModules.Game:WaitForChild('CollisionsClient'))
local Rayfield = __DARKLUA_BUNDLE_MODULES.load('a')
local Misc = __DARKLUA_BUNDLE_MODULES.load('b')
local Fusion = __DARKLUA_BUNDLE_MODULES.load('c')
local TaskBoard = __DARKLUA_BUNDLE_MODULES.load('d')
local GetInventory = __DARKLUA_BUNDLE_MODULES.load('e')
local Trade = __DARKLUA_BUNDLE_MODULES.load('f')
local Teleport = __DARKLUA_BUNDLE_MODULES.load('g')
local BuyItems = __DARKLUA_BUNDLE_MODULES.load('h')
local Ailments = __DARKLUA_BUNDLE_MODULES.load('i')
local StatsGuis2 = __DARKLUA_BUNDLE_MODULES.load('j')
local Clipboard = __DARKLUA_BUNDLE_MODULES.load('k')
local TradeLicense = __DARKLUA_BUNDLE_MODULES.load('l')
local BulkPotions = __DARKLUA_BUNDLE_MODULES.load('m')
local Tutorials = __DARKLUA_BUNDLE_MODULES.load('n')
local PotatoMode = __DARKLUA_BUNDLE_MODULES.load('o')
local Spring2025 = __DARKLUA_BUNDLE_MODULES.load('p')
local clipboard = Clipboard.new()
local taskBoard = TaskBoard.new()

StatsGuis2.Setup()

local TempPotions = StatsGuis2.new('TempPotions')
local TempTinyPotions = StatsGuis2.new('TempTinyPotions')
local TempBucks = StatsGuis2.new('TempBucks')
local TempEventCurrency = StatsGuis2.new('TempEventCurrency')
local TotalPotions = StatsGuis2.new('TotalPotions')
local TotalTinyPotions = StatsGuis2.new('TotalTinyPotions')
local TotalBucks = StatsGuis2.new('TotalBucks')
local TotalEventCurrency = StatsGuis2.new('TotalEventCurrency')
local BlankSlot1 = StatsGuis2.new('BlankSlot1')
local BlankSlot2 = StatsGuis2.new('BlankSlot1')
local TotalShiverBaits = StatsGuis2.new('TotalShiverBaits')
local TotalSubzeroBaits = StatsGuis2.new('TotalSubzeroBaits')
local petsTable = GetInventory:TabId('pets')

if #petsTable == 0 then
    petsTable = {
        'Nothing',
    }
end

local giftsTable = GetInventory:TabId('gifts')

if #giftsTable == 0 then
    giftsTable = {
        'Nothing',
    }
end

local toysTable = GetInventory:TabId('toys')

if #toysTable == 0 then
    toysTable = {
        'Nothing',
    }
end

local foodTable = GetInventory:TabId('food')

if #foodTable == 0 then
    foodTable = {
        'Nothing',
    }
end

local peteggs = GetInventory:GetPetEggs()
local clickGuiButton = function(button, xOffset, yOffset)
    local xOffset1 = xOffset or 60
    local yOffset1 = yOffset or 60

    task.wait()
    VirtualInputManager:SendMouseButtonEvent(button.AbsolutePosition.X + xOffset1, button.AbsolutePosition.Y + yOffset1, 0, true, game, 1)
    task.wait()
    VirtualInputManager:SendMouseButtonEvent(button.AbsolutePosition.X + xOffset1, button.AbsolutePosition.Y + yOffset1, 0, false, game, 1)
    task.wait()

    return
end
local fireButton = function(button)
    clickGuiButton(button)
end
local findButton = function(text, dialogFramePassOn)
    task.wait()

    local dialogFrame = dialogFramePassOn or 'NormalDialog'

    for _, v in localPlayer.PlayerGui.DialogApp.Dialog[dialogFrame].Buttons:GetDescendants()do
        if v:IsA('TextLabel') then
            if v.Text == text then
                fireButton(v.Parent.Parent)

                break
            end
        end
    end
end
local findFurniture = function()
    if Bed and Piano and LitterBox and NormalLure then
        return
    end

    Misc.DebugModePrint('getting furniture ids')

    for key, value in ClientData.get_data()[localPlayer.Name].house_interior.furniture do
        if value.id == 'basiccrib' then
            Bed = key
        elseif value.id == 'stylishshower' or value.id == 'modernshower' then
            Shower = key
        elseif value.id == 'piano' then
            Piano = key
        elseif value.id == 'lures_2023_normal_lure' then
            NormalLure = key
        elseif value.id == 'ailments_refresh_2024_litter_box' then
            LitterBox = key
        end
    end
end
local buyFurniture = function(furnitureId)
    Misc.DebugModePrint(string.format('\u{1f4b8} No %s, so buying it \u{1f4b8}', tostring(furnitureId)))

    local args = {
        {
            {
                ['kind'] = furnitureId,
                ['properties'] = {
                    ['cframe'] = CFrame.new(14, 2, -22) * CFrame.Angles(-0, 8.7, 3.8),
                },
            },
        },
    }

    ReplicatedStorage:WaitForChild('API'):WaitForChild('HousingAPI/BuyFurnitures'):InvokeServer(unpack(args))
end
local grabDailyReward = function()
    Misc.DebugModePrint('getting daily rewards')

    local Daily = ClientData.get('daily_login_manager')

    if Daily.prestige % 2 == 0 then
        for i, v in pairs(DailyRewardTable)do
            if i < Daily.stars or i == Daily.stars then
                if not Daily.claimed_star_rewards[v] then
                    Misc.DebugModePrint('grabbing dialy reward!')
                    Misc.DebugModePrint(ReplicatedStorage.API:FindFirstChild('DailyLoginAPI/ClaimStarReward'):InvokeServer(v))
                end
            end
        end
    else
        for i, v in pairs(DailyRewardTable2)do
            if i < Daily.stars or i == Daily.stars then
                if not Daily.claimed_star_rewards[v] then
                    Misc.DebugModePrint('grabbing dialy reward!')
                    Misc.DebugModePrint(ReplicatedStorage.API:FindFirstChild('DailyLoginAPI/ClaimStarReward'):InvokeServer(v))
                end
            end
        end
    end
end
local isMuleInGame = function()
    for _, player in Players:GetPlayers()do
        if player.Name == localPlayer.Name then
            continue
        end
        if table.find(getgenv().SETTINGS.TRADE_COLLECTOR_NAME, player.Name) then
            return true
        end
    end

    return false
end
local consumeItem = function(potionName)
    local agePotion = Workspace.PetObjects:WaitForChild(potionName, 15)

    if not agePotion then
        Misc.DebugModePrint('no age potion in workspace')

        return
    end

    ReplicatedStorage.API['PetAPI/ConsumeFoodObject']:FireServer(agePotion, ClientData.get('pet_char_wrappers')[1].pet_unique)
end
local agePotion = function(FoodPassOn)
    for _, v in pairs(ClientData.get_data()[localPlayer.Name].inventory.food)do
        if v.id == FoodPassOn then
            if not ClientData.get('pet_char_wrappers')[1] then
                return
            end

            local isEgg = table.find(peteggs, ClientData.get('pet_char_wrappers')[1]['pet_id']) and true or false
            local petAge = ClientData.get('pet_char_wrappers')[1]['pet_progression']['age']

            if isEgg or petAge >= 6 then
                return
            end

            local args = {
                [1] = '__Enum_PetObjectCreatorType_2',
                [2] = {
                    ['pet_unique'] = ClientData.get('pet_char_wrappers')[1].pet_unique,
                    ['unique_id'] = v.unique,
                },
            }

            ReplicatedStorage.API['PetObjectAPI/CreatePetObject']:InvokeServer(unpack(args))
            consumeItem('AgePotion')

            return
        end
    end

    return
end
local getPlayersInGame = function()
    local playerTable = {
        'Nothing',
    }

    for _, player in Players:GetPlayers()do
        if player.Name == localPlayer.Name then
            continue
        end

        table.insert(playerTable, player.Name)
    end

    table.sort(playerTable)

    return playerTable
end
local placeBaitOrPickUp = function(baitUniquePasson)
    if not NormalLure then
        return
    end
    if not baitUniquePasson then
        return
    end

    Misc.DebugModePrint('placing bait or picking up')

    local args = {
        [1] = game:GetService('Players').LocalPlayer,
        [2] = NormalLure,
        [3] = 'UseBlock',
        [4] = {
            ['bait_unique'] = baitUniquePasson,
        },
        [5] = game:GetService('Players').LocalPlayer.Character,
    }
    local success, errorMessage = pcall(function()
        ReplicatedStorage.API:FindFirstChild('HousingAPI/ActivateFurniture'):InvokeServer(unpack(args))
    end)

    Misc.DebugModePrint('FIRING BAITBOX', success, errorMessage)
end
local agePotionCount = function(nameId)
    local count = 0

    for _, v in ClientData.get_data()[localPlayer.Name].inventory.food do
        if v.id == nameId then
            count = count + 1
        end
    end

    return count
end
local eventCurrencyAmount = function()
    return ClientData.get_data()[localPlayer.Name].cherry_blossoms_2025 or 0
end
local updateStatsGui = function()
    StatsGuis2:UpdateTextFor('TimeLabel', startTime)

    potionsGained = agePotionCount('pet_age_potion') - startPotionAmount

    if potionsGained < 0 then
        potionsGained = 0
    end

    TempPotions:UpdateTextFor('TempPotions', potionsGained)

    tinyPotionsGained = agePotionCount('tiny_pet_age_potion') - startTinyPotionAmount

    if tinyPotionsGained < 0 then
        tinyPotionsGained = 0
    end

    TempTinyPotions:UpdateTextFor('TempTinyPotions', tinyPotionsGained)

    local currentEventCurrency = eventCurrencyAmount()

    if currentEventCurrency >= startEventCurrencyAmount then
        eventCurrencyGained = eventCurrencyGained + (currentEventCurrency - startEventCurrencyAmount)
        startEventCurrencyAmount = currentEventCurrency
    elseif currentEventCurrency < startEventCurrencyAmount then
        startEventCurrencyAmount = currentEventCurrency
    end

    TempEventCurrency:UpdateTextFor('TempEventCurrency', eventCurrencyGained)
    TotalEventCurrency:UpdateTextFor('TotalEventCurrency')
    TotalPotions:UpdateTextFor('TotalPotions')
    TotalBucks:UpdateTextFor('TotalBucks')
    BlankSlot1:UpdateTextFor('BlankSlot1')
    BlankSlot2:UpdateTextFor('BlankSlot2')
    TotalShiverBaits:UpdateTextFor('TotalShiverBaits')
    TotalSubzeroBaits:UpdateTextFor('TotalSubzeroBaits')
end
local findBait = function()
    local baits = getgenv().SETTINGS.BAIT_TO_USE_IN_ORDER

    if not baits then
        baits = {
            'ice_dimension_2025_shiver_cone_bait',
            'ice_dimension_2025_subzero_popsicle_bait',
            'ice_dimension_2025_ice_soup_bait',
        }
    end

    for _, id in ipairs(baits)do
        for _, v in pairs(ClientData.get_data()[localPlayer.Name].inventory.food)do
            if id == v.id then
                return v.unique
            end
        end
    end

    return nil
end
local getEgg = function(whichPet)
    for _, v in pairs(ClientData.get_data()[localPlayer.Name].inventory.pets)do
        if v.id == Egg2Buy and v.id ~= 'practice_dog' and v.properties.age ~= 6 and not v.properties.mega_neon then
            ReplicatedStorage.API['ToolAPI/Equip']:InvokeServer(v.unique, {
                ['use_sound_delay'] = true,
            })

            getgenv().petCurrentlyFarming1 = v.unique

            return true
        end
    end

    local BuyEgg = ReplicatedStorage.API['ShopAPI/BuyItem']:InvokeServer('pets', Egg2Buy, {})

    if BuyEgg == 'too little money' then
        return false
    end

    task.wait(1)

    return false
end
local getPet = function(whichPet)
    if getgenv().SETTINGS.FOCUS_FARM_AGE_POTION then
        print(string.format('Getting pet for %s', tostring(whichPet)))

        if whichPet == 1 and getgenv().petCurrentlyFarming1 then
            return
        end
        if whichPet == 2 and isProHandler and getgenv().petCurrentlyFarming2 then
            return
        end

        Misc.DebugModePrint(string.format('\u{1f414}\u{1f414} Getting pet to Farm age up potion, %s \u{1f414}\u{1f414}', tostring(whichPet)))

        if GetInventory:CheckForPetAndEquip('winter_2024_frostbite_cub', whichPet) then
            return true
        end
        if GetInventory:GetPetFriendship(whichPet) then
            return true
        end
        if GetInventory:CheckForPetAndEquip('starter_egg', whichPet) then
            return true
        end
        if GetInventory:CheckForPetAndEquip('dog', whichPet) then
            return true
        end
        if GetInventory:CheckForPetAndEquip('cat', whichPet) then
            return true
        end
        if GetInventory:GetHighestGrownPet(6, whichPet) then
            return true
        end
    end
    if getgenv().SETTINGS.HATCH_EGG_PRIORITY then
        if GetInventory:PriorityEgg(whichPet) then
            return
        end

        local hasMoney = ReplicatedStorage.API['ShopAPI/BuyItem']:InvokeServer('pets', getgenv().SETTINGS.HATCH_EGG_PRIORITY_NAMES[1], {})

        if hasMoney then
            return
        end
    end
    if getgenv().SETTINGS.PET_ONLY_PRIORITY then
        if GetInventory:PriorityPet(whichPet) then
            return
        end
    end
    if getgenv().SETTINGS.PET_NEON_PRIORITY then
        if GetInventory:GetNeonPet(whichPet) then
            return
        end
    end
    if GetInventory:PetRarityAndAge('legendary', 5, whichPet) then
        return
    end
    if GetInventory:PetRarityAndAge('ultra_rare', 5, whichPet) then
        return
    end
    if GetInventory:PetRarityAndAge('rare', 5, whichPet) then
        return
    end
    if GetInventory:PetRarityAndAge('uncommon', 5, whichPet) then
        return
    end
    if GetInventory:PetRarityAndAge('common', 5, whichPet) then
        return
    end
    if getEgg(whichPet) then
        return
    end

    return
end
local removeHandHeldItem = function()
    local tool = localPlayer.Character:FindFirstChildOfClass('Tool')

    if tool then
        ReplicatedStorage.API['ToolAPI/Unequip']:InvokeServer(tool.unique.Value, {})
    end
end
local CheckifEgg = function(whichPet)
    if not ClientData.get('pet_char_wrappers') then
        return
    end
    if not ClientData.get('pet_char_wrappers')[whichPet] then
        return
    end
    if table.find(peteggs, ClientData.get('pet_char_wrappers')[whichPet].pet_id) then
        return
    end

    Misc.DebugModePrint(string.format('NOT A EGG SO GETTING NEW EGG %s', tostring(whichPet)))
    getPet(whichPet)

    return
end
local SwitchOutFullyGrown = function(whichPet)
    if getgenv().isBuyingOrAging then
        return
    end
    if not ClientData.get('pet_char_wrappers')[whichPet] then
        if not Misc.ReEquipPet(whichPet) then
            Misc.DebugModePrint('SwitchOutFullyGrown: GETTING NEW PETS')
            getPet(whichPet)

            return
        end

        task.wait(1)
    end

    local PetAge = ClientData.get('pet_char_wrappers')[whichPet]['pet_progression']['age']

    if PetAge == 6 then
        if getgenv().SETTINGS.PET_AUTO_FUSION then
            Fusion:MakeMega(false)
            Fusion:MakeMega(true)
        end

        getPet(whichPet)

        return
    end
end
local ClickTradeWindowPopUps = function()
    for _, v in pairs(localPlayer.PlayerGui.DialogApp.Dialog.NormalDialog.Buttons:GetDescendants())do
        if v.Name == 'TextLabel' then
            if v.Text == 'Accept' or v.Text == 'Okay' or v.Text == 'Next' or v.Text == 'I understand' or v.Text == 'No' then
                fireButton(v.Parent.Parent)

                return
            end
        end
    end
    for _, v in pairs(localPlayer.PlayerGui.DialogApp.Dialog.HeaderDialog.Buttons:GetDescendants())do
        if v.Name == 'TextLabel' then
            if v.Text == 'Accept' or v.Text == 'Okay' or v.Text == 'Next' or v.Text == 'I understand' then
                fireButton(v.Parent.Parent)

                return
            end
        end
    end
end
local removeGameOverButton = function(ScreenGuiName)
    task.wait()
    localPlayer.PlayerGui[ScreenGuiName].Body.Button:WaitForChild('Face')

    for _, v in pairs(localPlayer.PlayerGui[ScreenGuiName].Body.Button:GetDescendants())do
        if v.Name == 'TextLabel' then
            if v.Text == 'NICE!' then
                fireButton(v.Parent.Parent)

                break
            end
        end
    end
end
local teleportToFarmSpotOrBlossomSpot = function()
    if getgenv().SETTINGS.EVENT and getgenv().SETTINGS.EVENT.DO_MINIGAME then
        Teleport.DownloadMainMap()
        Spring2025.Teleport()
    else
        Teleport.FarmingHome()
    end
end
local onTextChangedMiniGame = function()
    if getgenv().SETTINGS.EVENT and getgenv().SETTINGS.EVENT.DO_MINIGAME and hasStartedFarming and not isMuleInGame() then
        isInMiniGame = true

        findButton('Yes')
    else
        findButton('No')
    end
end
local completeBabyAilments = function()
    if isInMiniGame then
        return
    end

    for key, _ in ClientData.get_data()[localPlayer.Name].ailments_manager.baby_ailments do
        if key == 'hungry' then
            Ailments:BabyHungryAilment()

            return
        elseif key == 'thirsty' then
            Ailments:BabyThirstyAilment()

            return
        elseif key == 'bored' then
            Ailments:BabyBoredAilment(Piano)

            return
        elseif key == 'sleepy' then
            Ailments:BabySleepyAilment(Bed)

            return
        elseif key == 'dirty' then
            Ailments:BabyDirtyAilment(Shower)

            return
        end
    end
end
local CompletePetAilments = function(whichPet)
    if isInMiniGame then
        return
    end
    if not isProHandler and whichPet == 2 then
        return
    end

    local petWrapper = ClientData.get_data()[localPlayer.Name].pet_char_wrappers

    if not petWrapper or not petWrapper[whichPet] then
        if not Misc.ReEquipPet(whichPet) then
            getPet(whichPet)
        end
    end
    if not ClientData.get_data()[localPlayer.Name].ailments_manager then
        return false
    end
    if not ClientData.get_data()[localPlayer.Name].ailments_manager.ailments then
        return false
    end
    if not ClientData.get_data()[localPlayer.Name].pet_char_wrappers then
        return false
    end
    if not ClientData.get_data()[localPlayer.Name].pet_char_wrappers[whichPet] then
        return false
    end

    local petUnique = ClientData.get_data()[localPlayer.Name].pet_char_wrappers[whichPet].pet_unique

    if not petUnique then
        return false
    end
    if not ClientData.get_data()[localPlayer.Name].ailments_manager.ailments[petUnique] then
        return false
    end

    local petcount = 0

    for _ in ClientData.get_data()[localPlayer.Name].ailments_manager.ailments[petUnique]do
        petcount = petcount + 1
    end

    if petcount == 0 then
        return false
    end

    Ailments.whichPet = whichPet

    for key, _ in ClientData.get_data()[localPlayer.Name].ailments_manager.ailments[petUnique]do
        if key == 'hungry' then
            Ailments:HungryAilment()

            return true
        elseif key == 'thirsty' then
            Ailments:ThirstyAilment()

            return true
        elseif key == 'sick' then
            Ailments:SickAilment()

            return true
        elseif key == 'pet_me' then
            Ailments:PetMeAilment()

            return true
        end
    end
    for key, _ in ClientData.get_data()[localPlayer.Name].ailments_manager.ailments[petUnique]do
        if key == 'salon' then
            Ailments:SalonAilment(key, petUnique)
            teleportToFarmSpotOrBlossomSpot()

            return true
        elseif key == 'moon' then
            Ailments:MoonAilment(key, petUnique)

            return true
        elseif key == 'pizza_party' then
            Ailments:PizzaPartyAilment(key, petUnique)
            teleportToFarmSpotOrBlossomSpot()

            return true
        elseif key == 'school' then
            Ailments:SchoolAilment(key, petUnique)
            teleportToFarmSpotOrBlossomSpot()

            return true
        elseif key == 'bored' then
            Ailments:BoredAilment(Piano, petUnique)

            return true
        elseif key == 'sleepy' then
            Ailments:SleepyAilment(Bed, petUnique)

            return true
        elseif key == 'dirty' then
            Ailments:DirtyAilment(Shower, petUnique)

            return true
        elseif key == 'walk' then
            Ailments:WalkAilment(petUnique)

            return true
        elseif key == 'toilet' then
            if not LitterBox then
                Misc.DebugModePrint('DOEST HAVE LITTER BOX')
            end

            Ailments:ToiletAilment(LitterBox, petUnique)

            return true
        elseif key == 'ride' then
            Ailments:RideAilment(strollerId, petUnique)

            return true
        elseif key == 'play' then
            if not Ailments:PlayAilment(key, petUnique) then
                return false
            end

            return true
        end
    end
    for key, _ in ClientData.get_data()[localPlayer.Name].ailments_manager.ailments[petUnique]do
        if key == 'beach_party' then
            Teleport.PlaceFloorAtBeachParty()
            Ailments:BeachPartyAilment(petUnique)
            Teleport.DownloadMainMap()
            Spring2025.Teleport()

            return true
        elseif key == 'camping' then
            Teleport.PlaceFloorAtCampSite()
            Ailments:CampingAilment(petUnique)
            Teleport.DownloadMainMap()
            Spring2025.Teleport()

            return true
        end
    end
    for key, _ in ClientData.get_data()[localPlayer.Name].ailments_manager.ailments[petUnique]do
        if key:match('mystery') then
            Ailments:MysteryAilment(key, petUnique)

            return true
        end
    end

    return false
end
local autoFarm = function()
    if not getgenv().auto_farm then
        return
    end

    CollisionsClient.set_collidable(false)
    Teleport.PlaceFloorAtFarmingHome()
    Teleport.PlaceFloorAtCampSite()
    Teleport.PlaceFloorAtBeachParty()
    teleportToFarmSpotOrBlossomSpot()
    task.delay(30, function()
        hasStartedFarming = true

        local baitboxCount = 0

        while true do
            if getgenv().isBuyingOrAging then
                repeat
                    Misc.DebugModePrint('Stopping because its buying or aging')
                    task.wait(20)
                until not getgenv().isBuyingOrAging
            end
            if isInMiniGame then
                repeat
                    Misc.DebugModePrint('\u{23f1}\u{fe0f} Waiting for 20 secs [inside minigame] \u{23f1}\u{fe0f}')
                    task.wait(20)
                until not isInMiniGame

                isInMiniGame = false
            end

            removeHandHeldItem()

            if getgenv().SETTINGS.HATCH_EGG_PRIORITY then
                CheckifEgg(1)
                task.wait(1)

                if isProHandler then
                    CheckifEgg(2)
                    task.wait(1)
                end
            end
            if not CompletePetAilments(1) then
                task.wait()

                if not CompletePetAilments(2) then
                    task.wait()
                    completeBabyAilments()
                end
            end

            task.wait(1)

            if not getgenv().SETTINGS.FOCUS_FARM_AGE_POTION then
                SwitchOutFullyGrown(1)

                if isProHandler then
                    SwitchOutFullyGrown(2)
                end
            end
            if baitboxCount > 600 then
                baitUnique = findBait()

                placeBaitOrPickUp(baitUnique)
                task.wait(2)
                placeBaitOrPickUp(baitUnique)

                baitboxCount = 0
            end
            if not getgenv().SETTINGS.FOCUS_FARM_AGE_POTION then
                if ClientData.get('pet_char_wrappers')[1] and table.find(peteggs, ClientData.get('pet_char_wrappers')[1].pet_id) then
                    Misc.DebugModePrint('is egg, not feeding age potion')
                else
                    if ClientData.get('pet_char_wrappers')[1] and table.find(getgenv().SETTINGS.PET_ONLY_PRIORITY_NAMES, ClientData.get('pet_char_wrappers')[1].pet_unique) then
                        Misc.DebugModePrint('FEEDING AGE POTION')
                        agePotion('pet_age_potion')
                        task.wait()
                        agePotion('tiny_pet_age_potion')
                    end
                end
            end

            updateStatsGui()
            Misc.DebugModePrint('\u{23f1}\u{fe0f} Waiting for 5 secs \u{23f1}\u{fe0f}')

            baitboxCount = baitboxCount + 2

            task.wait(2)
        end
    end)

    if getgenv().SETTINGS.PET_AUTO_FUSION then
        Fusion:MakeMega(false)
        Fusion:MakeMega(true)
        task.wait(1)
    end

    getPet(1)
    task.wait(2)

    if isProHandler then
        getPet(2)
    end

    task.wait()
    TradeLicense.Get(ClientData, localPlayer.Name)
end
local startAutoFarm = function()
    counter = counter + 1

    if getgenv().SETTINGS.ENABLE_AUTO_FARM then
        findFurniture()

        if Bed then
            getgenv().auto_farm = true

            autoFarm()
        end
    end
end
local SendMessage = function(url, message, userId)
    local http = game:GetService('HttpService')
    local headers = {
        ['Content-Type'] = 'application/json',
    }
    local data = {
        ['content'] = string.format('<@%s> %s', tostring(userId), tostring(message)),
    }
    local body = http:JSONEncode(data)
    local response = request({
        Url = url,
        Method = 'POST',
        Headers = headers,
        Body = body,
    })

    for i, v in response do
        Misc.DebugModePrint(i, v)
    end
end
local dailyLoginAppClick = function()
    task.wait(0.1)

    if not localPlayer.PlayerGui.DailyLoginApp.Enabled then
        return
    end

    Misc.DebugModePrint('Clicking on Daily login app')
    localPlayer.PlayerGui.DailyLoginApp:WaitForChild('Frame')
    localPlayer.PlayerGui.DailyLoginApp.Frame:WaitForChild('Body')
    localPlayer.PlayerGui.DailyLoginApp.Frame.Body:WaitForChild('Buttons')

    for _, v in localPlayer.PlayerGui.DailyLoginApp.Frame.Body.Buttons:GetDescendants()do
        if v.Name == 'TextLabel' then
            if v.Text == 'CLOSE' then
                Misc.DebugModePrint('pressed Close on daily login')
                fireButton(v.Parent.Parent)
                task.wait(1)
                grabDailyReward()
            elseif v.Text == 'CLAIM!' then
                Misc.DebugModePrint('pressed claim on daily login')
                fireButton(v.Parent.Parent)
                task.wait()
                fireButton(v.Parent.Parent)
                grabDailyReward()
            end
        end
    end
end
local onTextChangedNormalDialog = function()
    if localPlayer.PlayerGui.DialogApp.Dialog.NormalDialog.Info.TextLabel.Text:match('Be careful when trading') then
        findButton('Okay')
    elseif localPlayer.PlayerGui.DialogApp.Dialog.NormalDialog.Info.TextLabel.Text:match('This trade seems unbalanced') then
        findButton('Next')
    elseif localPlayer.PlayerGui.DialogApp.Dialog.NormalDialog.Info.TextLabel.Text:match('sent you a trade request') then
        findButton('Accept')
    elseif localPlayer.PlayerGui.DialogApp.Dialog.NormalDialog.Info.TextLabel.Text:match('Any items lost') then
        findButton('I understand')
    elseif localPlayer.PlayerGui.DialogApp.Dialog.NormalDialog.Info.TextLabel.Text:match('4.5%% Legendary') then
        findButton('Okay')
    elseif localPlayer.PlayerGui.DialogApp.Dialog.NormalDialog.Info.TextLabel.Text:match('You have been awarded') then
        findButton('Awesome!')
    elseif localPlayer.PlayerGui.DialogApp.Dialog.NormalDialog.Info.TextLabel.Text:match('Thanks for subscribing!') then
        findButton('Okay')
    elseif localPlayer.PlayerGui.DialogApp.Dialog.NormalDialog.Info.TextLabel.Text:match("Let's start the day") then
        findButton('Start')
    elseif localPlayer.PlayerGui.DialogApp.Dialog.NormalDialog.Info.TextLabel.Text:match('Are you subscribed') then
        findButton('Yes')
    elseif localPlayer.PlayerGui.DialogApp.Dialog.NormalDialog.Info.TextLabel.Text:match('your inventory!') then
        findButton('Awesome!')
    elseif localPlayer.PlayerGui.DialogApp.Dialog.NormalDialog.Info.TextLabel.Text:match('Burtaur') then
        findButton('Cool!')
    elseif localPlayer.PlayerGui.DialogApp.Dialog.NormalDialog.Info.TextLabel.Text:match('Gingerbread!') then
        findButton('Awesome!')
    elseif localPlayer.PlayerGui.DialogApp.Dialog.NormalDialog.Info.TextLabel.Text:match('Thanks for') then
        findButton('Okay')
    elseif localPlayer.PlayerGui.DialogApp.Dialog.NormalDialog.Info.TextLabel.Text:match('Right now') then
        findButton('Next')
    elseif localPlayer.PlayerGui.DialogApp.Dialog.NormalDialog.Info.TextLabel.Text:match('You can customize it') then
        findButton('Start')
    elseif localPlayer.PlayerGui.DialogApp.Dialog.NormalDialog.Info.TextLabel.Text:match('Your subscription') then
        findButton('Okay!')
    elseif localPlayer.PlayerGui.DialogApp.Dialog.NormalDialog.Info.TextLabel.Text:match('You have been refunded') then
        findButton('Awesome!')
    end
end
local doStarterTutorial = function()
    if localPlayer.PlayerGui.DialogApp.Dialog.NormalDialog.Info.TextLabel.Text:match('Welcome to Adopt Me!') then
        findButton('Next')
        task.wait(2)
        Misc.DebugModePrint('doing tutorial')
        Tutorials.CompleteNewStarterTutorial()
        task.wait(1)
        Misc.DebugModePrint('doing trade license')
        task.wait(1)
        TradeLicense.Get(ClientData, localPlayer.Name)
        findButton('Next')
    end
end
local pickColorTutorial = function()
    local colorButton = localPlayer.PlayerGui.DialogApp.Dialog.ThemeColorDialog:WaitForChild('Info'):WaitForChild('Response'):WaitForChild('ColorTemplate')

    if not colorButton then
        return
    end

    fireButton(colorButton)
    task.wait(5)

    local doneButton = localPlayer.PlayerGui.DialogApp.Dialog.ThemeColorDialog:WaitForChild('Buttons'):WaitForChild('ButtonTemplate')

    if not doneButton then
        return
    end

    fireButton(doneButton)
    Misc.DebugModePrint('PICKED COLOR')
end

localPlayer.PlayerGui.HintApp.TextLabel:GetPropertyChangedSignal('Text'):Connect(function(
)
    if localPlayer.PlayerGui.HintApp.TextLabel.Text:match('Bucks') then
        local text = localPlayer.PlayerGui.HintApp.TextLabel.Text

        if not text then
            return
        end

        local amount = text:split('+')[2]:split(' ')[1]

        bucksGained = bucksGained + tonumber(amount)

        TempBucks:UpdateTextFor('TempBucks', bucksGained)
    elseif localPlayer.PlayerGui.HintApp.TextLabel.Text:match('aged up!') then
    end
end)
Workspace.StaticMap.blossom_shakedown_minigame_state.is_game_active:GetPropertyChangedSignal('Value'):Connect(function(
)
    if not Workspace.StaticMap.blossom_shakedown_minigame_state.is_game_active.Value then
        isInMiniGame = false

        Misc.DebugModePrint(string.format('game is not active setting isInMinigame to %s', tostring(isInMiniGame)))

        return
    end
    if getgenv().SETTINGS.EVENT and getgenv().SETTINGS.EVENT.DO_MINIGAME and hasStartedFarming and not isMuleInGame() then
        isInMiniGame = true

        Misc.DebugModePrint(string.format('game ACTIVE setting isInMinigame to %s', tostring(isInMiniGame)))
        ReplicatedStorage.API['MinigameAPI/AttemptJoin']:FireServer('blossom_shakedown', true)
        task.wait()
        ReplicatedStorage.API['LocationAPI/SetLocation']:FireServer('BlossomShakedownInterior')
    end
end)
Workspace.StaticMap.tear_up_toykyo_minigame_state.is_game_active:GetPropertyChangedSignal('Value'):Connect(function(
)
    if not Workspace.StaticMap.tear_up_toykyo_minigame_state.is_game_active.Value then
        isInMiniGame = false

        Misc.DebugModePrint(string.format('game is not active setting isInMinigame to %s', tostring(isInMiniGame)))

        return
    end
    if getgenv().SETTINGS.EVENT and getgenv().SETTINGS.EVENT.DO_MINIGAME and hasStartedFarming and not isMuleInGame() then
        isInMiniGame = true

        Misc.DebugModePrint(string.format('game ACTIVE setting isInMinigame to %s', tostring(isInMiniGame)))
    end
end)
UserInputService.InputBegan:Connect(function(input, processed)
    if (input.KeyCode == Enum.KeyCode.Q and not processed) then
        if debounce then
            return
        end

        debounce = true

        clipboard:CopyAllInventory()
        task.wait()

        debounce = false
    end
end)

RoleChooserDialogConnection = localPlayer.PlayerGui.DialogApp.Dialog.RoleChooserDialog:GetPropertyChangedSignal('Visible'):Connect(function(
)
    task.wait()

    if localPlayer.PlayerGui.DialogApp.Dialog.RoleChooserDialog.Visible then
        Misc.DebugModePrint('Clicking on baby dialog button')
        firesignal(localPlayer.PlayerGui.DialogApp.Dialog.RoleChooserDialog.Baby.MouseButton1Click)

        if RoleChooserDialogConnection then
            RoleChooserDialogConnection:Disconnect()

            RoleChooserDialogConnection = nil
        end
    end
end)
RobuxProductDialogConnection1 = localPlayer.PlayerGui.DialogApp.Dialog.RobuxProductDialog:GetPropertyChangedSignal('Visible'):Connect(function(
)
    if not localPlayer.PlayerGui.DialogApp.Dialog.RobuxProductDialog.Visible then
        return
    end

    localPlayer.PlayerGui.DialogApp.Dialog.RobuxProductDialog:WaitForChild('Buttons')
    task.wait()

    for _, v in localPlayer.PlayerGui.DialogApp.Dialog.RobuxProductDialog.Buttons:GetDescendants()do
        if v.Name == 'TextLabel' then
            if v.Text == 'No Thanks' then
                Misc.DebugModePrint('clicking on no thanks for robux')
                firesignal(v.Parent.Parent.MouseButton1Click)

                if RobuxProductDialogConnection1 then
                    RobuxProductDialogConnection1:Disconnect()

                    RobuxProductDialogConnection1 = nil
                end
            end
        end
    end
end)
RobuxProductDialogConnection2 = localPlayer.PlayerGui.DialogApp.Dialog:GetPropertyChangedSignal('Visible'):Connect(function(
)
    if not localPlayer.PlayerGui.DialogApp.Dialog.Visible then
        return
    end

    localPlayer.PlayerGui.DialogApp.Dialog:WaitForChild('RobuxProductDialog')

    if not localPlayer.PlayerGui.DialogApp.Dialog.RobuxProductDialog.Visible then
        return
    end

    localPlayer.PlayerGui.DialogApp.Dialog.RobuxProductDialog:WaitForChild('Buttons')
    task.wait()

    for _, v in localPlayer.PlayerGui.DialogApp.Dialog.RobuxProductDialog.Buttons:GetDescendants()do
        if v.Name == 'TextLabel' then
            if v.Text == 'No Thanks' then
                firesignal(v.Parent.Parent.MouseButton1Click)

                if RobuxProductDialogConnection2 then
                    RobuxProductDialogConnection2:Disconnect()

                    RobuxProductDialogConnection2 = nil
                end
            end
        end
    end
end)
DailyClaimConnection = localPlayer.PlayerGui.DailyLoginApp:GetPropertyChangedSignal('Enabled'):Connect(function(
)
    dailyLoginAppClick()

    if DailyClaimConnection then
        DailyClaimConnection:Disconnect()

        DailyClaimConnection = nil
    end
end)

Players.LocalPlayer.PlayerGui.QuestIconApp.ImageButton.EventContainer.IsNew:GetPropertyChangedSignal('Position'):Connect(function(
)
    if taskBoard.NewTaskBool then
        taskBoard.NewTaskBool = false

        ReplicatedStorage.API:FindFirstChild('QuestAPI/MarkQuestsViewed'):FireServer()
        taskBoard:NewTask()
    end
end)
Players.LocalPlayer.PlayerGui.QuestIconApp.ImageButton.EventContainer.IsClaimable:GetPropertyChangedSignal('Position'):Connect(function(
)
    if taskBoard.NewClaimBool then
        taskBoard.NewClaimBool = false

        taskBoard:NewClaim()
    end
end)
localPlayer.PlayerGui.DialogApp.Dialog:GetPropertyChangedSignal('Visible'):Connect(function(
)
    if not localPlayer.PlayerGui.DialogApp.Dialog.Visible then
        return
    end

    localPlayer.PlayerGui.DialogApp.Dialog:WaitForChild('HeaderDialog')

    if not localPlayer.PlayerGui.DialogApp.Dialog.HeaderDialog.Visible then
        return
    end

    localPlayer.PlayerGui.DialogApp.Dialog.HeaderDialog:WaitForChild('Info')
    localPlayer.PlayerGui.DialogApp.Dialog.HeaderDialog.Info:WaitForChild('TextLabel')
    localPlayer.PlayerGui.DialogApp.Dialog.HeaderDialog.Info.TextLabel:GetPropertyChangedSignal('Text'):Connect(function(
    )
        if localPlayer.PlayerGui.DialogApp.Dialog.HeaderDialog.Info.TextLabel.Text:match('sent you a trade request') then
            findButton('Accept', 'HeaderDialog')
        end
    end)
end)
localPlayer.PlayerGui.DialogApp.Dialog.ChildAdded:Connect(function(Child)
    if Child.Name ~= 'HeaderDialog' then
        return
    end

    Child:GetPropertyChangedSignal('Visible'):Connect(function()
        if not Child.Visible then
            return
        end

        Child:WaitForChild('Info')
        Child.Info:WaitForChild('TextLabel')
        Child.Info.TextLabel:GetPropertyChangedSignal('Text'):Connect(function()
            if Child.Info.TextLabel.Text:match('sent you a trade request') then
                findButton('Accept', 'HeaderDialog')
            end
        end)
    end)
end)
localPlayer.PlayerGui.DialogApp.Dialog.NormalDialog:GetPropertyChangedSignal('Visible'):Connect(function(
)
    if localPlayer.PlayerGui.DialogApp.Dialog.NormalDialog.Visible then
        localPlayer.PlayerGui.DialogApp.Dialog.NormalDialog:WaitForChild('Info')
        localPlayer.PlayerGui.DialogApp.Dialog.NormalDialog.Info:WaitForChild('TextLabel')
        localPlayer.PlayerGui.DialogApp.Dialog.NormalDialog.Info.TextLabel:GetPropertyChangedSignal('Text'):Connect(onTextChangedNormalDialog)
    end
end)
localPlayer.PlayerGui.DialogApp.Dialog.ChildAdded:Connect(function(Child)
    if Child.Name == 'NormalDialog' then
        Child:GetPropertyChangedSignal('Visible'):Connect(function()
            if not Child.Visible then
                return
            end

            Child:WaitForChild('Info')
            Child.Info:WaitForChild('TextLabel')
            Child.Info.TextLabel:GetPropertyChangedSignal('Text'):Connect(onTextChangedNormalDialog)
        end)
    end
end)
Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function(character)
        if table.find(getgenv().SETTINGS.TRADE_COLLECTOR_NAME, localPlayer.Name) then
            return
        end
        if not table.find(getgenv().SETTINGS.TRADE_COLLECTOR_NAME, player.Name) then
            return
        end

        local humanoidRootPart = character:WaitForChild('HumanoidRootPart', 120)

        if not humanoidRootPart then
            return
        end

        task.wait(math.random(10, 30))
        Trade:TradeCollector(getgenv().SETTINGS.TRADE_COLLECTOR_NAME)
    end)
end)

if getgenv().SETTINGS.WEBHOOK and getgenv().SETTINGS.WEBHOOK.URL and #getgenv().SETTINGS.WEBHOOK.URL >= 1 and localPlayer.Name == getgenv().SETTINGS.TRADE_COLLECTOR_NAME then
    localPlayer.PlayerGui.DialogApp.Dialog:GetPropertyChangedSignal('Visible'):Connect(function(
    )
        if discordCooldown then
            return
        end

        discordCooldown = true

        localPlayer.PlayerGui.DialogApp.Dialog:WaitForChild('HeaderDialog')
        localPlayer.PlayerGui.DialogApp.Dialog.HeaderDialog:GetPropertyChangedSignal('Visible'):Connect(function(
        )
            if not localPlayer.PlayerGui.DialogApp.Dialog.HeaderDialog.Visible then
                return
            end

            localPlayer.PlayerGui.DialogApp.Dialog.HeaderDialog:WaitForChild('Info')
            localPlayer.PlayerGui.DialogApp.Dialog.HeaderDialog.Info:WaitForChild('TextLabel')
            localPlayer.PlayerGui.DialogApp.Dialog.HeaderDialog.Info.TextLabel:GetPropertyChangedSignal('Text'):Connect(function(
            )
                SendMessage(getgenv().SETTINGS.WEBHOOK.URL, localPlayer.PlayerGui.DialogApp.Dialog.HeaderDialog.Info.TextLabel.Text, getgenv().SETTINGS.WEBHOOK.USER_ID)
                task.wait(1)

                discordCooldown = false
            end)
        end)
    end)
end

localPlayer.PlayerGui.TradeApp.Frame.NegotiationFrame.Body.PartnerOffer.Accepted:GetPropertyChangedSignal('ImageTransparency'):Connect(function(
)
    Trade:AutoAcceptTrade()
end)
localPlayer.PlayerGui.TradeApp.Frame.ConfirmationFrame.PartnerOffer.Accepted:GetPropertyChangedSignal('ImageTransparency'):Connect(function(
)
    Trade:AutoAcceptTrade()
end)
localPlayer.PlayerGui.MinigameInGameApp:GetPropertyChangedSignal('Enabled'):Connect(function(
)
    if localPlayer.PlayerGui.MinigameInGameApp.Enabled then
        localPlayer.PlayerGui.MinigameInGameApp:WaitForChild('Body')
        localPlayer.PlayerGui.MinigameInGameApp.Body:WaitForChild('Middle')
        localPlayer.PlayerGui.MinigameInGameApp.Body.Middle:WaitForChild('Container')
        localPlayer.PlayerGui.MinigameInGameApp.Body.Middle.Container:WaitForChild('TitleLabel')

        if localPlayer.PlayerGui.MinigameInGameApp.Body.Middle.Container.TitleLabel.Text:match('SAKURA SWOOP') then
            if getgenv().SETTINGS.EVENT and getgenv().SETTINGS.EVENT.DO_MINIGAME then
                isInMiniGame = true

                task.wait(2)
                Spring2025.StartSakuraSwoop()
            end
        elseif localPlayer.PlayerGui.MinigameInGameApp.Body.Middle.Container.TitleLabel.Text:match('TEAR UP TOYKYO') then
            if getgenv().SETTINGS.EVENT and getgenv().SETTINGS.EVENT.DO_MINIGAME then
                isInMiniGame = true

                task.wait(math.random(10, 15))
                Spring2025.StartTearUpToykyo()
            end
        end
    end
end)
localPlayer.PlayerGui.DialogApp.Dialog.ChildAdded:Connect(function(
    NormalDialogChild
)
    if NormalDialogChild.Name == 'NormalDialog' then
        NormalDialogChild:GetPropertyChangedSignal('Visible'):Connect(function()
            if NormalDialogChild.Visible then
                NormalDialogChild:WaitForChild('Info')
                NormalDialogChild.Info:WaitForChild('TextLabel')
                NormalDialogChild.Info.TextLabel:GetPropertyChangedSignal('Text'):Connect(function(
                )
                    if localPlayer.PlayerGui.DialogApp.Dialog.NormalDialog.Info.TextLabel.Text:match('Sakura Swoop') then
                        onTextChangedMiniGame()
                    elseif localPlayer.PlayerGui.DialogApp.Dialog.NormalDialog.Info.TextLabel.Text:match('Tear Up Toykyo') then
                        onTextChangedMiniGame()
                    elseif localPlayer.PlayerGui.DialogApp.Dialog.NormalDialog.Info.TextLabel.Text:match('invitation') then
                        game:Shutdown()
                    elseif localPlayer.PlayerGui.DialogApp.Dialog.NormalDialog.Info.TextLabel.Text:match('You found a') then
                        findButton('Okay')
                    end
                end)
            end
        end)
    end
end)
localPlayer.PlayerGui.DialogApp.Dialog.NormalDialog:GetPropertyChangedSignal('Visible'):Connect(function(
)
    if localPlayer.PlayerGui.DialogApp.Dialog.NormalDialog.Visible then
        localPlayer.PlayerGui.DialogApp.Dialog.NormalDialog:WaitForChild('Info')
        localPlayer.PlayerGui.DialogApp.Dialog.NormalDialog.Info:WaitForChild('TextLabel')
        localPlayer.PlayerGui.DialogApp.Dialog.NormalDialog.Info.TextLabel:GetPropertyChangedSignal('Text'):Connect(function(
        )
            if localPlayer.PlayerGui.DialogApp.Dialog.NormalDialog.Info.TextLabel.Text:match('Sakura Swoop') then
                onTextChangedMiniGame()
            elseif localPlayer.PlayerGui.DialogApp.Dialog.NormalDialog.Info.TextLabel.Text:match('Tear Up Toykyo') then
                onTextChangedMiniGame()
            elseif localPlayer.PlayerGui.DialogApp.Dialog.NormalDialog.Info.TextLabel.Text:match('invitation') then
                game:Shutdown()
            elseif localPlayer.PlayerGui.DialogApp.Dialog.NormalDialog.Info.TextLabel.Text:match('You found a') then
                findButton('Okay')
            end
        end)
    end
end)
localPlayer.PlayerGui.MinigameRewardsApp.Body:GetPropertyChangedSignal('Visible'):Connect(function(
)
    if localPlayer.PlayerGui.MinigameRewardsApp.Body.Visible then
        localPlayer.PlayerGui.MinigameRewardsApp.Body:WaitForChild('Button')
        localPlayer.PlayerGui.MinigameRewardsApp.Body.Button:WaitForChild('Face')
        localPlayer.PlayerGui.MinigameRewardsApp.Body.Button.Face:WaitForChild('TextLabel')
        localPlayer.PlayerGui.MinigameRewardsApp.Body:WaitForChild('Reward')
        localPlayer.PlayerGui.MinigameRewardsApp.Body.Reward:WaitForChild('TitleLabel')

        if localPlayer.PlayerGui.MinigameRewardsApp.Body.Button.Face.TextLabel.Text:match('NICE!') then
            localPlayer.Character.HumanoidRootPart.Anchored = false

            task.wait(10)
            removeGameOverButton('MinigameRewardsApp')

            isInMiniGame = false

            Teleport.DownloadMainMap()
            Spring2025.Teleport()
        end
    end
end)
localPlayer.PlayerGui.MinigameNewsPaperApp.Body:GetPropertyChangedSignal('Visible'):Connect(function(
)
    if localPlayer.PlayerGui.MinigameNewsPaperApp.Body.Visible then
        localPlayer.PlayerGui.MinigameNewsPaperApp.Body:WaitForChild('Button')
        localPlayer.PlayerGui.MinigameNewsPaperApp.Body.Button:WaitForChild('Face')
        localPlayer.PlayerGui.MinigameNewsPaperApp.Body.Button.Face:WaitForChild('TextLabel')

        if localPlayer.PlayerGui.MinigameNewsPaperApp.Body.Button.Face.TextLabel.Text:match('NICE!') then
            localPlayer.Character.HumanoidRootPart.Anchored = false

            task.wait(10)
            removeGameOverButton('MinigameNewsPaperApp')

            isInMiniGame = false

            Teleport.DownloadMainMap()
            Spring2025.Teleport()
        end
    end
end)
localPlayer.PlayerGui.BattlePassApp.Body:GetPropertyChangedSignal('Visible'):Connect(function(
)
    if localPlayer.PlayerGui.BattlePassApp.Body.Visible then
        localPlayer.PlayerGui.BattlePassApp.Body:WaitForChild('InnerBody')
        localPlayer.PlayerGui.BattlePassApp.Body.InnerBody:WaitForChild('ScrollingFrame')
        localPlayer.PlayerGui.BattlePassApp.Body.InnerBody.ScrollingFrame:WaitForChild('21')

        if localPlayer.PlayerGui.BattlePassApp.Body.InnerBody.ScrollingFrame[21] then
            for _, v in localPlayer.PlayerGui.BattlePassApp.Body.InnerBody.ScrollingFrame:GetChildren()do
                if not v:FindFirstChild('ButtonFrame') then
                    continue
                end
                if v.ButtonFrame:FindFirstChild('ClaimButton') then
                end
            end
        end
    end
end)
localPlayer.Idled:Connect(function()
    VirtualUser:ClickButton2(Vector2.new())
end)

repeat
    task.wait(1)
until localPlayer.PlayerGui.NewsApp.Enabled or localPlayer.Character

PotatoMode.Start()
StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Captures, false)

UserGameSettings.GraphicsQualityLevel = 1
UserGameSettings.MasterVolume = 0

for i, v in debug.getupvalue(RouterClient.init, 7)do
    v.Name = i
end

setfpscap(getgenv().SETTINGS.SET_FPS)
Misc.DebugModePrint(string.format('SET FPS TO %s', tostring(getgenv().SETTINGS.SET_FPS)))
StatsGuis2:CopyInventoryButton({
    callback = function()
        clipboard:CopyAllInventory()
    end,
})

if localPlayer.PlayerGui.NewsApp.Enabled then
    Misc.DebugModePrint('NEWSAPP ENABLED')

    local AbsPlay = localPlayer.PlayerGui.NewsApp:WaitForChild('EnclosingFrame'):WaitForChild('MainFrame'):WaitForChild('Buttons'):WaitForChild('PlayButton')

    fireButton(AbsPlay)
    Misc.DebugModePrint('NEWSAPP CLICKED')
end
if localPlayer.PlayerGui.DialogApp.Dialog.ThemeColorDialog.Visible then
    Misc.DebugModePrint('picking color')

    newAccount = true

    pickColorTutorial()

    if PickColorConn then
        PickColorConn:Disconnect()

        PickColorConn = nil
    end
end
if localPlayer.PlayerGui.DialogApp.Dialog.RoleChooserDialog.Visible then
    task.wait(1)
    firesignal(localPlayer.PlayerGui.DialogApp.Dialog.RoleChooserDialog.Baby.MouseButton1Click)

    if RoleChooserDialogConnection then
        RoleChooserDialogConnection:Disconnect()

        RoleChooserDialogConnection = nil
    end
end
if not localPlayer.Character then
    Misc.DebugModePrint('NO CHARACTER SO WAITING')
    localPlayer.CharacterAdded:Wait()
end

task.wait(10)

if not ClientData.get_data()[localPlayer.Name].boolean_flags.tutorial_v3_completed and not ClientData.get_data()[localPlayer.Name].tutorial_manager.completed then
    Misc.DebugModePrint('new alt detected. doing tutorial')
    doStarterTutorial()
end
if localPlayer.PlayerGui.DialogApp.Dialog.NormalDialog.Visible then
    if localPlayer.PlayerGui.DialogApp.Dialog.NormalDialog.Info.TextLabel.Text:match('4.5%% Legendary') then
        task.wait(1)
        findButton('Okay')
    end
end

startTime = DateTime.now().UnixTimestamp
startPotionAmount = agePotionCount('pet_age_potion')
startTinyPotionAmount = agePotionCount('tiny_pet_age_potion')
startEventCurrencyAmount = eventCurrencyAmount()

StatsGuis2:UpdateTextFor('TimeLabel', startTime)
TempPotions:UpdateTextFor('TempPotions', potionsGained)
TempTinyPotions:UpdateTextFor('TempTinyPotions', tinyPotionsGained)
TempBucks:UpdateTextFor('TempBucks', bucksGained)
TempEventCurrency:UpdateTextFor('TempEventCurrency', eventCurrencyGained)
TotalEventCurrency:UpdateTextFor('TotalEventCurrency')
TotalPotions:UpdateTextFor('TotalPotions')
TotalTinyPotions:UpdateTextFor('TotalTinyPotions')
TotalBucks:UpdateTextFor('TotalBucks')
BlankSlot1:UpdateTextFor('BlankSlot1')
BlankSlot2:UpdateTextFor('BlankSlot2')
TotalShiverBaits:UpdateTextFor('TotalShiverBaits')
TotalSubzeroBaits:UpdateTextFor('TotalSubzeroBaits')
findFurniture()

if not Bed then
    buyFurniture('basiccrib')
end

task.wait(1)

if not Piano then
    buyFurniture('piano')
end

task.wait(1)

if not LitterBox then
    buyFurniture('ailments_refresh_2024_litter_box')
end

task.wait(1)

if not NormalLure then
    buyFurniture('lures_2023_normal_lure')
end

task.wait(1)

baitUnique = findBait()

Misc.DebugModePrint(string.format('\u{1f36a} Found baitUnique: %s \u{1f36a}', tostring(baitUnique)))
placeBaitOrPickUp(baitUnique)
task.wait(1)
placeBaitOrPickUp(baitUnique)

strollerId = GetInventory:GetUniqueId('strollers', 'stroller-default')

findFurniture()
Misc.DebugModePrint(string.format('Has Bed: %s \u{1f6cf}\u{fe0f} | Has Piano: %s \u{1f3b9} | Has LitterBox: %s \u{1f4a9} | Has Lure: %s', tostring(Bed), tostring(Piano), tostring(LitterBox), tostring(NormalLure)))
ReplicatedStorage:WaitForChild('API'):WaitForChild('HousingAPI/SetDoorLocked'):InvokeServer(true)

if not localPlayer.Character then
    Misc.DebugModePrint('NO CHARACTER SO WAITING')
    localPlayer.CharacterAdded:Wait()
end
if localPlayer.Character:WaitForChild('HumanoidRootPart') then
    ReplicatedStorage.API['TeamAPI/ChooseTeam']:InvokeServer('Babies', {
        ['dont_send_back_home'] = true,
    })
    task.wait(1)
end
if ClientData.get('pet_char_wrappers') then
    Misc.DebugModePrint('Un Equip Pet')

    if Misc.WaitForPetToEquip() then
        ReplicatedStorage.API['ToolAPI/Unequip']:InvokeServer(ClientData.get('pet_char_wrappers')[1].pet_unique, {})
        task.wait(1)

        if ClientData.get('pet_char_wrappers')[1] then
            ReplicatedStorage.API['ToolAPI/Unequip']:InvokeServer(ClientData.get('pet_char_wrappers')[1].pet_unique, {})
            task.wait(1)
        end
    end
end

Teleport.PlaceFloorAtFarmingHome()
Teleport.PlaceFloorAtCampSite()
Teleport.PlaceFloorAtBeachParty()

local queueOnTeleport = (syn and syn.queue_on_teleport) or queue_on_teleport or (fluxus and fluxus.queue_on_teleport)

if queueOnTeleport then
    queueOnTeleport('\r\n\t\trepeat task.wait() until game:IsLoaded()\r\n\t\tgame:Shutdown()\r\n\t')
end

dailyLoginAppClick()

if getgenv().BUY_BEFORE_FARMING then
    getgenv().isBuyingOrAging = true

    BuyItems:StartBuyItems(getgenv().BUY_BEFORE_FARMING)
end
if getgenv().OPEN_ITEMS_BEFORE_FARMING then
    getgenv().isBuyingOrAging = true

    BuyItems:OpenItems(getgenv().OPEN_ITEMS_BEFORE_FARMING)
end
if getgenv().AGE_PETS_BEFORE_FARMING then
    getgenv().isBuyingOrAging = true

    local bulkPotions = BulkPotions.new()

    bulkPotions:SetEggTable(GetInventory:GetPetEggs())
    bulkPotions:StartAgingPets(getgenv().AGE_PETS_BEFORE_FARMING)
    Misc.DebugModePrint('DONE aging pets')
end
if getgenv().SETTINGS.PET_AUTO_FUSION then
    Fusion:MakeMega(false)
    Fusion:MakeMega(true)
end

getgenv().isBuyingOrAging = false

if isMuleInGame() then
    Trade:TradeCollector(getgenv().SETTINGS.TRADE_COLLECTOR_NAME)
end
if DailyClaimConnection then
    DailyClaimConnection:Disconnect()

    DailyClaimConnection = nil
end
if Players.LocalPlayer.Name == getgenv().SETTINGS.TRADE_COLLECTOR_NAME and getgenv().SETTINGS.ENABLE_TRADE_COLLECTOR == true then
    getgenv().AutoTradeToggle:Set(true)
end

task.wait(2)

isProHandler = ClientData.get_data()[localPlayer.Name].subscription_manager.equip_2x_pets.active and true or false

Misc.DebugModePrint(string.format('Does it have Pro Handler Certificate?: %s', tostring(isProHandler)))

if not isProHandler then
    if not table.find(getgenv().SETTINGS.TRADE_COLLECTOR_NAME, localPlayer.Name) then
        Misc.DebugModePrint('Checking inventory to see if it has Pro Handler Certificate')

        local proHandlerCert = GetInventory:GetUniqueId('gifts', 'subscription_2024_2x_pet_certificate')

        if proHandlerCert then
            ReplicatedStorage.API['ToolAPI/ServerUseTool']:FireServer(proHandlerCert, 'END', true)
            task.wait(1)

            isProHandler = ClientData.get_data()[localPlayer.Name].subscription_manager.equip_2x_pets.active and true or false

            Misc.DebugModePrint(string.format('Does it have Pro Handler Certificate now?: %s', tostring(isProHandler)))
        end
    end
end

startAutoFarm()

local Window = Rayfield:CreateWindow({
    Name = localPlayer.Name,
    Theme = 'Default',
    DisableRayfieldPrompts = true,
    DisableBuildWarnings = true,
    LoadingTitle = 'Rayfield Interface Suite',
    LoadingSubtitle = 'by Sirius',
    ConfigurationSaving = {
        Enabled = false,
        FolderName = nil,
        FileName = 'Big Hub',
    },
    Discord = {
        Enabled = false,
        Invite = 'noinvitelink',
        RememberJoins = true,
    },
    KeySystem = false,
    KeySettings = {
        Title = 'Untitled',
        Subtitle = 'Key System',
        Note = 'No method of obtaining the key is provided',
        FileName = 'Key',
        SaveKey = false,
        GrabKeyFromSite = false,
        Key = {
            'Hello',
        },
    },
})
local FarmTab = Window:CreateTab('Misc', 4483362458)

FarmTab:CreateButton({
    Name = 'Copy All Inventory to clipboard',
    Callback = function()
        clipboard:CopyAllInventory()
    end,
})
FarmTab:CreateButton({
    Name = 'Detailed Pet Inventory clipboard',
    Callback = function()
        clipboard:CopyPetInfo()
    end,
})
FarmTab:CreateSection('1 Click = ALL Neon/Mega')
FarmTab:CreateButton({
    Name = 'Make Neons',
    Callback = function()
        Fusion:MakeMega(false)
    end,
})
FarmTab:CreateButton({
    Name = 'Make Megas',
    Callback = function()
        Fusion:MakeMega(true)
    end,
})

local TradeTab = Window:CreateTab('Auto Trade', 4483362458)

TradeTab:CreateSection('only enable Auto Accept trade on alt getting the items')

getgenv().AutoTradeToggle = TradeTab:CreateToggle({
    Name = 'Auto Accept Trade',
    CurrentValue = false,
    Flag = 'Toggle1',
    Callback = function(Value)
        getgenv().auto_accept_trade = Value

        if getgenv().auto_accept_trade then
            Rayfield:SetVisibility(false)
            task.wait(1)
        end

        while getgenv().auto_accept_trade do
            Trade:AutoAcceptTrade()
            ClickTradeWindowPopUps()
            task.wait(1)
        end
    end,
})

local playerDropdown = TradeTab:CreateDropdown({
    Name = 'Select a player',
    Options = getPlayersInGame(),
    CurrentOption = {
        '',
    },
    MultipleOptions = false,
    Flag = 'Dropdown1',
    Callback = function(Option)
        selectedPlayer = Option[1]
    end,
})

TradeTab:CreateButton({
    Name = 'Refesh player list',
    Callback = function()
        local playersTable = getPlayersInGame()

        playerDropdown:Refresh(playersTable)
    end,
})
TradeTab:CreateToggle({
    Name = 'Send player Trade',
    CurrentValue = false,
    Flag = 'Toggle1',
    Callback = function(Value)
        getgenv().auto_trade_semi_auto = Value

        while getgenv().auto_trade_semi_auto do
            Trade:SendTradeRequest({selectedPlayer})
            task.wait(1)
        end
    end,
})
TradeTab:CreateToggle({
    Name = 'Semi-Auto Trade (manually choose items)',
    CurrentValue = false,
    Flag = 'Toggle1',
    Callback = function(Value)
        getgenv().auto_trade_semi_auto = Value
    end,
})

TradeAllInventory = TradeTab:CreateToggle({
    Name = 'Auto Trade EVERYTHING',
    CurrentValue = false,
    Flag = 'Toggle1',
    Callback = function(Value)
        getgenv().auto_trade_all_inventory = Value

        while getgenv().auto_trade_all_inventory do
            Trade:SendTradeRequest({selectedPlayer})
            Trade:AllInventory('pets')
            Trade:AllInventory('pet_accessories')
            Trade:AllInventory('strollers')
            Trade:AllInventory('food')
            Trade:AllInventory('transport')
            Trade:AllInventory('toys')
            Trade:AllInventory('gifts')

            local hasPets = Trade:AcceptNegotiationAndConfirm()

            if not hasPets then
                TradeAllInventory:Set(false)
            end

            task.wait()
        end
    end,
})
AllPetsToggle = TradeTab:CreateToggle({
    Name = 'Auto Trade All Pets',
    CurrentValue = false,
    Flag = 'Toggle1',
    Callback = function(Value)
        getgenv().auto_trade_all_pets = Value

        while getgenv().auto_trade_all_pets do
            Trade:SendTradeRequest({selectedPlayer})
            Trade:AllPets()

            local hasPets = Trade:AcceptNegotiationAndConfirm()

            if not hasPets then
                AllPetsToggle:Set(false)
            end

            task.wait()
        end
    end,
})
AnyNeonToggle = TradeTab:CreateToggle({
    Name = 'FullGrown, Newborn to luminous Neons and Megas',
    CurrentValue = false,
    Flag = 'Toggle1',
    Callback = function(Value)
        getgenv().auto_trade_fullgrown_neon_and_mega = Value

        while getgenv().auto_trade_fullgrown_neon_and_mega do
            Trade:SendTradeRequest({selectedPlayer})
            Trade:FullgrownAndAnyNeonsAndMegas()

            local hasPets = Trade:AcceptNegotiationAndConfirm()

            if not hasPets then
                AnyNeonToggle:Set(false)
            end

            task.wait()
        end
    end,
})
LegendaryToggle = TradeTab:CreateToggle({
    Name = "Auto Trade Only Legendary's",
    CurrentValue = false,
    Flag = 'Toggle1',
    Callback = function(Value)
        getgenv().auto_trade_Legendary = Value

        while getgenv().auto_trade_Legendary do
            Trade:SendTradeRequest({selectedPlayer})
            Trade:AllPetsOfSameRarity('legendary')

            local hasPets = Trade:AcceptNegotiationAndConfirm()

            if not hasPets then
                LegendaryToggle:Set(false)
            end

            task.wait()
        end
    end,
})
FullgrownToggle = TradeTab:CreateToggle({
    Name = 'Auto Trade FullGrown, luminous Neons and Megas',
    CurrentValue = false,
    Flag = 'Toggle1',
    Callback = function(Value)
        getgenv().auto_trade_fullgrown_neon_and_mega = Value

        while getgenv().auto_trade_fullgrown_neon_and_mega do
            Trade:SendTradeRequest({selectedPlayer})
            Trade:Fullgrown()

            local hasPets = Trade:AcceptNegotiationAndConfirm()

            if not hasPets then
                FullgrownToggle:Set(false)
            end

            task.wait()
        end
    end,
})
TradeAllMegas = TradeTab:CreateToggle({
    Name = 'Auto Trade All Megas',
    CurrentValue = false,
    Flag = 'Toggle1',
    Callback = function(Value)
        getgenv().auto_trade_all_neons = Value

        while getgenv().auto_trade_all_neons do
            Trade:SendTradeRequest({selectedPlayer})
            Trade:AllNeons('mega_neon')

            local hasPets = Trade:AcceptNegotiationAndConfirm()

            if not hasPets then
                TradeAllMegas:Set(false)
            end

            task.wait()
        end
    end,
})
TradeAllNeons = TradeTab:CreateToggle({
    Name = 'Auto Trade All Neons',
    CurrentValue = false,
    Flag = 'Toggle1',
    Callback = function(Value)
        getgenv().auto_trade_all_neons = Value

        while getgenv().auto_trade_all_neons do
            Trade:SendTradeRequest({selectedPlayer})
            Trade:AllNeons('neon')

            local hasPets = Trade:AcceptNegotiationAndConfirm()

            if not hasPets then
                TradeAllNeons:Set(false)
            end

            task.wait()
        end
    end,
})
LowTierToggle = TradeTab:CreateToggle({
    Name = 'Auto Trade Common to Ultra-rare and Newborn to Post-Teen',
    CurrentValue = false,
    Flag = 'Toggle1',
    Callback = function(Value)
        getgenv().auto_trade_lowtier_pets = Value

        while getgenv().auto_trade_lowtier_pets do
            if selectedPlayer then
                Trade:SendTradeRequest({selectedPlayer})
            end

            Trade:LowTiers()

            local hasPets = Trade:AcceptNegotiationAndConfirm()

            if not hasPets then
                LowTierToggle:Set(false)
            end

            task.wait()
        end
    end,
})
RarityToggle = TradeTab:CreateToggle({
    Name = 'Auto Trade Legendary Newborn to Post-Teen',
    CurrentValue = false,
    Flag = 'Toggle1',
    Callback = function(Value)
        getgenv().auto_trade_rarity_pets = Value

        while getgenv().auto_trade_rarity_pets do
            if selectedPlayer then
                Trade:SendTradeRequest({selectedPlayer})
            end

            Trade:NewbornToPostteen('legendary')

            local hasPets = Trade:AcceptNegotiationAndConfirm()

            if not hasPets then
                RarityToggle:Set(false)
            end

            task.wait()
        end
    end,
})

TradeTab:CreateSection('Multiple Choice')

local petRarityDropdown = TradeTab:CreateDropdown({
    Name = 'Select rarity(s)',
    Options = petRaritys,
    CurrentOption = {},
    MultipleOptions = true,
    Flag = 'Dropdown1',
    Callback = function(Options)
        multipleOptionsTable['rarity'] = Options
    end,
})
local petAgeDropdown = TradeTab:CreateDropdown({
    Name = 'Select pet age(s)',
    Options = petAges,
    CurrentOption = {},
    MultipleOptions = true,
    Flag = 'Dropdown1',
    Callback = function(Options)
        multipleOptionsTable['ages'] = Options
    end,
})
local petNeonDropdown = TradeTab:CreateDropdown({
    Name = 'Select pet normal or neon/mega',
    Options = petNeons,
    CurrentOption = {},
    MultipleOptions = true,
    Flag = 'Dropdown1',
    Callback = function(Options)
        multipleOptionsTable['neons'] = Options
    end,
})

MultipleChoiceToggle = TradeTab:CreateToggle({
    Name = 'START trading multi-choice pets',
    CurrentValue = false,
    Flag = 'Toggle1',
    Callback = function(Value)
        getgenv().auto_trade_multi_choice = Value

        if getgenv().auto_trade_multi_choice then
            if #multipleOptionsTable['rarity'] == 0 then
                MultipleChoiceToggle:Set(false)

                return Misc.DebugModePrint('\u{1f6d1} didnt select any rarity')
            end
            if #multipleOptionsTable['ages'] == 0 then
                MultipleChoiceToggle:Set(false)

                return Misc.DebugModePrint('\u{1f6d1} didnt select any ages')
            end
            if #multipleOptionsTable['neons'] == 0 then
                MultipleChoiceToggle:Set(false)

                return Misc.DebugModePrint('\u{1f6d1} didnt select normal or neon or mega_neon')
            end
        end

        while getgenv().auto_trade_multi_choice do
            if not Trade:SendTradeRequest({selectedPlayer}) then
                print('\u{26a0}\u{fe0f} PLAYER YOU WERE TRADING LEFT GAME \u{26a0}\u{fe0f}')
                MultipleChoiceToggle:Set(false)

                return
            end

            Trade:MultipleOptions(multipleOptionsTable)

            local hasPets = Trade:AcceptNegotiationAndConfirm()

            if not hasPets then
                MultipleChoiceToggle:Set(false)
            end

            task.wait()
        end

        petRarityDropdown:Set({
            '',
        })
        petAgeDropdown:Set({
            '',
        })
        petNeonDropdown:Set({
            '',
        })

        return
    end,
})

TradeTab:CreateSection('Send Custom Pet, sends ALL ages of selected pet')

local petsDropdown = TradeTab:CreateDropdown({
    Name = 'Select a Pet',
    Options = petsTable,
    CurrentOption = {
        petsTable[1],
    },
    MultipleOptions = false,
    Flag = 'Dropdown1',
    Callback = function(Option)
        selectedPet = Option[1] or 'Nothing'
    end,
})

TradeTab:CreateButton({
    Name = 'Refesh Pet list',
    Callback = function()
        petsDropdown:Set(GetInventory:TabId('pets'))
    end,
})

PetToggle = TradeTab:CreateToggle({
    Name = 'Auto Trade Selected Pet',
    CurrentValue = false,
    Flag = 'Toggle1',
    Callback = function(Value)
        getgenv().auto_trade_custom = Value

        while getgenv().auto_trade_custom do
            Trade:SendTradeRequest({selectedPlayer})
            Trade:SelectTabAndTrade('pets', selectedPet)

            local hasPets = Trade:AcceptNegotiationAndConfirm()

            if not hasPets then
                PetToggle:Set(false)
            end

            task.wait()
        end
    end,
})

TradeTab:CreateSection(' ')

local giftsDropdown = TradeTab:CreateDropdown({
    Name = 'Select gift',
    Options = giftsTable,
    CurrentOption = {
        giftsTable[1],
    },
    MultipleOptions = false,
    Flag = 'Dropdown1',
    Callback = function(Option)
        selectedGift = Option[1] or 'Nothing'
    end,
})

TradeTab:CreateButton({
    Name = 'Refesh Gift list',
    Callback = function()
        giftsDropdown:Set(GetInventory:TabId('gifts'))
    end,
})

GiftToggle = TradeTab:CreateToggle({
    Name = 'Auto Trade Custom Gift',
    CurrentValue = false,
    Flag = 'Toggle1',
    Callback = function(Value)
        getgenv().auto_trade_custom = Value

        while getgenv().auto_trade_custom do
            Trade:SendTradeRequest({selectedPlayer})
            Trade:SelectTabAndTrade('gifts', selectedGift)

            local hasPets = Trade:AcceptNegotiationAndConfirm()

            if not hasPets then
                GiftToggle:Set(false)
            end

            task.wait()
        end
    end,
})

TradeTab:CreateSection(' ')

local toysDropdown = TradeTab:CreateDropdown({
    Name = 'Select toys',
    Options = toysTable,
    CurrentOption = {
        toysTable[1],
    },
    MultipleOptions = false,
    Flag = 'Dropdown1',
    Callback = function(Option)
        selectedToy = Option[1] or 'Nothing'
    end,
})

TradeTab:CreateButton({
    Name = 'Refesh Toy list',
    Callback = function()
        toysDropdown:Set(GetInventory:TabId('toys'))
    end,
})

ToyToggle = TradeTab:CreateToggle({
    Name = 'Auto Trade Custom Toy',
    CurrentValue = false,
    Flag = 'Toggle1',
    Callback = function(Value)
        getgenv().auto_trade_custom = Value

        while getgenv().auto_trade_custom do
            Trade:SendTradeRequest({selectedPlayer})
            Trade:SelectTabAndTrade('toys', selectedToy)

            local hasPets = Trade:AcceptNegotiationAndConfirm()

            if not hasPets then
                ToyToggle:Set(false)
            end

            task.wait()
        end
    end,
})

TradeTab:CreateSection(' ')

local foodDropdown = TradeTab:CreateDropdown({
    Name = 'Select food',
    Options = foodTable,
    CurrentOption = {
        foodTable[1],
    },
    MultipleOptions = false,
    Flag = 'Dropdown1',
    Callback = function(Option)
        selectedFood = Option[1] or 'Nothing'
    end,
})

TradeTab:CreateButton({
    Name = 'Refesh Food list',
    Callback = function()
        foodDropdown:Set(GetInventory:TabId('food'))
    end,
})

FoodToggle = TradeTab:CreateToggle({
    Name = 'Auto Trade Custom Food',
    CurrentValue = false,
    Flag = 'Toggle1',
    Callback = function(Value)
        getgenv().auto_trade_custom = Value

        while getgenv().auto_trade_custom do
            Trade:SendTradeRequest({selectedPlayer})
            Trade:SelectTabAndTrade('food', selectedFood)

            local hasPets = Trade:AcceptNegotiationAndConfirm()

            if not hasPets then
                FoodToggle:Set(false)
            end

            task.wait()
        end
    end,
})

local NewAltTab = Window:CreateTab('New Alts', 4483362458)

NewAltTab:CreateButton({
    Name = 'Complete Starter Tutorial',
    Callback = function()
        Tutorials.CompleteStarterTutorial()
    end,
})
NewAltTab:CreateButton({
    Name = 'Get Trade License',
    Callback = function()
        TradeLicense.Get(ClientData, localPlayer.Name)
    end,
})
NewAltTab:CreateButton({
    Name = 'Buy Basic Crib',
    Callback = function()
        buyFurniture('basiccrib')
    end,
})
Rayfield:SetVisibility(false)
Misc.DebugModePrint('Loaded. lastest update 2/25/2025  mm/dd/yyyy')
