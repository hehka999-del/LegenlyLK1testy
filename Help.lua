--[[
==============================================================
          HUB - Troll & Universal
       Premium Visual Overhaul v10.0
                   by Legenly
==============================================================

PRESERVED ORIGINAL FEATURES
• EgorSpeed
• FakeLag FPS
• FakeLag Network
• Spin
• Spin Speed
• Spam Sword
• Arm Speed
• Target selector
• Unified Fling
• Freeze / Unfreeze
• Spin Target
• Teleport to Target
• Loop Kill
• Gang Back / Front
• Victim
• God Mode
• Noclip
• Fly
• Fly Speed
• Kill Aura
• Aura Range
• Chat Spam
• Stop All
• Themes
• RU / EN
• Discord info

VISUAL OVERHAUL
• LGK & Kick style
• Logo: rbxassetid://125281744611585
• Window background: rbxassetid://118369774163238
• Animated splash
• Mobile responsive window
• Touch + mouse drag
• Top-centered Dynamic Island
• Smooth minimize / restore
• Modern cards / toggles / sliders
• Improved target selector
==============================================================
]]

if not game:IsLoaded() then
    game.Loaded:Wait()
end

--==============================================================
-- SERVICES
--==============================================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")
local TextChatService = game:GetService("TextChatService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Lighting = game:GetService("Lighting")

local LocalPlayer = Players.LocalPlayer

--==============================================================
-- ASSETS
--==============================================================

local LOGO = "rbxassetid://125281744611585"
local WINDOW_BACKGROUND = "rbxassetid://118369774163238"

--==============================================================
-- THEMES
--==============================================================

local Themes = {
    Red = {
        Accent = Color3.fromRGB(255, 72, 72),
        AccentSoft = Color3.fromRGB(125, 44, 44),
        Name = "Ruby Red"
    },

    Blue = {
        Accent = Color3.fromRGB(72, 150, 255),
        AccentSoft = Color3.fromRGB(48, 92, 148),
        Name = "Deep Blue"
    },

    Purple = {
        Accent = Color3.fromRGB(186, 76, 255),
        AccentSoft = Color3.fromRGB(108, 51, 145),
        Name = "Amethyst Purple"
    },

    Green = {
        Accent = Color3.fromRGB(67, 235, 122),
        AccentSoft = Color3.fromRGB(48, 127, 76),
        Name = "Acid Green"
    },

    Gold = {
        Accent = Color3.fromRGB(255, 192, 65),
        AccentSoft = Color3.fromRGB(143, 108, 45),
        Name = "Luxury Gold"
    }
}

local CurrentTheme = Themes.Red
local CurrentThemeKey = "Red"

local RecolorQueue = {}
local TextElements = {}

--==============================================================
-- TRANSLATIONS
--==============================================================

local CurrentLang = "RU"

local Translations = {
    RU = {
        Title = "HUB - Troll & Universal",
        Subtitle = "Premium Edition • Legenly",

        TabMain = "Главная",
        TabTroll = "Troll",
        TabTarget = "Цель",
        TabVisual = "Визуал",
        TabSettings = "Настройки",
        TabInfo = "Инфо",

        SecMove = "Движение & Лаги",
        EgorSpeed = "Скорость Roblox Егора",
        FakeLagFPS = "Фейк лаги [ФПС]",
        SetLagFPS = "Настройка лагов [ФПС]",
        FakeLagNet = "Фейк лаги [Интернет]",
        Spin = "Вращение",
        SpinSpeed = "Скорость вращения",

        SecTroll = "Троллинг",
        ArmSpeed = "Скорость руки",

        SecTarget = "Выбор жертвы",
        SelectPlr = "  Цель: Выберите игрока...",
        TargetInfo = "Информация о цели",
        TargetDistance = "Расстояние до цели",
        ClearTarget = "Сбросить цель",

        SecDestroy = "Действия цели",
        Fling = "FLING",
        Freeze = "Заморозить цель",
        Unfreeze = "Разморозить цель",
        SpinTarget = "Закрутить цель",
        TPTarget = "Телепорт к цели",
        LoopKill = "Зацикленный килл",
        SecTargetState = "Persistent target actions",

        SecSelf = "Собственные функции",
        GodMode = "God Mode",
        Noclip = "Noclip",
        Fly = "Fly",
        FlySpeed = "Скорость полета",
        KillAura = "Kill Aura",
        AuraRange = "Радиус Kill Aura",

        SecChat = "Чат",
        ChatSpam = "Спамер в чат",
        ChatText = "Текст сообщения",

        SecVisual = "Визуализация",
        FullBright = "FullBright",
        NoFog = "No Fog",
        FOV = "Поле зрения",

        SecInterface = "Интерфейс",
        WindowBackground = "Фон окна",
        SecTheme = "Оформление",
        ThemeRed = "Ruby Red",
        ThemeBlue = "Deep Blue",
        ThemePurple = "Amethyst Purple",
        ThemeGreen = "Acid Green",
        ThemeGold = "Luxury Gold",

        StopAll = "ОСТАНОВИТЬ ВСЕ ДЕЙСТВИЯ",

        InfoDev = "Автор и разработчик: Legenly",
        InfoName = "Проект: HUB - Troll & Universal",
        InfoVersion = "Premium UI v10.0",
        InfoAssets = "Логотип и фон LGK",
        InfoDiscord = "Discord канал",
        NotifSelected = "выбран в качестве цели!",
        NoTarget = "Сначала выберите цель",
        Stopped = "Все действия остановлены"
    },

    EN = {
        Title = "HUB - Troll & Universal",
        Subtitle = "Premium Edition • Legenly",

        TabMain = "Main",
        TabTroll = "Troll",
        TabTarget = "Target",
        TabVisual = "Visual",
        TabSettings = "Settings",
        TabInfo = "Info",

        SecMove = "Movement & Lag",
        EgorSpeed = "Roblox Egor Speed",
        FakeLagFPS = "Fake Lag [FPS]",
        SetLagFPS = "Lag Delay [FPS]",
        FakeLagNet = "Fake Lag [Network]",
        Spin = "Spin",
        SpinSpeed = "Spin Speed",

        SecTroll = "Troll Features",
        ArmSpeed = "Arm Speed",

        SecTarget = "Target Selector",
        SelectPlr = "  Target: Select player...",
        TargetInfo = "Target information",
        TargetDistance = "Distance to target",
        ClearTarget = "Clear target",

        SecDestroy = "Target Actions",
        Fling = "FLING",
        Freeze = "Freeze Target",
        Unfreeze = "Unfreeze Target",
        SpinTarget = "Spin Target",
        TPTarget = "Teleport to Target",
        LoopKill = "Loop Kill",
        SecTargetState = "Persistent target actions",

        SecSelf = "Self Utility",
        GodMode = "God Mode",
        Noclip = "Noclip",
        Fly = "Fly",
        FlySpeed = "Fly Speed",
        KillAura = "Kill Aura",
        AuraRange = "Kill Aura Range",

        SecChat = "Chat",
        ChatSpam = "Chat Spammer",
        ChatText = "Message text",

        SecVisual = "Visuals",
        FullBright = "FullBright",
        NoFog = "No Fog",
        FOV = "Field of view",

        SecInterface = "Interface",
        WindowBackground = "Window background",
        SecTheme = "Appearance",
        ThemeRed = "Ruby Red",
        ThemeBlue = "Deep Blue",
        ThemePurple = "Amethyst Purple",
        ThemeGreen = "Acid Green",
        ThemeGold = "Luxury Gold",

        StopAll = "STOP ALL ACTIONS",

        InfoDev = "Author & developer: Legenly",
        InfoName = "Project: HUB - Troll & Universal",
        InfoVersion = "Premium UI v10.0",
        InfoAssets = "LGK logo and background",
        InfoDiscord = "Discord channel",
        NotifSelected = "selected as target!",
        NoTarget = "Select a target first",
        Stopped = "All actions stopped"
    }
}

--==============================================================
-- ORIGINAL STATE — PRESERVED
--==============================================================

local TrollState = {
    EgorSpeed = false,
    FakeLagFPS = false,
    LagFPSValue = 10,

    FakeLagNet = false,

    Spin = false,
    SpinSpeed = 10,


    TargetPlayer = nil,

    FlingActive = false,


    ActiveFX = {},

    FreezeTarget = nil,
    FreezePos = nil,

    SpinTarget = nil,

    KillAura = false,
    KillAuraRange = 15,

    ChatSpam = false,
    ChatSpamText = "Legenly on top!",

    GodMode = false,

    Noclip = false,

    Fly = false,
    FlySpeed = 50,

    LoopKill = false,
    LoopKillTarget = nil,

    FullBright = false,
    NoFog = false,
    FOV = 70,
    ShowWindowBackground = false
}

--==============================================================
-- GUI ROOT
--==============================================================

local function getParent()
    if typeof(gethui) == "function" then
        local ok, result = pcall(gethui)
        if ok and result then
            return result
        end
    end

    return CoreGui
end

local GuiParent = getParent()

local old = GuiParent:FindFirstChild("LegenlyTrollHub_LGK")

if old then
    pcall(function()
        old:Destroy()
    end)
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "LegenlyTrollHub_LGK"
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = GuiParent

--==============================================================
-- UI HELPERS
--==============================================================

local function RegisterForRecolor(element, property, activeOnly)
    table.insert(RecolorQueue, function(newColor)
        if not element or not element.Parent then
            return false
        end

        local ok = pcall(function()
            if activeOnly then
                if element:GetAttribute("IsActiveTab") then
                    element[property] = newColor
                end
            else
                element[property] = newColor
            end
        end)

        return ok
    end)
end

local function RegisterText(element, key)
    table.insert(TextElements, {
        Element = element,
        Key = key
    })

    pcall(function()
        element.Text =
            Translations[CurrentLang][key]
            or element.Text
    end)
end

local function SwitchLanguage(lang)
    if not Translations[lang] then
        return
    end

    CurrentLang = lang

    for _, data in ipairs(TextElements) do
        if data.Element and data.Element.Parent then
            pcall(function()
                local value =
                    Translations[CurrentLang][data.Key]

                if value then
                    data.Element.Text = value
                end
            end)
        end
    end
end

local function ApplyTheme(themeKey)
    local theme = Themes[themeKey]
    if not theme then
        return
    end

    CurrentTheme = theme
    CurrentThemeKey = themeKey

    local newQueue = {}

    for _, fn in ipairs(RecolorQueue) do
        local ok, keep = pcall(fn, theme.Accent)

        if ok and keep ~= false then
            table.insert(newQueue, fn)
        end
    end

    RecolorQueue = newQueue
end

--==============================================================
-- NOTIFICATIONS
--==============================================================

local function Notify(title, message, color)
    color = color or CurrentTheme.Accent

    local frame = Instance.new("Frame")
    frame.AnchorPoint = Vector2.new(1, 1)
    frame.Position = UDim2.new(1, -16, 1, -16)
    frame.Size = UDim2.fromOffset(300, 74)
    frame.BackgroundColor3 = Color3.fromRGB(17, 17, 23)
    frame.BorderSizePixel = 0
    frame.BackgroundTransparency = 0.02
    frame.ZIndex = 5000
    frame.Parent = ScreenGui

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 14)
    corner.Parent = frame

    local stroke = Instance.new("UIStroke")
    stroke.Thickness = 1
    stroke.Transparency = 0.35
    stroke.Color = color
    stroke.Parent = frame

    local bar = Instance.new("Frame")
    bar.Size = UDim2.fromOffset(5, 58)
    bar.Position = UDim2.fromOffset(0, 8)
    bar.BackgroundColor3 = color
    bar.BorderSizePixel = 0
    bar.Parent = frame

    local barCorner = Instance.new("UICorner")
    barCorner.CornerRadius = UDim.new(1, 0)
    barCorner.Parent = bar

    local titleLabel = Instance.new("TextLabel")
    titleLabel.BackgroundTransparency = 1
    titleLabel.Position = UDim2.fromOffset(16, 10)
    titleLabel.Size = UDim2.new(1, -28, 0, 21)
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextSize = 13
    titleLabel.TextColor3 = Color3.fromRGB(255,255,255)
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.Text = tostring(title)
    titleLabel.Parent = frame

    local messageLabel = Instance.new("TextLabel")
    messageLabel.BackgroundTransparency = 1
    messageLabel.Position = UDim2.fromOffset(16, 33)
    messageLabel.Size = UDim2.new(1, -28, 0, 30)
    messageLabel.Font = Enum.Font.Gotham
    messageLabel.TextSize = 11
    messageLabel.TextColor3 = Color3.fromRGB(185,185,192)
    messageLabel.TextWrapped = true
    messageLabel.TextXAlignment = Enum.TextXAlignment.Left
    messageLabel.Text = tostring(message)
    messageLabel.Parent = frame

    frame.Position =
        UDim2.new(
            1,
            320,
            1,
            -16
        )

    TweenService:Create(
        frame,
        TweenInfo.new(
            0.30,
            Enum.EasingStyle.Quint,
            Enum.EasingDirection.Out
        ),
        {
            Position =
                UDim2.new(
                    1,
                    -16,
                    1,
                    -16
                )
        }
    ):Play()

    task.delay(3, function()
        if not frame.Parent then
            return
        end

        TweenService:Create(
            frame,
            TweenInfo.new(
                0.25,
                Enum.EasingStyle.Quint,
                Enum.EasingDirection.In
            ),
            {
                Position =
                    UDim2.new(
                        1,
                        320,
                        1,
                        -16
                    )
            }
        ):Play()

        task.wait(0.26)

        if frame.Parent then
            frame:Destroy()
        end
    end)
