--[[
==============================================================
              LEGENLY HUB - TROLL & UNIVERSAL
                    Hardcore Premium Edition
                         Help.lua
                         by Legenly
==============================================================

VISUAL UPDATE
• LGK-style premium splash/loading
• Logo in splash, window header and Dynamic Island
• Window background image
• Smooth open / close / minimize animations
• Mobile-friendly dragging
• Animated buttons and toggles
• RU / EN without false language notifications
• Renamed "Точить шпагу" -> "Чесать спину"
• "Чесать спину" -> "Scratch Back" in English
• Theme system retained
• Target dropdown retained
• Existing universal/local utility systems retained

ASSETS
Logo:
rbxassetid://125281744611585

Window background:
rbxassetid://118369774163238
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
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")
local TextChatService = game:GetService("TextChatService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local ContentProvider = game:GetService("ContentProvider")

local LocalPlayer = Players.LocalPlayer

--==============================================================
-- ASSETS / CONFIG
--==============================================================

local LOGO = "rbxassetid://125281744611585"
local WINDOW_BACKGROUND = "rbxassetid://118369774163238"

local Config = {
    SplashTime = 6,
    WindowWidth = 560,
    WindowHeight = 410,
    IslandWidth = 118,
    IslandHeight = 38,
    AccentGlow = 0.84
}

local Themes = {
    Red = {
        Accent = Color3.fromRGB(255, 60, 60),
        Name = "Ruby Red"
    },

    Blue = {
        Accent = Color3.fromRGB(60, 150, 255),
        Name = "Deep Blue"
    },

    Purple = {
        Accent = Color3.fromRGB(180, 60, 255),
        Name = "Amethyst Purple"
    },

    Green = {
        Accent = Color3.fromRGB(60, 255, 120),
        Name = "Acid Green"
    },

    Gold = {
        Accent = Color3.fromRGB(255, 190, 60),
        Name = "Luxury Gold"
    }
}

local CurrentTheme = Themes.Red
local CurrentLang = "RU"

--==============================================================
-- DUPLICATE CLEANUP
--==============================================================

local function GetGuiParent()
    if typeof(gethui) == "function" then
        local ok, result = pcall(gethui)
        if ok and result then
            return result
        end
    end

    return CoreGui
end

local Parent = GetGuiParent()

local old = Parent:FindFirstChild("LegenlyTrollHub_Ultimate")
if old then
    pcall(function()
        old:Destroy()
    end)
end

--==============================================================
-- TRANSLATIONS
--==============================================================

local Translations = {
    RU = {
        Title = "HUB - Troll & Universal",
        TabMain = "Главная",
        TabInfo = "Инфо",

        SecMove = "Движение & Лаги",
        EgorSpeed = "Скорость Роблокс Егора",
        FakeLagFPS = "Фейк лаги [ФПС]",
        SetLagFPS = "Настройка лагов [ФПС]",
        FakeLagNet = "Фейк лаги [Интернет]",

        SecTroll = "Троллинг",
        Spin = "Вращение",
        SpinSpeed = "Скорость вращения",
        SpamSword = "Чесать спину",
        ArmSpeed = "Скорость руки",

        SecTarget = "Выбор Жертвы",
        SelectPlr = "  Цель: Выберите игрока...",

        SecDestroy = "Уничтожение Игроков",
        OrbitFling = "ORBIT FLING (Уничтожить цель)",
        VoidFling = "VOID FLING (Под текстуры)",
        Freeze = "Заморозить цель",
        Unfreeze = "Разморозить цель",
        SpinTarget = "Закрутить цель",
        TPTarget = "Телепорт к цели",
        LoopKill = "Зацикленный килл цели",

        SecGang = "Gang Bang (Троллинг)",
        FuckBack = "Прилипнуть сзади",
        FuckFront = "Прилипнуть спереди",
        Victim = "Стать жертвой (Лечь)",

        SecSelf = "Собственные функции",
        GodMode = "God Mode (Бессмертие)",
        Noclip = "Noclip (Сквозь стены)",
        Fly = "Fly (Полет)",
        FlySpeed = "Скорость полета",
        KillAura = "Kill Aura (Аура)",
        AuraRange = "Радиус Kill Aura",
        ChatSpam = "Спамер в чат",
        ChatPlaceholder = "Текст для спама...",

        StopAll = "ОСТАНОВИТЬ ВСЕ ДЕЙСТВИЯ",

        SecTheme = "Оформление Хаба",
        DiscordBtn = "Скопировать ссылку на Discord",

        InfoDev = "Автор и разработчик: Legenly",
        InfoName = "Проект: HUB - Troll & Universal",
        InfoDisc = "Discord канал с обновлениями:",

        Ready = "HUB готов",
        Splash1 = "Загрузка интерфейса...",
        Splash2 = "Загрузка систем...",
        Splash3 = "Подготовка управления...",
        Splash4 = "Применение темы...",
        Splash5 = "Подготовка HUB...",
        TargetSelected = "выбран в качестве цели!",
        LanguageChanged = "Язык изменен на Русский"
    },

    EN = {
        Title = "HUB - Troll & Universal",
        TabMain = "Main",
        TabInfo = "Info",

        SecMove = "Movement & Lag",
        EgorSpeed = "Roblox Egor Speed",
        FakeLagFPS = "Fake Lag [FPS]",
        SetLagFPS = "Lag Delay [FPS]",
        FakeLagNet = "Fake Lag [Network]",

        SecTroll = "Troll Features",
        Spin = "Character Spin",
        SpinSpeed = "Spin Speed",
        SpamSword = "Scratch Back",
        ArmSpeed = "Hand Speed",

        SecTarget = "Select Target",
        SelectPlr = "  Target: Select player...",

        SecDestroy = "Destroy Players",
        OrbitFling = "ORBIT FLING (Destroy Target)",
        VoidFling = "VOID FLING (Under Map)",
        Freeze = "Freeze Target",
        Unfreeze = "Unfreeze Target",
        SpinTarget = "Spin Target",
        TPTarget = "Teleport to Target",
        LoopKill = "Loop Kill Target",

        SecGang = "Attach Trolling",
        FuckBack = "Attach Behind",
        FuckFront = "Attach Front",
        Victim = "Become Victim (Lay down)",

        SecSelf = "Self Utility",
        GodMode = "God Mode (Invincible)",
        Noclip = "Noclip (Walk Through)",
        Fly = "Fly Mode",
        FlySpeed = "Fly Speed",
        KillAura = "Kill Aura",
        AuraRange = "Kill Aura Range",
        ChatSpam = "Chat Spammer",
        ChatPlaceholder = "Spam text...",

        StopAll = "STOP ALL ACTIONS",

        SecTheme = "Hub Appearance",
        DiscordBtn = "Copy Discord Link",

        InfoDev = "Author & Developer: Legenly",
        InfoName = "Project: HUB - Troll & Universal",
        InfoDisc = "Discord Server for Updates:",

        Ready = "HUB ready",
        Splash1 = "Loading interface...",
        Splash2 = "Loading systems...",
        Splash3 = "Preparing controls...",
        Splash4 = "Applying theme...",
        Splash5 = "Preparing HUB...",
        TargetSelected = "selected as target!",
        LanguageChanged = "Language switched to English"
    }
}

local function T(key)
    return Translations[CurrentLang][key] or key
end

--==============================================================
-- RECOLOR / TEXT REGISTRIES
--==============================================================

local RecolorQueue = {}
local TextElements = {}

local function RegisterForRecolor(element, property, checkActiveState)
    table.insert(RecolorQueue, function(newColor)
        if not element or not element.Parent then
            return false
        end

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

local function ApplyTheme(themeKey)
    local theme = Themes[themeKey]
    if not theme then
        return
    end

    CurrentTheme = theme

    local clean = {}

    for _, fn in ipairs(RecolorQueue) do
        local ok, keep = pcall(fn, theme.Accent)

        if ok and keep ~= false then
            table.insert(clean, fn)
        end
    end

    RecolorQueue = clean
end

local function RegisterText(element, key)
    table.insert(TextElements, {
        Element = element,
        Key = key
    })

    pcall(function()
        element.Text = T(key)
    end)
end

local function RefreshTexts()
    for _, item in ipairs(TextElements) do
        if item.Element and item.Element.Parent then
            pcall(function()
                local value = T(item.Key)
                if value then
                    item.Element.Text = value
                end
            end)
        end
    end
end

local function SwitchLanguage(lang, silent)
    if lang ~= "RU" and lang ~= "EN" then
        return
    end

    CurrentLang = lang
    RefreshTexts()

    if not silent then
        Notify(
            "Language",
            T("LanguageChanged"),
            CurrentTheme.Accent
        )
    end
end

--==============================================================
-- TWEEN HELPERS
--==============================================================

local function TweenObject(object, info, properties)
    if not object or not object.Parent then
        return nil
    end

    local ok, tween = pcall(function()
        return TweenService:Create(object, info, properties)
    end)

    if ok and tween then
        tween:Play()
        return tween
    end
end

local FAST = TweenInfo.new(
    0.18,
    Enum.EasingStyle.Quint,
    Enum.EasingDirection.Out
)

local MED = TweenInfo.new(
    0.32,
    Enum.EasingStyle.Quint,
    Enum.EasingDirection.Out
)

local SMOOTH = TweenInfo.new(
    0.48,
    Enum.EasingStyle.Quint,
    Enum.EasingDirection.Out
)

--==============================================================
-- SCRIPT STATE
--==============================================================

local TrollState = {
    EgorSpeed = false,
    FakeLagFPS = false,
    LagFPSValue = 10,
    FakeLagNet = false,

    Spin = false,
    SpinSpeed = 10,

    SpamSword = false,
    SpamSwordSpeed = 20,

    TargetPlayer = nil,

    AttachTarget = nil,
    AttachMode = "",

    FlingActive = false,

    OriginalShoulderC0 = nil,
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

    VictimLocked = false
}

--==============================================================
-- GUI
--==============================================================

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "LegenlyTrollHub_Ultimate"
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = Parent

--==============================================================
-- NOTIFICATIONS
--==============================================================

local NotificationHolder = Instance.new("Frame", ScreenGui)
NotificationHolder.Name = "NotificationHolder"
NotificationHolder.AnchorPoint = Vector2.new(1, 1)
NotificationHolder.Position = UDim2.new(1, -15, 1, -15)
NotificationHolder.Size = UDim2.fromOffset(290, 400)
NotificationHolder.BackgroundTransparency = 1
NotificationHolder.ZIndex = 700

local NotificationLayout = Instance.new("UIListLayout", NotificationHolder)
NotificationLayout.VerticalAlignment = Enum.VerticalAlignment.Bottom
NotificationLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
NotificationLayout.Padding = UDim.new(0, 8)

function Notify(title, message, color)
    color = color or CurrentTheme.Accent

    local frame = Instance.new("Frame")
    frame.Size = UDim2.fromOffset(280, 66)
    frame.BackgroundColor3 = Color3.fromRGB(14, 14, 20)
    frame.BackgroundTransparency = 1
    frame.BorderSizePixel = 0
    frame.ZIndex = 710
    frame.Parent = NotificationHolder

    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 12)

    local stroke = Instance.new("UIStroke", frame)
    stroke.Thickness = 1
    stroke.Transparency = 0.45
    stroke.Color = color

    local accent = Instance.new("Frame", frame)
    accent.Size = UDim2.fromOffset(4, 66)
    accent.BackgroundColor3 = color
    accent.BorderSizePixel = 0
    accent.ZIndex = 711
    Instance.new("UICorner", accent).CornerRadius = UDim.new(0, 12)

    local titleLabel = Instance.new("TextLabel", frame)
    titleLabel.Position = UDim2.fromOffset(15, 7)
    titleLabel.Size = UDim2.new(1, -22, 0, 20)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.Text = title
    titleLabel.TextSize = 13
    titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.TextTransparency = 1
    titleLabel.ZIndex = 711

    local messageLabel = Instance.new("TextLabel", frame)
    messageLabel.Position = UDim2.fromOffset(15, 29)
    messageLabel.Size = UDim2.new(1, -22, 0, 28)
    messageLabel.BackgroundTransparency = 1
    messageLabel.Font = Enum.Font.Gotham
    messageLabel.Text = message
    messageLabel.TextSize = 11
    messageLabel.TextWrapped = true
    messageLabel.TextColor3 = Color3.fromRGB(185, 185, 195)
    messageLabel.TextXAlignment = Enum.TextXAlignment.Left
    messageLabel.TextYAlignment = Enum.TextYAlignment.Top
    messageLabel.TextTransparency = 1
    messageLabel.ZIndex = 711

    TweenObject(frame, MED, {
        BackgroundTransparency = 0.08
    })

    TweenObject(titleLabel, MED, {
        TextTransparency = 0
    })

    TweenObject(messageLabel, MED, {
        TextTransparency = 0
    })

    task.delay(2.8, function()
        if not frame.Parent then
            return
        end

        TweenObject(frame, MED, {
            BackgroundTransparency = 1
        })

        TweenObject(titleLabel, MED, {
            TextTransparency = 1
        })

        TweenObject(messageLabel, MED, {
            TextTransparency = 1
        })

        task.wait(0.35)

        if frame.Parent then
            frame:Destroy()
        end
    end)
end

--==============================================================
-- SPLASH
--==============================================================

local Splash = Instance.new("Frame", ScreenGui)
Splash.Name = "Splash"
Splash.Size = UDim2.fromScale(1, 1)
Splash.BackgroundColor3 = Color3.fromRGB(6, 6, 9)
Splash.BorderSizePixel = 0
Splash.ZIndex = 500

local SplashGlow = Instance.new("Frame", Splash)
SplashGlow.AnchorPoint = Vector2.new(0.5, 0.5)
SplashGlow.Position = UDim2.fromScale(0.5, 0.40)
SplashGlow.Size = UDim2.fromOffset(190, 190)
SplashGlow.BackgroundColor3 = CurrentTheme.Accent
SplashGlow.BackgroundTransparency = 0.93
SplashGlow.BorderSizePixel = 0
SplashGlow.ZIndex = 500
Instance.new("UICorner", SplashGlow).CornerRadius = UDim.new(1, 0)

local SplashLogo = Instance.new("ImageLabel", Splash)
SplashLogo.AnchorPoint = Vector2.new(0.5, 0.5)
SplashLogo.Position = UDim2.fromScale(0.5, 0.34)
SplashLogo.Size = UDim2.fromOffset(112, 112)
SplashLogo.BackgroundTransparency = 1
SplashLogo.Image = LOGO
SplashLogo.ImageTransparency = 1
SplashLogo.ZIndex = 502
Instance.new("UICorner", SplashLogo).CornerRadius = UDim.new(0, 24)

local SplashStroke = Instance.new("UIStroke", SplashLogo)
SplashStroke.Thickness = 2
SplashStroke.Transparency = 1
SplashStroke.Color = CurrentTheme.Accent

local SplashTitle = Instance.new("TextLabel", Splash)
SplashTitle.AnchorPoint = Vector2.new(0.5, 0.5)
SplashTitle.Position = UDim2.fromScale(0.5, 0.505)
SplashTitle.Size = UDim2.fromScale(0.82, 0.07)
SplashTitle.BackgroundTransparency = 1
SplashTitle.Text = T("Title")
SplashTitle.Font = Enum.Font.GothamBold
SplashTitle.TextScaled = true
SplashTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
SplashTitle.TextTransparency = 1
SplashTitle.ZIndex = 502

local SplashAuthor = Instance.new("TextLabel", Splash)
SplashAuthor.AnchorPoint = Vector2.new(0.5, 0.5)
SplashAuthor.Position = UDim2.fromScale(0.5, 0.565)
SplashAuthor.Size = UDim2.fromScale(0.65, 0.035)
SplashAuthor.BackgroundTransparency = 1
SplashAuthor.Text = "Legenly"
SplashAuthor.Font = Enum.Font.Gotham
SplashAuthor.TextScaled = true
SplashAuthor.TextColor3 = Color3.fromRGB(150, 150, 160)
SplashAuthor.TextTransparency = 1
SplashAuthor.ZIndex = 502

local SplashStatus = Instance.new("TextLabel", Splash)
SplashStatus.AnchorPoint = Vector2.new(0.5, 0.5)
SplashStatus.Position = UDim2.fromScale(0.5, 0.63)
SplashStatus.Size = UDim2.fromScale(0.78, 0.035)
SplashStatus.BackgroundTransparency = 1
SplashStatus.Text = ""
SplashStatus.Font = Enum.Font.Gotham
SplashStatus.TextScaled = true
SplashStatus.TextColor3 = Color3.fromRGB(105, 145, 200)
SplashStatus.TextTransparency = 1
SplashStatus.ZIndex = 502

RegisterForRecolor(SplashGlow, "BackgroundColor3")
RegisterForRecolor(SplashStroke, "Color")

--==============================================================
-- MAIN WINDOW
--==============================================================

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Name = "MainFrame"
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.Position = UDim2.fromScale(0.5, 0.5)
MainFrame.Size = UDim2.fromOffset(Config.WindowWidth, Config.WindowHeight)
MainFrame.BackgroundColor3 = Color3.fromRGB(11, 11, 16)
MainFrame.BackgroundTransparency = 0.02
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.Visible = false
MainFrame.ZIndex = 20

Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 16)

local MainStroke = Instance.new("UIStroke", MainFrame)
MainStroke.Thickness = 1
MainStroke.Transparency = 0.55
MainStroke.Color = CurrentTheme.Accent
RegisterForRecolor(MainStroke, "Color")

local WindowBackground = Instance.new("ImageLabel", MainFrame)
WindowBackground.Name = "WindowBackground"
WindowBackground.Size = UDim2.fromScale(1, 1)
WindowBackground.BackgroundTransparency = 1
WindowBackground.Image = WINDOW_BACKGROUND
WindowBackground.ScaleType = Enum.ScaleType.Crop
WindowBackground.ImageTransparency = 0.64
WindowBackground.ZIndex = 20

local WindowOverlay = Instance.new("Frame", MainFrame)
WindowOverlay.Size = UDim2.fromScale(1, 1)
WindowOverlay.BackgroundColor3 = Color3.fromRGB(6, 7, 11)
WindowOverlay.BackgroundTransparency = 0.34
WindowOverlay.BorderSizePixel = 0
WindowOverlay.ZIndex = 21

--==============================================================
-- TITLE BAR
--==============================================================

local TitleBar = Instance.new("Frame", MainFrame)
TitleBar.Name = "TitleBar"
TitleBar.BackgroundColor3 = Color3.fromRGB(8, 8, 13)
TitleBar.BackgroundTransparency = 0.18
TitleBar.Size = UDim2.new(1, 0, 0, 48)
TitleBar.BorderSizePixel = 0
TitleBar.ZIndex = 30

local TitleBarStroke = Instance.new("UIStroke", TitleBar)
TitleBarStroke.Thickness = 1
TitleBarStroke.Transparency = 0.72
TitleBarStroke.Color = CurrentTheme.Accent
RegisterForRecolor(TitleBarStroke, "Color")

local HeaderLogo = Instance.new("ImageLabel", TitleBar)
HeaderLogo.Name = "HeaderLogo"
HeaderLogo.Size = UDim2.fromOffset(30, 30)
HeaderLogo.Position = UDim2.fromOffset(9, 9)
HeaderLogo.BackgroundTransparency = 1
HeaderLogo.Image = LOGO
HeaderLogo.ZIndex = 31
Instance.new("UICorner", HeaderLogo).CornerRadius = UDim.new(0, 8)

local HeaderStroke = Instance.new("UIStroke", HeaderLogo)
HeaderStroke.Thickness = 1
HeaderStroke.Transparency = 0.35
HeaderStroke.Color = CurrentTheme.Accent
RegisterForRecolor(HeaderStroke, "Color")

local TitleText = Instance.new("TextLabel", TitleBar)
TitleText.BackgroundTransparency = 1
TitleText.Position = UDim2.fromOffset(48, 0)
TitleText.Size = UDim2.new(1, -160, 1, 0)
TitleText.Font = Enum.Font.GothamBold
TitleText.TextColor3 = CurrentTheme.Accent
TitleText.TextSize = 14
TitleText.TextXAlignment = Enum.TextXAlignment.Left
TitleText.ZIndex = 31
RegisterText(TitleText, "Title")
RegisterForRecolor(TitleText, "TextColor3")

local LangBtn = Instance.new("TextButton", TitleBar)
LangBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 36)
LangBtn.BackgroundTransparency = 0.08
LangBtn.Position = UDim2.new(1, -102, 0.5, -13)
LangBtn.Size = UDim2.fromOffset(57, 26)
LangBtn.Font = Enum.Font.GothamBold
LangBtn.Text = "RU / EN"
LangBtn.TextColor3 = Color3.fromRGB(225, 225, 230)
LangBtn.TextSize = 10
LangBtn.AutoButtonColor = false
LangBtn.ZIndex = 32
Instance.new("UICorner", LangBtn).CornerRadius = UDim.new(0, 7)

local LangStroke = Instance.new("UIStroke", LangBtn)
LangStroke.Thickness = 1
LangStroke.Transparency = 0.55
LangStroke.Color = CurrentTheme.Accent
RegisterForRecolor(LangStroke, "Color")

local MinimizeBtn = Instance.new("TextButton", TitleBar)
MinimizeBtn.BackgroundTransparency = 1
MinimizeBtn.Position = UDim2.new(1, -42, 0, 0)
MinimizeBtn.Size = UDim2.fromOffset(42, 48)
MinimizeBtn.Font = Enum.Font.GothamBold
MinimizeBtn.Text = "−"
MinimizeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizeBtn.TextSize = 22
MinimizeBtn.AutoButtonColor = false
MinimizeBtn.ZIndex = 32

--==============================================================
-- SIDEBAR
--==============================================================

local Sidebar = Instance.new("Frame", MainFrame)
Sidebar.Name = "Sidebar"
Sidebar.BackgroundColor3 = Color3.fromRGB(13, 13, 18)
Sidebar.BackgroundTransparency = 0.12
Sidebar.Position = UDim2.new(0, 0, 0, 48)
Sidebar.Size = UDim2.new(0, 145, 1, -48)
Sidebar.BorderSizePixel = 0
Sidebar.ZIndex = 25

local SidebarGradient = Instance.new("UIGradient", Sidebar)
SidebarGradient.Rotation = 90
SidebarGradient.Transparency = NumberSequence.new({
    NumberSequenceKeypoint.new(0, 0.05),
    NumberSequenceKeypoint.new(1, 0.28)
})

local Pages = Instance.new("Frame", MainFrame)
Pages.Name = "Pages"
Pages.BackgroundTransparency = 1
Pages.Position = UDim2.new(0, 155, 0, 58)
Pages.Size = UDim2.new(1, -165, 1, -68)
Pages.ZIndex = 26

local MainPage = Instance.new("ScrollingFrame", Pages)
MainPage.Name = "MainPage"
MainPage.BackgroundTransparency = 1
MainPage.Size = UDim2.fromScale(1, 1)
MainPage.ScrollBarThickness = 3
MainPage.ScrollBarImageColor3 = CurrentTheme.Accent
MainPage.BorderSizePixel = 0
MainPage.ZIndex = 27

local InfoPage = Instance.new("ScrollingFrame", Pages)
InfoPage.Name = "InfoPage"
InfoPage.BackgroundTransparency = 1
InfoPage.Size = UDim2.fromScale(1, 1)
InfoPage.ScrollBarThickness = 3
InfoPage.ScrollBarImageColor3 = CurrentTheme.Accent
InfoPage.BorderSizePixel = 0
InfoPage.Visible = false
InfoPage.ZIndex = 27

local UIListLayoutMain = Instance.new("UIListLayout", MainPage)
UIListLayoutMain.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayoutMain.Padding = UDim.new(0, 8)

UIListLayoutMain:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    MainPage.CanvasSize = UDim2.new(0, 0, 0, UIListLayoutMain.AbsoluteContentSize.Y + 20)
end)

