-- ============================================
-- 🌙 LUNAR HUB v7.0 (МЕГА-АПГРЕЙД)
-- by Ryzen | ДИЗАЙН | ФИЧИ | СТИЛЬ
-- ============================================

-- ============================================
-- 🔄 АВТО-ОБНОВЛЕНИЕ
-- ============================================
local function selfUpdate()
    local currentVersion = "7.0"
    local repoURL = "https://raw.githubusercontent.com/ktoa4451-bot/Lunar-hub/main/"
    
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
-- ⚡ ИГРЫ С ИКОНКАМИ И КАТЕГОРИЯМИ
-- ============================================
local Games = {
    ["🔫 Шутеры"] = {
        {name = "🔫 Forsaken", link = "https://raw.githubusercontent.com/ScriptDLC/ScriptDLC/refs/heads/main/ForsakenDLCHUB"},
        {name = "🔫 MM2", link = "https://raw.githubusercontent.com/pruzgar242-rgb/Update/refs/heads/main/out.lua%20(17).txt"},
        {name = "🔫 Rivals", link = "https://rawscripts.net/raw/RIVALS-Noks-hub-keyless-111339"},
        {name = "🔫 Arsenal", link = "https://raw.githubusercontent.com/7GrandDadPNG/7GrandDadPNG/refs/heads/main/Arsenal.lua"},
        {name = "🔫 Slap Battles", link = "https://raw.githubusercontent.com/Articles-Hub/ROBLOXScript/refs/heads/main/File-Script/Slap_Battles.lua"},
    },
    ["🎮 Симуляторы"] = {
        {name = "🎮 Pet Simulator X", link = "https://raw.githubusercontent.com/ZaRdoOx/Ultra-Hub/main/Main"},
        {name = "🎮 Blox Fruits", link = "https://raw.githubusercontent.com/7GrandDadPNG/7GrandDadPNG/refs/heads/main/BloxFruits.lua"},
        {name = "🎮 King Legacy", link = "https://pastefy.app/3xQp8vL9/raw"},
        {name = "🎮 Tower of Hell", link = "https://raw.githubusercontent.com/iiProductionz/Floater-Scripts/main/WaifuEdition/Tower%20Of%20Hell"},
        {name = "🎮 1+ Speed Keyboard", link = "https://raw.githubusercontent.com/Gerreiro68/ShizaHub/refs/heads/main/loader.lua"},
        {name = "🎮 Merge Nuke", link = "https://raw.githubusercontent.com/gumanba/Scripts/main/MergeaNuke"},
        {name = "🎮 MorphUp", link = "https://raw.githubusercontent.com/gumanba/Scripts/main/MorphUp"},
        {name = "🎮 1 Magic Evolution", link = "https://raw.githubusercontent.com/gumanba/Scripts/main/1MagicEvolution"},
    },
    ["👻 Хорроры"] = {
        {name = "👻 Doors", link = "https://raw.githubusercontent.com/bocaj111004/Abysall/refs/heads/main/Loader.luau"},
        {name = "👻 Color or Die", link = "https://rawscripts.net/raw/Color-or-Die-Esp-12555"},
        {name = "👻 99 Nights in Forest", link = "https://raw.githubusercontent.com/caomod2077/Script/refs/heads/main/FoxnameHub.lua"},
        {name = "👻 Survive Zombie Arena", link = "https://raw.githubusercontent.com/caomod2077/Script/main/Foxname_SZA.lua"},
    },
    ["💰 Премиум"] = {
        {name = "💰 Rost Alpha Premium", link = "https://api.jnkie.com/api/v1/luascripts/public/e629b8f01eed30630fc3cb93da70708fdac4e57f3fd11fc6dc308c4d7ba6c1bd/download"},
        {name = "💰 Prison Life Premium", link = "https://rawscripts.net/raw/Prison-Life-Override-Hub-Silent-Aim-and-More-242218"},
        {name = "💰 CodeCoat", link = "https://raw.githubusercontent.com/Breadido/Codecoat/refs/heads/main/looder.luau"},
    }
}

-- ============================================
-- ⚙️ НАСТРОЙКИ
-- ============================================
local Favorites = {}
local OnlineUsers = 0

