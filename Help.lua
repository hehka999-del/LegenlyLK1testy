--[[
    HUB - Troll & Universal
    Developer: Legenly
    Premium UI Edition v10.0

    Changes in this version:
    • Old arm animation is now "Чесать спину"
    • Added separate "Точить шпагу" arm animation
    • New splash/loading system inspired only by the supplied visual example
    • Modern glass/card UI, smooth tweens and hover/press animations
    • Logo: rbxassetid://125281744611585
    • Main background: rbxassetid://118369774163238
    • Existing hub functions/names are kept independent from the supplied example
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
-- ASSETS
--==============================================================

local LOGO_ID = "rbxassetid://125281744611585"
local BACKGROUND_ID = "rbxassetid://118369774163238"

--==============================================================
-- GUI PARENT / DUPLICATE CLEANUP
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

local GuiParent = GetGuiParent()

local oldGui = GuiParent:FindFirstChild("LegenlyTrollHub_Ultimate")
if oldGui then
    pcall(function()
        oldGui:Destroy()
    end)
end

--==============================================================
-- THEMES
--==============================================================

local Themes = {
    Red = {
        Accent = Color3.fromRGB(255, 70, 90),
        Accent2 = Color3.fromRGB(255, 120, 120),
        Name = "Ruby Red"
    },
    Blue = {
        Accent = Color3.fromRGB(70, 150, 255),
        Accent2 = Color3.fromRGB(125, 190, 255),
        Name = "Deep Blue"
    },
    Purple = {
        Accent = Color3.fromRGB(180, 80, 255),
        Accent2 = Color3.fromRGB(220, 145, 255),
        Name = "Amethyst Purple"
    },
    Green = {
        Accent = Color3.fromRGB(65, 225, 125),
        Accent2 = Color3.fromRGB(135, 255, 170),
        Name = "Acid Green"
    },
    Gold = {
        Accent = Color3.fromRGB(255, 190, 70),
        Accent2 = Color3.fromRGB(255, 220, 140),
        Name = "Luxury Gold"
    }
}

local CurrentTheme = Themes.Red
local RecolorQueue = {}

local function RegisterForRecolor(element, property, activeOnly)
    table.insert(RecolorQueue, function(newColor)
        if not element or not element.Parent then
            return false
        end

        pcall(function()
            if activeOnly then
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

    local cleanQueue = {}
    for _, fn in ipairs(RecolorQueue) do
        local ok, keep = pcall(fn, theme.Accent)
        if ok and keep ~= false then
            table.insert(cleanQueue, fn)
        end
    end
    RecolorQueue = cleanQueue
end

--==============================================================
-- TRANSLATIONS
--==============================================================

local CurrentLang = "RU"
local TextElements = {}

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
        ScratchBack = "Чесать спину",
        ScratchBackSpeed = "Скорость чесания спины",
        SharpenSword = "Точить шпагу",
        SharpenSwordSpeed = "Скорость заточки шпаги",
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
        SecGang = "Gang Bang (18+ Троллинг)",
        FuckBack = "Трахнуть (Сзади + Фрикции)",
        FuckFront = "Выебать в рот (Спереди + Фрикции)",
        Victim = "Стать жертвой насилия (Лечь)",
        SecSelf = "Собственные функции",
        GodMode = "God Mode (Бессмертие)",
        Noclip = "Noclip (Сквозь стены)",
        Fly = "Fly (Полет)",
        FlySpeed = "Скорость полета",
        KillAura = "Kill Aura (Аура убийства)",
        AuraRange = "Радиус Kill Aura",
        ChatSpam = "Спамер в чат",
        StopAll = "ОСТАНОВИТЬ ВСЕ ДЕЙСТВИЯ",
        SecTheme = "Оформление Хаба",
        DiscordBtn = "Скопировать ссылку на Discord",
        InfoDev = "Автор и разработчик: Legenly",
        InfoName = "Проект: HUB - Troll & Universal",
        InfoDisc = "Discord канал с обновлениями:",
        NotifSwitched = "Язык изменен на Русский",
        PlrSelected = "выбран в качестве цели!"
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
        ScratchBack = "Scratch Back",
        ScratchBackSpeed = "Scratch Back Speed",
        SharpenSword = "Sharpen Sword",
        SharpenSwordSpeed = "Sharpen Sword Speed",
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
        SecGang = "Gang Bang (18+ Trolling)",
        FuckBack = "Fuck (Behind + Thrusts)",
        FuckFront = "Face Fuck (Front + Thrusts)",
        Victim = "Become Victim (Lay down)",
        SecSelf = "Self Utility",
        GodMode = "God Mode (Invincible)",
        Noclip = "Noclip (Walk Through)",
        Fly = "Fly Mode",
        FlySpeed = "Fly Speed",
        KillAura = "Kill Aura",
        AuraRange = "Kill Aura Range",
        ChatSpam = "Chat Spammer",
        StopAll = "STOP ALL ACTIONS",
        SecTheme = "Hub Appearance",
        DiscordBtn = "Copy Discord Link",
        InfoDev = "Author & Developer: Legenly",
        InfoName = "Project: HUB - Troll & Universal",
        InfoDisc = "Discord Server for Updates:",
        NotifSwitched = "Language switched to English",
        PlrSelected = "selected as target!"
    }
}

local function RegisterText(element, key)
    table.insert(TextElements, {Element = element, Key = key})
    pcall(function()
        element.Text = Translations[CurrentLang][key] or element.Text
    end)
end

local function UpdateRegisteredTexts()
    for _, item in ipairs(TextElements) do
        if item.Element and item.Element.Parent then
            pcall(function()
                local txt = Translations[CurrentLang][item.Key]
                if txt then
                    item.Element.Text = txt
                end
            end)
        end
    end
end

local function SwitchLanguage(lang)
    CurrentLang = lang
    UpdateRegisteredTexts()
end

--==============================================================
-- STATE
--==============================================================

local TrollState = {
    EgorSpeed = false,
    FakeLagFPS = false,
    LagFPSValue = 10,
    FakeLagNet = false,
    Spin = false,
    SpinSpeed = 10,

    ScratchBack = false,
    ScratchBackSpeed = 20,
    SharpenSword = false,
    SharpenSwordSpeed = 20,

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
    LoopKillTarget = nil
}

--==============================================================
-- GUI ROOT
--==============================================================

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "LegenlyTrollHub_Ultimate"
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = GuiParent

--==============================================================
-- UI HELPERS
--==============================================================

local function AddCorner(parent, radius)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, radius)
    corner.Parent = parent
    return corner
end

local function AddStroke(parent, color, transparency, thickness)
    local stroke = Instance.new("UIStroke")
    stroke.Color = color or Color3.fromRGB(255, 255, 255)
    stroke.Transparency = transparency == nil and 0.5 or transparency
    stroke.Thickness = thickness or 1
    stroke.Parent = parent
    return stroke
end

local function Tween(instance, duration, properties, easingStyle, easingDirection)
    local info = TweenInfo.new(
        duration or 0.25,
        easingStyle or Enum.EasingStyle.Quint,
        easingDirection or Enum.EasingDirection.Out
    )

    local animation = TweenService:Create(instance, info, properties)
    animation:Play()
    return animation
end

local function AddHover(button, normalColor, hoverColor)
    local normal = normalColor or button.BackgroundColor3
    local hover = hoverColor or Color3.fromRGB(
        math.clamp(normal.R * 255 + 12, 0, 255),
        math.clamp(normal.G * 255 + 12, 0, 255),
        math.clamp(normal.B * 255 + 12, 0, 255)
    )

    button.MouseEnter:Connect(function()
        Tween(button, 0.16, {BackgroundColor3 = hover})
    end)

    button.MouseLeave:Connect(function()
        Tween(button, 0.16, {BackgroundColor3 = normal})
    end)
end

local function AddPress(button, normalColor, activeColor)
    local normal = normalColor
    local active = activeColor or CurrentTheme.Accent

    button.MouseButton1Down:Connect(function()
        Tween(button, 0.08, {BackgroundColor3 = active, Size = button.Size + UDim2.fromOffset(-2, -2)})
    end)

    button.MouseButton1Up:Connect(function()
        Tween(button, 0.1, {BackgroundColor3 = normal, Size = button.Size + UDim2.fromOffset(2, 2)})
    end)
end

--==============================================================
-- SPLASH / LOADING SYSTEM
--==============================================================

local Splash = Instance.new("Frame")
Splash.Size = UDim2.fromScale(1, 1)
Splash.Position = UDim2.fromScale(0, 0)
Splash.BackgroundColor3 = Color3.fromRGB(7, 7, 10)
Splash.BorderSizePixel = 0
Splash.ZIndex = 500
Splash.Parent = ScreenGui

local SplashGlow = Instance.new("Frame")
SplashGlow.AnchorPoint = Vector2.new(0.5, 0.5)
SplashGlow.Position = UDim2.fromScale(0.5, 0.38)
SplashGlow.Size = UDim2.fromOffset(180, 180)
SplashGlow.BackgroundColor3 = CurrentTheme.Accent
SplashGlow.BackgroundTransparency = 0.92
SplashGlow.BorderSizePixel = 0
SplashGlow.ZIndex = 500
SplashGlow.Parent = Splash
AddCorner(SplashGlow, 100)

local SplashLogo = Instance.new("ImageLabel")
SplashLogo.AnchorPoint = Vector2.new(0.5, 0.5)
SplashLogo.Position = UDim2.fromScale(0.5, 0.34)
SplashLogo.Size = UDim2.fromOffset(100, 100)
SplashLogo.BackgroundTransparency = 1
SplashLogo.Image = LOGO_ID
SplashLogo.ImageTransparency = 1
SplashLogo.ZIndex = 501
SplashLogo.Parent = Splash
AddCorner(SplashLogo, 22)

local SplashTitle = Instance.new("TextLabel")
SplashTitle.AnchorPoint = Vector2.new(0.5, 0.5)
SplashTitle.Position = UDim2.fromScale(0.5, 0.50)
SplashTitle.Size = UDim2.fromScale(0.76, 0.08)
SplashTitle.BackgroundTransparency = 1
SplashTitle.Text = "HUB - Troll & Universal"
SplashTitle.Font = Enum.Font.GothamBold
SplashTitle.TextScaled = true
SplashTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
SplashTitle.TextTransparency = 1
SplashTitle.ZIndex = 501
SplashTitle.Parent = Splash

local SplashAuthor = Instance.new("TextLabel")
SplashAuthor.AnchorPoint = Vector2.new(0.5, 0.5)
SplashAuthor.Position = UDim2.fromScale(0.5, 0.565)
SplashAuthor.Size = UDim2.fromScale(0.70, 0.04)
SplashAuthor.BackgroundTransparency = 1
SplashAuthor.Text = "Legenly"
SplashAuthor.Font = Enum.Font.Gotham
SplashAuthor.TextScaled = true
SplashAuthor.TextColor3 = Color3.fromRGB(145, 145, 155)
SplashAuthor.TextTransparency = 1
SplashAuthor.ZIndex = 501
SplashAuthor.Parent = Splash

local SplashStatus = Instance.new("TextLabel")
SplashStatus.AnchorPoint = Vector2.new(0.5, 0.5)
SplashStatus.Position = UDim2.fromScale(0.5, 0.63)
SplashStatus.Size = UDim2.fromScale(0.72, 0.04)
SplashStatus.BackgroundTransparency = 1
SplashStatus.Text = ""
SplashStatus.Font = Enum.Font.Gotham
SplashStatus.TextScaled = true
SplashStatus.TextColor3 = Color3.fromRGB(115, 145, 185)
SplashStatus.TextTransparency = 1
SplashStatus.ZIndex = 501
SplashStatus.Parent = Splash

local SplashBarBack = Instance.new("Frame")
SplashBarBack.AnchorPoint = Vector2.new(0.5, 0.5)
SplashBarBack.Position = UDim2.fromScale(0.5, 0.69)
SplashBarBack.Size = UDim2.fromOffset(240, 5)
SplashBarBack.BackgroundColor3 = Color3.fromRGB(35, 35, 43)
SplashBarBack.BorderSizePixel = 0
SplashBarBack.ZIndex = 501
SplashBarBack.Parent = Splash
AddCorner(SplashBarBack, 5)

local SplashBar = Instance.new("Frame")
SplashBar.Size = UDim2.new(0, 0, 1, 0)
SplashBar.BackgroundColor3 = CurrentTheme.Accent
SplashBar.BorderSizePixel = 0
SplashBar.ZIndex = 502
SplashBar.Parent = SplashBarBack
AddCorner(SplashBar, 5)

RegisterForRecolor(SplashGlow, "BackgroundColor3")
RegisterForRecolor(SplashBar, "BackgroundColor3")

--==============================================================
-- MAIN WINDOW
--==============================================================

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.Position = UDim2.fromScale(0.5, 0.52)
MainFrame.Size = UDim2.fromOffset(550, 400)
MainFrame.BackgroundColor3 = Color3.fromRGB(12, 12, 17)
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.Visible = false
MainFrame.ZIndex = 10
MainFrame.Parent = ScreenGui
AddCorner(MainFrame, 16)
AddStroke(MainFrame, Color3.fromRGB(255,255,255), 0.82, 1)

local BackgroundImage = Instance.new("ImageLabel")
BackgroundImage.Size = UDim2.fromScale(1, 1)
BackgroundImage.Position = UDim2.fromScale(0, 0)
BackgroundImage.BackgroundTransparency = 1
BackgroundImage.Image = BACKGROUND_ID
BackgroundImage.ImageTransparency = 0.42
BackgroundImage.ScaleType = Enum.ScaleType.Crop
BackgroundImage.ZIndex = 10
BackgroundImage.Parent = MainFrame

local BackgroundOverlay = Instance.new("Frame")
BackgroundOverlay.Size = UDim2.fromScale(1, 1)
BackgroundOverlay.BackgroundColor3 = Color3.fromRGB(8, 8, 12)
BackgroundOverlay.BackgroundTransparency = 0.24
BackgroundOverlay.BorderSizePixel = 0
BackgroundOverlay.ZIndex = 11
BackgroundOverlay.Parent = MainFrame

local WindowGlow = Instance.new("Frame")
WindowGlow.Size = UDim2.new(1, -4, 1, -4)
WindowGlow.Position = UDim2.fromOffset(2, 2)
WindowGlow.BackgroundTransparency = 1
WindowGlow.BorderSizePixel = 0
WindowGlow.ZIndex = 12
WindowGlow.Parent = MainFrame
AddCorner(WindowGlow, 15)
local WindowGlowStroke = AddStroke(WindowGlow, CurrentTheme.Accent, 0.75, 1)
RegisterForRecolor(WindowGlowStroke, "Color")

--==============================================================
-- TITLE BAR
--==============================================================

local TitleBar = Instance.new("Frame")
TitleBar.Name = "TitleBar"
TitleBar.Size = UDim2.new(1, 0, 0, 48)
TitleBar.Position = UDim2.fromOffset(0, 0)
TitleBar.BackgroundColor3 = Color3.fromRGB(12, 12, 17)
TitleBar.BackgroundTransparency = 0.08
TitleBar.BorderSizePixel = 0
TitleBar.ZIndex = 20
TitleBar.Parent = MainFrame

local HeaderLogo = Instance.new("ImageLabel")
HeaderLogo.Size = UDim2.fromOffset(27, 27)
HeaderLogo.Position = UDim2.fromOffset(12, 10)
HeaderLogo.BackgroundTransparency = 1
HeaderLogo.Image = LOGO_ID
HeaderLogo.ZIndex = 21
HeaderLogo.Parent = TitleBar
AddCorner(HeaderLogo, 9)

local TitleText = Instance.new("TextLabel")
TitleText.BackgroundTransparency = 1
TitleText.Position = UDim2.fromOffset(46, 0)
TitleText.Size = UDim2.new(1, -160, 1, 0)
TitleText.Font = Enum.Font.GothamBold
TitleText.TextColor3 = CurrentTheme.Accent
TitleText.TextSize = 14
TitleText.TextXAlignment = Enum.TextXAlignment.Left
TitleText.ZIndex = 21
TitleText.Parent = TitleBar
RegisterText(TitleText, "Title")
RegisterForRecolor(TitleText, "TextColor3")

local LangBtn = Instance.new("TextButton")
LangBtn.Size = UDim2.fromOffset(58, 28)
LangBtn.Position = UDim2.new(1, -94, 0.5, -14)
LangBtn.BackgroundColor3 = Color3.fromRGB(27, 27, 34)
LangBtn.BackgroundTransparency = 0.08
LangBtn.BorderSizePixel = 0
LangBtn.Font = Enum.Font.GothamBold
LangBtn.Text = "RU / EN"
LangBtn.TextColor3 = Color3.fromRGB(230, 230, 235)
LangBtn.TextSize = 10
LangBtn.ZIndex = 21
LangBtn.Parent = TitleBar
AddCorner(LangBtn, 9)
AddStroke(LangBtn, Color3.fromRGB(255,255,255), 0.86, 1)
AddHover(LangBtn, LangBtn.BackgroundColor3, Color3.fromRGB(40,40,50))

LangBtn.MouseButton1Click:Connect(function()
    if CurrentLang == "RU" then
        SwitchLanguage("EN")
        Notify("Language", Translations.EN.NotifSwitched, CurrentTheme.Accent)
    else
        SwitchLanguage("RU")
        Notify("Язык", Translations.RU.NotifSwitched, CurrentTheme.Accent)
    end
end)

local MinimizeBtn = Instance.new("TextButton")
MinimizeBtn.Size = UDim2.fromOffset(36, 36)
MinimizeBtn.Position = UDim2.new(1, -42, 0.5, -18)
MinimizeBtn.BackgroundColor3 = Color3.fromRGB(27, 27, 34)
MinimizeBtn.BackgroundTransparency = 0.05
MinimizeBtn.BorderSizePixel = 0
MinimizeBtn.Font = Enum.Font.GothamBold
MinimizeBtn.Text = "–"
MinimizeBtn.TextColor3 = Color3.fromRGB(235,235,240)
MinimizeBtn.TextSize = 19
MinimizeBtn.ZIndex = 21
MinimizeBtn.Parent = TitleBar
AddCorner(MinimizeBtn, 10)
AddStroke(MinimizeBtn, Color3.fromRGB(255,255,255), 0.87, 1)
AddHover(MinimizeBtn, MinimizeBtn.BackgroundColor3, Color3.fromRGB(45,45,52))

--==============================================================
-- DYNAMIC ISLAND
--==============================================================

local IslandFrame = Instance.new("Frame")
IslandFrame.Name = "IslandFrame"
IslandFrame.AnchorPoint = Vector2.new(0.5, 0)
IslandFrame.Position = UDim2.new(0.5, 0, 0, 16)
IslandFrame.Size = UDim2.fromOffset(0, 40)
IslandFrame.BackgroundColor3 = Color3.fromRGB(12, 12, 17)
IslandFrame.BackgroundTransparency = 0.04
IslandFrame.BorderSizePixel = 0
IslandFrame.Visible = false
IslandFrame.ZIndex = 250
IslandFrame.Parent = ScreenGui
AddCorner(IslandFrame, 20)
local IslandStroke = AddStroke(IslandFrame, CurrentTheme.Accent, 0.67, 1)
RegisterForRecolor(IslandStroke, "Color")

local IslandLogo = Instance.new("ImageLabel")
IslandLogo.Size = UDim2.fromOffset(22,22)
IslandLogo.Position = UDim2.fromOffset(9,9)
IslandLogo.BackgroundTransparency = 1
IslandLogo.Image = LOGO_ID
IslandLogo.ZIndex = 251
IslandLogo.Parent = IslandFrame
AddCorner(IslandLogo, 8)

local IslandText = Instance.new("TextLabel")
IslandText.BackgroundTransparency = 1
IslandText.Position = UDim2.fromOffset(38,0)
IslandText.Size = UDim2.new(1, -58, 1, 0)
IslandText.Font = Enum.Font.GothamBold
IslandText.Text = "Troll"
IslandText.TextColor3 = Color3.fromRGB(255,255,255)
IslandText.TextSize = 13
IslandText.TextXAlignment = Enum.TextXAlignment.Left
IslandText.ZIndex = 251
IslandText.Parent = IslandFrame

local IslandDot = Instance.new("Frame")
IslandDot.Size = UDim2.fromOffset(6,6)
IslandDot.Position = UDim2.new(1, -17, 0.5, -3)
IslandDot.BackgroundColor3 = CurrentTheme.Accent
IslandDot.BorderSizePixel = 0
IslandDot.ZIndex = 251
IslandDot.Parent = IslandFrame
AddCorner(IslandDot, 3)
RegisterForRecolor(IslandDot, "BackgroundColor3")

local IslandClicker = Instance.new("TextButton")
IslandClicker.Size = UDim2.fromScale(1,1)
IslandClicker.BackgroundTransparency = 1
IslandClicker.Text = ""
IslandClicker.ZIndex = 252
IslandClicker.Parent = IslandFrame

--==============================================================
-- SIDEBAR / PAGES
--==============================================================

local Sidebar = Instance.new("Frame")
Sidebar.Name = "Sidebar"
Sidebar.Position = UDim2.fromOffset(0, 48)
Sidebar.Size = UDim2.new(0, 145, 1, -48)
Sidebar.BackgroundColor3 = Color3.fromRGB(15,15,21)
Sidebar.BackgroundTransparency = 0.08
Sidebar.BorderSizePixel = 0
Sidebar.ZIndex = 20
Sidebar.Parent = MainFrame

local SidebarLogo = Instance.new("ImageLabel")
SidebarLogo.Size = UDim2.fromOffset(38,38)
SidebarLogo.Position = UDim2.new(0.5, -19, 0, 15)
SidebarLogo.BackgroundTransparency = 1
SidebarLogo.Image = LOGO_ID
SidebarLogo.ZIndex = 21
SidebarLogo.Parent = Sidebar
AddCorner(SidebarLogo, 12)

local SidebarLabel = Instance.new("TextLabel")
SidebarLabel.BackgroundTransparency = 1
SidebarLabel.Position = UDim2.fromOffset(10, 58)
SidebarLabel.Size = UDim2.new(1, -20, 0, 24)
SidebarLabel.Text = "Legenly"
SidebarLabel.Font = Enum.Font.GothamBold
SidebarLabel.TextColor3 = Color3.fromRGB(215,215,225)
SidebarLabel.TextSize = 12
SidebarLabel.ZIndex = 21
SidebarLabel.Parent = Sidebar

local Pages = Instance.new("Frame")
Pages.Name = "Pages"
Pages.Position = UDim2.fromOffset(156, 58)
Pages.Size = UDim2.new(1, -166, 1, -68)
Pages.BackgroundTransparency = 1
Pages.ZIndex = 20
Pages.Parent = MainFrame

local MainPage = Instance.new("ScrollingFrame")
MainPage.Name = "MainPage"
MainPage.Size = UDim2.fromScale(1,1)
MainPage.BackgroundTransparency = 1
MainPage.BorderSizePixel = 0
MainPage.ScrollBarThickness = 3
MainPage.ScrollBarImageColor3 = CurrentTheme.Accent
MainPage.CanvasSize = UDim2.new(0,0,0,0)
MainPage.ZIndex = 20
MainPage.Parent = Pages

local InfoPage = Instance.new("ScrollingFrame")
InfoPage.Name = "InfoPage"
InfoPage.Size = UDim2.fromScale(1,1)
InfoPage.BackgroundTransparency = 1
InfoPage.BorderSizePixel = 0
InfoPage.ScrollBarThickness = 3
InfoPage.ScrollBarImageColor3 = CurrentTheme.Accent
InfoPage.CanvasSize = UDim2.new(0,0,0,0)
InfoPage.Visible = false
InfoPage.ZIndex = 20
InfoPage.Parent = Pages

local UIListLayoutMain = Instance.new("UIListLayout")
UIListLayoutMain.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayoutMain.Padding = UDim.new(0, 8)
UIListLayoutMain.Parent = MainPage

local UIListLayoutInfo = Instance.new("UIListLayout")
UIListLayoutInfo.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayoutInfo.Padding = UDim.new(0, 8)
UIListLayoutInfo.Parent = InfoPage

UIListLayoutMain:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    MainPage.CanvasSize = UDim2.new(0,0,0,UIListLayoutMain.AbsoluteContentSize.Y + 24)
end)

