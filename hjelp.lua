--[[ HUB - Troll & Universal (Fixed Fling, Kill Aura, Theme Dropdown, Visual Tags)
    Разработчик: Legenly
    Версия: Hardcore Premium Edition v9.1 (Mobile Fly, Noclip, Fling Anchored, KillAura+)
]]

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")
local TextChatService = game:GetService("TextChatService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer

-- ==========================================
-- ТЕМЫ И ОФОРМЛЕНИЕ
-- ==========================================
local Themes = {
    Red = {Accent = Color3.fromRGB(255, 60, 60), Name = "Ruby Red"},
    Blue = {Accent = Color3.fromRGB(60, 150, 255), Name = "Deep Blue"},
    Purple = {Accent = Color3.fromRGB(180, 60, 255), Name = "Amethyst Purple"},
    Green = {Accent = Color3.fromRGB(60, 255, 120), Name = "Acid Green"},
    Gold = {Accent = Color3.fromRGB(255, 190, 60), Name = "Luxury Gold"}
}
local CurrentTheme = Themes.Red
local RecolorQueue = {}

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

-- ==========================================
-- МУЛЬТИЯЗЫЧНОСТЬ (TRANSLATIONS)
-- ==========================================
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
        SpamSword = "Точить шпагу (Дрочка 18+)",
        ArmSpeed = "Скорость руки",
        SecTarget = "Выбор Жертвы",
        SelectPlr = " Цель: Выберите игрока...",
        SecDestroy = "Уничтожение Игроков",
        OrbitFling = "ORBIT FLING (Уничтожить цель)",
        VoidFling = "VOID FLING (Под текстуры)",
        Freeze = "Заморозить цель (Visual)",
        SpinTarget = "Закрутить цель (Visual)",
        TPTarget = "Телепорт к цели",
        LoopKill = "Зацикленный килл цели",
        SecGang = "Gang Bang (18+ Троллинг)",
        FuckBack = "Трахнуть (Сзади + Фрикции)",
        FuckFront = "Выехать в рот (Спереди + Фрикции)",
        Victim = "Стать жертвой насилия (Лечь) (Visual)",
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
        ThemeSelect = "Выбор темы",
        DiscordBtn = "Скопировать ссылку на Discord",
        InfoDev = "Автор и разработчик: Legenly",
        InfoName = "Проект: HUB - Troll & Universal",
        InfoDisc = "Discord канал с обновлениями:",
        NotifSwitched = "Язык изменен на Русский",
        PlrSelected = "выбран в качестве цели!",
        ThemeChanged = "Тема изменена на "
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
        SpamSword = "Sharpen Sword (18+ Action)",
        ArmSpeed = "Hand Speed",
        SecTarget = "Select Target",
        SelectPlr = " Target: Select player...",
        SecDestroy = "Destroy Players",
        OrbitFling = "ORBIT FLING (Destroy Target)",
        VoidFling = "VOID FLING (Under Map)",
        Freeze = "Freeze Target (Visual)",
        SpinTarget = "Spin Target (Visual)",
        TPTarget = "Teleport to Target",
        LoopKill = "Loop Kill Target",
        SecGang = "Gang Bang (18+ Trolling)",
        FuckBack = "Fuck (Behind + Thrusts)",
        FuckFront = "Face Fuck (Front + Thrusts)",
        Victim = "Become Victim (Lay down) (Visual)",
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
        ThemeSelect = "Select Theme",
        DiscordBtn = "Copy Discord Link",
        InfoDev = "Author & Developer: Legenly",
        InfoName = "Project: HUB - Troll & Universal",
        InfoDisc = "Discord Server for Updates:",
        NotifSwitched = "Language switched to English",
        PlrSelected = "selected as target!",
        ThemeChanged = "Theme changed to "
    }
}

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
                if txt then
                    item.Element.Text = txt
                end
            end)
        end
    end
end

-- ==========================================
-- СОСТОЯНИЕ СКРИПТА
-- ==========================================
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
}

-- ==========================================
-- ПЕРЕМЕННЫЕ ДЛЯ FLY (Mobile Fix)
-- ==========================================
local flyDirection = Vector3.zero
local touchPos = nil

-- ==========================================
-- ИНИЦИАЛИЗАЦИЯ ИНТЕРФЕЙСА
-- ==========================================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "LegenlyTrollHub_Ultimate"
ScreenGui.ResetOnSpawn = false
local success, _ = pcall(function()
    ScreenGui.Parent = CoreGui
end)
if not success then
    ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
end

