--// 🌙 LUNAR HUB v32.0
--// LINK GAME SYSTEM
--// PART 1 / 3

--==================================================
-- SERVICES
--==================================================

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")

local LocalPlayer = Players.LocalPlayer

--==================================================
-- CONFIG
--==================================================

local CONFIG = {
    Name = "LunarHub",
    Title = "LUNAR HUB",
    Version = "v32.0",

    Width = 720,
    Height = 510,

    SidebarWidth = 165,
    TopBarHeight = 76,

    Corner = 20,
}

--==================================================
-- THEME
--==================================================

local Theme = {
    Background = Color3.fromRGB(10, 8, 20),
    Main = Color3.fromRGB(14, 11, 28),

    Sidebar = Color3.fromRGB(17, 13, 34),
    Card = Color3.fromRGB(22, 17, 43),
    CardHover = Color3.fromRGB(31, 24, 58),

    Accent = Color3.fromRGB(167, 108, 255),
    AccentDark = Color3.fromRGB(104, 65, 175),

    Text = Color3.fromRGB(245, 240, 255),
    Sub = Color3.fromRGB(165, 155, 190),

    Border = Color3.fromRGB(101, 67, 160),
}

--==================================================
-- GAME DATA
--==================================================

local Games = {

    {
        Name = "Forsaken",
        Description = "Forsaken script",
        Link = "https://raw.githubusercontent.com/ktoa4451-bot/Lunar-hub-v3.0/main/Games/Forsaken.lua"
    },

    {
        Name = "MM2",
        Description = "Murder Mystery 2",
        Link = "https://raw.githubusercontent.com/ktoa4451-bot/Lunar-hub-v3.0/main/Games/MM2.lua"
    },

    {
        Name = "Rivals",
        Description = "Rivals script",
        Link = "https://raw.githubusercontent.com/ktoa4451-bot/Lunar-hub-v3.0/main/Games/Rivals.lua"
    },

    {
        Name = "Slap Battles",
        Description = "Slap Battles script",
        Link = "https://raw.githubusercontent.com/ktoa4451-bot/Lunar-hub-v3.0/main/Games/SlapBattles.lua"
    },

    {
        Name = "King Legacy",
        Description = "King Legacy script",
        Link = "https://raw.githubusercontent.com/ktoa4451-bot/Lunar-hub-v3.0/main/Games/KingLegacy.lua"
    },

    {
        Name = "1+ Speed Keyboard",
        Description = "Speed Keyboard script",
        Link = "https://raw.githubusercontent.com/ktoa4451-bot/Lunar-hub-v3.0/main/Games/SpeedKeyboard.lua"
    },

    {
        Name = "Merge Nuke",
        Description = "Merge Nuke script",
        Link = "https://raw.githubusercontent.com/ktoa4451-bot/Lunar-hub-v3.0/main/Games/MergeNuke.lua"
    },

    {
        Name = "MorphUp",
        Description = "MorphUp script",
        Link = "https://raw.githubusercontent.com/ktoa4451-bot/Lunar-hub-v3.0/main/Games/MorphUp.lua"
    },

    {
        Name = "1 Magic Evolution",
        Description = "Magic Evolution script",
        Link = "https://raw.githubusercontent.com/ktoa4451-bot/Lunar-hub-v3.0/main/Games/1MagicEvolution.lua"
    },

    {
        Name = "99 Nights in Forest",
        Description = "99 Nights in the Forest",
        Link = "https://raw.githubusercontent.com/ktoa4451-bot/Lunar-hub-v3.0/main/Games/99Nights.lua"
    },

    {
        Name = "Survive Zombie Arena",
        Description = "Zombie Arena script",
        Link = "https://raw.githubusercontent.com/ktoa4451-bot/Lunar-hub-v3.0/main/Games/SurviveZombieArena.lua"
    },

    {
        Name = "Color or Die",
        Description = "Color or Die script",
        Link = "https://raw.githubusercontent.com/ktoa4451-bot/Lunar-hub-v3.0/main/Games/ColorOrDie.lua"
    },

    {
        Name = "Rost Alpha Premium",
        Description = "Rost Alpha Premium",
        Link = "https://raw.githubusercontent.com/ktoa4451-bot/Lunar-hub-v3.0/main/Games/RostAlpha.lua"
    },

    {
        Name = "Prison Life Premium",
        Description = "Prison Life Premium",
        Link = "https://raw.githubusercontent.com/ktoa4451-bot/Lunar-hub-v3.0/main/Games/PrisonLife.lua"
    },

}

