--[[
    Dropkick-like Script (без ключа)
    Функция: флинг игроков с анимациями
]]

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local LocalPlayer = Players.LocalPlayer

-- ==========================================
-- НАСТРОЙКИ (можно менять)
-- ==========================================
local FLING_POWER = 200          -- базовая сила
local UPWARD_BOOST = 50          -- подъём вверх
local AUTO_FLING_DISTANCE = 10   -- дистанция для авто-флинга
local AUTO_FLING_ENABLED = false -- включить авто-флинг по умолчанию

-- ==========================================
-- СОЗДАНИЕ GUI
-- ==========================================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "DropKickGUI"
ScreenGui.ResetOnSpawn = false
pcall(function() ScreenGui.Parent = CoreGui end)

-- Главное окно (тёмное, как в dropkick)
local MainFrame = Instance.new("Frame")
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.5, -120, 0.5, -150)
MainFrame.Size = UDim2.new(0, 240, 0, 300)
MainFrame.ClipsDescendants = true
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 8)

-- Размытый фон (имитация blur)
local Blur = Instance.new("Frame", MainFrame)
Blur.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Blur.BackgroundTransparency = 0.2
Blur.Size = UDim2.new(1, 0, 1, 0)
Blur.Position = UDim2.new(0, 0, 0, 0)
Blur.BorderSizePixel = 0

-- Заголовок
local Title = Instance.new("TextLabel")
Title.Parent = MainFrame
Title.BackgroundTransparency = 1
Title.Size = UDim2.new(1, 0, 0, 30)
Title.Position = UDim2.new(0, 0, 0, 5)
Title.Font = Enum.Font.GothamBold
Title.Text = "⬡ DROP KICK"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 16
Title.TextXAlignment = Enum.TextXAlignment.Center

-- Список игроков (с прокруткой)
local PlayerList = Instance.new("ScrollingFrame")
PlayerList.Parent = MainFrame
PlayerList.BackgroundTransparency = 1
PlayerList.Size = UDim2.new(1, -20, 0, 180)
PlayerList.Position = UDim2.new(0, 10, 0, 40)
PlayerList.CanvasSize = UDim2.new(0, 0, 0, 0)
PlayerList.ScrollBarThickness = 4

local PlayerListLayout = Instance.new("UIListLayout")
PlayerListLayout.Parent = PlayerList
PlayerListLayout.SortOrder = Enum.SortOrder.LayoutOrder
PlayerListLayout.Padding = UDim.new(0, 5)

-- Контейнер для элементов игроков
local PlayerButtons = {}
local function RefreshPlayerList()
    -- Очищаем старые кнопки
    for _, btn in ipairs(PlayerButtons) do
        btn:Destroy()
    end
    PlayerButtons = {}

    -- Создаём кнопки для всех игроков (кроме себя)
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            local btn = Instance.new("TextButton")
            btn.Parent = PlayerList
            btn.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
            btn.Size = UDim2.new(1, 0, 0, 30)
            btn.Font = Enum.Font.GothamSemibold
            btn.Text = player.Name
            btn.TextColor3 = Color3.fromRGB(255, 255, 255)
            btn.TextSize = 13
            Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 4)
            
            -- Сохраняем ссылку на игрока
            btn.MouseButton1Click:Connect(function()
                FlingPlayer(player)
            end)
            
            table.insert(PlayerButtons, btn)
        end
    end
    
    -- Обновляем CanvasSize
    PlayerList.CanvasSize = UDim2.new(0, 0, 0, PlayerListLayout.AbsoluteContentSize.Y)
end

-- Слайдер силы
local PowerSlider = Instance.new("Frame")
PowerSlider.Parent = MainFrame
PowerSlider.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
PowerSlider.Position = UDim2.new(0, 10, 0, 230)
PowerSlider.Size = UDim2.new(1, -20, 0, 40)
Instance.new("UICorner", PowerSlider).CornerRadius = UDim.new(0, 4)

local PowerLabel = Instance.new("TextLabel")
PowerLabel.Parent = PowerSlider
PowerLabel.BackgroundTransparency = 1
PowerLabel.Size = UDim2.new(1, 0, 0, 20)
PowerLabel.Position = UDim2.new(0, 0, 0, 0)
PowerLabel.Font = Enum.Font.Gotham
PowerLabel.Text = "Сила: " .. FLING_POWER
PowerLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
PowerLabel.TextSize = 12
PowerLabel.TextXAlignment = Enum.TextXAlignment.Left

local PowerBar = Instance.new("TextButton")
PowerBar.Parent = PowerSlider
PowerBar.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
PowerBar.Position = UDim2.new(0, 0, 0, 22)
PowerBar.Size = UDim2.new(1, 0, 0, 10)
PowerBar.Text = ""
PowerBar.AutoButtonColor = false
Instance.new("UICorner", PowerBar).CornerRadius = UDim.new(1, 0)

local PowerFill = Instance.new("Frame")
PowerFill.Parent = PowerBar
PowerFill.BackgroundColor3 = Color3.fromRGB(255, 200, 50)
PowerFill.Size = UDim2.new(FLING_POWER / 300, 0, 1, 0) -- max 300
Instance.new("UICorner", PowerFill).CornerRadius = UDim.new(1, 0)