-- ============================================
-- 🔧 ГЛАВНЫЙ GUI
-- ============================================
local Players = game:GetService("Players")
local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui")
local TweenService = game:GetService("TweenService")

local screen = Instance.new("ScreenGui")
screen.Name = "LunarHub"
screen.Parent = PlayerGui
screen.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- ============================================
-- 🎨 ГРАДИЕНТНЫЙ ФОН
-- ============================================
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 600, 0, 460)
frame.Position = UDim2.new(0.5, -300, 0.5, -230)
frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
frame.BackgroundTransparency = 0
frame.BorderSizePixel = 0
frame.ClipsDescendants = true
frame.Active = true
frame.Draggable = true
frame.Parent = screen

-- ГРАДИЕНТ
local gradient = Instance.new("UIGradient")
gradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(15, 15, 45)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(30, 10, 60)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(10, 5, 30))
})
frame.UIGradient = gradient

-- СКРУГЛЁННЫЕ УГЛЫ
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12)
corner.Parent = frame

-- ТЕНЬ И СВЕЧЕНИЕ
local shadow = Instance.new("ImageLabel")
shadow.Size = UDim2.new(1, 20, 1, 20)
shadow.Position = UDim2.new(0, -10, 0, -10)
shadow.BackgroundTransparency = 1
shadow.Image = "rbxassetid://13188751145"
shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
shadow.ImageTransparency = 0.3
shadow.Parent = frame

local glow = Instance.new("Frame")
glow.Size = UDim2.new(1, 4, 1, 4)
glow.Position = UDim2.new(0, -2, 0, -2)
glow.BackgroundColor3 = Color3.fromRGB(100, 50, 200)
glow.BackgroundTransparency = 0.3
glow.BorderSizePixel = 0
glow.Parent = frame

local glowCorner = Instance.new("UICorner")
glowCorner.CornerRadius = UDim.new(0, 14)
glowCorner.Parent = glow

local glowGradient = Instance.new("UIGradient")
glowGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(150, 50, 255)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(50, 100, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(150, 50, 255))
})
glow.UIGradient = glowGradient

-- ============================================
-- 📊 ПАНЕЛЬ СТАТИСТИКИ
-- ============================================
local statsFrame = Instance.new("Frame")
statsFrame.Size = UDim2.new(0, 560, 0, 30)
statsFrame.Position = UDim2.new(0, 20, 0, 10)
statsFrame.BackgroundTransparency = 1
statsFrame.Parent = frame

local onlineLabel = Instance.new("TextLabel")
onlineLabel.Size = UDim2.new(0, 200, 1, 0)
onlineLabel.Text = "🟢 Online: 0"
onlineLabel.TextColor3 = Color3.fromRGB(0, 255, 100)
onlineLabel.TextSize = 14
onlineLabel.Font = Enum.Font.GothamBold
onlineLabel.BackgroundTransparency = 1
onlineLabel.TextXAlignment = Enum.TextXAlignment.Left
onlineLabel.Parent = statsFrame

local favLabel = Instance.new("TextLabel")
favLabel.Size = UDim2.new(0, 200, 1, 0)
favLabel.Position = UDim2.new(0, 200, 0, 0)
favLabel.Text = "⭐ Избранное: 0"
favLabel.TextColor3 = Color3.fromRGB(255, 215, 0)
favLabel.TextSize = 14
favLabel.Font = Enum.Font.GothamBold
favLabel.BackgroundTransparency = 1
favLabel.TextXAlignment = Enum.TextXAlignment.Left
favLabel.Parent = statsFrame

local gameCountLabel = Instance.new("TextLabel")
gameCountLabel.Size = UDim2.new(0, 200, 1, 0)
gameCountLabel.Position = UDim2.new(0, 400, 0, 0)
gameCountLabel.Text = "🎮 Игр: 0"
gameCountLabel.TextColor3 = Color3.fromRGB(100, 200, 255)
gameCountLabel.TextSize = 14
gameCountLabel.Font = Enum.Font.GothamBold
gameCountLabel.BackgroundTransparency = 1
gameCountLabel.TextXAlignment = Enum.TextXAlignment.Left
gameCountLabel.Parent = statsFrame

