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

        SecTargetTools = "Инструменты цели",
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
        WhiteFX = "White FX",
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

        SecTargetTools = "Target tools",
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
        WhiteFX = "White FX",
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
    _NoclipParts = {},

    Fly = false,
    FlySpeed = 50,

    LoopKill = false,
    LoopKillTarget = nil,

    FullBright = false,
    NoFog = false,
    FOV = 70,
    ShowWindowBackground = false,
    WhiteFX = false,
    _OriginalLighting = nil,
    _OriginalFog = nil,
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

local function RegisterForRecolor(element, property, checkActiveState)
    table.insert(RecolorQueue, function(newColor)
        if not element or not element.Parent then return false end
        pcall(function()
            if checkActiveState then
                if element:GetAttribute("IsActiveTab") then
                    element[property] = newColor
                end
            else
                element[property] = newColor
            end
        end)
        return true
    end)
end

local function RegisterText(element, key)
    table.insert(TextElements, {Element = element, Key = key})
    pcall(function()
        element.Text = Translations[CurrentLang][key] or element.Text
    end)
end

local function SwitchLanguage(lang)
    CurrentLang = lang
    for _, item in ipairs(TextElements) do
        if item.Element and item.Element.Parent then
            pcall(function()
                local txt = Translations[CurrentLang][item.Key]
                if txt then item.Element.Text = txt end
            end)
        end
    end
end

local function ApplyTheme(themeKey)
    local theme = Themes[themeKey]
    if theme then
        CurrentTheme = theme
        local cleanQueue = {}
        for _, recolorFn in ipairs(RecolorQueue) do
            local success, keep = pcall(recolorFn, theme.Accent)
            if success and keep ~= false then
                table.insert(cleanQueue, recolorFn)
            end
        end
        RecolorQueue = cleanQueue
    end
end

--==============================================================
-- NOTIFICATIONS
--==============================================================

local function Notify(title, message, color)
    color = color or CurrentTheme.Accent
    local NotifFrame = Instance.new("Frame", ScreenGui)
    NotifFrame.Size = UDim2.new(0, 240, 0, 65)
    NotifFrame.Position = UDim2.new(1, -250, 1, -75)
    NotifFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
    NotifFrame.BorderSizePixel = 0
    Instance.new("UICorner", NotifFrame).CornerRadius = UDim.new(0, 8)

    local AccentLine = Instance.new("Frame", NotifFrame)
    AccentLine.Size = UDim2.new(0, 4, 1, 0)
    AccentLine.BorderSizePixel = 0
    AccentLine.BackgroundColor3 = color
    Instance.new("UICorner", AccentLine).CornerRadius = UDim.new(0, 8)
    RegisterForRecolor(AccentLine, "BackgroundColor3")

    local TxtTitle = Instance.new("TextLabel", NotifFrame)
    TxtTitle.BackgroundTransparency = 1
    TxtTitle.Position = UDim2.new(0, 15, 0, 8)
    TxtTitle.Size = UDim2.new(1, -20, 0, 20)
    TxtTitle.Font = Enum.Font.GothamBold
    TxtTitle.Text = title
    TxtTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    TxtTitle.TextSize = 13
    TxtTitle.TextXAlignment = Enum.TextXAlignment.Left

    local TxtMsg = Instance.new("TextLabel", NotifFrame)
    TxtMsg.BackgroundTransparency = 1
    TxtMsg.Position = UDim2.new(0, 15, 0, 28)
    TxtMsg.Size = UDim2.new(1, -20, 0, 30)
    TxtMsg.Font = Enum.Font.Gotham
    TxtMsg.Text = message
    TxtMsg.TextColor3 = Color3.fromRGB(180, 180, 180)
    TxtMsg.TextSize = 11
    TxtMsg.TextWrapped = true
    TxtMsg.TextXAlignment = Enum.TextXAlignment.Left

    task.delay(3, function()
        for i = 0, 10 do
            if not NotifFrame or not NotifFrame.Parent then break end
            local transp = i/10
            NotifFrame.BackgroundTransparency = transp
            TxtTitle.TextTransparency = transp
            TxtMsg.TextTransparency = transp
            AccentLine.BackgroundTransparency = transp
            task.wait(0.02)
        end
        if NotifFrame and NotifFrame.Parent then NotifFrame:Destroy() end
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
MainFrame.BackgroundColor3 = Color3.fromRGB(6,6,9)
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
MainBackground.Visible = false
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
IslandFrame.Size = UDim2.fromOffset(142,38)
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
IslandLogo.Position = UDim2.fromOffset(8,6)
IslandLogo.Size = UDim2.fromOffset(26,26)
IslandLogo.BackgroundTransparency = 1
IslandLogo.Image = LOGO
IslandLogo.ZIndex = 701
IslandLogo.Parent = IslandFrame

local islandLogoCorner = Instance.new("UICorner")
islandLogoCorner.CornerRadius = UDim.new(0,10)
islandLogoCorner.Parent = IslandLogo

local IslandText = Instance.new("TextLabel")
IslandText.BackgroundTransparency = 1
IslandText.Position = UDim2.fromOffset(39,0)
IslandText.Size = UDim2.new(1,-45,1,0)
IslandText.Text = "Troll HUB"
IslandText.Font = Enum.Font.GothamBold
IslandText.TextSize = 12
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
local VisualPage = CreatePage("VisualPage")
local InfoPage = CreatePage("InfoPage")
local SettingsPage = CreatePage("SettingsPage")

--==============================================================
-- GENERIC UI BUILDERS
--==============================================================

local function CreateSection(parent, textKey)
    local Lbl = Instance.new("TextLabel", parent)
    Lbl.BackgroundTransparency = 1
    Lbl.Size = UDim2.new(1, 0, 0, 25)
    Lbl.Font = Enum.Font.GothamBold
    Lbl.TextColor3 = CurrentTheme.Accent
    Lbl.TextSize = 13
    RegisterText(Lbl, textKey)
    RegisterForRecolor(Lbl, "TextColor3")
end

local ToggleControllers = {}

local function CreateToggle(parent, textKey, callback)
    local Frame = Instance.new("Frame", parent)
    Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
    Frame.Size = UDim2.new(1, -10, 0, 35)
    Instance.new("UICorner", Frame).CornerRadius = UDim.new(0, 6)

    local Lbl = Instance.new("TextLabel", Frame)
    Lbl.BackgroundTransparency = 1
    Lbl.Position = UDim2.new(0, 10, 0, 0)
    Lbl.Size = UDim2.new(1, -50, 1, 0)
    Lbl.Font = Enum.Font.Gotham
    Lbl.TextColor3 = Color3.fromRGB(255, 255, 255)
    Lbl.TextSize = 12
    Lbl.TextXAlignment = Enum.TextXAlignment.Left
    RegisterText(Lbl, textKey)

    local Btn = Instance.new("TextButton", Frame)
    Btn.BackgroundColor3 = Color3.fromRGB(45, 45, 50)
    Btn.Position = UDim2.new(1, -35, 0.5, -10)
    Btn.Size = UDim2.new(0, 25, 0, 20)
    Btn.Text = ""
    Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 4)

    local state = false
    Btn.MouseButton1Click:Connect(function()
        state = not state
        Btn.BackgroundColor3 = state and CurrentTheme.Accent or Color3.fromRGB(45, 45, 50)
        callback(state)
    end)

    table.insert(RecolorQueue, function(newColor)
        if state then Btn.BackgroundColor3 = newColor end
    end)
