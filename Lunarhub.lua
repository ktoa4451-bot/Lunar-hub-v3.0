--// 🌙 LUNAR HUB v32.0
--// Part 1/2

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local Player = Players.LocalPlayer

--==================================================
-- CONFIG
--==================================================

local CONFIG = {
    Width = 650,
    Height = 510,

    SidebarWidth = 145,
    TopBarHeight = 76,

    Corner = 22,

    AnimationTime = 0.18
}

--==================================================
-- THEME
--==================================================

local Theme = {
    Background = Color3.fromRGB(10, 8, 20),
    Card = Color3.fromRGB(19, 16, 35),
    CardHover = Color3.fromRGB(28, 23, 50),

    Sidebar = Color3.fromRGB(14, 11, 27),

    Accent = Color3.fromRGB(174, 125, 255),
    AccentDark = Color3.fromRGB(125, 82, 205),

    Text = Color3.fromRGB(245, 241, 255),
    Sub = Color3.fromRGB(170, 163, 190),

    Border = Color3.fromRGB(110, 75, 170)
}

--==================================================
-- GAMES
--==================================================

local Games = {
        {
        Name = "prison life",
        Description = "prison life",
        Link = "https://raw.githubusercontent.com/yourhighnesskei/Reformation/refs/heads/main/Loader.lua"
    },
    {
        Name = "lost front",
        Description = "lost front",
        Link = "https://raw.githubusercontent.com/Bac0nHck/Scripts/refs/heads/main/TheLostFront.lua"
    },
    {
        Name = "flick",
        Description = "flick",
        Link = "https://raw.githubusercontent.com/GLAMOHGA/fling/refs/heads/main/ФЛИК%20FLICK.md"
    },
    {
        Name = "Muscle Legends",
        Description = "Muscle Legends",
        Link = "https://raw.githubusercontent.com/2581235867/21/refs/heads/main/By%20Tokattk"
    },
    {
        Name = "Steal the egg ",
        Description = "Steal the egg",
        Link = "https://raw.githubusercontent.com/PulseZax/Loader/refs/heads/main/.lua"
    },
}

--==================================================
-- HELPERS
--==================================================

local function Corner(object, radius)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, radius)
    corner.Parent = object
    return corner
end

local function Stroke(object, color, thickness, transparency)
    local stroke = Instance.new("UIStroke")
    stroke.Color = color
    stroke.Thickness = thickness or 1
    stroke.Transparency = transparency or 0
    stroke.Parent = object
    return stroke
end

local function MakeText(parent, text, size, position, font, color)
    local label = Instance.new("TextLabel")

    label.Parent = parent
    label.BackgroundTransparency = 1

    label.Text = text
    label.TextColor3 = color or Theme.Text
    label.TextSize = size or 14
    label.Font = font or Enum.Font.Gotham

    label.Position = position or UDim2.new()
    label.Size = UDim2.new(1, 0, 0, size + 10)

    label.TextXAlignment = Enum.TextXAlignment.Left
    label.TextYAlignment = Enum.TextYAlignment.Center

    return label
end

--==================================================
-- SCREEN GUI
--==================================================

local ScreenGui = Instance.new("ScreenGui")

ScreenGui.Name = "LunarHub"
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true

ScreenGui.Parent = Player:WaitForChild("PlayerGui")

--==================================================
-- MAIN WINDOW
--==================================================

local Main = Instance.new("Frame")

Main.Name = "Main"
Main.Parent = ScreenGui

Main.Size = UDim2.new(
    0,
    CONFIG.Width,
    0,
    CONFIG.Height
)

Main.Position = UDim2.new(
    0.5,
    -CONFIG.Width / 2,
    0.5,
    -CONFIG.Height / 2
)

Main.BackgroundColor3 = Theme.Background
Main.BorderSizePixel = 0

-- IMPORTANT
Main.ClipsDescendants = true

Corner(Main, CONFIG.Corner)

Stroke(
    Main,
    Theme.Border,
    1.5,
    0.15
)

--==================================================
-- TOP BAR
--==================================================

local TopBar = Instance.new("Frame")

TopBar.Name = "TopBar"
TopBar.Parent = Main

TopBar.Position = UDim2.new(0, 2, 0, 2)

TopBar.Size = UDim2.new(
    1,
    -4,
    0,
    CONFIG.TopBarHeight - 2
)

