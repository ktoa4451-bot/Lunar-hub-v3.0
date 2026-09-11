--[[
    🌙 LUNAR HUB v32.0
    NEW UI
    PART 1A / 2
]]

local VERSION = "32.0"

--// SERVICES
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local LocalPlayer = Players.LocalPlayer

--//==================================================
--// CONFIG
--//==================================================

local Config = {
    Width = 720,
    Height = 510,

    SidebarWidth = 165,
    TopBarHeight = 76,

    Corner = 18,
    CardCorner = 14,
    ButtonCorner = 12,

    Animation = 0.22,
    FastAnimation = 0.12,

    MobileWidth = 610,
    MobileHeight = 470
}

--//==================================================
--// THEME
--//==================================================

local Theme = {
    Background = Color3.fromRGB(10, 8, 22),
    Background2 = Color3.fromRGB(15, 11, 32),

    Sidebar = Color3.fromRGB(13, 10, 29),
    Content = Color3.fromRGB(12, 9, 26),

    Card = Color3.fromRGB(24, 18, 48),
    CardHover = Color3.fromRGB(34, 24, 65),

    Button = Color3.fromRGB(27, 19, 55),
    ButtonHover = Color3.fromRGB(72, 38, 145),

    Accent = Color3.fromRGB(157, 72, 255),
    Accent2 = Color3.fromRGB(113, 45, 220),
    AccentLight = Color3.fromRGB(195, 130, 255),

    Border = Color3.fromRGB(125, 48, 220),

    Text = Color3.fromRGB(245, 240, 255),
    SubText = Color3.fromRGB(160, 145, 195),

    Success = Color3.fromRGB(100, 230, 150),
    Error = Color3.fromRGB(255, 90, 110)
}

--//==================================================
--// GAME LIST
--//==================================================

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

--//==================================================
--// HELPER FUNCTIONS
--//==================================================

local function Create(className, properties)
    local object = Instance.new(className)

    for property, value in pairs(properties or {}) do
        object[property] = value
    end

    return object
end


local function AddCorner(parent, radius)
    local corner = Instance.new("UICorner")

    corner.CornerRadius = UDim.new(
        0,
        radius
    )

    corner.Parent = parent

    return corner
end


local function AddStroke(
    parent,
    color,
    thickness,
    transparency
)
    local stroke = Instance.new("UIStroke")

    stroke.Color = color or Theme.Border

    stroke.Thickness = thickness or 1

    stroke.Transparency =
        transparency or 0

    stroke.ApplyStrokeMode =
        Enum.ApplyStrokeMode.Border

    stroke.Parent = parent

    return stroke
end


local function Tween(
    object,
    properties,
    duration
)
    if not object then
        return
    end

    local tween = TweenService:Create(
        object,

        TweenInfo.new(
            duration or Config.Animation,
            Enum.EasingStyle.Quint,
            Enum.EasingDirection.Out
        ),

        properties
    )

    tween:Play()

    return tween
end


local function SetVisible(
    object,
    visible
)
    if object then
        object.Visible = visible
    end
end


--//==================================================
--// SAFE DESTROY
--//==================================================

local OldGui

pcall(function()
    OldGui = game:GetService("CoreGui"):FindFirstChild(
        "LunarHub"
    )
end)

if OldGui then
    OldGui:Destroy()
end


--//==================================================
--// SCREEN GUI
--//==================================================

local ScreenGui = Create("ScreenGui", {

    Name = "LunarHub",

    Parent = game:GetService("CoreGui"),

    ResetOnSpawn = false,

    IgnoreGuiInset = true,

    ZIndexBehavior =
        Enum.ZIndexBehavior.Sibling
})


--//==================================================
--// OUTER GLOW
--//==================================================

local Glow = Create("Frame", {

    Name = "Glow",

    Parent = ScreenGui,

    AnchorPoint =
        Vector2.new(0.5, 0.5),

    Position =
        UDim2.fromScale(0.5, 0.5),

    Size = UDim2.new(
        0,
        Config.Width + 18,
        0,
        Config.Height + 18
    ),

    BackgroundColor3 =
        Theme.Accent,

    BackgroundTransparency =
        0.78,

    BorderSizePixel = 0,

    ZIndex = 1
})

AddCorner(
    Glow,
    Config.Corner + 5
)