UIListLayoutInfo:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    InfoPage.CanvasSize = UDim2.new(0,0,0,UIListLayoutInfo.AbsoluteContentSize.Y + 24)
end)

--==============================================================
-- NOTIFICATIONS
--==============================================================

local NotificationContainer = Instance.new("Frame")
NotificationContainer.AnchorPoint = Vector2.new(1,1)
NotificationContainer.Position = UDim2.new(1, -15, 1, -15)
NotificationContainer.Size = UDim2.fromOffset(300, 320)
NotificationContainer.BackgroundTransparency = 1
NotificationContainer.ZIndex = 800
NotificationContainer.Parent = ScreenGui

local NotificationLayout = Instance.new("UIListLayout")
NotificationLayout.VerticalAlignment = Enum.VerticalAlignment.Bottom
NotificationLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
NotificationLayout.Padding = UDim.new(0,8)
NotificationLayout.Parent = NotificationContainer

function Notify(title, message, color, duration)
    color = color or CurrentTheme.Accent
    duration = duration or 3

    local frame = Instance.new("Frame")
    frame.Size = UDim2.fromOffset(280, 66)
    frame.BackgroundColor3 = Color3.fromRGB(15,15,21)
    frame.BackgroundTransparency = 1
    frame.BorderSizePixel = 0
    frame.ZIndex = 801
    frame.Parent = NotificationContainer
    AddCorner(frame, 12)
    local stroke = AddStroke(frame, color, 0.58, 1)

    local accent = Instance.new("Frame")
    accent.Size = UDim2.fromOffset(4, 46)
    accent.Position = UDim2.fromOffset(8, 10)
    accent.BackgroundColor3 = color
    accent.BorderSizePixel = 0
    accent.BackgroundTransparency = 1
    accent.ZIndex = 802
    accent.Parent = frame
    AddCorner(accent, 4)

    local titleLabel = Instance.new("TextLabel")
    titleLabel.BackgroundTransparency = 1
    titleLabel.Position = UDim2.fromOffset(21, 8)
    titleLabel.Size = UDim2.new(1, -30, 0, 19)
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.Text = title
    titleLabel.TextColor3 = Color3.fromRGB(250,250,255)
    titleLabel.TextSize = 13
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.TextTransparency = 1
    titleLabel.ZIndex = 802
    titleLabel.Parent = frame

    local messageLabel = Instance.new("TextLabel")
    messageLabel.BackgroundTransparency = 1
    messageLabel.Position = UDim2.fromOffset(21, 28)
    messageLabel.Size = UDim2.new(1, -30, 0, 30)
    messageLabel.Font = Enum.Font.Gotham
    messageLabel.Text = message
    messageLabel.TextColor3 = Color3.fromRGB(180,180,190)
    messageLabel.TextSize = 11
    messageLabel.TextWrapped = true
    messageLabel.TextXAlignment = Enum.TextXAlignment.Left
    messageLabel.TextTransparency = 1
    messageLabel.ZIndex = 802
    messageLabel.Parent = frame

    Tween(frame, 0.22, {BackgroundTransparency = 0.05})
    Tween(accent, 0.22, {BackgroundTransparency = 0})
    Tween(titleLabel, 0.22, {TextTransparency = 0})
    Tween(messageLabel, 0.22, {TextTransparency = 0})

    task.delay(duration, function()
        if not frame.Parent then
            return
        end

        Tween(frame, 0.2, {BackgroundTransparency = 1})
        Tween(stroke, 0.2, {Transparency = 1})
        Tween(accent, 0.2, {BackgroundTransparency = 1})
        Tween(titleLabel, 0.2, {TextTransparency = 1})
        Tween(messageLabel, 0.2, {TextTransparency = 1})

        task.wait(0.22)
        if frame.Parent then
            frame:Destroy()
        end
    end)
