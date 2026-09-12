--[[
    🌙 LUNAR HUB v32.0
    FINAL COMPACT UI
]]

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")

local Player = Players.LocalPlayer
local VERSION = "32.0"

--==================================================
-- GUI PARENT
--==================================================

local Parent

pcall(function()
    if gethui then
        Parent = gethui()
    end
end)

Parent = Parent or game:GetService("CoreGui")

-- Удаляем старую копию
pcall(function()
    local old = Parent:FindFirstChild("LunarHub")
    if old then
        old:Destroy()
    end
end)

--==================================================
-- THEME
--==================================================

local Theme = {
    Background = Color3.fromRGB(12, 10, 27),
    Header = Color3.fromRGB(15, 12, 32),
    Sidebar = Color3.fromRGB(16, 13, 32),

    Card = Color3.fromRGB(27, 23, 53),
    CardHover = Color3.fromRGB(38, 30, 70),

    Purple = Color3.fromRGB(120, 45, 255),
    PurpleDark = Color3.fromRGB(75, 28, 185),

    Text = Color3.fromRGB(245, 242, 255),
    Sub = Color3.fromRGB(150, 143, 180)
}

local function Tween(obj, time, properties)
    local info = TweenInfo.new(
        time,
        Enum.EasingStyle.Quint,
        Enum.EasingDirection.Out
    )

    return TweenService:Create(obj, info, properties)
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

local function MakeText(parent, text, size, position, font, color)
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

--==================================================
-- SCREEN GUI
--==================================================

local Gui = Instance.new("ScreenGui")
Gui.Name = "LunarHub"
Gui.ResetOnSpawn = false
Gui.IgnoreGuiInset = true
Gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
Gui.Parent = Parent

--==================================================
-- MAIN
--==================================================

local Main = Instance.new("Frame")

Main.Parent = Gui
Main.AnchorPoint = Vector2.new(0.5, 0.5)
Main.Position = UDim2.new(0.5, 0, 0.5, 30)

-- Меньше ширина, высота остаётся большой
Main.Size = UDim2.new(0, 720, 0, 500)

Main.BackgroundColor3 = Theme.Background
Main.BackgroundTransparency = 0.03
Main.BorderSizePixel = 0
Main.ClipsDescendants = true

Corner(Main, 24)
Stroke(Main, Theme.Purple, 0.18, 2)

--==================================================
-- HEADER
--==================================================

local Header = Instance.new("Frame")

Header.Parent = Main
Header.Size = UDim2.new(1, 0, 0, 82)
Header.BackgroundColor3 = Theme.Header
Header.BorderSizePixel = 0

Corner(Header, 24)

-- Луна
local Moon = MakeText(
    Header,
    "🌙",
    31,
    UDim2.new(0, 20, 0, 16),
    Enum.Font.GothamBold
)

Moon.Size = UDim2.new(0, 42, 0, 42)
Moon.TextXAlignment = Enum.TextXAlignment.Center

-- Title
local Title = MakeText(
    Header,
    "LUNAR HUB",
    22,
    UDim2.new(0, 65, 0, 12),
    Enum.Font.GothamBold
)

Title.Size = UDim2.new(0, 150, 0, 30)

-- Version
local Version = MakeText(
    Header,
    "v" .. VERSION,
    12,
    UDim2.new(0, 66, 0, 42),
    Enum.Font.Gotham,
    Theme.Sub
)

--==================================================
-- HEADER SEARCH
--==================================================

local Search = Instance.new("TextBox")

Search.Parent = Header
Search.Position = UDim2.new(0, 220, 0, 14)
Search.Size = UDim2.new(1, -365, 0, 54)

Search.BackgroundColor3 = Theme.Card
Search.BorderSizePixel = 0

Search.Text = ""
Search.PlaceholderText = "🔍  Search games..."
Search.PlaceholderColor3 = Theme.Sub

Search.TextColor3 = Theme.Text
Search.TextSize = 14
Search.Font = Enum.Font.Gotham

Search.ClearTextOnFocus = false

Corner(Search, 17)

--==================================================
-- MINIMIZE
--==================================================

local Minimize = Instance.new("TextButton")

Minimize.Parent = Header
Minimize.Position = UDim2.new(1, -112, 0, 19)
Minimize.Size = UDim2.new(0, 43, 0, 43)

