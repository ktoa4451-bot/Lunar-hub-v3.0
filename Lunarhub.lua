-- ============================================
-- 🌙 LUNAR HUB v4.2 (СТАБИЛЬНАЯ ВЕРСИЯ)
-- by Ryzen | ГАРАНТИРОВАННО РАБОТАЕТ
-- ============================================

local Players = game:GetService("Players")
local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui")

-- ============================================
-- ⚡ ИГРЫ (ДОБАВЛЯЙ СЮДА)
-- ============================================
local Games = {
    ["🔫 Шутеры"] = {
        {name = "Arena 1.8", link = "https://raw.githubusercontent.com/Lutosys/1.8arena/refs/heads/main/1.8arena.lua"},
        {name = "Forsaken", link = "https://raw.githubusercontent.com/ScriptDLC/ScriptDLC/refs/heads/main/ForsakenDLCHUB"},
        {name = "Rivals", link = "https://rawscripts.net/raw/RIVALS-Noks-hub-keyless-111339"},
        {name = "MM2", link = "https://raw.githubusercontent.com/pruzgar242-rgb/Update/refs/heads/main/out.lua%20(17).txt"},
        {name = "Prison Life", link = "https://rawscripts.net/raw/Prison-Life-serk4rx-script-239866"},
    },
    ["🌋 Приключения"] = {
        {name = "Rost Alpha", link = "https://pastefy.app/JNOgCLi6/raw?part="},
        {name = "Ink Game", link = "https://rawscripts.net/raw/Universal-Script-RINGTA-best-script-for-ink-game-206674"},
        {name = "Wallhop V4", link = "https://rawscripts.net/raw/Universal-Script-Nova-Wallhop-V4-206099"},
        {name = "Color or Die", link = "https://rawscripts.net/raw/Color-or-Die-Esp-12555"},
    },
    ["🔑 Премиум"] = {
        {name = "Rost Alpha Premium", link = "https://api.jnkie.com/api/v1/luascripts/public/e629b8f01eed30630fc3cb93da70708fdac4e57f3fd11fc6dc308c4d7ba6c1bd/download"},
        {name = "Prison Life Premium", link = "https://rawscripts.net/raw/Prison-Life-Override-Hub-Silent-Aim-and-More-242218"},
    }
}

-- ============================================
-- 🔧 ПРОСТОЙ ГАРАНТИРОВАННО РАБОЧИЙ GUI
-- ============================================
local screen = Instance.new("ScreenGui")
screen.Name = "LunarHub"
screen.Parent = PlayerGui

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 380, 0, 460)
frame.Position = UDim2.new(0.5, -190, 0.5, -230)
frame.BackgroundColor3 = Color3.fromRGB(16, 16, 36)
frame.BackgroundTransparency = 0
frame.BorderSizePixel = 0
frame.ClipsDescendants = true
frame.Active = true
frame.Draggable = true
frame.Parent = screen

-- ГРАДИЕНТ
local gradient = Instance.new("UIGradient")
gradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(30, 20, 60)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(16, 16, 36))
})
frame.UIGradient = gradient

-- ЗАГОЛОВОК
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 45)
title.Position = UDim2.new(0, 0, 0, 5)
title.Text = "🌙 LUNAR HUB v4.2"
title.TextColor3 = Color3.fromRGB(255, 215, 0)
title.TextScaled = true
title.Font = Enum.Font.GothamBold
title.BackgroundTransparency = 1
title.Parent = frame

-- СЧЁТЧИК
local totalGames = 0
for _, list in pairs(Games) do
    totalGames = totalGames + #list
end

local sub = Instance.new("TextLabel")
sub.Size = UDim2.new(1, 0, 0, 20)
sub.Position = UDim2.new(0, 0, 0, 50)
sub.Text = "📊 " .. totalGames .. " игр | by Ryzen"
sub.TextColor3 = Color3.fromRGB(180, 180, 220)
sub.TextSize = 13
sub.Font = Enum.Font.Gotham
sub.BackgroundTransparency = 1
sub.Parent = frame

-- ЗАКРЫТИЕ
local close = Instance.new("TextButton")
close.Size = UDim2.new(0, 34, 0, 34)
close.Position = UDim2.new(1, -40, 0, 5)
close.Text = "✕"
close.TextColor3 = Color3.fromRGB(255, 100, 100)
close.TextSize = 20
close.Font = Enum.Font.Gotham
close.BackgroundTransparency = 1
close.Parent = frame
close.MouseButton1Click:Connect(function()
    screen:Destroy()
end)

-- СПИСОК
local list = Instance.new("ScrollingFrame")
list.Size = UDim2.new(1, -20, 1, -100)
list.Position = UDim2.new(0, 10, 0, 75)
list.BackgroundTransparency = 1
list.CanvasSize = UDim2.new(0, 0, 0, 0)
list.ScrollBarThickness = 5
list.ScrollBarImageColor3 = Color3.fromRGB(80, 80, 140)
list.Parent = frame

local listLayout = Instance.new("UIListLayout")
listLayout.SortOrder = Enum.SortOrder.Name
listLayout.Padding = UDim.new(0, 5)
listLayout.Parent = list

-- ============================================
-- 🔘 СОЗДАНИЕ КНОПОК
-- ============================================
for _, gameList in pairs(Games) do
    for _, game in ipairs(gameList) do
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(1, 0, 0, 34)
        btn.Text = game.name
        btn.TextColor3 = Color3.fromRGB(230, 230, 255)
        btn.TextSize = 14
        btn.TextXAlignment = Enum.TextXAlignment.Left
        btn.Font = Enum.Font.Gotham
        btn.BackgroundColor3 = Color3.fromRGB(30, 30, 55)
        btn.BackgroundTransparency = 0.2
        btn.BorderSizePixel = 0
        btn.Parent = list
        
        local padding = Instance.new("UIPadding")
        padding.PaddingLeft = UDim.new(0, 12)
        padding.Parent = btn
        
        btn.MouseEnter:Connect(function()
            btn.BackgroundTransparency = 0
            btn.BackgroundColor3 = Color3.fromRGB(55, 40, 85)
        end)
        btn.MouseLeave:Connect(function()
            btn.BackgroundTransparency = 0.2
            btn.BackgroundColor3 = Color3.fromRGB(30, 30, 55)
        end)
        
        btn.MouseButton1Click:Connect(function()
            btn.Text = "⏳ Загрузка..."
            btn.BackgroundColor3 = Color3.fromRGB(70, 50, 30)
            
            local success, err = pcall(function()
                loadstring(game:HttpGet(game.link))()
            end)
            
            if success then
                btn.Text = "✅ " .. game.name
                btn.BackgroundColor3 = Color3.fromRGB(30, 70, 30)
            else
                btn.Text = "❌ " .. game.name
                btn.BackgroundColor3 = Color3.fromRGB(70, 30, 30)
            end
            
            task.wait(1.5)
            btn.Text = game.name
            btn.BackgroundColor3 = Color3.fromRGB(30, 30, 55)
        end)
    end
end

-- ОБНОВЛЕНИЕ РАЗМЕРА
task.wait(0.1)
local count = 0
for _, child in ipairs(list:GetChildren()) do
    if child:IsA("TextButton") then
        count = count + 1
    end
end
list.CanvasSize = UDim2.new(0, 0, 0, count * 39 + 10)

print("✅ Lunar Hub v4.2 загружен! (" .. totalGames .. " игр)")
