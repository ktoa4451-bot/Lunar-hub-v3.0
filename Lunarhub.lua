-- ============================================
-- 🌙 LUNAR HUB v5.6 (БАЗОВАЯ ВЕРСИЯ)
-- by Ryzen
-- ============================================

-- ============================================
-- 🔄 АВТО-ОБНОВЛЕНИЕ
-- ============================================
local function selfUpdate()
    local currentVersion = "5.6"
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
-- ⚡ ИГРЫ
-- ============================================
local Games = {
    {name = "Arena 1.8", link = "https://raw.githubusercontent.com/Lutosys/1.8arena/refs/heads/main/1.8arena.lua"},
    {name = "Forsaken", link = "https://raw.githubusercontent.com/ScriptDLC/ScriptDLC/refs/heads/main/ForsakenDLCHUB"},
    {name = "Rivals", link = "https://rawscripts.net/raw/RIVALS-Noks-hub-keyless-111339"},
    {name = "MM2", link = "https://raw.githubusercontent.com/pruzgar242-rgb/Update/refs/heads/main/out.lua%20(17).txt"},
    {name = "Prison Life", link = "https://rawscripts.net/raw/Prison-Life-serk4rx-script-239866"},
    {name = "Rost Alpha", link = "https://pastefy.app/JNOgCLi6/raw?part="},
    {name = "Ink Game", link = "https://rawscripts.net/raw/Universal-Script-RINGTA-best-script-for-ink-game-206674"},
    {name = "Wallhop V4", link = "https://rawscripts.net/raw/Universal-Script-Nova-Wallhop-V4-206099"},
    {name = "Color or Die", link = "https://rawscripts.net/raw/Color-or-Die-Esp-12555"},
    {name = "Rost Alpha Premium", link = "https://api.jnkie.com/api/v1/luascripts/public/e629b8f01eed30630fc3cb93da70708fdac4e57f3fd11fc6dc308c4d7ba6c1bd/download"},
    {name = "Prison Life Premium", link = "https://rawscripts.net/raw/Prison-Life-Override-Hub-Silent-Aim-and-More-242218"},
    {name = "Slap Battles", link = "https://raw.githubusercontent.com/Articles-Hub/ROBLOXScript/refs/heads/main/File-Script/Slap_Battles.lua"},
    {name = "Drain the Lake", link = "https://raw.githubusercontent.com/gumanba/Scripts/main/DraintheLake"},
    {name = "Chameleon", link = "https://raw.githubusercontent.com/tawxm/NgThanhTam/refs/heads/main/Chameleon.lua"},
    {name = "Sell Limons", link = "https://raw.githubusercontent.com/Fluxyyy333/HoshiOnTop/main/loader.lua"},
    {name = "Mine Per Click", link = "https://raw.githubusercontent.com/gumanba/Scripts/refs/heads/main/1MinePerClick"},
}

-- ============================================
-- 🔧 УНИВЕРСАЛЬНЫЙ ЗАГРУЗЧИК
-- ============================================
local function loadScript(link)
    local success, result = pcall(function()
        local scriptContent = game:HttpGet(link)
        return loadstring(scriptContent)
    end)
    
    if success and result then
        local execSuccess, execErr = pcall(result)
        if execSuccess then
            return true, "✅ Успешно"
        else
            return false, "Ошибка выполнения: " .. tostring(execErr)
        end
    else
        return false, "Ошибка загрузки: " .. tostring(result)
    end
end

-- ============================================
-- 🔧 GUI
-- ============================================
local Players = game:GetService("Players")
local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui")
local TweenService = game:GetService("TweenService")

local screen = Instance.new("ScreenGui")
screen.Name = "LunarHub"
screen.Parent = PlayerGui
screen.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- ОСНОВНОЙ ФРЕЙМ
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 380, 0, 460)
frame.Position = UDim2.new(0.5, -190, 0.5, -230)
frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
frame.BackgroundTransparency = 0.15
frame.BorderSizePixel = 0
frame.ClipsDescendants = true
frame.Active = true
frame.Draggable = true
frame.Parent = screen

local border = Instance.new("Frame")
border.Size = UDim2.new(1, 2, 1, 2)
border.Position = UDim2.new(0, -1, 0, -1)
border.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
border.BackgroundTransparency = 0.9
border.BorderSizePixel = 0
border.Parent = frame

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 45)
title.Position = UDim2.new(0, 0, 0, 10)
title.Text = "🌙 LUNAR HUB"
title.TextColor3 = Color3.fromRGB(255, 215, 0)
title.TextScaled = true
title.Font = Enum.Font.GothamBold
title.BackgroundTransparency = 1
title.Parent = frame

