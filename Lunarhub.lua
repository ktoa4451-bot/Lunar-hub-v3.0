-- ============================================
-- 🌙 LUNAR HUB v4.0 (ЭПОХАЛЬНОЕ ОБНОВЛЕНИЕ)
-- by Ryzen | ИМБОВОЕ МЕНЮ | СТАБИЛЬНОСТЬ
-- ============================================

-- ============================================
-- 🔄 АВТО-ОБНОВЛЕНИЕ
-- ============================================
local function selfUpdate()
    local currentVersion = "4.0"
    local repoURL = "https://raw.githubusercontent.com/ktoa4451-bot/Lunar-hub-v3.0/main/"
    
    local success, remoteVersion = pcall(function()
        return game:HttpGet(repoURL .. "version.txt")
    end)
    
    if not success then
        warn("⚠️ Не удалось проверить обновления. Загружаю текущую версию.")
        return false
    end
    
    remoteVersion = remoteVersion:gsub("%s+", "")
    
    if remoteVersion ~= currentVersion then
        print("🔄 Найдено обновление! (" .. currentVersion .. " → " .. remoteVersion .. ")")
        print("📥 Загрузка новой версии...")
        local newScript = game:HttpGet(repoURL .. "Lunarhub.lua")
        loadstring(newScript)()
        return true
    end
    
    print("✅ Версия актуальна (" .. currentVersion .. ")")
    return false
end

if selfUpdate() then
    return
end

-- ============================================
-- ⚡ ДОБАВЛЯЙ ИГРЫ СЮДА
-- ============================================
local Games = {
    ["🔫 Шутеры"] = {
        {name = "Arena 1.8", link = "https://raw.githubusercontent.com/Lutosys/1.8arena/refs/heads/main/1.8arena.lua"},
        {name = "Forsaken", link = "https://raw.githubusercontent.com/ScriptDLC/ScriptDLC/refs/heads/main/ForsakenDLCHUB"},
        {name = "Rivals", link = "https://rawscripts.net/raw/RIVALS-Noks-hub-keyless-111339"},
        {name = "MM2", link = "https://raw.githubusercontent.com/pruzgar242-rgb/Update/refs/heads/main/out.lua%20(17).txt"},
        {name = "Prison Life (Keyless)", link = "https://rawscripts.net/raw/Prison-Life-serk4rx-script-239866"},
    },
    ["🌍 Симуляторы"] = {   
        -- Добавляй сюда игры
    },
    ["🌋 Приключения"] = {
        {name = "Rost Alpha (Keyless)", link = "https://pastefy.app/JNOgCLi6/raw?part="},
        {name = "Ink Game", link = "https://rawscripts.net/raw/Universal-Script-RINGTA-best-script-for-ink-game-206674"},
        {name = "Wallhop V4", link = "https://rawscripts.net/raw/Universal-Script-Nova-Wallhop-V4-206099"},
        {name = "Color or Die", link = "https://rawscripts.net/raw/Color-or-Die-Esp-12555"},
    },
    ["🔑 Премиум"] = {
        {name = "Rost Alpha (Premium)", link = "https://api.jnkie.com/api/v1/luascripts/public/e629b8f01eed30630fc3cb93da70708fdac4e57f3fd11fc6dc308c4d7ba6c1bd/download"},
        {name = "Prison Life (Premium)", link = "https://rawscripts.net/raw/Prison-Life-Override-Hub-Silent-Aim-and-More-242218"}
    }
}

-- ============================================
-- 🔧 GUI V4.0 — ИМБОВОЕ МЕНЮ
-- ============================================
local Players = game:GetService("Players")
local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local screen = Instance.new("ScreenGui")
screen.Name = "LunarHubV4"
screen.Parent = PlayerGui
screen.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- ===== ОСНОВНОЙ ФРЕЙМ =====
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 0, 0, 0)
frame.Position = UDim2.new(0.5, -220, 0.5, -300)
frame.BackgroundColor3 = Color3.fromRGB(12, 12, 30)
frame.BackgroundTransparency = 1
frame.BorderSizePixel = 0
frame.ClipsDescendants = true
frame.Active = true
frame.Draggable = true
frame.Parent = screen