end

--==============================================================
-- TABS
--==============================================================

local function CreateTabButton(nameKey, targetPage, posY)
    local button = Instance.new("TextButton")
    button.Position = UDim2.fromOffset(10, posY)
    button.Size = UDim2.new(1, -20, 0, 38)
    button.BackgroundColor3 = Color3.fromRGB(24,24,31)
    button.BackgroundTransparency = 0.04
    button.BorderSizePixel = 0
    button.Font = Enum.Font.GothamSemibold
    button.TextColor3 = Color3.fromRGB(175,175,188)
    button.TextSize = 12
    button.ZIndex = 22
    button.Parent = Sidebar
    AddCorner(button, 10)
    AddStroke(button, Color3.fromRGB(255,255,255), 0.92, 1)
    button:SetAttribute("IsActiveTab", false)
    RegisterText(button, nameKey)

    AddHover(button, button.BackgroundColor3, Color3.fromRGB(38,38,48))

    button.MouseButton1Click:Connect(function()
        MainPage.Visible = targetPage == MainPage
        InfoPage.Visible = targetPage == InfoPage

        for _, child in ipairs(Sidebar:GetChildren()) do
            if child:IsA("TextButton") then
                child.BackgroundColor3 = Color3.fromRGB(24,24,31)
                child.TextColor3 = Color3.fromRGB(175,175,188)
                child:SetAttribute("IsActiveTab", false)
            end
        end

        button.BackgroundColor3 = CurrentTheme.Accent
        button.TextColor3 = Color3.fromRGB(255,255,255)
        button:SetAttribute("IsActiveTab", true)
    end)

    RegisterForRecolor(button, "BackgroundColor3", true)
    return button
