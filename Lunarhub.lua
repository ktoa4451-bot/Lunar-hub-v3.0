-- 🌙 LUNAR HUB v31.0
-- Neon Purple UI / Animated Hub

local VERSION = "31.0"

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")

local LocalPlayer = Players.LocalPlayer

--------------------------------------------------
-- CONFIG
--------------------------------------------------

local Config = {
    AnimationSpeed = 0.25,
    HoverSpeed = 0.15,
    ClickSpeed = 0.10,
    OpenSpeed = 0.45,
    CloseSpeed = 0.30,

    MainWidth = 680,
    MainHeight = 500,

    SidebarWidth = 155
}

--------------------------------------------------
-- THEME
--------------------------------------------------

local Theme = {
    Background = Color3.fromRGB(12, 10, 20),
    Secondary = Color3.fromRGB(20, 16, 32),
    Card = Color3.fromRGB(29, 23, 45),

    Accent = Color3.fromRGB(157, 82, 255),
    AccentDark = Color3.fromRGB(92, 43, 170),
    AccentLight = Color3.fromRGB(190, 130, 255),

    Text = Color3.fromRGB(245, 242, 255),
    SubText = Color3.fromRGB(165, 155, 185),

    Success = Color3.fromRGB(80, 220, 130),
    Error = Color3.fromRGB(255, 80, 100),
    Warning = Color3.fromRGB(255, 190, 70)
}

--------------------------------------------------
-- GAMES
--------------------------------------------------

local Games = {

    {
        Name = "Forsaken",
        Description = "Forsaken scripts",
        Link = "https://raw.githubusercontent.com/ktoa4451-bot/Lunar-hub-v3.0/main/Games/Forsaken.lua"
    },

    {
        Name = "MM2",
        Description = "Murder Mystery 2",
        Link = "https://raw.githubusercontent.com/ktoa4451-bot/Lunar-hub-v3.0/main/Games/MM2.lua"
    },

    {
        Name = "Rivals",
        Description = "Rivals scripts",
        Link = "https://raw.githubusercontent.com/ktoa4451-bot/Lunar-hub-v3.0/main/Games/Rivals.lua"
    },

    {
        Name = "Slap Battles",
        Description = "Slap Battles",
        Link = "https://raw.githubusercontent.com/ktoa4451-bot/Lunar-hub-v3.0/main/Games/SlapBattles.lua"
    },

    {
        Name = "King Legacy",
        Description = "King Legacy",
        Link = "https://raw.githubusercontent.com/ktoa4451-bot/Lunar-hub-v3.0/main/Games/KingLegacy.lua"
    },

    {
        Name = "1+ Speed Keyboard",
        Description = "Speed Keyboard",
        Link = "https://raw.githubusercontent.com/ktoa4451-bot/Lunar-hub-v3.0/main/Games/SpeedKeyboard.lua"
    },

    {
        Name = "Merge Nuke",
        Description = "Merge Nuke",
        Link = "https://raw.githubusercontent.com/ktoa4451-bot/Lunar-hub-v3.0/main/Games/MergeNuke.lua"
    },

    {
        Name = "MorphUp",
        Description = "MorphUp",
        Link = "https://raw.githubusercontent.com/ktoa4451-bot/Lunar-hub-v3.0/main/Games/MorphUp.lua"
    },

    {
        Name = "1 Magic Evolution",
        Description = "1 Magic Evolution",
        Link = "https://raw.githubusercontent.com/ktoa4451-bot/Lunar-hub-v3.0/main/Games/1MagicEvolution.lua"
    },

    {
        Name = "99 Nights in Forest",
        Description = "99 Nights in the Forest",
        Link = "https://raw.githubusercontent.com/ktoa4451-bot/Lunar-hub-v3.0/main/Games/99Nights.lua"
    },

    {
        Name = "Survive Zombie Arena",
        Description = "Survive Zombie Arena",
        Link = "https://raw.githubusercontent.com/ktoa4451-bot/Lunar-hub-v3.0/main/Games/SurviveZombieArena.lua"
    },

    {
        Name = "Color or Die",
        Description = "Color or Die",
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
    }

}

--------------------------------------------------
-- UTILITY
--------------------------------------------------

local function Create(className, properties)

    local object = Instance.new(className)

    for property, value in pairs(properties or {}) do
        object[property] = value
    end

    return object
end

--------------------------------------------------

local function Corner(parent, radius)

    return Create("UICorner", {
        Parent = parent,
        CornerRadius = UDim.new(0, radius or 10)
    })

end

--------------------------------------------------

local function Stroke(parent, color, transparency, thickness)

    return Create("UIStroke", {
        Parent = parent,
        Color = color or Theme.Accent,
        Transparency = transparency or 0,
        Thickness = thickness or 1
    })

end

--------------------------------------------------

local function Tween(object, properties, duration, style, direction)

    local tween = TweenService:Create(
        object,
        TweenInfo.new(
            duration or Config.AnimationSpeed,
            style or Enum.EasingStyle.Quart,
            direction or Enum.EasingDirection.Out
        ),
        properties
    )

    tween:Play()

    return tween
end

--------------------------------------------------
-- SCREEN GUI
--------------------------------------------------

local OldGui = LocalPlayer:FindFirstChild("LunarHub")

if OldGui then
    OldGui:Destroy()
end

--------------------------------------------------

local ScreenGui = Create("ScreenGui", {

    Name = "LunarHub",

    Parent = LocalPlayer:WaitForChild("PlayerGui"),

    ResetOnSpawn = false,

    ZIndexBehavior = Enum.ZIndexBehavior.Sibling,

    IgnoreGuiInset = true
})

--------------------------------------------------
-- MAIN WINDOW
--------------------------------------------------

local Main = Create("Frame", {

    Parent = ScreenGui,

    BackgroundColor3 = Theme.Background,

    BorderSizePixel = 0,

    Position = UDim2.new(
        0.5,
        -Config.MainWidth / 2,
        0.5,
        -Config.MainHeight / 2
    ),

    Size = UDim2.new(
        0,
        Config.MainWidth,
        0,
        Config.MainHeight
    ),

    ClipsDescendants = true,

    Visible = true
})

Corner(Main, 16)

Stroke(
    Main,
    Theme.Accent,
    0.45,
    1.5
)

--------------------------------------------------
-- OUTER GLOW
--------------------------------------------------

local Glow = Create("Frame", {

    Parent = Main,

    BackgroundColor3 = Theme.Accent,

    BackgroundTransparency = 0.92,

    BorderSizePixel = 0,

    Position = UDim2.new(
        0,
        -8,
        0,
        -8
    ),

    Size = UDim2.new(
        1,
        16,
        1,
        16
    ),

    ZIndex = 0
})

Corner(Glow, 22)

--------------------------------------------------
-- TOP BAR
--------------------------------------------------

local TopBar = Create("Frame", {

    Parent = Main,

    BackgroundColor3 = Theme.Secondary,

    BorderSizePixel = 0,

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
        64
    ),

    ZIndex = 5
})

--------------------------------------------------
-- MOON
--------------------------------------------------