-- АНИМАЦИЯ ПОЯВЛЕНИЯ
frame.BackgroundTransparency = 1
TweenService:Create(frame, TweenInfo.new(0.6, Enum.EasingStyle.Back), {Size = UDim2.new(0, 440, 0, 580), BackgroundTransparency = 0.05}):Play()

-- ГРАДИЕНТ ФОНА
local gradient = Instance.new("UIGradient")
gradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(30, 20, 60)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(12, 12, 30))
})
frame.UIGradient = gradient

-- НЕОНОВАЯ РАМКА
local glow = Instance.new("Frame")
glow.Size = UDim2.new(1, 8, 1, 8)
glow.Position = UDim2.new(0, -4, 0, -4)
glow.BackgroundColor3 = Color3.fromRGB(100, 70, 255)
glow.BackgroundTransparency = 0.3
glow.BorderSizePixel = 0
glow.Parent = frame

local glowGradient = Instance.new("UIGradient")
glowGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(200, 50, 255)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(50, 100, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(200, 50, 255))
})
glow.UIGradient = glowGradient

-- ===== ЗАГОЛОВОК =====
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 55)
title.Position = UDim2.new(0, 0, 0, 10)
title.Text = "🌙 LUNAR HUB v4.0"
title.TextColor3 = Color3.fromRGB(255, 215, 0)
title.TextSize = 26
title.Font = Enum.Font.GothamBold
title.BackgroundTransparency = 1
title.TextScaled = true
title.Parent = frame

-- ПОДЗАГОЛОВОК
local totalGames = 0
for _, list in pairs(Games) do
    totalGames = totalGames + #list
end

local sub = Instance.new("TextLabel")
sub.Size = UDim2.new(1, 0, 0, 20)
sub.Position = UDim2.new(0, 0, 0, 60)
sub.Text = "📊 " .. totalGames .. " игр | by Ryzen | v4.0"
sub.TextColor3 = Color3.fromRGB(180, 180, 220)
sub.TextSize = 13
sub.Font = Enum.Font.Gotham
sub.BackgroundTransparency = 1
sub.Parent = frame

-- ===== КНОПКИ УПРАВЛЕНИЯ =====
-- Кнопка закрытия
local close = Instance.new("TextButton")
close.Size = UDim2.new(0, 34, 0, 34)
close.Position = UDim2.new(1, -44, 0, 8)
close.Text = "✕"
close.TextColor3 = Color3.fromRGB(255, 80, 80)
close.TextSize = 22
close.Font = Enum.Font.GothamBold
close.BackgroundTransparency = 1
close.Parent = frame
close.MouseEnter:Connect(function()
    TweenService:Create(close, TweenInfo.new(0.2), {TextColor3 = Color3.fromRGB(255, 30, 30)}):Play()
end)
close.MouseLeave:Connect(function()
    TweenService:Create(close, TweenInfo.new(0.2), {TextColor3 = Color3.fromRGB(255, 80, 80)}):Play()
end)
close.MouseButton1Click:Connect(function()
    TweenService:Create(frame, TweenInfo.new(0.4, Enum.EasingStyle.Back), {Size = UDim2.new(0, 0, 0, 0), BackgroundTransparency = 1}):Play()
    task.wait(0.4)
    screen:Destroy()
end)

-- Кнопка свернуть
local minimize = Instance.new("TextButton")
minimize.Size = UDim2.new(0, 34, 0, 34)
minimize.Position = UDim2.new(1, -84, 0, 8)
minimize.Text = "—"
minimize.TextColor3 = Color3.fromRGB(200, 200, 255)
minimize.TextSize = 24
minimize.Font = Enum.Font.GothamBold
minimize.BackgroundTransparency = 1
minimize.Parent = frame
minimize.MouseEnter:Connect(function()
    TweenService:Create(minimize, TweenInfo.new(0.2), {TextColor3 = Color3.fromRGB(255, 255, 255)}):Play()
end)
minimize.MouseLeave:Connect(function()
    TweenService:Create(minimize, TweenInfo.new(0.2), {TextColor3 = Color3.fromRGB(200, 200, 255)}):Play()
end)
local minimized = false
minimize.MouseButton1Click:Connect(function()
    minimized = not minimized
    if minimized then
        TweenService:Create(frame, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {Size = UDim2.new(0, 440, 0, 60)}):Play()
    else
        TweenService:Create(frame, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {Size = UDim2.new(0, 440, 0, 580)}):Play()
    end
end)

