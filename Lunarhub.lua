--[[
    🌙 LUNAR HUB v32.0
    Clean UI Rebuild
]]

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")

local Player = Players.LocalPlayer
local GuiParent = game:GetService("CoreGui")

local VERSION = "32.0"

-- Remove old Lunar Hub
pcall(function()
    local old = GuiParent:FindFirstChild("LunarHub")
    if old then
        old:Destroy()
    end
end)

--// THEME
local Theme = {
    Background = Color3.fromRGB(12, 10, 25),
    Header = Color3.fromRGB(15, 12, 30),
    Sidebar = Color3.fromRGB(17, 14, 34),
    Card = Color3.fromRGB(27, 23, 52),
    CardHover = Color3.fromRGB(36, 29, 67),
    Purple = Color3.fromRGB(112, 42, 255),
    PurpleDark = Color3.fromRGB(75, 28, 180),
    Text = Color3.fromRGB(245, 242, 255),
    SubText = Color3.fromRGB(150, 143, 180)
}

local function Tween(obj, time, props)
    local info = TweenInfo.new(
        time,
        Enum.EasingStyle.Quint,
        Enum.EasingDirection.Out
    )

    return TweenService:Create(obj, info, props)
end

local function Corner(obj, radius)
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, radius)
    c.Parent = obj
end

local function Stroke(obj, color, transparency, thickness)
    local s = Instance.new("UIStroke")
    s.Color = color
    s.Transparency = transparency or 0
    s.Thickness = thickness or 1
    s.Parent = obj
end

local function Text(parent, text, size, position, font, color)
    local t = Instance.new("TextLabel")
    t.Parent = parent
    t.BackgroundTransparency = 1
    t.Text = text
    t.TextSize = size
    t.Font = font or Enum.Font.Gotham
    t.TextColor3 = color or Theme.Text
    t.Position = position
    t.Size = UDim2.new(1, -20, 0, size + 8)
    t.TextXAlignment = Enum.TextXAlignment.Left
    return t
end

--// GUI
local Gui = Instance.new("ScreenGui")
Gui.Name = "LunarHub"
Gui.ResetOnSpawn = false
Gui.IgnoreGuiInset = true
Gui.Parent = GuiParent

--// MAIN
local Main = Instance.new("Frame")
Main.Parent = Gui
Main.AnchorPoint = Vector2.new(0.5, 0.5)
Main.Position = UDim2.new(0.5, 0, 0.5, 20)
Main.Size = UDim2.new(0, 820, 0, 500)
Main.BackgroundColor3 = Theme.Background
Main.BorderSizePixel = 0
Main.ClipsDescendants = true
Main.BackgroundTransparency = 0.04
Corner(Main, 22)
Stroke(Main, Theme.Purple, 0.2, 2)

--// HEADER
local Header = Instance.new("Frame")
Header.Parent = Main
Header.Size = UDim2.new(1, 0, 0, 88)
Header.BackgroundColor3 = Theme.Header
Header.BorderSizePixel = 0

local Moon = Text(
    Header,
    "☾",
    42,
    UDim2.new(0, 28, 0, 16),
    Enum.Font.GothamBold,
    Color3.fromRGB(210, 180, 255)
)
Moon.Size = UDim2.new(0, 50, 0, 50)
Moon.TextXAlignment = Enum.TextXAlignment.Center

Text(
    Header,
    "LUNAR HUB",
    25,
    UDim2.new(0, 85, 0, 18),
    Enum.Font.GothamBold
)

Text(
    Header,
    "v" .. VERSION,
    13,
    UDim2.new(0, 86, 0, 49),
    Enum.Font.Gotham,
    Theme.SubText
)

