-- 🌙 LUNAR HUB v30.1
-- Clean rebuild

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

-- Удаляем старую копию
local old = PlayerGui:FindFirstChild("LunarHub")
if old then old:Destroy() end

local Theme = {
    BG = Color3.fromRGB(14, 12, 27),
    Card = Color3.fromRGB(27, 23, 48),
    Card2 = Color3.fromRGB(32, 27, 56),
    Purple = Color3.fromRGB(130, 55, 255),
    Purple2 = Color3.fromRGB(92, 35, 200),
    Text = Color3.fromRGB(245, 242, 255),
    Sub = Color3.fromRGB(155, 148, 180)
}

local function corner(obj, radius)
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, radius or 14)
    c.Parent = obj
end

local function stroke(obj, color, transparency, thickness)
    local s = Instance.new("UIStroke")
    s.Color = color
    s.Transparency = transparency or 0
    s.Thickness = thickness or 1
    s.Parent = obj
end

local function label(parent, text, size, pos, font, color)
    local x = Instance.new("TextLabel")
    x.Parent = parent
    x.BackgroundTransparency = 1
    x.Text = text
    x.TextSize = size
    x.Font = font or Enum.Font.Gotham
    x.TextColor3 = color or Theme.Text
    x.Position = pos
    x.Size = UDim2.new(1, -20, 0, size + 8)
    x.TextXAlignment = Enum.TextXAlignment.Left
    return x
end

-- GUI
local Gui = Instance.new("ScreenGui")
Gui.Name = "LunarHub"
Gui.ResetOnSpawn = false
Gui.IgnoreGuiInset = true
Gui.Parent = PlayerGui

-- Main
local Main = Instance.new("Frame")
Main.Parent = Gui
Main.Size = UDim2.new(0, 900, 0, 560)
Main.Position = UDim2.new(0.5, -450, 0.5, -280)
Main.BackgroundColor3 = Theme.BG
Main.BorderSizePixel = 0
corner(Main, 22)
stroke(Main, Theme.Purple, 0.25, 2)

-- Header
local Header = Instance.new("Frame")
Header.Parent = Main
Header.Size = UDim2.new(1, 0, 0, 85)
Header.BackgroundColor3 = Theme.BG
Header.BorderSizePixel = 0
corner(Header, 22)

label(Header, "☾  LUNAR HUB", 25,
    UDim2.new(0, 30, 0, 18),
    Enum.Font.GothamBold)

label(Header, "NEON EDITION • v30.1", 12,
    UDim2.new(0, 31, 0, 51),
    Enum.Font.Gotham,
    Theme.Sub)

-- Close
local Close = Instance.new("TextButton")
Close.Parent = Header
Close.Size = UDim2.new(0, 48, 0, 44)
Close.Position = UDim2.new(1, -62, 0, 20)
Close.BackgroundColor3 = Theme.Card
Close.Text = "×"
Close.TextSize = 24
Close.Font = Enum.Font.GothamBold
Close.TextColor3 = Theme.Text
Close.BorderSizePixel = 0
corner(Close, 14)

-- Minimize
local Min = Instance.new("TextButton")
Min.Parent = Header
Min.Size = UDim2.new(0, 48, 0, 44)
Min.Position = UDim2.new(1, -118, 0, 20)
Min.BackgroundColor3 = Theme.Card
Min.Text = "−"
Min.TextSize = 24
Min.Font = Enum.Font.GothamBold
Min.TextColor3 = Theme.Text
Min.BorderSizePixel = 0
corner(Min, 14)

-- Sidebar
local Side = Instance.new("Frame")
Side.Parent = Main
Side.Position = UDim2.new(0, 0, 0, 85)
Side.Size = UDim2.new(0, 220, 1, -85)
Side.BackgroundColor3 = Color3.fromRGB(17, 14, 32)
Side.BorderSizePixel = 0
corner(Side, 18)

local Games = Instance.new("TextButton")
Games.Parent = Side
Games.Position = UDim2.new(0, 18, 0, 30)
Games.Size = UDim2.new(1, -36, 0, 60)
Games.BackgroundColor3 = Theme.Purple2
Games.Text = "☾   Games"
Games.TextSize = 17
Games.Font = Enum.Font.GothamBold
Games.TextColor3 = Theme.Text
Games.BorderSizePixel = 0
corner(Games, 18)

local Updates = Instance.new("TextButton")
Updates.Parent = Side
Updates.Position = UDim2.new(0, 18, 0, 105)
Updates.Size = UDim2.new(1, -36, 0, 60)
Updates.BackgroundColor3 = Side.BackgroundColor3
Updates.Text = "↻   Updates"
Updates.TextSize = 17
Updates.Font = Enum.Font.Gotham
Updates.TextColor3 = Theme.Sub
Updates.BorderSizePixel = 0
corner(Updates, 18)

-- Content
local Content = Instance.new("Frame")
Content.Parent = Main
Content.Position = UDim2.new(0, 220, 0, 85)
Content.Size = UDim2.new(1, -220, 1, -85)
Content.BackgroundTransparency = 1

-- Search
local Search = Instance.new("TextBox")
Search.Parent = Content
Search.Position = UDim2.new(0, 25, 0, 25)
Search.Size = UDim2.new(1, -50, 0, 55)
Search.BackgroundColor3 = Theme.Card
Search.PlaceholderText = "⌕  Search games..."
Search.PlaceholderColor3 = Theme.Sub
Search.Text = ""
Search.TextColor3 = Theme.Text
Search.TextSize = 15
Search.Font = Enum.Font.Gotham
Search.BorderSizePixel = 0
corner(Search, 17)