end

--==============================================================
-- SPLASH
--==============================================================

local Splash = Instance.new("Frame")
Splash.Size = UDim2.fromScale(1,1)
Splash.BackgroundColor3 = Color3.fromRGB(7,7,10)
Splash.BorderSizePixel = 0
Splash.ZIndex = 2000
Splash.Parent = ScreenGui

local SplashLogo = Instance.new("ImageLabel")
SplashLogo.AnchorPoint = Vector2.new(0.5,0.5)
SplashLogo.Position = UDim2.fromScale(0.5,0.32)
SplashLogo.Size = UDim2.fromOffset(110,110)
SplashLogo.BackgroundTransparency = 1
SplashLogo.Image = LOGO
SplashLogo.ImageTransparency = 1
SplashLogo.ZIndex = 2001
SplashLogo.Parent = Splash

local splashLogoCorner = Instance.new("UICorner")
splashLogoCorner.CornerRadius = UDim.new(0,26)
splashLogoCorner.Parent = SplashLogo

local SplashTitle = Instance.new("TextLabel")
SplashTitle.AnchorPoint = Vector2.new(0.5,0.5)
SplashTitle.Position = UDim2.fromScale(0.5,0.50)
SplashTitle.Size = UDim2.fromScale(0.78,0.075)
SplashTitle.BackgroundTransparency = 1
SplashTitle.Text = "HUB - Troll & Universal"
SplashTitle.Font = Enum.Font.GothamBold
SplashTitle.TextScaled = true
SplashTitle.TextColor3 = Color3.fromRGB(255,255,255)
SplashTitle.TextTransparency = 1
SplashTitle.ZIndex = 2001
SplashTitle.Parent = Splash

local SplashSub = Instance.new("TextLabel")
SplashSub.AnchorPoint = Vector2.new(0.5,0.5)
SplashSub.Position = UDim2.fromScale(0.5,0.565)
SplashSub.Size = UDim2.fromScale(0.66,0.04)
SplashSub.BackgroundTransparency = 1
SplashSub.Text = "Premium Edition • Legenly"
SplashSub.Font = Enum.Font.Gotham
SplashSub.TextScaled = true
SplashSub.TextColor3 = Color3.fromRGB(145,145,155)
SplashSub.TextTransparency = 1
SplashSub.ZIndex = 2001
SplashSub.Parent = Splash

local SplashStatus = Instance.new("TextLabel")
SplashStatus.AnchorPoint = Vector2.new(0.5,0.5)
SplashStatus.Position = UDim2.fromScale(0.5,0.635)
SplashStatus.Size = UDim2.fromScale(0.72,0.04)
SplashStatus.BackgroundTransparency = 1
SplashStatus.Text = ""
SplashStatus.Font = Enum.Font.Gotham
SplashStatus.TextScaled = true
SplashStatus.TextColor3 = CurrentTheme.Accent
SplashStatus.TextTransparency = 1
SplashStatus.ZIndex = 2001
SplashStatus.Parent = Splash

--==============================================================
-- MAIN WINDOW
--==============================================================

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.AnchorPoint = Vector2.new(0.5,0.5)
MainFrame.Position = UDim2.fromScale(0.5,0.5)
MainFrame.Size = UDim2.fromOffset(720,500)
MainFrame.BackgroundColor3 = Color3.fromRGB(10,10,15)
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.Visible = false
MainFrame.ZIndex = 100
MainFrame.Parent = ScreenGui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0,20)
mainCorner.Parent = MainFrame

local MainScale = Instance.new("UIScale")
MainScale.Scale = 0.84
MainScale.Parent = MainFrame

local MainBackground = Instance.new("ImageLabel")
MainBackground.Size = UDim2.fromScale(1,1)
MainBackground.BackgroundTransparency = 1
MainBackground.Image = WINDOW_BACKGROUND
MainBackground.ScaleType = Enum.ScaleType.Crop
MainBackground.ImageTransparency = 0.30
MainBackground.Visible = false
MainBackground.ZIndex = 101
MainBackground.Parent = MainFrame

local MainOverlay = Instance.new("Frame")
MainOverlay.Size = UDim2.fromScale(1,1)
MainOverlay.BackgroundColor3 = Color3.fromRGB(7,7,12)
MainOverlay.BackgroundTransparency = 0.50
MainOverlay.BorderSizePixel = 0
MainOverlay.ZIndex = 102
MainOverlay.Parent = MainFrame

--==============================================================
-- RESPONSIVE SIZE
--==============================================================

local function UpdateWindowSize()
    local camera = workspace.CurrentCamera
    if not camera then
        return
    end

    local viewport = camera.ViewportSize

    if UserInputService.TouchEnabled or viewport.X < 680 then
        MainFrame.Size =
            UDim2.fromOffset(
                math.clamp(viewport.X - 20, 300, 470),
                math.clamp(viewport.Y - 76, 420, 650)
            )
    else
        MainFrame.Size =
            UDim2.fromOffset(720,500)
    end
end

UpdateWindowSize()

if workspace.CurrentCamera then
    workspace.CurrentCamera:GetPropertyChangedSignal(
        "ViewportSize"
    ):Connect(UpdateWindowSize)
end

--==============================================================
-- HEADER
--==============================================================

local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1,0,0,62)
TitleBar.BackgroundColor3 = Color3.fromRGB(12,12,18)
TitleBar.BackgroundTransparency = 0.09
TitleBar.BorderSizePixel = 0
TitleBar.ZIndex = 110
TitleBar.Parent = MainFrame

local HeaderLine = Instance.new("Frame")
HeaderLine.Position = UDim2.new(0,0,1,-2)
HeaderLine.Size = UDim2.new(1,0,0,2)
HeaderLine.BackgroundColor3 = CurrentTheme.Accent
HeaderLine.BorderSizePixel = 0
HeaderLine.ZIndex = 113
HeaderLine.Parent = TitleBar
RegisterForRecolor(HeaderLine,"BackgroundColor3")

local HeaderLogo = Instance.new("ImageLabel")
HeaderLogo.Position = UDim2.fromOffset(12,9)
HeaderLogo.Size = UDim2.fromOffset(42,42)
HeaderLogo.BackgroundTransparency = 1
HeaderLogo.Image = LOGO
HeaderLogo.ZIndex = 112
HeaderLogo.Parent = TitleBar