-- ===== ПОИСК =====
local searchBox = Instance.new("TextBox")
searchBox.Size = UDim2.new(1, -20, 0, 35)
searchBox.Position = UDim2.new(0, 10, 0, 85)
searchBox.BackgroundColor3 = Color3.fromRGB(25, 25, 50)
searchBox.BackgroundTransparency = 0.5
searchBox.TextColor3 = Color3.fromRGB(255, 255, 255)
searchBox.PlaceholderText = "🔍 Искать игру..."
searchBox.PlaceholderColor3 = Color3.fromRGB(150, 150, 200)
searchBox.TextSize = 15
searchBox.Font = Enum.Font.Gotham
searchBox.BorderSizePixel = 0
searchBox.ClipsDescendants = true
searchBox.Parent = frame

-- ===== ВКЛАДКИ =====
local tabsFrame = Instance.new("Frame")
tabsFrame.Size = UDim2.new(1, -20, 0, 40)
tabsFrame.Position = UDim2.new(0, 10, 0, 125)
tabsFrame.BackgroundTransparency = 1
tabsFrame.Parent = frame

local tabList = Instance.new("ScrollingFrame")
tabList.Size = UDim2.new(1, 0, 1, 0)
tabList.BackgroundTransparency = 1
tabList.CanvasSize = UDim2.new(2, 0, 0, 0)
tabList.ScrollBarThickness = 3
tabList.HorizontalScrollBarInset = Enum.ScrollBarInset.None
tabList.Parent = tabsFrame

local tabLayout = Instance.new("UIListLayout")
tabLayout.FillDirection = Enum.FillDirection.Horizontal
tabLayout.Padding = UDim.new(0, 6)
tabLayout.Parent = tabList

-- ===== СПИСОК ИГР =====
local list = Instance.new("ScrollingFrame")
list.Size = UDim2.new(1, -20, 1, -210)
list.Position = UDim2.new(0, 10, 0, 170)
list.BackgroundTransparency = 1
list.ScrollBarThickness = 5
list.ScrollBarImageColor3 = Color3.fromRGB(80, 80, 150)
list.Parent = frame

local listLayout = Instance.new("UIListLayout")
listLayout.SortOrder = Enum.SortOrder.Name
listLayout.Padding = UDim.new(0, 6)
listLayout.Parent = list

local currentCategory = nil
local lastSearch = ""

-- ===== ФУНКЦИЯ КНОПКИ ИГРЫ =====
local function createGameButton(data, parent)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 40)
    btn.Text = data.name
    btn.TextColor3 = Color3.fromRGB(220, 220, 245)
    btn.TextSize = 15
    btn.TextXAlignment = Enum.TextXAlignment.Left
    btn.Font = Enum.Font.Gotham
    btn.BackgroundColor3 = Color3.fromRGB(25, 25, 50)
    btn.BackgroundTransparency = 0.2
    btn.BorderSizePixel = 0
    btn.Parent = parent
    
    -- Иконка стрелки
    local arrow = Instance.new("TextLabel")
    arrow.Size = UDim2.new(0, 30, 1, 0)
    arrow.Position = UDim2.new(1, -35, 0, 0)
    arrow.Text = "▶"
    arrow.TextColor3 = Color3.fromRGB(100, 100, 200)
    arrow.TextSize = 18
    arrow.BackgroundTransparency = 1
    arrow.Parent = btn
    
    local padding = Instance.new("UIPadding")
    padding.PaddingLeft = UDim.new(0, 15)
    padding.Parent = btn
    
    btn.MouseEnter:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundTransparency = 0, BackgroundColor3 = Color3.fromRGB(50, 35, 90)}):Play()
        TweenService:Create(arrow, TweenInfo.new(0.2), {TextColor3 = Color3.fromRGB(200, 150, 255)}):Play()
    end)
    btn.MouseLeave:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundTransparency = 0.2, BackgroundColor3 = Color3.fromRGB(25, 25, 50)}):Play()
        TweenService:Create(arrow, TweenInfo.new(0.2), {TextColor3 = Color3.fromRGB(100, 100, 200)}):Play()
    end)
    
    btn.MouseButton1Click:Connect(function()
        btn.Text = "⏳ Загрузка..."
        btn.BackgroundColor3 = Color3.fromRGB(70, 50, 30)
        task.wait(0.2)
        
        local success, err = pcall(function()
            loadstring(game:HttpGet(data.link))()
        end)
        
        if success then
            btn.Text = "✅ " .. data.name
            btn.BackgroundColor3 = Color3.fromRGB(30, 70, 30)
        else
            btn.Text = "❌ Ошибка!"
            btn.BackgroundColor3 = Color3.fromRGB(70, 30, 30)
            warn("Lunar Hub Error: " .. tostring(err))
        end
        
        task.wait(1.2)
        btn.Text = data.name
        btn.BackgroundColor3 = Color3.fromRGB(25, 25, 50)
    end)