local UIListLayoutInfo = Instance.new("UIListLayout", InfoPage)
UIListLayoutInfo.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayoutInfo.Padding = UDim.new(0, 8)

UIListLayoutInfo:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    InfoPage.CanvasSize = UDim2.new(0, 0, 0, UIListLayoutInfo.AbsoluteContentSize.Y + 20)
end)

--==============================================================
-- TAB BUTTONS
--==============================================================

local function CreateTabButton(nameKey, targetPage, posY)
    local Btn = Instance.new("TextButton", Sidebar)
    Btn.BackgroundColor3 = Color3.fromRGB(29, 29, 35)
    Btn.BackgroundTransparency = 0.13
    Btn.BorderSizePixel = 0
    Btn.Position = UDim2.new(0, 10, 0, posY)
    Btn.Size = UDim2.new(1, -20, 0, 36)
    Btn.Font = Enum.Font.GothamSemibold
    Btn.TextColor3 = Color3.fromRGB(180, 180, 188)
    Btn.TextSize = 12
    Btn.AutoButtonColor = false
    Btn.ZIndex = 28
    Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 9)
    Btn:SetAttribute("IsActiveTab", false)

    RegisterText(Btn, nameKey)

    Btn.MouseButton1Click:Connect(function()
        MainPage.Visible = (targetPage == MainPage)
        InfoPage.Visible = (targetPage == InfoPage)

        for _, child in ipairs(Sidebar:GetChildren()) do
            if child:IsA("TextButton") then
                child.BackgroundColor3 = Color3.fromRGB(29, 29, 35)
                child.TextColor3 = Color3.fromRGB(180, 180, 188)
                child:SetAttribute("IsActiveTab", false)
                TweenObject(child, FAST, {
                    Size = UDim2.new(1, -20, 0, 36)
                })
            end
        end

        Btn:SetAttribute("IsActiveTab", true)
        Btn.TextColor3 = Color3.fromRGB(255, 255, 255)

        TweenObject(Btn, FAST, {
            BackgroundColor3 = CurrentTheme.Accent,
            Size = UDim2.new(1, -14, 0, 38)
        })

        task.delay(0.12, function()
            if Btn.Parent then
                TweenObject(Btn, FAST, {
                    Size = UDim2.new(1, -20, 0, 36)
                })
            end
        end)
    end)

    RegisterForRecolor(Btn, "BackgroundColor3", true)
    return Btn