local headerLogoCorner = Instance.new("UICorner")
headerLogoCorner.CornerRadius = UDim.new(0,12)
headerLogoCorner.Parent = HeaderLogo

local TitleText = Instance.new("TextLabel")
TitleText.BackgroundTransparency = 1
TitleText.Position = UDim2.fromOffset(66,7)
TitleText.Size = UDim2.new(1,-235,0,25)
TitleText.Font = Enum.Font.GothamBold
TitleText.TextSize = 18
TitleText.TextColor3 = CurrentTheme.Accent
TitleText.TextXAlignment = Enum.TextXAlignment.Left
TitleText.ZIndex = 112
RegisterText(TitleText,"Title")
RegisterForRecolor(TitleText,"TextColor3")
TitleText.Parent = TitleBar

local SubtitleText = Instance.new("TextLabel")
SubtitleText.BackgroundTransparency = 1
SubtitleText.Position = UDim2.fromOffset(67,33)
SubtitleText.Size = UDim2.new(1,-240,0,16)
SubtitleText.Font = Enum.Font.Gotham
SubtitleText.TextSize = 10
SubtitleText.TextColor3 = Color3.fromRGB(150,150,160)
SubtitleText.TextXAlignment = Enum.TextXAlignment.Left
SubtitleText.ZIndex = 112
RegisterText(SubtitleText,"Subtitle")
SubtitleText.Parent = TitleBar

local LangButton = Instance.new("TextButton")
LangButton.Size = UDim2.fromOffset(66,31)
LangButton.Position = UDim2.new(1,-113,0,15)
LangButton.BackgroundColor3 = Color3.fromRGB(28,28,35)
LangButton.BorderSizePixel = 0
LangButton.Text = "RU / EN"
LangButton.Font = Enum.Font.GothamBold
LangButton.TextSize = 10
LangButton.TextColor3 = Color3.fromRGB(225,225,230)
LangButton.AutoButtonColor = false
LangButton.ZIndex = 114
LangButton.Parent = TitleBar

local langCorner = Instance.new("UICorner")
langCorner.CornerRadius = UDim.new(0,9)
langCorner.Parent = LangButton

local StopButton = Instance.new("TextButton")
StopButton.Size = UDim2.fromOffset(46,31)
StopButton.Position = UDim2.new(1,-166,0,15)
StopButton.BackgroundColor3 = Color3.fromRGB(30,24,28)
StopButton.BorderSizePixel = 0
StopButton.Text = "STOP"
StopButton.Font = Enum.Font.GothamBold
StopButton.TextSize = 9
StopButton.TextColor3 = Color3.fromRGB(255,170,170)
StopButton.AutoButtonColor = false
StopButton.ZIndex = 114
StopButton.Parent = TitleBar

local stopCorner = Instance.new("UICorner")
stopCorner.CornerRadius = UDim.new(0,9)
stopCorner.Parent = StopButton

local stopStroke = Instance.new("UIStroke")
stopStroke.Thickness = 1
stopStroke.Transparency = 0.4
stopStroke.Color = Color3.fromRGB(255,80,80)
stopStroke.Parent = StopButton

local MinimizeButton = Instance.new("TextButton")
MinimizeButton.Size = UDim2.fromOffset(36,31)
MinimizeButton.Position = UDim2.new(1,-43,0,15)
MinimizeButton.BackgroundColor3 = Color3.fromRGB(28,28,35)
MinimizeButton.BorderSizePixel = 0
MinimizeButton.Text = "−"
MinimizeButton.Font = Enum.Font.GothamBold
MinimizeButton.TextSize = 18
MinimizeButton.TextColor3 = Color3.fromRGB(245,245,250)
MinimizeButton.AutoButtonColor = false
MinimizeButton.ZIndex = 114
MinimizeButton.Parent = TitleBar

local minCorner = Instance.new("UICorner")
minCorner.CornerRadius = UDim.new(0,9)
minCorner.Parent = MinimizeButton

--==============================================================
-- ISLAND
--==============================================================

local IslandFrame = Instance.new("Frame")
IslandFrame.Name = "IslandFrame"
IslandFrame.AnchorPoint = Vector2.new(0.5,0)
IslandFrame.Position = UDim2.fromScale(0.5,0.018)
IslandFrame.Size = UDim2.fromOffset(205,50)
IslandFrame.BackgroundColor3 = Color3.fromRGB(11,11,17)
IslandFrame.BorderSizePixel = 0
IslandFrame.Visible = false
IslandFrame.ZIndex = 700
IslandFrame.Parent = ScreenGui

local islandCorner = Instance.new("UICorner")
islandCorner.CornerRadius = UDim.new(1,0)
islandCorner.Parent = IslandFrame

local islandStroke = Instance.new("UIStroke")
islandStroke.Thickness = 1
islandStroke.Transparency = 0.2
islandStroke.Color = CurrentTheme.Accent
islandStroke.Parent = IslandFrame
RegisterForRecolor(islandStroke,"Color")

local IslandLogo = Instance.new("ImageLabel")
IslandLogo.Position = UDim2.fromOffset(6,5)
IslandLogo.Size = UDim2.fromOffset(40,40)
IslandLogo.BackgroundTransparency = 1
IslandLogo.Image = LOGO
IslandLogo.ZIndex = 701
IslandLogo.Parent = IslandFrame

local islandLogoCorner = Instance.new("UICorner")
islandLogoCorner.CornerRadius = UDim.new(0,10)
islandLogoCorner.Parent = IslandLogo

local IslandText = Instance.new("TextLabel")
IslandText.BackgroundTransparency = 1
IslandText.Position = UDim2.fromOffset(55,0)
IslandText.Size = UDim2.new(1,-65,1,0)
IslandText.Text = "Troll HUB"
IslandText.Font = Enum.Font.GothamBold
IslandText.TextSize = 17
IslandText.TextColor3 = Color3.fromRGB(255,255,255)
IslandText.TextXAlignment = Enum.TextXAlignment.Left
IslandText.ZIndex = 701
IslandText.Parent = IslandFrame

local IslandButton = Instance.new("TextButton")
IslandButton.Size = UDim2.fromScale(1,1)
IslandButton.BackgroundTransparency = 1
IslandButton.Text = ""
IslandButton.ZIndex = 702
IslandButton.Parent = IslandFrame

--==============================================================
-- BODY / SIDEBAR / PAGES
--==============================================================

local Body = Instance.new("Frame")
Body.Position = UDim2.fromOffset(0,62)
Body.Size = UDim2.new(1,0,1,-62)
Body.BackgroundTransparency = 1
Body.ZIndex = 104
Body.Parent = MainFrame

local Sidebar = Instance.new("Frame")
Sidebar.Position = UDim2.fromOffset(0,0)
Sidebar.Size = UDim2.new(0,155,1,0)
Sidebar.BackgroundColor3 = Color3.fromRGB(15,15,21)
Sidebar.BackgroundTransparency = 0.74
Sidebar.BorderSizePixel = 0
Sidebar.ZIndex = 105
Sidebar.Parent = Body

local sidePadding = Instance.new("UIPadding")
sidePadding.PaddingTop = UDim.new(0,12)
sidePadding.PaddingLeft = UDim.new(0,10)
sidePadding.PaddingRight = UDim.new(0,10)
sidePadding.Parent = Sidebar

local sideLayout = Instance.new("UIListLayout")
sideLayout.Padding = UDim.new(0,8)
sideLayout.SortOrder = Enum.SortOrder.LayoutOrder
sideLayout.Parent = Sidebar

local Pages = Instance.new("Frame")
Pages.Position = UDim2.fromOffset(155,0)
Pages.Size = UDim2.new(1,-155,1,0)
Pages.BackgroundTransparency = 1
Pages.ZIndex = 106
Pages.Parent = Body

local function CreatePage(name)
    local page = Instance.new("ScrollingFrame")
    page.Name = name
    page.Size = UDim2.fromScale(1,1)
    page.BackgroundTransparency = 1
    page.BorderSizePixel = 0
    page.ScrollBarThickness = 3
    page.CanvasSize = UDim2.fromOffset(0,0)
    page.AutomaticCanvasSize = Enum.AutomaticSize.Y
    page.Visible = false
    page.ZIndex = 107
    page.Parent = Pages

    local pad = Instance.new("UIPadding")
    pad.PaddingTop = UDim.new(0,12)
    pad.PaddingBottom = UDim.new(0,16)
    pad.PaddingLeft = UDim.new(0,12)
    pad.PaddingRight = UDim.new(0,12)
    pad.Parent = page

    local list = Instance.new("UIListLayout")
    list.Padding = UDim.new(0,8)
    list.SortOrder = Enum.SortOrder.LayoutOrder
    list.Parent = page

    return page
end

local MainPage = CreatePage("MainPage")
local TrollPage = CreatePage("TrollPage")
local TargetPage = CreatePage("TargetPage")
local VisualPage = CreatePage("VisualPage")
local InfoPage = CreatePage("InfoPage")
local SettingsPage = CreatePage("SettingsPage")

--==============================================================
-- GENERIC UI BUILDERS
--==============================================================

local function CreateSection(parent,key)
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1,0,0,25)
    label.BackgroundTransparency = 1
    label.Font = Enum.Font.GothamBold
    label.TextSize = 12
    label.TextColor3 = CurrentTheme.Accent
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.ZIndex = 108
    RegisterText(label,key)
    RegisterForRecolor(label,"TextColor3")
    label.Parent = parent
    return label
end

local ToggleControllers = {}