--//==================================================
--// MAIN WINDOW
--//==================================================

local Main = Create("Frame", {

    Name = "Main",

    Parent = ScreenGui,

    AnchorPoint =
        Vector2.new(0.5, 0.5),

    Position =
        UDim2.fromScale(0.5, 0.5),

    Size = UDim2.new(
        0,
        Config.Width,
        0,
        Config.Height
    ),

    BackgroundColor3 =
        Theme.Background,

    BorderSizePixel = 0,

    ClipsDescendants = true,

    ZIndex = 2
})

-- ГЛАВНОЕ СКРУГЛЕНИЕ ОКНА
AddCorner(
    Main,
    Config.Corner
)

AddStroke(
    Main,
    Theme.Accent,
    2,
    0.08
)


--//==================================================
--// TOP BAR
--//==================================================

local TopBar = Create("Frame", {

    Name = "TopBar",

    Parent = Main,

    Position =
        UDim2.new(0, 0, 0, 0),

    Size = UDim2.new(
        1,
        0,
        0,
        Config.TopBarHeight
    ),

    BackgroundColor3 =
        Theme.Background2,

    BorderSizePixel = 0,

    ZIndex = 5
})


local TopLine = Create("Frame", {

    Name = "TopLine",

    Parent = TopBar,

    Position =
        UDim2.new(
            0,
            0,
            1,
            -1
        ),

    Size =
        UDim2.new(
            1,
            0,
            0,
            1
        ),

    BackgroundColor3 =
        Theme.Accent,

    BackgroundTransparency =
        0.55,

    BorderSizePixel = 0,

    ZIndex = 6
})


--//==================================================
--// LOGO
--//==================================================

local Logo = Create("Frame", {

    Name = "Logo",

    Parent = TopBar,

    Position =
        UDim2.new(
            0,
            18,
            0.5,
            -21
        ),

    Size =
        UDim2.fromOffset(
            42,
            42
        ),

    BackgroundColor3 =
        Theme.Accent2,

    BorderSizePixel = 0,

    ZIndex = 6
})

AddCorner(
    Logo,
    12
)

AddStroke(
    Logo,
    Theme.AccentLight,
    1,
    0.35
)


local LogoSymbol = Create("TextLabel", {

    Name = "Symbol",

    Parent = Logo,

    Size =
        UDim2.fromScale(
            1,
            1
        ),

    BackgroundTransparency = 1,

    Text = "☾",

    TextColor3 =
        Theme.Text,

    TextSize = 25,

    Font =
        Enum.Font.GothamBold,

    TextXAlignment =
        Enum.TextXAlignment.Center,

    TextYAlignment =
        Enum.TextYAlignment.Center,

    ZIndex = 7
})


--//==================================================
--// TITLE
--//==================================================

local Title = Create("TextLabel", {

    Name = "Title",

    Parent = TopBar,

    Position =
        UDim2.new(
            0,
            72,
            0,
            14
        ),

    Size =
        UDim2.new(
            0,
            300,
            0,
            28
        ),

    BackgroundTransparency = 1,

    Text = "LUNAR HUB",

    TextColor3 =
        Theme.Text,

    TextSize = 21,

    Font =
        Enum.Font.GothamBold,

    TextXAlignment =
        Enum.TextXAlignment.Left,

    ZIndex = 6
})


local VersionText = Create("TextLabel", {

    Name = "Version",

    Parent = TopBar,

    Position =
        UDim2.new(
            0,
            73,
            0,
            42
        ),

    Size =
        UDim2.new(
            0,
            250,
            0,
            18
        ),

    BackgroundTransparency = 1,

    Text =
        "NEON EDITION • v" .. VERSION,

    TextColor3 =
        Theme.AccentLight,

    TextSize = 11,

    Font =
        Enum.Font.GothamMedium,

    TextXAlignment =
        Enum.TextXAlignment.Left,

    ZIndex = 6
})


--//==================================================
--// MINIMIZE BUTTON
--//==================================================

local MinimizeButton = Create(
    "TextButton",
    {

        Name = "Minimize",

        Parent = TopBar,

        AnchorPoint =
            Vector2.new(
                1,
                0.5
            ),

        Position =
            UDim2.new(
                1,
                -62,
                0.5,
                0
            ),

        Size =
            UDim2.fromOffset(
                42,
                42
            ),

        BackgroundColor3 =
            Theme.Button,

        BorderSizePixel = 0,

        AutoButtonColor = false,

        Text = "—",

        TextColor3 =
            Theme.Text,

        TextSize = 20,

        Font =
            Enum.Font.GothamBold,

        ZIndex = 7
    }
)