end

local TabMain = CreateTabButton("TabMain", MainPage, 14)
local TabInfo = CreateTabButton("TabInfo", InfoPage, 58)

TabMain.BackgroundColor3 = CurrentTheme.Accent
TabMain.TextColor3 = Color3.fromRGB(255, 255, 255)
TabMain:SetAttribute("IsActiveTab", true)

--==============================================================
-- UI CONSTRUCTORS
--==============================================================

local function CreateSection(parent, textKey)
    local holder = Instance.new("Frame", parent)
    holder.BackgroundTransparency = 1
    holder.Size = UDim2.new(1, -10, 0, 28)
    holder.ZIndex = 28

    local line = Instance.new("Frame", holder)
    line.AnchorPoint = Vector2.new(0, 0.5)
    line.Position = UDim2.new(0, 0, 0.5, 0)
    line.Size = UDim2.fromOffset(3, 16)
    line.BackgroundColor3 = CurrentTheme.Accent
    line.BorderSizePixel = 0
    line.ZIndex = 29
    Instance.new("UICorner", line).CornerRadius = UDim.new(1, 0)
    RegisterForRecolor(line, "BackgroundColor3")

    local lbl = Instance.new("TextLabel", holder)
    lbl.BackgroundTransparency = 1
    lbl.Position = UDim2.fromOffset(10, 0)
    lbl.Size = UDim2.new(1, -10, 1, 0)
    lbl.Font = Enum.Font.GothamBold
    lbl.TextColor3 = CurrentTheme.Accent
    lbl.TextSize = 12
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.ZIndex = 29

    RegisterText(lbl, textKey)
    RegisterForRecolor(lbl, "TextColor3")
end

local function CreateToggle(parent, textKey, callback)
    local Frame = Instance.new("Frame", parent)
    Frame.BackgroundColor3 = Color3.fromRGB(27, 27, 33)
    Frame.BackgroundTransparency = 0.10
    Frame.Size = UDim2.new(1, -10, 0, 38)
    Frame.BorderSizePixel = 0
    Frame.ZIndex = 28
    Instance.new("UICorner", Frame).CornerRadius = UDim.new(0, 9)

    local Label = Instance.new("TextLabel", Frame)
    Label.BackgroundTransparency = 1
    Label.Position = UDim2.fromOffset(11, 0)
    Label.Size = UDim2.new(1, -65, 1, 0)
    Label.Font = Enum.Font.Gotham
    Label.TextColor3 = Color3.fromRGB(245, 245, 248)
    Label.TextSize = 11
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.ZIndex = 29
    RegisterText(Label, textKey)

    local Btn = Instance.new("TextButton", Frame)
    Btn.BackgroundColor3 = Color3.fromRGB(48, 48, 55)
    Btn.Position = UDim2.new(1, -44, 0.5, -10)
    Btn.Size = UDim2.fromOffset(29, 20)
    Btn.Text = ""
    Btn.AutoButtonColor = false
    Btn.ZIndex = 30
    Instance.new("UICorner", Btn).CornerRadius = UDim.new(1, 0)

    local Knob = Instance.new("Frame", Btn)
    Knob.Size = UDim2.fromOffset(14, 14)
    Knob.Position = UDim2.fromOffset(3, 3)
    Knob.BackgroundColor3 = Color3.fromRGB(240, 240, 245)
    Knob.BorderSizePixel = 0
    Knob.ZIndex = 31
    Instance.new("UICorner", Knob).CornerRadius = UDim.new(1, 0)

    local state = false

    local function Render()
        TweenObject(Btn, FAST, {
            BackgroundColor3 = state and CurrentTheme.Accent or Color3.fromRGB(48, 48, 55)
        })

        TweenObject(Knob, FAST, {
            Position = state
                and UDim2.fromOffset(12, 3)
                or UDim2.fromOffset(3, 3)
        })
    end

    Btn.MouseButton1Click:Connect(function()
        state = not state
        Render()
        callback(state)
    end)

    table.insert(RecolorQueue, function(newColor)
        if not Btn.Parent then
            return false
        end

        if state then
            Btn.BackgroundColor3 = newColor
        end

        return true
    end)

    return {
        Frame = Frame,
        Button = Btn,
        Set = function(value)
            state = value == true
            Render()
        end
    }
end