local Moon = Create("TextLabel", {

    Parent = TopBar,

    BackgroundTransparency = 1,

    Position = UDim2.new(
        0,
        18,
        0,
        12
    ),

    Size = UDim2.new(
        0,
        40,
        0,
        40
    ),

    Font = Enum.Font.GothamBold,

    Text = "☾",

    TextColor3 = Theme.AccentLight,

    TextSize = 30,

    ZIndex = 6
})

--------------------------------------------------
-- TITLE
--------------------------------------------------

local Title = Create("TextLabel", {

    Parent = TopBar,

    BackgroundTransparency = 1,

    Position = UDim2.new(
        0,
        65,
        0,
        10
    ),

    Size = UDim2.new(
        0,
        250,
        0,
        25
    ),

    Font = Enum.Font.GothamBold,

    Text = "LUNAR HUB",

    TextColor3 = Theme.Text,

    TextSize = 19,

    TextXAlignment = Enum.TextXAlignment.Left,

    ZIndex = 6
})

--------------------------------------------------

local Version = Create("TextLabel", {

    Parent = TopBar,

    BackgroundTransparency = 1,

    Position = UDim2.new(
        0,
        66,
        0,
        35
    ),

    Size = UDim2.new(
        0,
        150,
        0,
        16
    ),

    Font = Enum.Font.Gotham,

    Text = "NEON EDITION • v" .. VERSION,

    TextColor3 = Theme.SubText,

    TextSize = 9,

    TextXAlignment = Enum.TextXAlignment.Left,

    ZIndex = 6
})

--------------------------------------------------
-- WINDOW BUTTONS
--------------------------------------------------

local MinimizeButton = Create("TextButton", {

    Parent = TopBar,

    BackgroundColor3 = Theme.Card,

    BorderSizePixel = 0,

    Position = UDim2.new(
        1,
        -82,
        0,
        17
    ),

    Size = UDim2.new(
        0,
        32,
        0,
        32
    ),

    AutoButtonColor = false,

    Font = Enum.Font.GothamBold,

    Text = "—",

    TextColor3 = Theme.Text,

    TextSize = 16,

    ZIndex = 7
})

Corner(MinimizeButton, 9)

--------------------------------------------------

local CloseButton = Create("TextButton", {

    Parent = TopBar,

    BackgroundColor3 = Theme.Card,

    BorderSizePixel = 0,

    Position = UDim2.new(
        1,
        -43,
        0,
        17
    ),

    Size = UDim2.new(
        0,
        32,
        0,
        32
    ),

    AutoButtonColor = false,

    Font = Enum.Font.GothamBold,

    Text = "×",

    TextColor3 = Theme.Text,

    TextSize = 20,

    ZIndex = 7
})

Corner(CloseButton, 9)

--------------------------------------------------
-- BUTTON HOVER ANIMATION
--------------------------------------------------

local function ButtonHover(button)

    local originalSize = button.Size

    button.MouseEnter:Connect(function()

        Tween(
            button,
            {
                BackgroundColor3 = Theme.AccentDark,

                Size = UDim2.new(
                    originalSize.X.Scale,
                    originalSize.X.Offset + 2,
                    originalSize.Y.Scale,
                    originalSize.Y.Offset + 2
                )
            },
            Config.HoverSpeed
        )

    end)

    button.MouseLeave:Connect(function()

        Tween(
            button,
            {
                BackgroundColor3 = Theme.Card,

                Size = originalSize
            },
            Config.HoverSpeed
        )

    end)

end

ButtonHover(MinimizeButton)
ButtonHover(CloseButton)

--------------------------------------------------
-- DRAG SYSTEM
--------------------------------------------------

local Dragging = false

local DragStart

local StartPosition

TopBar.InputBegan:Connect(function(input)

    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then

        Dragging = true

        DragStart = input.Position

        StartPosition = Main.Position

        input.Changed:Connect(function()

            if input.UserInputState == Enum.UserInputState.End then

                Dragging = false

            end

        end)

    end

end)

--------------------------------------------------

UserInputService.InputChanged:Connect(function(input)

    if not Dragging then
        return
    end

    if input.UserInputType == Enum.UserInputType.MouseMovement
        or input.UserInputType == Enum.UserInputType.Touch then

        local Delta =
            input.Position - DragStart

        Main.Position = UDim2.new(

            StartPosition.X.Scale,

            StartPosition.X.Offset + Delta.X,

            StartPosition.Y.Scale,

            StartPosition.Y.Offset + Delta.Y

        )

    end

end)

--------------------------------------------------
-- SIDEBAR
--------------------------------------------------

local Sidebar = Create("Frame", {

    Parent = Main,

    BackgroundColor3 = Theme.Secondary,

    BorderSizePixel = 0,

    Position = UDim2.new(
        0,
        0,
        0,
        64
    ),

    Size = UDim2.new(
        0,
        Config.SidebarWidth,
        1,
        -64
    ),

    ZIndex = 3
})

--------------------------------------------------

Create("UIPadding", {

    Parent = Sidebar,

    PaddingTop = UDim.new(0, 18),

    PaddingLeft = UDim.new(0, 12),

    PaddingRight = UDim.new(0, 12)

})

--------------------------------------------------

Create("UIListLayout", {

    Parent = Sidebar,

    Padding = UDim.new(0, 8),

    SortOrder = Enum.SortOrder.LayoutOrder

})

--------------------------------------------------
-- CONTENT
--------------------------------------------------

local Content = Create("Frame", {

    Parent = Main,

    BackgroundTransparency = 1,

    Position = UDim2.new(
        0,
        Config.SidebarWidth,
        0,
        64
    ),

    Size = UDim2.new(
        1,
        -Config.SidebarWidth,
        1,
        -64
    ),

    ZIndex = 2
})

--------------------------------------------------
-- SEARCH BOX
--------------------------------------------------

local SearchBox = Create("TextBox", {

    Parent = Content,

    BackgroundColor3 = Theme.Card,

    BorderSizePixel = 0,

    Position = UDim2.new(
        0,
        18,
        0,
        18
    ),

    Size = UDim2.new(
        1,
        -36,
        0,
        40
    ),

    Font = Enum.Font.Gotham,

    PlaceholderText = "⌕  Search games...",

    PlaceholderColor3 = Theme.SubText,

    Text = "",

    TextColor3 = Theme.Text,

    TextSize = 12,

    ClearTextOnFocus = false,

    ZIndex = 4
})

Corner(SearchBox, 10)

Create("UIPadding", {

    Parent = SearchBox,

    PaddingLeft = UDim.new(0, 14),

    PaddingRight = UDim.new(0, 14)

})
--------------------------------------------------
-- GAME LIST
--------------------------------------------------

local GameList = Create("ScrollingFrame", {

    Parent = Content,

    BackgroundTransparency = 1,

    BorderSizePixel = 0,

    Position = UDim2.new(
        0,
        18,
        0,
        72
    ),

    Size = UDim2.new(
        1,
        -36,
        1,
        -88
    ),

    CanvasSize = UDim2.new(
        0,
        0,
        0,
        0
    ),

    AutomaticCanvasSize = Enum.AutomaticSize.Y,

    ScrollBarThickness = 3,

    ScrollBarImageColor3 = Theme.Accent,

    ScrollBarImageTransparency = 0.25,

    ZIndex = 3
})

