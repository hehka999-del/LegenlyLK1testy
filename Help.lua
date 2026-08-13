--[[
    TH - Evade
    Основано на Troll HUB от Legenly
    Адаптировано для игры Evade
    Функции: настройки игрока, фарм, ESP, анти-некстбот, удаление барьеров, телепорты и другое
]]

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer

-- ==========================================
-- НАСТРОЙКИ ЛОГОТИПА (можно заменить)
-- ==========================================
local MY_LOGO_ID = "rbxassetid://119059199538985" -- Ваш логотип

-- ==========================================
-- ГЛОБАЛЬНЫЕ ПЕРЕМЕННЫЕ
-- ==========================================
local State = {
    -- Player
    speed = 16,
    jumpPower = 50,
    jumpCap = 1,
    strafeAcceleration = 187,
    -- Anti-Nextbot
    antiNextbot = false,
    detectionDistance = 50,
    -- Auto Farm
    autoFarm = false,
    farmCoins = true,
    farmExp = false,
    -- Combat
    aimbot = false,
    autoAttack = false,
    -- Misc
    noclip = false,
    fly = false,
    flySpeed = 50,
    infiniteJump = false,
    -- Visuals
    esp = false,
    espBoxes = true,
    espNames = true,
    espTracers = false,
    espHealth = false,
    -- Event
    eventMode = false,
    -- Barriers
    removeBarriers = false,
    bugEmote = false,
    -- Teleports
    teleportPoints = {},
    customServer = false,
}

local PlayerState = {
    originalWalkSpeed = 16,
    originalJumpPower = 50,
    isFlying = false,
    flyBodyVelocity = nil,
    flyBodyGyro = nil,
    noclipParts = {},
    espObjects = {},
}

-- ==========================================
-- СОЗДАНИЕ GUI (на основе Troll HUB)
-- ==========================================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "THEvadeHub"
ScreenGui.ResetOnSpawn = false
local success = pcall(function() ScreenGui.Parent = CoreGui end)
if not success then ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui") end

-- Главное окно
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.5, -275, 0.5, -200)
MainFrame.Size = UDim2.new(0, 550, 0, 430)
MainFrame.ClipsDescendants = true
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 8)

-- Заголовок
local TitleBar = Instance.new("Frame")
TitleBar.Name = "TitleBar"
TitleBar.Parent = MainFrame
TitleBar.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
TitleBar.Size = UDim2.new(1, 0, 0, 35)
TitleBar.BorderSizePixel = 0

local LogoIcon = Instance.new("ImageLabel")
LogoIcon.Parent = TitleBar
LogoIcon.BackgroundTransparency = 1
LogoIcon.Position = UDim2.new(0, 10, 0, 5)
LogoIcon.Size = UDim2.new(0, 25, 0, 25)
LogoIcon.Image = MY_LOGO_ID

local TitleText = Instance.new("TextLabel")
TitleText.Parent = TitleBar
TitleText.BackgroundTransparency = 1
TitleText.Position = UDim2.new(0, 45, 0, 0)
TitleText.Size = UDim2.new(1, -90, 1, 0)
TitleText.Font = Enum.Font.GothamBold
TitleText.Text = "TH - Evade | By Legenly"
TitleText.TextColor3 = Color3.fromRGB(255, 215, 0)
TitleText.TextSize = 14
TitleText.TextXAlignment = Enum.TextXAlignment.Left

local MinimizeBtn = Instance.new("TextButton")
MinimizeBtn.Parent = TitleBar
MinimizeBtn.BackgroundTransparency = 1
MinimizeBtn.Position = UDim2.new(1, -35, 0, 0)
MinimizeBtn.Size = UDim2.new(0, 35, 1, 0)
MinimizeBtn.Font = Enum.Font.GothamBold
MinimizeBtn.Text = "-"
MinimizeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizeBtn.TextSize = 20