-- Game list
local List = Instance.new("ScrollingFrame")
List.Parent = Content
List.Position = UDim2.new(0, 25, 0, 95)
List.Size = UDim2.new(1, -50, 1, -115)
List.BackgroundTransparency = 1
List.BorderSizePixel = 0
List.ScrollBarThickness = 3
List.AutomaticCanvasSize = Enum.AutomaticSize.Y
List.CanvasSize = UDim2.new()

local Layout = Instance.new("UIListLayout")
Layout.Parent = List
Layout.Padding = UDim.new(0, 12)

local Padding = Instance.new("UIPadding")
Padding.Parent = List
Padding.PaddingBottom = UDim.new(0, 10)

-- Games
local GameData = {
    {"Forsaken", "Forsaken scripts"},
    {"MM2", "Murder Mystery 2"},
    {"Rivals", "Rivals scripts"},
    {"Slap Battles", "Slap Battles"},
    {"King Legacy", "King Legacy"}
}

local Cards = {}

local function createGame(data)
    local card = Instance.new("TextButton")
    card.Parent = List
    card.Size = UDim2.new(1, 0, 0, 82)
    card.BackgroundColor3 = Theme.Card
    card.Text = ""
    card.AutoButtonColor = false
    card.BorderSizePixel = 0
    corner(card, 18)

    local icon = Instance.new("Frame")
    icon.Parent = card
    icon.Position = UDim2.new(0, 14, 0, 12)
    icon.Size = UDim2.new(0, 58, 0, 58)
    icon.BackgroundColor3 = Theme.Purple2
    icon.BorderSizePixel = 0
    corner(icon, 15)

    label(icon, "☾", 27,
        UDim2.new(0, 0, 0, 11),
        Enum.Font.GothamBold,
        Theme.Text).TextXAlignment = Enum.TextXAlignment.Center

    local title = label(card, data[1], 16,
        UDim2.new(0, 88, 0, 15),
        Enum.Font.GothamBold)

    local desc = label(card, data[2], 13,
        UDim2.new(0, 88, 0, 42),
        Enum.Font.Gotham,
        Theme.Sub)

    local arrow = label(card, "›", 28,
        UDim2.new(1, -45, 0, 25),
        Enum.Font.GothamBold,
        Theme.Sub)
    arrow.TextXAlignment = Enum.TextXAlignment.Center

    card.MouseEnter:Connect(function()
        card.BackgroundColor3 = Theme.Card2
    end)

    card.MouseLeave:Connect(function()
        card.BackgroundColor3 = Theme.Card
    end)

    card.MouseButton1Click:Connect(function()
        -- Здесь позже подключим действие/ссылку игры
        print("Selected:", data[1])
    end)

    table.insert(Cards, {card, title, desc})
end

for _, gameData in ipairs(GameData) do
    createGame(gameData)
end

-- Updates page
local UpdatePage = Instance.new("Frame")
UpdatePage.Parent = Content
UpdatePage.Position = UDim2.new(0, 25, 0, 25)
UpdatePage.Size = UDim2.new(1, -50, 1, -50)
UpdatePage.BackgroundColor3 = Theme.Card
UpdatePage.Visible = false
UpdatePage.BorderSizePixel = 0
corner(UpdatePage, 18)

label(UpdatePage, "☾  Lunar Updates", 22,
    UDim2.new(0, 25, 0, 25),
    Enum.Font.GothamBold)

label(UpdatePage,
    "Lunar Hub v30.1\n\n• Rounded interface\n• Fixed duplicate categories\n• Improved mobile layout\n• New game cards",
    14,
    UDim2.new(0, 25, 0, 75),
    Enum.Font.Gotham,
    Theme.Sub).TextWrapped = true

-- Search
Search:GetPropertyChangedSignal("Text"):Connect(function()
    local query = Search.Text:lower()

    for _, item in ipairs(Cards) do
        local card, title = item[1], item[2]
        card.Visible = query == "" or title.Text:lower():find(query, 1, true) ~= nil
    end
end)

-- Categories
Games.MouseButton1Click:Connect(function()
    List.Visible = true
    Search.Visible = true
    UpdatePage.Visible = false

    Games.BackgroundColor3 = Theme.Purple2
    Games.TextColor3 = Theme.Text
    Updates.BackgroundColor3 = Side.BackgroundColor3
    Updates.TextColor3 = Theme.Sub
end)

Updates.MouseButton1Click:Connect(function()
    List.Visible = false
    Search.Visible = false
    UpdatePage.Visible = true

    Updates.BackgroundColor3 = Theme.Purple2
    Updates.TextColor3 = Theme.Text
    Games.BackgroundColor3 = Side.BackgroundColor3
    Games.TextColor3 = Theme.Sub
end)

-- Close
Close.MouseButton1Click:Connect(function()
    Gui:Destroy()
end)

-- Minimize
local minimized = false

Min.MouseButton1Click:Connect(function()
    minimized = not minimized

    for _, obj in ipairs(Main:GetChildren()) do
        if obj ~= Header then
            obj.Visible = not minimized
        end
    end

    Main.Size = minimized
        and UDim2.new(0, 420, 0, 85)
        or UDim2.new(0, 900, 0, 560)
end)

-- Drag
local dragging = false
local dragStart
local startPos

Header.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then

        dragging = true
        dragStart = input.Position
        startPos = Main.Position
    end
end)

UIS.InputChanged:Connect(function(input)
    if dragging and
        (input.UserInputType == Enum.UserInputType.MouseMovement
        or input.UserInputType == Enum.UserInputType.Touch) then

        local delta = input.Position - dragStart

        Main.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
    end
end)

UIS.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)

print("🌙 Lunar Hub loaded successfully")