-- Кастомные уведомления
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
            local transp = i / 10
            NotifFrame.BackgroundTransparency = transp
            TxtTitle.TextTransparency = transp
            TxtMsg.TextTransparency = transp
            AccentLine.BackgroundTransparency = transp
            task.wait(0.02)
        end
        if NotifFrame and NotifFrame.Parent then
            NotifFrame:Destroy()
        end
    end)
end

-- Главное окно
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Name = "MainFrame"
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.5, -275, 0.5, -200)
MainFrame.Size = UDim2.new(0, 550, 0, 400)
MainFrame.ClipsDescendants = true
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 8)

-- Шапка
local TitleBar = Instance.new("Frame", MainFrame)
TitleBar.Name = "TitleBar"
TitleBar.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
TitleBar.Size = UDim2.new(1, 0, 0, 35)
TitleBar.BorderSizePixel = 0

local TitleText = Instance.new("TextLabel", TitleBar)
TitleText.BackgroundTransparency = 1
TitleText.Position = UDim2.new(0, 15, 0, 0)
TitleText.Size = UDim2.new(1, -120, 1, 0)
TitleText.Font = Enum.Font.GothamBold
TitleText.TextColor3 = CurrentTheme.Accent
TitleText.TextSize = 14
TitleText.TextXAlignment = Enum.TextXAlignment.Left
RegisterText(TitleText, "Title")
RegisterForRecolor(TitleText, "TextColor3")

-- Кнопка смены языка [RU / EN]
local LangBtn = Instance.new("TextButton", TitleBar)
LangBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
LangBtn.Position = UDim2.new(1, -100, 0.5, -12)
LangBtn.Size = UDim2.new(0, 55, 0, 24)
LangBtn.Font = Enum.Font.GothamBold
LangBtn.Text = "RU / EN"
LangBtn.TextColor3 = Color3.fromRGB(220, 220, 220)
LangBtn.TextSize = 11
Instance.new("UICorner", LangBtn).CornerRadius = UDim.new(0, 5)
LangBtn.MouseButton1Click:Connect(function()
    if CurrentLang == "RU" then
        SwitchLanguage("EN")
        Notify("Language", Translations.EN.NotifSwitched, CurrentTheme.Accent)
    else
        SwitchLanguage("RU")
        Notify("Язык", Translations.RU.NotifSwitched, CurrentTheme.Accent)
    end
end)

-- Кнопка сворачивания [-]
local MinimizeBtn = Instance.new("TextButton", TitleBar)
MinimizeBtn.BackgroundTransparency = 1
MinimizeBtn.Position = UDim2.new(1, -35, 0, 0)
MinimizeBtn.Size = UDim2.new(0, 35, 1, 0)
MinimizeBtn.Font = Enum.Font.GothamBold
MinimizeBtn.Text = "-"
MinimizeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizeBtn.TextSize = 20

-- Островок (Dynamic Island)
local IslandFrame = Instance.new("Frame", ScreenGui)
IslandFrame.Name = "IslandFrame"
IslandFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
IslandFrame.Position = UDim2.new(0.5, -55, 0, 20)
IslandFrame.Size = UDim2.new(0, 110, 0, 36)
IslandFrame.Visible = false
IslandFrame.BorderSizePixel = 0
Instance.new("UICorner", IslandFrame).CornerRadius = UDim.new(1, 0)

local IslandClicker = Instance.new("TextButton", IslandFrame)
IslandClicker.Size = UDim2.new(1, 0, 1, 0)
IslandClicker.BackgroundTransparency = 1
IslandClicker.Text = ""

local IslandText = Instance.new("TextLabel", IslandFrame)
IslandText.BackgroundTransparency = 1
IslandText.Position = UDim2.new(0, 15, 0, 0)
IslandText.Size = UDim2.new(1, -35, 1, 0)
IslandText.Font = Enum.Font.GothamBold
IslandText.Text = "Troll"
IslandText.TextColor3 = Color3.fromRGB(255, 255, 255)
IslandText.TextSize = 14
IslandText.TextXAlignment = Enum.TextXAlignment.Left

local IslandDot = Instance.new("Frame", IslandFrame)
IslandDot.Size = UDim2.new(0, 6, 0, 6)
IslandDot.Position = UDim2.new(1, -18, 0.5, -3)
IslandDot.BorderSizePixel = 0
IslandDot.BackgroundColor3 = CurrentTheme.Accent
Instance.new("UICorner", IslandDot).CornerRadius = UDim.new(1, 0)
RegisterForRecolor(IslandDot, "BackgroundColor3")

-- ==========================================
-- УНИВЕРСАЛЬНАЯ СИСТЕМА ДРАГА (БЕЗ ФАЛЬШИВЫХ КЛИКОВ)
-- ==========================================
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