-- Островок
local Island = Instance.new("TextButton")
Island.Name = "IslandFrame"
Island.Parent = ScreenGui
Island.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
Island.Position = UDim2.new(0.5, -60, 0, 20)
Island.Size = UDim2.new(0, 120, 0, 35)
Island.Font = Enum.Font.GothamBold
Island.Text = "  TH - Evade"
Island.TextColor3 = Color3.fromRGB(255, 215, 0)
Island.TextSize = 14
Island.Visible = false
Island.AutoButtonColor = false
Instance.new("UICorner", Island).CornerRadius = UDim.new(1, 0)

local IslandLogo = Instance.new("ImageLabel")
IslandLogo.Parent = Island
IslandLogo.BackgroundTransparency = 1
IslandLogo.Position = UDim2.new(0, 10, 0, 5)
IslandLogo.Size = UDim2.new(0, 25, 0, 25)
IslandLogo.Image = MY_LOGO_ID

-- ==========================================
-- ПЕРЕТАСКИВАНИЕ ОКОН
-- ==========================================
local function MakeWindowDraggable(dragArea, windowToMove)
    local dragging = false
    local dragInput, dragStart, startPos
    
    dragArea.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = windowToMove.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    
    dragArea.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            windowToMove.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
end

MakeWindowDraggable(TitleBar, MainFrame)
MakeWindowDraggable(Island, Island)

-- Сворачивание
MinimizeBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
    Island.Visible = true
end)
Island.MouseButton1Click:Connect(function()
    Island.Visible = false
    MainFrame.Visible = true
end)

-- Боковая панель
local Sidebar = Instance.new("Frame")
Sidebar.Name = "Sidebar"
Sidebar.Parent = MainFrame
Sidebar.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
Sidebar.Position = UDim2.new(0, 0, 0, 35)
Sidebar.Size = UDim2.new(0, 140, 1, -35)

-- Контейнер страниц
local Pages = Instance.new("Frame")
Pages.Name = "Pages"
Pages.Parent = MainFrame
Pages.BackgroundTransparency = 1
Pages.Position = UDim2.new(0, 150, 0, 45)
Pages.Size = UDim2.new(1, -160, 1, -55)

-- Страницы (вкладки)
local tabs = {}
local function CreateTabPage(name)
    local page = Instance.new("ScrollingFrame")
    page.Name = name.."Page"
    page.Parent = Pages
    page.BackgroundTransparency = 1
    page.Size = UDim2.new(1, 0, 1, 0)
    page.ScrollBarThickness = 4
    page.BorderSizePixel = 0
    page.Visible = false
    
    local layout = Instance.new("UIListLayout")
    layout.Parent = page
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Padding = UDim.new(0, 8)
    layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        page.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y + 20)
    end)
    return page
end

local function CreateTabButton(name, page, posY)
    local btn = Instance.new("TextButton")
    btn.Parent = Sidebar
    btn.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
    btn.BorderSizePixel = 0
    btn.Position = UDim2.new(0, 10, 0, posY)
    btn.Size = UDim2.new(1, -20, 0, 35)
    btn.Font = Enum.Font.GothamSemibold
    btn.Text = name
    btn.TextColor3 = Color3.fromRGB(200, 200, 200)
    btn.TextSize = 13
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    
    btn.MouseButton1Click:Connect(function()
        for _, p in pairs(Pages:GetChildren()) do
            if p:IsA("ScrollingFrame") then p.Visible = false end
        end
        page.Visible = true
        for _, child in pairs(Sidebar:GetChildren()) do
            if child:IsA("TextButton") then
                child.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
                child.TextColor3 = Color3.fromRGB(200, 200, 200)
            end
        end
        btn.BackgroundColor3 = Color3.fromRGB(255, 215, 0)
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    end)
    return btn
end

-- Создание вкладок
local playerPage = CreateTabPage("Player")
local autoFarmPage = CreateTabPage("AutoFarm")
local combatPage = CreateTabPage("Combat")
local miscPage = CreateTabPage("Misc")
local visualsPage = CreateTabPage("Visuals")
local eventPage = CreateTabPage("Event")
local infoPage = CreateTabPage("Info")