--==================================================
-- REMOVE OLD GUI
--==================================================

pcall(function()
    local old = CoreGui:FindFirstChild(CONFIG.Name)

    if old then
        old:Destroy()
    end
end)

--==================================================
-- HELPERS
--==================================================

local function Create(className, properties)
    local object = Instance.new(className)

    for property, value in pairs(properties or {}) do
        object[property] = value
    end

    return object
end

local function Corner(parent, radius)
    local corner = Instance.new("UICorner")

    corner.CornerRadius = UDim.new(
        0,
        radius or CONFIG.Corner
    )

    corner.Parent = parent

    return corner
end

local function Stroke(parent, color, thickness, transparency)
    local stroke = Instance.new("UIStroke")

    stroke.Color = color or Theme.Border
    stroke.Thickness = thickness or 1
    stroke.Transparency = transparency or 0

    stroke.Parent = parent

    return stroke
end

local function Tween(object, time, properties)
    local tween = TweenService:Create(
        object,
        TweenInfo.new(
            time or 0.15,
            Enum.EasingStyle.Quad,
            Enum.EasingDirection.Out
        ),
        properties
    )

    tween:Play()

    return tween
end

local function MakeText(
    parent,
    text,
    size,
    position,
    font,
    color
)
    local label = Instance.new("TextLabel")

    label.Parent = parent
    label.BackgroundTransparency = 1

    label.Text = text
    label.TextSize = size or 14
    label.Font = font or Enum.Font.Gotham
    label.TextColor3 = color or Theme.Text

    label.Position = position or UDim2.new()
    label.Size = UDim2.new(
        1,
        0,
        0,
        (size or 14) + 10
    )

    label.TextXAlignment = Enum.TextXAlignment.Left
    label.TextYAlignment = Enum.TextYAlignment.Center

    return label
end

--==================================================
-- GUI PARENT
--==================================================

local GuiParent

pcall(function()
    if gethui then
        GuiParent = gethui()
    end
end)

if not GuiParent then
    GuiParent = CoreGui
end

--==================================================
-- SCREEN GUI
--==================================================

local ScreenGui = Create("ScreenGui", {
    Name = CONFIG.Name,

    Parent = GuiParent,

    ResetOnSpawn = false,
    IgnoreGuiInset = true,

    ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
})

--==================================================
-- MAIN WINDOW
--==================================================

local Main = Create("Frame", {
    Name = "Main",

    Parent = ScreenGui,

    AnchorPoint = Vector2.new(0.5, 0.5),

    Position = UDim2.new(
        0.5,
        0,
        0.5,
        0
    ),

    Size = UDim2.new(
        0,
        CONFIG.Width,
        0,
        CONFIG.Height
    ),

    BackgroundColor3 = Theme.Background,

    BorderSizePixel = 0,

    ZIndex = 2,
})

Corner(Main, CONFIG.Corner)

local MainStroke = Stroke(
    Main,
    Theme.Border,
    1.5,
    0.15
)

--==================================================
-- GLOW
--==================================================

local Glow = Create("ImageLabel", {
    Name = "Glow",

    Parent = Main,

    BackgroundTransparency = 1,

    AnchorPoint = Vector2.new(0.5, 0.5),

    Position = UDim2.new(
        0.5,
        0,
        0.5,
        0
    ),

    Size = UDim2.new(
        1,
        45,
        1,
        45
    ),

    Image = "rbxassetid://5028857084",

    ImageColor3 = Theme.Accent,

    ImageTransparency = 0.9,

    ScaleType = Enum.ScaleType.Slice,

    SliceCenter = Rect.new(
        24,
        24,
        276,
        276
    ),

    ZIndex = 1,
})

--==================================================
-- TOP BAR
--==================================================

local TopBar = Create("Frame", {
    Name = "TopBar",

    Parent = Main,

    Position = UDim2.new(
        0,
        0,
        0,
        0
    ),

    Size = UDim2.new(
        1,
        0,
        0,
        CONFIG.TopBarHeight
    ),

    BackgroundColor3 = Theme.Main,

    BorderSizePixel = 0,

    ZIndex = 5,
})

Corner(TopBar, CONFIG.Corner)

--==================================================
-- LOGO
--==================================================