local isDragging = false
PowerBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        isDragging = true
        updatePower(input)
    end
end)
UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        isDragging = false
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if isDragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        updatePower(input)
    end
end)

local function updatePower(input)
    local pos = math.clamp(input.Position.X - PowerBar.AbsolutePosition.X, 0, PowerBar.AbsoluteSize.X)
    local percent = pos / PowerBar.AbsoluteSize.X
    PowerFill.Size = UDim2.new(percent, 0, 1, 0)
    FLING_POWER = math.floor(percent * 300)
    PowerLabel.Text = "Сила: " .. FLING_POWER
end

-- Переключатель авто-флинга
local AutoToggle = Instance.new("TextButton")
AutoToggle.Parent = MainFrame
AutoToggle.BackgroundColor3 = AUTO_FLING_ENABLED and Color3.fromRGB(50, 200, 50) or Color3.fromRGB(40, 40, 40)
AutoToggle.Size = UDim2.new(0, 100, 0, 25)
AutoToggle.Position = UDim2.new(0.5, -50, 0, 275)
AutoToggle.Font = Enum.Font.GothamSemibold
AutoToggle.Text = "Авто: " .. (AUTO_FLING_ENABLED and "Вкл" or "Выкл")
AutoToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
AutoToggle.TextSize = 12
Instance.new("UICorner", AutoToggle).CornerRadius = UDim.new(0, 4)

AutoToggle.MouseButton1Click:Connect(function()
    AUTO_FLING_ENABLED = not AUTO_FLING_ENABLED
    AutoToggle.BackgroundColor3 = AUTO_FLING_ENABLED and Color3.fromRGB(50, 200, 50) or Color3.fromRGB(40, 40, 40)
    AutoToggle.Text = "Авто: " .. (AUTO_FLING_ENABLED and "Вкл" or "Выкл")
end)

-- ==========================================
-- ЯДРО ФУНКЦИИ ФЛИНГА + АНИМАЦИЯ
-- ==========================================
local function FlingPlayer(target)
    local targetChar = target.Character
    local targetHRP = targetChar and targetChar:FindFirstChild("HumanoidRootPart")
    local myChar = LocalPlayer.Character
    local myHRP = myChar and myChar:FindFirstChild("HumanoidRootPart")
    
    if not targetHRP or not myHRP then return end

    -- Анимация: ударяем (можно заменить на любую анимацию)
    local hum = myChar:FindFirstChild("Humanoid")
    if hum then
        -- Проигрываем анимацию "RightHand" (можно заменить ID)
        local animId = "rbxassetid://251025878" -- стандартный удар
        local anim = Instance.new("Animation")
        anim.AnimationId = animId
        local track = hum:LoadAnimation(anim)
        track:Play()
        
        -- Ждём немного, чтобы анимация успела начаться
        task.wait(0.1)
    end

    -- Вычисляем направление
    local direction = (targetHRP.Position - myHRP.Position).Unit
    local power = FLING_POWER

    -- Создаём BodyVelocity для флинга
    local bv = Instance.new("BodyVelocity")
    bv.MaxForce = Vector3.new(1e9, 1e9, 1e9)
    bv.Velocity = direction * power + Vector3.new(0, UPWARD_BOOST, 0)
    bv.Parent = targetHRP

    -- Через 1.5 секунды удаляем
    task.wait(1.5)
    bv:Destroy()

    -- Показываем эффект (опционально)
    local particle = Instance.new("ParticleEmitter")
    particle.Parent = targetHRP
    particle.Texture = "rbxassetid://130541160" -- искры
    particle.Rate = 20
    particle.Lifetime = NumberRange.new(0.5, 1)
    particle.Size = NumberSequence.new(2)
    particle.Speed = NumberRange.new(1, 5)
    task.wait(0.5)
    particle:Destroy()
end

-- ==========================================
-- АВТО-ФЛИНГ ПРИ КАСАНИИ
-- ==========================================
RunService.Heartbeat:Connect(function()
    if not AUTO_FLING_ENABLED then return end
    local myChar = LocalPlayer.Character
    if not myChar then return end
    local myHRP = myChar:FindFirstChild("HumanoidRootPart")
    if not myHRP then return end

    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            local char = player.Character
            if char then
                local hrp = char:FindFirstChild("HumanoidRootPart")
                if hrp then
                    local dist = (myHRP.Position - hrp.Position).Magnitude
                    if dist < AUTO_FLING_DISTANCE then
                        FlingPlayer(player)
                        task.wait(0.5) -- защита от спама
                    end
                end
            end
        end
    end
end)

-- ==========================================
-- ОБНОВЛЕНИЕ СПИСКА ИГРОКОВ
-- ==========================================
Players.PlayerAdded:Connect(RefreshPlayerList)
Players.PlayerRemoving:Connect(RefreshPlayerList)
RefreshPlayerList()

-- ==========================================
-- ПЕРЕТАСКИВАНИЕ ОКНА
-- ==========================================
local function MakeDraggable(frame)
    local dragging = false
    local dragStart, startPos
    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStart
            frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
end
MakeDraggable(MainFrame)

print("✅ DropKick скрипт загружен! Нажми на игрока чтобы флингнуть.")
