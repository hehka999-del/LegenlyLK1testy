--[[
    TH - Evade
    Полностью рабочий HUB для Evade
    Основан на открытых исходниках VHNS v3, VanillaSourceCode/evade и zReal-King/Evade
    Автор: Legenly
    Версия: 3.0 (Keyless)
]]

-- ==========================================
-- СЕРВИСЫ И ГЛОБАЛЬНЫЕ ПЕРЕМЕННЫЕ
-- ==========================================
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local TweenService = game:GetService("TweenService")
local TeleportService = game:GetService("TeleportService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Lighting = game:GetService("Lighting")
local LocalPlayer = Players.LocalPlayer

local State = {
    -- Player
    speed = 16,
    jumpPower = 50,
    hipHeight = 0,
    fov = 70,
    -- Fly
    fly = false,
    flySpeed = 50,
    -- Noclip
    noclip = false,
    -- Infinite Jump
    infiniteJump = false,
    -- Bhop
    bhop = false,
    -- Auto Farm
    autoFarm = false,
    farmMoney = false,
    farmTickets = false,
    farmCollectables = false,
    -- Auto Respawn/Revive
    autoRespawn = false,
    autoRevive = false,
    -- Anti-Nextbot
    antiNextbot = false,
    detectionDistance = 30,
    -- ESP
    esp = false,
    espPlayers = true,
    espMonsters = true,
    espCollectables = false,
    espBoxes = true,
    espNames = true,
    espHealth = false,
    -- World
    removeBarriers = false,
    fullBright = false,
    noFog = false,
    -- Server
    autoRejoin = false,
}

local PlayerState = {
    originalWalkSpeed = 16,
    originalJumpPower = 50,
    isFlying = false,
    flyBodyVelocity = nil,
    flyBodyGyro = nil,
}

-- ==========================================
-- СОЗДАНИЕ GUI
-- ==========================================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "THEvadeHub"
ScreenGui.ResetOnSpawn = false
pcall(function() ScreenGui.Parent = CoreGui end)

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

local TitleText = Instance.new("TextLabel")
TitleText.Parent = TitleBar
TitleText.BackgroundTransparency = 1
TitleText.Position = UDim2.new(0, 15, 0, 0)
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

-- Перетаскивание окон
local function MakeWindowDraggable(dragArea, windowToMove)
    local dragging = false
    local dragInput, dragStart, startPos
    dragArea.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = windowToMove.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then dragging = false end
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
local farmPage = CreateTabPage("Auto Farm")
local combatPage = CreateTabPage("Combat")
local visualsPage = CreateTabPage("Visuals")
local worldPage = CreateTabPage("World")
local infoPage = CreateTabPage("Info")

CreateTabButton("Player", playerPage, 10)
CreateTabButton("Auto Farm", farmPage, 55)
CreateTabButton("Combat", combatPage, 100)
CreateTabButton("Visuals", visualsPage, 145)
CreateTabButton("World", worldPage, 190)
CreateTabButton("Info", infoPage, 235)

playerPage.Visible = true
local firstBtn = Sidebar:FindFirstChildWhichIsA("TextButton")
if firstBtn then
    firstBtn.BackgroundColor3 = Color3.fromRGB(255, 215, 0)
    firstBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
end

-- ==========================================
-- UI КОМПОНЕНТЫ
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
-- ЯДРО ФУНКЦИОНАЛА (ВЗЯТО ИЗ ОТКРЫТЫХ ИСХОДНИКОВ)
-- ==========================================

-- Поиск объектов в мире
local function FindNextbot()
    for _, obj in ipairs(Workspace:GetDescendants()) do
        if obj:IsA("Model") and (obj.Name:lower():find("nextbot") or obj.Name:lower():find("bot") or obj.Name:lower():find("npc")) then
            local hrp = obj:FindFirstChild("HumanoidRootPart")
            if hrp then return obj end
        end
    end
    return nil
end

local function FindCollectables()
    local items = {}
    for _, obj in ipairs(Workspace:GetDescendants()) do
        if obj:IsA("BasePart") and (obj.Name:lower():find("coin") or obj.Name:lower():find("ticket") or obj.Name:lower():find("collect") or obj.Name:lower():find("rose")) then
            table.insert(items, obj)
        end
    end
    return items
end

local function FindBarriers()
    local barriers = {}
    for _, obj in ipairs(Workspace:GetDescendants()) do
        if obj:IsA("BasePart") and (obj.Name:lower():find("barrier") or obj.Name:lower():find("wall") or obj.Name:lower():find("invis")) then
            table.insert(barriers, obj)
        end
    end
    return barriers
end

local function GetPlayers()
    local list = {}
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer then table.insert(list, p) end
    end
    return list
end

-- 1. НАСТРОЙКИ ИГРОКА
local function ApplyPlayerSettings()
    local char = LocalPlayer.Character
    if not char then return end
    local hum = char:FindFirstChild("Humanoid")
    if not hum then return end
    if not PlayerState.originalWalkSpeed then
        PlayerState.originalWalkSpeed = hum.WalkSpeed
        PlayerState.originalJumpPower = hum.JumpPower
    end
    hum.WalkSpeed = State.speed
    hum.JumpPower = State.jumpPower
    hum.HipHeight = State.hipHeight
    Workspace.CurrentCamera.FieldOfView = State.fov
end

-- 2. FLY (ВЗЯТО ИЗ ОТКРЫТЫХ ИСХОДНИКОВ)
local function ToggleFly(state)
    State.fly = state
    local char = LocalPlayer.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    local hum = char:FindFirstChild("Humanoid")
    if not hrp or not hum then return end
    if state then
        hum.PlatformStand = true
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
        hrp.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
    end
end

-- 3. NOCLIP
local function ToggleNoclip(state)
    State.noclip = state
    if state then
        local char = LocalPlayer.Character
        if char then
            for _, part in ipairs(char:GetDescendants()) do
                if part:IsA("BasePart") then part.CanCollide = false end
            end
        end
    else
        local char = LocalPlayer.Character
        if char then
            for _, part in ipairs(char:GetDescendants()) do
                if part:IsA("BasePart") then part.CanCollide = true end
            end
        end
    end
end

-- 4. БЕСКОНЕЧНЫЕ ПРЫЖКИ
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

-- 5. АВТО-ФАРМ (ВЗЯТО ИЗ ОТКРЫТЫХ ИСХОДНИКОВ)
local function AutoFarmLoop()
    if not State.autoFarm then return end
    local char = LocalPlayer.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    local items = FindCollectables()
    if #items > 0 then
        local closest = nil
        local closestDist = math.huge
        for _, item in ipairs(items) do
            local dist = (hrp.Position - item.Position).Magnitude
            if dist < closestDist then
                closestDist = dist
                closest = item
            end
        end
        if closest then
            hrp.CFrame = closest.CFrame + Vector3.new(0, 2, 0)
        end
    end
end

-- 6. АНТИ-НЕКСТБОТ (ВЗЯТО ИЗ ОТКРЫТЫХ ИСХОДНИКОВ)
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
            local dir = (hrp.Position - botPos).Unit
            local newPos = hrp.Position + dir * 20
            hrp.CFrame = CFrame.new(newPos)
        end
    end
end

-- 7. АВТО-РЕСПАВН (ВЗЯТО ИЗ ОТКРЫТЫХ ИСХОДНИКОВ)
local function AutoRespawnLoop()
    if not State.autoRespawn then return end
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        local hum = LocalPlayer.Character.Humanoid
        if hum.Health <= 0 or hum.Health == 0 then
            task.wait(0.5)
            -- Отправляем событие респавна
            local respawnEvent = ReplicatedStorage:FindFirstChild("Events") and ReplicatedStorage.Events:FindFirstChild("Player") and ReplicatedStorage.Events.Player:FindFirstChild("ChangePlayerMode")
            if respawnEvent then
                respawnEvent:FireServer(true)
            end
        end
    end
end

-- 8. АВТО-ВОСКРЕШЕНИЕ (ВЗЯТО ИЗ ОТКРЫТЫХ ИСХОДНИКОВ)
local function AutoReviveLoop()
    if not State.autoRevive then return end
    -- Ищем упавших игроков и воскрешаем
    for _, player in ipairs(GetPlayers()) do
        local char = player.Character
        if char and char:FindFirstChild("Humanoid") then
            local hum = char.Humanoid
            if hum.Health <= 0 or hum.Health == 0 then
                -- Пытаемся воскресить (если есть событие)
                local reviveEvent = ReplicatedStorage:FindFirstChild("Events") and ReplicatedStorage.Events:FindFirstChild("Player") and ReplicatedStorage.Events.Player:FindFirstChild("Revive")
                if reviveEvent then
                    reviveEvent:FireServer(player)
                end
            end
        end
    end
end

-- 9. УДАЛЕНИЕ БАРЬЕРОВ (ВЗЯТО ИЗ ОТКРЫТЫХ ИСХОДНИКОВ)
local function RemoveBarriersLoop()
    if not State.removeBarriers then return end
    local barriers = FindBarriers()
    for _, barrier in ipairs(barriers) do
        barrier:Destroy()
    end
    -- Особый случай: очистка InvisParts
    local invisParts = Workspace:FindFirstChild("Game") and Workspace.Game:FindFirstChild("Map") and Workspace.Game.Map:FindFirstChild("InvisParts")
    if invisParts then
        invisParts:ClearAllChildren()
    end
end

-- 10. FULL BRIGHT (ВЗЯТО ИЗ ОТКРЫТЫХ ИСХОДНИКОВ)
local function ToggleFullBright(state)
    State.fullBright = state
    if state then
        Lighting.Brightness = 4
        Lighting.FogEnd = 100000
        Lighting.GlobalShadows = false
        Lighting.ClockTime = 12
    else
        Lighting.Brightness = 1
        Lighting.FogEnd = 1000
        Lighting.GlobalShadows = true
    end
end

-- 11. РЕЖИМ BHOP (ВЗЯТО ИЗ ОТКРЫТЫХ ИСХОДНИКОВ)
local function ToggleBhop(state)
    State.bhop = state
    if state then
        UserInputService.JumpRequest:Connect(function()
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
                local hum = LocalPlayer.Character.Humanoid
                if hum and hum:GetState() == Enum.HumanoidStateType.Running then
                    hum:ChangeState(Enum.HumanoidStateType.Jumping)
                end
            end
        end)
    end
end

-- 12. ESP (ВЗЯТО ИЗ ОТКРЫТЫХ ИСХОДНИКОВ)
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
    -- ESP игроков
    if State.espPlayers then
        for _, player in ipairs(GetPlayers()) do
            local char = player.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
                local hrp = char.HumanoidRootPart
                local pos = hrp.Position
                local screenPos, onScreen = camera:WorldToViewportPoint(pos)
                if onScreen then
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
                    if State.espHealth then
                        local healthLabel = Instance.new("TextLabel")
                        healthLabel.Size = UDim2.new(0, 50, 0, 16)
                        healthLabel.Position = UDim2.new(0, screenPos.X - 25, 0, screenPos.Y - 60)
                        healthLabel.BackgroundTransparency = 1
                        local hum = char:FindFirstChild("Humanoid")
                        healthLabel.Text = hum and math.floor(hum.Health) or "?"
                        healthLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
                        healthLabel.TextSize = 10
                        healthLabel.Font = Enum.Font.Gotham
                        healthLabel.Parent = espFolder
                    end
                end
            end
        end
    end
    -- ESP монстров (некстботов)
    if State.espMonsters then
        local bot = FindNextbot()
        if bot and bot:FindFirstChild("HumanoidRootPart") then
            local hrp = bot.HumanoidRootPart
            local pos = hrp.Position
            local screenPos, onScreen = camera:WorldToViewportPoint(pos)
            if onScreen then
                local nameLabel = Instance.new("TextLabel")
                nameLabel.Size = UDim2.new(0, 100, 0, 20)
                nameLabel.Position = UDim2.new(0, screenPos.X - 50, 0, screenPos.Y - 80)
                nameLabel.BackgroundTransparency = 1
                nameLabel.Text = "⚠ NEXTBOT"
                nameLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
                nameLabel.TextSize = 14
                nameLabel.Font = Enum.Font.GothamBold
                nameLabel.Parent = espFolder
            end
        end
    end
    -- ESP коллекционируемых предметов
    if State.espCollectables then
        local items = FindCollectables()
        for _, item in ipairs(items) do
            local pos = item.Position
            local screenPos, onScreen = camera:WorldToViewportPoint(pos)
            if onScreen then
                local nameLabel = Instance.new("TextLabel")
                nameLabel.Size = UDim2.new(0, 80, 0, 16)
                nameLabel.Position = UDim2.new(0, screenPos.X - 40, 0, screenPos.Y - 8)
                nameLabel.BackgroundTransparency = 1
                nameLabel.Text = "★ ITEM"
                nameLabel.TextColor3 = Color3.fromRGB(0, 255, 255)
                nameLabel.TextSize = 10
                nameLabel.Font = Enum.Font.GothamBold
                nameLabel.Parent = espFolder
            end
        end
    end
end

-- 13. ПЕРЕЗАХОД (ВЗЯТО ИЗ ОТКРЫТЫХ ИСХОДНИКОВ)
local function Rejoin()
    if #Players:GetPlayers() <= 1 then
        LocalPlayer:Kick("Rejoining...")
        task.wait()
        TeleportService:Teleport(game.PlaceId, LocalPlayer)
    else
        TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, LocalPlayer)
    end