local Logo = MakeText(
    TopBar,
    "🌙",
    27,
    UDim2.new(0, 18, 0, 8),
    Enum.Font.GothamBold,
    Theme.Text
)

Logo.Size = UDim2.new(
    0,
    42,
    0,
    45
)

Logo.TextXAlignment =
    Enum.TextXAlignment.Center

--==================================================
-- TITLE
--==================================================

local Title = MakeText(
    TopBar,
    CONFIG.Title,
    20,
    UDim2.new(0, 62, 0, 7),
    Enum.Font.GothamBold,
    Theme.Text
)

Title.Size = UDim2.new(
    0,
    150,
    0,
    32
)

--==================================================
-- VERSION
--==================================================

local VersionText = MakeText(
    TopBar,
    CONFIG.Version,
    11,
    UDim2.new(0, 63, 0, 38),
    Enum.Font.GothamMedium,
    Theme.Accent
)

VersionText.Size = UDim2.new(
    0,
    100,
    0,
    20
)

--==================================================
-- SEARCH
--==================================================

local SearchBox = Create("Frame", {
    Name = "SearchBox",

    Parent = TopBar,

    Position = UDim2.new(
        0,
        250,
        0,
        19
    ),

    Size = UDim2.new(
        0,
        250,
        0,
        38
    ),

    BackgroundColor3 = Theme.Card,

    BorderSizePixel = 0,

    ZIndex = 10,
})

Corner(SearchBox, 12)

Stroke(
    SearchBox,
    Theme.Border,
    1,
    0.45
)

local SearchIcon = MakeText(
    SearchBox,
    "🔍",
    15,
    UDim2.new(0, 10, 0, 0),
    Enum.Font.Gotham
)

SearchIcon.Size = UDim2.new(
    0,
    28,
    1,
    0
)

SearchIcon.TextXAlignment =
    Enum.TextXAlignment.Center

local SearchInput = Create("TextBox", {
    Name = "SearchInput",

    Parent = SearchBox,

    Position = UDim2.new(
        0,
        40,
        0,
        0
    ),

    Size = UDim2.new(
        1,
        -48,
        1,
        0
    ),

    BackgroundTransparency = 1,

    Text = "",

    PlaceholderText = "Search games...",

    PlaceholderColor3 = Theme.Sub,

    TextColor3 = Theme.Text,

    TextSize = 13,

    Font = Enum.Font.Gotham,

    ClearTextOnFocus = false,

    TextXAlignment = Enum.TextXAlignment.Left,

    ZIndex = 11,
})

--==================================================
-- MINIMIZE
--==================================================

local MinimizeButton = Create("TextButton", {
    Name = "Minimize",

    Parent = TopBar,

    Position = UDim2.new(
        1,
        -78,
        0,
        18
    ),

    Size = UDim2.new(
        0,
        30,
        0,
        30
    ),

    BackgroundColor3 = Theme.Card,

    Text = "−",

    TextColor3 = Theme.Text,

    TextSize = 19,

    Font = Enum.Font.GothamBold,

    AutoButtonColor = false,

    ZIndex = 20,
})

Corner(MinimizeButton, 9)

--==================================================
-- CLOSE
--==================================================

local CloseButton = Create("TextButton", {
    Name = "Close",

    Parent = TopBar,

    Position = UDim2.new(
        1,
        -42,
        0,
        18
    ),

    Size = UDim2.new(
        0,
        30,
        0,
        30
    ),

    BackgroundColor3 = Theme.Card,

    Text = "×",

    TextColor3 = Theme.Text,

    TextSize = 19,

    Font = Enum.Font.GothamBold,

    AutoButtonColor = false,

    ZIndex = 20,
})

Corner(CloseButton, 9)

--==================================================
-- SIDEBAR
--==================================================

local Sidebar = Create("Frame", {
    Name = "Sidebar",

    Parent = Main,

    Position = UDim2.new(
        0,
        0,
        0,
        CONFIG.TopBarHeight
    ),

    Size = UDim2.new(
        0,
        CONFIG.SidebarWidth,
        1,
        -CONFIG.TopBarHeight
    ),

    BackgroundColor3 = Theme.Sidebar,

    BorderSizePixel = 0,

    ZIndex = 4,
})

--==================================================
-- CATEGORY TITLE
--==================================================

local CategoryTitle = MakeText(
    Sidebar,
    "CATEGORIES",
    10,
    UDim2.new(0, 18, 0, 18),
    Enum.Font.GothamBold,
    Theme.Sub
)