-- ============================================
-- 🌙 ПРИВЕТСТВЕННЫЙ ЭКРАН
-- ============================================
local splash = Instance.new("Frame")
splash.Size = UDim2.new(1, 0, 1, 0)
splash.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
splash.BackgroundTransparency = 0
splash.BorderSizePixel = 0
splash.Parent = frame

local splashCorner = Instance.new("UICorner")
splashCorner.CornerRadius = UDim.new(0, 12)
splashCorner.Parent = splash

local splashTitle = Instance.new("TextLabel")
splashTitle.Size = UDim2.new(1, 0, 1, 0)
splashTitle.Text = "🌙 LUNAR HUB\nЗагрузка..."
splashTitle.TextColor3 = Color3.fromRGB(255, 215, 0)
splashTitle.TextScaled = true
splashTitle.Font = Enum.Font.GothamBold
splashTitle.BackgroundTransparency = 1
splashTitle.Parent = splash

task.wait(1.5)
TweenService:Create(splash, TweenInfo.new(0.5, Enum.EasingStyle.Quad), {BackgroundTransparency = 1}):Play()
task.wait(0.5)
splash:Destroy()

-- ============================================
-- 📋 ВКЛАДКИ
-- ============================================
local tabs = Instance.new("Frame")
tabs.Size = UDim2.new(0, 560, 0, 36)
tabs.Position = UDim2.new(0, 20, 0, 45)
tabs.BackgroundTransparency = 1
tabs.Parent = frame

local tabLayout = Instance.new("UIListLayout")
tabLayout.FillDirection = Enum.FillDirection.Horizontal
tabLayout.Padding = UDim.new(0, 6)
tabLayout.Parent = tabs

local currentTab = "🔫 Шутеры"
local tabButtons = {}

for cat, _ in pairs(Games) do
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 100, 1, 0)
    btn.Text = cat
    btn.TextColor3 = Color3.fromRGB(200, 200, 255)
    btn.TextSize = 13
    btn.Font = Enum.Font.GothamBold
    btn.BackgroundColor3 = Color3.fromRGB(30, 30, 60)
    btn.BackgroundTransparency = 0.3
    btn.BorderSizePixel = 0
    btn.Parent = tabs
    btn.Name = cat
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 6)
    btnCorner.Parent = btn
    
    btn.MouseButton1Click:Connect(function()
        currentTab = cat
        for _, b in ipairs(tabs:GetChildren()) do
            if b:IsA("TextButton") then
                b.BackgroundTransparency = 0.3
            end
        end
        btn.BackgroundTransparency = 0
        updateContent(cat)
    end)
    tabButtons[cat] = btn
end

-- ============================================
-- 📋 ОБНОВЛЕНИЯ
-- ============================================
local updateFrame = Instance.new("Frame")
updateFrame.Size = UDim2.new(0, 560, 0, 30)
updateFrame.Position = UDim2.new(0, 20, 0, 85)
updateFrame.BackgroundTransparency = 1
updateFrame.Parent = frame

local updateLabel = Instance.new("TextLabel")
updateLabel.Size = UDim2.new(1, 0, 1, 0)
updateLabel.Text = "📢 Обновление: v7.0 — Добавлены категории, градиент, избранное!"
updateLabel.TextColor3 = Color3.fromRGB(255, 200, 100)
updateLabel.TextSize = 13
updateLabel.Font = Enum.Font.Gotham
updateLabel.BackgroundTransparency = 1
updateLabel.Parent = updateFrame

-- ============================================
-- 📋 КОНТЕНТ
-- ============================================
local contentFrame = Instance.new("ScrollingFrame")
contentFrame.Size = UDim2.new(0, 560, 0, 300)
contentFrame.Position = UDim2.new(0, 20, 0, 120)
contentFrame.BackgroundTransparency = 1
contentFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
contentFrame.ScrollBarThickness = 6
contentFrame.ScrollBarImageColor3 = Color3.fromRGB(100, 50, 200)
contentFrame.Parent = frame