local function CreateSlider(parent, textKey, min, max, default, callback)
    local Frame = Instance.new("Frame", parent)
    Frame.BackgroundColor3 = Color3.fromRGB(27, 27, 33)
    Frame.BackgroundTransparency = 0.10
    Frame.Size = UDim2.new(1, -10, 0, 54)
    Frame.BorderSizePixel = 0
    Frame.ZIndex = 28
    Instance.new("UICorner", Frame).CornerRadius = UDim.new(0, 9)

    local Label = Instance.new("TextLabel", Frame)
    Label.BackgroundTransparency = 1
    Label.Position = UDim2.fromOffset(11, 5)
    Label.Size = UDim2.new(1, -22, 0, 19)
    Label.Font = Enum.Font.Gotham
    Label.TextColor3 = Color3.fromRGB(245, 245, 248)
    Label.TextSize = 11
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.ZIndex = 29

    local Bar = Instance.new("TextButton", Frame)
    Bar.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
    Bar.Position = UDim2.new(0, 11, 0, 34)
    Bar.Size = UDim2.new(1, -22, 0, 9)
    Bar.Text = ""
    Bar.AutoButtonColor = false
    Bar.ZIndex = 29
    Instance.new("UICorner", Bar).CornerRadius = UDim.new(1, 0)

    local Fill = Instance.new("Frame", Bar)
    Fill.BackgroundColor3 = CurrentTheme.Accent
    Fill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
    Fill.BorderSizePixel = 0
    Fill.ZIndex = 30
    Instance.new("UICorner", Fill).CornerRadius = UDim.new(1, 0)
    RegisterForRecolor(Fill, "BackgroundColor3")

    local Knob = Instance.new("Frame", Bar)
    Knob.AnchorPoint = Vector2.new(0.5, 0.5)
    Knob.Position = UDim2.new((default - min) / (max - min), 0, 0.5, 0)
    Knob.Size = UDim2.fromOffset(14, 14)
    Knob.BackgroundColor3 = Color3.fromRGB(250, 250, 255)
    Knob.BorderSizePixel = 0
    Knob.ZIndex = 31
    Instance.new("UICorner", Knob).CornerRadius = UDim.new(1, 0)

    local currentValue = default
    local dragging = false

    local function RenderLabel(value)
        Label.Text = string.format(
            "%s: %s",
            T(textKey),
            tostring(value)
        )
    end

    RenderLabel(default)

    local function UpdateFromX(x)
        local width = math.max(1, Bar.AbsoluteSize.X)
        local position = math.clamp(
            x - Bar.AbsolutePosition.X,
            0,
            width
        )

        local percent = position / width
        currentValue = math.floor(
            min + ((max - min) * percent) + 0.5
        )

        Fill.Size = UDim2.new(percent, 0, 1, 0)
        Knob.Position = UDim2.new(percent, 0, 0.5, 0)
        RenderLabel(currentValue)
        callback(currentValue)
    end

    Bar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
            or input.UserInputType == Enum.UserInputType.Touch then

            dragging = true
            UpdateFromX(input.Position.X)
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if not dragging then
            return
        end

        if input.UserInputType == Enum.UserInputType.MouseMovement
            or input.UserInputType == Enum.UserInputType.Touch then

            UpdateFromX(input.Position.X)
        end
    end)

    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
            or input.UserInputType == Enum.UserInputType.Touch then

            dragging = false
        end
    end)
end

local function CreateButton(parent, textKey, callback)
    local Btn = Instance.new("TextButton", parent)
    Btn.BackgroundColor3 = Color3.fromRGB(30, 30, 37)
    Btn.BackgroundTransparency = 0.06
    Btn.Size = UDim2.new(1, -10, 0, 38)
    Btn.Font = Enum.Font.GothamBold
    Btn.TextColor3 = Color3.fromRGB(245, 245, 248)
    Btn.TextSize = 11
    Btn.AutoButtonColor = false
    Btn.BorderSizePixel = 0
    Btn.ZIndex = 28
    Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 9)

    local Stroke = Instance.new("UIStroke", Btn)
    Stroke.Thickness = 1
    Stroke.Transparency = 0.78
    Stroke.Color = CurrentTheme.Accent
    RegisterForRecolor(Stroke, "Color")

    RegisterText(Btn, textKey)

    Btn.MouseButton1Click:Connect(function()
        TweenObject(Btn, FAST, {
            BackgroundColor3 = CurrentTheme.Accent,
            Size = UDim2.new(1, -6, 0, 40)
        })

        task.wait(0.10)

        TweenObject(Btn, FAST, {
            BackgroundColor3 = Color3.fromRGB(30, 30, 37),
            Size = UDim2.new(1, -10, 0, 38)
        })

        callback()
    end)

    return Btn
end

local function CreateTextBox(parent, placeholderKey, callback)
    local Frame = Instance.new("Frame", parent)
    Frame.BackgroundColor3 = Color3.fromRGB(27, 27, 33)
    Frame.BackgroundTransparency = 0.10
    Frame.Size = UDim2.new(1, -10, 0, 38)
    Frame.BorderSizePixel = 0
    Frame.ZIndex = 28
    Instance.new("UICorner", Frame).CornerRadius = UDim.new(0, 9)

    local Box = Instance.new("TextBox", Frame)
    Box.BackgroundTransparency = 1
    Box.Size = UDim2.new(1, -20, 1, 0)
    Box.Position = UDim2.fromOffset(10, 0)
    Box.Font = Enum.Font.Gotham
    Box.PlaceholderText = T(placeholderKey)
    Box.Text = ""
    Box.TextColor3 = Color3.fromRGB(245, 245, 248)
    Box.PlaceholderColor3 = Color3.fromRGB(125, 125, 135)
    Box.TextSize = 11
    Box.ClearTextOnFocus = false
    Box.TextXAlignment = Enum.TextXAlignment.Left
    Box.ZIndex = 29

    Box.FocusLost:Connect(function()
        callback(Box.Text)
    end)

    table.insert(TextElements, {
        Element = {
            get Text()
                return Box.PlaceholderText
            end,
            set Text(value)
                Box.PlaceholderText = value
            end
        },
        Key = placeholderKey
    })
end

--==============================================================
-- PLAYER DROPDOWN
--==============================================================

local function CreatePlayerDropdown(parent)
    local DropFrame = Instance.new("Frame", parent)
    DropFrame.BackgroundColor3 = Color3.fromRGB(27, 27, 33)
    DropFrame.BackgroundTransparency = 0.06
    DropFrame.Size = UDim2.new(1, -10, 0, 38)
    DropFrame.ClipsDescendants = true
    DropFrame.BorderSizePixel = 0
    DropFrame.ZIndex = 40
    Instance.new("UICorner", DropFrame).CornerRadius = UDim.new(0, 9)

    local MainBtn = Instance.new("TextButton", DropFrame)
    MainBtn.Size = UDim2.new(1, 0, 0, 38)
    MainBtn.BackgroundTransparency = 1
    MainBtn.Font = Enum.Font.GothamBold
    MainBtn.TextColor3 = Color3.fromRGB(245, 245, 248)
    MainBtn.TextSize = 11
    MainBtn.TextXAlignment = Enum.TextXAlignment.Left
    MainBtn.AutoButtonColor = false
    MainBtn.ZIndex = 41
    RegisterText(MainBtn, "SelectPlr")

    local Arrow = Instance.new("TextLabel", MainBtn)
    Arrow.Size = UDim2.fromOffset(28, 38)
    Arrow.Position = UDim2.new(1, -32, 0, 0)
    Arrow.BackgroundTransparency = 1
    Arrow.Font = Enum.Font.GothamBold
    Arrow.Text = "▼"
    Arrow.TextColor3 = Color3.fromRGB(190, 190, 198)
    Arrow.TextSize = 11
    Arrow.ZIndex = 42

    local Scroll = Instance.new("ScrollingFrame", DropFrame)
    Scroll.Position = UDim2.fromOffset(5, 39)
    Scroll.Size = UDim2.new(1, -10, 0, 120)
    Scroll.BackgroundTransparency = 1
    Scroll.ScrollBarThickness = 2
    Scroll.BorderSizePixel = 0
    Scroll.ZIndex = 42

    local Layout = Instance.new("UIListLayout", Scroll)
    Layout.Padding = UDim.new(0, 4)

    local isOpen = false

    local function RefreshPlayers()
        for _, child in ipairs(Scroll:GetChildren()) do
            if child:IsA("TextButton") then
                child:Destroy()
            end
        end

        for _, plr in ipairs(Players:GetPlayers()) do
            if plr ~= LocalPlayer then
                local button = Instance.new("TextButton", Scroll)
                button.Size = UDim2.new(1, -4, 0, 28)
                button.BackgroundColor3 = Color3.fromRGB(40, 40, 47)
                button.BorderSizePixel = 0
                button.AutoButtonColor = false
                button.Font = Enum.Font.Gotham
                button.Text = "  " .. plr.DisplayName .. " (@" .. plr.Name .. ")"
                button.TextColor3 = Color3.fromRGB(225, 225, 230)
                button.TextSize = 10
                button.TextXAlignment = Enum.TextXAlignment.Left
                button.ZIndex = 43

                Instance.new("UICorner", button).CornerRadius = UDim.new(0, 6)

                button.MouseButton1Click:Connect(function()
                    TrollState.TargetPlayer = plr
                    MainBtn.Text = "  " .. plr.DisplayName
                    isOpen = false
                    Arrow.Text = "▼"

                    TweenObject(
                        DropFrame,
                        MED,
                        {
                            Size = UDim2.new(1, -10, 0, 38)
                        }
                    )

                    Notify(
                        "Target",
                        plr.DisplayName .. " " .. T("TargetSelected"),
                        CurrentTheme.Accent
                    )
                end)
            end
        }

        Scroll.CanvasSize = UDim2.new(
            0,
            0,
            0,
            Layout.AbsoluteContentSize.Y + 8
        )
    end

    MainBtn.MouseButton1Click:Connect(function()
        isOpen = not isOpen

        if isOpen then
            RefreshPlayers()
            Arrow.Text = "▲"

            TweenObject(
                DropFrame,
                MED,
                {
                    Size = UDim2.new(1, -10, 0, 165)
                }
            )
        else
            Arrow.Text = "▼"

            TweenObject(
                DropFrame,
                MED,
                {
                    Size = UDim2.new(1, -10, 0, 38)
                }
            )
        end
    end)

    Players.PlayerAdded:Connect(RefreshPlayers)
    Players.PlayerRemoving:Connect(RefreshPlayers)