Create("UIListLayout", {

    Parent = GameList,

    Padding = UDim.new(
        0,
        9
    ),

    SortOrder = Enum.SortOrder.LayoutOrder
})

Create("UIPadding", {

    Parent = GameList,

    PaddingBottom = UDim.new(
        0,
        10
    )
})

--------------------------------------------------
-- GAME BUTTONS
--------------------------------------------------

local GameButtons = {}

--------------------------------------------------
-- GAME CARD
--------------------------------------------------

local function CreateGameButton(gameData)

    local Button = Create("TextButton", {

        Parent = GameList,

        BackgroundColor3 = Theme.Card,

        BorderSizePixel = 0,

        Size = UDim2.new(
            1,
            0,
            0,
            68
        ),

        AutoButtonColor = false,

        Text = "",

        ZIndex = 4
    })

    Corner(
        Button,
        11
    )

    local ButtonStroke = Stroke(
        Button,
        Theme.Accent,
        1,
        1
    )

    --------------------------------------------------
    -- ICON
    --------------------------------------------------

    local Icon = Create("Frame", {

        Parent = Button,

        BackgroundColor3 = Theme.AccentDark,

        BorderSizePixel = 0,

        Position = UDim2.new(
            0,
            10,
            0.5,
            -22
        ),

        Size = UDim2.new(
            0,
            44,
            0,
            44
        ),

        ZIndex = 5
    })

    Corner(
        Icon,
        10
    )

    Stroke(
        Icon,
        Theme.Accent,
        0.45,
        1
    )

    --------------------------------------------------
    -- MOON ICON
    --------------------------------------------------

    local IconText = Create("TextLabel", {

        Parent = Icon,

        BackgroundTransparency = 1,

        Size = UDim2.new(
            1,
            0,
            1,
            0
        ),

        Font = Enum.Font.GothamBold,

        Text = "☾",

        TextColor3 = Theme.AccentLight,

        TextSize = 23,

        ZIndex = 6
    })

    --------------------------------------------------
    -- GAME NAME
    --------------------------------------------------

    local NameLabel = Create("TextLabel", {

        Parent = Button,

        BackgroundTransparency = 1,

        Position = UDim2.new(
            0,
            66,
            0,
            11
        ),

        Size = UDim2.new(
            1,
            -110,
            0,
            21
        ),

        Font = Enum.Font.GothamBold,

        Text = gameData.Name,

        TextColor3 = Theme.Text,

        TextSize = 13,

        TextXAlignment = Enum.TextXAlignment.Left,

        TextTruncate = Enum.TextTruncate.AtEnd,

        ZIndex = 5
    })

    --------------------------------------------------
    -- DESCRIPTION
    --------------------------------------------------

    local DescriptionLabel = Create("TextLabel", {

        Parent = Button,

        BackgroundTransparency = 1,

        Position = UDim2.new(
            0,
            66,
            0,
            34
        ),

        Size = UDim2.new(
            1,
            -110,
            0,
            18
        ),

        Font = Enum.Font.Gotham,

        Text = gameData.Description or "Lunar Hub game",

        TextColor3 = Theme.SubText,

        TextSize = 10,

        TextXAlignment = Enum.TextXAlignment.Left,

        TextTruncate = Enum.TextTruncate.AtEnd,

        ZIndex = 5
    })

    --------------------------------------------------
    -- ARROW
    --------------------------------------------------

    local Arrow = Create("TextLabel", {

        Parent = Button,

        BackgroundTransparency = 1,

        Position = UDim2.new(
            1,
            -38,
            0.5,
            -12
        ),

        Size = UDim2.new(
            0,
            25,
            0,
            25
        ),

        Font = Enum.Font.GothamBold,

        Text = "›",

        TextColor3 = Theme.SubText,

        TextSize = 24,

        ZIndex = 6
    })

    --------------------------------------------------
    -- HOVER
    --------------------------------------------------

    Button.MouseEnter:Connect(function()

        Tween(
            Button,
            {
                BackgroundColor3 = Color3.fromRGB(
                    37,
                    29,
                    55
                )
            },
            Config.HoverSpeed
        )

        Tween(
            ButtonStroke,
            {
                Transparency = 0.35
            },
            Config.HoverSpeed
        )

        Tween(
            Arrow,
            {
                TextColor3 = Theme.AccentLight,

                Position = UDim2.new(
                    1,
                    -34,
                    0.5,
                    -12
                )
            },
            Config.HoverSpeed
        )

        Tween(
            Icon,
            {
                BackgroundColor3 = Theme.Accent
            },
            Config.HoverSpeed
        )

        Tween(
            IconText,
            {
                Rotation = 15,

                TextColor3 = Theme.Text
            },
            Config.HoverSpeed
        )

    end)

    --------------------------------------------------
    -- LEAVE
    --------------------------------------------------

    Button.MouseLeave:Connect(function()

        Tween(
            Button,
            {
                BackgroundColor3 = Theme.Card
            },
            Config.HoverSpeed
        )

        Tween(
            ButtonStroke,
            {
                Transparency = 1
            },
            Config.HoverSpeed
        )

        Tween(
            Arrow,
            {
                TextColor3 = Theme.SubText,

                Position = UDim2.new(
                    1,
                    -38,
                    0.5,
                    -12
                )
            },
            Config.HoverSpeed
        )

        Tween(
            Icon,
            {
                BackgroundColor3 = Theme.AccentDark
            },
            Config.HoverSpeed
        )

        Tween(
            IconText,
            {
                Rotation = 0,

                TextColor3 = Theme.AccentLight
            },
            Config.HoverSpeed
        )

    end)

    --------------------------------------------------
    -- CLICK
    --------------------------------------------------

    Button.MouseButton1Down:Connect(function()

        Tween(
            Button,
            {
                Size = UDim2.new(
                    1,
                    -4,
                    0,
                    64
                )
            },
            Config.ClickSpeed
        )

    end)

    Button.MouseButton1Up:Connect(function()

        Tween(
            Button,
            {
                Size = UDim2.new(
                    1,
                    0,
                    0,
                    68
                )
            },
            Config.ClickSpeed
        )

    end)

    --------------------------------------------------
    -- LOAD GAME
    --------------------------------------------------

    Button.MouseButton1Click:Connect(function()

        if not gameData.Link
            or gameData.Link == "" then

            Notify(
                "Lunar Hub",
                "У этой игры нет ссылки.",
                "warning"
            )

            return
        end

        --------------------------------------------------
        -- CLICK ANIMATION
        --------------------------------------------------

        Tween(
            Arrow,
            {
                Rotation = 90
            },
            0.12
        )

        task.delay(
            0.12,
            function()

                if Arrow then

                    Tween(
                        Arrow,
                        {
                            Rotation = 0
                        },
                        0.15
                    )

                end

            end
        )

        --------------------------------------------------
        -- NOTIFICATION
        --------------------------------------------------

        Notify(
            "Lunar Hub",
            "Загрузка " ..
                gameData.Name ..
                "...",
            "success"
        )

        --------------------------------------------------
        -- LOAD
        --------------------------------------------------

        task.spawn(function()

            local Success,
                Result = pcall(function()

                    local Source = game:HttpGet(
                        gameData.Link
                    )

                    local Function =
                        loadstring(Source)

                    if not Function then

                        error(
                            "loadstring вернул nil"
                        )

                    end

                    return Function()

                end)

                --------------------------------------------------
                -- SUCCESS
                --------------------------------------------------

                if Success then

                    Notify(
                        "Lunar Hub",
                        gameData.Name ..
                            " успешно загружен!",
                        "success"
                    )

                else

                    warn(
                        "[Lunar Hub] " ..
                        "Ошибка загрузки " ..
                        gameData.Name ..
                        ": " ..
                        tostring(Result)
                    )

                    Notify(
                        "Lunar Hub",
                        "Ошибка загрузки " ..
                            gameData.Name,
                        "error"
                    )

                end

        end)

    end)

    --------------------------------------------------
    -- STORE BUTTON
    --------------------------------------------------

    table.insert(
        GameButtons,
        {
            Button = Button,
            Data = gameData,
            Name = NameLabel,
            Description = DescriptionLabel,
            Arrow = Arrow,
            Icon = Icon
        }
    )

    return Button