end

local function CreateButton(parent, textKey, callback)
    local Btn = Instance.new("TextButton", parent)
    Btn.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
    Btn.Size = UDim2.new(1, -10, 0, 35)
    Btn.Font = Enum.Font.GothamBold
    Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    Btn.TextSize = 13
    Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 6)
    RegisterText(Btn, textKey)

    Btn.MouseButton1Click:Connect(function()
        Btn.BackgroundColor3 = CurrentTheme.Accent
        task.wait(0.12)
        Btn.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
        callback()
    end)
end

local function CreateSlider(parent, textKey, min, max, default, callback)
    local Frame = Instance.new("Frame", parent)
    Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
    Frame.Size = UDim2.new(1, -10, 0, 50)
    Instance.new("UICorner", Frame).CornerRadius = UDim.new(0, 6)

    local Lbl = Instance.new("TextLabel", Frame)
    Lbl.BackgroundTransparency = 1
    Lbl.Position = UDim2.new(0, 10, 0, 5)
    Lbl.Size = UDim2.new(1, -20, 0, 20)
    Lbl.Font = Enum.Font.Gotham
    Lbl.TextColor3 = Color3.fromRGB(255, 255, 255)
    Lbl.TextSize = 12
    Lbl.TextXAlignment = Enum.TextXAlignment.Left

    local function UpdateLabelText(val)
        local baseText = Translations[CurrentLang][textKey] or textKey
        Lbl.Text = baseText .. ": " .. tostring(val)
    end
    UpdateLabelText(default)
    table.insert(TextElements, {Element = {Text = ""}, Key = textKey}) -- Регистрируем
    
    local Bar = Instance.new("TextButton", Frame)
    Bar.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
    Bar.Position = UDim2.new(0, 10, 0, 30)
    Bar.Size = UDim2.new(1, -20, 0, 10)
    Bar.Text = ""
    Bar.AutoButtonColor = false
    Instance.new("UICorner", Bar).CornerRadius = UDim.new(1, 0)

    local Fill = Instance.new("Frame", Bar)
    Fill.BackgroundColor3 = CurrentTheme.Accent
    Fill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
    Instance.new("UICorner", Fill).CornerRadius = UDim.new(1, 0)
    RegisterForRecolor(Fill, "BackgroundColor3")

    local isDragging = false
    local currentValue = default

    local function UpdateSliderValue(input)
        local barWidth = Bar.AbsoluteSize.X
        if barWidth == 0 then barWidth = 1 end
        local pos = math.clamp(input.Position.X - Bar.AbsolutePosition.X, 0, barWidth)
        local percent = pos / barWidth
        Fill.Size = UDim2.new(percent, 0, 1, 0)
        currentValue = math.floor(min + ((max - min) * percent))
        UpdateLabelText(currentValue)
        callback(currentValue)
    end

    Bar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then 
            isDragging = true 
            UpdateSliderValue(input)
        end
    end)

    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then 
            isDragging = false 
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if isDragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            UpdateSliderValue(input)
        end
    end)
end

local function CreateTextBox(parent, placeholder, callback)
    local Frame = Instance.new("Frame", parent)
    Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
    Frame.Size = UDim2.new(1, -10, 0, 35)
    Instance.new("UICorner", Frame).CornerRadius = UDim.new(0, 6)

    local Box = Instance.new("TextBox", Frame)
    Box.BackgroundTransparency = 1
    Box.Size = UDim2.new(1, -20, 1, 0)
    Box.Position = UDim2.new(0, 10, 0, 0)
    Box.Font = Enum.Font.Gotham
    Box.PlaceholderText = placeholder
    Box.Text = ""
    Box.TextColor3 = Color3.fromRGB(255, 255, 255)
    Box.TextSize = 12
    Box.TextXAlignment = Enum.TextXAlignment.Left

    Box.FocusLost:Connect(function() callback(Box.Text) end)
end

local function CreateInfoLabel(parent, text)
    local Lbl = Instance.new("TextLabel", parent)
    Lbl.BackgroundTransparency = 1
    Lbl.Size = UDim2.new(1, -10, 0, 20)
    Lbl.Font = Enum.Font.Gotham
    Lbl.Text = text
    Lbl.TextColor3 = Color3.fromRGB(200, 200, 200)
    Lbl.TextSize = 13
    Lbl.TextXAlignment = Enum.TextXAlignment.Left
    Lbl.TextWrapped = true
end

--==============================================================
-- TAB SYSTEM
--==============================================================