local function CreateToggle(parent,textKey,callback,default)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1,0,0,43)
    frame.BackgroundColor3 = Color3.fromRGB(25,25,32)
    frame.BackgroundTransparency = 0.03
    frame.BorderSizePixel = 0
    frame.ZIndex = 108
    frame.Parent = parent

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0,11)
    corner.Parent = frame

    local glowStroke = Instance.new("UIStroke")
    glowStroke.Thickness = 1
    glowStroke.Transparency = 0.75
    glowStroke.Color = CurrentTheme.Accent
    glowStroke.Parent = frame
    RegisterForRecolor(glowStroke,"Color")

    local label = Instance.new("TextLabel")
    label.BackgroundTransparency = 1
    label.Position = UDim2.fromOffset(13,0)
    label.Size = UDim2.new(1,-95,1,0)
    label.Font = Enum.Font.GothamMedium
    label.TextSize = 12
    label.TextColor3 = Color3.fromRGB(235,235,240)
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.ZIndex = 109
    RegisterText(label,textKey)
    label.Parent = frame

    local switch = Instance.new("TextButton")
    switch.Size = UDim2.fromOffset(52,27)
    switch.Position = UDim2.new(1,-65,0.5,-13)
    switch.BackgroundColor3 = Color3.fromRGB(54,54,63)
    switch.BorderSizePixel = 0
    switch.Text = ""
    switch.AutoButtonColor = false
    switch.ZIndex = 110
    switch.Parent = frame

    local switchCorner = Instance.new("UICorner")
    switchCorner.CornerRadius = UDim.new(1,0)
    switchCorner.Parent = switch

    local knob = Instance.new("Frame")
    knob.Size = UDim2.fromOffset(21,21)
    knob.Position = UDim2.fromOffset(3,3)
    knob.BackgroundColor3 = Color3.fromRGB(248,248,248)
    knob.BorderSizePixel = 0
    knob.ZIndex = 111
    knob.Parent = switch

    local knobCorner = Instance.new("UICorner")
    knobCorner.CornerRadius = UDim.new(1,0)
    knobCorner.Parent = knob

    local state = default == true

    local function render()
        TweenService:Create(
            switch,
            TweenInfo.new(0.16,Enum.EasingStyle.Quint,Enum.EasingDirection.Out),
            {
                BackgroundColor3 =
                    state and CurrentTheme.Accent
                    or Color3.fromRGB(54,54,63)
            }
        ):Play()

        TweenService:Create(
            knob,
            TweenInfo.new(0.16,Enum.EasingStyle.Quint,Enum.EasingDirection.Out),
            {
                Position =
                    state and UDim2.fromOffset(28,3)
                    or UDim2.fromOffset(3,3)
            }
        ):Play()
    end

    switch.Activated:Connect(function()
        state = not state
        render()
        TweenService:Create(glowStroke,TweenInfo.new(0.10,Enum.EasingStyle.Quint,Enum.EasingDirection.Out),{Transparency = state and 0.18 or 0.75,Thickness = state and 1.7 or 1}):Play()
        callback(state)
    end)

    render()
    return frame
end

local function CreateButton(parent,textKey,callback)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1,0,0,43)
    button.BackgroundColor3 = Color3.fromRGB(29,29,36)
    button.BorderSizePixel = 0
    button.Font = Enum.Font.GothamBold
    button.TextSize = 12
    button.TextColor3 = Color3.fromRGB(244,244,248)
    button.AutoButtonColor = false
    button.ZIndex = 108
    RegisterText(button,textKey)
    button.Parent = parent

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0,11)
    corner.Parent = button

    local stroke = Instance.new("UIStroke")
    stroke.Thickness = 1
    stroke.Transparency = 0.55
    stroke.Color = CurrentTheme.Accent
    stroke.Parent = button
    RegisterForRecolor(stroke,"Color")

    local glow = Instance.new("Frame")
    glow.Size = UDim2.fromScale(1,1)
    glow.BackgroundColor3 = CurrentTheme.Accent
    glow.BackgroundTransparency = 1
    glow.BorderSizePixel = 0
    glow.ZIndex = 107
    glow.Parent = button
    local glowCorner = Instance.new("UICorner")
    glowCorner.CornerRadius = UDim.new(0,11)
    glowCorner.Parent = glow
    RegisterForRecolor(glow,"BackgroundColor3")

    button.Activated:Connect(function()
        TweenService:Create(
            button,
            TweenInfo.new(0.1,Enum.EasingStyle.Quint,Enum.EasingDirection.Out),
            {BackgroundColor3 = CurrentTheme.Accent}
        ):Play()

        TweenService:Create(glow,TweenInfo.new(0.10,Enum.EasingStyle.Quint,Enum.EasingDirection.Out),{BackgroundTransparency = 0.78}):Play()
        TweenService:Create(stroke,TweenInfo.new(0.10,Enum.EasingStyle.Quint,Enum.EasingDirection.Out),{Transparency = 0.05,Thickness = 2}):Play()

        task.delay(0.12,function()
            if button.Parent then
                TweenService:Create(
                    button,
                    TweenInfo.new(0.18,Enum.EasingStyle.Quint,Enum.EasingDirection.Out),
                    {BackgroundColor3 = Color3.fromRGB(29,29,36)}
                ):Play()
                TweenService:Create(glow,TweenInfo.new(0.22,Enum.EasingStyle.Quint,Enum.EasingDirection.Out),{BackgroundTransparency = 1}):Play()
                TweenService:Create(stroke,TweenInfo.new(0.18,Enum.EasingStyle.Quint,Enum.EasingDirection.Out),{Transparency = 0.55,Thickness = 1}):Play()
            end
        end)

        callback()
    end)

    return button
end

local function CreateSlider(parent,textKey,min,max,default,callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1,0,0,60)
    frame.BackgroundColor3 = Color3.fromRGB(25,25,32)
    frame.BorderSizePixel = 0
    frame.ZIndex = 108
    frame.Parent = parent

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0,11)
    corner.Parent = frame

    local label = Instance.new("TextLabel")
    label.BackgroundTransparency = 1
    label.Position = UDim2.fromOffset(13,5)
    label.Size = UDim2.new(1,-26,0,20)
    label.Font = Enum.Font.GothamMedium
    label.TextSize = 12
    label.TextColor3 = Color3.fromRGB(235,235,240)
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = frame

    local bar = Instance.new("TextButton")
    bar.Position = UDim2.new(0,13,0,36)
    bar.Size = UDim2.new(1,-26,0,7)
    bar.BackgroundColor3 = Color3.fromRGB(52,52,61)
    bar.BorderSizePixel = 0
    bar.Text = ""
    bar.AutoButtonColor = false
    bar.ZIndex = 109
    bar.Parent = frame

    local barCorner = Instance.new("UICorner")
    barCorner.CornerRadius = UDim.new(1,0)
    barCorner.Parent = bar

    local fill = Instance.new("Frame")
    fill.BackgroundColor3 = CurrentTheme.Accent
    fill.BorderSizePixel = 0
    fill.ZIndex = 110
    fill.Parent = bar

    local fillCorner = Instance.new("UICorner")
    fillCorner.CornerRadius = UDim.new(1,0)
    fillCorner.Parent = fill

    RegisterForRecolor(fill,"BackgroundColor3")

    local dragging = false
    local value = default

    local function setValue(x)
        local width = math.max(1,bar.AbsoluteSize.X)
        local alpha = math.clamp(
            (x-bar.AbsolutePosition.X)/width,
            0,1
        )

        value = math.floor(
            min + (max-min)*alpha
        )

        fill.Size = UDim2.new(alpha,0,1,0)

        label.Text =
            (Translations[CurrentLang][textKey] or textKey)
            .. ": "
            .. tostring(value)

        callback(value)
    end

    local initialAlpha =
        math.clamp((default-min)/(max-min),0,1)

    fill.Size =
        UDim2.new(initialAlpha,0,1,0)

    label.Text =
        (Translations[CurrentLang][textKey] or textKey)
        .. ": "
        .. tostring(default)

    bar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            setValue(input.Position.X)
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if not dragging then
            return
        end

        if input.UserInputType == Enum.UserInputType.MouseMovement
        or input.UserInputType == Enum.UserInputType.Touch then
            setValue(input.Position.X)
        end
    end)

    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)

    return frame
end

local function CreateTextBox(parent,placeholder,defaultText,callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1,0,0,43)
    frame.BackgroundColor3 = Color3.fromRGB(25,25,32)
    frame.BorderSizePixel = 0
    frame.ZIndex = 108
    frame.Parent = parent

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0,11)
    corner.Parent = frame

    local box = Instance.new("TextBox")
    box.BackgroundTransparency = 1
    box.Position = UDim2.fromOffset(13,0)
    box.Size = UDim2.new(1,-26,1,0)
    box.Font = Enum.Font.Gotham
    box.TextSize = 12
    box.TextColor3 = Color3.fromRGB(235,235,240)
    box.PlaceholderColor3 = Color3.fromRGB(115,115,125)
    box.PlaceholderText = placeholder
    box.Text = defaultText or ""
    box.ClearTextOnFocus = false
    box.TextXAlignment = Enum.TextXAlignment.Left
    box.ZIndex = 109
    box.Parent = frame

    box.FocusLost:Connect(function()
        callback(box.Text)
    end)

    return frame
end

local function CreateInfoLabel(parent,text)
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1,0,0,24)
    label.BackgroundTransparency = 1
    label.Font = Enum.Font.Gotham
    label.TextSize = 11
    label.TextColor3 = Color3.fromRGB(185,185,192)
    label.TextWrapped = true
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Text = text
    label.Parent = parent
    return label
end

--==============================================================
-- TAB SYSTEM
--==============================================================

local PagesByName = {
    Main = MainPage,
    Troll = TrollPage,
    Target = TargetPage,
    Visual = VisualPage,
    Settings = SettingsPage,
    Info = InfoPage
}

local TabButtons = {}

local function ShowPage(name)
    for key,page in pairs(PagesByName) do
        page.Visible = key == name
    end

    for key,button in pairs(TabButtons) do
        local active = key == name

        button:SetAttribute("IsActiveTab",active)

        button.BackgroundColor3 =
            active
            and CurrentTheme.Accent
            or Color3.fromRGB(29,29,36)

        button.TextColor3 =
            active
            and Color3.fromRGB(255,255,255)
            or Color3.fromRGB(180,180,188)
    end