end

local TabMain = CreateTabButton("TabMain", MainPage, 92)
local TabInfo = CreateTabButton("TabInfo", InfoPage, 136)
TabMain.BackgroundColor3 = CurrentTheme.Accent
TabMain.TextColor3 = Color3.fromRGB(255,255,255)
TabMain:SetAttribute("IsActiveTab", true)

--==============================================================
-- DRAGGING
--==============================================================

local function MakeDraggable(dragArea, frameToMove, isIsland)
    local dragging = false
    local dragStart = nil
    local startPos = nil
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
        if not dragging then
            return
        end

        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            local delta = input.Position - dragStart
            if delta.Magnitude > 3 then
                hasMoved = true
            end

            frameToMove.Position = UDim2.new(
                startPos.X.Scale,
                startPos.X.Offset + delta.X,
                startPos.Y.Scale,
                startPos.Y.Offset + delta.Y
            )
        end
    end)

    dragArea.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
            if isIsland and not hasMoved then
                OpenMainWindow()
            end
        end
    end)
end

--==============================================================
-- WINDOW ANIMATIONS
--==============================================================

local MainOpenSize = UDim2.fromOffset(550,400)
local MainClosedSize = UDim2.fromOffset(480,350)

function OpenMainWindow()
    if MainFrame.Visible and not IslandFrame.Visible then
        return
    end

    IslandFrame.Visible = false
    MainFrame.Visible = true
    MainFrame.Size = MainClosedSize
    MainFrame.BackgroundTransparency = 0.25

    Tween(MainFrame, 0.34, {
        Size = MainOpenSize,
        BackgroundTransparency = 0
    }, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
end

local function MinimizeWindow()
    local animation = Tween(MainFrame, 0.28, {
        Size = UDim2.fromOffset(475,330),
        BackgroundTransparency = 1
    }, Enum.EasingStyle.Quint, Enum.EasingDirection.In)

    animation.Completed:Connect(function()
        MainFrame.Visible = false
        MainFrame.Size = MainOpenSize
        MainFrame.BackgroundTransparency = 0

        IslandFrame.Visible = true
        IslandFrame.Size = UDim2.fromOffset(0,40)

        Tween(IslandFrame, 0.34, {
            Size = UDim2.fromOffset(120,40)
        }, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
    end)

    animation:Play()
end

MakeDraggable(TitleBar, MainFrame, false)
MakeDraggable(IslandClicker, IslandFrame, true)

MinimizeBtn.MouseButton1Click:Connect(MinimizeWindow)

--==============================================================
-- UI CONSTRUCTORS
--==============================================================

local function CreateSection(parent, textKey)
    local holder = Instance.new("Frame")
    holder.Size = UDim2.new(1,-5,0,32)
    holder.BackgroundTransparency = 1
    holder.ZIndex = 25
    holder.Parent = parent

    local accent = Instance.new("Frame")
    accent.Size = UDim2.fromOffset(4,18)
    accent.Position = UDim2.fromOffset(3,7)
    accent.BackgroundColor3 = CurrentTheme.Accent
    accent.BorderSizePixel = 0
    accent.ZIndex = 26
    accent.Parent = holder
    AddCorner(accent, 4)
    RegisterForRecolor(accent, "BackgroundColor3")

    local label = Instance.new("TextLabel")
    label.BackgroundTransparency = 1
    label.Position = UDim2.fromOffset(14,0)
    label.Size = UDim2.new(1,-15,1,0)
    label.Font = Enum.Font.GothamBold
    label.TextColor3 = CurrentTheme.Accent
    label.TextSize = 12
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.ZIndex = 26
    label.Parent = holder
    RegisterText(label, textKey)
    RegisterForRecolor(label, "TextColor3")
end

local function CreateToggle(parent, textKey, callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1,-5,0,42)
    frame.BackgroundColor3 = Color3.fromRGB(18,18,25)
    frame.BackgroundTransparency = 0.08
    frame.BorderSizePixel = 0
    frame.ZIndex = 25
    frame.Parent = parent
    AddCorner(frame, 11)
    AddStroke(frame, Color3.fromRGB(255,255,255), 0.93, 1)

    local label = Instance.new("TextLabel")
    label.BackgroundTransparency = 1
    label.Position = UDim2.fromOffset(13,0)
    label.Size = UDim2.new(1,-65,1,0)
    label.Font = Enum.Font.Gotham
    label.TextColor3 = Color3.fromRGB(245,245,250)
    label.TextSize = 12
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.ZIndex = 26
    label.Parent = frame
    RegisterText(label, textKey)

    local switch = Instance.new("TextButton")
    switch.Size = UDim2.fromOffset(48,24)
    switch.Position = UDim2.new(1,-60,0.5,-12)
    switch.BackgroundColor3 = Color3.fromRGB(47,47,57)
    switch.BorderSizePixel = 0
    switch.Text = ""
    switch.AutoButtonColor = false
    switch.ZIndex = 26
    switch.Parent = frame
    AddCorner(switch, 12)

    local knob = Instance.new("Frame")
    knob.Size = UDim2.fromOffset(18,18)
    knob.Position = UDim2.fromOffset(3,3)
    knob.BackgroundColor3 = Color3.fromRGB(245,245,248)
    knob.BorderSizePixel = 0
    knob.ZIndex = 27
    knob.Parent = switch
    AddCorner(knob, 9)

    local state = false

    local function Render()
        if state then
            Tween(switch,0.14,{BackgroundColor3 = CurrentTheme.Accent})
            Tween(knob,0.14,{Position = UDim2.fromOffset(27,3)})
        else
            Tween(switch,0.14,{BackgroundColor3 = Color3.fromRGB(47,47,57)})
            Tween(knob,0.14,{Position = UDim2.fromOffset(3,3)})
        end
    end

    switch.MouseButton1Click:Connect(function()
        state = not state
        Render()
        callback(state)
    end)

    table.insert(RecolorQueue, function(newColor)
        if not switch or not switch.Parent then
            return false
        end
        if state then
            switch.BackgroundColor3 = newColor
        end
        return true
    end)
end

local function CreateSlider(parent, textKey, min, max, default, callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1,-5,0,58)
    frame.BackgroundColor3 = Color3.fromRGB(18,18,25)
    frame.BackgroundTransparency = 0.08
    frame.BorderSizePixel = 0
    frame.ZIndex = 25
    frame.Parent = parent
    AddCorner(frame, 11)
    AddStroke(frame, Color3.fromRGB(255,255,255), 0.93, 1)

    local label = Instance.new("TextLabel")
    label.BackgroundTransparency = 1
    label.Position = UDim2.fromOffset(13,5)
    label.Size = UDim2.new(1,-26,0,20)
    label.Font = Enum.Font.Gotham
    label.TextColor3 = Color3.fromRGB(245,245,250)
    label.TextSize = 11
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.ZIndex = 26
    label.Parent = frame

    local bar = Instance.new("TextButton")
    bar.Position = UDim2.new(0,13,0,36)
    bar.Size = UDim2.new(1,-26,0,8)
    bar.BackgroundColor3 = Color3.fromRGB(35,35,44)
    bar.BorderSizePixel = 0
    bar.Text = ""
    bar.AutoButtonColor = false
    bar.ZIndex = 26
    bar.Parent = frame
    AddCorner(bar, 4)

    local fill = Instance.new("Frame")
    fill.Size = UDim2.new((default-min)/(max-min),0,1,0)
    fill.BackgroundColor3 = CurrentTheme.Accent
    fill.BorderSizePixel = 0
    fill.ZIndex = 27
    fill.Parent = bar
    AddCorner(fill, 4)
    RegisterForRecolor(fill, "BackgroundColor3")

    local thumb = Instance.new("Frame")
    thumb.Size = UDim2.fromOffset(14,14)
    thumb.AnchorPoint = Vector2.new(0.5,0.5)
    thumb.Position = UDim2.new((default-min)/(max-min),0,0.5,0)
    thumb.BackgroundColor3 = Color3.fromRGB(248,248,252)
    thumb.BorderSizePixel = 0
    thumb.ZIndex = 28
    thumb.Parent = bar
    AddCorner(thumb,7)

    local currentValue = default
    local isDragging = false

    local function UpdateLabel(value)
        label.Text = (Translations[CurrentLang][textKey] or textKey) .. ": " .. tostring(value)
    end

    local function UpdateValue(input)
        local width = math.max(bar.AbsoluteSize.X,1)
        local position = math.clamp(input.Position.X - bar.AbsolutePosition.X,0,width)
        local percent = position / width
        currentValue = math.floor(min + (max-min) * percent)
        fill.Size = UDim2.new(percent,0,1,0)
        thumb.Position = UDim2.new(percent,0,0.5,0)
        UpdateLabel(currentValue)
        callback(currentValue)
    end

    UpdateLabel(default)

    bar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            isDragging = true
            UpdateValue(input)
        end
    end)

    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            isDragging = false
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if isDragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            UpdateValue(input)
        end
    end)