Minimize.BackgroundColor3 = Theme.Card
Minimize.Text = "−"
Minimize.TextSize = 23
Minimize.Font = Enum.Font.GothamBold
Minimize.TextColor3 = Theme.Text
Minimize.BorderSizePixel = 0
Minimize.AutoButtonColor = false

Corner(Minimize, 14)

--==================================================
-- CLOSE
--==================================================

local Close = Instance.new("TextButton")

Close.Parent = Header
Close.Position = UDim2.new(1, -61, 0, 19)
Close.Size = UDim2.new(0, 43, 0, 43)

Close.BackgroundColor3 = Theme.Card
Close.Text = "×"
Close.TextSize = 23
Close.Font = Enum.Font.GothamBold
Close.TextColor3 = Theme.Text
Close.BorderSizePixel = 0
Close.AutoButtonColor = false

Corner(Close, 14)

--==================================================
-- SIDEBAR
--==================================================

local Sidebar = Instance.new("Frame")

Sidebar.Parent = Main
Sidebar.Position = UDim2.new(0, 0, 0, 82)
Sidebar.Size = UDim2.new(0, 185, 1, -82)

Sidebar.BackgroundColor3 = Theme.Sidebar
Sidebar.BorderSizePixel = 0

Corner(Sidebar, 20)

--==================================================
-- GAMES CATEGORY
--==================================================

local GamesButton = Instance.new("TextButton")

GamesButton.Parent = Sidebar
GamesButton.Position = UDim2.new(0, 14, 0, 25)
GamesButton.Size = UDim2.new(1, -28, 0, 58)

GamesButton.BackgroundColor3 = Theme.PurpleDark
GamesButton.Text = "🎮  Games"
GamesButton.TextSize = 16
GamesButton.Font = Enum.Font.GothamBold
GamesButton.TextColor3 = Theme.Text

GamesButton.BorderSizePixel = 0
GamesButton.AutoButtonColor = false

Corner(GamesButton, 17)

--==================================================
-- UPDATES CATEGORY
--==================================================

local UpdatesButton = Instance.new("TextButton")

UpdatesButton.Parent = Sidebar
UpdatesButton.Position = UDim2.new(0, 14, 0, 94)
UpdatesButton.Size = UDim2.new(1, -28, 0, 58)

UpdatesButton.BackgroundColor3 = Theme.Sidebar
UpdatesButton.Text = "🔄  Updates"
UpdatesButton.TextSize = 16
UpdatesButton.Font = Enum.Font.Gotham
UpdatesButton.TextColor3 = Theme.Sub

UpdatesButton.BorderSizePixel = 0
UpdatesButton.AutoButtonColor = false

Corner(UpdatesButton, 17)

--==================================================
-- CONTENT
--==================================================

local Content = Instance.new("Frame")

Content.Parent = Main
Content.Position = UDim2.new(0, 185, 0, 82)
Content.Size = UDim2.new(1, -185, 1, -82)

Content.BackgroundTransparency = 1

--==================================================
-- GAME LIST
--==================================================

local GameList = Instance.new("ScrollingFrame")

GameList.Parent = Content
GameList.Position = UDim2.new(0, 18, 0, 15)
GameList.Size = UDim2.new(1, -36, 1, -25)

GameList.BackgroundTransparency = 1
GameList.BorderSizePixel = 0

GameList.ScrollBarThickness = 2
GameList.ScrollBarImageColor3 = Theme.Purple

GameList.AutomaticCanvasSize = Enum.AutomaticSize.Y
GameList.CanvasSize = UDim2.new()

local Layout = Instance.new("UIListLayout")

Layout.Parent = GameList
Layout.Padding = UDim.new(0, 10)

Layout.HorizontalAlignment = Enum.HorizontalAlignment.Center