AddCorner(
    MinimizeButton,
    Config.ButtonCorner
)

AddStroke(
    MinimizeButton,
    Theme.Accent2,
    1,
    0.35
)


--//==================================================
--// CLOSE BUTTON
--//==================================================

local CloseButton = Create(
    "TextButton",
    {

        Name = "Close",

        Parent = TopBar,

        AnchorPoint =
            Vector2.new(
                1,
                0.5
            ),

        Position =
            UDim2.new(
                1,
                -14,
                0.5,
                0
            ),

        Size =
            UDim2.fromOffset(
                42,
                42
            ),

        BackgroundColor3 =
            Theme.Button,

        BorderSizePixel = 0,

        AutoButtonColor = false,

        Text = "×",

        TextColor3 =
            Theme.Text,

        TextSize = 24,

        Font =
            Enum.Font.GothamBold,

        ZIndex = 7
    }
)

AddCorner(
    CloseButton,
    Config.ButtonCorner
)

AddStroke(
    CloseButton,
    Theme.Accent2,
    1,
    0.35
)


--//==================================================
--// BUTTON HOVER
--//==================================================

local function SetupTopButtonHover(button)
    button.MouseEnter:Connect(function()

        Tween(
            button,
            {
                BackgroundColor3 =
                    Theme.ButtonHover
            },
            Config.FastAnimation
        )

    end)


    button.MouseLeave:Connect(function()

        Tween(
            button,
            {
                BackgroundColor3 =
                    Theme.Button
            },
            Config.FastAnimation
        )

    end)
end


SetupTopButtonHover(
    MinimizeButton
)

SetupTopButtonHover(
    CloseButton
)


print(
    "🌙 Lunar Hub v" ..
    VERSION ..
    " - Part 1A loaded"
)
--[[
    🌙 LUNAR HUB v32.0
    NEW UI
    PART 1B / 2
]]

--//==================================================
--// BODY
--//==================================================

local Body = Create("Frame", {
    Name = "Body",
    Parent = Main,

    Position = UDim2.new(
        0, 0,
        0, Config.TopBarHeight
    ),

    Size = UDim2.new(
        1, 0,
        1, -Config.TopBarHeight
    ),

    BackgroundTransparency = 1,
    BorderSizePixel = 0,

    ZIndex = 3
})


--//==================================================
--// SIDEBAR
--//==================================================

local Sidebar = Create("Frame", {
    Name = "Sidebar",
    Parent = Body,

    Position = UDim2.new(0, 0, 0, 0),

    Size = UDim2.new(
        0,
        Config.SidebarWidth,
        1,
        0
    ),

    BackgroundColor3 = Theme.Sidebar,

    BorderSizePixel = 0,

    ClipsDescendants = true,

    ZIndex = 4
})


local SidebarLine = Create("Frame", {
    Name = "SidebarLine",
    Parent = Sidebar,

    Position = UDim2.new(
        1, -1,
        0, 0
    ),

    Size = UDim2.new(
        0, 1,
        1, 0
    ),

    BackgroundColor3 = Theme.Accent,

    BackgroundTransparency = 0.65,

    BorderSizePixel = 0,

    ZIndex = 5
})


--//==================================================
--// SIDEBAR TITLE
--//==================================================

local SidebarTitle = Create("TextLabel", {
    Name = "SidebarTitle",
    Parent = Sidebar,

    Position = UDim2.new(
        0, 18,
        0, 20
    ),

    Size = UDim2.new(
        1, -36,
        0, 25
    ),

    BackgroundTransparency = 1,

    Text = "LUNAR",

    TextColor3 = Theme.AccentLight,

    TextSize = 18,

    Font = Enum.Font.GothamBold,

    TextXAlignment = Enum.TextXAlignment.Left,

    ZIndex = 6
})


local SidebarTitleLine = Create("Frame", {
    Name = "TitleLine",
    Parent = Sidebar,

    Position = UDim2.new(
        0, 18,
        0, 55
    ),

    Size = UDim2.new(
        1, -36,
        0, 2
    ),

    BackgroundColor3 = Theme.Accent,

    BorderSizePixel = 0,

    ZIndex = 6
})