TopBar.BackgroundColor3 = Theme.Card
TopBar.BorderSizePixel = 0

Corner(TopBar, 18)

--==================================================
-- LOGO
--==================================================

local Logo = MakeText(
    TopBar,
    "🌙",
    30,
    UDim2.new(0, 18, 0, 10),
    Enum.Font.GothamBold
)

Logo.Size = UDim2.new(0, 40, 0, 40)
Logo.TextXAlignment = Enum.TextXAlignment.Center

--==================================================
-- TITLE
--==================================================

local Title = MakeText(
    TopBar,
    "LUNAR HUB",
    20,
    UDim2.new(0, 62, 0, 8),
    Enum.Font.GothamBold
)

Title.Size = UDim2.new(0, 160, 0, 30)

--==================================================
-- VERSION
--==================================================

local Version = MakeText(
    TopBar,
    "v32.0",
    12,
    UDim2.new(0, 63, 0, 38),
    Enum.Font.Gotham
)

Version.Size = UDim2.new(0, 80, 0, 20)
Version.TextColor3 = Theme.Sub

--==================================================
-- SEARCH BOX
--==================================================

local SearchBox = Instance.new("Frame")

SearchBox.Name = "SearchBox"
SearchBox.Parent = TopBar

SearchBox.Position = UDim2.new(
    0,
    230,
    0,
    18
)

SearchBox.Size = UDim2.new(
    1,
    -325,
    0,
    40
)

SearchBox.BackgroundColor3 = Theme.Background
SearchBox.BorderSizePixel = 0

Corner(SearchBox, 12)

Stroke(
    SearchBox,
    Theme.Border,
    1,
    0.35
)

local SearchInput = Instance.new("TextBox")

SearchInput.Name = "SearchInput"
SearchInput.Parent = SearchBox

SearchInput.BackgroundTransparency = 1
SearchInput.BorderSizePixel = 0

SearchInput.Position = UDim2.new(
    0,
    12,
    0,
    0
)

SearchInput.Size = UDim2.new(
    1,
    -24,
    1,
    0
)

SearchInput.ClearTextOnFocus = false

SearchInput.PlaceholderText = "🔍 Search games..."
SearchInput.PlaceholderColor3 = Theme.Sub

SearchInput.Text = ""
SearchInput.TextColor3 = Theme.Text

SearchInput.TextSize = 13
SearchInput.Font = Enum.Font.Gotham

SearchInput.TextXAlignment = Enum.TextXAlignment.Left

--==================================================
-- MINIMIZE
--==================================================

local Minimize = Instance.new("TextButton")

Minimize.Name = "Minimize"
Minimize.Parent = TopBar

Minimize.BackgroundTransparency = 1

Minimize.Position = UDim2.new(
    1,
    -78,
    0,
    16
)

Minimize.Size = UDim2.new(
    0,
    30,
    0,
    30
)

Minimize.Text = "−"
Minimize.TextColor3 = Theme.Text
Minimize.TextSize = 24
Minimize.Font = Enum.Font.GothamBold

--==================================================
-- CLOSE
--==================================================

local Close = Instance.new("TextButton")

Close.Name = "Close"
Close.Parent = TopBar

Close.BackgroundTransparency = 1

Close.Position = UDim2.new(
    1,
    -43,
    0,
    16
)

Close.Size = UDim2.new(
    0,
    30,
    0,
    30
)

Close.Text = "×"
Close.TextColor3 = Theme.Text
Close.TextSize = 25
Close.Font = Enum.Font.GothamBold

--==================================================
-- SIDEBAR
--==================================================

local Sidebar = Instance.new("Frame")

Sidebar.Name = "Sidebar"
Sidebar.Parent = Main

Sidebar.Position = UDim2.new(
    0,
    2,
    0,
    CONFIG.TopBarHeight
)

Sidebar.Size = UDim2.new(
    0,
    CONFIG.SidebarWidth - 2,
    1,
    -CONFIG.TopBarHeight - 2
)

Sidebar.BackgroundColor3 = Theme.Sidebar
Sidebar.BorderSizePixel = 0

Corner(Sidebar, 18)

--==================================================
-- GAMES BUTTON
--==================================================

local GamesButton = Instance.new("TextButton")

GamesButton.Name = "GamesButton"
GamesButton.Parent = Sidebar