--==================================================
-- GAMES
--==================================================

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
    Card.Size = UDim2.new(1, 0, 0, 80)

    Card.BackgroundColor3 = Theme.Card
    Card.BorderSizePixel = 0

    Card.Text = ""
    Card.AutoButtonColor = false

    Corner(Card, 19)

    -- Icon
    local Icon = Instance.new("Frame")

    Icon.Parent = Card
    Icon.Position = UDim2.new(0, 12, 0, 11)
    Icon.Size = UDim2.new(0, 58, 0, 58)

    Icon.BackgroundColor3 = Theme.PurpleDark
    Icon.BorderSizePixel = 0

    Corner(Icon, 16)

    local IconText = MakeText(
        Icon,
        "🌙",
        25,
        UDim2.new(0, 0, 0, 9),
        Enum.Font.GothamBold
    )

    IconText.Size = UDim2.new(1, 0, 0, 38)
    IconText.TextXAlignment = Enum.TextXAlignment.Center

    -- Name
    local Name = MakeText(
        Card,
        name,
        15,
        UDim2.new(0, 84, 0, 13),
        Enum.Font.GothamBold
    )

    -- Description
    local Description = MakeText(
        Card,
        description,
        12,
        UDim2.new(0, 84, 0, 40),
        Enum.Font.Gotham,
        Theme.Sub
    )

    -- Arrow
    local Arrow = MakeText(
        Card,
        "›",
        28,
        UDim2.new(1, -43, 0, 21),
        Enum.Font.GothamBold,
        Theme.Sub
    )

    Arrow.Size = UDim2.new(0, 30, 0, 35)
    Arrow.TextXAlignment = Enum.TextXAlignment.Center

    -- Hover
    Card.MouseEnter:Connect(function()

        Tween(Card, 0.18, {
            BackgroundColor3 = Theme.CardHover
        }):Play()

        Tween(Icon, 0.18, {
            Size = UDim2.new(0, 62, 0, 62)
        }):Play()

    end)

    Card.MouseLeave:Connect(function()

        Tween(Card, 0.18, {
            BackgroundColor3 = Theme.Card
        }):Play()

        Tween(Icon, 0.18, {
            Size = UDim2.new(0, 58, 0, 58)
        }):Play()

    end)

    -- Click animation
    Card.MouseButton1Click:Connect(function()

        Tween(Card, 0.08, {
            Size = UDim2.new(0.97, 0, 0, 77)
        }):Play()

        task.wait(0.08)

        Tween(Card, 0.15, {
            Size = UDim2.new(1, 0, 0, 80)
        }):Play()

        print("🌙 Lunar Hub:", name)

    end)

    table.insert(Cards, {
        Card = Card,
        Name = name
    })
end

for _, data in ipairs(GameData) do
    CreateGame(data[1], data[2])
end

--==================================================
-- UPDATE PAGE
--==================================================

local UpdatePage = Instance.new("Frame")

UpdatePage.Parent = Content
UpdatePage.Position = UDim2.new(0, 18, 0, 15)
UpdatePage.Size = UDim2.new(1, -36, 1, -25)

UpdatePage.BackgroundColor3 = Theme.Card
UpdatePage.BorderSizePixel = 0
UpdatePage.Visible = false

Corner(UpdatePage, 20)

-- Заголовок НЕ двигаем
MakeText(
    UpdatePage,
    "🔄  Lunar Updates",
    21,
    UDim2.new(0, 22, 0, 22),
    Enum.Font.GothamBold
)

-- Описание обновления опущено ниже
MakeText(
    UpdatePage,
    "🌙 Lunar Hub v32.0\n\n" ..
    "• New compact interface\n" ..
    "• Rounded corners everywhere\n" ..
    "• New category animations\n" ..
    "• Improved search\n" ..
    "• Fixed duplicate categories\n" ..
    "• Improved mobile layout",
    13,
    UDim2.new(0, 22, 0, 80),
    Enum.Font.Gotham,
    Theme.Sub
)

--==================================================
-- SEARCH FILTER
--==================================================

Search:GetPropertyChangedSignal("Text"):Connect(function()

    local query = Search.Text:lower()

    for _, item in ipairs(Cards) do

        local name = item.Name:lower()

        if query == "" then
            item.Card.Visible = true
        else
            item.Card.Visible = name:find(query, 1, true) ~= nil
        end

    end
end)

--==================================================
-- CATEGORY ANIMATION
--==================================================