local PagesByName = {
    Main = MainPage,
    Troll = TrollPage,
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

local function CreateTabButton(nameKey, targetPage, posY)
    local Btn = Instance.new("TextButton", Sidebar)
    Btn.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
    Btn.BorderSizePixel = 0
    Btn.Position = UDim2.new(0, 10, 0, posY)
    Btn.Size = UDim2.new(1, -20, 0, 35)
    Btn.Font = Enum.Font.GothamSemibold
    Btn.TextColor3 = Color3.fromRGB(180, 180, 180)
    Btn.TextSize = 13
    Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 6)
    Btn:SetAttribute("IsActiveTab", false)
    RegisterText(Btn, nameKey)

    Btn.MouseButton1Click:Connect(function()
        MainPage.Visible = (targetPage == MainPage)
        InfoPage.Visible = (targetPage == InfoPage)
        for _, child in pairs(Sidebar:GetChildren()) do
            if child:IsA("TextButton") then
                child.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
                child.TextColor3 = Color3.fromRGB(180, 180, 180)
                child:SetAttribute("IsActiveTab", false)
            end
        end
        Btn.BackgroundColor3 = CurrentTheme.Accent
        Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        Btn:SetAttribute("IsActiveTab", true)
    end)

    RegisterForRecolor(Btn, "BackgroundColor3", true)
    return Btn
end

CreateTabButton("Main","TabMain")
CreateTabButton("Troll","TabTroll")
CreateTabButton("Visual","TabVisual")
CreateTabButton("Settings","TabSettings")
CreateTabButton("Info","TabInfo")

--==============================================================
-- TARGET DROPDOWN
--==============================================================

local function CreatePlayerDropdown(parent)
    local DropFrame = Instance.new("Frame", parent)
    DropFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
    DropFrame.Size = UDim2.new(1, -10, 0, 35)
    DropFrame.ClipsDescendants = true
    Instance.new("UICorner", DropFrame).CornerRadius = UDim.new(0, 6)

    local MainBtn = Instance.new("TextButton", DropFrame)
    MainBtn.Size = UDim2.new(1, 0, 0, 35)
    MainBtn.BackgroundTransparency = 1
    MainBtn.Font = Enum.Font.GothamBold
    MainBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    MainBtn.TextSize = 12
    MainBtn.TextXAlignment = Enum.TextXAlignment.Left
    RegisterText(MainBtn, "SelectPlr")

    local Arrow = Instance.new("TextLabel", MainBtn)
    Arrow.Size = UDim2.new(0, 30, 1, 0)
    Arrow.Position = UDim2.new(1, -30, 0, 0)
    Arrow.BackgroundTransparency = 1
    Arrow.Font = Enum.Font.GothamBold
    Arrow.Text = "▼"
    Arrow.TextColor3 = Color3.fromRGB(200, 200, 200)
    Arrow.TextSize = 12

    local Scroll = Instance.new("ScrollingFrame", DropFrame)
    Scroll.Position = UDim2.new(0, 5, 0, 35)
    Scroll.Size = UDim2.new(1, -10, 0, 110)
    Scroll.BackgroundTransparency = 1
    Scroll.ScrollBarThickness = 3
    Scroll.BorderSizePixel = 0

    local ListLayout = Instance.new("UIListLayout", Scroll)
    ListLayout.Padding = UDim.new(0, 4)

    local isOpen = false

    local function RefreshPlayers()
        for _, child in pairs(Scroll:GetChildren()) do
            if child:IsA("TextButton") then child:Destroy() end
        end

        for _, plr in pairs(Players:GetPlayers()) do
            if plr ~= LocalPlayer then
                local PlrBtn = Instance.new("TextButton", Scroll)
                PlrBtn.Size = UDim2.new(1, -5, 0, 25)
                PlrBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
                PlrBtn.Font = Enum.Font.Gotham
                PlrBtn.Text = "  " .. plr.DisplayName .. " (@" .. plr.Name .. ")"
                PlrBtn.TextColor3 = Color3.fromRGB(220, 220, 220)
                PlrBtn.TextSize = 11
                PlrBtn.TextXAlignment = Enum.TextXAlignment.Left
                Instance.new("UICorner", PlrBtn).CornerRadius = UDim.new(0, 4)

                PlrBtn.MouseButton1Click:Connect(function()
                    TrollState.TargetPlayer = plr
                    MainBtn.Text = "  " .. plr.DisplayName
                    isOpen = false
                    DropFrame.Size = UDim2.new(1, -10, 0, 35)
                    Arrow.Text = "▼"
                    Notify("Target", plr.DisplayName .. " " .. Translations[CurrentLang].PlrSelected, CurrentTheme.Accent)
                end)
            end
        end
        Scroll.CanvasSize = UDim2.new(0, 0, 0, ListLayout.AbsoluteContentSize.Y + 10)
    end

    MainBtn.MouseButton1Click:Connect(function()
        isOpen = not isOpen
        if isOpen then
            RefreshPlayers()
            DropFrame.Size = UDim2.new(1, -10, 0, 150)
            Arrow.Text = "▲"
        else
            DropFrame.Size = UDim2.new(1, -10, 0, 35)
            Arrow.Text = "▼"
        end
    end)

    Players.PlayerAdded:Connect(RefreshPlayers)
    Players.PlayerRemoving:Connect(RefreshPlayers)
end

--==============================================================
-- PRESERVED ORIGINAL LOGIC
--==============================================================

local function UseWeaponOnTarget(targetChar)
    pcall(function()
        if not targetChar then return end
        local char = LocalPlayer.Character
        if not char then return end

        local tool = char:FindFirstChildOfClass("Tool") or LocalPlayer.Backpack:FindFirstChildOfClass("Tool")
        if tool then
            if tool.Parent ~= char then tool.Parent = char end
            local handle = tool:FindFirstChild("Handle") or tool:FindFirstChildWhichIsA("BasePart")
            if handle then
                local firetouch = firetouchinterest or (syn and syn.firetouchinterest)
                if firetouch then
                    for _, part in pairs(targetChar:GetDescendants()) do
                        if part:IsA("BasePart") then
                            firetouch(handle, part, 0)
                            firetouch(handle, part, 1)
                        end
                    end
                else
                    handle.CFrame = targetChar:GetPivot()
                end
            end
        end
    end)
end