CreateTabButton("Player", playerPage, 10)
CreateTabButton("Auto Farm", autoFarmPage, 55)
CreateTabButton("Combat", combatPage, 100)
CreateTabButton("Misc", miscPage, 145)
CreateTabButton("Visuals", visualsPage, 190)
CreateTabButton("Event", eventPage, 235)
CreateTabButton("Info", infoPage, 280)

-- Делаем первую вкладку активной
playerPage.Visible = true
local firstBtn = Sidebar:FindFirstChildWhichIsA("TextButton")
if firstBtn then
    firstBtn.BackgroundColor3 = Color3.fromRGB(255, 215, 0)
    firstBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
end

-- ==========================================
-- КОМПОНЕНТЫ UI
-- ==========================================
local function CreateSection(parent, text)
    local lbl = Instance.new("TextLabel", parent)
    lbl.BackgroundTransparency = 1
    lbl.Size = UDim2.new(1, 0, 0, 25)
    lbl.Font = Enum.Font.GothamBold
    lbl.Text = "- " .. text .. " -"
    lbl.TextColor3 = Color3.fromRGB(255, 215, 0)
    lbl.TextSize = 14
end

local function CreateToggle(parent, text, default, callback)
    local frame = Instance.new("Frame", parent)
    frame.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
    frame.Size = UDim2.new(1, -10, 0, 35)
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 6)
    
    local lbl = Instance.new("TextLabel", frame)
    lbl.BackgroundTransparency = 1
    lbl.Position = UDim2.new(0, 10, 0, 0)
    lbl.Size = UDim2.new(1, -50, 1, 0)
    lbl.Font = Enum.Font.Gotham
    lbl.Text = text
    lbl.TextColor3 = Color3.fromRGB(255, 255, 255)
    lbl.TextSize = 13
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    
    local btn = Instance.new("TextButton", frame)
    btn.BackgroundColor3 = default and Color3.fromRGB(255, 215, 0) or Color3.fromRGB(45, 45, 50)
    btn.Position = UDim2.new(1, -35, 0.5, -10)
    btn.Size = UDim2.new(0, 25, 0, 20)
    btn.Text = ""
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 4)
    
    local state = default
    btn.MouseButton1Click:Connect(function()
        state = not state
        btn.BackgroundColor3 = state and Color3.fromRGB(255, 215, 0) or Color3.fromRGB(45, 45, 50)
        callback(state)
    end)
    if default then callback(true) end
    return function() return state end
end

local function CreateSlider(parent, text, min, max, default, callback)
    local frame = Instance.new("Frame", parent)
    frame.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
    frame.Size = UDim2.new(1, -10, 0, 50)
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 6)
    
    local lbl = Instance.new("TextLabel", frame)
    lbl.BackgroundTransparency = 1
    lbl.Position = UDim2.new(0, 10, 0, 5)
    lbl.Size = UDim2.new(1, -20, 0, 20)
    lbl.Font = Enum.Font.Gotham
    lbl.Text = text .. ": " .. default
    lbl.TextColor3 = Color3.fromRGB(255, 255, 255)
    lbl.TextSize = 13
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    
    local bar = Instance.new("TextButton", frame)
    bar.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
    bar.Position = UDim2.new(0, 10, 0, 30)
    bar.Size = UDim2.new(1, -20, 0, 10)
    bar.Text = ""
    bar.AutoButtonColor = false
    Instance.new("UICorner", bar).CornerRadius = UDim.new(1, 0)
    
    local fill = Instance.new("Frame", bar)
    fill.BackgroundColor3 = Color3.fromRGB(255, 215, 0)
    fill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
    Instance.new("UICorner", fill).CornerRadius = UDim.new(1, 0)
    
    local isDragging = false
    bar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            isDragging = true
        end
    end)
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            isDragging = false
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if isDragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local pos = math.clamp(input.Position.X - bar.AbsolutePosition.X, 0, bar.AbsoluteSize.X)
            local percent = pos / bar.AbsoluteSize.X
            fill.Size = UDim2.new(percent, 0, 1, 0)
            local value = math.floor(min + ((max - min) * percent))
            lbl.Text = text .. ": " .. value
            callback(value)
        end
    end)
    callback(default)