end

--------------------------------------------------
-- CREATE ALL GAMES
--------------------------------------------------

for _, GameData in ipairs(Games) do

    CreateGameButton(
        GameData
    )

end

--------------------------------------------------
-- SEARCH
--------------------------------------------------

SearchBox:GetPropertyChangedSignal(
    "Text"
):Connect(function()

    local SearchText =
        string.lower(
            SearchBox.Text or ""
        )

    local Found = 0

    for _, GameInfo in ipairs(GameButtons) do

        local GameName =
            string.lower(
                GameInfo.Data.Name or ""
            )

        local Description =
            string.lower(
                GameInfo.Data.Description or ""
            )

        local Matches =
            SearchText == ""
            or string.find(
                GameName,
                SearchText,
                1,
                true
            )
            or string.find(
                Description,
                SearchText,
                1,
                true
            )

        GameInfo.Button.Visible =
            Matches

        if Matches then
            Found += 1
        end

    end

    --------------------------------------------------
    -- EMPTY SEARCH
    --------------------------------------------------

    if SearchText ~= ""
        and Found == 0 then

        EmptySearch.Visible = true

    else

        EmptySearch.Visible = false

    end

end)

--------------------------------------------------
-- EMPTY SEARCH LABEL
--------------------------------------------------

local EmptySearch = Create(
    "TextLabel",
    {

        Parent = Content,

        BackgroundTransparency = 1,

        Position = UDim2.new(
            0,
            20,
            0,
            145
        ),

        Size = UDim2.new(
            1,
            -40,
            0,
            60
        ),

        Font = Enum.Font.GothamMedium,

        Text = "🌙\n\nИгра не найдена",

        TextColor3 = Theme.SubText,

        TextSize = 13,

        TextWrapped = true,

        TextXAlignment =
            Enum.TextXAlignment.Center,

        TextYAlignment =
            Enum.TextYAlignment.Center,

        Visible = false,

        ZIndex = 5
    }
)

--------------------------------------------------
-- SIDEBAR TITLE
--------------------------------------------------

local SidebarTitle = Create(
    "TextLabel",
    {

        Parent = Sidebar,

        BackgroundTransparency = 1,

        Position = UDim2.new(
            0,
            12,
            0,
            12
        ),

        Size = UDim2.new(
            1,
            -24,
            0,
            22
        ),

        Font = Enum.Font.GothamBold,

        Text = "LUNAR",

        TextColor3 = Theme.AccentLight,

        TextSize = 12,

        TextXAlignment =
            Enum.TextXAlignment.Left,

        ZIndex = 5
    }
)

--------------------------------------------------
-- SIDEBAR LINE
--------------------------------------------------

local SidebarLine = Create(
    "Frame",
    {

        Parent = Sidebar,

        BackgroundColor3 =
            Theme.Accent,

        BackgroundTransparency = 0.5,

        BorderSizePixel = 0,

        Position = UDim2.new(
            0,
            12,
            0,
            38
        ),

        Size = UDim2.new(
            1,
            -24,
            0,
            1
        ),

        ZIndex = 5
    }
)

--------------------------------------------------
-- SIDEBAR BUTTON CREATOR
--------------------------------------------------

local function CreateSidebarButton(
    Text,
    Order
)

    local Button = Create(
        "TextButton",
        {

            Parent = Sidebar,

            BackgroundColor3 =
                Theme.Secondary,

            BorderSizePixel = 0,

            Size = UDim2.new(
                1,
                0,
                0,
                42
            ),

            LayoutOrder = Order,

            AutoButtonColor = false,

            Font = Enum.Font.GothamMedium,

            Text = Text,

            TextColor3 =
                Theme.SubText,

            TextSize = 12,

            ZIndex = 5
        }
    )

    Corner(
        Button,
        10
    )

    local ButtonStroke =
        Stroke(
            Button,
            Theme.Accent,
            1,
            1
        )

    --------------------------------------------------
    -- HOVER
    --------------------------------------------------

    Button.MouseEnter:Connect(
        function()

            Tween(
                Button,
                {
                    BackgroundColor3 =
                        Theme.Card,

                    TextColor3 =
                        Theme.Text
                },
                Config.HoverSpeed
            )

            Tween(
                ButtonStroke,
                {
                    Transparency = 0.65
                },
                Config.HoverSpeed
            )

        end
    )

    Button.MouseLeave:Connect(
        function()

            Tween(
                Button,
                {
                    BackgroundColor3 =
                        Theme.Secondary
                },
                Config.HoverSpeed
            )

            Tween(
                ButtonStroke,
                {
                    Transparency = 1
                },
                Config.HoverSpeed
            )

        end
    )

    return Button

end

--------------------------------------------------
-- SIDEBAR BUTTONS
--------------------------------------------------

local GamesButton =
    CreateSidebarButton(
        "🎮  Games",
        1
    )

local UpdatesButton =
    CreateSidebarButton(
        "🔄  Updates",
        2
    )

--------------------------------------------------
-- SELECTED PAGE INDICATOR
--------------------------------------------------

local SelectedIndicator = Create(
    "Frame",
    {

        Parent = Sidebar,

        BackgroundColor3 =
            Theme.Accent,

        BorderSizePixel = 0,

        Position = UDim2.new(
            0,
            2,
            0,
            15
        ),

        Size = UDim2.new(
            0,
            3,
            0,
            22
        ),

        ZIndex = 8
    }
)

Corner(
    SelectedIndicator,
    3
)

--------------------------------------------------
-- UPDATE PAGE
--------------------------------------------------

local UpdatePage = Create(
    "Frame",
    {

        Parent = Content,

        BackgroundTransparency = 1,

        Size = UDim2.new(
            1,
            0,
            1,
            0
        ),

        Visible = false,

        ZIndex = 3
    }
)