MakeDraggable(TitleBar, MainFrame, false)
MakeDraggable(IslandClicker, IslandFrame, true)

MinimizeBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
    IslandFrame.Visible = true
    Notify("Troll Hub", Translations[CurrentLang].NotifSwitched, CurrentTheme.Accent)
end)

-- Боковая панель
local Sidebar = Instance.new("Frame", MainFrame)
Sidebar.Name = "Sidebar"
Sidebar.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
Sidebar.Position = UDim2.new(0, 0, 0, 35)
Sidebar.Size = UDim2.new(0, 140, 1, -35)
Sidebar.BorderSizePixel = 0

-- Контейнер страниц
local Pages = Instance.new("Frame", MainFrame)
Pages.Name = "Pages"
Pages.BackgroundTransparency = 1
Pages.Position = UDim2.new(0, 150, 0, 45)
Pages.Size = UDim2.new(1, -160, 1, -55)

local MainPage = Instance.new("ScrollingFrame", Pages)
MainPage.Name = "MainPage"
MainPage.BackgroundTransparency = 1
MainPage.Size = UDim2.new(1, 0, 1, 0)
MainPage.ScrollBarThickness = 4
MainPage.BorderSizePixel = 0

local InfoPage = Instance.new("ScrollingFrame", Pages)
InfoPage.Name = "InfoPage"
InfoPage.BackgroundTransparency = 1
InfoPage.Size = UDim2.new(1, 0, 1, 0)

-- ==========================================
-- КОНСТРУКТОРЫ ЭЛЕМЕНТОВ ИНТЕРФЕЙСА
-- ==========================================
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
        if state then
            Btn.BackgroundColor3 = newColor
        end
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
    table.insert(TextElements, {Element = {Text = ""}, Key = textKey})

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
    Fill.BorderSizePixel = 0
    Instance.new("UICorner", Fill).CornerRadius = UDim.new(1, 0)
    RegisterForRecolor(Fill, "BackgroundColor3")

    local dragging = false
    local function updateFromMouse(x)
        local rel = math.clamp((x - Bar.AbsolutePosition.X) / Bar.AbsoluteSize.X, 0, 1)
        local val = math.round(min + rel * (max - min))
        Fill.Size = UDim2.new(rel, 0, 1, 0)
        UpdateLabelText(val)
        callback(val)
    end

    Bar.MouseButton1Down:Connect(function()
        dragging = true
        local x = UserInputService:GetMouseLocation().X
        updateFromMouse(x)
    end)

    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            updateFromMouse(input.Position.X)
        end
    end)

    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)

    -- Touch support for slider
    Bar.TouchTap:Connect(function()
        local x = UserInputService:GetMouseLocation().X
        updateFromMouse(x)
    end)

    Bar.TouchLongPress:Connect(function()
        dragging = true
    end)

    UserInputService.TouchMoved:Connect(function(input)
        if dragging then
            updateFromMouse(input.Position.X)
        end
    end)

    UserInputService.TouchEnded:Connect(function()
        dragging = false
    end)
end

-- ==========================================
-- ПОСТРОЕНИЕ ИНТЕРФЕЙСА (ГЛАВНАЯ СТРАНИЦА)
-- ==========================================
local UIListLayout = Instance.new("UIListLayout", MainPage)
UIListLayout.Padding = UDim.new(0, 8)

-- Раздел: Движение & Лаги
CreateSection(MainPage, "SecMove")

CreateToggle(MainPage, "EgorSpeed", function(state)
    TrollState.EgorSpeed = state
end)

CreateToggle(MainPage, "FakeLagFPS", function(state)
    TrollState.FakeLagFPS = state
end)

CreateSlider(MainPage, "SetLagFPS", 1, 30, 10, function(value)
    TrollState.LagFPSValue = value
end)

CreateToggle(MainPage, "FakeLagNet", function(state)
    TrollState.FakeLagNet = state
end)

-- Раздел: Троллинг
CreateSection(MainPage, "SecTroll")

CreateToggle(MainPage, "Spin", function(state)
    TrollState.Spin = state
end)

CreateSlider(MainPage, "SpinSpeed", 1, 50, 10, function(value)
    TrollState.SpinSpeed = value
end)

CreateToggle(MainPage, "SpamSword", function(state)
    TrollState.SpamSword = state
end)

CreateSlider(MainPage, "ArmSpeed", 5, 50, 20, function(value)
    TrollState.SpamSwordSpeed = value
end)

-- Раздел: Выбор Жертвы
CreateSection(MainPage, "SecTarget")

local TargetFrame = Instance.new("Frame", MainPage)
TargetFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
TargetFrame.Size = UDim2.new(1, -10, 0, 35)
Instance.new("UICorner", TargetFrame).CornerRadius = UDim.new(0, 6)