end

local function CreateTabButton(name,textKey)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1,0,0,40)
    button.BackgroundColor3 = Color3.fromRGB(29,29,36)
    button.BorderSizePixel = 0
    button.TextColor3 = Color3.fromRGB(180,180,188)
    button.Font = Enum.Font.GothamSemibold
    button.TextSize = 12
    button.AutoButtonColor = false
    button.ZIndex = 108
    RegisterText(button,textKey)
    button.Parent = Sidebar

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0,10)
    corner.Parent = button

    TabButtons[name] = button

    button.Activated:Connect(function()
        ShowPage(name)
    end)

    return button
end

CreateTabButton("Main","TabMain")
CreateTabButton("Troll","TabTroll")
CreateTabButton("Target","TabTarget")
CreateTabButton("Visual","TabVisual")
CreateTabButton("Settings","TabSettings")
CreateTabButton("Info","TabInfo")

--==============================================================
-- TARGET DROPDOWN
--==============================================================

local function CreatePlayerDropdown(parent)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1,0,0,44)
    frame.BackgroundColor3 = Color3.fromRGB(25,25,32)
    frame.BorderSizePixel = 0
    frame.ClipsDescendants = true
    frame.ZIndex = 110
    frame.Parent = parent

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0,11)
    corner.Parent = frame

    local mainButton = Instance.new("TextButton")
    mainButton.Size = UDim2.new(1,0,0,44)
    mainButton.BackgroundTransparency = 1
    mainButton.Font = Enum.Font.GothamMedium
    mainButton.TextSize = 12
    mainButton.TextColor3 = Color3.fromRGB(235,235,240)
    mainButton.TextXAlignment = Enum.TextXAlignment.Left
    mainButton.ZIndex = 112
    RegisterText(mainButton,"SelectPlr")
    mainButton.Parent = frame

    local arrow = Instance.new("TextLabel")
    arrow.BackgroundTransparency = 1
    arrow.Position = UDim2.new(1,-34,0,0)
    arrow.Size = UDim2.fromOffset(30,44)
    arrow.Text = ">"
    arrow.Font = Enum.Font.GothamBold
    arrow.TextSize = 13
    arrow.TextColor3 = Color3.fromRGB(175,175,185)
    arrow.ZIndex = 113
    arrow.Parent = mainButton

    local scroll = Instance.new("ScrollingFrame")
    scroll.Position = UDim2.fromOffset(8,48)
    scroll.Size = UDim2.new(1,-16,0,156)
    scroll.BackgroundTransparency = 1
    scroll.BorderSizePixel = 0
    scroll.ScrollBarThickness = 3
    scroll.ZIndex = 111
    scroll.Parent = frame

    local layout = Instance.new("UIListLayout")
    layout.Padding = UDim.new(0,5)
    layout.Parent = scroll

    local isOpen = false

    local function refreshPlayers()
        for _,child in ipairs(scroll:GetChildren()) do
            if child:IsA("TextButton") then
                child:Destroy()
            end
        end

        for _,plr in ipairs(Players:GetPlayers()) do
            if plr ~= LocalPlayer then
                local button = Instance.new("TextButton")
                button.Size = UDim2.new(1,0,0,30)
                button.BackgroundColor3 = Color3.fromRGB(35,35,43)
                button.BorderSizePixel = 0
                button.TextColor3 = Color3.fromRGB(225,225,230)
                button.Font = Enum.Font.Gotham
                button.TextSize = 11
                button.TextXAlignment = Enum.TextXAlignment.Left
                button.Text = "  " .. plr.DisplayName .. "  @" .. plr.Name
                button.ZIndex = 114
                button.Parent = scroll

                local c = Instance.new("UICorner")
                c.CornerRadius = UDim.new(0,8)
                c.Parent = button

                button.Activated:Connect(function()
                    TrollState.TargetPlayer = plr
                    mainButton.Text = "  " .. plr.DisplayName
                    arrow.Text = ">"
                    isOpen = false
                    frame.Size = UDim2.new(1,0,0,44)

                    Notify(
                        "Target",
                        plr.DisplayName
                            .. " "
                            .. Translations[CurrentLang].NotifSelected,
                        CurrentTheme.Accent
                    )
                end)
            end
        end

        scroll.CanvasSize =
            UDim2.fromOffset(
                0,
                layout.AbsoluteContentSize.Y + 8
            )
    end

    mainButton.Activated:Connect(function()
        isOpen = not isOpen

        if isOpen then
            refreshPlayers()
            frame.Size = UDim2.new(1,0,0,210)
            arrow.Text = "^"
        else
            frame.Size = UDim2.new(1,0,0,44)
            arrow.Text = ">"
        end
    end)

    Players.PlayerAdded:Connect(refreshPlayers)
    Players.PlayerRemoving:Connect(refreshPlayers)

    return frame
end

--==============================================================
-- PRESERVED ORIGINAL LOGIC
--==============================================================

local function UseWeaponOnTarget(targetChar)
    pcall(function()
        if not targetChar then return end

        local char = LocalPlayer.Character
        if not char then return end

        local tool =
            char:FindFirstChildOfClass("Tool")
            or
            LocalPlayer.Backpack:FindFirstChildOfClass("Tool")

        if tool then
            if tool.Parent ~= char then
                tool.Parent = char
            end

            local handle =
                tool:FindFirstChild("Handle")
                or
                tool:FindFirstChildWhichIsA("BasePart")

            if handle then
                local firetouch =
                    firetouchinterest
                    or
                    (syn and syn.firetouchinterest)

                if firetouch then
                    for _,part in pairs(
                        targetChar:GetDescendants()
                    ) do
                        if part:IsA("BasePart") then
                            firetouch(handle,part,0)
                            firetouch(handle,part,1)
                        end
                    end
                else
                    handle.CFrame =
                        targetChar:GetPivot()
                end
            end
        end
    end)
end

local function StopAllActions()
    TrollState.FlingActive = false

    for _,fx in ipairs(TrollState.ActiveFX) do
        if fx then
            pcall(function()
                fx:Destroy()
            end)
        end
    end

    TrollState.ActiveFX = {}

    pcall(function()
        local hrp =
            LocalPlayer.Character
            and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")

        if hrp then
            local bv = hrp:FindFirstChild("FlyVelocity")
            local bg = hrp:FindFirstChild("FlyGyro")

            if bv then bv:Destroy() end
            if bg then bg:Destroy() end

            for _,obj in ipairs(hrp:GetChildren()) do
                if obj.Name == "FlingVelocity"
                or obj.Name == "FlingAngular"
                or obj.Name == "FlingForce"
                then
                    obj:Destroy()
                end
            end
        end
    end)

    TrollState.FreezeTarget = nil
    TrollState.FreezePos = nil
    TrollState.SpinTarget = nil
    TrollState.LoopKill = false
    TrollState.LoopKillTarget = nil
    TrollState.KillAura = false
    TrollState.ChatSpam = false
end

StopButton.Activated:Connect(function()
    StopAllActions()
    for key in {"EgorSpeed","GodMode","Noclip","Fly","Freeze","SpinTarget","LoopKill","KillAura","ChatSpam","FakeLagFPS","FakeLagNet","Spin","FullBright","NoFog","WhiteFX"} do
        if ToggleControllers[key] then pcall(ToggleControllers[key],false) end
    end
    TrollState.EgorSpeed=false
    TrollState.FakeLagFPS=false
    TrollState.FakeLagNet=false
    TrollState.Spin=false
    TrollState.GodMode=false
    TrollState.Noclip=false
    TrollState.Fly=false
    TrollState.FullBright=false
    TrollState.NoFog=false
    TrollState.KillAura=false
    TrollState.ChatSpam=false
    TrollState.LoopKill=false
    TrollState.LoopKillTarget=nil
    Notify("Stopped",Translations[CurrentLang].Stopped,Color3.fromRGB(255,255,255))
end)