end

local function CreateInfoLabel(parent, text)
    local Lbl = Instance.new("TextLabel", parent)
    Lbl.BackgroundTransparency = 1
    Lbl.Size = UDim2.new(1, -10, 0, 22)
    Lbl.Font = Enum.Font.Gotham
    Lbl.Text = text
    Lbl.TextColor3 = Color3.fromRGB(190, 190, 198)
    Lbl.TextSize = 11
    Lbl.TextXAlignment = Enum.TextXAlignment.Left
    Lbl.TextWrapped = true
    Lbl.ZIndex = 28
end

--==============================================================
-- CHARACTER HELPERS
--==============================================================

local function GetCharacter()
    return LocalPlayer.Character
end

local function GetHumanoid()
    local character = GetCharacter()
    if not character then
        return nil
    end

    return character:FindFirstChildOfClass("Humanoid")
end

local function GetRoot()
    local character = GetCharacter()
    if not character then
        return nil
    end

    return character:FindFirstChild("HumanoidRootPart")
end

--==============================================================
-- EFFECTS / WEAPON
--==============================================================

local function ApplyBackScratchFX()
    pcall(function()
        local char = GetCharacter()
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        if not hrp then
            return
        end

        local pe = Instance.new("ParticleEmitter")
        pe.Name = "ScratchBackFX"
        pe.Texture = "rbxassetid://243132757"
        pe.Rate = 20
        pe.Speed = NumberRange.new(5, 10)
        pe.VelocitySpread = 35
        pe.Lifetime = NumberRange.new(0.4, 0.9)
        pe.Color = ColorSequence.new(Color3.fromRGB(220, 225, 235))
        pe.Size = NumberSequence.new({
            NumberSequenceKeypoint.new(0, 0.25),
            NumberSequenceKeypoint.new(1, 0.03)
        })
        pe.EmissionDirection = Enum.NormalId.Back
        pe.Parent = hrp

        table.insert(TrollState.ActiveFX, pe)
    end)
end

local function UseWeaponOnTarget(targetChar)
    pcall(function()
        if not targetChar then
            return
        end

        local char = GetCharacter()
        if not char then
            return
        end

        local tool = char:FindFirstChildOfClass("Tool")
            or LocalPlayer.Backpack:FindFirstChildOfClass("Tool")

        if not tool then
            return
        end

        if tool.Parent ~= char then
            tool.Parent = char
        end

        local handle = tool:FindFirstChild("Handle")
            or tool:FindFirstChildWhichIsA("BasePart")

        if not handle then
            return
        end

        local firetouch = firetouchinterest
            or (syn and syn.firetouchinterest)

        if firetouch then
            for _, part in ipairs(targetChar:GetDescendants()) do
                if part:IsA("BasePart") then
                    firetouch(handle, part, 0)
                    firetouch(handle, part, 1)
                end
            end
        else
            handle.CFrame = targetChar:GetPivot()
        end
    end)
end

--==============================================================
-- STOP ALL
--==============================================================