--------------------------------------------------
-- UPDATE TITLE
--------------------------------------------------

local UpdateTitle = Create(
    "TextLabel",
    {

        Parent = UpdatePage,

        BackgroundTransparency = 1,

        Position = UDim2.new(
            0,
            20,
            0,
            20
        ),

        Size = UDim2.new(
            1,
            -40,
            0,
            30
        ),

        Font = Enum.Font.GothamBold,

        Text = "Updates",

        TextColor3 = Theme.Text,

        TextSize = 20,

        TextXAlignment =
            Enum.TextXAlignment.Left
    }
)

--------------------------------------------------
-- UPDATE VERSION
--------------------------------------------------

local UpdateVersion = Create(
    "TextLabel",
    {

        Parent = UpdatePage,

        BackgroundTransparency = 1,

        Position = UDim2.new(
            0,
            20,
            0,
            53
        ),

        Size = UDim2.new(
            1,
            -40,
            0,
            22
        ),

        Font = Enum.Font.Gotham,

        Text =
            "Current version: v"
            .. VERSION,

        TextColor3 =
            Theme.SubText,

        TextSize = 11,

        TextXAlignment =
            Enum.TextXAlignment.Left
    }
)

--------------------------------------------------
-- UPDATE CARD
--------------------------------------------------

local UpdateCard = Create(
    "Frame",
    {

        Parent = UpdatePage,

        BackgroundColor3 =
            Theme.Card,

        BorderSizePixel = 0,

        Position = UDim2.new(
            0,
            20,
            0,
            95
        ),

        Size = UDim2.new(
            1,
            -40,
            0,
            150
        )
    }
)

Corner(
    UpdateCard,
    12
)

Stroke(
    UpdateCard,
    Theme.Accent,
    0.7,
    1
)

--------------------------------------------------
-- UPDATE CARD TITLE
--------------------------------------------------

local UpdateCardTitle = Create(
    "TextLabel",
    {
        Parent = UpdateCard,

        BackgroundTransparency = 1,

        Position = UDim2.new(
            0,
            16,
            0,
            14
        ),

        Size = UDim2.new(
            1,
            -32,
            0,
            25
        ),

        Font = Enum.Font.GothamBold,

        Text = "🌙 Lunar Hub v" .. VERSION,

        TextColor3 = Theme.Text,

        TextSize = 14,

        TextXAlignment =
            Enum.TextXAlignment.Left,

        ZIndex = 5
    }
)

--------------------------------------------------
-- UPDATE TEXT
--------------------------------------------------

local UpdateText = Create(
    "TextLabel",
    {
        Parent = UpdateCard,

        BackgroundTransparency = 1,

        Position = UDim2.new(
            0,
            16,
            0,
            45
        ),

        Size = UDim2.new(
            1,
            -32,
            0,
            85
        ),

        Font = Enum.Font.Gotham,

        Text =
            "• Neon Purple interface\n"
            .. "• Smooth menu animations\n"
            .. "• Animated game cards\n"
            .. "• Search system\n"
            .. "• Updates page\n"
            .. "• Improved loading system",

        TextColor3 = Theme.SubText,

        TextSize = 11,

        TextWrapped = true,

        TextXAlignment =
            Enum.TextXAlignment.Left,

        TextYAlignment =
            Enum.TextYAlignment.Top,

        ZIndex = 5
    }
)

--------------------------------------------------
-- SIDEBAR BUTTON CREATOR
--------------------------------------------------

local function CreateSidebarButton(
    Text,
    Order
)

    local Button = Create(
        "TextButton",
        {
            Parent = Sidebar,

            BackgroundColor3 =
                Theme.Secondary,

            BorderSizePixel = 0,

            Size = UDim2.new(
                1,
                0,
                0,
                42
            ),

            LayoutOrder = Order,

            AutoButtonColor = false,

            Font = Enum.Font.GothamMedium,

            Text = Text,

            TextColor3 =
                Theme.SubText,

            TextSize = 12,

            ZIndex = 5
        }
    )

    Corner(
        Button,
        10
    )

    local ButtonStroke =
        Stroke(
            Button,
            Theme.Accent,
            1,
            1
        )

    Button.MouseEnter:Connect(
        function()

            Tween(
                Button,
                {
                    BackgroundColor3 =
                        Theme.Card,

                    TextColor3 =
                        Theme.Text
                },
                Config.HoverSpeed
            )

            Tween(
                ButtonStroke,
                {
                    Transparency = 0.65
                },
                Config.HoverSpeed
            )

        end
    )

    Button.MouseLeave:Connect(
        function()

            Tween(
                Button,
                {
                    BackgroundColor3 =
                        Theme.Secondary
                },
                Config.HoverSpeed
            )

            Tween(
                ButtonStroke,
                {
                    Transparency = 1
                },
                Config.HoverSpeed
            )

        end
    )

    return Button

end

--------------------------------------------------
-- SIDEBAR BUTTONS
--------------------------------------------------

local GamesButton =
    CreateSidebarButton(
        "🎮  Games",
        1
    )

local UpdatesButton =
    CreateSidebarButton(
        "🔄  Updates",
        2
    )

--------------------------------------------------
-- SELECTED INDICATOR
--------------------------------------------------

local SelectedIndicator = Create(
    "Frame",
    {
        Parent = Sidebar,

        BackgroundColor3 =
            Theme.Accent,

        BorderSizePixel = 0,

        Position = UDim2.new(
            0,
            2,
            0,
            15
        ),

        Size = UDim2.new(
            0,
            3,
            0,
            22
        ),

        ZIndex = 8
    }
)

Corner(
    SelectedIndicator,
    3
)

--------------------------------------------------
-- PAGE FUNCTIONS
--------------------------------------------------

local function ShowGames()

    GameList.Visible = true

    SearchBox.Visible = true

    UpdatePage.Visible = false

    EmptySearch.Visible = false

    Tween(
        GamesButton,
        {
            BackgroundColor3 =
                Theme.Card,

            TextColor3 =
                Theme.Text
        },
        Config.HoverSpeed
    )

    Tween(
        UpdatesButton,
        {
            BackgroundColor3 =
                Theme.Secondary,

            TextColor3 =
                Theme.SubText
        },
        Config.HoverSpeed
    )

    Tween(
        SelectedIndicator,
        {
            Position = UDim2.new(
                0,
                2,
                0,
                15
            )
        },
        0.2
    )

end

--------------------------------------------------

local function ShowUpdates()

    GameList.Visible = false

    SearchBox.Visible = false

    EmptySearch.Visible = false

    UpdatePage.Visible = true

    Tween(
        GamesButton,
        {
            BackgroundColor3 =
                Theme.Secondary,

            TextColor3 =
                Theme.SubText
        },
        Config.HoverSpeed
    )

    Tween(
        UpdatesButton,
        {
            BackgroundColor3 =
                Theme.Card,

            TextColor3 =
                Theme.Text
        },
        Config.HoverSpeed
    )

    Tween(
        SelectedIndicator,
        {
            Position = UDim2.new(
                0,
                2,
                0,
                65
            )
        },
        0.2
    )