CategoryTitle.Size = UDim2.new(
    1,
    -36,
    0,
    25
)

--==================================================
-- GAMES BUTTON
--==================================================

local GamesButton = Create("TextButton", {
    Name = "GamesButton",

    Parent = Sidebar,

    Position = UDim2.new(
        0,
        10,
        0,
        55
    ),

    Size = UDim2.new(
        1,
        -20,
        0,
        43
    ),

    BackgroundColor3 = Theme.AccentDark,

    Text = "🎮  Games",

    TextColor3 = Theme.Text,

    TextSize = 13,

    Font = Enum.Font.GothamBold,

    TextXAlignment = Enum.TextXAlignment.Left,

    AutoButtonColor = false,

    ZIndex = 10,
})

Corner(GamesButton, 11)

local GamesPadding = Instance.new("UIPadding")
GamesPadding.Parent = GamesButton
GamesPadding.PaddingLeft = UDim.new(0, 13)

--==================================================
-- UPDATES BUTTON
--==================================================

local UpdatesButton = Create("TextButton", {
    Name = "UpdatesButton",

    Parent = Sidebar,

    Position = UDim2.new(
        0,
        10,
        0,
        105
    ),

    Size = UDim2.new(
        1,
        -20,
        0,
        43
    ),

    BackgroundColor3 = Theme.Card,

    Text = "🔄  Updates",

    TextColor3 = Theme.Sub,

    TextSize = 13,

    Font = Enum.Font.GothamMedium,

    TextXAlignment = Enum.TextXAlignment.Left,

    AutoButtonColor = false,

    ZIndex = 10,
})

Corner(UpdatesButton, 11)

local UpdatesPadding = Instance.new("UIPadding")
UpdatesPadding.Parent = UpdatesButton
UpdatesPadding.PaddingLeft = UDim.new(0, 13)

--==================================================
-- CONTENT
--==================================================

local Content = Create("Frame", {
    Name = "Content",

    Parent = Main,

    Position = UDim2.new(
        0,
        CONFIG.SidebarWidth,
        0,
        CONFIG.TopBarHeight
    ),

    Size = UDim2.new(
        1,
        -CONFIG.SidebarWidth,
        1,
        -CONFIG.TopBarHeight
    ),

    BackgroundColor3 = Theme.Main,

    BorderSizePixel = 0,

    ZIndex = 3,
})

--==================================================
-- GAME PAGE
--==================================================

local GamePage = Create("Frame", {
    Name = "GamePage",

    Parent = Content,

    Position = UDim2.new(
        0,
        14,
        0,
        14
    ),

    Size = UDim2.new(
        1,
        -28,
        1,
        -24
    ),

    BackgroundColor3 = Theme.Card,

    BorderSizePixel = 0,

    Visible = true,

    ZIndex = 4,
})

Corner(GamePage, 18)

--==================================================
-- GAME TITLE
--==================================================

local GameTitle = MakeText(
    GamePage,
    "🎮  Games",
    20,
    UDim2.new(0, 20, 0, 13),
    Enum.Font.GothamBold,
    Theme.Text
)

GameTitle.Size = UDim2.new(
    1,
    -40,
    0,
    35
)

--==================================================
-- GAME SCROLL
--==================================================

local GameScroll = Create("ScrollingFrame", {
    Name = "GameScroll",

    Parent = GamePage,

    Position = UDim2.new(
        0,
        15,
        0,
        55
    ),

    Size = UDim2.new(
        1,
        -30,
        1,
        -65
    ),

    BackgroundTransparency = 1,

    BorderSizePixel = 0,

    ScrollBarThickness = 3,

    ScrollBarImageColor3 = Theme.Accent,

    CanvasSize = UDim2.new(
        0,
        0,
        0,
        0
    ),

    AutomaticCanvasSize = Enum.AutomaticSize.Y,

    ScrollingDirection = Enum.ScrollingDirection.Y,

    ZIndex = 5,
})

--==================================================
-- GAME LIST
--==================================================

local GameList = Create("UIListLayout", {
    Parent = GameScroll,

    Padding = UDim.new(
        0,
        9
    ),

    SortOrder = Enum.SortOrder.LayoutOrder,
})

GameList.HorizontalAlignment =
    Enum.HorizontalAlignment.Center

--==================================================
-- END PART 1 / 3
--==================================================

--==================================================
-- 🌙 LUNAR HUB v32.0
-- PART 2 / 3
--==================================================