local function SelectGames()

    GameList.Visible = true
    UpdatePage.Visible = false

    Tween(GamesButton, 0.28, {
        BackgroundColor3 = Theme.PurpleDark
    }):Play()

    Tween(UpdatesButton, 0.28, {
        BackgroundColor3 = Theme.Sidebar
    }):Play()

    GamesButton.TextColor3 = Theme.Text
    UpdatesButton.TextColor3 = Theme.Sub

end

local function SelectUpdates()

    GameList.Visible = false
    UpdatePage.Visible = true

    Tween(UpdatesButton, 0.28, {
        BackgroundColor3 = Theme.PurpleDark
    }):Play()

    Tween(GamesButton, 0.28, {
        BackgroundColor3 = Theme.Sidebar
    }):Play()

    UpdatesButton.TextColor3 = Theme.Text
    GamesButton.TextColor3 = Theme.Sub

end

GamesButton.MouseButton1Click:Connect(function()

    Tween(GamesButton, 0.12, {
        Size = UDim2.new(1, -20, 0, 62)
    }):Play()

    task.wait(0.12)

    Tween(GamesButton, 0.25, {
        Size = UDim2.new(1, -28, 0, 58)
    }):Play()

    SelectGames()

end)

UpdatesButton.MouseButton1Click:Connect(function()

    Tween(UpdatesButton, 0.12, {
        Size = UDim2.new(1, -20, 0, 62)
    }):Play()

    task.wait(0.12)

    Tween(UpdatesButton, 0.25, {
        Size = UDim2.new(1, -28, 0, 58)
    }):Play()

    SelectUpdates()

end)

--==================================================
-- BUTTON HOVER
--==================================================

local function ButtonHover(button)

    local original = button.Size

    button.MouseEnter:Connect(function()

        Tween(button, 0.16, {
            Size = original + UDim2.new(0, 4, 0, 2)
        }):Play()

    end)

    button.MouseLeave:Connect(function()

        Tween(button, 0.16, {
            Size = original
        }):Play()

    end)

end

ButtonHover(Close)
ButtonHover(Minimize)

--==================================================
-- CLOSE ANIMATION
--==================================================

local Closed = false

Close.MouseButton1Click:Connect(function()

    if Closed then
        return
    end

    Closed = true

    Tween(Main, 0.28, {
        Size = UDim2.new(0, 650, 0, 0),
        BackgroundTransparency = 1
    }):Play()

    task.wait(0.3)

    Gui:Destroy()

end)

--==================================================
-- MINIMIZE INTO STRIP
--==================================================

local Minimized = false

Minimize.MouseButton1Click:Connect(function()

    Minimized = not Minimized

    if Minimized then

        -- Прячем всё кроме Header
        Sidebar.Visible = false
        Content.Visible = false

        Tween(Main, 0.35, {
            Size = UDim2.new(0, 500, 0, 82)
        }):Play()

        Minimize.Text = "＋"

    else

        Tween(Main, 0.35, {
            Size = UDim2.new(0, 720, 0, 500)
        }):Play()

        task.wait(0.2)

        Sidebar.Visible = true
        Content.Visible = true

        Minimize.Text = "−"

    end
end)

--==================================================
-- DRAG
--==================================================

local Dragging = false
local DragStart
local StartPosition

Header.InputBegan:Connect(function(input)

    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then

        Dragging = true
        DragStart = input.Position
        StartPosition = Main.Position

    end
end)

UIS.InputChanged:Connect(function(input)

    if not Dragging then
        return
    end

    if input.UserInputType ~= Enum.UserInputType.MouseMovement
        and input.UserInputType ~= Enum.UserInputType.Touch then
        return
    end

    local Delta = input.Position - DragStart

    Main.Position = UDim2.new(
        StartPosition.X.Scale,
        StartPosition.X.Offset + Delta.X,
        StartPosition.Y.Scale,
        StartPosition.Y.Offset + Delta.Y
    )

end)

UIS.InputEnded:Connect(function(input)

    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then

        Dragging = false

    end
end)

--==================================================
-- START ANIMATION
--==================================================

Main.Size = UDim2.new(0, 650, 0, 450)
Main.BackgroundTransparency = 1

Tween(Main, 0.45, {
    Size = UDim2.new(0, 720, 0, 500),
    BackgroundTransparency = 0.03
}):Play()

print("🌙 LUNAR HUB v32.0 LOADED")