AddCorner(
    SidebarTitleLine,
    2
)


--//==================================================
--// SIDEBAR BUTTON CREATOR
--//==================================================

local function CreateSidebarButton(
    name,
    text,
    icon,
    y
)

    local button = Create("TextButton", {
        Name = name,
        Parent = Sidebar,

        Position = UDim2.new(
            0, 12,
            0, y
        ),

        Size = UDim2.new(
            1, -24,
            0, 46
        ),

        BackgroundColor3 = Theme.Button,

        BackgroundTransparency = 1,

        BorderSizePixel = 0,

        AutoButtonColor = false,

        Text = "",

        ZIndex = 7
    })

    AddCorner(
        button,
        Config.ButtonCorner
    )


    local Icon = Create("TextLabel", {
        Name = "Icon",
        Parent = button,

        Position = UDim2.new(
            0, 10,
            0, 0
        ),

        Size = UDim2.fromOffset(
            30,
            46
        ),

        BackgroundTransparency = 1,

        Text = icon,

        TextColor3 = Theme.SubText,

        TextSize = 19,

        Font = Enum.Font.GothamBold,

        TextXAlignment =
            Enum.TextXAlignment.Center,

        TextYAlignment =
            Enum.TextYAlignment.Center,

        ZIndex = 8
    })


    local Label = Create("TextLabel", {
        Name = "Label",
        Parent = button,

        Position = UDim2.new(
            0, 48,
            0, 0
        ),

        Size = UDim2.new(
            1, -58,
            1, 0
        ),

        BackgroundTransparency = 1,

        Text = text,

        TextColor3 = Theme.SubText,

        TextSize = 14,

        Font = Enum.Font.GothamMedium,

        TextXAlignment =
            Enum.TextXAlignment.Left,

        TextYAlignment =
            Enum.TextYAlignment.Center,

        ZIndex = 8
    })


    --// HOVER

    button.MouseEnter:Connect(function()

        Tween(
            button,
            {
                BackgroundTransparency = 0,
                BackgroundColor3 =
                    Theme.ButtonHover
            },
            Config.FastAnimation
        )

        Tween(
            Icon,
            {
                TextColor3 =
                    Theme.AccentLight
            },
            Config.FastAnimation
        )

        Tween(
            Label,
            {
                TextColor3 =
                    Theme.Text
            },
            Config.FastAnimation
        )

    end)


    button.MouseLeave:Connect(function()

        if button:GetAttribute(
            "Selected"
        ) then
            return
        end

        Tween(
            button,
            {
                BackgroundTransparency = 1
            },
            Config.FastAnimation
        )

        Tween(
            Icon,
            {
                TextColor3 =
                    Theme.SubText
            },
            Config.FastAnimation
        )

        Tween(
            Label,
            {
                TextColor3 =
                    Theme.SubText
            },
            Config.FastAnimation
        )

    end)


    return button, Icon, Label
end


--//==================================================
--// GAMES
--//==================================================

local GamesButton,
    GamesIcon,
    GamesLabel =
    CreateSidebarButton(
        "GamesButton",
        "Games",
        "🎮",
        78
    )


--//==================================================
--// UPDATES
--//==================================================

local UpdatesButton,
    UpdatesIcon,
    UpdatesLabel =
    CreateSidebarButton(
        "UpdatesButton",
        "Updates",
        "↻",
        132
    )


--//==================================================
--// SELECTED INDICATOR
--//==================================================

local SelectedIndicator = Create("Frame", {
    Name = "SelectedIndicator",
    Parent = Sidebar,

    Position = UDim2.new(
        0, 4,
        0, 88
    ),

    Size = UDim2.new(
        0, 3,
        0, 26
    ),

    BackgroundColor3 =
        Theme.AccentLight,

    BorderSizePixel = 0,

    ZIndex = 10
})

AddCorner(
    SelectedIndicator,
    3
)


--//==================================================
--// SIDEBAR FOOTER
--//==================================================

