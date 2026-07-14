-- ============================================
-- 🌙 LUNAR HUB v3.1 (С АВТО-ОБНОВЛЕНИЕМ)
-- by Ryzen | Одна ссылка — вечные обновления
-- ============================================

-- ============================================
-- 🔄 АВТО-ОБНОВЛЕНИЕ
-- ============================================
local function selfUpdate()
    local currentVersion = "3.1"  -- ← МЕНЯЙ ЭТУ ЦИФРУ ПРИ КАЖДОМ ОБНОВЛЕНИИ
    local repoURL = "https://raw.githubusercontent.com/ktoa4451-bot/Lunar-hub-v3.0-release/main/"
    
    local success, remoteVersion = pcall(function()
        return game:HttpGet(repoURL .. "version.txt")
    end)
    
    if not success then
        print("⚠️ Не удалось проверить обновления. Загружаю текущую версию.")
        return false
    end
    
    remoteVersion = remoteVersion:gsub("%s+", "") -- убираем пробелы и переносы
    
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

-- Если есть обновление — запускаем новую версию и выходим
if selfUpdate() then
    return
end

-- ============================================
-- ⚡ ДОБАВЛЯЙ ИГРЫ СЮДА ⚡
-- ============================================
local Games = {
    ["🔫 Шутеры"] = {
        {name = "Arena 1.8", link = "https://raw.githubusercontent.com/Lutosys/1.8arena/refs/heads/main/1.8arena.lua"},
        {name = "Forsaken", link = "https://raw.githubusercontent.com/ScriptDLC/ScriptDLC/refs/heads/main/ForsakenDLCHUB"},
        {name = "Rivals", link = "https://rawscripts.net/raw/RIVALS-Noks-hub-keyless-111339"},
        {name = "MM2", link = "https://raw.githubusercontent.com/pruzgar242-rgb/Update/refs/heads/main/out.lua%20(17).txt"},
        {name = "Prison Life", link = "https://raw.githubusercontent.com/tbao143/thaibao/main/TbaohubPrisonLife"},
    },
    ["🌍 Симуляторы"] = {
        {name = "Blox Fruits", link = "https://raw.githubusercontent.com/7GrandDadPNG/7GrandDadPNG/refs/heads/main/BloxFruits.lua"},
        {name = "Pet Simulator X", link = "https://raw.githubusercontent.com/ZaRdoOx/Ultra-Hub/main/Main"},
        {name = "Tower of Hell", link = "https://raw.githubusercontent.com/iiProductionz/Floater-Scripts/main/WaifuEdition/Tower%20Of%20Hell"},   
    },
    ["🌋 Приключения"] = {
        {name = "Rost Alpha (Keyless)", link = "https://pastefy.app/JNOgCLi6/raw?part="},
        {name = "Ink Game", link = "https://rawscripts.net/raw/Universal-Script-RINGTA-best-script-for-ink-game-206674"},
        {name = "Wallhop V4", link = "https://rawscripts.net/raw/Universal-Script-Nova-Wallhop-V4-206099"},
        {name = "Doors", link = "https://raw.githubusercontent.com/RegularVynixus/Vynixius/main/Doors/Script.lua"},
        {name = "Color or Die", link = "https://scriptblox.com/api/script/150402/source"},
    },
    ["🔑 Премиум"] = {
        {name = "Rost Alpha (Premium)", link = "https://api.jnkie.com/api/v1/luascripts/public/e629b8f01eed30630fc3cb93da70708fdac4e57f3fd11fc6dc308c4d7ba6c1bd/download"},
    }
}
-- ============================================

-- ============================================
-- 🔧 СИСТЕМНЫЕ НАСТРОЙКИ
-- ============================================
local Players = game:GetService("Players")
local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui")

local screen = Instance.new("ScreenGui")
screen.Name = "LunarHub"
screen.Parent = PlayerGui

-- ============================================
-- 🎨 GUI
-- ============================================
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 380, 0, 520)
frame.Position = UDim2.new(0.5, -190, 0.5, -260)
frame.BackgroundColor3 = Color3.fromRGB(20, 20, 40)
frame.BackgroundTransparency = 0
frame.BorderSizePixel = 0
frame.ClipsDescendants = true
frame.Active = true
frame.Draggable = true
frame.Parent = screen

-- Заголовок
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 45)
title.Position = UDim2.new(0, 0, 0, 5)
title.Text = "🌜 Lunar Hub v3.0 🌛"
title.TextColor3 = Color3.fromRGB(255, 215, 0)
title.TextSize = 22
title.Font = Enum.Font.GothamBold
title.BackgroundTransparency = 1
title.Parent = frame

-- Подсчёт игр
local totalGames = 0
for _, list in pairs(Games) do
    totalGames = totalGames + #list
end

local sub = Instance.new("TextLabel")
sub.Size = UDim2.new(1, 0, 0, 20)
sub.Position = UDim2.new(0, 0, 0, 50)
sub.Text = "📊 " .. totalGames .. " игр | by Ryzen"
sub.TextColor3 = Color3.fromRGB(160, 160, 190)
sub.TextSize = 13
sub.Font = Enum.Font.Gotham
sub.BackgroundTransparency = 1
sub.Parent = frame