local function StopAllActions()
    TrollState.SpamSword = false
    TrollState.AttachTarget = nil
    TrollState.AttachMode = ""
    TrollState.FlingActive = false

    for _, fx in ipairs(TrollState.ActiveFX) do
        if fx then
            pcall(function()
                fx:Destroy()
            end)
        end
    end

    TrollState.ActiveFX = {}

    pcall(function()
        local hrp = GetRoot()
        if hrp then
            local bv = hrp:FindFirstChild("FlyVelocity")
            local bg = hrp:FindFirstChild("FlyGyro")

            if bv then bv:Destroy() end
            if bg then bg:Destroy() end

            for _, obj in ipairs(hrp:GetChildren()) do
                if obj.Name == "FlingVelocity"
                    or obj.Name == "FlingAngular"
                    or obj.Name == "FlingForce" then
                    obj:Destroy()
                end
            end
        end
    end)

    pcall(function()
        local char = GetCharacter()
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
        local char = GetCharacter()

        if char then
            local ru = char:FindFirstChild("RightUpperArm")
                or char:FindFirstChild("Right Arm")

            local torso = char:FindFirstChild("Torso")
                or char:FindFirstChild("UpperTorso")

            local rs = (ru and ru:FindFirstChild("RightShoulder"))
                or (torso and torso:FindFirstChild("Right Shoulder"))

            if rs
                and rs:IsA("Motor6D")
                and TrollState.OriginalShoulderC0 then

                rs.C0 = TrollState.OriginalShoulderC0
                TrollState.OriginalShoulderC0 = nil
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
    TrollState.VictimLocked = false
end

--==============================================================
-- FLING
--==============================================================

local function RunOrbitFling(target, isVoidMode)
    local myChar = GetCharacter()
    local myHrp = myChar and myChar:FindFirstChild("HumanoidRootPart")
    local myHum = myChar and myChar:FindFirstChildOfClass("Humanoid")

    local targetChar = target and target.Character
    local targetHrp = targetChar and targetChar:FindFirstChild("HumanoidRootPart")

    if not (myHrp and targetHrp and myHum) then
        Notify(
            "Error",
            "Character not loaded!",
            Color3.fromRGB(255, 80, 80)
        )
        return
    end

    local oldPos = myHrp.CFrame
    local oldVelocity = myHrp.AssemblyLinearVelocity

    TrollState.FlingActive = true

    Notify(
        isVoidMode and "Void Fling" or "Orbit Fling",
        "Target: " .. target.DisplayName,
        CurrentTheme.Accent
    )

    task.spawn(function()
        for _, part in ipairs(myChar:GetDescendants()) do
            if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                part.CanCollide = false
                part.CanQuery = false
            end
        end

        myHrp.CanCollide = true

        local myVelocity = Instance.new("BodyVelocity")
        myVelocity.Name = "FlingVelocity"
        myVelocity.MaxForce = Vector3.new(9e9, 9e9, 9e9)
        myVelocity.Parent = myHrp

        if isVoidMode then
            myVelocity.Velocity = Vector3.new(0, -99999, 0)

            local targetVelocity = Instance.new("BodyVelocity")
            targetVelocity.Name = "TargetFlingVelocity"
            targetVelocity.MaxForce = Vector3.new(9e9, 9e9, 9e9)
            targetVelocity.Velocity = Vector3.new(0, -99999, 0)
            targetVelocity.Parent = targetHrp

            task.wait(0.5)

            if targetVelocity.Parent then
                targetVelocity:Destroy()
            end
        else
            local startTime = os.clock()

            while os.clock() - startTime < 4
                and TrollState.FlingActive
                and targetHrp.Parent do

                local angle = os.clock() * 300
                local radius = 0.5

                local offset = Vector3.new(
                    math.cos(angle) * radius,
                    0,
                    math.sin(angle) * radius
                )

                local targetPos = targetHrp.Position
                local myPos = targetPos + offset

                myHrp.CFrame = CFrame.new(myPos, targetPos)

                local tangent = Vector3.new(
                    -math.sin(angle),
                    0,
                    math.cos(angle)
                ) * 99999

                myVelocity.Velocity = tangent

                targetHrp.AssemblyLinearVelocity =
                    targetHrp.AssemblyLinearVelocity
                    + Vector3.new(
                        math.random(-50000, 50000),
                        math.random(30000, 80000),
                        math.random(-50000, 50000)
                    )

                RunService.Heartbeat:Wait()
            end
        end

        TrollState.FlingActive = false

        pcall(function()
            myVelocity:Destroy()
        end)

        pcall(function()
            myHrp.AssemblyLinearVelocity = oldVelocity or Vector3.zero
            myHrp.AssemblyAngularVelocity = Vector3.zero
            myHrp.CFrame = oldPos
            myHum.PlatformStand = false
            myHum.AutoRotate = true
        end)

        for _, part in ipairs(myChar:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = true
                part.CanQuery = true
            end
        end

        Notify(
            "Fling",
            "Body restored.",
            CurrentTheme.Accent
        )
    end)
end

--==============================================================
-- PHYSICS LOOP
--==============================================================

RunService.Stepped:Connect(function()
    pcall(function()
        local char = GetCharacter()
        if not char then
            return
        end

        local hrp = char:FindFirstChild("HumanoidRootPart")
        local hum = char:FindFirstChildOfClass("Humanoid")

        if TrollState.Noclip
            or TrollState.AttachTarget
            or TrollState.FlingActive then

            for _, part in ipairs(char:GetDescendants()) do
                if part:IsA("BasePart") then
                    if not (
                        TrollState.FlingActive
                        and part.Name == "HumanoidRootPart"
                    ) then
                        part.CanCollide = false
                        part.CanQuery = false
                    end
                end
            end
        end

        -- Scratch Back
        if TrollState.SpamSword and hum and hrp and not TrollState.AttachTarget then
            local rightUpperArm = char:FindFirstChild("RightUpperArm")
                or char:FindFirstChild("Right Arm")

            local torso = char:FindFirstChild("Torso")
                or char:FindFirstChild("UpperTorso")

            local rs = (rightUpperArm and rightUpperArm:FindFirstChild("RightShoulder"))
                or (torso and torso:FindFirstChild("Right Shoulder"))

            local speed = TrollState.SpamSwordSpeed
            local rub = math.cos(os.clock() * speed)

            if rs and rs:IsA("Motor6D") then
                if not TrollState.OriginalShoulderC0 then
                    TrollState.OriginalShoulderC0 = rs.C0
                end

                rs.C0 =
                    TrollState.OriginalShoulderC0
                    * CFrame.new(
                        -0.15,
                        rub * 0.28,
                        -0.12
                    )
                    * CFrame.Angles(
                        math.rad(72 + (rub * 10)),
                        math.rad(-10),
                        0
                    )
            end
        end

        -- Attach
        if TrollState.AttachTarget
            and TrollState.AttachMode ~= ""
            and hrp
            and hum then

            local targetChar = TrollState.AttachTarget.Character

            if targetChar then
                local thrp = targetChar:FindFirstChild("HumanoidRootPart")

                if thrp then
                    hum.PlatformStand = true

                    local speedMultiplier =
                        TrollState.SpamSword
                        and TrollState.SpamSwordSpeed
                        or 25

                    local thrust =
                        (math.sin(os.clock() * speedMultiplier) + 1) / 2

                    local offset
                    local tilt

                    if TrollState.AttachMode == "Back" then
                        offset = 1.25 - (thrust * 0.85)
                        tilt = math.rad(10 + (thrust * 15))

                        hrp.CFrame =
                            thrp.CFrame
                            * CFrame.new(
                                0,
                                -0.2,
                                offset
                            )
                            * CFrame.Angles(
                                tilt,
                                0,
                                0
                            )

                    elseif TrollState.AttachMode == "Front" then
                        offset = -1.2 + (thrust * 0.8)
                        tilt = math.rad(-30 + (thrust * 20))

                        hrp.CFrame =
                            thrp.CFrame
                            * CFrame.new(
                                0,
                                1.6,
                                offset
                            )
                            * CFrame.Angles(
                                tilt,
                                math.rad(180),
                                0
                            )
                    end

                    hrp.AssemblyLinearVelocity = Vector3.zero
                    hrp.AssemblyAngularVelocity = Vector3.zero
                else
                    StopAllActions()
                end
            else
                StopAllActions()
            end
        end

        -- Freeze
        if TrollState.FreezeTarget
            and TrollState.FreezeTarget.Character then

            local tHrp =
                TrollState.FreezeTarget.Character:FindFirstChild(
                    "HumanoidRootPart"
                )

            if tHrp then
                if not TrollState.FreezePos then
                    TrollState.FreezePos = tHrp.CFrame
                end

                tHrp.CFrame = TrollState.FreezePos
                tHrp.AssemblyLinearVelocity = Vector3.zero
                tHrp.AssemblyAngularVelocity = Vector3.zero
            else
                StopAllActions()
            end
        end

        -- Spin target
        if TrollState.SpinTarget
            and TrollState.SpinTarget.Character then

            local tHrp =
                TrollState.SpinTarget.Character:FindFirstChild(
                    "HumanoidRootPart"
                )

            if tHrp then
                tHrp.CFrame =
                    tHrp.CFrame
                    * CFrame.Angles(
                        0,
                        math.rad(18),
                        0
                    )
            end
        end
    end)
end)

--==============================================================
-- RENDER LOOP
--==============================================================

RunService.RenderStepped:Connect(function()
    pcall(function()
        local char = GetCharacter()
        if not char then
            return
        end

        local hum = char:FindFirstChildOfClass("Humanoid")
        local hrp = char:FindFirstChild("HumanoidRootPart")

        if hum then
            if TrollState.EgorSpeed then
                hum.WalkSpeed = 3.5

                local animator = hum:FindFirstChildOfClass("Animator")
                local tracks =
                    animator
                    and animator:GetPlayingAnimationTracks()
                    or hum:GetPlayingAnimationTracks()

                for _, track in ipairs(tracks) do
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
                * CFrame.Angles(
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
        local char = GetCharacter()
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        local hum = char and char:FindFirstChildOfClass("Humanoid")

        if not hrp or not hum then
            return
        end

        local bv =
            hrp:FindFirstChild("FlyVelocity")
            or Instance.new("BodyVelocity")

        bv.Name = "FlyVelocity"
        bv.MaxForce = Vector3.new(9e9, 9e9, 9e9)

        local bg =
            hrp:FindFirstChild("FlyGyro")
            or Instance.new("BodyGyro")

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
                local flyDir = Vector3.new(
                    moveDir.X,
                    cameraCFrame.LookVector.Y * moveDir.Magnitude,
                    moveDir.Z
                )

                if flyDir.Magnitude > 0 then
                    flyDir = flyDir.Unit
                end

                bv.Velocity = flyDir * TrollState.FlySpeed
            else
                bv.Velocity = Vector3.zero
            end

            if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
                bv.Velocity += Vector3.new(
                    0,
                    TrollState.FlySpeed,
                    0
                )
            end

            if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
                bv.Velocity -= Vector3.new(
                    0,
                    TrollState.FlySpeed,
                    0
                )
            end

            bg.CFrame = cameraCFrame
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
            local char = GetCharacter()
            if not char then
                return
            end

            if TrollState.FakeLagFPS or TrollState.FakeLagNet then
                local hrp = char:FindFirstChild("HumanoidRootPart")

                if hrp then
                    hrp.Anchored = true

                    task.wait(
                        TrollState.LagFPSValue / 100
                    )

                    hrp.Anchored = false
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
    local char = GetCharacter()
    if not char then
        return
    end

    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hum then
        return
    end

    hum.MaxHealth = 9e9
    hum.Health = hum.MaxHealth

    local healthLoop
    healthLoop = RunService.Heartbeat:Connect(function()
        if TrollState.GodMode
            and hum
            and hum.Parent then

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
                    GetRoot()

                if not myHrp then
                    return
                end

                for _, p in ipairs(Players:GetPlayers()) do
                    if p ~= LocalPlayer and p.Character then
                        local tHrp =
                            p.Character:FindFirstChild(
                                "HumanoidRootPart"
                            )

                        if tHrp
                            and (myHrp.Position - tHrp.Position).Magnitude
                                <= TrollState.KillAuraRange then

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
                if TextChatService.ChatVersion
                    == Enum.ChatVersion.TextChatService then

                    local config =
                        TextChatService:FindFirstChild(
                            "ChatInputBarConfiguration"
                        )

                    local targetChannel =
                        config
                        and config.TargetTextChannel

                    local textChannels =
                        TextChatService:FindFirstChild(
                            "TextChannels"
                        )

                    local generalChannel =
                        targetChannel
                        or (
                            textChannels
                            and (
                                textChannels:FindFirstChild(
                                    "RBXGeneral"
                                )
                                or textChannels:GetChildren()[1]
                            )
                        )

                    if generalChannel then
                        generalChannel:SendAsync(
                            TrollState.ChatSpamText
                        )
                    end
                else
                    local chatEvents =
                        ReplicatedStorage:FindFirstChild(
                            "DefaultChatSystemChatEvents"
                        )

                    local remote =
                        chatEvents
                        and chatEvents:FindFirstChild(
                            "SayMessageRequest"
                        )

                    if remote then
                        remote:FireServer(
                            TrollState.ChatSpamText,
                            "All"
                        )
                    end
                end
            end)
        end
    end
end)

task.spawn(function()
    while task.wait(0.1) do
        if TrollState.LoopKill
            and TrollState.LoopKillTarget
            and TrollState.LoopKillTarget.Character then

            UseWeaponOnTarget(
                TrollState.LoopKillTarget.Character
            )
        end
    end
end)

--==============================================================
-- CHARACTER RESET
--==============================================================

LocalPlayer.CharacterAdded:Connect(function()
    StopAllActions()

    TrollState.FreezeTarget = nil
    TrollState.FreezePos = nil
    TrollState.SpinTarget = nil
    TrollState.LoopKillTarget = nil

    if TrollState.GodMode then
        task.wait(0.4)
        EnableGodMode()
    end
end)

--==============================================================
-- MAIN PAGE
--==============================================================

CreateSection(MainPage, "SecMove")

CreateToggle(MainPage, "EgorSpeed", function(state)
    TrollState.EgorSpeed = state
end)

CreateToggle(MainPage, "FakeLagFPS", function(state)
    TrollState.FakeLagFPS = state
end)

CreateSlider(
    MainPage,
    "SetLagFPS",
    1,
    100,
    10,
    function(value)
        TrollState.LagFPSValue = value
    end
)

CreateToggle(MainPage, "FakeLagNet", function(state)
    TrollState.FakeLagNet = state
end)

CreateSection(MainPage, "SecTroll")

CreateToggle(MainPage, "Spin", function(state)
    TrollState.Spin = state
end)

CreateSlider(
    MainPage,
    "SpinSpeed",
    1,
    100,
    10,
    function(value)
        TrollState.SpinSpeed = value
    end
)

CreateToggle(MainPage, "SpamSword", function(state)
    StopAllActions()
    TrollState.SpamSword = state

    if state then
        ApplyBackScratchFX()

        Notify(
            "Scratch Back",
            CurrentLang == "RU"
                and "Режим «Чесать спину» активирован."
                or "Scratch Back activated.",
            CurrentTheme.Accent
        )
    end
end)

CreateSlider(
    MainPage,
    "ArmSpeed",
    5,
    45,
    20,
    function(value)
        TrollState.SpamSwordSpeed = value
    end
)

CreateSection(MainPage, "SecTarget")
CreatePlayerDropdown(MainPage)

CreateSection(MainPage, "SecDestroy")

CreateButton(MainPage, "OrbitFling", function()
    StopAllActions()

    if TrollState.TargetPlayer then
        RunOrbitFling(
            TrollState.TargetPlayer,
            false
        )
    else
        Notify(
            "Error",
            CurrentLang == "RU"
                and "Сначала выбери цель!"
                or "Select a target first!",
            Color3.fromRGB(255, 80, 80)
        )
    end
end)

CreateButton(MainPage, "VoidFling", function()
    StopAllActions()

    if TrollState.TargetPlayer then
        RunOrbitFling(
            TrollState.TargetPlayer,
            true
        )
    else
        Notify(
            "Error",
            CurrentLang == "RU"
                and "Сначала выбери цель!"
                or "Select a target first!",
            Color3.fromRGB(255, 80, 80)
        )
    end
end)

CreateButton(MainPage, "Freeze", function()
    if TrollState.TargetPlayer then
        TrollState.FreezeTarget =
            TrollState.TargetPlayer

        TrollState.FreezePos = nil

        Notify(
            "Freeze",
            TrollState.TargetPlayer.DisplayName,
            CurrentTheme.Accent
        )
    else
        Notify(
            "Error",
            CurrentLang == "RU"
                and "Сначала выбери цель!"
                or "Select a target first!",
            Color3.fromRGB(255, 80, 80)
        )
    end
end)

CreateButton(MainPage, "Unfreeze", function()
    if TrollState.FreezeTarget then
        StopAllActions()

        Notify(
            "Unfreeze",
            CurrentLang == "RU"
                and "Цель разморожена."
                or "Target unfrozen.",
            CurrentTheme.Accent
        )
    else
        Notify(
            "Info",
            CurrentLang == "RU"
                and "Замороженной цели нет."
                or "No target frozen.",
            CurrentTheme.Accent
        )
    end
end)

CreateButton(MainPage, "SpinTarget", function()
    if TrollState.TargetPlayer then
        TrollState.SpinTarget =
            TrollState.TargetPlayer

        Notify(
            "Spin",
            TrollState.TargetPlayer.DisplayName,
            CurrentTheme.Accent
        )
    else
        Notify(
            "Error",
            CurrentLang == "RU"
                and "Сначала выбери цель!"
                or "Select a target first!",
            Color3.fromRGB(255, 80, 80)
        )
    end
end)

CreateButton(MainPage, "TPTarget", function()
    if TrollState.TargetPlayer
        and TrollState.TargetPlayer.Character
        and TrollState.TargetPlayer.Character:FindFirstChild(
            "HumanoidRootPart"
        ) then

        local myChar = GetCharacter()

        if myChar
            and myChar:FindFirstChild(
                "HumanoidRootPart"
            ) then

            myChar.HumanoidRootPart.CFrame =
                TrollState.TargetPlayer.Character.HumanoidRootPart.CFrame
                * CFrame.new(0, 5, 0)

            Notify(
                "Teleport",
                "Teleported to "
                    .. TrollState.TargetPlayer.DisplayName,
                CurrentTheme.Accent
            )
        end
    else
        Notify(
            "Error",
            CurrentLang == "RU"
                and "Невозможно телепортироваться!"
                or "Cannot teleport!",
            Color3.fromRGB(255, 80, 80)
        )
    end
end)

CreateButton(MainPage, "LoopKill", function()
    if TrollState.TargetPlayer then
        TrollState.LoopKillTarget =
            TrollState.TargetPlayer

        TrollState.LoopKill = true

        Notify(
            "Loop Kill",
            "Loop killing "
                .. TrollState.TargetPlayer.DisplayName,
            Color3.fromRGB(255, 80, 80)
        )
    else
        Notify(
            "Error",
            CurrentLang == "RU"
                and "Сначала выбери цель!"
                or "Select a target first!",
            Color3.fromRGB(255, 80, 80)
        )
    end
end)

CreateSection(MainPage, "SecGang")

CreateButton(MainPage, "FuckBack", function()
    StopAllActions()

    if TrollState.TargetPlayer then
        TrollState.AttachTarget =
            TrollState.TargetPlayer

        TrollState.AttachMode = "Back"

        Notify(
            "Attach",
            CurrentLang == "RU"
                and "Прилипание сзади активно."
                or "Attach behind active.",
            Color3.fromRGB(255, 80, 170)
        )
    else
        Notify(
            "Error",
            CurrentLang == "RU"
                and "Сначала выбери цель!"
                or "Select a target first!",
            Color3.fromRGB(255, 80, 80)
        )
    end
end)

CreateButton(MainPage, "FuckFront", function()
    StopAllActions()

    if TrollState.TargetPlayer then
        TrollState.AttachTarget =
            TrollState.TargetPlayer

        TrollState.AttachMode = "Front"

        Notify(
            "Attach",
            CurrentLang == "RU"
                and "Прилипание спереди активно."
                or "Attach front active.",
            Color3.fromRGB(255, 80, 170)
        )
    else
        Notify(
            "Error",
            CurrentLang == "RU"
                and "Сначала выбери цель!"
                or "Select a target first!",
            Color3.fromRGB(255, 80, 80)
        )
    end
end)

CreateButton(MainPage, "Victim", function()
    StopAllActions()

    pcall(function()
        local hrp = GetRoot()
        local hum = GetHumanoid()

        if not hrp then
            return
        end

        if hum then
            hum.PlatformStand = true
        end

        hrp.CFrame =
            CFrame.new(
                hrp.Position
                - Vector3.new(0, 1.35, 0)
            )
            * CFrame.Angles(
                math.rad(90),
                0,
                0
            )

        hrp.Anchored = true
        TrollState.VictimLocked = true

        Notify(
            "Victim",
            CurrentLang == "RU"
                and "Позиция зафиксирована."
                or "Position locked.",
            Color3.fromRGB(255, 120, 0)
        )
    end)
end)

CreateSection(MainPage, "SecSelf")

CreateToggle(MainPage, "GodMode", function(state)
    TrollState.GodMode = state

    if state then
        EnableGodMode()

        Notify(
            "God Mode",
            "Activated!",
            CurrentTheme.Accent
        )
    else
        Notify(
            "God Mode",
            "Deactivated.",
            CurrentTheme.Accent
        )
    end
end)

CreateToggle(MainPage, "Noclip", function(state)
    TrollState.Noclip = state
end)

CreateToggle(MainPage, "Fly", function(state)
    TrollState.Fly = state

    if not state then
        pcall(function()
            local hrp = GetRoot()

            if hrp then
                local bv = hrp:FindFirstChild("FlyVelocity")
                local bg = hrp:FindFirstChild("FlyGyro")

                if bv then bv:Destroy() end
                if bg then bg:Destroy() end
            end

            local hum = GetHumanoid()

            if hum then
                hum.PlatformStand = false
            end
        end)
    end
end)

CreateSlider(
    MainPage,
    "FlySpeed",
    20,
    200,
    50,
    function(value)
        TrollState.FlySpeed = value
    end
)

CreateToggle(MainPage, "KillAura", function(state)
    TrollState.KillAura = state
end)

CreateSlider(
    MainPage,
    "AuraRange",
    5,
    50,
    15,
    function(value)
        TrollState.KillAuraRange = value
    end
)

CreateToggle(MainPage, "ChatSpam", function(state)
    TrollState.ChatSpam = state
end)

CreateTextBox(
    MainPage,
    "ChatPlaceholder",
    function(text)
        TrollState.ChatSpamText = text
    end
)

CreateButton(MainPage, "StopAll", function()
    StopAllActions()

    Notify(
        "Stopped",
        CurrentLang == "RU"
            and "Все действия остановлены."
            or "All actions stopped.",
        Color3.fromRGB(255, 255, 255)
    )
end)

CreateSection(MainPage, "SecTheme")

local function CreateThemeButton(key)
    local btn = Instance.new("TextButton", MainPage)
    btn.BackgroundColor3 = Color3.fromRGB(30, 30, 37)
    btn.BackgroundTransparency = 0.04
    btn.Size = UDim2.new(1, -10, 0, 33)
    btn.Font = Enum.Font.GothamBold
    btn.Text = "Theme: " .. Themes[key].Name
    btn.TextColor3 = Themes[key].Accent
    btn.TextSize = 11
    btn.AutoButtonColor = false
    btn.BorderSizePixel = 0
    btn.ZIndex = 28
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 9)

    btn.MouseButton1Click:Connect(function()
        ApplyTheme(key)

        if SplashGlow.Parent then
            SplashGlow.BackgroundColor3 = CurrentTheme.Accent
            SplashStroke.Color = CurrentTheme.Accent
        end

        Notify(
            "Theme",
            Themes[key].Name,
            Themes[key].Accent
        )
    end)
end

CreateThemeButton("Red")
CreateThemeButton("Blue")
CreateThemeButton("Purple")
CreateThemeButton("Green")
CreateThemeButton("Gold")

--==============================================================
-- INFO PAGE
--==============================================================

local InfoDevLabel = Instance.new("TextLabel", InfoPage)
InfoDevLabel.BackgroundTransparency = 1
InfoDevLabel.Size = UDim2.new(1, -10, 0, 23)
InfoDevLabel.Font = Enum.Font.GothamBold
InfoDevLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
InfoDevLabel.TextSize = 12
InfoDevLabel.TextXAlignment = Enum.TextXAlignment.Left
InfoDevLabel.ZIndex = 28
RegisterText(InfoDevLabel, "InfoDev")

local InfoNameLabel = Instance.new("TextLabel", InfoPage)
InfoNameLabel.BackgroundTransparency = 1
InfoNameLabel.Size = UDim2.new(1, -10, 0, 23)
InfoNameLabel.Font = Enum.Font.Gotham
InfoNameLabel.TextColor3 = Color3.fromRGB(200, 200, 208)
InfoNameLabel.TextSize = 11
InfoNameLabel.TextXAlignment = Enum.TextXAlignment.Left
InfoNameLabel.ZIndex = 28
RegisterText(InfoNameLabel, "InfoName")

CreateInfoLabel(
    InfoPage,
    "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
)

local InfoDiscLabel = Instance.new("TextLabel", InfoPage)
InfoDiscLabel.BackgroundTransparency = 1
InfoDiscLabel.Size = UDim2.new(1, -10, 0, 23)
InfoDiscLabel.Font = Enum.Font.GothamBold
InfoDiscLabel.TextColor3 = Color3.fromRGB(115, 185, 255)
InfoDiscLabel.TextSize = 11
InfoDiscLabel.TextXAlignment = Enum.TextXAlignment.Left
InfoDiscLabel.ZIndex = 28
RegisterText(InfoDiscLabel, "InfoDisc")

local CopyDiscBtn = Instance.new("TextButton", InfoPage)
CopyDiscBtn.BackgroundColor3 = Color3.fromRGB(35, 42, 58)
CopyDiscBtn.Size = UDim2.new(1, -10, 0, 38)
CopyDiscBtn.Font = Enum.Font.GothamBold
CopyDiscBtn.Text = "https://discord.gg/vpfFGGjg9"
CopyDiscBtn.TextColor3 = Color3.fromRGB(130, 190, 255)
CopyDiscBtn.TextSize = 11
CopyDiscBtn.AutoButtonColor = false
CopyDiscBtn.BorderSizePixel = 0
CopyDiscBtn.ZIndex = 28
Instance.new("UICorner", CopyDiscBtn).CornerRadius = UDim.new(0, 9)

CopyDiscBtn.MouseButton1Click:Connect(function()
    local link = "https://discord.gg/vpfFGGjg9"

    if setclipboard or (syn and syn.write_clipboard) then
        pcall(function()
            (setclipboard or syn.write_clipboard)(link)
        end)

        Notify(
            "Discord",
            CurrentLang == "RU"
                and "Ссылка скопирована."
                or "Link copied.",
            Color3.fromRGB(100, 200, 255)
        )
    else
        Notify(
            "Discord",
            link,
            Color3.fromRGB(100, 200, 255)
        )
    end
end)

--==============================================================
-- DYNAMIC ISLAND
--==============================================================

local IslandFrame = Instance.new("Frame", ScreenGui)
IslandFrame.Name = "IslandFrame"
IslandFrame.AnchorPoint = Vector2.new(0.5, 0)
IslandFrame.Position = UDim2.new(0.5, 0, 0, 18)
IslandFrame.Size = UDim2.fromOffset(
    Config.IslandWidth,
    Config.IslandHeight
)
IslandFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 15)
IslandFrame.BackgroundTransparency = 0.05
IslandFrame.BorderSizePixel = 0
IslandFrame.Visible = false
IslandFrame.ZIndex = 120

Instance.new("UICorner", IslandFrame).CornerRadius = UDim.new(1, 0)

local IslandStroke = Instance.new("UIStroke", IslandFrame)
IslandStroke.Thickness = 1
IslandStroke.Transparency = 0.52
IslandStroke.Color = CurrentTheme.Accent
RegisterForRecolor(IslandStroke, "Color")

local IslandShadow = Instance.new("Frame", IslandFrame)
IslandShadow.Size = UDim2.fromScale(1, 1)
IslandShadow.BackgroundTransparency = 1
IslandShadow.ZIndex = 120

local IslandLogo = Instance.new("ImageLabel", IslandFrame)
IslandLogo.Size = UDim2.fromOffset(24, 24)
IslandLogo.Position = UDim2.fromOffset(8, 7)
IslandLogo.BackgroundTransparency = 1
IslandLogo.Image = LOGO
IslandLogo.ZIndex = 121
Instance.new("UICorner", IslandLogo).CornerRadius = UDim.new(1, 0)

local IslandLogoStroke = Instance.new("UIStroke", IslandLogo)
IslandLogoStroke.Thickness = 1
IslandLogoStroke.Transparency = 0.35
IslandLogoStroke.Color = CurrentTheme.Accent
RegisterForRecolor(IslandLogoStroke, "Color")

local IslandText = Instance.new("TextLabel", IslandFrame)
IslandText.BackgroundTransparency = 1
IslandText.Position = UDim2.fromOffset(39, 0)
IslandText.Size = UDim2.new(1, -62, 1, 0)
IslandText.Font = Enum.Font.GothamBold
IslandText.Text = "LGK"
IslandText.TextColor3 = Color3.fromRGB(255, 255, 255)
IslandText.TextSize = 12
IslandText.TextXAlignment = Enum.TextXAlignment.Left
IslandText.ZIndex = 121

local IslandDot = Instance.new("Frame", IslandFrame)
IslandDot.Size = UDim2.fromOffset(6, 6)
IslandDot.Position = UDim2.new(1, -18, 0.5, -3)
IslandDot.BorderSizePixel = 0
IslandDot.BackgroundColor3 = CurrentTheme.Accent
IslandDot.ZIndex = 121
Instance.new("UICorner", IslandDot).CornerRadius = UDim.new(1, 0)
RegisterForRecolor(IslandDot, "BackgroundColor3")

local IslandClicker = Instance.new("TextButton", IslandFrame)
IslandClicker.Size = UDim2.fromScale(1, 1)
IslandClicker.BackgroundTransparency = 1
IslandClicker.Text = ""
IslandClicker.ZIndex = 122
IslandClicker.AutoButtonColor = false

--==============================================================
-- DRAG HELPERS
--==============================================================

local function ClampFrame(frame)
    local camera = workspace.CurrentCamera
    if not camera or not frame.Parent then
        return
    end

    local viewport = camera.ViewportSize
    local size = frame.AbsoluteSize
    local pos = frame.AbsolutePosition

    local x = math.clamp(
        pos.X,
        5,
        math.max(5, viewport.X - size.X - 5)
    )

    local y = math.clamp(
        pos.Y,
        5,
        math.max(5, viewport.Y - size.Y - 5)
    )

    frame.Position = UDim2.fromOffset(x, y)
end

local function MakeDraggable(area, frame, isIsland)
    local dragging = false
    local moved = false
    local dragStart
    local startPos

    area.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
            or input.UserInputType == Enum.UserInputType.Touch then

            dragging = true
            moved = false
            dragStart = input.Position
            startPos = frame.Position
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if not dragging then
            return
        end

        if input.UserInputType == Enum.UserInputType.MouseMovement
            or input.UserInputType == Enum.UserInputType.Touch then

            local delta = input.Position - dragStart

            if delta.Magnitude > 5 then
                moved = true
            end

            frame.Position = UDim2.new(
                startPos.X.Scale,
                startPos.X.Offset + delta.X,
                startPos.Y.Scale,
                startPos.Y.Offset + delta.Y
            )

            ClampFrame(frame)
        end
    end)

    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
            or input.UserInputType == Enum.UserInputType.Touch then

            dragging = false

            if isIsland and not moved then
                IslandFrame.Visible = false
                MainFrame.Visible = true

                MainFrame.Size = UDim2.fromOffset(530, 386)

                TweenObject(
                    MainFrame,
                    MED,
                    {
                        Size = UDim2.fromOffset(
                            Config.WindowWidth,
                            Config.WindowHeight
                        )
                    }
                )
            end
        end
    end)