end

--------------------------------------------------
-- PAGE CONNECTIONS
--------------------------------------------------

GamesButton.MouseButton1Click:Connect(
    function()

        ShowGames()

    end
)

UpdatesButton.MouseButton1Click:Connect(
    function()

        ShowUpdates()

    end
)

--------------------------------------------------
-- FOOTER
--------------------------------------------------

local Footer = Create(
    "TextLabel",
    {
        Parent = Content,

        BackgroundTransparency = 1,

        Position = UDim2.new(
            0,
            20,
            1,
            -28
        ),

        Size = UDim2.new(
            1,
            -40,
            0,
            18
        ),

        Font = Enum.Font.Gotham,

        Text =
            "🌙 LUNAR HUB • v"
            .. VERSION,

        TextColor3 =
            Theme.SubText,

        TextSize = 9,

        TextXAlignment =
            Enum.TextXAlignment.Right,

        ZIndex = 5
    }
)
            --------------------------------------------------
-- NOTIFICATION SYSTEM
--------------------------------------------------

local NotificationHolder = Create(
    "Frame",
    {
        Parent = ScreenGui,

        BackgroundTransparency = 1,

        Position = UDim2.new(
            1,
            -20,
            1,
            -20
        ),

        Size = UDim2.new(
            0,
            300,
            0,
            250
        ),

        AnchorPoint = Vector2.new(
            1,
            1
        ),

        ZIndex = 100
    }
)

Create(
    "UIListLayout",
    {
        Parent = NotificationHolder,

        Padding = UDim.new(
            0,
            8
        ),

        SortOrder =
            Enum.SortOrder.LayoutOrder,

        VerticalAlignment =
            Enum.VerticalAlignment.Bottom
    }
)

--------------------------------------------------
-- NOTIFICATION
--------------------------------------------------

function Notify(
    TitleText,
    MessageText,
    NotificationType
)

    local AccentColor =
        Theme.Accent

    if NotificationType == "success" then

        AccentColor =
            Theme.Success

    elseif NotificationType == "error" then

        AccentColor =
            Theme.Error

    elseif NotificationType == "warning" then

        AccentColor =
            Theme.Warning

    end

    local Notification =
        Create(
            "Frame",
            {
                Parent =
                    NotificationHolder,

                BackgroundColor3 =
                    Theme.Card,

                BackgroundTransparency = 0.02,

                BorderSizePixel = 0,

                Size = UDim2.new(
                    1,
                    0,
                    0,
                    65
                ),

                ZIndex = 101
            }
        )

    Corner(
        Notification,
        11
    )

    Stroke(
        Notification,
        AccentColor,
        0.5,
        1
    )

    --------------------------------------------------
    -- ACCENT BAR
    --------------------------------------------------

    local Accent =
        Create(
            "Frame",
            {
                Parent =
                    Notification,

                BackgroundColor3 =
                    AccentColor,

                BorderSizePixel = 0,

                Position = UDim2.new(
                    0,
                    0,
                    0,
                    8
                ),

                Size = UDim2.new(
                    0,
                    3,
                    1,
                    -16
                ),

                ZIndex = 103
            }
        )

    Corner(
        Accent,
        3
    )

    --------------------------------------------------
    -- TITLE
    --------------------------------------------------

    local NotificationTitle =
        Create(
            "TextLabel",
            {
                Parent =
                    Notification,

                BackgroundTransparency = 1,

                Position = UDim2.new(
                    0,
                    15,
                    0,
                    9
                ),

                Size = UDim2.new(
                    1,
                    -25,
                    0,
                    20
                ),

                Font =
                    Enum.Font.GothamBold,

                Text =
                    TitleText,

                TextColor3 =
                    Theme.Text,

                TextSize = 12,

                TextXAlignment =
                    Enum.TextXAlignment.Left,

                ZIndex = 103
            }
        )

    --------------------------------------------------
    -- MESSAGE
    --------------------------------------------------

    local NotificationMessage =
        Create(
            "TextLabel",
            {
                Parent =
                    Notification,

                BackgroundTransparency = 1,

                Position = UDim2.new(
                    0,
                    15,
                    0,
                    31
                ),

                Size = UDim2.new(
                    1,
                    -25,
                    0,
                    23
                ),

                Font =
                    Enum.Font.Gotham,

                Text =
                    MessageText,

                TextColor3 =
                    Theme.SubText,

                TextSize = 10,

                TextWrapped = true,

                TextXAlignment =
                    Enum.TextXAlignment.Left,

                ZIndex = 103
            }
        )

    --------------------------------------------------
    -- START ANIMATION
    --------------------------------------------------

    Notification.Position =
        UDim2.new(
            1,
            30,
            0,
            0
        )

    Tween(
        Notification,
        {
            Position =
                UDim2.new(
                    0,
                    0,
                    0,
                    0
                )
        },
        0.35,
        Enum.EasingStyle.Quart,
        Enum.EasingDirection.Out
    )

    --------------------------------------------------
    -- AUTO CLOSE
    --------------------------------------------------

    task.delay(
        3.5,
        function()

            if not Notification
                or not Notification.Parent then
                return
            end

            local Out =
                Tween(
                    Notification,
                    {
                        Position =
                            UDim2.new(
                                1,
                                30,
                                0,
                                0
                            ),

                        BackgroundTransparency = 1
                    },
                    0.3,
                    Enum.EasingStyle.Quart,
                    Enum.EasingDirection.In
                )

            Out.Completed:Wait()

            if Notification then
                Notification:Destroy()
            end

        end
    )

end

--------------------------------------------------
-- PAGE FADE
--------------------------------------------------

local function FadeObject(
    Object,
    Transparency,
    Duration
)

    if not Object then
        return
    end

    local Properties = {}

    if Object:IsA("TextLabel")
        or Object:IsA("TextButton")
        or Object:IsA("TextBox") then

        Properties.TextTransparency =
            Transparency

    elseif Object:IsA("ImageLabel")
        or Object:IsA("ImageButton") then

        Properties.ImageTransparency =
            Transparency

    end

    if Object:IsA("Frame")
        or Object:IsA("ScrollingFrame")
        or Object:IsA("TextButton")
        or Object:IsA("TextBox") then

        Properties.BackgroundTransparency =
            Transparency

    end

    if next(Properties) then

        Tween(
            Object,
            Properties,
            Duration
        )

    end

end

--------------------------------------------------
-- GAME PAGE ANIMATION
--------------------------------------------------

local function AnimateGameCards()

    for Index, GameInfo in
        ipairs(GameButtons) do

        local Button =
            GameInfo.Button

        if Button then

            Button.Position =
                UDim2.new(
                    0,
                    35,
                    0,
                    0
                )

            Button.BackgroundTransparency =
                1

            task.delay(
                Index * 0.035,
                function()

                    if not Button
                        or not Button.Parent then
                        return
                    end

                    Tween(
                        Button,
                        {
                            Position =
                                UDim2.new(
                                    0,
                                    0,
                                    0,
                                    0
                                ),

                            BackgroundTransparency =
                                0
                        },
                        0.3,
                        Enum.EasingStyle.Quart
                    )

                end
            )

        end

    end