local sub = Instance.new("TextLabel")
sub.Size = UDim2.new(1, 0, 0, 20)
sub.Position = UDim2.new(0, 0, 0, 52)
sub.Text = "📊 " .. #Games .. " игр | by Ryzen"
sub.TextColor3 = Color3.fromRGB(180, 180, 220)
sub.TextSize = 12
sub.Font = Enum.Font.Gotham
sub.BackgroundTransparency = 1
sub.Parent = frame

local close = Instance.new("TextButton")
close.Size = UDim2.new(0, 32, 0, 32)
close.Position = UDim2.new(1, -40, 0, 8)
close.Text = "✕"
close.TextColor3 = Color3.fromRGB(255, 100, 100)
close.TextSize = 18
close.Font = Enum.Font.GothamBold
close.BackgroundTransparency = 1
close.Parent = frame
close.MouseButton1Click:Connect(function()
    screen:Destroy()
end)

local searchBox = Instance.new("TextBox")
searchBox.Size = UDim2.new(1, -20, 0, 28)
searchBox.Position = UDim2.new(0, 10, 0, 78)
searchBox.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
searchBox.BackgroundTransparency = 0.5
searchBox.TextColor3 = Color3.fromRGB(255, 255, 255)
searchBox.PlaceholderText = "🔍 Поиск..."
searchBox.PlaceholderColor3 = Color3.fromRGB(140, 140, 180)
searchBox.TextSize = 13
searchBox.Font = Enum.Font.Gotham
searchBox.BorderSizePixel = 0
searchBox.ClipsDescendants = true
searchBox.Parent = frame

local list = Instance.new("ScrollingFrame")
list.Size = UDim2.new(1, -20, 1, -110)
list.Position = UDim2.new(0, 10, 0, 110)
list.BackgroundTransparency = 1
list.ScrollBarThickness = 4
list.ScrollBarImageColor3 = Color3.fromRGB(80, 80, 80)
list.Parent = frame

local listLayout = Instance.new("UIListLayout")
listLayout.SortOrder = Enum.SortOrder.Name
listLayout.Padding = UDim.new(0, 4)
listLayout.Parent = list

for _, gameData in ipairs(Games) do
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 32)
    btn.Text = gameData.name
    btn.TextColor3 = Color3.fromRGB(230, 230, 255)
    btn.TextSize = 13
    btn.TextXAlignment = Enum.TextXAlignment.Left
    btn.Font = Enum.Font.GothamBold
    btn.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    btn.BackgroundTransparency = 0.2
    btn.BorderSizePixel = 0
    btn.Parent = list
    
    local padding = Instance.new("UIPadding")
    padding.PaddingLeft = UDim.new(0, 12)
    padding.Parent = btn
    
    local arrow = Instance.new("TextLabel")
    arrow.Size = UDim2.new(0, 25, 1, 0)
    arrow.Position = UDim2.new(1, -30, 0, 0)
    arrow.Text = "▶"
    arrow.TextColor3 = Color3.fromRGB(150, 150, 150)
    arrow.TextSize = 16
    arrow.BackgroundTransparency = 1
    arrow.Parent = btn
    
    btn.MouseEnter:Connect(function()
        btn.BackgroundTransparency = 0
        btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        arrow.TextColor3 = Color3.fromRGB(255, 215, 0)
    end)
    btn.MouseLeave:Connect(function()
        btn.BackgroundTransparency = 0.2
        btn.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
        arrow.TextColor3 = Color3.fromRGB(150, 150, 150)
    end)
    
    btn.MouseButton1Click:Connect(function()
        btn.Text = "⏳..."
        btn.BackgroundColor3 = Color3.fromRGB(50, 50, 30)
        arrow.Text = "⏳"
        
        local success, msg = loadScript(gameData.link)
        
        if success then
            btn.Text = "✅ " .. gameData.name
            btn.BackgroundColor3 = Color3.fromRGB(30, 50, 30)
            arrow.Text = "✅"
        else
            btn.Text = "❌ " .. gameData.name
            btn.BackgroundColor3 = Color3.fromRGB(50, 30, 30)
            arrow.Text = "❌"
        end
        
        task.wait(1)
        btn.Text = gameData.name
        btn.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
        arrow.Text = "▶"
    end)
end

task.wait(0.1)
local count = 0
for _, child in ipairs(list:GetChildren()) do
    if child:IsA("TextButton") then
        count = count + 1
    end
end
list.CanvasSize = UDim2.new(0, 0, 0, count * 36 + 10)

searchBox:GetPropertyChangedSignal("Text"):Connect(function()
    local search = string.lower(searchBox.Text)
    for _, child in ipairs(list:GetChildren()) do
        if child:IsA("TextButton") then
            child.Visible = (search == "" or string.find(string.lower(child.Text), search))
        end
    end
end)

print("✅ Lunar Hub v5.6 загружен! (" .. #Games .. " игр)")