--==================================================
-- GAME CARD CREATOR
--==================================================

local GameCards = {}

local function CreateGameCard(gameData, index)

    local Card = Create("TextButton", {
        Name = "Game_" .. tostring(index),

        Parent = GameScroll,

        Size = UDim2.new(
            1,
            -5,
            0,
            64
        ),

        BackgroundColor3 = Theme.Main,

        BorderSizePixel = 0,

        Text = "",

        AutoButtonColor = false,

        LayoutOrder = index,

        ZIndex = 6,
    })

    Corner(Card, 14)

    local CardStroke = Stroke(
        Card,
        Theme.Border,
        1,
        0.65
    )

    --==================================================
    -- MOON
    --==================================================

    local Moon = MakeText(
        Card,
        "🌙",
        21,
        UDim2.new(0, 10, 0, 8),
        Enum.Font.GothamBold,
        Theme.Text
    )

    Moon.Size = UDim2.new(
        0,
        40,
        0,
        45
    )

    Moon.TextXAlignment =
        Enum.TextXAlignment.Center

    --==================================================
    -- NAME
    --==================================================

    local Name = MakeText(
        Card,
        gameData.Name or "Unknown Game",
        14,
        UDim2.new(0, 58, 0, 7),
        Enum.Font.GothamBold,
        Theme.Text
    )

    Name.Size = UDim2.new(
        1,
        -115,
        0,
        24
    )

    Name.TextTruncate =
        Enum.TextTruncate.AtEnd

    --==================================================
    -- DESCRIPTION
    --==================================================

    local Description = MakeText(
        Card,
        gameData.Description or "No description",
        11,
        UDim2.new(0, 58, 0, 32),
        Enum.Font.Gotham,
        Theme.Sub
    )

    Description.Size = UDim2.new(
        1,
        -115,
        0,
        20
    )

    Description.TextTruncate =
        Enum.TextTruncate.AtEnd

    --==================================================
    -- ARROW
    --==================================================

    local Arrow = MakeText(
        Card,
        "›",
        27,
        UDim2.new(
            1,
            -47,
            0,
            8
        ),
        Enum.Font.GothamMedium,
        Theme.Sub
    )

    Arrow.Size = UDim2.new(
        0,
        35,
        0,
        45
    )

    Arrow.TextXAlignment =
        Enum.TextXAlignment.Center

    --==================================================
    -- HOVER ON
    --==================================================

    Card.MouseEnter:Connect(function()

        Tween(
            Card,
            0.15,
            {
                BackgroundColor3 =
                    Theme.CardHover
            }
        )

        Tween(
            CardStroke,
            0.15,
            {
                Transparency = 0.15
            }
        )

        Tween(
            Arrow,
            0.15,
            {
                TextColor3 =
                    Theme.Accent
            }
        )

        Tween(
            Moon,
            0.15,
            {
                TextColor3 =
                    Theme.Accent
            }
        )
    end)

    --==================================================
    -- HOVER OFF
    --==================================================

    Card.MouseLeave:Connect(function()

        Tween(
            Card,
            0.15,
            {
                BackgroundColor3 =
                    Theme.Main
            }
        )

        Tween(
            CardStroke,
            0.15,
            {
                Transparency = 0.65
            }
        )

        Tween(
            Arrow,
            0.15,
            {
                TextColor3 =
                    Theme.Sub
            }
        )

        Tween(
            Moon,
            0.15,
            {
                TextColor3 =
                    Theme.Text
            }
        )
    end)

    --==================================================
    -- CLICK EFFECT
    --==================================================

    Card.MouseButton1Down:Connect(function()

        Tween(
            Card,
            0.08,
            {
                BackgroundColor3 =
                    Theme.AccentDark
            }
        )

        Tween(
            Arrow,
            0.08,
            {
                TextColor3 =
                    Theme.Text
            }
        )
    end)

    Card.MouseButton1Up:Connect(function()

        Tween(
            Card,
            0.12,
            {
                BackgroundColor3 =
                    Theme.CardHover
            }
        )
    end)

    --==================================================
    -- SAVE CARD
    --==================================================

    GameCards[index] = {
        Frame = Card,
        Data = gameData,
        Name = Name,
        Description = Description,
    }

    return Card
end

--==================================================
-- CREATE CARDS
--==================================================

for index, gameData in ipairs(Games) do
    CreateGameCard(gameData, index)
end