end

-- ===== ОБНОВЛЕНИЕ СПИСКА =====
local function updateList(category, search)
    for _, child in ipairs(list:GetChildren()) do
        if child:IsA("TextButton") then child:Destroy() end
    end
    
    local gamesToShow = {}
    
    if category and Games[category] then
        for _, game in ipairs(Games[category]) do
            table.insert(gamesToShow, game)
        end
    else
        for _, gameList in pairs(Games) do
            for _, game in ipairs(gameList) do
                table.insert(gamesToShow, game)
            end
        end
    end
    
    if search and search ~= "" then
        local filtered = {}
        local lower = string.lower(search)
        for _, game in ipairs(gamesToShow) do
            if string.find(string.lower(game.name), lower, 1, true) then
                table.insert(filtered, game)
            end
        end
        gamesToShow = filtered
    end
    
    table.sort(gamesToShow, function(a, b)
        return a.name < b.name
    end)
    
    for _, game in ipairs(gamesToShow) do
        createGameButton(game, list)
    end
    
    list.CanvasSize = UDim2.new(0, 0, 0, #gamesToShow * 46 + 10)
end

-- ===== СОЗДАНИЕ ВКЛАДОК =====
local function createTabs()
    for cat, _ in pairs(Games) do
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(0, 130, 1, 0)
        btn.Text = cat
        btn.TextColor3 = Color3.fromRGB(200, 200, 230)
        btn.TextSize = 13
        btn.Font = Enum.Font.Gotham
        btn.BackgroundColor3 = Color3.fromRGB(25, 25, 45)
        btn.BackgroundTransparency = 0.3
        btn.BorderSizePixel = 0
        btn.Parent = tabList
        
        btn.MouseEnter:Connect(function()
            TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundTransparency = 0, BackgroundColor3 = Color3.fromRGB(50, 35, 90)}):Play()
        end)
        btn.MouseLeave:Connect(function()
            if currentCategory ~= cat then
                TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundTransparency = 0.3, BackgroundColor3 = Color3.fromRGB(25, 25, 45)}):Play()
            end
        end)
        
        btn.MouseButton1Click:Connect(function()
            currentCategory = cat
            for _, child in ipairs(tabList:GetChildren()) do
                if child:IsA("TextButton") then
                    if child == btn then
                        child.BackgroundTransparency = 0
                        child.BackgroundColor3 = Color3.fromRGB(80, 50, 140)
                    else
                        child.BackgroundTransparency = 0.3
                        child.BackgroundColor3 = Color3.fromRGB(25, 25, 45)
                    end
                end
            end
            updateList(currentCategory, lastSearch)
        end)
    end
    
    local first = next(Games)
    if first then
        currentCategory = first
        for _, child in ipairs(tabList:GetChildren()) do
            if child:IsA("TextButton") and child.Text == first then
                child.BackgroundTransparency = 0
                child.BackgroundColor3 = Color3.fromRGB(80, 50, 140)
                break
            end
        end
    end
end

-- ===== ПОИСК =====
searchBox:GetPropertyChangedSignal("Text"):Connect(function()
    lastSearch = searchBox.Text
    updateList(currentCategory, lastSearch)
end)

-- ===== ЗАПУСК =====
createTabs()
updateList(currentCategory, "")

print("✅ Lunar Hub v4.0 загружен! (" .. totalGames .. " игр)")
print("🌙 Эпохальное обновление активировано!")