local SidebarFooterIcon = Create("TextLabel", {
    Name = "FooterIcon",
    Parent = Sidebar,

    AnchorPoint =
        Vector2.new(0.5, 1),

    Position = UDim2.new(
        0.5, 0,
        1, -38
    ),

    Size = UDim2.fromOffset(
        35,
        35
    ),

    BackgroundTransparency = 1,

    Text = "☾",

    TextColor3 =
        Theme.AccentLight,

    TextSize = 30,

    Font = Enum.Font.GothamBold,

    TextXAlignment =
        Enum.TextXAlignment.Center,

    TextYAlignment =
        Enum.TextYAlignment.Center,

    ZIndex = 6
})


local SidebarFooter = Create("TextLabel", {
    Name = "Footer",
    Parent = Sidebar,

    AnchorPoint =
        Vector2.new(0.5, 1),

    Position = UDim2.new(
        0.5, 0,
        1, -10
    ),

    Size = UDim2.new(
        1, -20,
        0, 18
    ),

    BackgroundTransparency = 1,

    Text =
        "LUNAR HUB • v" ..
        VERSION,

    TextColor3 =
        Theme.SubText,

    TextSize = 9,

    Font = Enum.Font.GothamMedium,

    TextXAlignment =
        Enum.TextXAlignment.Center,

    ZIndex = 6
})


--//==================================================
--// CONTENT
--//==================================================

local Content = Create("Frame", {
    Name = "Content",
    Parent = Body,

    Position = UDim2.new(
        0,
        Config.SidebarWidth,
        0,
        0
    ),

    Size = UDim2.new(
        1,
        -Config.SidebarWidth,
        1,
        0
    ),

    BackgroundColor3 =
        Theme.Content,

    BorderSizePixel = 0,

    ClipsDescendants = true,

    ZIndex = 4
})


--//==================================================
--// SEARCH
--//==================================================

local SearchContainer = Create("Frame", {
    Name = "SearchContainer",
    Parent = Content,

    Position = UDim2.new(
        0, 20,
        0, 18
    ),

    Size = UDim2.new(
        1, -40,
        0, 44
    ),

    BackgroundColor3 =
        Theme.Card,

    BorderSizePixel = 0,

    ClipsDescendants = true,

    ZIndex = 6
})

AddCorner(
    SearchContainer,
    Config.CardCorner
)

AddStroke(
    SearchContainer,
    Theme.Accent2,
    1,
    0.55
)


local SearchIcon = Create("TextLabel", {
    Name = "SearchIcon",
    Parent = SearchContainer,

    Position = UDim2.new(
        0, 12,
        0, 0
    ),

    Size = UDim2.fromOffset(
        30,
        44
    ),

    BackgroundTransparency = 1,

    Text = "⌕",

    TextColor3 =
        Theme.AccentLight,

    TextSize = 24,

    Font = Enum.Font.GothamBold,

    TextXAlignment =
        Enum.TextXAlignment.Center,

    TextYAlignment =
        Enum.TextYAlignment.Center,

    ZIndex = 7
})


local SearchBox = Create("TextBox", {
    Name = "SearchBox",
    Parent = SearchContainer,

    Position = UDim2.new(
        0, 48,
        0, 0
    ),

    Size = UDim2.new(
        1, -58,
        1, 0
    ),

    BackgroundTransparency = 1,

    ClearTextOnFocus = false,

    PlaceholderText =
        "Search games...",

    PlaceholderColor3 =
        Theme.SubText,

    Text = "",

    TextColor3 =
        Theme.Text,

    TextSize = 13,

    Font = Enum.Font.GothamMedium,

    TextXAlignment =
        Enum.TextXAlignment.Left,

    ZIndex = 7
})


--//==================================================
--// GAME LIST
--//==================================================

local GameList = Create("ScrollingFrame", {
    Name = "GameList",
    Parent = Content,

    Position = UDim2.new(
        0, 20,
        0, 76
    ),

    Size = UDim2.new(
        1, -40,
        1, -94
    ),

    BackgroundTransparency = 1,

    BorderSizePixel = 0,

    ScrollBarThickness = 3,

    ScrollBarImageColor3 =
        Theme.Accent,

    ScrollBarImageTransparency =
        0.25,

    CanvasSize = UDim2.new(
        0, 0,
        0, 0
    ),

    AutomaticCanvasSize =
        Enum.AutomaticSize.Y,

    ClipsDescendants = true,

    ZIndex = 5
})