--// CLOSE
local Close = Instance.new("TextButton")
Close.Parent = Header
Close.Size = UDim2.new(0, 48, 0, 44)
Close.Position = UDim2.new(1, -62, 0, 21)
Close.BackgroundColor3 = Theme.Card
Close.Text = "×"
Close.TextSize = 25
Close.Font = Enum.Font.GothamBold
Close.TextColor3 = Theme.Text
Close.BorderSizePixel = 0
Corner(Close, 15)

--// MINIMIZE
local Minimize = Instance.new("TextButton")
Minimize.Parent = Header
Minimize.Size = UDim2.new(0, 48, 0, 44)
Minimize.Position = UDim2.new(1, -118, 0, 21)
Minimize.BackgroundColor3 = Theme.Card
Minimize.Text = "−"
Minimize.TextSize = 25
Minimize.Font = Enum.Font.GothamBold
Minimize.TextColor3 = Theme.Text
Minimize.BorderSizePixel = 0
Corner(Minimize, 15)

--// SIDEBAR
local Sidebar = Instance.new("Frame")
Sidebar.Parent = Main
Sidebar.Position = UDim2.new(0, 0, 0, 88)
Sidebar.Size = UDim2.new(0, 215, 1, -88)
Sidebar.BackgroundColor3 = Theme.Sidebar
Sidebar.BorderSizePixel = 0

-- Games
local GamesButton = Instance.new("TextButton")
GamesButton.Parent = Sidebar
GamesButton.Position = UDim2.new(0, 18, 0, 28)
GamesButton.Size = UDim2.new(1, -36, 0, 62)
GamesButton.BackgroundColor3 = Theme.PurpleDark
GamesButton.Text = "🎮   Games"
GamesButton.TextSize = 17
GamesButton.Font = Enum.Font.GothamBold
GamesButton.TextColor3 = Theme.Text
GamesButton.BorderSizePixel = 0
GamesButton.AutoButtonColor = false
Corner(GamesButton, 18)

-- Updates
local UpdatesButton = Instance.new("TextButton")
UpdatesButton.Parent = Sidebar
UpdatesButton.Position = UDim2.new(0, 18, 0, 103)
UpdatesButton.Size = UDim2.new(1, -36, 0, 62)
UpdatesButton.BackgroundColor3 = Theme.Sidebar
UpdatesButton.Text = "🔄   Updates"
UpdatesButton.TextSize = 17
UpdatesButton.Font = Enum.Font.Gotham
UpdatesButton.TextColor3 = Theme.SubText
UpdatesButton.BorderSizePixel = 0
UpdatesButton.AutoButtonColor = false
Corner(UpdatesButton, 18)

--// CONTENT
local Content = Instance.new("Frame")
Content.Parent = Main
Content.Position = UDim2.new(0, 215, 0, 88)
Content.Size = UDim2.new(1, -215, 1, -88)
Content.BackgroundTransparency = 1

--// SEARCH
local Search = Instance.new("TextBox")
Search.Parent = Content
Search.Position = UDim2.new(0, 25, 0, 22)
Search.Size = UDim2.new(1, -50, 0, 58)
Search.BackgroundColor3 = Theme.Card
Search.PlaceholderText = "🔍  Search games..."
Search.PlaceholderColor3 = Theme.SubText
Search.Text = ""
Search.TextColor3 = Theme.Text
Search.TextSize = 15
Search.Font = Enum.Font.Gotham
Search.BorderSizePixel = 0
Search.ClearTextOnFocus = false
Corner(Search, 18)

--// GAME LIST
local GameList = Instance.new("ScrollingFrame")
GameList.Parent = Content
GameList.Position = UDim2.new(0, 25, 0, 92)
GameList.Size = UDim2.new(1, -50, 1, -105)
GameList.BackgroundTransparency = 1
GameList.BorderSizePixel = 0
GameList.ScrollBarThickness = 3
GameList.AutomaticCanvasSize = Enum.AutomaticSize.Y
GameList.CanvasSize = UDim2.new()

local Layout = Instance.new("UIListLayout")
Layout.Parent = GameList
Layout.Padding = UDim.new(0, 10)