end

--------------------------------------------------
-- UPDATE PAGE ANIMATION
--------------------------------------------------

local function AnimateUpdates()

    UpdatePage.Position =
        UDim2.new(
            0,
            30,
            0,
            0
        )

    UpdatePage.BackgroundTransparency =
        1

    Tween(
        UpdatePage,
        {
            Position =
                UDim2.new(
                    0,
                    0,
                    0,
                    0
                )
        },
        0.35
    )

end

--------------------------------------------------
-- REDEFINE PAGE FUNCTIONS
--------------------------------------------------

local function OpenGamesPage()

    UpdatePage.Visible = false

    GameList.Visible = true

    SearchBox.Visible = true

    Footer.Visible = true

    --------------------------------------------------
    -- BUTTON COLORS
    --------------------------------------------------

    Tween(
        GamesButton,
        {
            BackgroundColor3 =
                Theme.Card,

            TextColor3 =
                Theme.Text
        },
        0.2
    )

    Tween(
        UpdatesButton,
        {
            BackgroundColor3 =
                Theme.Secondary,

            TextColor3 =
                Theme.SubText
        },
        0.2
    )

    --------------------------------------------------
    -- INDICATOR
    --------------------------------------------------

    Tween(
        SelectedIndicator,
        {
            Position =
                UDim2.new(
                    0,
                    2,
                    0,
                    15
                )
        },
        0.25
    )

    AnimateGameCards()

end

--------------------------------------------------

local function OpenUpdatesPage()

    GameList.Visible = false

    SearchBox.Visible = false

    Footer.Visible = false

    UpdatePage.Visible = true

    --------------------------------------------------
    -- BUTTON COLORS
    --------------------------------------------------

    Tween(
        GamesButton,
        {
            BackgroundColor3 =
                Theme.Secondary,

            TextColor3 =
                Theme.SubText
        },
        0.2
    )

    Tween(
        UpdatesButton,
        {
            BackgroundColor3 =
                Theme.Card,

            TextColor3 =
                Theme.Text
        },
        0.2
    )

    --------------------------------------------------
    -- INDICATOR
    --------------------------------------------------

    Tween(
        SelectedIndicator,
        {
            Position =
                UDim2.new(
                    0,
                    2,
                    0,
                    65
                )
        },
        0.25
    )

    AnimateUpdates()

end

--------------------------------------------------
-- SIDEBAR EVENTS
--------------------------------------------------

GamesButton.MouseButton1Click:Connect(
    function()

        Tween(
            GamesButton,
            {
                Size = UDim2.new(
                    1,
                    -6,
                    0,
                    40
                )
            },
            0.08
        )

        task.delay(
            0.08,
            function()

                Tween(
                    GamesButton,
                    {
                        Size = UDim2.new(
                            1,
                            0,
                            0,
                            42
                        )
                    },
                    0.12
                )

            end
        )

        OpenGamesPage()

    end
)

--------------------------------------------------

UpdatesButton.MouseButton1Click:Connect(
    function()

        Tween(
            UpdatesButton,
            {
                Size = UDim2.new(
                    1,
                    -6,
                    0,
                    40
                )
            },
            0.08
        )

        task.delay(
            0.08,
            function()

                Tween(
                    UpdatesButton,
                    {
                        Size = UDim2.new(
                            1,
                            0,
                            0,
                            42
                        )
                    },
                    0.12
                )

            end
        )

        OpenUpdatesPage()

    end
)

--------------------------------------------------
-- MOON ANIMATION
--------------------------------------------------

task.spawn(
    function()

        while ScreenGui.Parent do

            Tween(
                Moon,
                {
                    Rotation = 8,

                    TextColor3 =
                        Theme.Text
                },
                1.2,
                Enum.EasingStyle.Sine,
                Enum.EasingDirection.InOut
            )

            task.wait(1.2)

            Tween(
                Moon,
                {
                    Rotation = -8,

                    TextColor3 =
                        Theme.AccentLight
                },
                1.2,
                Enum.EasingStyle.Sine,
                Enum.EasingDirection.InOut
            )

            task.wait(1.2)

        end

    end
)

--------------------------------------------------
-- GLOW ANIMATION
--------------------------------------------------

task.spawn(
    function()

        while ScreenGui.Parent do

            Tween(
                Glow,
                {
                    BackgroundTransparency =
                        0.95
                },
                1.5,
                Enum.EasingStyle.Sine,
                Enum.EasingDirection.InOut
            )

            task.wait(1.5)

            Tween(
                Glow,
                {
                    BackgroundTransparency =
                        0.89
                },
                1.5,
                Enum.EasingStyle.Sine,
                Enum.EasingDirection.InOut
            )

            task.wait(1.5)

        end

    end
)

--------------------------------------------------
-- INITIAL PAGE
--------------------------------------------------

OpenGamesPage()

--------------------------------------------------
-- STARTUP NOTIFICATION
--------------------------------------------------

task.delay(
    0.8,
    function()

        Notify(
            "🌙 Lunar Hub",
            "Hub успешно запущен!",
            "success"
        )

    end
 )
            --------------------------------------------------
-- MINIMIZE SYSTEM
--------------------------------------------------

local Minimized = false

local OriginalMainSize = Main.Size

local OriginalMainPosition =
    Main.Position

--------------------------------------------------
-- MINIMIZE
--------------------------------------------------

local function MinimizeHub()

    if Minimized then
        return
    end

    Minimized = true

    --------------------------------------------------
    -- BUTTON ANIMATION
    --------------------------------------------------

    Tween(
        MinimizeButton,
        {
            Rotation = 180
        },
        0.2
    )

    --------------------------------------------------
    -- CONTENT FADE
    --------------------------------------------------

    Tween(
        Sidebar,
        {
            BackgroundTransparency = 1
        },
        0.2
    )

    Tween(
        Content,
        {
            BackgroundTransparency = 1
        },
        0.2
    )

    --------------------------------------------------
    -- SHRINK WINDOW
    --------------------------------------------------

    Tween(
        Main,
        {
            Size = UDim2.new(
                0,
                680,
                0,
                64
            )
        },
        0.35,
        Enum.EasingStyle.Back,
        Enum.EasingDirection.In
    )

end

--------------------------------------------------
-- RESTORE
--------------------------------------------------

local function RestoreHub()

    if not Minimized then
        return
    end

    Minimized = false

    --------------------------------------------------
    -- BUTTON
    --------------------------------------------------

    Tween(
        MinimizeButton,
        {
            Rotation = 0
        },
        0.2
    )

    --------------------------------------------------
    -- WINDOW
    --------------------------------------------------

    Tween(
        Main,
        {
            Size = OriginalMainSize
        },
        0.4,
        Enum.EasingStyle.Back,
        Enum.EasingDirection.Out
    )

    task.delay(
        0.15,
        function()

            Tween(
                Sidebar,
                {
                    BackgroundTransparency = 0
                },
                0.2
            )

            Tween(
                Content,
                {
                    BackgroundTransparency = 1
                },
                0.2
            )

        end
    )