local function StopAllActions()
    TrollState.SpamSword = false
    TrollState.AttachTarget = nil
    TrollState.AttachMode = ""
    TrollState.FlingActive = false

    for _, fx in ipairs(TrollState.ActiveFX) do
        if fx then pcall(function() fx:Destroy() end) end
    end
    TrollState.ActiveFX = {}

    pcall(function()
        local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if hrp then
            local bv = hrp:FindFirstChild("FlyVelocity")
            local bg = hrp:FindFirstChild("FlyGyro")
            if bv then bv:Destroy() end
            if bg then bg:Destroy() end

            for _, obj in ipairs(hrp:GetChildren()) do
                if obj.Name == "FlingVelocity" or obj.Name == "FlingAngular" or obj.Name == "FlingForce" then
                    obj:Destroy()
                end
            end
        end
    end)

    pcall(function()
        local char = LocalPlayer.Character
        local hum = char and char:FindFirstChildOfClass("Humanoid")
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        if hum then
            hum.PlatformStand = false
            hum.AutoRotate = true
        end
        if hrp then
            hrp.Anchored = false
            hrp.AssemblyLinearVelocity = Vector3.zero
            hrp.AssemblyAngularVelocity = Vector3.zero
        end
    end)

    pcall(function()
        local char = LocalPlayer.Character
        if char then
            local ru = char:FindFirstChild("RightUpperArm") or char:FindFirstChild("Right Arm")
            local torso = char:FindFirstChild("Torso") or char:FindFirstChild("UpperTorso")
            local rs = (ru and ru:FindFirstChild("RightShoulder")) or (torso and torso:FindFirstChild("Right Shoulder"))
            if rs and rs:IsA("Motor6D") and TrollState.OriginalShoulderC0 then
                rs.C0 = TrollState.OriginalShoulderC0
                TrollState.OriginalShoulderC0 = nil
            end
        end
    end)

    -- Отключение заморозки
    TrollState.FreezeTarget = nil
    TrollState.FreezePos = nil
    TrollState.SpinTarget = nil
    TrollState.LoopKill = false
    TrollState.LoopKillTarget = nil
    TrollState.KillAura = false
    TrollState.ChatSpam = false
end