end

MakeDraggable(TitleBar, MainFrame, false)
MakeDraggable(IslandClicker, IslandFrame, true)

--==============================================================
-- LANGUAGE
-- IMPORTANT: opening / closing window never changes language.
--==============================================================

LangBtn.MouseButton1Click:Connect(function()
    if CurrentLang == "RU" then
        SwitchLanguage("EN", false)
    else
        SwitchLanguage("RU", false)
    end
end)

--==============================================================
-- MINIMIZE / RESTORE
--==============================================================

MinimizeBtn.MouseButton1Click:Connect(function()
    TweenObject(
        MainFrame,
        TweenInfo.new(
            0.22,
            Enum.EasingStyle.Quint,
            Enum.EasingDirection.In
        ),
        {
            Size = UDim2.fromOffset(505, 360)
        }
    )

    task.wait(0.18)

    MainFrame.Visible = false
    IslandFrame.Visible = true

    IslandFrame.Size = UDim2.fromOffset(78, 29)

    TweenObject(
        IslandFrame,
        MED,
        {
            Size = UDim2.fromOffset(
                Config.IslandWidth,
                Config.IslandHeight
            )
        }
    )

    -- Deliberately no "Language changed" notification here.
end)

--==============================================================
-- STARTUP
--==============================================================

task.spawn(function()
    pcall(function()
        ContentProvider:PreloadAsync({
            SplashLogo,
            HeaderLogo,
            IslandLogo,
            WindowBackground
        })
    end)

    task.wait(0.20)

    TweenObject(
        SplashLogo,
        TweenInfo.new(
            0.65,
            Enum.EasingStyle.Back,
            Enum.EasingDirection.Out
        ),
        {
            ImageTransparency = 0
        }
    )

    TweenObject(
        SplashGlow,
        SMOOTH,
        {
            BackgroundTransparency = Config.AccentGlow,
            Size = UDim2.fromOffset(215, 215)
        }
    )

    TweenObject(
        SplashStroke,
        MED,
        {
            Transparency = 0.35
        }
    )

    task.wait(0.24)

    TweenObject(
        SplashTitle,
        MED,
        {
            TextTransparency = 0
        }
    )

    task.wait(0.15)

    TweenObject(
        SplashAuthor,
        MED,
        {
            TextTransparency = 0
        }
    )

    task.wait(0.12)

    TweenObject(
        SplashStatus,
        MED,
        {
            TextTransparency = 0
        }
    )

    SplashStatus.Text = T("Splash1")
    task.wait(0.95)

    SplashStatus.Text = T("Splash2")
    task.wait(0.95)

    SplashStatus.Text = T("Splash3")
    task.wait(0.95)

    SplashStatus.Text = T("Splash4")
    task.wait(0.85)

    SplashStatus.Text = T("Splash5")
    task.wait(0.70)

    SplashStatus.Text = T("Ready")
    task.wait(0.80)

    -- Splash out
    TweenObject(SplashLogo, MED, {
        ImageTransparency = 1
    })

    TweenObject(SplashStroke, MED, {
        Transparency = 1
    })

    TweenObject(SplashTitle, MED, {
        TextTransparency = 1
    })

    TweenObject(SplashAuthor, MED, {
        TextTransparency = 1
    })

    TweenObject(SplashStatus, MED, {
        TextTransparency = 1
    })

    TweenObject(SplashGlow, MED, {
        BackgroundTransparency = 1,
        Size = UDim2.fromOffset(260, 260)
    })

    task.wait(0.35)

    Splash.Visible = false

    -- Main window
    MainFrame.Visible = true
    MainFrame.Size = UDim2.fromOffset(520, 375)
    MainFrame.Position = UDim2.fromScale(0.5, 0.53)

    WindowBackground.ImageTransparency = 1
    WindowOverlay.BackgroundTransparency = 1

    TweenObject(
        MainFrame,
        TweenInfo.new(
            0.60,
            Enum.EasingStyle.Back,
            Enum.EasingDirection.Out
        ),
        {
            Size = UDim2.fromOffset(
                Config.WindowWidth,
                Config.WindowHeight
            ),
            Position = UDim2.fromScale(0.5, 0.5)
        }
    )

    TweenObject(
        WindowBackground,
        SMOOTH,
        {
            ImageTransparency = 0.64
        }
    )

    TweenObject(
        WindowOverlay,
        SMOOTH,
        {
            BackgroundTransparency = 0.34
        }
    )

    -- Sidebar slide
    Sidebar.Position = UDim2.new(
        0,
        -145,
        0,
        48
    )

    TweenObject(
        Sidebar,
        SMOOTH,
        {
            Position = UDim2.new(
                0,
                0,
                0,
                48
            )
        }
    )

    -- Pages slide
    Pages.Position = UDim2.new(
        0,
        176,
        0,
        58
    )

    TweenObject(
        Pages,
        SMOOTH,
        {
            Position = UDim2.new(
                0,
                155,
                0,
                58
            )
        }
    )

    task.wait(0.35)

    Notify(
        "Legenly HUB",
        T("Ready"),
        CurrentTheme.Accent
    )
end)

--==============================================================
-- PRINT
--==============================================================

print("================================")
print("Legenly HUB - Troll & Universal")
print("Author: Legenly")
print("Version: Premium Help.lua")
print("Logo: " .. LOGO)
print("Window Background: " .. WINDOW_BACKGROUND)
print("================================")