end

local function CreateButton(parent, text, callback)
    local btn = Instance.new("TextButton", parent)
    btn.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
    btn.Size = UDim2.new(1, -10, 0, 35)
    btn.Font = Enum.Font.Gotham
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 13
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    
    btn.MouseButton1Click:Connect(function()
        btn.BackgroundColor3 = Color3.fromRGB(255, 215, 0)
        task.wait(0.1)
        btn.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
        callback()
    end)
end

local function CreateTextBox(parent, placeholder, callback)
    local frame = Instance.new("Frame", parent)
    frame.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
    frame.Size = UDim2.new(1, -10, 0, 35)
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 6)
    
    local box = Instance.new("TextBox", frame)
    box.BackgroundTransparency = 1
    box.Size = UDim2.new(1, -20, 1, 0)
    box.Position = UDim2.new(0, 10, 0, 0)
    box.Font = Enum.Font.Gotham
    box.PlaceholderText = placeholder
    box.Text = ""
    box.TextColor3 = Color3.fromRGB(255, 255, 255)
    box.TextSize = 13
    box.TextXAlignment = Enum.TextXAlignment.Left
    
    box.FocusLost:Connect(function() callback(box.Text) end)
end

local function CreateInfoLabel(parent, text)
    local lbl = Instance.new("TextLabel", parent)
    lbl.BackgroundTransparency = 1
    lbl.Size = UDim2.new(1, -10, 0, 20)
    lbl.Font = Enum.Font.Gotham
    lbl.Text = text
    lbl.TextColor3 = Color3.fromRGB(200, 200, 200)
    lbl.TextSize = 13
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.TextWrapped = true
end

-- ==========================================
-- ФУНКЦИОНАЛ ДЛЯ EVADE
-- ==========================================

-- Получить всех игроков, кроме себя
local function GetPlayers()
    local list = {}
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer then table.insert(list, p) end
    end
    return list
end

-- Поиск nextbot (обычно это объект с именем "Nextbot" или "Bot")
local function FindNextbot()
    for _, obj in ipairs(Workspace:GetDescendants()) do
        if obj:IsA("Model") and (obj.Name:lower():find("nextbot") or obj.Name:lower():find("bot")) then
            local hrp = obj:FindFirstChild("HumanoidRootPart")
            if hrp then return obj end
        end
    end
    return nil
end

-- Поиск монет (обычно Part с названием "Coin")
local function FindCoins()
    local coins = {}
    for _, obj in ipairs(Workspace:GetDescendants()) do
        if obj:IsA("BasePart") and obj.Name:lower():find("coin") then
            table.insert(coins, obj)
        end
    end
    return coins
end

-- Поиск барьеров (Part с названием "Barrier")
local function FindBarriers()
    local barriers = {}
    for _, obj in ipairs(Workspace:GetDescendants()) do
        if obj:IsA("BasePart") and (obj.Name:lower():find("barrier") or obj.Name:lower():find("wall")) then
            table.insert(barriers, obj)
        end
    end
    return barriers
end

-- ==========================================
-- РЕАЛИЗАЦИЯ ФУНКЦИЙ
-- ==========================================

-- 1. Player Adjustments
local function ApplyPlayerSettings()
    local char = LocalPlayer.Character
    if not char then return end
    local hum = char:FindFirstChild("Humanoid")
    if not hum then return end
    
    -- Запоминаем оригинальные значения при первом применении
    if not PlayerState.originalWalkSpeed then
        PlayerState.originalWalkSpeed = hum.WalkSpeed
        PlayerState.originalJumpPower = hum.JumpPower
    end
    
    hum.WalkSpeed = State.speed
    hum.JumpPower = State.jumpPower
    -- Jump Cap (ограничение количества прыжков?) - можно реализовать через переменную
end