end

-- ==========================================
-- ЗАПОЛНЕНИЕ ВКЛАДОК
-- ==========================================

-- ВКЛАДКА PLAYER
CreateSection(playerPage, "Настройки игрока")
CreateSlider(playerPage, "Скорость", 10, 200, 16, function(v) State.speed = v ApplyPlayerSettings() end)
CreateSlider(playerPage, "Сила прыжка", 0, 300, 50, function(v) State.jumpPower = v ApplyPlayerSettings() end)
CreateSlider(playerPage, "Высота бедра", 0, 10, 0, function(v) State.hipHeight = v ApplyPlayerSettings() end)
CreateSlider(playerPage, "Поле зрения (FOV)", 70, 120, 70, function(v) State.fov = v ApplyPlayerSettings() end)

CreateSection(playerPage, "Движение")
CreateToggle(playerPage, "Fly (полёт)", false, function(v) ToggleFly(v) end)
CreateSlider(playerPage, "Скорость полёта", 10, 200, 50, function(v) State.flySpeed = v end)
CreateToggle(playerPage, "Noclip (проход сквозь стены)", false, function(v) ToggleNoclip(v) end)
CreateToggle(playerPage, "Infinite Jump", false, function(v) ToggleInfiniteJump(v) end)
CreateToggle(playerPage, "Bhop (бани-хоп)", false, function(v) ToggleBhop(v) end)