local function RunOrbitFling(target, isVoidMode)
    local myChar = LocalPlayer.Character
    local myHrp = myChar and myChar:FindFirstChild("HumanoidRootPart")
    local myHum = myChar and myChar:FindFirstChildOfClass("Humanoid")
    local targetChar = target and target.Character
    local targetHrp = targetChar and targetChar:FindFirstChild("HumanoidRootPart")

    if not (myHrp and targetHrp and myHum) then
        Notify("Error", "Character not loaded!", Color3.fromRGB(255, 0, 0))
        return
    end

    local oldPos = myHrp.CFrame
    local oldVelocity = myHrp.AssemblyLinearVelocity
    TrollState.FlingActive = true

    Notify(isVoidMode and "Void Fling" or "Orbit Fling", "Flinging: " .. target.DisplayName, CurrentTheme.Accent)

    task.spawn(function()
        -- Отключаем коллизии у всех частей кроме HRP, чтобы не застревать
        for _, part in pairs(myChar:GetDescendants()) do
            if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                part.CanCollide = false
                part.CanQuery = false
            end
        end

        -- Включаем коллизию у HRP для передачи импульса
        myHrp.CanCollide = true

        -- Создаём BodyVelocity для себя (будем двигаться с огромной скоростью)
        local myVelocity = Instance.new("BodyVelocity")
        myVelocity.Name = "FlingVelocity"
        myVelocity.MaxForce = Vector3.new(9e9, 9e9, 9e9)
        myVelocity.Parent = myHrp

        -- Для void fling будем толкать цель вниз
        if isVoidMode then
            -- Толкаем себя вниз вместе с целью
            myVelocity.Velocity = Vector3.new(0, -99999, 0)
            -- Также принудительно ставим цель вниз
            local targetVelocity = Instance.new("BodyVelocity")
            targetVelocity.Name = "TargetFlingVelocity"
            targetVelocity.MaxForce = Vector3.new(9e9, 9e9, 9e9)
            targetVelocity.Velocity = Vector3.new(0, -99999, 0)
            targetVelocity.Parent = targetHrp
            task.wait(0.5)
            targetVelocity:Destroy()
        else
            -- Orbit Fling: вращаемся вокруг цели с огромной скоростью
            local startTime = os.clock()
            while os.clock() - startTime < 4 and TrollState.FlingActive do
                local angle = os.clock() * 300
                local radius = 0.5
                local offset = Vector3.new(math.cos(angle) * radius, 0, math.sin(angle) * radius)
                local targetPos = targetHrp.Position
                local myPos = targetPos + offset
                -- Телепортируем себя в нужную позицию, чтобы постоянно касаться цели
                myHrp.CFrame = CFrame.new(myPos, targetPos)
                -- Устанавливаем скорость по касательной
                local tangent = Vector3.new(-math.sin(angle), 0, math.cos(angle)) * 99999
                myVelocity.Velocity = tangent
                -- Принудительно толкаем цель в случайную сторону
                targetHrp.AssemblyLinearVelocity = targetHrp.AssemblyLinearVelocity + Vector3.new(
                    math.random(-50000, 50000),
                    math.random(30000, 80000),
                    math.random(-50000, 50000)
                )
                RunService.Heartbeat:Wait()
            end
        end

        -- Останавливаем флинг
        TrollState.FlingActive = false
        myVelocity:Destroy()

        pcall(function()
            myHrp.AssemblyLinearVelocity = oldVelocity or Vector3.zero
            myHrp.AssemblyAngularVelocity = Vector3.zero
            myHrp.CFrame = oldPos
            myHum.PlatformStand = false
            myHum.AutoRotate = true
        end)

        -- Восстанавливаем коллизии
        for _, part in pairs(myChar:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = true
                part.CanQuery = true
            end
        end
        Notify("Fling Done", "Body restored.", CurrentTheme.Accent)
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

        if TrollState.Noclip then
            EnableNoclip()
        elseif next(TrollState._NoclipParts) ~= nil then
            DisableNoclip()
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
-- MOVEMENT CLEANUP HELPERS
--==============================================================

local function EnableNoclip()
    local char = LocalPlayer.Character
    if not char then
        return
    end

    for _,part in ipairs(char:GetDescendants()) do
        if part:IsA("BasePart") then
            if TrollState._NoclipParts[part] == nil then
                TrollState._NoclipParts[part] = {
                    CanCollide = part.CanCollide,
                    CanQuery = part.CanQuery
                }
            end

            part.CanCollide = false
            part.CanQuery = false
        end
    end
end

local function DisableNoclip()
    for part,state in pairs(TrollState._NoclipParts) do
        if part and part.Parent then
            pcall(function()
                part.CanCollide = state.CanCollide
                part.CanQuery = state.CanQuery
            end)
        end
    end

    TrollState._NoclipParts = {}
end

local function DisableFly()
    TrollState.Fly = false

    local char = LocalPlayer.Character
    if not char then
        return
    end

    local hrp =
        char:FindFirstChild("HumanoidRootPart")

    local hum =
        char:FindFirstChildOfClass("Humanoid")

    if hrp then
        local bv = hrp:FindFirstChild("FlyVelocity")
        local bg = hrp:FindFirstChild("FlyGyro")

        if bv then
            bv:Destroy()
        end

        if bg then
            bg:Destroy()
        end

        hrp.Anchored = false
        hrp.AssemblyLinearVelocity = Vector3.zero
        hrp.AssemblyAngularVelocity = Vector3.zero
    end

    if hum then
        hum.PlatformStand = false
        hum.AutoRotate = true
    end
end

--==============================================================
-- FLY
--==============================================================

local function ApplySmoothFly()
    pcall(function()
        local char = LocalPlayer.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        local hum = char and char:FindFirstChildOfClass("Humanoid")
        if not hrp or not hum then return end

        local bv = hrp:FindFirstChild("FlyVelocity") or Instance.new("BodyVelocity")
        bv.Name = "FlyVelocity"
        bv.MaxForce = Vector3.new(9e9, 9e9, 9e9)

        local bg = hrp:FindFirstChild("FlyGyro") or Instance.new("BodyGyro")
        bg.Name = "FlyGyro"
        bg.MaxTorque = Vector3.new(9e9, 9e9, 9e9)

        if TrollState.Fly then
            hum.PlatformStand = true
            bv.Parent = hrp
            bg.Parent = hrp

            local camera = workspace.CurrentCamera
            local cameraCFrame = camera.CFrame
            local moveDir = hum.MoveDirection

            if moveDir.Magnitude > 0 then
                local flyDir = Vector3.new(moveDir.X, cameraCFrame.LookVector.Y * (moveDir.Magnitude), moveDir.Z)
                if flyDir.Magnitude > 0 then flyDir = flyDir.Unit end
                bv.Velocity = flyDir * TrollState.FlySpeed
            else
                bv.Velocity = Vector3.zero
            end

            if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
                bv.Velocity = bv.Velocity + Vector3.new(0, TrollState.FlySpeed, 0)
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
                bv.Velocity = bv.Velocity - Vector3.new(0, TrollState.FlySpeed, 0)
            end

            bg.CFrame = cameraCFrame
        else
            if hrp:FindFirstChild("FlyVelocity") then hrp.FlyVelocity:Destroy() end
            if hrp:FindFirstChild("FlyGyro") then hrp.FlyGyro:Destroy() end
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
-- LIVE VISUAL LOOP
--==============================================================

RunService.RenderStepped:Connect(function()
    pcall(function()
        local camera = workspace.CurrentCamera

        if camera then
            camera.FieldOfView = TrollState.FOV
        end

        if TrollState.FullBright then
            Lighting.Ambient =
                Color3.fromRGB(255,255,255)

            Lighting.OutdoorAmbient =
                Color3.fromRGB(255,255,255)

            Lighting.Brightness = 3
            Lighting.ClockTime = 12
            Lighting.GlobalShadows = false
        end

        if TrollState.NoFog then
            Lighting.FogStart = 0
            Lighting.FogEnd = 1000000

            local atmosphere =
                Lighting:FindFirstChildOfClass(
                    "Atmosphere"
                )

            if atmosphere then
                atmosphere.Density = 0
                atmosphere.Haze = 0
                atmosphere.Glare = 0
            end
        end
    end)
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
    if not char then return end
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hum then return end
    
    hum.MaxHealth = 9e9
    hum.Health = hum.MaxHealth
    
    local function onDied()
        if TrollState.GodMode then
            hum.Health = hum.MaxHealth
            local hrp = char:FindFirstChild("HumanoidRootPart")
            if hrp then
                hrp.CFrame = hrp.CFrame + Vector3.new(0, 0.1, 0)
            end
        end
    end
    hum.Died:Connect(onDied)
    
    local healthLoop
    healthLoop = RunService.Heartbeat:Connect(function()
        if TrollState.GodMode and hum and hum.Parent then
            hum.Health = hum.MaxHealth
        else
            healthLoop:Disconnect()
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
    DisableNoclip()
    DisableFly()

    TrollState.FreezeTarget = nil
    TrollState.FreezePos = nil
    TrollState.SpinTarget = nil
    TrollState.LoopKillTarget = nil

    local whiteFxController = ToggleControllers["WhiteFX"]
    if TrollState.WhiteFX and whiteFxController then
        task.defer(function()
            pcall(function()
                whiteFxController(true)
            end)
        end)
    end

    for _, key in ipairs({"Fling","Freeze","SpinTarget","LoopKill"}) do
        if ToggleControllers[key] then
            pcall(function()
                ToggleControllers[key](false)
            end)
        end
    end

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
CreateToggle(MainPage,"Noclip",function(state)
    TrollState.Noclip = state

    if state then
        EnableNoclip()
    else
        DisableNoclip()

        local char = LocalPlayer.Character
        if char then
            for _,part in ipairs(char:GetDescendants()) do
                if part:IsA("BasePart") then
                    -- Restore defaults only where no prior snapshot exists.
                    if TrollState._NoclipParts[part] == nil then
                        pcall(function()
                            part.CanQuery = true
                        end)
                    end
                end
            end
        end
    end
end,false)
CreateToggle(MainPage,"Fly",function(state)
    if state then
        TrollState.Fly = true
        ApplySmoothFly()
    else
        DisableFly()
    end
end,false)
CreateSlider(MainPage,"FlySpeed",20,200,TrollState.FlySpeed,function(v) TrollState.FlySpeed = v end)

CreateInfoLabel(MainPage,"Main = personal movement and character utilities. Troll = target/trolling actions. Visual = camera/lighting. Settings = interface.")

--==============================================================
-- TROLL PAGE
--==============================================================

CreateSection(TrollPage,"SecTarget")
CreatePlayerDropdown(TrollPage)

CreateSection(TrollPage,"SecDestroy")

-- Unified Fling button: one-shot action; it auto-finishes.
CreateButton(TrollPage,"Fling",function()
    if not TrollState.TargetPlayer then
        Notify(
            "Target",
            Translations[CurrentLang].NoTarget,
            Color3.fromRGB(255,0,0)
        )
        return
    end

    RunOrbitFling(
        TrollState.TargetPlayer,
        false
    )
end)

-- Freeze: toggle off directly.
CreateToggle(TrollPage,"Freeze",function(state)
    if state then
        if TrollState.TargetPlayer then
            TrollState.FreezeTarget =
                TrollState.TargetPlayer

            TrollState.FreezePos = nil
        else
            Notify(
                "Target",
                Translations[CurrentLang].NoTarget,
                Color3.fromRGB(255,0,0)
            )

            if ToggleControllers["Freeze"] then
                ToggleControllers["Freeze"](false)
            end
        end
    else
        TrollState.FreezeTarget = nil
        TrollState.FreezePos = nil
    end
end,false)

-- Spin Target: toggle off directly.
CreateToggle(TrollPage,"SpinTarget",function(state)
    if state then
        if TrollState.TargetPlayer then
            TrollState.SpinTarget =
                TrollState.TargetPlayer
        else
            Notify(
                "Target",
                Translations[CurrentLang].NoTarget,
                Color3.fromRGB(255,0,0)
            )

            if ToggleControllers["SpinTarget"] then
                ToggleControllers["SpinTarget"](false)
            end
        end
    else
        TrollState.SpinTarget = nil
    end
end,false)

-- Loop Kill: toggle off directly.
CreateToggle(TrollPage,"LoopKill",function(state)
    if state then
        if TrollState.TargetPlayer then
            TrollState.LoopKillTarget =
                TrollState.TargetPlayer

            TrollState.LoopKill = true
        else
            Notify(
                "Target",
                Translations[CurrentLang].NoTarget,
                Color3.fromRGB(255,0,0)
            )

            if ToggleControllers["LoopKill"] then
                ToggleControllers["LoopKill"](false)
            end
        end
    else
        TrollState.LoopKill = false
        TrollState.LoopKillTarget = nil
    end
end,false)

-- One-shot action: teleport.
CreateButton(TrollPage,"TPTarget",function()
    local target = TrollState.TargetPlayer

    local myChar =
        LocalPlayer.Character

    local targetRoot =
        target
        and
        target.Character
        and
        target.Character:FindFirstChild(
            "HumanoidRootPart"
        )

    local myRoot =
        myChar
        and
        myChar:FindFirstChild(
            "HumanoidRootPart"
        )

    if targetRoot and myRoot then
        myRoot.CFrame =
            targetRoot.CFrame
            *
            CFrame.new(0,5,0)

        Notify(
            "Teleport",
            "Teleported to " .. target.DisplayName,
            CurrentTheme.Accent
        )
    else
        Notify(
            "Target",
            Translations[CurrentLang].NoTarget,
            Color3.fromRGB(255,0,0)
        )
    end
end)

CreateSection(TrollPage,"SecTargetTools")

CreateButton(TrollPage,"TargetInfo",function()
    local target =
        TrollState.TargetPlayer

    if not target then
        Notify(
            "Target",
            Translations[CurrentLang].NoTarget,
            Color3.fromRGB(255,0,0)
        )
        return
    end

    local tr =
        target.Character
        and
        target.Character:FindFirstChild(
            "HumanoidRootPart"
        )

    local th =
        target.Character
        and
        target.Character:FindFirstChildOfClass(
            "Humanoid"
        )

    local mr =
        LocalPlayer.Character
        and
        LocalPlayer.Character:FindFirstChild(
            "HumanoidRootPart"
        )

    if tr and mr then
        local d =
            math.floor(
                (tr.Position - mr.Position).Magnitude
            )

        local hp =
            th
            and
            math.floor(th.Health)
            or
            0

        Notify(
            "Target",
            target.DisplayName
                .. " • "
                .. d
                .. "m • HP "
                .. hp,
            CurrentTheme.Accent
        )
    end
end)

CreateButton(TrollPage,"TargetDistance",function()
    local target =
        TrollState.TargetPlayer

    local tr =
        target
        and
        target.Character
        and
        target.Character:FindFirstChild(
            "HumanoidRootPart"
        )

    local mr =
        LocalPlayer.Character
        and
        LocalPlayer.Character:FindFirstChild(
            "HumanoidRootPart"
        )

    if tr and mr then
        Notify(
            "Distance",
            target.DisplayName
                .. ": "
                .. math.floor(
                    (tr.Position - mr.Position).Magnitude
                )
                .. "m",
            CurrentTheme.Accent
        )
    else
        Notify(
            "Target",
            Translations[CurrentLang].NoTarget,
            Color3.fromRGB(255,0,0)
        )
    end
end)

CreateButton(TrollPage,"ClearTarget",function()
    TrollState.TargetPlayer = nil

    if ToggleControllers["Freeze"] then
        ToggleControllers["Freeze"](false)
    end

    if ToggleControllers["SpinTarget"] then
        ToggleControllers["SpinTarget"](false)
    end

    if ToggleControllers["LoopKill"] then
        ToggleControllers["LoopKill"](false)
    end

    Notify(
        "Target",
        "Target cleared.",
        CurrentTheme.Accent
    )
end)

CreateSection(TrollPage,"SecSelf")

CreateToggle(TrollPage,"KillAura",function(state)
    TrollState.KillAura = state
end,false)

CreateSlider(
    TrollPage,
    "AuraRange",
    5,
    50,
    TrollState.KillAuraRange,
    function(v)
        TrollState.KillAuraRange = v
    end
)

CreateToggle(TrollPage,"ChatSpam",function(state)
    TrollState.ChatSpam = state
end,false)

CreateTextBox(
    TrollPage,
    "Spam text...",
    TrollState.ChatSpamText,
    function(v)
        TrollState.ChatSpamText = v
    end
)

CreateSection(TrollPage,"SecMove")

CreateToggle(TrollPage,"FakeLagFPS",function(state)
    TrollState.FakeLagFPS = state
end,false)

CreateSlider(
    TrollPage,
    "SetLagFPS",
    1,
    100,
    TrollState.LagFPSValue,
    function(v)
        TrollState.LagFPSValue = v
    end
)

CreateToggle(TrollPage,"FakeLagNet",function(state)
    TrollState.FakeLagNet = state
end,false)

CreateToggle(TrollPage,"Spin",function(state)
    TrollState.Spin = state
end,false)

CreateSlider(
    TrollPage,
    "SpinSpeed",
    1,
    100,
    TrollState.SpinSpeed,
    function(v)
        TrollState.SpinSpeed = v
    end
)

--==============================================================
-- VISUAL PAGE
--==============================================================

CreateSection(VisualPage,"SecVisual")

CreateToggle(VisualPage,"FullBright",function(state)
    TrollState.FullBright = state

    if state then
        if not TrollState._OriginalLighting then
            TrollState._OriginalLighting = {
                Ambient = Lighting.Ambient,
                OutdoorAmbient = Lighting.OutdoorAmbient,
                Brightness = Lighting.Brightness,
                ClockTime = Lighting.ClockTime,
                GlobalShadows = Lighting.GlobalShadows,
                FogEnd = Lighting.FogEnd,
                FogStart = Lighting.FogStart
            }
        end
    elseif TrollState._OriginalLighting then
        local o = TrollState._OriginalLighting

        Lighting.Ambient = o.Ambient
        Lighting.OutdoorAmbient = o.OutdoorAmbient
        Lighting.Brightness = o.Brightness
        Lighting.ClockTime = o.ClockTime
        Lighting.GlobalShadows = o.GlobalShadows

        TrollState._OriginalLighting = nil
    end
end,false)

CreateToggle(VisualPage,"NoFog",function(state)
    TrollState.NoFog = state

    if state then
        if not TrollState._OriginalFog then
            local atmosphere =
                Lighting:FindFirstChildOfClass("Atmosphere")

            TrollState._OriginalFog = {
                FogStart = Lighting.FogStart,
                FogEnd = Lighting.FogEnd,
                Atmosphere = atmosphere and {
                    Instance = atmosphere,
                    Density = atmosphere.Density,
                    Haze = atmosphere.Haze,
                    Glare = atmosphere.Glare
                } or nil
            }
        end
    elseif TrollState._OriginalFog then
        local o = TrollState._OriginalFog

        Lighting.FogStart = o.FogStart
        Lighting.FogEnd = o.FogEnd

        if o.Atmosphere and o.Atmosphere.Instance and o.Atmosphere.Instance.Parent then
            o.Atmosphere.Instance.Density = o.Atmosphere.Density
            o.Atmosphere.Instance.Haze = o.Atmosphere.Haze
            o.Atmosphere.Instance.Glare = o.Atmosphere.Glare
        end

        TrollState._OriginalFog = nil
    end
end,false)

CreateSlider(
    VisualPage,
    "FOV",
    50,
    120,
    TrollState.FOV,
    function(v)
        TrollState.FOV = v

        local camera = workspace.CurrentCamera

        if camera then
            camera.FieldOfView = v
        end
    end
)

CreateToggle(VisualPage,"WhiteFX",function(state)
    TrollState.WhiteFX = state

    local char = LocalPlayer.Character
    local root =
        char
        and
        char:FindFirstChild(
            "HumanoidRootPart"
        )

    if not root then
        return
    end

    local existing =
        root:FindFirstChild(
            "TrollHubWhiteFX"
        )

    if existing then
        existing:Destroy()
    end

    if state then
        local emitter =
            Instance.new(
                "ParticleEmitter"
            )

        emitter.Name =
            "TrollHubWhiteFX"

        emitter.Texture =
            "rbxassetid://296874871"

        emitter.Rate = 18
        emitter.Lifetime =
            NumberRange.new(0.5,1.0)

        emitter.Speed =
            NumberRange.new(2,6)

        emitter.SpreadAngle =
            Vector2.new(180,180)

        emitter.Color =
            ColorSequence.new(
                Color3.fromRGB(255,255,255)
            )

        emitter.LightEmission = 1

        emitter.Size =
            NumberSequence.new(0.22)

        emitter.Parent = root
    end
end,false)

CreateInfoLabel(
    VisualPage,
    "FOV, FullBright and NoFog are local visual effects. WhiteFX is local too; it cannot be guaranteed to replicate to other clients without a server remote from the experience."
)

--==============================================================
-- SETTINGS PAGE
--==============================================================

CreateSection(SettingsPage,"SecInterface")

CreateToggle(
    SettingsPage,
    "WindowBackground",
    function(state)
        TrollState.ShowWindowBackground = state
        MainBackground.Visible = state

        -- Sidebar and body become glass when the image is on.
        Sidebar.BackgroundTransparency =
            state and 0.62 or 0.12
    end,
    false
)

CreateInfoLabel(
    SettingsPage,
    "Window background is OFF by default. Enable it to use the supplied image across the entire window."
)

CreateSection(SettingsPage,"SecTheme")

CreateButton(SettingsPage,"ThemeRed",function()
    ApplyTheme("Red")
    Notify(
        "Theme",
        Themes.Red.Name,
        Themes.Red.Accent
    )
end)

CreateButton(SettingsPage,"ThemeBlue",function()
    ApplyTheme("Blue")
    Notify(
        "Theme",
        Themes.Blue.Name,
        Themes.Blue.Accent
    )
end)

CreateButton(SettingsPage,"ThemePurple",function()
    ApplyTheme("Purple")
    Notify(
        "Theme",
        Themes.Purple.Name,
        Themes.Purple.Accent
    )
end)

CreateButton(SettingsPage,"ThemeGreen",function()
    ApplyTheme("Green")
    Notify(
        "Theme",
        Themes.Green.Name,
        Themes.Green.Accent
    )
end)

CreateButton(SettingsPage,"ThemeGold",function()
    ApplyTheme("Gold")
    Notify(
        "Theme",
        Themes.Gold.Name,
        Themes.Gold.Accent
    )
end)

CreateInfoLabel(
    SettingsPage,
    "Persistent functions now use switches and can be disabled directly by pressing the same switch again."
)

--==============================================================
-- INFO PAGE
--==============================================================

CreateSection(InfoPage,"InfoDev")

CreateInfoLabel(
    InfoPage,
    "Автор и разработчик: Legenly"
)

CreateInfoLabel(
    InfoPage,
    "HUB - Troll & Universal • Premium UI"
)

CreateInfoLabel(
    InfoPage,
    "LGK — группа разработчиков проекта."
)

CreateSection(InfoPage,"InfoDiscord")

local DiscordButton = Instance.new("TextButton")
DiscordButton.Size =
    UDim2.new(1,0,0,43)

DiscordButton.BackgroundColor3 =
    Color3.fromRGB(29,29,36)

DiscordButton.BorderSizePixel = 0

DiscordButton.Font =
    Enum.Font.GothamBold

DiscordButton.TextSize = 12

DiscordButton.TextColor3 =
    Color3.fromRGB(150,190,255)

DiscordButton.Text =
    "Copy Discord Link"

DiscordButton.ZIndex = 108
DiscordButton.Parent = InfoPage

local discordCorner =
    Instance.new("UICorner")

discordCorner.CornerRadius =
    UDim.new(0,11)

discordCorner.Parent =
    DiscordButton

local discordStroke =
    Instance.new("UIStroke")

discordStroke.Thickness = 1
discordStroke.Transparency = 0.45
discordStroke.Color = CurrentTheme.Accent
discordStroke.Parent = DiscordButton

RegisterForRecolor(
    discordStroke,
    "Color"
)

DiscordButton.Activated:Connect(function()
    local link =
        "https://discord.gg/vpfFGGjg9"

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
            "Copy is unavailable in this executor.",
            Color3.fromRGB(255,170,70)
        )
    end
end)

CreateInfoLabel(
    InfoPage,
    "LGK is only mentioned here because it is the developer group, not the hub name."
)

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

local function MakeDraggable(dragArea, frameToMove, isIsland)
    local dragging = false
    local dragStart, startPos
    local hasMoved = false

    dragArea.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            hasMoved = false
            dragStart = input.Position
            startPos = frameToMove.Position
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStart
            if delta.Magnitude > 3 then
                hasMoved = true
            end
            frameToMove.Position = UDim2.new(
                startPos.X.Scale, startPos.X.Offset + delta.X, 
                startPos.Y.Scale, startPos.Y.Offset + delta.Y
            )
        end
    end)

    dragArea.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
            if isIsland and not hasMoved then
                IslandFrame.Visible = false
                MainFrame.Visible = true
            end
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
    IslandFrame.Size = UDim2.fromOffset(22,22)

    TweenService:Create(
        IslandFrame,
        TweenInfo.new(
            0.32,
            Enum.EasingStyle.Back,
            Enum.EasingDirection.Out
        ),
        {
            Size = UDim2.fromOffset(142,38)
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
            Size = UDim2.fromOffset(22,22)
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
print("Target Engine: merged into Troll tab")
print("Orbit Fling: PRESERVED")
print("Fling: one-shot button")
print("Freeze: PRESERVED")
print("Spin Target: PRESERVED")
print("Teleport Target: PRESERVED")
print("Loop Kill: PRESERVED")
print("Sexual target actions: REMOVED")
print("Kill Aura: PRESERVED")
print("Noclip/Fly/GodMode: PRESERVED")
print("================================================")


--==============================================================
-- PRESERVED NATIVE FUNCTIONS FROM ORIGINAL Help.lua.txt
--==============================================================

local function ApplyEjaculationFX()
    pcall(function()
        local char = LocalPlayer.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        if not hrp then return end

        local tool = char:FindFirstChildOfClass("Tool") or LocalPlayer.Backpack:FindFirstChildOfClass("Tool")
        local parentObj = hrp
        if tool and tool:FindFirstChild("Handle") then
            if tool.Parent ~= char then tool.Parent = char end
            parentObj = tool.Handle
        end

        local pe = Instance.new("ParticleEmitter")
        pe.Name = "SpermFX"
        pe.Texture = "rbxassetid://243132757"
        pe.Rate = 50
        pe.Speed = NumberRange.new(12, 22)
        pe.VelocitySpread = 35
        pe.Lifetime = NumberRange.new(0.6, 1.2)
        pe.Color = ColorSequence.new(Color3.fromRGB(255, 255, 255))
        pe.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.5), NumberSequenceKeypoint.new(1, 0.05)})
        pe.EmissionDirection = Enum.NormalId.Front
        pe.Parent = parentObj
        table.insert(TrollState.ActiveFX, pe)

        local sound = Instance.new("Sound")
        sound.Name = "SpermSound"
        sound.SoundId = "rbxassetid://9114223190"
        sound.Volume = 3.5
        sound.Looped = true
        sound.PlaybackSpeed = 1.05
        sound.Parent = hrp
        sound:Play()
        table.insert(TrollState.ActiveFX, sound)
    end)
end

local function CreateThemeBtn(key)
    local btn = Instance.new("TextButton", MainPage)
    btn.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
    btn.Size = UDim2.new(1, -10, 0, 30)
    btn.Font = Enum.Font.GothamBold
    btn.Text = "Theme: " .. Themes[key].Name
    btn.TextColor3 = Themes[key].Accent
    btn.TextSize = 12
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)

    btn.MouseButton1Click:Connect(function()
        ApplyTheme(key)
        Notify("Theme", Themes[key].Name, Themes[key].Accent)
    end)
end