local contentLayout = Instance.new("UIListLayout")
contentLayout.SortOrder = Enum.SortOrder.Name
contentLayout.Padding = UDim.new(0, 6)
contentLayout.Parent = contentFrame

-- КРАСИВЫЙ СКРОЛЛ
contentFrame.ScrollBarImageColor3 = Color3.fromRGB(150, 50, 255)

-- ============================================
-- ⭐ ИЗБРАННОЕ
-- ============================================
local function toggleFavorite(gameName)
    if Favorites[gameName] then
        Favorites[gameName] = nil
    else
        Favorites[gameName] = true
    end
    updateStats()
    updateContent(currentTab)
end

local function updateStats()
    local favCount = 0
    for _ in pairs(Favorites) do
        favCount = favCount + 1
    end
    favLabel.Text = "⭐ Избранное: " .. favCount
    OnlineUsers = math.random(10, 50)
    onlineLabel.Text = "🟢 Online: " .. OnlineUsers
    local totalGames = 0
    for _, list in pairs(Games) do
        totalGames = totalGames + #list
    end
    gameCountLabel.Text = "🎮 Игр: " .. totalGames
end

-- ============================================
-- 🎨 КНОПКИ ИГР
-- ============================================
local function createGameButton(gameData)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 38)
    btn.Text = gameData.name
    btn.TextColor3 = Color3.fromRGB(230, 230, 255)
    btn.TextSize = 14
    btn.TextXAlignment = Enum.TextXAlignment.Left
    btn.Font = Enum.Font.GothamBold
    btn.BackgroundColor3 = Color3.fromRGB(20, 20, 50)
    btn.BackgroundTransparency = 0.2
    btn.BorderSizePixel = 0
    btn.Parent = contentFrame
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 8)
    btnCorner.Parent = btn
    
    local padding = Instance.new("UIPadding")
    padding.PaddingLeft = UDim.new(0, 15)
    padding.Parent = btn
    
    local arrow = Instance.new("TextLabel")
    arrow.Size = UDim2.new(0, 30, 1, 0)
    arrow.Position = UDim2.new(1, -40, 0, 0)
    arrow.Text = "▶"
    arrow.TextColor3 = Color3.fromRGB(150, 100, 200)
    arrow.TextSize = 18
    arrow.BackgroundTransparency = 1
    arrow.Parent = btn
    
    -- КНОПКА ИЗБРАННОГО
    local favBtn = Instance.new("TextButton")
    favBtn.Size = UDim2.new(0, 30, 1, 0)
    favBtn.Position = UDim2.new(1, -75, 0, 0)
    favBtn.Text = Favorites[gameData.name] and "⭐" or "☆"
    favBtn.TextColor3 = Color3.fromRGB(255, 215, 0)
    favBtn.TextSize = 18
    favBtn.BackgroundTransparency = 1
    favBtn.Parent = btn
    
    favBtn.MouseButton1Click:Connect(function()
        toggleFavorite(gameData.name)
        favBtn.Text = Favorites[gameData.name] and "⭐" or "☆"
    end)
    
    btn.MouseEnter:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.15), {BackgroundTransparency = 0, BackgroundColor3 = Color3.fromRGB(40, 30, 80)}):Play()
        TweenService:Create(arrow, TweenInfo.new(0.15), {TextColor3 = Color3.fromRGB(255, 215, 0)}):Play()
    end)
    btn.MouseLeave:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.15), {BackgroundTransparency = 0.2, BackgroundColor3 = Color3.fromRGB(20, 20, 50)}):Play()
        TweenService:Create(arrow, TweenInfo.new(0.15), {TextColor3 = Color3.fromRGB(150, 100, 200)}):Play()
    end)
    
    btn.MouseButton1Click:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.1, Enum.EasingStyle.Back), {Size = UDim2.new(1, 0, 0, 36)}):Play()
        task.wait(0.1)
        TweenService:Create(btn, TweenInfo.new(0.1, Enum.EasingStyle.Back), {Size = UDim2.new(1, 0, 0, 38)}):Play()
        
        btn.Text = "⏳..."
        btn.BackgroundColor3 = Color3.fromRGB(50, 50, 30)
        arrow.Text = "⏳"
        task.wait(0.15)
        
        local success, msg = loadScript(gameData.link)
        
        if success then
            btn.Text = "✅ " .. gameData.name
            btn.BackgroundColor3 = Color3.fromRGB(30, 50, 30)
            arrow.Text = "✅"
        else
            btn.Text = "❌ " .. gameData.name
            btn.BackgroundColor3 = Color3.fromRGB(50, 30, 30)
            arrow.Text = "❌"
            warn("Error: " .. msg)
        end
        
        task.wait(1.5)
        btn.Text = gameData.name
        btn.BackgroundColor3 = Color3.fromRGB(20, 20, 50)
        arrow.Text = "▶"
    end)