local MainBtn = Instance.new("TextButton", TargetFrame)
MainBtn.BackgroundTransparency = 1
MainBtn.Size = UDim2.new(1, 0, 1, 0)
MainBtn.Font = Enum.Font.Gotham
MainBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
MainBtn.TextSize = 12
MainBtn.TextXAlignment = Enum.TextXAlignment.Left
MainBtn.Text = " " .. Translations[CurrentLang].SelectPlr
RegisterText(MainBtn, "SelectPlr")

local Arrow = Instance.new("TextLabel", TargetFrame)
Arrow.BackgroundTransparency = 1
Arrow.Position = UDim2.new(1, -30, 0, 0)
Arrow.Size = UDim2.new(0, 30, 1, 0)
Arrow.Font = Enum.Font.GothamBold
Arrow.Text = "▼"
Arrow.TextColor3 = Color3.fromRGB(200, 200, 200)
Arrow.TextSize = 12

local DropFrame = Instance.new("Frame", TargetFrame)
DropFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
DropFrame.Position = UDim2.new(0, 0, 1, 0)
DropFrame.Size = UDim2.new(1, 0, 0, 35)
DropFrame.ClipsDescendants = true
Instance.new("UICorner", DropFrame).CornerRadius = UDim.new(0, 6)

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
        if child:IsA("TextButton") then
            child:Destroy()
        end
    end
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer then
            local PlrBtn = Instance.new("TextButton", Scroll)
            PlrBtn.Size = UDim2.new(1, -5, 0, 25)
            PlrBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
            PlrBtn.Font = Enum.Font.Gotham
            PlrBtn.Text = " " .. plr.DisplayName .. " (@" .. plr.Name .. ")"
            PlrBtn.TextColor3 = Color3.fromRGB(220, 220, 220)
            PlrBtn.TextSize = 11
            PlrBtn.TextXAlignment = Enum.TextXAlignment.Left
            Instance.new("UICorner", PlrBtn).CornerRadius = UDim.new(0, 4)
            PlrBtn.MouseButton1Click:Connect(function()
                TrollState.TargetPlayer = plr
                MainBtn.Text = " " .. plr.DisplayName
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

-- Раздел: Уничтожение Игроков
CreateSection(MainPage, "SecDestroy")

local function CreateDestroyButton(parent, textKey, callback)
    local Btn = Instance.new("TextButton", parent)
    Btn.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
    Btn.Size = UDim2.new(1, -10, 0, 30)
    Btn.Font = Enum.Font.GothamBold
    Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    Btn.TextSize = 12
    Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 6)
    RegisterText(Btn, textKey)
    Btn.MouseButton1Click:Connect(function()
        if TrollState.TargetPlayer then
            callback(TrollState.TargetPlayer)
        else
            Notify("Error", "Select a target first!", Color3.fromRGB(255, 0, 0))
        end
    end)
end

CreateDestroyButton(MainPage, "OrbitFling", function(target)
    RunOrbitFling(target, false)
end)

CreateDestroyButton(MainPage, "VoidFling", function(target)
    RunOrbitFling(target, true)
end)

CreateDestroyButton(MainPage, "Freeze", function(target)
    TrollState.FreezeTarget = target
    TrollState.FreezePos = target.Character and target.Character:GetPivot()
end)

CreateDestroyButton(MainPage, "SpinTarget", function(target)
    TrollState.SpinTarget = target
end)

CreateDestroyButton(MainPage, "TPTarget", function(target)
    local char = LocalPlayer.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    local tChar = target.Character
    local tHrp = tChar and tChar:FindFirstChild("HumanoidRootPart")
    if hrp and tHrp then
        hrp.CFrame = tHrp.CFrame + Vector3.new(0, 3, 0)
    end
end)

CreateDestroyButton(MainPage, "LoopKill", function(target)
    TrollState.LoopKill = not TrollState.LoopKill
    if TrollState.LoopKill then
        TrollState.LoopKillTarget = target
        Notify("Loop Kill", "Started on " .. target.DisplayName, CurrentTheme.Accent)
    else
        TrollState.LoopKillTarget = nil
        Notify("Loop Kill", "Stopped", CurrentTheme.Accent)
    end
end)

-- Раздел: Gang Bang
CreateSection(MainPage, "SecGang")

CreateDestroyButton(MainPage, "FuckBack", function(target)
    TrollState.AttachTarget = target
    TrollState.AttachMode = "Back"
end)

CreateDestroyButton(MainPage, "FuckFront", function(target)
    TrollState.AttachTarget = target
    TrollState.AttachMode = "Front"
end)