end

local function CreateButton(parent, textKey, callback)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1,-5,0,40)
    button.BackgroundColor3 = Color3.fromRGB(20,20,27)
    button.BackgroundTransparency = 0.02
    button.BorderSizePixel = 0
    button.Font = Enum.Font.GothamBold
    button.TextColor3 = Color3.fromRGB(245,245,250)
    button.TextSize = 11
    button.TextWrapped = true
    button.AutoButtonColor = false
    button.ZIndex = 25
    button.Parent = parent
    AddCorner(button, 11)
    AddStroke(button, Color3.fromRGB(255,255,255), 0.93, 1)
    RegisterText(button, textKey)

    AddHover(button, button.BackgroundColor3, Color3.fromRGB(32,32,43))

    button.MouseButton1Click:Connect(function()
        Tween(button,0.08,{BackgroundColor3 = CurrentTheme.Accent})
        task.wait(0.1)
        Tween(button,0.12,{BackgroundColor3 = Color3.fromRGB(20,20,27)})
        callback()
    end)
end

local function CreateTextBox(parent, placeholder, callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1,-5,0,40)
    frame.BackgroundColor3 = Color3.fromRGB(18,18,25)
    frame.BackgroundTransparency = 0.08
    frame.BorderSizePixel = 0
    frame.ZIndex = 25
    frame.Parent = parent
    AddCorner(frame,11)
    AddStroke(frame, Color3.fromRGB(255,255,255), 0.93, 1)

    local box = Instance.new("TextBox")
    box.Size = UDim2.new(1,-26,1,0)
    box.Position = UDim2.fromOffset(13,0)
    box.BackgroundTransparency = 1
    box.Font = Enum.Font.Gotham
    box.PlaceholderText = placeholder
    box.PlaceholderColor3 = Color3.fromRGB(115,115,125)
    box.Text = ""
    box.TextColor3 = Color3.fromRGB(245,245,250)
    box.TextSize = 11
    box.TextXAlignment = Enum.TextXAlignment.Left
    box.ClearTextOnFocus = false
    box.ZIndex = 26
    box.Parent = frame

    box.FocusGained:Connect(function()
        local stroke = frame:FindFirstChildOfClass("UIStroke")
        if stroke then
            Tween(stroke,0.16,{Transparency = 0.55, Color = CurrentTheme.Accent})
        end
    end)

    box.FocusLost:Connect(function()
        local stroke = frame:FindFirstChildOfClass("UIStroke")
        if stroke then
            Tween(stroke,0.16,{Transparency = 0.93, Color = Color3.fromRGB(255,255,255)})
        end
        callback(box.Text)
    end)
end

local function CreatePlayerDropdown(parent)
    local dropFrame = Instance.new("Frame")
    dropFrame.Size = UDim2.new(1,-5,0,42)
    dropFrame.BackgroundColor3 = Color3.fromRGB(18,18,25)
    dropFrame.BackgroundTransparency = 0.08
    dropFrame.BorderSizePixel = 0
    dropFrame.ClipsDescendants = true
    dropFrame.ZIndex = 30
    dropFrame.Parent = parent
    AddCorner(dropFrame,11)
    AddStroke(dropFrame, Color3.fromRGB(255,255,255), 0.93, 1)

    local mainButton = Instance.new("TextButton")
    mainButton.Size = UDim2.new(1,0,0,42)
    mainButton.BackgroundTransparency = 1
    mainButton.Font = Enum.Font.GothamBold
    mainButton.TextColor3 = Color3.fromRGB(245,245,250)
    mainButton.TextSize = 11
    mainButton.TextXAlignment = Enum.TextXAlignment.Left
    mainButton.ZIndex = 31
    mainButton.Parent = dropFrame
    RegisterText(mainButton, "SelectPlr")

    local arrow = Instance.new("TextLabel")
    arrow.Size = UDim2.fromOffset(30,42)
    arrow.Position = UDim2.new(1,-35,0,0)
    arrow.BackgroundTransparency = 1
    arrow.Font = Enum.Font.GothamBold
    arrow.Text = "⌄"
    arrow.TextColor3 = Color3.fromRGB(180,180,190)
    arrow.TextSize = 15
    arrow.ZIndex = 32
    arrow.Parent = mainButton

    local scroll = Instance.new("ScrollingFrame")
    scroll.Position = UDim2.fromOffset(7,46)
    scroll.Size = UDim2.new(1,-14,0,118)
    scroll.BackgroundTransparency = 1
    scroll.BorderSizePixel = 0
    scroll.ScrollBarThickness = 3
    scroll.ZIndex = 31
    scroll.Parent = dropFrame

    local layout = Instance.new("UIListLayout")
    layout.Padding = UDim.new(0,4)
    layout.Parent = scroll

    local opened = false

    local function RefreshPlayers()
        for _, child in ipairs(scroll:GetChildren()) do
            if child:IsA("TextButton") then
                child:Destroy()
            end
        end

        local count = 0
        for _, plr in ipairs(Players:GetPlayers()) do
            if plr ~= LocalPlayer then
                count += 1

                local button = Instance.new("TextButton")
                button.Size = UDim2.new(1,-4,0,30)
                button.BackgroundColor3 = Color3.fromRGB(27,27,35)
                button.BorderSizePixel = 0
                button.Font = Enum.Font.Gotham
                button.Text = "  " .. plr.DisplayName .. "  (@" .. plr.Name .. ")"
                button.TextColor3 = Color3.fromRGB(225,225,232)
                button.TextSize = 10
                button.TextXAlignment = Enum.TextXAlignment.Left
                button.ZIndex = 32
                button.Parent = scroll
                AddCorner(button,8)
                AddHover(button, button.BackgroundColor3, Color3.fromRGB(40,40,50))

                button.MouseButton1Click:Connect(function()
                    TrollState.TargetPlayer = plr
                    mainButton.Text = "  " .. plr.DisplayName
                    opened = false
                    dropFrame.Size = UDim2.new(1,-5,0,42)
                    arrow.Text = "⌄"
                    Notify("Target", plr.DisplayName .. " " .. Translations[CurrentLang].PlrSelected, CurrentTheme.Accent)
                end)
            end
        end

        scroll.CanvasSize = UDim2.new(0,0,0,math.max(0, count * 34))
    end

    mainButton.MouseButton1Click:Connect(function()
        opened = not opened
        if opened then
            RefreshPlayers()
            dropFrame.Size = UDim2.new(1,-5,0,172)
            arrow.Text = "⌃"
        else
            dropFrame.Size = UDim2.new(1,-5,0,42)
            arrow.Text = "⌄"
        end
    end)

    Players.PlayerAdded:Connect(RefreshPlayers)
    Players.PlayerRemoving:Connect(RefreshPlayers)
end

local function CreateInfoLabel(parent, text)
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1,-5,0,30)
    label.BackgroundTransparency = 1
    label.Font = Enum.Font.Gotham
    label.Text = text
    label.TextColor3 = Color3.fromRGB(198,198,210)
    label.TextSize = 11
    label.TextWrapped = true
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.ZIndex = 25
    label.Parent = parent
end

--==============================================================
-- CHARACTER HELPERS
--==============================================================

local function GetHumanoid()
    local char = LocalPlayer.Character
    return char and char:FindFirstChildOfClass("Humanoid")
end

local function GetRoot()
    local char = LocalPlayer.Character
    return char and char:FindFirstChild("HumanoidRootPart")
end

--==============================================================
-- EXISTING LOGIC / EFFECTS
--==============================================================