--// GAMES
local GameData = {
    {"Forsaken", "Forsaken scripts"},
    {"MM2", "Murder Mystery 2"},
    {"Rivals", "Rivals scripts"},
    {"Slap Battles", "Slap Battles"},
    {"King Legacy", "King Legacy"}
}

local Cards = {}

local function CreateGame(name, description)

    local Card = Instance.new("TextButton")
    Card.Parent = GameList
    Card.Size = UDim2.new(1, 0, 0, 82)
    Card.BackgroundColor3 = Theme.Card
    Card.Text = ""
    Card.AutoButtonColor = false
    Card.BorderSizePixel = 0
    Corner(Card, 18)

    local Icon = Instance.new("Frame")
    Icon.Parent = Card
    Icon.Position = UDim2.new(0, 14, 0, 12)
    Icon.Size = UDim2.new(0, 58, 0, 58)
    Icon.BackgroundColor3 = Theme.PurpleDark
    Icon.BorderSizePixel = 0
    Corner(Icon, 16)

    local MoonIcon = Text(
        Icon,
        "🌙",
        27,
        UDim2.new(0, 0, 0, 10),
        Enum.Font.GothamBold
    )
    MoonIcon.Size = UDim2.new(1, 0, 0, 35)
    MoonIcon.TextXAlignment = Enum.TextXAlignment.Center

    Text(
        Card,
        name,
        16,
        UDim2.new(0, 88, 0, 14),
        Enum.Font.GothamBold
    )

    Text(
        Card,
        description,
        13,
        UDim2.new(0, 88, 0, 42),
        Enum.Font.Gotham,
        Theme.SubText
    )

    local Arrow = Text(
        Card,
        "›",
        28,
        UDim2.new(1, -48, 0, 24),
        Enum.Font.GothamBold,
        Theme.SubText
    )
    Arrow.Size = UDim2.new(0, 30, 0, 35)
    Arrow.TextXAlignment = Enum.TextXAlignment.Center

    Card.MouseEnter:Connect(function()
        Tween(Card, 0.12, {
            BackgroundColor3 = Theme.CardHover
        }):Play()
    end)

    Card.MouseLeave:Connect(function()
        Tween(Card, 0.12, {
            BackgroundColor3 = Theme.Card
        }):Play()
    end)

    Card.MouseButton1Click:Connect(function()
        Tween(Card, 0.08, {
            Size = UDim2.new(0.98, 0, 0, 78)
        }):Play()

        task.wait(0.08)

        Tween(Card, 0.12, {
            Size = UDim2.new(1, 0, 0, 82)
        }):Play()

        print("Lunar Hub:", name)
    end)

    table.insert(Cards, {
        Card = Card,
        Name = name
    })
end

for _, game in ipairs(GameData) do
    CreateGame(game[1], game[2])
end

--// UPDATE PAGE
local UpdatePage = Instance.new("Frame")
UpdatePage.Parent = Content
UpdatePage.Position = UDim2.new(0, 25, 0, 22)
UpdatePage.Size = UDim2.new(1, -50, 1, -44)
UpdatePage.BackgroundColor3 = Theme.Card
UpdatePage.BorderSizePixel = 0
UpdatePage.Visible = false
Corner(UpdatePage, 18)

Text(
    UpdatePage,
    "🔄  Lunar Updates",
    22,
    UDim2.new(0, 25, 0, 25),
    Enum.Font.GothamBold
)

Text(
    UpdatePage,
    "Lunar Hub v32.0\n\n" ..
    "• New rounded interface\n" ..
    "• New moon game icons\n" ..
    "• Improved animations\n" ..
    "• Fixed duplicate categories\n" ..
    "• Improved mobile layout",
    14,
    UDim2.new(0, 25, 0, 72),
    Enum.Font.Gotham,
    Theme.SubText
)