--==================================================
-- EXECUTE GAME
--==================================================

local function ExecuteGame(gameData)

    if not gameData then
        return
    end

    if not gameData.Link or gameData.Link == "" then

        warn(
            "Lunar Hub: No Link for " ..
            tostring(gameData.Name)
        )

        return
    end

    task.spawn(function()

        local success, result = pcall(function()

            local source =
                game:HttpGet(gameData.Link)

            if not source or source == "" then

                error(
                    "Empty script received from link"
                )

            end

            local loaded =
                loadstring(source)

            if not loaded then

                error(
                    "loadstring failed"
                )

            end

            return loaded()

        end)

        if not success then

            warn(
                "Lunar Hub [" ..
                tostring(gameData.Name) ..
                "]: " ..
                tostring(result)
            )

        end

    end)
end

--==================================================
-- CONNECT GAME BUTTONS
--==================================================

for index, cardData in pairs(GameCards) do

    local Card = cardData.Frame
    local gameData = cardData.Data

    Card.MouseButton1Click:Connect(function()

        ExecuteGame(gameData)

    end)

end

--==================================================
-- SEARCH FUNCTION
--==================================================

local function SearchGames(text)

    text = tostring(text or "")
    text = string.lower(text)

    for _, cardData in pairs(GameCards) do

        local gameData = cardData.Data

        local gameName =
            string.lower(
                tostring(gameData.Name or "")
            )

        local description =
            string.lower(
                tostring(gameData.Description or "")
            )

        local found = false

        if text == "" then

            found = true

        elseif string.find(
            gameName,
            text,
            1,
            true
        ) then

            found = true

        elseif string.find(
            description,
            text,
            1,
            true
        ) then

            found = true

        end

        cardData.Frame.Visible = found
    end

end

--==================================================
-- SEARCH CHANGED
--==================================================

SearchInput:GetPropertyChangedSignal(
    "Text"
):Connect(function()

    SearchGames(
        SearchInput.Text
    )

end)

--==================================================
-- SEARCH FOCUS
--==================================================

SearchInput.Focused:Connect(function()

    Tween(
        SearchBox,
        0.15,
        {
            BackgroundColor3 =
                Theme.CardHover
        }
    )

end)

SearchInput.FocusLost:Connect(function()

    Tween(
        SearchBox,
        0.15,
        {
            BackgroundColor3 =
                Theme.Card
        }
    )

end)

--==================================================
-- PAGE STATE
--==================================================

local CurrentPage = "Games"

local function SetPage(page)

    CurrentPage = page

    if page == "Games" then

        GamePage.Visible = true

        if UpdatePage then
            UpdatePage.Visible = false
        end

        GamesButton.BackgroundColor3 =
            Theme.AccentDark

        GamesButton.TextColor3 =
            Theme.Text

        UpdatesButton.BackgroundColor3 =
            Theme.Card

        UpdatesButton.TextColor3 =
            Theme.Sub

    elseif page == "Updates" then

        GamePage.Visible = false

        if UpdatePage then
            UpdatePage.Visible = true
        end

        GamesButton.BackgroundColor3 =
            Theme.Card

        GamesButton.TextColor3 =
            Theme.Sub

        UpdatesButton.BackgroundColor3 =
            Theme.AccentDark

        UpdatesButton.TextColor3 =
            Theme.Text

    end

end

--==================================================
-- SIDEBAR HOVER
--==================================================

GamesButton.MouseEnter:Connect(function()

    if CurrentPage ~= "Games" then

        Tween(
            GamesButton,
            0.15,
            {
                BackgroundColor3 =
                    Theme.CardHover
            }
        )

    end

end)

GamesButton.MouseLeave:Connect(function()

    if CurrentPage ~= "Games" then

        Tween(
            GamesButton,
            0.15,
            {
                BackgroundColor3 =
                    Theme.Card
            }
        )

    end

end)

UpdatesButton.MouseEnter:Connect(function()

    if CurrentPage ~= "Updates" then

        Tween(
            UpdatesButton,
            0.15,
            {
                BackgroundColor3 =
                    Theme.CardHover
            }
        )

    end

end)

UpdatesButton.MouseLeave:Connect(function()

    if CurrentPage ~= "Updates" then

        Tween(
            UpdatesButton,
            0.15,
            {
                BackgroundColor3 =
                    Theme.Card
            }
        )

    end

end)

--==================================================
-- BUTTON CLICKS
--==================================================