end

-- ============================================
-- 🔧 ОБНОВЛЕНИЕ КОНТЕНТА
-- ============================================
local function updateContent(category)
    for _, child in ipairs(contentFrame:GetChildren()) do
        if child:IsA("TextButton") then child:Destroy() end
    end
    
    local gamesToShow = {}
    local searchText = searchBox.Text:lower()
    
    if category == "⭐ Избранное" then
        for _, catList in pairs(Games) do
            for _, game in ipairs(catList) do
                if Favorites[game.name] then
                    table.insert(gamesToShow, game)
                end
            end
        end
    elseif Games[category] then
        for _, game in ipairs(Games[category]) do
            table.insert(gamesToShow, game)
        end
    else
        for _, catList in pairs(Games) do
            for _, game in ipairs(catList) do
                table.insert(gamesToShow, game)
            end
        end
    end
    
    if searchText ~= "" then
        local filtered = {}
        for _, game in ipairs(gamesToShow) do
            if string.find(string.lower(game.name), searchText) then
                table.insert(filtered, game)
            end
        end
        gamesToShow = filtered
    end
    
    table.sort(gamesToShow, function(a, b) return a.name < b.name end)
    
    for _, game in ipairs(gamesToShow) do
        createGameButton(game)
    end
    
    contentFrame.CanvasSize = UDim2.new(0, 0, 0, #gamesToShow * 44 + 10)
    updateStats()
end

-- ============================================
-- 🔧 ПОИСК
-- ============================================
local searchBox = Instance.new("TextBox")
searchBox.Size = UDim2.new(0, 560, 0, 28)
searchBox.Position = UDim2.new(0, 20, 0, 85)
searchBox.BackgroundColor3 = Color3.fromRGB(30, 30, 60)
searchBox.BackgroundTransparency = 0.5
searchBox.TextColor3 = Color3.fromRGB(255, 255, 255)
searchBox.PlaceholderText = "🔍 Search game..."
searchBox.PlaceholderColor3 = Color3.fromRGB(140, 140, 180)
searchBox.TextSize = 13
searchBox.Font = Enum.Font.Gotham
searchBox.BorderSizePixel = 0
searchBox.ClipsDescendants = true
searchBox.Parent = frame

searchBox:GetPropertyChangedSignal("Text"):Connect(function()
    updateContent(currentTab)
end)

-- ============================================
-- 🔧 ЗАКРЫТИЕ
-- ============================================
local close = Instance.new("TextButton")
close.Size = UDim2.new(0, 30, 0, 30)
close.Position = UDim2.new(1, -10, 0, 10)
close.Text = "✕"
close.TextColor3 = Color3.fromRGB(255, 100, 100)
close.TextSize = 18
close.Font = Enum.Font.GothamBold
close.BackgroundTransparency = 1
close.Parent = frame

close.MouseEnter:Connect(function()
    close.TextColor3 = Color3.fromRGB(255, 50, 50)
end)
close.MouseLeave:Connect(function()
    close.TextColor3 = Color3.fromRGB(255, 100, 100)
end)

close.MouseButton1Click:Connect(function()
    screen:Destroy()
end)

-- ============================================
-- 🚀 ЗАПУСК
-- ============================================
updateContent("🔫 Шутеры")
updateStats()

print("✅ Lunar Hub v7.0 loaded! (" .. #Games .. " categories)")
print("🌙 Мега-апгрейд активирован!")