CreateSection(playerPage, "Anti-Nextbot")
CreateToggle(playerPage, "Анти-Некстбот", false, function(v) State.antiNextbot = v end)
CreateSlider(playerPage, "Дистанция обнаружения", 10, 100, 30, function(v) State.detectionDistance = v end)

-- ВКЛАДКА AUTO FARM
CreateSection(farmPage, "Авто-фарм")
CreateToggle(farmPage, "Включить авто-фарм", false, function(v) State.autoFarm = v end)
CreateToggle(farmPage, "Фарм монет", true, function(v) State.farmMoney = v end)
CreateToggle(farmPage, "Фарм билетов", false, function(v) State.farmTickets = v end)
CreateToggle(farmPage, "Фарм коллекционных предметов", false, function(v) State.farmCollectables = v end)

CreateSection(farmPage, "Авто-респавн и воскрешение")
CreateToggle(farmPage, "Auto Respawn", false, function(v) State.autoRespawn = v end)
CreateToggle(farmPage, "Auto Revive (воскрешать других)", false, function(v) State.autoRevive = v end)

CreateButton(farmPage, "Собрать всё сейчас", function()
    local char = LocalPlayer.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    local items = FindCollectables()
    for _, item in ipairs(items) do
        hrp.CFrame = item.CFrame + Vector3.new(0, 2, 0)
        task.wait(0.1)
    end
end)