GamesButton.Position = UDim2.new(
    0,
    10,
    0,
    20
)

GamesButton.Size = UDim2.new(
    1,
    -20,
    0,
    46
)

GamesButton.BackgroundColor3 = Theme.Card
GamesButton.BorderSizePixel = 0

GamesButton.Text = "🎮  Games"
GamesButton.TextColor3 = Theme.Text
GamesButton.TextSize = 14
GamesButton.Font = Enum.Font.GothamBold

GamesButton.TextXAlignment = Enum.TextXAlignment.Left

Corner(GamesButton, 12)

--==================================================
-- UPDATES BUTTON
--==================================================

local UpdatesButton = Instance.new("TextButton")

UpdatesButton.Name = "UpdatesButton"
UpdatesButton.Parent = Sidebar

UpdatesButton.Position = UDim2.new(
    0,
    10,
    0,
    76
)

UpdatesButton.Size = UDim2.new(
    1,
    -20,
    0,
    46
)

UpdatesButton.BackgroundColor3 = Theme.Sidebar
UpdatesButton.BorderSizePixel = 0

UpdatesButton.Text = "🔄  Updates"
UpdatesButton.TextColor3 = Theme.Sub
UpdatesButton.TextSize = 14
UpdatesButton.Font = Enum.Font.GothamBold

UpdatesButton.TextXAlignment = Enum.TextXAlignment.Left

Corner(UpdatesButton, 12)

--==================================================
-- CONTENT
--==================================================

local Content = Instance.new("Frame")

Content.Name = "Content"
Content.Parent = Main

Content.Position = UDim2.new(
    0,
    CONFIG.SidebarWidth,
    0,
    CONFIG.TopBarHeight
)

Content.Size = UDim2.new(
    1,
    -CONFIG.SidebarWidth - 2,
    1,
    -CONFIG.TopBarHeight - 2
)

Content.BackgroundColor3 = Theme.Background
Content.BorderSizePixel = 0

Corner(Content, 18)

--==================================================
-- GAME PAGE
--==================================================

local GamePage = Instance.new("Frame")

GamePage.Name = "GamePage"
GamePage.Parent = Content

GamePage.Position = UDim2.new(
    0,
    18,
    0,
    15
)

GamePage.Size = UDim2.new(
    1,
    -36,
    1,
    -25
)

GamePage.BackgroundColor3 = Theme.Card
GamePage.BorderSizePixel = 0

Corner(GamePage, 18)

--==================================================
-- GAME SCROLL
--==================================================

local GameScroll = Instance.new("ScrollingFrame")

GameScroll.Name = "GameScroll"
GameScroll.Parent = GamePage

GameScroll.Position = UDim2.new(
    0,
    12,
    0,
    12
)

GameScroll.Size = UDim2.new(
    1,
    -24,
    1,
    -24
)

GameScroll.BackgroundTransparency = 1
GameScroll.BorderSizePixel = 0

GameScroll.ScrollBarThickness = 3
GameScroll.ScrollBarImageColor3 = Theme.Accent

GameScroll.CanvasSize = UDim2.new(
    0,
    0,
    0,
    0
)

GameScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y

GameScroll.ScrollingDirection = Enum.ScrollingDirection.Y

--==================================================
-- LIST LAYOUT
--==================================================

local GameLayout = Instance.new("UIListLayout")

GameLayout.Parent = GameScroll

GameLayout.Padding = UDim.new(
    0,
    10
)

GameLayout.SortOrder = Enum.SortOrder.LayoutOrder

--==================================================
-- PADDING
--==================================================

local GamePadding = Instance.new("UIPadding")

GamePadding.Parent = GameScroll

GamePadding.PaddingTop = UDim.new(
    0,
    2
)

GamePadding.PaddingBottom = UDim.new(
    0,
    5
)

GamePadding.PaddingLeft = UDim.new(
    0,
    2
)

GamePadding.PaddingRight = UDim.new(
    0,
    2
)

--==================================================
-- PART 1 END
--==================================================

--// 🌙 LUNAR HUB v32.0
--// Part 2/2

--==================================================
-- CREATE GAME CARD
--==================================================