local function ApplyEjaculationFX()
    pcall(function()
        local char = LocalPlayer.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        if not hrp then return end

        local tool = char:FindFirstChildOfClass("Tool") or LocalPlayer.Backpack:FindFirstChildOfClass("Tool")
        local parentObj = hrp
        if tool and tool:FindFirstChild("Handle") then
            if tool.Parent ~= char then
                tool.Parent = char
            end
            parentObj = tool.Handle
        end

        local pe = Instance.new("ParticleEmitter")
        pe.Name = "SpermFX"
        pe.Texture = "rbxassetid://243132757"
        pe.Rate = 50
        pe.Speed = NumberRange.new(12,22)
        pe.VelocitySpread = 35
        pe.Lifetime = NumberRange.new(0.6,1.2)
        pe.Color = ColorSequence.new(Color3.fromRGB(255,255,255))
        pe.Size = NumberSequence.new({
            NumberSequenceKeypoint.new(0,0.5),
            NumberSequenceKeypoint.new(1,0.05)
        })
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

local function UseWeaponOnTarget(targetChar)
    pcall(function()
        if not targetChar then return end
        local char = LocalPlayer.Character
        if not char then return end

        local tool = char:FindFirstChildOfClass("Tool") or LocalPlayer.Backpack:FindFirstChildOfClass("Tool")
        if tool then
            if tool.Parent ~= char then
                tool.Parent = char
            end
            local handle = tool:FindFirstChild("Handle") or tool:FindFirstChildWhichIsA("BasePart")
            if handle then
                local firetouch = firetouchinterest or (syn and syn.firetouchinterest)
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
            end
        end
    end)
end

local function StopAllActions()
    TrollState.ScratchBack = false
    TrollState.SharpenSword = false
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
            end
        end
    end)

    TrollState.OriginalShoulderC0 = nil
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
        Notify("Error", "Character not loaded!", Color3.fromRGB(255,0,0))
        return
    end

    local oldPos = myHrp.CFrame
    local oldVelocity = myHrp.AssemblyLinearVelocity
    TrollState.FlingActive = true

    Notify(isVoidMode and "Void Fling" or "Orbit Fling", "Flinging: " .. target.DisplayName, CurrentTheme.Accent)

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
        myVelocity.MaxForce = Vector3.new(9e9,9e9,9e9)
        myVelocity.Parent = myHrp

        if isVoidMode then
            myVelocity.Velocity = Vector3.new(0,-99999,0)
            local targetVelocity = Instance.new("BodyVelocity")
            targetVelocity.Name = "TargetFlingVelocity"
            targetVelocity.MaxForce = Vector3.new(9e9,9e9,9e9)
            targetVelocity.Velocity = Vector3.new(0,-99999,0)
            targetVelocity.Parent = targetHrp
            task.wait(0.5)
            if targetVelocity.Parent then
                targetVelocity:Destroy()
            end
        else
            local startTime = os.clock()
            while os.clock() - startTime < 4 and TrollState.FlingActive do
                local angle = os.clock() * 300
                local radius = 0.5
                local offset = Vector3.new(math.cos(angle) * radius,0,math.sin(angle) * radius)
                local targetPos = targetHrp.Position
                local myPos = targetPos + offset
                myHrp.CFrame = CFrame.new(myPos,targetPos)
                myVelocity.Velocity = Vector3.new(-math.sin(angle),0,math.cos(angle)) * 99999
                targetHrp.AssemblyLinearVelocity = targetHrp.AssemblyLinearVelocity + Vector3.new(
                    math.random(-50000,50000),
                    math.random(30000,80000),
                    math.random(-50000,50000)
                )
                RunService.Heartbeat:Wait()
            end
        end

        TrollState.FlingActive = false
        if myVelocity.Parent then
            myVelocity:Destroy()
        end

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

        Notify("Fling Done", "Body restored.", CurrentTheme.Accent)
    end)
end

--==============================================================
-- MOVEMENT / ANIMATION LOOPS
--==============================================================

RunService.Stepped:Connect(function()
    pcall(function()
        local char = LocalPlayer.Character
        if not char then return end

        local hrp = char:FindFirstChild("HumanoidRootPart")
        local hum = char:FindFirstChildOfClass("Humanoid")

        if TrollState.Noclip or TrollState.AttachTarget or TrollState.FlingActive then
            for _, part in ipairs(char:GetDescendants()) do
                if part:IsA("BasePart") then
                    if not (TrollState.FlingActive and part.Name == "HumanoidRootPart") then
                        part.CanCollide = false
                        part.CanQuery = false
                    end
                end
            end
        end

        --==========================================================
        -- ARM ANIMATIONS
        --==========================================================

        if (TrollState.ScratchBack or TrollState.SharpenSword) and hum and hrp and not TrollState.AttachTarget then
            local rightUpperArm = char:FindFirstChild("RightUpperArm") or char:FindFirstChild("Right Arm")
            local torso = char:FindFirstChild("Torso") or char:FindFirstChild("UpperTorso")
            local rs = (rightUpperArm and rightUpperArm:FindFirstChild("RightShoulder")) or (torso and torso:FindFirstChild("Right Shoulder"))

            if rs and rs:IsA("Motor6D") then
                if not TrollState.OriginalShoulderC0 then
                    TrollState.OriginalShoulderC0 = rs.C0
                end

                local base = TrollState.OriginalShoulderC0

                if TrollState.ScratchBack then
                    local wave = math.cos(os.clock() * TrollState.ScratchBackSpeed)
                    rs.C0 = base
                        * CFrame.new(-0.35, wave * 0.45, -0.2)
                        * CFrame.Angles(math.rad(85 + wave * 12), math.rad(-15), 0)
                elseif TrollState.SharpenSword then
                    local wave = math.sin(os.clock() * TrollState.SharpenSwordSpeed)
                    rs.C0 = base
                        * CFrame.new(0.10, -0.05 + wave * 0.08, -0.72)
                        * CFrame.Angles(math.rad(62 + wave * 10), math.rad(18), math.rad(-8))
                end
            end
        end

        --==========================================================
        -- ATTACH MODES
        --==========================================================

        if TrollState.AttachTarget and TrollState.AttachMode ~= "" and hrp and hum then
            local targetChar = TrollState.AttachTarget.Character
            if targetChar then
                local thrp = targetChar:FindFirstChild("HumanoidRootPart")
                if thrp then
                    hum.PlatformStand = true

                    local speedMultiplier = TrollState.ScratchBack and TrollState.ScratchBackSpeed
                        or TrollState.SharpenSword and TrollState.SharpenSwordSpeed
                        or 25

                    local thrust = (math.sin(os.clock() * speedMultiplier) + 1) / 2
                    local offset
                    local tilt

                    local rightUpperArm = char:FindFirstChild("RightUpperArm") or char:FindFirstChild("Right Arm")
                    local torso = char:FindFirstChild("Torso") or char:FindFirstChild("UpperTorso")
                    local rs = (rightUpperArm and rightUpperArm:FindFirstChild("RightShoulder")) or (torso and torso:FindFirstChild("Right Shoulder"))

                    if rs and rs:IsA("Motor6D") and (TrollState.ScratchBack or TrollState.SharpenSword) then
                        if not TrollState.OriginalShoulderC0 then
                            TrollState.OriginalShoulderC0 = rs.C0
                        end

                        local wave = math.cos(os.clock() * speedMultiplier)
                        rs.C0 = TrollState.OriginalShoulderC0
                            * CFrame.new(0, wave * 0.35, -0.1)
                            * CFrame.Angles(math.rad(80), 0, 0)
                    end

                    if TrollState.AttachMode == "Back" then
                        offset = 1.25 - (thrust * 0.85)
                        tilt = math.rad(10 + (thrust * 15))
                        hrp.CFrame = thrp.CFrame * CFrame.new(0,-0.2,offset) * CFrame.Angles(tilt,0,0)
                    elseif TrollState.AttachMode == "Front" then
                        offset = -1.2 + (thrust * 0.8)
                        tilt = math.rad(-30 + (thrust * 20))
                        hrp.CFrame = thrp.CFrame * CFrame.new(0,1.6,offset) * CFrame.Angles(tilt,math.rad(180),0)
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

        if TrollState.FreezeTarget and TrollState.FreezeTarget.Character then
            local targetRoot = TrollState.FreezeTarget.Character:FindFirstChild("HumanoidRootPart")
            if targetRoot then
                if not TrollState.FreezePos then
                    TrollState.FreezePos = targetRoot.CFrame
                end
                targetRoot.CFrame = TrollState.FreezePos
                targetRoot.AssemblyLinearVelocity = Vector3.zero
                targetRoot.AssemblyAngularVelocity = Vector3.zero
            else
                StopAllActions()
            end
        end

        if TrollState.SpinTarget and TrollState.SpinTarget.Character then
            local targetRoot = TrollState.SpinTarget.Character:FindFirstChild("HumanoidRootPart")
            if targetRoot then
                targetRoot.CFrame = targetRoot.CFrame * CFrame.Angles(0,math.rad(18),0)
            end
        end
    end)
end)