CreateDestroyButton(MainPage, "Victim", function(target)
    local char = LocalPlayer.Character
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    if hum then
        hum.PlatformStand = true
        hum.AutoRotate = false
    end
end)

-- Раздел: Собственные функции
CreateSection(MainPage, "SecSelf")

CreateToggle(MainPage, "GodMode", function(state)
    TrollState.GodMode = state
    local char = LocalPlayer.Character
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    if hum then
        hum.MaxHealth = state and math.huge or 100
        hum.Health = state and math.huge or 100
    end
end)

CreateToggle(MainPage, "Noclip", function(state)
    TrollState.Noclip = state
    local char = LocalPlayer.Character
    if char then
        for _, part in ipairs(char:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = not state
            end
        end
    end
end)

CreateToggle(MainPage, "Fly", function(state)
    TrollState.Fly = state
    if not state then
        flyDirection = Vector3.zero
        touchPos = nil
        local char = LocalPlayer.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        if hrp then
            local bv = hrp:FindFirstChild("FlyVelocity")
            local bg = hrp:FindFirstChild("FlyGyro")
            if bv then bv:Destroy() end
            if bg then bg:Destroy() end
        end
    end
end)

CreateSlider(MainPage, "FlySpeed", 10, 200, 50, function(value)
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

-- Раздел: Оформление (выпадающий список тем)
CreateSection(MainPage, "SecTheme")

local ThemeFrame = Instance.new("Frame", MainPage)
ThemeFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
ThemeFrame.Size = UDim2.new(1, -10, 0, 35)
Instance.new("UICorner", ThemeFrame).CornerRadius = UDim.new(0, 6)

local ThemeMainBtn = Instance.new("TextButton", ThemeFrame)
ThemeMainBtn.BackgroundTransparency = 1
ThemeMainBtn.Size = UDim2.new(1, 0, 1, 0)
ThemeMainBtn.Font = Enum.Font.Gotham
ThemeMainBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ThemeMainBtn.TextSize = 12
ThemeMainBtn.TextXAlignment = Enum.TextXAlignment.Left
ThemeMainBtn.Text = " " .. Translations[CurrentLang].ThemeSelect .. ": " .. CurrentTheme.Name
RegisterText(ThemeMainBtn, "ThemeSelect")

local ThemeArrow = Instance.new("TextLabel", ThemeFrame)
ThemeArrow.BackgroundTransparency = 1
ThemeArrow.Position = UDim2.new(1, -30, 0, 0)
ThemeArrow.Size = UDim2.new(0, 30, 1, 0)
ThemeArrow.Font = Enum.Font.GothamBold
ThemeArrow.Text = "▼"
ThemeArrow.TextColor3 = Color3.fromRGB(200, 200, 200)
ThemeArrow.TextSize = 12

local ThemeDropFrame = Instance.new("Frame", ThemeFrame)
ThemeDropFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
ThemeDropFrame.Position = UDim2.new(0, 0, 1, 0)
ThemeDropFrame.Size = UDim2.new(1, 0, 0, 35)
ThemeDropFrame.ClipsDescendants = true
Instance.new("UICorner", ThemeDropFrame).CornerRadius = UDim.new(0, 6)

local ThemeScroll = Instance.new("ScrollingFrame", ThemeDropFrame)
ThemeScroll.Position = UDim2.new(0, 5, 0, 35)
ThemeScroll.Size = UDim2.new(1, -10, 0, 110)
ThemeScroll.BackgroundTransparency = 1
ThemeScroll.ScrollBarThickness = 3
ThemeScroll.BorderSizePixel = 0

local ThemeListLayout = Instance.new("UIListLayout", ThemeScroll)
ThemeListLayout.Padding = UDim.new(0, 4)

local themeOpen = false

local function RefreshThemes()
    for _, child in pairs(ThemeScroll:GetChildren()) do
        if child:IsA("TextButton") then
            child:Destroy()
        end
    end
    for themeKey, themeData in pairs(Themes) do
        local Btn = Instance.new("TextButton", ThemeScroll)
        Btn.Size = UDim2.new(1, -5, 0, 25)
        Btn.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
        Btn.Font = Enum.Font.Gotham
        Btn.Text = " " .. themeData.Name
        Btn.TextColor3 = Color3.fromRGB(220, 220, 220)
        Btn.TextSize = 11
        Btn.TextXAlignment = Enum.TextXAlignment.Left
        Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 4)
        Btn.MouseButton1Click:Connect(function()
            ApplyTheme(themeKey)
            ThemeMainBtn.Text = " " .. Translations[CurrentLang].ThemeSelect .. ": " .. CurrentTheme.Name
            themeOpen = false
            ThemeDropFrame.Size = UDim2.new(1, -10, 0, 35)
            ThemeArrow.Text = "▼"
            Notify("Theme", Translations[CurrentLang].ThemeChanged .. CurrentTheme.Name, CurrentTheme.Accent)
        end)
    end
    ThemeScroll.CanvasSize = UDim2.new(0, 0, 0, ThemeListLayout.AbsoluteContentSize.Y + 10)
end

ThemeMainBtn.MouseButton1Click:Connect(function()
    themeOpen = not themeOpen
    if themeOpen then
        RefreshThemes()
        ThemeDropFrame.Size = UDim2.new(1, -10, 0, 150)
        ThemeArrow.Text = "▲"
    else
        ThemeDropFrame.Size = UDim2.new(1, -10, 0, 35)
        ThemeArrow.Text = "▼"
    end
end)

-- Кнопка остановки всех действий
local StopBtn = Instance.new("TextButton", MainPage)
StopBtn.BackgroundColor3 = Color3.fromRGB(200, 30, 30)
StopBtn.Size = UDim2.new(1, -10, 0, 35)
StopBtn.Font = Enum.Font.GothamBold
StopBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
StopBtn.TextSize = 14
Instance.new("UICorner", StopBtn).CornerRadius = UDim.new(0, 6)
RegisterText(StopBtn, "StopAll")
StopBtn.MouseButton1Click:Connect(function()
    StopAllActions()
end)

-- ==========================================
-- ПОСТРОЕНИЕ ИНТЕРФЕЙСА (ИНФО СТРАНИЦА)
-- ==========================================
local InfoLayout = Instance.new("UIListLayout", InfoPage)
InfoLayout.Padding = UDim.new(0, 10)

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

CreateInfoLabel(InfoPage, Translations[CurrentLang].InfoDev)
CreateInfoLabel(InfoPage, Translations[CurrentLang].InfoName)
CreateInfoLabel(InfoPage, Translations[CurrentLang].InfoDisc)
CreateInfoLabel(InfoPage, "https://discord.gg/example")

local DiscordBtn = Instance.new("TextButton", InfoPage)
DiscordBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
DiscordBtn.Size = UDim2.new(1, -10, 0, 30)
DiscordBtn.Font = Enum.Font.GothamBold
DiscordBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
DiscordBtn.TextSize = 12
Instance.new("UICorner", DiscordBtn).CornerRadius = UDim.new(0, 6)
RegisterText(DiscordBtn, "DiscordBtn")
DiscordBtn.MouseButton1Click:Connect(function()
    setclipboard and setclipboard("https://discord.gg/example")
    Notify("Discord", "Link copied to clipboard!", CurrentTheme.Accent)
end)

-- ==========================================
-- НАВИГАЦИЯ ПО ВКЛАДКАМ
-- ==========================================
local function CreateTabButton(parent, textKey, page)
    local Btn = Instance.new("TextButton", parent)
    Btn.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
    Btn.Size = UDim2.new(1, -10, 0, 30)
    Btn.Position = UDim2.new(0, 5, 0, 5)
    Btn.Font = Enum.Font.GothamBold
    Btn.TextColor3 = Color3.fromRGB(200, 200, 200)
    Btn.TextSize = 12
    Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 6)
    RegisterText(Btn, textKey)
    Btn.MouseButton1Click:Connect(function()
        MainPage.Visible = false
        InfoPage.Visible = false
        page.Visible = true
        for _, child in pairs(Sidebar:GetChildren()) do
            if child:IsA("TextButton") then
                child.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
                child.TextColor3 = Color3.fromRGB(200, 200, 200)
            end
        end
        Btn.BackgroundColor3 = CurrentTheme.Accent
        Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        Btn:SetAttribute("IsActiveTab", true)
    end)
    table.insert(RecolorQueue, function(newColor)
        if Btn:GetAttribute("IsActiveTab") then
            Btn.BackgroundColor3 = newColor
        end
    end)
    return Btn