end

--------------------------------------------------
-- MINIMIZE CLICK
--------------------------------------------------

MinimizeButton.MouseButton1Click:Connect(
    function()

        if Minimized then

            RestoreHub()

        else

            MinimizeHub()

        end

    end
)

--------------------------------------------------
-- CLOSE ANIMATION
--------------------------------------------------

local Closing = false

local function CloseHub()

    if Closing then
        return
    end

    Closing = true

    --------------------------------------------------
    -- BUTTON EFFECT
    --------------------------------------------------

    Tween(
        CloseButton,
        {
            Rotation = 90,

            BackgroundColor3 =
                Theme.Error
        },
        0.15
    )

    --------------------------------------------------
    -- FADE CONTENT
    --------------------------------------------------

    for _, Object in
        ipairs(Main:GetDescendants()) do

        if Object:IsA("TextLabel")
            or Object:IsA("TextButton")
            or Object:IsA("TextBox") then

            Tween(
                Object,
                {
                    TextTransparency = 1
                },
                0.18
            )

        elseif Object:IsA("ImageLabel")
            or Object:IsA("ImageButton") then

            Tween(
                Object,
                {
                    ImageTransparency = 1
                },
                0.18
            )

        end

    end

    --------------------------------------------------
    -- MAIN CLOSE
    --------------------------------------------------

    local CloseTween =
        Tween(
            Main,
            {
                Size = UDim2.new(
                    0,
                    Config.MainWidth - 70,
                    0,
                    Config.MainHeight - 70
                ),

                BackgroundTransparency = 1
            },
            Config.CloseSpeed,
            Enum.EasingStyle.Back,
            Enum.EasingDirection.In
        )

    CloseTween.Completed:Wait()

    --------------------------------------------------
    -- DESTROY
    --------------------------------------------------

    ScreenGui:Destroy()

end

--------------------------------------------------
-- CLOSE BUTTON
--------------------------------------------------

CloseButton.MouseButton1Click:Connect(
    function()

        CloseHub()

    end
)

--------------------------------------------------
-- OPEN ANIMATION
--------------------------------------------------

local function OpenHub()

    Main.Size =
        UDim2.new(
            0,
            Config.MainWidth - 100,
            0,
            Config.MainHeight - 100
        )

    Main.BackgroundTransparency = 1

    --------------------------------------------------
    -- HIDE CHILDREN
    --------------------------------------------------

    for _, Object in
        ipairs(Main:GetDescendants()) do

        if Object:IsA("TextLabel")
            or Object:IsA("TextButton")
            or Object:IsA("TextBox") then

            Object.TextTransparency = 1

        elseif Object:IsA("ImageLabel")
            or Object:IsA("ImageButton") then

            Object.ImageTransparency = 1

        end

    end

    --------------------------------------------------
    -- MAIN
    --------------------------------------------------

    Tween(
        Main,
        {
            Size = OriginalMainSize,

            BackgroundTransparency = 0
        },
        Config.OpenSpeed,
        Enum.EasingStyle.Back,
        Enum.EasingDirection.Out
    )

    --------------------------------------------------
    -- CHILDREN
    --------------------------------------------------

    task.delay(
        0.12,
        function()

            for _, Object in
                ipairs(Main:GetDescendants()) do

                if Object:IsA("TextLabel")
                    or Object:IsA("TextButton")
                    or Object:IsA("TextBox") then

                    Tween(
                        Object,
                        {
                            TextTransparency = 0
                        },
                        0.25
                    )

                elseif Object:IsA("ImageLabel")
                    or Object:IsA("ImageButton") then

                    Tween(
                        Object,
                        {
                            ImageTransparency = 0
                        },
                        0.25
                    )

                end

            end

        end
    )

end

--------------------------------------------------
-- TOUCH SUPPORT
--------------------------------------------------

local TouchStart = nil

local TouchStartPosition = nil

TopBar.InputBegan:Connect(
    function(Input)

        if Input.UserInputType ==
            Enum.UserInputType.Touch then

            TouchStart =
                Input.Position

            TouchStartPosition =
                Main.Position

        end

    end
)

TopBar.InputChanged:Connect(
    function(Input)

        if Input.UserInputType ==
            Enum.UserInputType.Touch then

            if TouchStart then

                local Delta =
                    Input.Position -
                    TouchStart

                Main.Position =
                    UDim2.new(
                        TouchStartPosition.X.Scale,
                        TouchStartPosition.X.Offset
                            + Delta.X,

                        TouchStartPosition.Y.Scale,
                        TouchStartPosition.Y.Offset
                            + Delta.Y
                    )

            end

        end

    end
)

TopBar.InputEnded:Connect(
    function(Input)

        if Input.UserInputType ==
            Enum.UserInputType.Touch then

            TouchStart = nil

        end

    end
)

--------------------------------------------------
-- WINDOW CENTERING
--------------------------------------------------

local Camera =
    workspace.CurrentCamera

if Camera then

    local Viewport =
        Camera.ViewportSize

    Main.Position =
        UDim2.new(
            0.5,
            -Config.MainWidth / 2,
            0.5,
            -Config.MainHeight / 2
        )

end

--------------------------------------------------
-- RESPONSIVE MOBILE
--------------------------------------------------

local function UpdateMobileSize()

    local CurrentCamera =
        workspace.CurrentCamera

    if not CurrentCamera then
        return
    end

    local Viewport =
        CurrentCamera.ViewportSize

    if Viewport.X < 700 then

        local Width =
            math.min(
                Viewport.X - 25,
                Config.MainWidth
            )

        local Height =
            math.min(
                Viewport.Y - 35,
                Config.MainHeight
            )

        Tween(
            Main,
            {
                Size = UDim2.new(
                    0,
                    Width,
                    0,
                    Height
                )
            },
            0.25
        )

    else

        Tween(
            Main,
            {
                Size =
                    OriginalMainSize
            },
            0.25
        )

    end

end

--------------------------------------------------
-- CAMERA RESIZE
--------------------------------------------------

if workspace.CurrentCamera then

    workspace.CurrentCamera:GetPropertyChangedSignal(
        "ViewportSize"
    ):Connect(
        function()

            UpdateMobileSize()

        end
    )

end

--------------------------------------------------
-- INITIAL STATE
--------------------------------------------------

GamesButton.BackgroundColor3 =
    Theme.Card

GamesButton.TextColor3 =
    Theme.Text

UpdatesButton.BackgroundColor3 =
    Theme.Secondary

UpdatesButton.TextColor3 =
    Theme.SubText

--------------------------------------------------
-- OPEN HUB
--------------------------------------------------

task.wait(0.1)

OpenHub()

--------------------------------------------------
-- FINAL NOTIFICATION
--------------------------------------------------

task.delay(
    1,
    function()

        if not Closing then

            Notify(
                "🌙 Lunar Hub",
                "Добро пожаловать в Lunar Hub!",
                "success"
            )

        end

    end
)

--------------------------------------------------
-- END
--------------------------------------------------

print(
    "[Lunar Hub] v"
    .. VERSION
    .. " loaded successfully."
)