local function RunOrbitFling(target,isVoidMode)
    local myChar = LocalPlayer.Character
    local myHrp =
        myChar
        and
        myChar:FindFirstChild("HumanoidRootPart")

    local myHum =
        myChar
        and
        myChar:FindFirstChildOfClass("Humanoid")

    local targetChar =
        target
        and
        target.Character

    local targetHrp =
        targetChar
        and
        targetChar:FindFirstChild("HumanoidRootPart")

    if not (myHrp and targetHrp and myHum) then
        Notify(
            "Error",
            "Character not loaded!",
            Color3.fromRGB(255,0,0)
        )
        return
    end

    local oldPos = myHrp.CFrame
    local oldVelocity = myHrp.AssemblyLinearVelocity

    TrollState.FlingActive = true

    Notify(
        isVoidMode and "Void Fling" or "Orbit Fling",
        "Flinging: " .. target.DisplayName,
        CurrentTheme.Accent
    )

    task.spawn(function()
        for _,part in pairs(myChar:GetDescendants()) do
            if part:IsA("BasePart")
            and
            part.Name ~= "HumanoidRootPart"
            then
                part.CanCollide = false
                part.CanQuery = false
            end
        end

        myHrp.CanCollide = true

        local myVelocity =
            Instance.new("BodyVelocity")

        myVelocity.Name = "FlingVelocity"
        myVelocity.MaxForce =
            Vector3.new(9e9,9e9,9e9)
        myVelocity.Parent = myHrp

        if isVoidMode then
            myVelocity.Velocity =
                Vector3.new(0,-99999,0)

            local targetVelocity =
                Instance.new("BodyVelocity")

            targetVelocity.Name = "TargetFlingVelocity"
            targetVelocity.MaxForce =
                Vector3.new(9e9,9e9,9e9)
            targetVelocity.Velocity =
                Vector3.new(0,-99999,0)
            targetVelocity.Parent = targetHrp

            task.wait(0.5)

            targetVelocity:Destroy()
        else
            local startTime = os.clock()

            while
                os.clock() - startTime < 4
                and
                TrollState.FlingActive
            do
                local angle = os.clock() * 300
                local radius = 0.5

                local offset =
                    Vector3.new(
                        math.cos(angle) * radius,
                        0,
                        math.sin(angle) * radius
                    )

                local targetPos =
                    targetHrp.Position

                local myPos =
                    targetPos + offset

                myHrp.CFrame =
                    CFrame.new(
                        myPos,
                        targetPos
                    )

                local tangent =
                    Vector3.new(
                        -math.sin(angle),
                        0,
                        math.cos(angle)
                    ) * 99999

                myVelocity.Velocity =
                    tangent

                targetHrp.AssemblyLinearVelocity =
                    targetHrp.AssemblyLinearVelocity
                    +
                    Vector3.new(
                        math.random(-50000,50000),
                        math.random(30000,80000),
                        math.random(-50000,50000)
                    )

                RunService.Heartbeat:Wait()
            end
        end

        TrollState.FlingActive = false

        myVelocity:Destroy()

        pcall(function()
            myHrp.AssemblyLinearVelocity =
                oldVelocity
                or
                Vector3.zero

            myHrp.AssemblyAngularVelocity =
                Vector3.zero

            myHrp.CFrame =
                oldPos

            myHum.PlatformStand = false
            myHum.AutoRotate = true
        end)

        for _,part in pairs(myChar:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = true
                part.CanQuery = true
            end
        end

        Notify(
            "Fling Done",
            "Body restored.",
            CurrentTheme.Accent
        )
    end)
end

--==============================================================
-- ORIGINAL PHYSICS LOOP
--==============================================================

RunService.Stepped:Connect(function()
    pcall(function()
        local char = LocalPlayer.Character
        if not char then return end

        local hrp =
            char:FindFirstChild("HumanoidRootPart")

        local hum =
            char:FindFirstChildOfClass("Humanoid")

        if
            TrollState.Noclip
            or
            TrollState.FlingActive
        then
            for _,part in pairs(
                char:GetDescendants()
            ) do
                if part:IsA("BasePart") then
                    if not (
                        TrollState.FlingActive
                        and
                        part.Name == "HumanoidRootPart"
                    ) then
                        part.CanCollide = false
                        part.CanQuery = false
                    end
                end
            end
        end
        if
            TrollState.FreezeTarget
            and
            TrollState.FreezeTarget.Character
        then
            local tHrp =
                TrollState.FreezeTarget.Character:FindFirstChild(
                    "HumanoidRootPart"
                )

            if tHrp then
                if not TrollState.FreezePos then
                    TrollState.FreezePos =
                        tHrp.CFrame
                end

                tHrp.CFrame =
                    TrollState.FreezePos

                tHrp.AssemblyLinearVelocity =
                    Vector3.zero

                tHrp.AssemblyAngularVelocity =
                    Vector3.zero
            else
                StopAllActions()
            end
        end

        if
            TrollState.SpinTarget
            and
            TrollState.SpinTarget.Character
        then
            local tHrp =
                TrollState.SpinTarget.Character:FindFirstChild(
                    "HumanoidRootPart"
                )

            if tHrp then
                tHrp.CFrame =
                    tHrp.CFrame
                    *
                    CFrame.Angles(
                        0,
                        math.rad(18),
                        0
                    )
            end
        end
    end)
end)

RunService.RenderStepped:Connect(function()
    pcall(function()
        local char = LocalPlayer.Character
        if not char then return end

        local hum =
            char:FindFirstChildOfClass("Humanoid")

        local hrp =
            char:FindFirstChild("HumanoidRootPart")

        if hum then
            if TrollState.EgorSpeed then
                hum.WalkSpeed = 3.5

                local animator =
                    hum:FindFirstChildOfClass("Animator")

                local tracks =
                    animator
                    and
                    animator:GetPlayingAnimationTracks()
                    or
                    hum:GetPlayingAnimationTracks()

                for _,track in pairs(tracks) do
                    if track.IsPlaying then
                        pcall(function()
                            track:AdjustSpeed(6)
                        end)
                    end
                end
            else
                if hum.WalkSpeed == 3.5 then
                    hum.WalkSpeed = 16
                end
            end
        end

        if hrp and TrollState.Spin then
            hrp.CFrame =
                hrp.CFrame
                *
                CFrame.Angles(
                    0,
                    math.rad(TrollState.SpinSpeed),
                    0
                )
        end
    end)
end)

--==============================================================
-- FLY
--==============================================================

local function ApplySmoothFly()
    pcall(function()
        local char = LocalPlayer.Character
        local hrp =
            char
            and
            char:FindFirstChild("HumanoidRootPart")

        local hum =
            char
            and
            char:FindFirstChildOfClass("Humanoid")

        if not hrp or not hum then
            return
        end

        local bv =
            hrp:FindFirstChild("FlyVelocity")
            or
            Instance.new("BodyVelocity")

        bv.Name = "FlyVelocity"
        bv.MaxForce =
            Vector3.new(9e9,9e9,9e9)

        local bg =
            hrp:FindFirstChild("FlyGyro")
            or
            Instance.new("BodyGyro")

        bg.Name = "FlyGyro"
        bg.MaxTorque =
            Vector3.new(9e9,9e9,9e9)

        if TrollState.Fly then
            hum.PlatformStand = true

            bv.Parent = hrp
            bg.Parent = hrp

            local camera =
                workspace.CurrentCamera

            local moveDir =
                hum.MoveDirection

            if moveDir.Magnitude > 0 then
                local flyDir =
                    Vector3.new(
                        moveDir.X,
                        camera.CFrame.LookVector.Y
                            * moveDir.Magnitude,
                        moveDir.Z
                    )

                if flyDir.Magnitude > 0 then
                    flyDir = flyDir.Unit
                end

                bv.Velocity =
                    flyDir * TrollState.FlySpeed
            else
                bv.Velocity =
                    Vector3.zero
            end

            if UserInputService:IsKeyDown(
                Enum.KeyCode.Space
            ) then
                bv.Velocity +=
                    Vector3.new(
                        0,
                        TrollState.FlySpeed,
                        0
                    )
            end

            if UserInputService:IsKeyDown(
                Enum.KeyCode.LeftShift
            ) then
                bv.Velocity -=
                    Vector3.new(
                        0,
                        TrollState.FlySpeed,
                        0
                    )
            end

            bg.CFrame =
                camera.CFrame

        else
            if hrp:FindFirstChild("FlyVelocity") then
                hrp.FlyVelocity:Destroy()
            end

            if hrp:FindFirstChild("FlyGyro") then
                hrp.FlyGyro:Destroy()
            end

            hum.PlatformStand = false
        end
    end)
end

RunService.Heartbeat:Connect(function()
    if TrollState.Fly then
        ApplySmoothFly()
    end
end)

--==============================================================
-- FAKE LAG
--==============================================================

task.spawn(function()
    while task.wait() do
        pcall(function()
            local char = LocalPlayer.Character
            if not char then
                return
            end

            if
                TrollState.FakeLagFPS
                or
                TrollState.FakeLagNet
            then
                local hrp =
                    char:FindFirstChild(
                        "HumanoidRootPart"
                    )

                if hrp then
                    hrp.Anchored = true

                    task.wait(
                        TrollState.LagFPSValue / 100
                    )

                    if hrp.Parent then
                        hrp.Anchored = false
                    end

                    task.wait(0.04)
                end
            end
        end)
    end
end)

--==============================================================
-- GOD MODE
--==============================================================

local function EnableGodMode()
    local char = LocalPlayer.Character
    if not char then
        return
    end

    local hum =
        char:FindFirstChildOfClass("Humanoid")

    if not hum then
        return
    end

    hum.MaxHealth = 9e9
    hum.Health = hum.MaxHealth

    local healthLoop

    healthLoop =
        RunService.Heartbeat:Connect(function()
            if
                TrollState.GodMode
                and
                hum
                and
                hum.Parent
            then
                hum.Health = hum.MaxHealth
            else
                pcall(function()
                    healthLoop:Disconnect()
                end)
            end
        end)
end

--==============================================================
-- KILL AURA / CHAT / LOOP KILL
--==============================================================

task.spawn(function()
    while task.wait(0.1) do
        if TrollState.KillAura then
            pcall(function()
                local myHrp =
                    LocalPlayer.Character
                    and
                    LocalPlayer.Character:FindFirstChild(
                        "HumanoidRootPart"
                    )

                if not myHrp then
                    return
                end

                for _,p in pairs(
                    Players:GetPlayers()
                ) do
                    if
                        p ~= LocalPlayer
                        and
                        p.Character
                    then
                        local tHrp =
                            p.Character:FindFirstChild(
                                "HumanoidRootPart"
                            )

                        if
                            tHrp
                            and
                            (
                                myHrp.Position
                                -
                                tHrp.Position
                            ).Magnitude
                            <= TrollState.KillAuraRange
                        then
                            UseWeaponOnTarget(
                                p.Character
                            )
                        end
                    end
                end
            end)
        end
    end
end)

task.spawn(function()
    while task.wait(2) do
        if TrollState.ChatSpam then
            pcall(function()
                if
                    TextChatService.ChatVersion
                    ==
                    Enum.ChatVersion.TextChatService
                then
                    local channels =
                        TextChatService:FindFirstChild(
                            "TextChannels"
                        )

                    local general =
                        channels
                        and
                        (
                            channels:FindFirstChild(
                                "RBXGeneral"
                            )
                            or
                            channels:GetChildren()[1]
                        )

                    if general then
                        general:SendAsync(
                            TrollState.ChatSpamText
                        )
                    end
                end
            end)
        end
    end
end)

task.spawn(function()
    while task.wait(0.1) do
        if
            TrollState.LoopKill
            and
            TrollState.LoopKillTarget
            and
            TrollState.LoopKillTarget.Character
        then
            UseWeaponOnTarget(
                TrollState.LoopKillTarget.Character
            )
        end
    end
end)

--==============================================================
-- RESPAWN
--==============================================================

LocalPlayer.CharacterAdded:Connect(function()
    task.wait(0.25)

    StopAllActions()

    TrollState.FreezeTarget = nil
    TrollState.FreezePos = nil
    TrollState.SpinTarget = nil
    TrollState.LoopKillTarget = nil

    if TrollState.GodMode then
        EnableGodMode()
    end
end)

--==============================================================
-- MAIN PAGE
--==============================================================

CreateSection(MainPage,"SecMove")
CreateToggle(MainPage,"EgorSpeed",function(state) TrollState.EgorSpeed = state end,false)

CreateSection(MainPage,"SecSelf")
CreateToggle(MainPage,"GodMode",function(state)
    TrollState.GodMode = state
    if state then EnableGodMode() end
end,false)
CreateToggle(MainPage,"Noclip",function(state) TrollState.Noclip = state end,false)
CreateToggle(MainPage,"Fly",function(state) TrollState.Fly = state end,false)
CreateSlider(MainPage,"FlySpeed",20,200,TrollState.FlySpeed,function(v) TrollState.FlySpeed = v end)

CreateInfoLabel(MainPage,"Main = personal movement and character utilities. Troll = target/trolling actions. Visual = camera/lighting. Settings = interface.")

--==============================================================
-- TROLL PAGE
--==============================================================

CreateSection(TrollPage,"SecTarget")
CreatePlayerDropdown(TrollPage)

CreateSection(TrollPage,"SecDestroy")
CreateButton(TrollPage,function()
    if TrollState.TargetPlayer then
        RunOrbitFling(TrollState.TargetPlayer,false)
    else
        Notify("Target",Translations[CurrentLang].NoTarget,Color3.fromRGB(255,0,0))
    end
end)
CreateButton(TrollPage,"TPTarget",function()
    local target=TrollState.TargetPlayer
    local myChar=LocalPlayer.Character
    local targetRoot=target and target.Character and target.Character:FindFirstChild("HumanoidRootPart")
    local myRoot=myChar and myChar:FindFirstChild("HumanoidRootPart")
    if targetRoot and myRoot then
        myRoot.CFrame=targetRoot.CFrame*CFrame.new(0,5,0)
        Notify("Teleport","Teleported to "..target.DisplayName,CurrentTheme.Accent)
    else
        Notify("Target",Translations[CurrentLang].NoTarget,Color3.fromRGB(255,0,0))
    end
end)
CreateToggle(TrollPage,"Freeze",function(state)
    if state then
        if TrollState.TargetPlayer then
            TrollState.FreezeTarget=TrollState.TargetPlayer
            TrollState.FreezePos=nil
        else
            Notify("Target",Translations[CurrentLang].NoTarget,Color3.fromRGB(255,0,0))
        end
    else
        TrollState.FreezeTarget=nil
        TrollState.FreezePos=nil
    end
end,false)
CreateToggle(TrollPage,"SpinTarget",function(state)
    if state then
        if TrollState.TargetPlayer then TrollState.SpinTarget=TrollState.TargetPlayer else Notify("Target",Translations[CurrentLang].NoTarget,Color3.fromRGB(255,0,0)) end
    else TrollState.SpinTarget=nil end
end,false)
CreateToggle(TrollPage,"LoopKill",function(state)
    if state then
        if TrollState.TargetPlayer then TrollState.LoopKillTarget=TrollState.TargetPlayer; TrollState.LoopKill=true else Notify("Target",Translations[CurrentLang].NoTarget,Color3.fromRGB(255,0,0)) end
    else TrollState.LoopKill=false; TrollState.LoopKillTarget=nil end
end,false)

CreateSection(TrollPage,"SecSelf")
CreateToggle(TrollPage,"KillAura",function(state) TrollState.KillAura=state end,false)
CreateSlider(TrollPage,"AuraRange",5,50,TrollState.KillAuraRange,function(v) TrollState.KillAuraRange=v end)
CreateToggle(TrollPage,"ChatSpam",function(state) TrollState.ChatSpam=state end,false)
CreateTextBox(TrollPage,"Spam text...",TrollState.ChatSpamText,function(v) TrollState.ChatSpamText=v end)

CreateSection(TrollPage,"SecMove")
CreateToggle(TrollPage,"FakeLagFPS",function(state) TrollState.FakeLagFPS=state end,false)
CreateSlider(TrollPage,"SetLagFPS",1,100,TrollState.LagFPSValue,function(v) TrollState.LagFPSValue=v end)
CreateToggle(TrollPage,"FakeLagNet",function(state) TrollState.FakeLagNet=state end,false)
CreateToggle(TrollPage,"Spin",function(state) TrollState.Spin=state end,false)
CreateSlider(TrollPage,"SpinSpeed",1,100,TrollState.SpinSpeed,function(v) TrollState.SpinSpeed=v end)

--==============================================================
-- TARGET PAGE
--==============================================================

CreateSection(TargetPage,"SecTarget")
CreatePlayerDropdown(TargetPage)
CreateSection(TargetPage,"SecTargetTools")
CreateButton(TargetPage,"TargetInfo",function()
    local target=TrollState.TargetPlayer
    if not target then Notify("Target",Translations[CurrentLang].NoTarget,Color3.fromRGB(255,0,0)); return end
    local tr=target.Character and target.Character:FindFirstChild("HumanoidRootPart")
    local th=target.Character and target.Character:FindFirstChildOfClass("Humanoid")
    local mr=LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if tr and mr then
        local d=math.floor((tr.Position-mr.Position).Magnitude)
        local hp=th and math.floor(th.Health) or 0
        Notify("Target",target.DisplayName.." • "..d.."m • HP "..hp,CurrentTheme.Accent)
    end
end)
CreateButton(TargetPage,"TargetDistance",function()
    local target=TrollState.TargetPlayer
    local tr=target and target.Character and target.Character:FindFirstChild("HumanoidRootPart")
    local mr=LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if tr and mr then Notify("Distance",target.DisplayName..": "..math.floor((tr.Position-mr.Position).Magnitude).."m",CurrentTheme.Accent) else Notify("Target",Translations[CurrentLang].NoTarget,Color3.fromRGB(255,0,0)) end
end)
CreateButton(TargetPage,"ClearTarget",function() TrollState.TargetPlayer=nil; Notify("Target","Target cleared.",CurrentTheme.Accent) end)
CreateInfoLabel(TargetPage,"Target is shared between Troll and Target tabs. Persistent actions are toggles in Troll so each can be disabled directly.")

--==============================================================
-- VISUAL PAGE
--==============================================================

CreateSection(VisualPage,"SecVisual")
CreateToggle(VisualPage,"FullBright",function(state) TrollState.FullBright=state end,false)
CreateToggle(VisualPage,"NoFog",function(state) TrollState.NoFog=state end,false)
CreateSlider(VisualPage,"FOV",50,120,TrollState.FOV,function(v) TrollState.FOV=v end)
CreateToggle(VisualPage,"WhiteFX",function(state)
    local c=LocalPlayer.Character
    local root=c and c:FindFirstChild("HumanoidRootPart")
    if not root then return end
    local existing=root:FindFirstChild("TrollHubWhiteFX")
    if state then
        if existing then existing:Destroy() end
        local e=Instance.new("ParticleEmitter")
        e.Name="TrollHubWhiteFX"
        e.Texture="rbxassetid://296874871"
        e.Rate=18
        e.Lifetime=NumberRange.new(0.5,1)
        e.Speed=NumberRange.new(2,6)
        e.SpreadAngle=Vector2.new(180,180)
        e.Color=ColorSequence.new(Color3.fromRGB(255,255,255))
        e.LightEmission=1
        e.Size=NumberSequence.new(0.22)
        e.Parent=root
    else
        if existing then existing:Destroy() end
    end
end,false)
CreateInfoLabel(VisualPage,"Visual controls are client-side. Generic client particles cannot be guaranteed to replicate to every player.")

--==============================================================
-- SETTINGS PAGE
--==============================================================

CreateSection(SettingsPage,"SecInterface")
CreateToggle(SettingsPage,"WindowBackground",function(state)
    TrollState.ShowWindowBackground=state
    MainBackground.Visible=state
    MainOverlay.BackgroundTransparency=state and 0.44 or 0.66
    Sidebar.BackgroundTransparency=state and 0.78 or 0.98
end,TrollState.ShowWindowBackground)

CreateButton(SettingsPage,"StopAll",function()
    StopAllActions()
    for key in {"EgorSpeed","GodMode","Noclip","Fly","Freeze","SpinTarget","LoopKill","KillAura","ChatSpam","FakeLagFPS","FakeLagNet","Spin","FullBright","NoFog","WhiteFX"} do
        if ToggleControllers[key] then pcall(ToggleControllers[key],false) end
    end
    TrollState.EgorSpeed=false
    TrollState.FakeLagFPS=false
    TrollState.FakeLagNet=false
    TrollState.Spin=false
    TrollState.GodMode=false
    TrollState.Noclip=false
    TrollState.Fly=false
    TrollState.FullBright=false
    TrollState.NoFog=false
    TrollState.KillAura=false
    TrollState.ChatSpam=false
    TrollState.LoopKill=false
    TrollState.LoopKillTarget=nil
    Notify("Stopped",Translations[CurrentLang].Stopped,Color3.fromRGB(255,255,255))
end)
CreateSection(SettingsPage,"SecTheme")
CreateButton(SettingsPage,"ThemeRed",function() ApplyTheme("Red"); Notify("Theme",Themes.Red.Name,Themes.Red.Accent) end)
CreateButton(SettingsPage,"ThemeBlue",function() ApplyTheme("Blue"); Notify("Theme",Themes.Blue.Name,Themes.Blue.Accent) end)
CreateButton(SettingsPage,"ThemePurple",function() ApplyTheme("Purple"); Notify("Theme",Themes.Purple.Name,Themes.Purple.Accent) end)
CreateButton(SettingsPage,"ThemeGreen",function() ApplyTheme("Green"); Notify("Theme",Themes.Green.Name,Themes.Green.Accent) end)
CreateButton(SettingsPage,"ThemeGold",function() ApplyTheme("Gold"); Notify("Theme",Themes.Gold.Name,Themes.Gold.Accent) end)
CreateInfoLabel(SettingsPage,"Background image is OFF by default. Turn it on here when you want the photo; the layout keeps the same black/glass structure.")

--==============================================================
-- INFO PAGE
--==============================================================

CreateSection(InfoPage,"InfoDev")

CreateInfoLabel(
    InfoPage,
    Translations[CurrentLang].InfoDev
)

CreateInfoLabel(
    InfoPage,
    Translations[CurrentLang].InfoName
)

CreateInfoLabel(
    InfoPage,
    Translations[CurrentLang].InfoVersion
)

CreateInfoLabel(
    InfoPage,
    Translations[CurrentLang].InfoAssets
)

CreateInfoLabel(InfoPage,"LGK = developer group; it is mentioned here only in Info.")

CreateInfoLabel(
    InfoPage,
    "LGK = developer group; it is not the name of the hub."
)

CreateInfoLabel(
    InfoPage,
    "Logo: " .. LOGO
)

CreateInfoLabel(
    InfoPage,
    "Background: " .. WINDOW_BACKGROUND
)

CreateSection(InfoPage,"InfoDiscord")
CreateInfoLabel(InfoPage,"https://discord.gg/vpfFGGjg9")
CreateInfoLabel(InfoPage, "https://discord.gg/vpfFGGjg9")

local DiscordButton = Instance.new("TextButton")
DiscordButton.Size = UDim2.new(1,0,0,43)
DiscordButton.BackgroundColor3 = Color3.fromRGB(29,29,36)
DiscordButton.BorderSizePixel = 0
DiscordButton.Font = Enum.Font.GothamBold
DiscordButton.TextSize = 11
DiscordButton.TextColor3 = Color3.fromRGB(145,190,255)
DiscordButton.Text = "Copy Discord Link"
DiscordButton.ZIndex = 108
DiscordButton.Parent = InfoPage

local discordCorner = Instance.new("UICorner")
discordCorner.CornerRadius = UDim.new(0,11)
discordCorner.Parent = DiscordButton

DiscordButton.Activated:Connect(function()
    local link = "https://discord.gg/vpfFGGjg9"

    if typeof(setclipboard) == "function" then
        pcall(function()
            setclipboard(link)
        end)

        Notify(
            "Discord",
            "Link copied.",
            CurrentTheme.Accent
        )
    else
        Notify(
            "Discord",
            link,
            CurrentTheme.Accent
        )
    end
end)


local function HookCanvas(page)
    local layout = page:FindFirstChildOfClass("UIListLayout")
    if layout then
        layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            page.CanvasSize = UDim2.fromOffset(
                0,
                layout.AbsoluteContentSize.Y + 36
            )
        end)
    end