--// SEARCH
Search:GetPropertyChangedSignal("Text"):Connect(function()

    local query = Search.Text:lower()

    for _, item in ipairs(Cards) do

        local show = query == ""
            or item.Name:lower():find(query, 1, true)

        item.Card.Visible = show ~= nil
    end
end)

--// CATEGORY SWITCH
GamesButton.MouseButton1Click:Connect(function()

    GameList.Visible = true
    Search.Visible = true
    UpdatePage.Visible = false

    Tween(GamesButton, 0.15, {
        BackgroundColor3 = Theme.PurpleDark
    }):Play()

    Tween(UpdatesButton, 0.15, {
        BackgroundColor3 = Theme.Sidebar
    }):Play()

    GamesButton.TextColor3 = Theme.Text
    UpdatesButton.TextColor3 = Theme.SubText
end)

UpdatesButton.MouseButton1Click:Connect(function()

    GameList.Visible = false
    Search.Visible = false
    UpdatePage.Visible = true

    Tween(UpdatesButton, 0.15, {
        BackgroundColor3 = Theme.PurpleDark
    }):Play()

    Tween(GamesButton, 0.15, {
        BackgroundColor3 = Theme.Sidebar
    }):Play()

    UpdatesButton.TextColor3 = Theme.Text
    GamesButton.TextColor3 = Theme.SubText
end)

--// BUTTON ANIMATIONS
for _, button in ipairs({Close, Minimize, GamesButton, UpdatesButton}) do

    button.MouseEnter:Connect(function()
        Tween(button, 0.12, {
            Size = button.Size + UDim2.new(0, 2, 0, 2)
        }):Play()
    end)

    button.MouseLeave:Connect(function()
        Tween(button, 0.12, {
            Size = button.Size - UDim2.new(0, 2, 0, 2)
        }):Play()
    end)
end

--// CLOSE
Close.MouseButton1Click:Connect(function()

    local anim = Tween(Main, 0.22, {
        Size = UDim2.new(0, 760, 0, 450),
        BackgroundTransparency = 1
    })

    anim:Play()
    anim.Completed:Wait()

    Gui:Destroy()
end)

--// MINIMIZE
local minimized = false

Minimize.MouseButton1Click:Connect(function()

    minimized = not minimized

    if minimized then

        for _, obj in ipairs(Main:GetChildren()) do
            if obj ~= Header then
                obj.Visible = false
            end
        end

        Tween(Main, 0.22, {
            Size = UDim2.new(0, 420, 0, 88)
        }):Play()

    else

        Tween(Main, 0.22, {
            Size = UDim2.new(0, 820, 0, 500)
        }):Play()

        task.wait(0.18)

        for _, obj in ipairs(Main:GetChildren()) do
            if obj ~= Header then
                obj.Visible = true
            end
        end
    end
end)

--// DRAG
local dragging = false
local dragStart
local startPosition

Header.InputBegan:Connect(function(input)

    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then

        dragging = true
        dragStart = input.Position
        startPosition = Main.Position
    end
end)

UIS.InputChanged:Connect(function(input)

    if dragging and (
        input.UserInputType == Enum.UserInputType.MouseMovement
        or input.UserInputType == Enum.UserInputType.Touch
    ) then

        local delta = input.Position - dragStart

        Main.Position = UDim2.new(
            startPosition.X.Scale,
            startPosition.X.Offset + delta.X,
            startPosition.Y.Scale,
            startPosition.Y.Offset + delta.Y
        )
    end
end)

UIS.InputEnded:Connect(function(input)

    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then

        dragging = false
    end
end)

--// OPEN ANIMATION
Main.Size = UDim2.new(0, 700, 0, 420)
Main.BackgroundTransparency = 1

Tween(Main, 0.3, {
    Size = UDim2.new(0, 820, 0, 500),
    BackgroundTransparency = 0.04
}):Play()

print("🌙 Lunar Hub v32.0 loaded")