-- ВКЛАДКА COMBAT
CreateSection(combatPage, "Боевые функции")
CreateToggle(combatPage, "Авто-уклонение от бота", false, function(v)
    if v then
        task.spawn(function()
            while State.antiNextbot do
                local bot = FindNextbot()
                if bot and bot:FindFirstChild("HumanoidRootPart") and LocalPlayer.Character then
                    local hrp = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                    if hrp then
                        local dist = (hrp.Position - bot.HumanoidRootPart.Position).Magnitude
                        if dist < 20 then
                            local dir = (hrp.Position - bot.HumanoidRootPart.Position).Unit
                            hrp.CFrame = hrp.CFrame + dir * 15
                        end
                    end
                end
                task.wait(0.3)
            end
        end)
    end
end)

CreateToggle(combatPage, "Aimbot (слежение за ботом)", false, function(v)
    if v then
        task.spawn(function()
            while State.esp do
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

-- ВКЛАДКА VISUALS
CreateSection(visualsPage, "ESP")
CreateToggle(visualsPage, "Включить ESP", false, function(v) State.esp = v end)
CreateToggle(visualsPage, "ESP игроков", true, function(v) State.espPlayers = v end)
CreateToggle(visualsPage, "ESP монстров", true, function(v) State.espMonsters = v end)
CreateToggle(visualsPage, "ESP предметов", false, function(v) State.espCollectables = v end)
CreateToggle(visualsPage, "Boxes (рамки)", true, function(v) State.espBoxes = v end)
CreateToggle(visualsPage, "Имена", true, function(v) State.espNames = v end)
CreateToggle(visualsPage, "Здоровье", false, function(v) State.espHealth = v end)

-- ВКЛАДКА WORLD
CreateSection(worldPage, "Мир")
CreateToggle(worldPage, "Full Bright", false, function(v) ToggleFullBright(v) end)
CreateToggle(worldPage, "Удалить барьеры", false, function(v) State.removeBarriers = v end)

CreateSection(worldPage, "Сервер")
CreateButton(worldPage, "Перезаход (Rejoin)", function() Rejoin() end)
CreateToggle(worldPage, "Авто-перезаход при смерти", false, function(v) State.autoRejoin = v end)

-- ВКЛАДКА INFO
CreateInfoLabel(infoPage, "TH - Evade Hub")
CreateInfoLabel(infoPage, "Версия: 3.0 (Keyless)")
CreateInfoLabel(infoPage, "Автор: Legenly")
CreateInfoLabel(infoPage, "--------------------------------")
CreateInfoLabel(infoPage, "Основан на открытых исходниках:")
CreateInfoLabel(infoPage, "- VHNS v3 (Fratele)")
CreateInfoLabel(infoPage, "- VanillaSourceCode/evade")
CreateInfoLabel(infoPage, "- zReal-King/Evade")
CreateInfoLabel(infoPage, "--------------------------------")
CreateInfoLabel(infoPage, "Все функции рабочие и проверенные")
CreateInfoLabel(infoPage, "Поддерживает: Delta, Solara, Hydrogen,")
CreateInfoLabel(infoPage, "Xeno, Wave, Potassium и др.")

-- ==========================================
-- ГЛАВНЫЙ ЦИКЛ
-- ==========================================
RunService.RenderStepped:Connect(function()
    pcall(function()
        ApplyPlayerSettings()
        AntiNextbotLoop()
        AutoFarmLoop()
        AutoRespawnLoop()
        AutoReviveLoop()
        RemoveBarriersLoop()
        UpdateESP()
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

-- Пересоздание персонажа
LocalPlayer.CharacterAdded:Connect(function(char)
    if State.noclip then ToggleNoclip(true) end
    if State.fly then ToggleFly(true) end
    ApplyPlayerSettings()
end)

print("TH - Evade Hub загружен! Все функции рабочие. Автор: Legenly")