end

HookCanvas(MainPage)
HookCanvas(TrollPage)
HookCanvas(TargetPage)
HookCanvas(VisualPage)
HookCanvas(SettingsPage)
HookCanvas(InfoPage)

--==============================================================
-- LANGUAGE
--==============================================================

LangButton.Activated:Connect(function()
    if CurrentLang == "RU" then
        SwitchLanguage("EN")
        Notify(
            "Language",
            "Language switched to English",
            CurrentTheme.Accent
        )
    else
        SwitchLanguage("RU")
        Notify(
            "Язык",
            "Язык изменен на Русский",
            CurrentTheme.Accent
        )
    end
end)

--==============================================================
-- WINDOW DRAG
--==============================================================

local function MakeDraggable(dragArea,frame)
    local dragging = false
    local dragStart
    local startPos

    dragArea.InputBegan:Connect(function(input)
        if
            input.UserInputType == Enum.UserInputType.MouseButton1
            or
            input.UserInputType == Enum.UserInputType.Touch
        then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if not dragging then
            return
        end

        if
            input.UserInputType == Enum.UserInputType.MouseMovement
            or
            input.UserInputType == Enum.UserInputType.Touch
        then
            local delta =
                input.Position
                -
                dragStart

            frame.Position =
                UDim2.new(
                    startPos.X.Scale,
                    startPos.X.Offset + delta.X,
                    startPos.Y.Scale,
                    startPos.Y.Offset + delta.Y
                )
        end
    end)

    UserInputService.InputEnded:Connect(function(input)
        if
            input.UserInputType == Enum.UserInputType.MouseButton1
            or
            input.UserInputType == Enum.UserInputType.Touch
        then
            dragging = false
        end
    end)