RunService.RenderStepped:Connect(function()
    pcall(function()
        local char = LocalPlayer.Character
        if not char then return end
        local hum = char:FindFirstChildOfClass("Humanoid")
        local hrp = char:FindFirstChild("HumanoidRootPart")

        if hum then
            if TrollState.EgorSpeed then
                hum.WalkSpeed = 3.5
                local animator = hum:FindFirstChildOfClass("Animator")
                local tracks = animator and animator:GetPlayingAnimationTracks() or hum:GetPlayingAnimationTracks()
                for _, track in ipairs(tracks) do
                    if track.IsPlaying then
                        pcall(function()
                            track:AdjustSpeed(6.0)
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
            hrp.CFrame = hrp.CFrame * CFrame.Angles(0, math.rad(TrollState.SpinSpeed), 0)
        end
    end)
end)

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
        bv.MaxForce = Vector3.new(9e9,9e9,9e9)

        local bg = hrp:FindFirstChild("FlyGyro") or Instance.new("BodyGyro")
        bg.Name = "FlyGyro"
        bg.MaxTorque = Vector3.new(9e9,9e9,9e9)

        if TrollState.Fly then
            hum.PlatformStand = true
            bv.Parent = hrp
            bg.Parent = hrp

            local camera = workspace.CurrentCamera
            local cameraCFrame = camera and camera.CFrame or hrp.CFrame
            local moveDir = hum.MoveDirection

            if moveDir.Magnitude > 0 then
                local flyDir = Vector3.new(moveDir.X, cameraCFrame.LookVector.Y * moveDir.Magnitude, moveDir.Z)
                if flyDir.Magnitude > 0 then
                    flyDir = flyDir.Unit
                end
                bv.Velocity = flyDir * TrollState.FlySpeed
            else
                bv.Velocity = Vector3.zero
            end

            if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
                bv.Velocity = bv.Velocity + Vector3.new(0,TrollState.FlySpeed,0)
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
                bv.Velocity = bv.Velocity - Vector3.new(0,TrollState.FlySpeed,0)
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
-- FAKE LAG
--==============================================================

task.spawn(function()
    while task.wait() do
        pcall(function()
            local char = LocalPlayer.Character
            if not char then return end
            if TrollState.FakeLagFPS or TrollState.FakeLagNet then
                local hrp = char:FindFirstChild("HumanoidRootPart")
                if hrp then
                    hrp.Anchored = true
                    task.wait(TrollState.LagFPSValue / 100)
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
    local char = LocalPlayer.Character
    if not char then return end
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hum then return end

    hum.MaxHealth = 9e9
    hum.Health = hum.MaxHealth

    local healthConnection
    healthConnection = RunService.Heartbeat:Connect(function()
        if TrollState.GodMode and hum and hum.Parent then
            hum.Health = hum.MaxHealth
        else
            if healthConnection then
                healthConnection:Disconnect()
            end
        end
    end)
end

--==============================================================
-- KILL AURA / CHAT SPAM / LOOP KILL
--==============================================================

task.spawn(function()
    while task.wait(0.1) do
        if TrollState.KillAura then
            pcall(function()
                local myRoot = GetRoot()
                if not myRoot then return end
                for _, player in ipairs(Players:GetPlayers()) do
                    if player ~= LocalPlayer and player.Character then
                        local targetRoot = player.Character:FindFirstChild("HumanoidRootPart")
                        if targetRoot and (myRoot.Position - targetRoot.Position).Magnitude <= TrollState.KillAuraRange then
                            UseWeaponOnTarget(player.Character)
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
                if TextChatService.ChatVersion == Enum.ChatVersion.TextChatService then
                    local config = TextChatService:FindFirstChild("ChatInputBarConfiguration")
                    local targetChannel = config and config.TargetTextChannel
                    local textChannels = TextChatService:FindFirstChild("TextChannels")
                    local generalChannel = targetChannel or (textChannels and (textChannels:FindFirstChild("RBXGeneral") or textChannels:GetChildren()[1]))
                    if generalChannel then
                        generalChannel:SendAsync(TrollState.ChatSpamText)
                    end
                else
                    local defaultChat = ReplicatedStorage:FindFirstChild("DefaultChatSystemChatEvents")
                    local remote = defaultChat and defaultChat:FindFirstChild("SayMessageRequest")
                    if remote then
                        remote:FireServer(TrollState.ChatSpamText, "All")
                    end
                end
            end)
        end
    end
end)

task.spawn(function()
    while task.wait(0.1) do
        if TrollState.LoopKill and TrollState.LoopKillTarget and TrollState.LoopKillTarget.Character then
            UseWeaponOnTarget(TrollState.LoopKillTarget.Character)
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
        task.wait(0.25)
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
CreateSlider(MainPage, "SetLagFPS", 1, 100, 10, function(value)
    TrollState.LagFPSValue = value
end)
CreateToggle(MainPage, "FakeLagNet", function(state)
    TrollState.FakeLagNet = state
end)

CreateSection(MainPage, "SecTroll")
CreateToggle(MainPage, "Spin", function(state)
    TrollState.Spin = state
end)
CreateSlider(MainPage, "SpinSpeed", 1, 100, 10, function(value)
    TrollState.SpinSpeed = value
end)

CreateToggle(MainPage, "ScratchBack", function(state)
    if state then
        TrollState.SharpenSword = false
        TrollState.ScratchBack = true
    else
        TrollState.ScratchBack = false
    end

    pcall(function()
        local char = LocalPlayer.Character
        local ru = char and (char:FindFirstChild("RightUpperArm") or char:FindFirstChild("Right Arm"))
        local torso = char and (char:FindFirstChild("Torso") or char:FindFirstChild("UpperTorso"))
        local rs = (ru and ru:FindFirstChild("RightShoulder")) or (torso and torso:FindFirstChild("Right Shoulder"))
        if rs and TrollState.OriginalShoulderC0 then
            if not TrollState.ScratchBack and not TrollState.SharpenSword then
                rs.C0 = TrollState.OriginalShoulderC0
                TrollState.OriginalShoulderC0 = nil
            end
        end
    end)
end)
CreateSlider(MainPage, "ScratchBackSpeed", 5, 45, 20, function(value)
    TrollState.ScratchBackSpeed = value
end)

CreateToggle(MainPage, "SharpenSword", function(state)
    if state then
        TrollState.ScratchBack = false
        TrollState.SharpenSword = true
    else
        TrollState.SharpenSword = false
    end

    pcall(function()
        local char = LocalPlayer.Character
        local ru = char and (char:FindFirstChild("RightUpperArm") or char:FindFirstChild("Right Arm"))
        local torso = char and (char:FindFirstChild("Torso") or char:FindFirstChild("UpperTorso"))
        local rs = (ru and ru:FindFirstChild("RightShoulder")) or (torso and torso:FindFirstChild("Right Shoulder"))
        if rs and TrollState.OriginalShoulderC0 then
            if not TrollState.ScratchBack and not TrollState.SharpenSword then
                rs.C0 = TrollState.OriginalShoulderC0
                TrollState.OriginalShoulderC0 = nil
            end
        end
    end)
end)
CreateSlider(MainPage, "SharpenSwordSpeed", 5, 45, 20, function(value)
    TrollState.SharpenSwordSpeed = value
end)

CreateSection(MainPage, "SecTarget")
CreatePlayerDropdown(MainPage)

CreateSection(MainPage, "SecDestroy")

CreateButton(MainPage, "OrbitFling", function()
    StopAllActions()
    if TrollState.TargetPlayer then
        RunOrbitFling(TrollState.TargetPlayer, false)
    else
        Notify("Error", "Select a target first!", Color3.fromRGB(255,0,0))
    end
end)

CreateButton(MainPage, "VoidFling", function()
    StopAllActions()
    if TrollState.TargetPlayer then
        RunOrbitFling(TrollState.TargetPlayer, true)
    else
        Notify("Error", "Select a target first!", Color3.fromRGB(255,0,0))
    end
end)

CreateButton(MainPage, "Freeze", function()
    if TrollState.TargetPlayer then
        TrollState.FreezeTarget = TrollState.TargetPlayer
        TrollState.FreezePos = nil
        Notify("Freeze", TrollState.TargetPlayer.DisplayName, CurrentTheme.Accent)
    else
        Notify("Error", "Select a target first!", Color3.fromRGB(255,0,0))
    end
end)

CreateButton(MainPage, "Unfreeze", function()
    if TrollState.FreezeTarget then
        StopAllActions()
        Notify("Unfreeze", "Target unfrozen.", CurrentTheme.Accent)
    else
        Notify("Info", "No target frozen.", CurrentTheme.Accent)
    end
end)

CreateButton(MainPage, "SpinTarget", function()
    if TrollState.TargetPlayer then
        TrollState.SpinTarget = TrollState.TargetPlayer
        Notify("Spin", TrollState.TargetPlayer.DisplayName, CurrentTheme.Accent)
    else
        Notify("Error", "Select a target first!", Color3.fromRGB(255,0,0))
    end
end)

CreateButton(MainPage, "TPTarget", function()
    local target = TrollState.TargetPlayer
    if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
        local myChar = LocalPlayer.Character
        if myChar and myChar:FindFirstChild("HumanoidRootPart") then
            myChar.HumanoidRootPart.CFrame = target.Character.HumanoidRootPart.CFrame * CFrame.new(0,5,0)
            Notify("Teleport", "Teleported to " .. target.DisplayName, CurrentTheme.Accent)
        end
    else
        Notify("Error", "Cannot teleport!", Color3.fromRGB(255,0,0))
    end
end)

CreateButton(MainPage, "LoopKill", function()
    if TrollState.TargetPlayer then
        TrollState.LoopKillTarget = TrollState.TargetPlayer
        TrollState.LoopKill = true
        Notify("Loop Kill", "Loop killing " .. TrollState.TargetPlayer.DisplayName, Color3.fromRGB(255,0,0))
    else
        Notify("Error", "Select a target first!", Color3.fromRGB(255,0,0))
    end
end)

CreateSection(MainPage, "SecGang")

CreateButton(MainPage, "FuckBack", function()
    StopAllActions()
    if TrollState.TargetPlayer then
        TrollState.AttachTarget = TrollState.TargetPlayer
        TrollState.AttachMode = "Back"
        ApplyEjaculationFX()
        Notify("Success", "Attached to " .. TrollState.TargetPlayer.DisplayName, Color3.fromRGB(255,50,150))
    else
        Notify("Error", "Select a target first!", Color3.fromRGB(255,0,0))
    end
end)

CreateButton(MainPage, "FuckFront", function()
    StopAllActions()
    if TrollState.TargetPlayer then
        TrollState.AttachTarget = TrollState.TargetPlayer
        TrollState.AttachMode = "Front"
        ApplyEjaculationFX()
        Notify("Success", "Attached to " .. TrollState.TargetPlayer.DisplayName, Color3.fromRGB(255,50,150))
    else
        Notify("Error", "Select a target first!", Color3.fromRGB(255,0,0))
    end
end)

CreateButton(MainPage, "Victim", function()
    StopAllActions()
    pcall(function()
        local char = LocalPlayer.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        local hum = char and char:FindFirstChildOfClass("Humanoid")
        if not hrp then return end
        if hum then hum.PlatformStand = true end
        hrp.CFrame = CFrame.new(hrp.Position - Vector3.new(0,1.35,0)) * CFrame.Angles(math.rad(90),0,0)
        hrp.Anchored = true
        Notify("Victim Mode", "Locked to floor.", Color3.fromRGB(255,120,0))
    end)
end)

CreateSection(MainPage, "SecSelf")

CreateToggle(MainPage, "GodMode", function(state)
    TrollState.GodMode = state
    if state then
        EnableGodMode()
        Notify("God Mode", "Activated!", CurrentTheme.Accent)
    else
        Notify("God Mode", "Deactivated.", CurrentTheme.Accent)
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
            if hum then hum.PlatformStand = false end
        end)
    end
end)

CreateSlider(MainPage, "FlySpeed", 20, 200, 50, function(value)
    TrollState.FlySpeed = value
end)

CreateToggle(MainPage, "KillAura", function(state)
    TrollState.KillAura = state
end)

CreateSlider(MainPage, "AuraRange", 5, 50, 15, function(value)
    TrollState.KillAuraRange = value
end)

CreateToggle(MainPage, "ChatSpam", function(state)
    TrollState.ChatSpam = state
end)

CreateTextBox(MainPage, "Spam text...", function(text)
    TrollState.ChatSpamText = text
end)

CreateButton(MainPage, "StopAll", function()
    StopAllActions()
    Notify("Stopped", "All targets and actions cleared.", Color3.fromRGB(255,255,255))
end)

CreateSection(MainPage, "SecTheme")

local function CreateThemeButton(key)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1,-5,0,36)
    button.BackgroundColor3 = Color3.fromRGB(20,20,27)
    button.BorderSizePixel = 0
    button.Font = Enum.Font.GothamBold
    button.Text = "Theme: " .. Themes[key].Name
    button.TextColor3 = Themes[key].Accent
    button.TextSize = 11
    button.ZIndex = 25
    button.Parent = MainPage
    AddCorner(button,10)
    AddStroke(button, Themes[key].Accent, 0.72, 1)

    button.MouseEnter:Connect(function()
        Tween(button,0.16,{BackgroundColor3 = Color3.fromRGB(30,30,40)})
    end)
    button.MouseLeave:Connect(function()
        Tween(button,0.16,{BackgroundColor3 = Color3.fromRGB(20,20,27)})
    end)

    button.MouseButton1Click:Connect(function()
        ApplyTheme(key)
        button.TextColor3 = Themes[key].Accent
        Notify("Theme", Themes[key].Name, Themes[key].Accent)
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

local InfoCard = Instance.new("Frame")
InfoCard.Size = UDim2.new(1,-5,0,180)
InfoCard.BackgroundColor3 = Color3.fromRGB(18,18,25)
InfoCard.BackgroundTransparency = 0.06
InfoCard.BorderSizePixel = 0
InfoCard.ZIndex = 25
InfoCard.Parent = InfoPage
AddCorner(InfoCard,14)
AddStroke(InfoCard, CurrentTheme.Accent, 0.72, 1)

local InfoLogo = Instance.new("ImageLabel")
InfoLogo.Size = UDim2.fromOffset(54,54)
InfoLogo.Position = UDim2.fromOffset(15,16)
InfoLogo.BackgroundTransparency = 1
InfoLogo.Image = LOGO_ID
InfoLogo.ZIndex = 26
InfoLogo.Parent = InfoCard
AddCorner(InfoLogo,15)

local InfoDevLabel = Instance.new("TextLabel")
InfoDevLabel.BackgroundTransparency = 1
InfoDevLabel.Position = UDim2.fromOffset(82,18)
InfoDevLabel.Size = UDim2.new(1,-96,0,24)
InfoDevLabel.Font = Enum.Font.GothamBold
InfoDevLabel.TextColor3 = Color3.fromRGB(255,255,255)
InfoDevLabel.TextSize = 12
InfoDevLabel.TextXAlignment = Enum.TextXAlignment.Left
InfoDevLabel.ZIndex = 26
InfoDevLabel.Parent = InfoCard
RegisterText(InfoDevLabel, "InfoDev")

local InfoNameLabel = Instance.new("TextLabel")
InfoNameLabel.BackgroundTransparency = 1
InfoNameLabel.Position = UDim2.fromOffset(82,46)
InfoNameLabel.Size = UDim2.new(1,-96,0,40)
InfoNameLabel.Font = Enum.Font.Gotham
InfoNameLabel.TextColor3 = Color3.fromRGB(195,195,208)
InfoNameLabel.TextSize = 11
InfoNameLabel.TextWrapped = true
InfoNameLabel.TextXAlignment = Enum.TextXAlignment.Left
InfoNameLabel.ZIndex = 26
InfoNameLabel.Parent = InfoCard
RegisterText(InfoNameLabel, "InfoName")

local infoLine = Instance.new("Frame")
infoLine.Size = UDim2.new(1,-30,0,1)
infoLine.Position = UDim2.fromOffset(15,92)
infoLine.BackgroundColor3 = Color3.fromRGB(70,70,82)
infoLine.BorderSizePixel = 0
infoLine.ZIndex = 26
infoLine.Parent = InfoCard

local InfoDiscLabel = Instance.new("TextLabel")
InfoDiscLabel.BackgroundTransparency = 1
InfoDiscLabel.Position = UDim2.fromOffset(15,106)
InfoDiscLabel.Size = UDim2.new(1,-30,0,20)
InfoDiscLabel.Font = Enum.Font.GothamBold
InfoDiscLabel.TextColor3 = Color3.fromRGB(125,190,255)
InfoDiscLabel.TextSize = 11
InfoDiscLabel.TextXAlignment = Enum.TextXAlignment.Left
InfoDiscLabel.ZIndex = 26
InfoDiscLabel.Parent = InfoCard
RegisterText(InfoDiscLabel, "InfoDisc")

local CopyDiscBtn = Instance.new("TextButton")
CopyDiscBtn.BackgroundColor3 = Color3.fromRGB(30,35,48)
CopyDiscBtn.Position = UDim2.fromOffset(15,132)
CopyDiscBtn.Size = UDim2.new(1,-30,0,34)
CopyDiscBtn.BorderSizePixel = 0
CopyDiscBtn.Font = Enum.Font.GothamBold
CopyDiscBtn.Text = "https://discord.gg/vpfFGGjg9"
CopyDiscBtn.TextColor3 = Color3.fromRGB(135,195,255)
CopyDiscBtn.TextSize = 10
CopyDiscBtn.ZIndex = 26
CopyDiscBtn.Parent = InfoCard
AddCorner(CopyDiscBtn,10)
AddHover(CopyDiscBtn, CopyDiscBtn.BackgroundColor3, Color3.fromRGB(42,48,65))

CopyDiscBtn.MouseButton1Click:Connect(function()
    local link = "https://discord.gg/vpfFGGjg9"
    local clipboard = setclipboard or (syn and syn.write_clipboard)
    if clipboard then
        pcall(function()
            clipboard(link)
        end)
        Notify("Discord", "Ссылка скопирована в буфер обмена!", Color3.fromRGB(100,200,255))
    else
        Notify("Discord", link, Color3.fromRGB(100,200,255))
    end
end)

CreateInfoLabel(InfoPage, "UI style: modern dark glass / splash inspired by the supplied visual reference.")
CreateInfoLabel(InfoPage, "Arm animations: Чесать спину + отдельная Точить шпагу.")

--==============================================================
-- CONTENT PRELOAD
--==============================================================

local function PreloadUiAssets()
    pcall(function()
        ContentProvider:PreloadAsync({
            MainFrame,
            HeaderLogo,
            SidebarLogo,
            InfoLogo,
            SplashLogo,
            BackgroundImage
        })
    end)
end

--==============================================================
-- SPLASH -> OPEN WINDOW
--==============================================================

task.spawn(function()
    task.wait(0.2)

    Tween(SplashLogo,0.6,{ImageTransparency = 0},Enum.EasingStyle.Back,Enum.EasingDirection.Out)
    Tween(SplashGlow,0.9,{Size = UDim2.fromOffset(220,220),BackgroundTransparency = 0.88},Enum.EasingStyle.Sine,Enum.EasingDirection.InOut)
    task.wait(0.25)

    Tween(SplashTitle,0.55,{TextTransparency = 0},Enum.EasingStyle.Quint,Enum.EasingDirection.Out)
    task.wait(0.2)

    Tween(SplashAuthor,0.45,{TextTransparency = 0})
    task.wait(0.2)

    Tween(SplashStatus,0.35,{TextTransparency = 0})

    SplashStatus.Text = "Loading interface..."
    Tween(SplashBar,0.8,{Size = UDim2.new(0.20,0,1,0)})
    task.wait(0.8)

    SplashStatus.Text = "Loading controls..."
    Tween(SplashBar,0.7,{Size = UDim2.new(0.42,0,1,0)})
    task.wait(0.7)

    SplashStatus.Text = "Loading animations..."
    Tween(SplashBar,0.7,{Size = UDim2.new(0.64,0,1,0)})
    task.wait(0.7)

    SplashStatus.Text = "Loading target system..."
    Tween(SplashBar,0.7,{Size = UDim2.new(0.82,0,1,0)})
    task.wait(0.7)

    SplashStatus.Text = "Preparing hub..."
    Tween(SplashBar,0.6,{Size = UDim2.new(1,0,1,0)})
    task.wait(0.7)

    SplashStatus.Text = "Legenly Hub ready"
    task.wait(0.8)

    Tween(SplashLogo,0.3,{ImageTransparency = 1})
    Tween(SplashTitle,0.3,{TextTransparency = 1})
    Tween(SplashAuthor,0.3,{TextTransparency = 1})
    Tween(SplashStatus,0.25,{TextTransparency = 1})
    Tween(SplashBarBack,0.25,{BackgroundTransparency = 1})
    Tween(SplashGlow,0.3,{BackgroundTransparency = 1})
    Tween(Splash,0.42,{BackgroundTransparency = 1})

    task.wait(0.45)
    Splash.Visible = false

    OpenMainWindow()
end)

--==============================================================
-- PRELOAD / FINAL
--==============================================================

PreloadUiAssets()

print("================================")
print("Legenly HUB - Troll & Universal")
print("UI: Premium Edition v10.0")
print("Arm animation 1: Scratch Back")
print("Arm animation 2: Sharpen Sword")
print("================================")