local function CreateGameCard(gameData, order)
    local Card = Instance.new("TextButton")

    Card.Name = gameData.Name
    Card.Parent = GameScroll

    Card.Size = UDim2.new(
        1,
        0,
        0,
        70
    )

    Card.BackgroundColor3 = Theme.Background
    Card.BorderSizePixel = 0

    Card.Text = ""

    Card.AutoButtonColor = false

    Card.LayoutOrder = order

    Corner(Card, 14)

    local CardStroke = Stroke(
        Card,
        Theme.Border,
        1,
        0.55
    )

    -- Moon
    local Moon = MakeText(
        Card,
        "🌙",
        25,
        UDim2.new(0, 14, 0, 12),
        Enum.Font.GothamBold
    )

    Moon.Size = UDim2.new(
        0,
        38,
        0,
        42
    )

    Moon.TextXAlignment = Enum.TextXAlignment.Center

    -- Name
    local Name = MakeText(
        Card,
        gameData.Name,
        15,
        UDim2.new(0, 58, 0, 8),
        Enum.Font.GothamBold
    )

    Name.Size = UDim2.new(
        1,
        -105,
        0,
        25
    )

    -- Description
    local Description = MakeText(
        Card,
        gameData.Description or "Lunar Hub game",
        11,
        UDim2.new(0, 58, 0, 34),
        Enum.Font.Gotham
    )

    Description.Size = UDim2.new(
        1,
        -105,
        0,
        22
    )

    Description.TextColor3 = Theme.Sub

    -- Arrow
    local Arrow = MakeText(
        Card,
        "›",
        27,
        UDim2.new(
            1,
            -42,
            0,
            17
        ),
        Enum.Font.GothamBold
    )

    Arrow.Size = UDim2.new(
        0,
        30,
        0,
        35
    )

    Arrow.TextXAlignment = Enum.TextXAlignment.Center

    Arrow.TextColor3 = Theme.Sub

    --==================================================
    -- HOVER
    --==================================================

    Card.MouseEnter:Connect(function()
        TweenService:Create(
            Card,
            TweenInfo.new(
                CONFIG.AnimationTime,
                Enum.EasingStyle.Quad,
                Enum.EasingDirection.Out
            ),
            {
                BackgroundColor3 = Theme.CardHover
            }
        ):Play()

        TweenService:Create(
            CardStroke,
            TweenInfo.new(CONFIG.AnimationTime),
            {
                Transparency = 0.05
            }
        ):Play()

        TweenService:Create(
            Arrow,
            TweenInfo.new(CONFIG.AnimationTime),
            {
                TextColor3 = Theme.Accent,
                Position = UDim2.new(
                    1,
                    -38,
                    0,
                    17
                )
            }
        ):Play()
    end)

    Card.MouseLeave:Connect(function()
        TweenService:Create(
            Card,
            TweenInfo.new(
                CONFIG.AnimationTime,
                Enum.EasingStyle.Quad,
                Enum.EasingDirection.Out
            ),
            {
                BackgroundColor3 = Theme.Background
            }
        ):Play()

        TweenService:Create(
            CardStroke,
            TweenInfo.new(CONFIG.AnimationTime),
            {
                Transparency = 0.55
            }
        ):Play()

        TweenService:Create(
            Arrow,
            TweenInfo.new(CONFIG.AnimationTime),
            {
                TextColor3 = Theme.Sub,
                Position = UDim2.new(
                    1,
                    -42,
                    0,
                    17
                )
            }
        ):Play()
    end)

    --==================================================
    -- CLICK
    --==================================================

    Card.MouseButton1Click:Connect(function()
        if not gameData.Link or gameData.Link == "" then
            warn("Lunar Hub: Link отсутствует для " .. gameData.Name)
            return
        end

        local success, result = pcall(function()
            local source = game:HttpGet(gameData.Link)
            local func = loadstring(source)

            if not func then
                error("loadstring вернул nil")
            end

            return func()
        end)

        if not success then
            warn(
                "Lunar Hub: ошибка запуска " ..
                gameData.Name ..
                ": " ..
                tostring(result)
            )
        end
    end)

    return Card
end

--==================================================
-- CREATE ALL GAMES
--==================================================

for index, gameData in ipairs(Games) do
    CreateGameCard(gameData, index)
end

--==================================================
-- SEARCH
--==================================================