end

MakeDraggable(TitleBar,MainFrame)

--==============================================================
-- MINIMIZE / ISLAND
--==============================================================

local savedPosition = MainFrame.Position
local minimized = false

local function ShowIsland()
    IslandFrame.Visible = true
    IslandFrame.Size = UDim2.fromOffset(24,24)

    TweenService:Create(
        IslandFrame,
        TweenInfo.new(
            0.32,
            Enum.EasingStyle.Back,
            Enum.EasingDirection.Out
        ),
        {
            Size = UDim2.fromOffset(190,46)
        }
    ):Play()
end

local function HideIsland()
    TweenService:Create(
        IslandFrame,
        TweenInfo.new(
            0.20,
            Enum.EasingStyle.Quint,
            Enum.EasingDirection.In
        ),
        {
            Size = UDim2.fromOffset(24,24)
        }
    ):Play()

    task.delay(0.22,function()
        IslandFrame.Visible = false
    end)
end

local function Minimize()
    if minimized then
        return
    end

    minimized = true
    savedPosition = MainFrame.Position

    TweenService:Create(
        MainScale,
        TweenInfo.new(
            0.34,
            Enum.EasingStyle.Quint,
            Enum.EasingDirection.In
        ),
        {
            Scale = 0.07
        }
    ):Play()

    task.delay(0.34,function()
        if minimized then
            MainFrame.Visible = false
            ShowIsland()
        end
    end)
end

local function Restore()
    if not minimized then
        return
    end

    minimized = false
    HideIsland()

    MainFrame.Visible = true
    MainFrame.Position = savedPosition
    MainScale.Scale = 0.07

    TweenService:Create(
        MainScale,
        TweenInfo.new(
            0.42,
            Enum.EasingStyle.Back,
            Enum.EasingDirection.Out
        ),
        {
            Scale = 1
        }
    ):Play()
end

MinimizeButton.Activated:Connect(Minimize)
IslandButton.Activated:Connect(Restore)

--==============================================================
-- DEFAULT PAGE
--==============================================================

ShowPage("Main")

--==============================================================
-- SPLASH SEQUENCE
--==============================================================

task.spawn(function()
    task.wait(0.25)

    TweenService:Create(
        SplashLogo,
        TweenInfo.new(
            0.65,
            Enum.EasingStyle.Back,
            Enum.EasingDirection.Out
        ),
        {
            ImageTransparency = 0
        }
    ):Play()

    task.wait(0.25)

    TweenService:Create(
        SplashTitle,
        TweenInfo.new(
            0.55,
            Enum.EasingStyle.Quint,
            Enum.EasingDirection.Out
        ),
        {
            TextTransparency = 0
        }
    ):Play()

    task.wait(0.20)

    TweenService:Create(
        SplashSub,
        TweenInfo.new(0.45),
        {
            TextTransparency = 0
        }
    ):Play()

    task.wait(0.20)

    TweenService:Create(
        SplashStatus,
        TweenInfo.new(0.3),
        {
            TextTransparency = 0
        }
    ):Play()

    SplashStatus.Text = "Loading interface..."
    task.wait(0.85)

    SplashStatus.Text = "Loading target engine..."
    task.wait(0.85)

    SplashStatus.Text = "Loading movement..."
    task.wait(0.85)

    SplashStatus.Text = "Loading visual system..."
    task.wait(0.85)

    SplashStatus.Text = "Applying LGK style..."
    task.wait(0.85)

    SplashStatus.Text = "HUB ready"
    task.wait(0.75)

    TweenService:Create(
        SplashLogo,
        TweenInfo.new(0.3),
        {
            ImageTransparency = 1
        }
    ):Play()

    TweenService:Create(
        SplashTitle,
        TweenInfo.new(0.3),
        {
            TextTransparency = 1
        }
    ):Play()

    TweenService:Create(
        SplashSub,
        TweenInfo.new(0.3),
        {
            TextTransparency = 1
        }
    ):Play()

    TweenService:Create(
        SplashStatus,
        TweenInfo.new(0.25),
        {
            TextTransparency = 1
        }
    ):Play()

    task.wait(0.35)

    Splash:Destroy()

    MainFrame.Visible = true
    MainScale.Scale = 0.82

    TweenService:Create(
        MainScale,
        TweenInfo.new(
            0.48,
            Enum.EasingStyle.Back,
            Enum.EasingDirection.Out
        ),
        {
            Scale = 1
        }
    ):Play()

    Notify(
        "HUB",
        "Premium UI loaded.",
        CurrentTheme.Accent
    )
end)

print("================================================")
print("HUB - Troll & Universal")
print("Premium Visual Overhaul v10.0")
print("Author: Legenly")
print("Target Engine: PRESERVED")
print("Orbit Fling: PRESERVED")
print("Fling: PRESERVED (single target action)")
print("Freeze: PRESERVED")
print("Spin Target: PRESERVED")
print("Teleport Target: PRESERVED")
print("Loop Kill: PRESERVED")
print("Sexual target actions: REMOVED")
print("Kill Aura: PRESERVED")
print("Noclip/Fly/GodMode: PRESERVED")
print("================================================")