local GameListPadding = Create(
    "UIPadding",
    {
        Parent = GameList,

        PaddingTop =
            UDim.new(0, 2),

        PaddingBottom =
            UDim.new(0, 8),

        PaddingLeft =
            UDim.new(0, 2),

        PaddingRight =
            UDim.new(0, 4)
    }
)


local GameListLayout = Create(
    "UIListLayout",
    {
        Parent = GameList,

        FillDirection =
            Enum.FillDirection.Vertical,

        HorizontalAlignment =
            Enum.HorizontalAlignment.Center,

        SortOrder =
            Enum.SortOrder.LayoutOrder,

        Padding =
            UDim.new(0, 10)
    }
)


--//==================================================
--// EMPTY SEARCH
--//==================================================

local EmptySearch = Create("TextLabel", {
    Name = "EmptySearch",
    Parent = Content,

    AnchorPoint =
        Vector2.new(0.5, 0.5),

    Position = UDim2.new(
        0.5, 0,
        0.5, 20
    ),

    Size = UDim2.new(
        1, -60,
        0, 60
    ),

    BackgroundTransparency = 1,

    Text = "No games found",

    TextColor3 =
        Theme.SubText,

    TextSize = 15,

    Font = Enum.Font.GothamMedium,

    TextXAlignment =
        Enum.TextXAlignment.Center,

    TextYAlignment =
        Enum.TextYAlignment.Center,

    Visible = false,

    ZIndex = 10
})


--//==================================================
--// UPDATES PAGE
--//==================================================

local UpdatePage = Create("Frame", {
    Name = "UpdatePage",
    Parent = Content,

    Position = UDim2.new(
        0, 20,
        0, 18
    ),

    Size = UDim2.new(
        1, -40,
        1, -36
    ),

    BackgroundTransparency = 1,

    Visible = false,

    ClipsDescendants = true,

    ZIndex = 8
})


local UpdateTitle = Create("TextLabel", {
    Name = "UpdateTitle",
    Parent = UpdatePage,

    Position = UDim2.new(
        0, 0,
        0, 0
    ),

    Size = UDim2.new(
        1, 0,
        0, 32
    ),

    BackgroundTransparency = 1,

    Text = "Updates",

    TextColor3 =
        Theme.Text,

    TextSize = 22,

    Font = Enum.Font.GothamBold,

    TextXAlignment =
        Enum.TextXAlignment.Left,

    ZIndex = 9
})


local UpdateVersion = Create("TextLabel", {
    Name = "UpdateVersion",
    Parent = UpdatePage,

    Position = UDim2.new(
        0, 0,
        0, 34
    ),

    Size = UDim2.new(
        1, 0,
        0, 22
    ),

    BackgroundTransparency = 1,

    Text =
        "Lunar Hub v" ..
        VERSION,

    TextColor3 =
        Theme.AccentLight,

    TextSize = 12,

    Font = Enum.Font.GothamMedium,

    TextXAlignment =
        Enum.TextXAlignment.Left,

    ZIndex = 9
})


local UpdateCard = Create("Frame", {
    Name = "UpdateCard",
    Parent = UpdatePage,

    Position = UDim2.new(
        0, 0,
        0, 78
    ),

    Size = UDim2.new(
        1, 0,
        0, 180
    ),

    BackgroundColor3 =
        Theme.Card,

    BorderSizePixel = 0,

    ClipsDescendants = true,

    ZIndex = 9
})

AddCorner(
    UpdateCard,
    Config.CardCorner
)

AddStroke(
    UpdateCard,
    Theme.Accent2,
    1,
    0.45
)


local UpdateCardTitle = Create("TextLabel", {
    Name = "Title",
    Parent = UpdateCard,

    Position = UDim2.new(
        0, 18,
        0, 18
    ),

    Size = UDim2.new(
        1, -36,
        0, 26
    ),

    BackgroundTransparency = 1,

    Text =
        "🌙 Lunar Hub v" ..
        VERSION,

    TextColor3 =
        Theme.Text,

    TextSize = 17,

    Font = Enum.Font.GothamBold,

    TextXAlignment =
        Enum.TextXAlignment.Left,

    ZIndex = 10
})