-- 2. Anti-Nextbot
local function AntiNextbotLoop()
    if not State.antiNextbot then return end
    local char = LocalPlayer.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    
    local bot = FindNextbot()
    if bot and bot:FindFirstChild("HumanoidRootPart") then
        local botPos = bot.HumanoidRootPart.Position
        local dist = (hrp.Position - botPos).Magnitude
        if dist < State.detectionDistance then
            -- Убегаем в противоположную сторону
            local dir = (hrp.Position - botPos).Unit
            local newPos = hrp.Position + dir * 20
            hrp.CFrame = CFrame.new(newPos)
        end
    end
end

-- 3. Auto Farm (монеты)
local function AutoFarmLoop()
    if not State.autoFarm then return end
    local char = LocalPlayer.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    
    local coins = FindCoins()
    if #coins > 0 then
        -- Находим ближайшую монету
        local closest = nil
        local closestDist = math.huge
        for _, coin in ipairs(coins) do
            local dist = (hrp.Position - coin.Position).Magnitude
            if dist < closestDist then
                closestDist = dist
                closest = coin
            end
        end
        if closest then
            hrp.CFrame = closest.CFrame + Vector3.new(0, 2, 0)
        end
    end
end

-- 4. Combat (аимбот, автоатака) - для Evade нет оружия, но можно добавить автоматическое избегание бота
-- Можно сделать автоматический уклон от nextbot