-- Поиск
local searchBox = Instance.new("TextBox")
searchBox.Size = UDim2.new(1, -20, 0, 30)
searchBox.Position = UDim2.new(0, 10, 0, 75)
searchBox.BackgroundColor3 = Color3.fromRGB(30, 30, 55)
searchBox.TextColor3 = Color3.fromRGB(255, 255, 255)
searchBox.PlaceholderText = "🔍 Поиск игры..."
searchBox.PlaceholderColor3 = Color3.fromRGB(130, 130, 170)
searchBox.TextSize = 14
searchBox.Font = Enum.Font.Gotham
searchBox.BorderSizePixel = 0
searchBox.ClipsDescendants = true
searchBox.Parent = frame

-- Вкладки
local tabsFrame = Instance.new("Frame")
tabsFrame.Size = UDim2.new(1, -10, 0, 36)
tabsFrame.Position = UDim2.new(0, 5, 0, 110)
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
tabLayout.Padding = UDim.new(0, 5)
tabLayout.Parent = tabList

-- Список игр
local list = Instance.new("ScrollingFrame")
list.Size = UDim2.new(1, -20, 1, -185)
list.Position = UDim2.new(0, 10, 0, 150)
list.BackgroundTransparency = 1
list.ScrollBarThickness = 5
list.ScrollBarImageColor3 = Color3.fromRGB(80, 80, 130)
list.Parent = frame

local listLayout = Instance.new("UIListLayout")
listLayout.SortOrder = Enum.SortOrder.Name
listLayout.Padding = UDim.new(0, 5)
listLayout.Parent = list

-- Переменные
local currentCategory = nil
local lastSearch = ""

-- Создание кнопки игры
local function createGameButton(data, parent)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 34)
    btn.Text = data.name
    btn.TextColor3 = Color3.fromRGB(220, 220, 245)
    btn.TextSize = 14
    btn.TextXAlignment = Enum.TextXAlignment.Left
    btn.Font = Enum.Font.Gotham
    btn.BackgroundColor3 = Color3.fromRGB(30, 30, 50)
    btn.BorderSizePixel = 0
    btn.Parent = parent
    
    local padding = Instance.new("UIPadding")
    padding.PaddingLeft = UDim.new(0, 10)
    padding.Parent = btn
    
    btn.MouseEnter:Connect(function()
        btn.BackgroundColor3 = Color3.fromRGB(50, 40, 75)
    end)
    btn.MouseLeave:Connect(function()
        btn.BackgroundColor3 = Color3.fromRGB(30, 30, 50)
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
        
        task.wait(1)
        btn.Text = data.name
        btn.BackgroundColor3 = Color3.fromRGB(30, 30, 50)
    end)
end

-- Обновление списка
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
    
    list.CanvasSize = UDim2.new(0, 0, 0, #gamesToShow * 39 + 10)
end

-- Создание вкладок
local function createTabs()
    for cat, _ in pairs(Games) do
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(0, 120, 1, 0)
        btn.Text = cat
        btn.TextColor3 = Color3.fromRGB(200, 200, 230)
        btn.TextSize = 13
        btn.Font = Enum.Font.Gotham
        btn.BackgroundColor3 = Color3.fromRGB(25, 25, 45)
        btn.BorderSizePixel = 0
        btn.Parent = tabList
        
        btn.MouseEnter:Connect(function()
            btn.BackgroundColor3 = Color3.fromRGB(50, 40, 70)
        end)
        btn.MouseLeave:Connect(function()
            if currentCategory ~= cat then
                btn.BackgroundColor3 = Color3.fromRGB(25, 25, 45)
            end
        end)
        
        btn.MouseButton1Click:Connect(function()
            currentCategory = cat
            for _, child in ipairs(tabList:GetChildren()) do
                if child:IsA("TextButton") then
                    if child == btn then
                        child.BackgroundColor3 = Color3.fromRGB(70, 50, 100)
                    else
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
                child.BackgroundColor3 = Color3.fromRGB(70, 50, 100)
                break
            end
        end
    end
end

-- Поиск
searchBox:GetPropertyChangedSignal("Text"):Connect(function()
    lastSearch = searchBox.Text
    updateList(currentCategory, lastSearch)
end)

-- Кнопка закрытия
local close = Instance.new("TextButton")
close.Size = UDim2.new(0, 34, 0, 34)
close.Position = UDim2.new(1, -40, 0, 6)
close.Text = "✕"
close.TextColor3 = Color3.fromRGB(255, 100, 100)
close.TextSize = 20
close.Font = Enum.Font.Gotham
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

-- Запуск
createTabs()
updateList(currentCategory, "")

print("✅ Lunar Hub v3.0 загружен! (" .. totalGames .. " игр)")
print("🌙 Добавляй игры в блок Games в начале кода.")