local function UpdateSearch()
    local query = string.lower(
        SearchInput.Text or ""
    )

    for _, card in ipairs(GameScroll:GetChildren()) do
        if card:IsA("TextButton") then

            local name = string.lower(
                card.Name
            )

            if query == "" or string.find(
                name,
                query,
                1,
                true
            ) then
                card.Visible = true
            else
                card.Visible = false
            end
        end
    end
end

SearchInput:GetPropertyChangedSignal(
    "Text"
):Connect(UpdateSearch)

--==================================================
-- UPDATE PAGE
--==================================================

local UpdatePage = Instance.new("Frame")

UpdatePage.Name = "UpdatePage"
UpdatePage.Parent = Content

UpdatePage.Position = UDim2.new(
    0,
    18,
    0,
    15
)

UpdatePage.Size = UDim2.new(
    1,
    -36,
    1,
    -25
)

UpdatePage.BackgroundColor3 = Theme.Card
UpdatePage.BorderSizePixel = 0

UpdatePage.Visible = false

Corner(UpdatePage, 18)

-- Title
local UpdateTitle = MakeText(
    UpdatePage,
    "🔄  Lunar Updates",
    21,
    UDim2.new(0, 22, 0, 22),
    Enum.Font.GothamBold
)

UpdateTitle.Size = UDim2.new(
    1,
    -44,
    0,
    35
)

-- Description
local UpdateText = MakeText(
    UpdatePage,

    "🌙 Lunar Hub v32.0\n\n" ..

    "• New compact interface\n" ..
    "• Rounded corners everywhere\n" ..
    "• New category animations\n" ..
    "• Improved search\n" ..
    "• Fixed duplicate categories\n" ..
    "• Improved mobile layout",

    13,

    UDim2.new(
        0,
        22,
        0,
        95
    ),

    Enum.Font.Gotham
)

UpdateText.Size = UDim2.new(
    1,
    -44,
    0,
    220
)

UpdateText.TextColor3 = Theme.Sub

UpdateText.TextWrapped = true

UpdateText.TextYAlignment =
    Enum.TextYAlignment.Top

--==================================================
-- PAGE SWITCH
--==================================================

local CurrentPage = "Games"

local function SwitchPage(page)
    CurrentPage = page

    if page == "Games" then

        GamePage.Visible = true
        UpdatePage.Visible = false

        GamesButton.BackgroundColor3 =
            Theme.Card

        GamesButton.TextColor3 =
            Theme.Text

        UpdatesButton.BackgroundColor3 =
            Theme.Sidebar

        UpdatesButton.TextColor3 =
            Theme.Sub

        SearchBox.Visible = true

    elseif page == "Updates" then

        GamePage.Visible = false
        UpdatePage.Visible = true

        GamesButton.BackgroundColor3 =
            Theme.Sidebar

        GamesButton.TextColor3 =
            Theme.Sub

        UpdatesButton.BackgroundColor3 =
            Theme.Card

        UpdatesButton.TextColor3 =
            Theme.Text

        SearchBox.Visible = false
    end
end

--==================================================
-- CATEGORY BUTTONS
--==================================================

GamesButton.MouseButton1Click:Connect(function()
    SwitchPage("Games")
end)

UpdatesButton.MouseButton1Click:Connect(function()
    SwitchPage("Updates")
end)

--==================================================
-- BUTTON HOVER
--==================================================

local function ButtonHover(button)
    button.MouseEnter:Connect(function()
        if CurrentPage == "Games" and
            button == GamesButton then
            return
        end

        if CurrentPage == "Updates" and
            button == UpdatesButton then
            return
        end

        TweenService:Create(
            button,
            TweenInfo.new(
                CONFIG.AnimationTime
            ),
            {
                BackgroundColor3 =
                    Theme.CardHover
            }
        ):Play()
    end)

    button.MouseLeave:Connect(function()

        local active =
            (CurrentPage == "Games" and
            button == GamesButton)
            or
            (CurrentPage == "Updates" and
            button == UpdatesButton)

        if active then
            return
        end

        TweenService:Create(
            button,
            TweenInfo.new(
                CONFIG.AnimationTime
            ),
            {
                BackgroundColor3 =
                    Theme.Sidebar
            }
        ):Play()
    end)
end

ButtonHover(GamesButton)
ButtonHover(UpdatesButton)

--==================================================
-- MINIMIZE
--==================================================

local Minimized = false