-- 5. Misc: Noclip, Fly, Infinite Jump
local function ToggleNoclip(state)
    State.noclip = state
    if state then
        -- Включаем ноклип для всех частей персонажа
        local char = LocalPlayer.Character
        if char then
            for _, part in ipairs(char:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
        end
    else
        -- Восстанавливаем коллизии
        local char = LocalPlayer.Character
        if char then
            for _, part in ipairs(char:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = true
                end
            end
        end
    end
end

local function ToggleFly(state)
    State.fly = state
    local char = LocalPlayer.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    local hum = char:FindFirstChild("Humanoid")
    if not hrp or not hum then return end
    
    if state then
        hum.PlatformStand = true
        -- BodyVelocity и BodyGyro для управления
        local bv = Instance.new("BodyVelocity")
        bv.MaxForce = Vector3.new(9e9, 9e9, 9e9)
        bv.Velocity = Vector3.new(0, 0, 0)
        bv.Parent = hrp
        
        local bg = Instance.new("BodyGyro")
        bg.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
        bg.P = 9e4
        bg.CFrame = hrp.CFrame
        bg.Parent = hrp
        
        PlayerState.flyBodyVelocity = bv
        PlayerState.flyBodyGyro = bg
        
        -- Цикл управления полетом
        PlayerState.isFlying = true
        task.spawn(function()
            while PlayerState.isFlying and hrp and hum do
                local cam = Workspace.CurrentCamera
                if not cam then break end
                local dir = Vector3.new(0, 0, 0)
                if UserInputService:IsKeyDown(Enum.KeyCode.W) then dir = dir + Vector3.new(0, 0, -1) end
                if UserInputService:IsKeyDown(Enum.KeyCode.S) then dir = dir + Vector3.new(0, 0, 1) end
                if UserInputService:IsKeyDown(Enum.KeyCode.A) then dir = dir + Vector3.new(-1, 0, 0) end
                if UserInputService:IsKeyDown(Enum.KeyCode.D) then dir = dir + Vector3.new(1, 0, 0) end
                if UserInputService:IsKeyDown(Enum.KeyCode.Space) then dir = dir + Vector3.new(0, 1, 0) end
                if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then dir = dir + Vector3.new(0, -1, 0) end
                
                if dir.Magnitude > 0 then
                    local speed = State.flySpeed
                    local vel = cam.CFrame:VectorToWorldSpace(dir.Unit) * speed
                    if PlayerState.flyBodyVelocity then
                        PlayerState.flyBodyVelocity.Velocity = vel
                    end
                else
                    if PlayerState.flyBodyVelocity then
                        PlayerState.flyBodyVelocity.Velocity = Vector3.new(0, 0, 0)
                    end
                end
                if PlayerState.flyBodyGyro then
                    PlayerState.flyBodyGyro.CFrame = cam.CFrame
                end
                task.wait()
            end
        end)
    else
        PlayerState.isFlying = false
        hum.PlatformStand = false
        if PlayerState.flyBodyVelocity then
            PlayerState.flyBodyVelocity:Destroy()
            PlayerState.flyBodyVelocity = nil
        end
        if PlayerState.flyBodyGyro then
            PlayerState.flyBodyGyro:Destroy()
            PlayerState.flyBodyGyro = nil
        end
        -- Сбрасываем скорость
        hrp.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
    end
end

local function ToggleInfiniteJump(state)
    State.infiniteJump = state
    if state then
        UserInputService.JumpRequest:Connect(function()
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
                LocalPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
            end
        end)
    end
end

-- 6. Visuals: ESP
local espFolder = Instance.new("Folder")
espFolder.Name = "TH_ESP"
espFolder.Parent = CoreGui

local function ClearESP()
    espFolder:ClearAllChildren()
end

local function UpdateESP()
    ClearESP()
    if not State.esp then return end
    
    local camera = Workspace.CurrentCamera
    for _, player in ipairs(GetPlayers()) do
        local char = player.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            local hrp = char.HumanoidRootPart
            local pos = hrp.Position
            local screenPos, onScreen = camera:WorldToViewportPoint(pos)
            if onScreen then
                -- Box
                if State.espBoxes then
                    local box = Instance.new("Frame")
                    box.Size = UDim2.new(0, 60, 0, 120)
                    box.Position = UDim2.new(0, screenPos.X - 30, 0, screenPos.Y - 60)
                    box.BackgroundTransparency = 0.5
                    box.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
                    box.BorderSizePixel = 1
                    box.BorderColor3 = Color3.fromRGB(255, 255, 255)
                    box.Parent = espFolder
                end
                -- Name
                if State.espNames then
                    local nameLabel = Instance.new("TextLabel")
                    nameLabel.Size = UDim2.new(0, 100, 0, 20)
                    nameLabel.Position = UDim2.new(0, screenPos.X - 50, 0, screenPos.Y - 80)
                    nameLabel.BackgroundTransparency = 1
                    nameLabel.Text = player.Name
                    nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                    nameLabel.TextSize = 12
                    nameLabel.Font = Enum.Font.GothamBold
                    nameLabel.Parent = espFolder
                end
                -- Tracer
                if State.espTracers then
                    local line = Drawing.new("Line")
                    line.Visible = true
                    line.Color = Color3.new(1, 0, 0)
                    line.Thickness = 1.5
                    line.Transparency = 0.8
                    line.From = Vector2.new(camera.ViewportSize.X / 2, camera.ViewportSize.Y)
                    line.To = Vector2.new(screenPos.X, screenPos.Y)
                    task.delay(0, function()
                        RunService.RenderStepped:Wait()
                        line:Remove()
                    end)
                end
            end
        end
    end
end

-- 7. Remove Barriers
local function RemoveBarriersLoop()
    if not State.removeBarriers then return end
    local barriers = FindBarriers()
    for _, barrier in ipairs(barriers) do
        barrier:Destroy()
    end
end

-- 8. Teleports (запись точек и телепортация)
local teleportPoints = {}
local function AddTeleportPoint(name)
    local char = LocalPlayer.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    teleportPoints[name] = hrp.Position
end

local function TeleportToPoint(name)
    local pos = teleportPoints[name]
    if not pos then return end
    local char = LocalPlayer.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    hrp.CFrame = CFrame.new(pos)
end

-- 9. Bug Emote (эмодзи бага) - возможно, просто анимация

-- ==========================================
-- ЗАПОЛНЕНИЕ ВКЛАДОК
-- ==========================================

-- ВКЛАДКА PLAYER
CreateSection(playerPage, "Настройки игрока")
CreateSlider(playerPage, "Скорость", 10, 200, 16, function(v) State.speed = v ApplyPlayerSettings() end)
CreateSlider(playerPage, "Сила прыжка", 0, 300, 50, function(v) State.jumpPower = v ApplyPlayerSettings() end)
CreateSlider(playerPage, "Лимит прыжков (Cap)", 1, 10, 1, function(v) State.jumpCap = v end)
CreateSlider(playerPage, "Ускорение стрейфа", 100, 300, 187, function(v) State.strafeAcceleration = v end)
CreateButton(playerPage, "Применить настройки", function() ApplyPlayerSettings() end)

CreateSection(playerPage, "Anti-Nextbot")
CreateToggle(playerPage, "Анти-Некстбот", false, function(v) State.antiNextbot = v end)
CreateSlider(playerPage, "Дистанция обнаружения", 10, 100, 50, function(v) State.detectionDistance = v end)

-- ВКЛАДКА AUTO FARM
CreateSection(autoFarmPage, "Фарм")
CreateToggle(autoFarmPage, "Авто-фарм (монеты)", false, function(v) State.autoFarm = v end)
CreateToggle(autoFarmPage, "Фарм опыта", false, function(v) State.farmExp = v end)
CreateButton(autoFarmPage, "Фармнуть сейчас", function()
    -- Мгновенный фарм ближайшей монеты
    local char = LocalPlayer.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    local coins = FindCoins()
    if #coins > 0 then
        local closest = nil
        local closestDist = math.huge
        for _, coin in ipairs(coins) do
            local dist = (hrp.Position - coin.Position).Magnitude
            if dist < closestDist then
                closestDist = dist
                closest = coin
            end
        end
        if closest then
            hrp.CFrame = closest.CFrame + Vector3.new(0, 2, 0)
        end
    end
end)

-- ВКЛАДКА COMBAT
CreateSection(combatPage, "Боевые функции (уклонение)")
CreateToggle(combatPage, "Авто-уклонение от бота", false, function(v) 
    -- Реализуем простой уклон
    if v then
        task.spawn(function()
            while State.autoAttack do
                local bot = FindNextbot()
                if bot and bot:FindFirstChild("HumanoidRootPart") and LocalPlayer.Character then
                    local hrp = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                    if hrp then
                        local dist = (hrp.Position - bot.HumanoidRootPart.Position).Magnitude
                        if dist < 20 then
                            local dir = (hrp.Position - bot.HumanoidRootPart.Position).Unit
                            hrp.CFrame = hrp.CFrame + dir * 10
                        end
                    end
                end
                task.wait(0.5)
            end
        end)
    end
end)

CreateSection(combatPage, "Настройки боя")
CreateToggle(combatPage, "Aimbot (слежение за ботом)", false, function(v)
    State.aimbot = v
    if v then
        task.spawn(function()
            while State.aimbot do
                local bot = FindNextbot()
                if bot and bot:FindFirstChild("HumanoidRootPart") then
                    local cam = Workspace.CurrentCamera
                    cam.CFrame = CFrame.new(cam.CFrame.Position, bot.HumanoidRootPart.Position)
                end
                task.wait()
            end
        end)
    end
end)

-- ВКЛАДКА MISC
CreateSection(miscPage, "Утилиты")
CreateToggle(miscPage, "Noclip", false, function(v) ToggleNoclip(v) end)
CreateToggle(miscPage, "Fly", false, function(v) ToggleFly(v) end)
CreateSlider(miscPage, "Скорость полета", 10, 200, 50, function(v) State.flySpeed = v end)
CreateToggle(miscPage, "Бесконечные прыжки", false, function(v) ToggleInfiniteJump(v) end)
CreateButton(miscPage, "Сбросить скорость/прыжок", function()
    local char = LocalPlayer.Character
    if char and char:FindFirstChild("Humanoid") then
        char.Humanoid.WalkSpeed = PlayerState.originalWalkSpeed or 16
        char.Humanoid.JumpPower = PlayerState.originalJumpPower or 50
    end
end)

CreateSection(miscPage, "Телепорты")
CreateTextBox(miscPage, "Имя точки (например: Home)", function(name)
    if name ~= "" then
        AddTeleportPoint(name)
    end
end)
CreateButton(miscPage, "Записать текущую позицию", function()
    AddTeleportPoint("temp")
end)
CreateButton(miscPage, "Телепорт на записанную точку", function()
    TeleportToPoint("temp")
end)

-- ВКЛАДКА VISUALS
CreateSection(visualsPage, "Визуальные улучшения")
CreateToggle(visualsPage, "ESP (вкл)", false, function(v) State.esp = v end)
CreateToggle(visualsPage, "ESP Boxes", true, function(v) State.espBoxes = v end)
CreateToggle(visualsPage, "ESP Names", true, function(v) State.espNames = v end)
CreateToggle(visualsPage, "ESP Tracers", false, function(v) State.espTracers = v end)

CreateSection(visualsPage, "Барьеры")
CreateToggle(visualsPage, "Удалять барьеры", false, function(v) State.removeBarriers = v end)

-- ВКЛАДКА EVENT
CreateSection(eventPage, "Ивент-режим")
CreateToggle(eventPage, "Режим ивента", false, function(v) State.eventMode = v end)
CreateButton(eventPage, "Bug Emote (эмодзи)", function()
    State.bugEmote = not State.bugEmote
    if State.bugEmote then
        -- Проигрываем анимацию (если есть)
        local char = LocalPlayer.Character
        if char and char:FindFirstChild("Humanoid") then
            local hum = char.Humanoid
            local anim = Instance.new("Animation")
            anim.AnimationId = "rbxassetid://1234567890" -- заменить на реальный ID
            local track = hum:LoadAnimation(anim)
            track:Play()
        end
    end
end)

-- ВКЛАДКА INFO
CreateInfoLabel(infoPage, "TH - Evade Hub")
CreateInfoLabel(infoPage, "Автор: Legenly")
CreateInfoLabel(infoPage, "Основано на Troll HUB")
CreateInfoLabel(infoPage, "--------------------------------")
CreateInfoLabel(infoPage, "Функции:")
CreateInfoLabel(infoPage, "- Настройки игрока (скорость, прыжок)")
CreateInfoLabel(infoPage, "- Анти-Некстбот")
CreateInfoLabel(infoPage, "- Авто-фарм монет")
CreateInfoLabel(infoPage, "- ESP и визуальные улучшения")
CreateInfoLabel(infoPage, "- Удаление барьеров")
CreateInfoLabel(infoPage, "- Noclip, Fly, бесконечные прыжки")
CreateInfoLabel(infoPage, "- Телепорты")
CreateInfoLabel(infoPage, "- Режим ивента")
CreateInfoLabel(infoPage, "--------------------------------")
CreateInfoLabel(infoPage, "Для работы скрипта нужен исполнитель")
CreateInfoLabel(infoPage, "Поддерживает Delta, Solara, и др.")

-- ==========================================
-- ГЛАВНЫЙ ЦИКЛ РЕНДЕРА (обновление состояний)
-- ==========================================
RunService.RenderStepped:Connect(function()
    pcall(function()
        -- Применяем настройки игрока каждый кадр (если изменились)
        ApplyPlayerSettings()
        
        -- Анти-Некстбот
        AntiNextbotLoop()
        
        -- Авто-фарм
        AutoFarmLoop()
        
        -- Удаление барьеров
        RemoveBarriersLoop()
        
        -- ESP
        UpdateESP()
        
        -- Noclip (если включен, поддерживаем)
        if State.noclip then
            local char = LocalPlayer.Character
            if char then
                for _, part in ipairs(char:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            end
        end
    end)
end)

-- ==========================================
-- ОБРАБОТЧИК ВЫХОДА ИГРОКА ИЗ ИГРЫ (чистка)
-- ==========================================
LocalPlayer.CharacterAdded:Connect(function(char)
    -- Пересоздаем ноклип если включен
    if State.noclip then
        ToggleNoclip(true)
    end
    -- Применяем настройки
    ApplyPlayerSettings()
    -- Если флай был включен, перезапускаем
    if State.fly then
        ToggleFly(true)
    end
end)

print("TH - Evade Hub загружен! Автор: Legenly")