local UpdateText = Create("TextLabel", {
    Name = "Text",
    Parent = UpdateCard,

    Position = UDim2.new(
        0, 18,
        0, 54
    ),

    Size = UDim2.new(
        1, -36,
        0, 100
    ),

    BackgroundTransparency = 1,

    Text =
        "• New interface" ..
        "\n• Fixed rounded UI" ..
        "\n• Removed duplicated navigation" ..
        "\n• Improved game cards" ..
        "\n• Better mobile layout",

    TextColor3 =
        Theme.SubText,

    TextSize = 13,

    Font = Enum.Font.GothamMedium,

    TextWrapped = true,

    TextXAlignment =
        Enum.TextXAlignment.Left,

    TextYAlignment =
        Enum.TextYAlignment.Top,

    ZIndex = 10
})


--//==================================================
--// PAGE SWITCHING
--//==================================================

local CurrentPage = "Games"


local function SelectGames()

    CurrentPage = "Games"

    GameList.Visible = true

    SearchContainer.Visible = true

    EmptySearch.Visible = false

    UpdatePage.Visible = false

    GamesButton:SetAttribute(
        "Selected",
        true
    )

    UpdatesButton:SetAttribute(
        "Selected",
        false
    )

    Tween(
        SelectedIndicator,
        {
            Position = UDim2.new(
                0, 4,
                0, 88
            )
        }
    )

    Tween(
        GamesButton,
        {
            BackgroundTransparency = 0,
            BackgroundColor3 =
                Theme.ButtonHover
        }
    )

    Tween(
        GamesLabel,
        {
            TextColor3 =
                Theme.Text
        }
    )

    Tween(
        GamesIcon,
        {
            TextColor3 =
                Theme.AccentLight
        }
    )

    Tween(
        UpdatesButton,
        {
            BackgroundTransparency = 1
        }
    )

    Tween(
        UpdatesLabel,
        {
            TextColor3 =
                Theme.SubText
        }
    )

    Tween(
        UpdatesIcon,
        {
            TextColor3 =
                Theme.SubText
        }
    )
end


local function SelectUpdates()

    CurrentPage = "Updates"

    GameList.Visible = false

    SearchContainer.Visible = false

    EmptySearch.Visible = false

    UpdatePage.Visible = true

    GamesButton:SetAttribute(
        "Selected",
        false
    )

    UpdatesButton:SetAttribute(
        "Selected",
        true
    )

    Tween(
        SelectedIndicator,
        {
            Position = UDim2.new(
                0, 4,
                0, 142
            )
        }
    )

    Tween(
        UpdatesButton,
        {
            BackgroundTransparency = 0,
            BackgroundColor3 =
                Theme.ButtonHover
        }
    )

    Tween(
        UpdatesLabel,
        {
            TextColor3 =
                Theme.Text
        }
    )

    Tween(
        UpdatesIcon,
        {
            TextColor3 =
                Theme.AccentLight
        }
    )

    Tween(
        GamesButton,
        {
            BackgroundTransparency = 1
        }
    )

    Tween(
        GamesLabel,
        {
            TextColor3 =
                Theme.SubText
        }
    )

    Tween(
        GamesIcon,
        {
            TextColor3 =
                Theme.SubText
        }
    )
end


GamesButton.MouseButton1Click:Connect(
    SelectGames
)

UpdatesButton.MouseButton1Click:Connect(
    SelectUpdates
)


--//==================================================
--// SEARCH
--//==================================================

SearchBox:GetPropertyChangedSignal(
    "Text"
):Connect(function()

    if CurrentPage ~= "Games" then
        return
    end

    local query = string.lower(
        SearchBox.Text or ""
    )

    local found = 0

    for _, gameData in ipairs(
        Games
    ) do

        local card =
            GameList:FindFirstChild(
                gameData.Name
            )

        if card then

            local gameName =
                string.lower(
                    gameData.Name
                )

            local description =
                string.lower(
                    gameData.Description
                )

            local matches =
                query == ""
                or string.find(
                    gameName,
                    query,
                    1,
                    true
                )
                or string.find(
                    description,
                    query,
                    1,
                    true
                )

            card.Visible = matches

            if matches then
                found += 1
            end
        end
    end

    EmptySearch.Visible =
        query ~= ""
        and found == 0
end


--//==================================================
--// DEFAULT PAGE
--//==================================================

SelectGames()


print(
    "🌙 Lunar Hub v" ..
    VERSION ..
    " - Part 1B loaded"
)