end

local TabMain = CreateTabButton(Sidebar, "TabMain", MainPage)
local TabInfo = CreateTabButton(Sidebar, "TabInfo", InfoPage)

-- Активируем главную вкладку по умолчанию
TabMain.MouseButton1Click:Fire()

-- ==========================================
-- ЛОГИКА ТРОЛЛИНГА И ЭФФЕКТОВ
-- ==========================================
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
        pe.Speed = NumberRange.new(12, 22)
        pe.VelocitySpread = 35
        pe.Lifetime = NumberRange.new(0.6, 1.2)
        pe.Color = ColorSequence.new(Color3.fromRGB(255, 255, 255))
        pe.Size = NumberSequence.new({
            NumberSequenceKeypoint.new(0, 0.5),
            NumberSequenceKeypoint.new(1, 0.05)
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
        if fx then
            pcall(function() fx:Destroy() end)
        end
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
            hrp.Anchored = false -- снимаем anchor, если остался
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

    TrollState.LoopKill = false
    TrollState.LoopKillTarget = nil
    TrollState.FreezeTarget = nil
    TrollState.FreezePos = nil
    TrollState.SpinTarget = nil
    flyDirection = Vector3.zero
    touchPos = nil
end

-- ==========================================
-- FE ORBIT / VOID FLING BYPASS (FIX: сам не улетаешь)
-- ==========================================
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

    TrollState.FlingActive = true
    Notify(isVoidMode and "Void Fling" or "Orbit Fling", "Flinging: " .. target.DisplayName, CurrentTheme.Accent)

    -- Запоминаем исходное состояние
    local wasAnchored = myHrp.Anchored
    myHrp.Anchored = true -- заанкориваем себя, чтобы не сдвинуться

    task.spawn(function()
        local startTime = tick()
        local duration = 5

        while TrollState.FlingActive and tick() - startTime < duration and myHrp and targetHrp and targetHrp.Parent do
            -- Вычисляем позицию для телепортации
            local targetPos = targetHrp.Position
            local offset
            if isVoidMode then
                offset = Vector3.new(0, -20, 0) -- глубоко под карту
            else
                local dir = (targetPos - myHrp.Position).Unit
                local perp = Vector3.new(-dir.Z, 0, dir.X)
                if perp.Magnitude < 0.1 then
                    perp = Vector3.new(0, 0, 1)
                end
                perp = perp.Unit
                offset = perp * 5 + Vector3.new(0, 2, 0) -- орбита
            end
            local newPos = targetPos + offset
            myHrp.CFrame = CFrame.new(newPos)

            -- Дополнительно создаём столкновение, нанося удар инструментом (если есть)
            UseWeaponOnTarget(targetChar)

            task.wait(0.05)
        end

        -- Возвращаем anchor в исходное состояние
        if myHrp then
            myHrp.Anchored = wasAnchored
        end
        TrollState.FlingActive = false
        Notify("Fling", "Finished!", CurrentTheme.Accent)
    end)
end

-- ==========================================
-- ОСНОВНОЙ ЦИКЛ (HEARTBEAT)
-- ==========================================
RunService.Heartbeat:Connect(function(dt)
    local char = LocalPlayer.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    local hum = char and char:FindFirstChildOfClass("Humanoid")

    -- God Mode
    if TrollState.GodMode and hum then
        hum.MaxHealth = math.huge
        hum.Health = math.huge
    end

    -- Noclip (все части)
    if TrollState.Noclip and char then
        for _, part in ipairs(char:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end

    -- Fly (Mobile + Keyboard)
    if TrollState.Fly and hrp then
        local moveDir = Vector3.zero
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then moveDir = moveDir + Vector3.new(0, 0, -1) end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then moveDir = moveDir + Vector3.new(0, 0, 1) end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then moveDir = moveDir + Vector3.new(-1, 0, 0) end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then moveDir = moveDir + Vector3.new(1, 0, 0) end
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then moveDir = moveDir + Vector3.new(0, 1, 0) end
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then moveDir = moveDir + Vector3.new(0, -1, 0) end

        local finalDir = moveDir.Magnitude > 0 and moveDir.Unit or Vector3.zero
        if touchPos then
            finalDir = flyDirection
        end

        hrp.AssemblyLinearVelocity = finalDir * TrollState.FlySpeed

        local bv = hrp:FindFirstChild("FlyVelocity")
        if not bv then
            bv = Instance.new("BodyVelocity")
            bv.Name = "FlyVelocity"
            bv.MaxForce = Vector3.new(1e9, 1e9, 1e9)
            bv.Parent = hrp
        end
        bv.Velocity = finalDir * TrollState.FlySpeed

        local bg = hrp:FindFirstChild("FlyGyro")
        if not bg then
            bg = Instance.new("BodyGyro")
            bg.Name = "FlyGyro"
            bg.MaxTorque = Vector3.new(1e9, 1e9, 1e9)
            bg.Parent = hrp
        end
        bg.CFrame = hrp.CFrame
    end

    -- Spin (свой)
    if TrollState.Spin and hrp then
        hrp.AssemblyAngularVelocity = Vector3.new(0, TrollState.SpinSpeed, 0)
    end

    -- Spam Sword
    if TrollState.SpamSword and char then
        local tool = char:FindFirstChildOfClass("Tool")
        if tool then
            local handle = tool:FindFirstChild("Handle")
            if handle then
                local shoulder = char:FindFirstChild("Torso") and char.Torso:FindFirstChild("Right Shoulder")
                if not shoulder then
                    shoulder = char:FindFirstChild("UpperTorso") and char.UpperTorso:FindFirstChild("Right Shoulder")
                end
                if shoulder and shoulder:IsA("Motor6D") then
                    if not TrollState.OriginalShoulderC0 then
                        TrollState.OriginalShoulderC0 = shoulder.C0
                    end
                    local time = tick()
                    local angle = math.sin(time * TrollState.SpamSwordSpeed) * 2
                    shoulder.C0 = CFrame.new(1, 0.5, 0) * CFrame.Angles(angle, 0, 0)
                end
            end
        end
    end

    -- Freeze Target (Visual)
    if TrollState.FreezeTarget and TrollState.FreezePos then
        local tChar = TrollState.FreezeTarget.Character
        local tHrp = tChar and tChar:FindFirstChild("HumanoidRootPart")
        if tHrp then
            tHrp.CFrame = TrollState.FreezePos
        end
    end

    -- Spin Target (Visual)
    if TrollState.SpinTarget then
        local tChar = TrollState.SpinTarget.Character
        local tHrp = tChar and tChar:FindFirstChild("HumanoidRootPart")
        if tHrp then
            tHrp.AssemblyAngularVelocity = Vector3.new(0, 20, 0)
        end
    end

    -- Kill Aura (улучшена)
    if TrollState.KillAura and hrp then
        for _, plr in pairs(Players:GetPlayers()) do
            if plr ~= LocalPlayer then
                local tChar = plr.Character
                local tHrp = tChar and tChar:FindFirstChild("HumanoidRootPart")
                if tHrp and (tHrp.Position - hrp.Position).Magnitude < TrollState.KillAuraRange then
                    local tHum = tChar:FindFirstChildOfClass("Humanoid")
                    if tHum and tHum.Health > 0 then
                        -- Пытаемся убить через здоровье
                        tHum.Health = 0
                        task.wait(0.1)
                        -- Если не убило (защита), применяем удары инструментом
                        if tHum.Health > 0 then
                            UseWeaponOnTarget(tChar)
                        end
                    end
                end
            end
        end
    end

    -- Loop Kill
    if TrollState.LoopKill and TrollState.LoopKillTarget then
        local tChar = TrollState.LoopKillTarget.Character
        local tHum = tChar and tChar:FindFirstChildOfClass("Humanoid")
        if tHum then
            tHum.Health = 0
            task.wait(0.1)
            if tHum.Health > 0 then
                UseWeaponOnTarget(tChar)
            end
        end
    end

    -- Attach (Fuck modes)
    if TrollState.AttachTarget and TrollState.AttachMode ~= "" and hrp then
        local tChar = TrollState.AttachTarget.Character
        local tHrp = tChar and tChar:FindFirstChild("HumanoidRootPart")
        if tHrp then
            local offset = TrollState.AttachMode == "Back" and Vector3.new(0, 0, -2) or Vector3.new(0, 0, 2)
            hrp.CFrame = tHrp.CFrame * CFrame.new(offset)
            ApplyEjaculationFX()
        end
    end

    -- Chat Spam
    if TrollState.ChatSpam then
        pcall(function()
            local chat = TextChatService:FindFirstChild("TextChannels") and TextChatService.TextChannels:FindFirstChild("General")
            if chat then
                chat:SendAsync(TrollState.ChatSpamText)
            end
        end)
    end
end)

-- ==========================================
-- ОБРАБОТЧИКИ СЕНСОРНОГО УПРАВЛЕНИЯ ДЛЯ FLY
-- ==========================================
UserInputService.TouchStarted:Connect(function(touch)
    if TrollState.Fly then
        touchPos = touch.Position
    end
end)

UserInputService.TouchMoved:Connect(function(touch)
    if TrollState.Fly and touchPos then
        local delta = touch.Position - touchPos
        flyDirection = Vector3.new(delta.X, 0, -delta.Y).Unit * TrollState.FlySpeed
        touchPos = touch.Position
    end
end)

UserInputService.TouchEnded:Connect(function(touch)
    if TrollState.Fly then
        flyDirection = Vector3.zero
        touchPos = nil
    end
end)

-- ==========================================
-- ОБРАБОТЧИК ВЫХОДА ИГРОКА
-- ==========================================
LocalPlayer.OnTeleport:Connect(function()
    StopAllActions()
end)

LocalPlayer.CharacterAdded:Connect(function()
    StopAllActions()
end)

Notify("Troll Hub", "Loaded successfully! All features fixed.", CurrentTheme.Accent)