local function SetMinimized(state)
    Minimized = state

    if state then

        GamePage.Visible = false
        UpdatePage.Visible = false
        Sidebar.Visible = false
        SearchBox.Visible = false

        TweenService:Create(
            Main,
            TweenInfo.new(
                0.25,
                Enum.EasingStyle.Quart,
                Enum.EasingDirection.Out
            ),
            {
                Size = UDim2.new(
                    0,
                    CONFIG.Width,
                    0,
                    CONFIG.TopBarHeight
                )
            }
        ):Play()

        Minimize.Text = "+"

    else

        TweenService:Create(
            Main,
            TweenInfo.new(
                0.25,
                Enum.EasingStyle.Quart,
                Enum.EasingDirection.Out
            ),
            {
                Size = UDim2.new(
                    0,
                    CONFIG.Width,
                    0,
                    CONFIG.Height
                )
            }
        ):Play()

        task.delay(0.12, function()

            if Minimized then
                return
            end

            Sidebar.Visible = true

            if CurrentPage == "Games" then
                GamePage.Visible = true
                UpdatePage.Visible = false
                SearchBox.Visible = true
            else
                GamePage.Visible = false
                UpdatePage.Visible = true
                SearchBox.Visible = false
            end
        end)

        Minimize.Text = "−"
    end
end

Minimize.MouseButton1Click:Connect(function()
    SetMinimized(not Minimized)
end)

--==================================================
-- CLOSE
--==================================================

Close.MouseButton1Click:Connect(function()

    local tween = TweenService:Create(
        Main,
        TweenInfo.new(
            0.2,
            Enum.EasingStyle.Quad,
            Enum.EasingDirection.In
        ),
        {
            Size = UDim2.new(
                0,
                CONFIG.Width - 30,
                0,
                CONFIG.Height - 30
            ),

            BackgroundTransparency = 1
        }
    )

    tween:Play()

    task.delay(
        0.2,
        function()
            ScreenGui:Destroy()
        end
    )
end)

--==================================================
-- DRAG SYSTEM
--==================================================

local Dragging = false
local DragStart
local StartPosition

local function IsBlockedObject(object)
    if not object then
        return false
    end

    if object == SearchBox
        or object == SearchInput
        or object == GamesButton
        or object == UpdatesButton
        or object == Minimize
        or object == Close then
        return true
    end

    for _, gameData in ipairs(
        GameScroll:GetChildren()
    ) do
        if object == gameData
            or object:IsDescendantOf(gameData) then
            return true
        end
    end

    return false
end

TopBar.InputBegan:Connect(function(
    input
)

    if input.UserInputType ==
        Enum.UserInputType.MouseButton1
        or input.UserInputType ==
        Enum.UserInputType.Touch then

        local objects =
            ScreenGui:GetGuiObjectsAtPosition(
                input.Position.X,
                input.Position.Y
            )

        for _, object in ipairs(objects) do
            if IsBlockedObject(object) then
                return
            end
        end

        Dragging = true

        DragStart = input.Position

        StartPosition = Main.Position
    end
end)

UserInputService.InputChanged:Connect(
    function(input)

        if not Dragging then
            return
        end

        if input.UserInputType ==
            Enum.UserInputType.MouseMovement
            or input.UserInputType ==
            Enum.UserInputType.Touch then

            local Delta =
                input.Position - DragStart

            Main.Position = UDim2.new(
                StartPosition.X.Scale,
                StartPosition.X.Offset + Delta.X,

                StartPosition.Y.Scale,
                StartPosition.Y.Offset + Delta.Y
            )
        end
    end
)

UserInputService.InputEnded:Connect(
    function(input)

        if input.UserInputType ==
            Enum.UserInputType.MouseButton1
            or input.UserInputType ==
            Enum.UserInputType.Touch then

            Dragging = false
        end
    end
)

--==================================================
-- INITIAL STATE
--==================================================

SwitchPage("Games")

Main.Visible = true

-- небольшая анимация появления
Main.BackgroundTransparency = 1

task.spawn(function()

    TweenService:Create(
        Main,
        TweenInfo.new(
            0.3,
            Enum.EasingStyle.Quart,
            Enum.EasingDirection.Out
        ),
        {
            BackgroundTransparency = 0
        }
    ):Play()

end)

print("🌙 Lunar Hub v32.0 loaded!")