GamesButton.MouseButton1Click:Connect(function()

    SetPage("Games")

end)

UpdatesButton.MouseButton1Click:Connect(function()

    SetPage("Updates")

end)

--==================================================
-- END PART 2 / 3
--==================================================

--==================================================
-- 🌙 LUNAR HUB v32.0
-- PART 3 / 3
--==================================================

--==================================================
-- UPDATE PAGE
--==================================================

local UpdatePage = Create("Frame", {
    Name = "UpdatePage",

    Parent = Content,

    Position = UDim2.new(
        0,
        14,
        0,
        14
    ),

    Size = UDim2.new(
        1,
        -28,
        1,
        -24
    ),

    BackgroundColor3 = Theme.Card,

    BorderSizePixel = 0,

    Visible = false,

    ZIndex = 4,
})

Corner(UpdatePage, 18)

--==================================================
-- UPDATE TITLE
--==================================================

local UpdateTitle = MakeText(
    UpdatePage,
    "🔄  Lunar Updates",
    21,
    UDim2.new(0, 22, 0, 22),
    Enum.Font.GothamBold,
    Theme.Text
)

UpdateTitle.Size = UDim2.new(
    1,
    -44,
    0,
    35
)

--==================================================
-- UPDATE DESCRIPTION
--==================================================

local UpdateDescription = MakeText(
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

    Enum.Font.Gotham,

    Theme.Sub
)

UpdateDescription.Size = UDim2.new(
    1,
    -44,
    0,
    180
)

UpdateDescription.TextYAlignment =
    Enum.TextYAlignment.Top

UpdateDescription.TextWrapped = true

--==================================================
-- PAGE SWITCH ANIMATION
--==================================================

local function AnimatePage(page)

    if not page then
        return
    end

    page.Position = UDim2.new(
        0,
        28,
        0,
        14
    )

    page.BackgroundTransparency = 1

    Tween(
        page,
        0.2,
        {
            Position = UDim2.new(
                0,
                14,
                0,
                14
            ),

            BackgroundTransparency = 0
        }
    )

end

--==================================================
-- OVERRIDE PAGE SWITCH
--==================================================

local function SwitchPage(page)

    CurrentPage = page

    if page == "Games" then

        UpdatePage.Visible = false

        GamePage.Visible = true

        AnimatePage(GamePage)

        Tween(
            GamesButton,
            0.15,
            {
                BackgroundColor3 =
                    Theme.AccentDark,

                TextColor3 =
                    Theme.Text
            }
        )

        Tween(
            UpdatesButton,
            0.15,
            {
                BackgroundColor3 =
                    Theme.Card,

                TextColor3 =
                    Theme.Sub
            }
        )

    elseif page == "Updates" then

        GamePage.Visible = false

        UpdatePage.Visible = true

        AnimatePage(UpdatePage)

        Tween(
            GamesButton,
            0.15,
            {
                BackgroundColor3 =
                    Theme.Card,

                TextColor3 =
                    Theme.Sub
            }
        )

        Tween(
            UpdatesButton,
            0.15,
            {
                BackgroundColor3 =
                    Theme.AccentDark,

                TextColor3 =
                    Theme.Text
            }
        )

    end

end

--==================================================
-- RECONNECT CATEGORY BUTTONS
--==================================================

GamesButton.MouseButton1Click:Connect(function()

    SwitchPage("Games")

end)

UpdatesButton.MouseButton1Click:Connect(function()

    SwitchPage("Updates")

end)

--==================================================
-- MINIMIZE SYSTEM
--==================================================

local Minimized = false

local NormalSize = UDim2.new(
    0,
    CONFIG.Width,
    0,
    CONFIG.Height
)

local MinimizedSize = UDim2.new(
    0,
    CONFIG.Width,
    0,
    58
)

local function SetMinimized(state)

    Minimized = state

    if Minimized then

        Tween(
            Main,
            0.25,
            {
                Size = MinimizedSize
            }
        )

        Tween(
            Content,
            0.2,
            {
                BackgroundTransparency = 1
            }
        )

        Tween(
            Sidebar,
            0.2,
            {
                BackgroundTransparency = 1
            }
        )

        SearchBox.Visible = false

        MinimizeButton.Text = "+"

    else

        Tween(
            Main,
            0.25,
            {
                Size = NormalSize
            }
        )

        SearchBox.Visible = true

        Tween(
            Content,
            0.2,
            {
                BackgroundTransparency = 0
            }
        )

        Tween(
            Sidebar,
            0.2,
            {
                BackgroundTransparency = 0
            }
        )

        MinimizeButton.Text = "−"

    end

end

--==================================================
-- MINIMIZE HOVER
--==================================================

MinimizeButton.MouseEnter:Connect(function()

    Tween(
        MinimizeButton,
        0.12,
        {
            BackgroundColor3 =
                Theme.AccentDark
        }
    )

end)

MinimizeButton.MouseLeave:Connect(function()

    Tween(
        MinimizeButton,
        0.12,
        {
            BackgroundColor3 =
                Theme.Card
        }
    )

end)

--==================================================
-- CLOSE HOVER
--==================================================

CloseButton.MouseEnter:Connect(function()

    Tween(
        CloseButton,
        0.12,
        {
            BackgroundColor3 =
                Theme.AccentDark
        }
    )

end)

CloseButton.MouseLeave:Connect(function()

    Tween(
        CloseButton,
        0.12,
        {
            BackgroundColor3 =
                Theme.Card
        }
    )

end)

--==================================================
-- MINIMIZE CLICK
--==================================================

MinimizeButton.MouseButton1Click:Connect(function()

    SetMinimized(
        not Minimized
    )

end)

--==================================================
-- CLOSE CLICK
--==================================================

CloseButton.MouseButton1Click:Connect(function()

    Tween(
        Main,
        0.2,
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

    Tween(
        Glow,
        0.2,
        {
            ImageTransparency = 1
        }
    )

    task.wait(0.22)

    ScreenGui:Destroy()

end)

--==================================================
-- DRAG SYSTEM
--==================================================

local Dragging = false
local DragStart
local StartPosition

local function UpdateDrag(input)

    local Delta =
        input.Position - DragStart

    Main.Position = UDim2.new(
        StartPosition.X.Scale,
        StartPosition.X.Offset + Delta.X,

        StartPosition.Y.Scale,
        StartPosition.Y.Offset + Delta.Y
    )

end

TopBar.InputBegan:Connect(function(input)

    if input.UserInputType ==
        Enum.UserInputType.MouseButton1
        or
        input.UserInputType ==
        Enum.UserInputType.Touch
    then

        Dragging = true

        DragStart = input.Position

        StartPosition = Main.Position

        input.Changed:Connect(function()

            if input.UserInputState ==
                Enum.UserInputState.End
            then

                Dragging = false

            end

        end)

    end

end)

UserInputService.InputChanged:Connect(function(input)

    if not Dragging then
        return
    end

    if input.UserInputType ==
        Enum.UserInputType.MouseMovement
        or
        input.UserInputType ==
        Enum.UserInputType.Touch
    then

        UpdateDrag(input)

    end

end)

--==================================================
-- TOP BAR BUTTON ANIMATION
--==================================================

local function ButtonPressAnimation(button)

    local originalSize =
        button.Size

    button.MouseButton1Down:Connect(function()

        Tween(
            button,
            0.08,
            {
                Size = UDim2.new(
                    0,
                    originalSize.X.Offset - 3,
                    0,
                    originalSize.Y.Offset - 3
                )
            }
        )

    end)

    button.MouseButton1Up:Connect(function()

        Tween(
            button,
            0.08,
            {
                Size = originalSize
            }
        )

    end)

end

ButtonPressAnimation(
    MinimizeButton
)

ButtonPressAnimation(
    CloseButton
)

--==================================================
-- INITIAL STATE
--==================================================

SwitchPage("Games")

--==================================================
-- STARTUP ANIMATION
--==================================================

Main.Size = UDim2.new(
    0,
    CONFIG.Width - 40,
    0,
    CONFIG.Height - 40
)

Main.BackgroundTransparency = 1

Glow.ImageTransparency = 1

Tween(
    Main,
    0.35,
    {
        Size = NormalSize,

        BackgroundTransparency = 0
    }
)

Tween(
    Glow,
    0.4,
    {
        ImageTransparency = 0.9
    }
)

--==================================================
-- FINAL SETTINGS
--==================================================

Main.Active = true
TopBar.Active = true

GamePage.Visible = true
UpdatePage.Visible = false

--==================================================
-- 🌙 LUNAR HUB READY
--==================================================

print(
    "🌙 Lunar Hub v32.0 loaded successfully!"
)

--==================================================
-- END OF PART 3 / 3
--==================================================
