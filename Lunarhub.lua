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
--[[
    🌙 LUNAR HUB v32.0
    NEW UI
    PART 2B / 2
]]

-- =========================================
-- SEARCH SYSTEM
-- =========================================

local function UpdateSearch()
    local query = string.lower(SearchBox.Text or "")
    local found = false

    for gameName, data in pairs(GameCards) do
        if data.Card then

            local nameMatch = string.find(
                string.lower(gameName),
                query,
                1,
                true
            )

            local descriptionMatch = false

            if data.Description then
                descriptionMatch = string.find(
                    string.lower(data.Description.Text or ""),
                    query,
                    1,
                    true
                )
            end

            local visible = (
                query == ""
                or nameMatch
                or descriptionMatch
            )

            data.Card.Visible = visible

            if visible then
                found = true
            end
        end
    end

    if EmptySearch then
        EmptySearch.Visible = not found
    end
end


if SearchBox then
    SearchBox:GetPropertyChangedSignal("Text"):Connect(
        UpdateSearch
    )
end


-- =========================================
-- EMPTY SEARCH MESSAGE
-- =========================================

if EmptySearch then
    EmptySearch.Text = "NO GAMES FOUND"
    EmptySearch.Font = Enum.Font.GothamBold
    EmptySearch.TextSize = 16
    EmptySearch.TextColor3 = Theme.SubText
    EmptySearch.TextXAlignment = Enum.TextXAlignment.Center
    EmptySearch.TextYAlignment = Enum.TextYAlignment.Center
end


-- =========================================
-- GAME LIST SCROLLBAR
-- =========================================

GameList.ScrollBarThickness = 4
GameList.ScrollBarImageColor3 = Theme.Accent
GameList.ScrollBarImageTransparency = 0.25
GameList.ScrollingDirection = Enum.ScrollingDirection.Y


-- =========================================
-- UPDATE PAGE
-- =========================================

local function RefreshUpdatePage()

    if UpdateVersion then
        UpdateVersion.Text =
            "CURRENT VERSION  •  v"
            .. VERSION
    end

    if UpdateText then
        UpdateText.Text =
            "Welcome to Lunar Hub v"
            .. VERSION
            .. ".\n\n"
            .. "• New redesigned interface\n"
            .. "• Improved game cards\n"
            .. "• Search system\n"
            .. "• Better animations\n"
            .. "• Cleaner sidebar\n"
            .. "• Improved mobile support\n\n"
            .. "Lunar Hub is ready."
    end
end


-- =========================================
-- PAGE SWITCH ANIMATION
-- =========================================

local PageBusy = false

local function AnimatePage(page, visible)

    if PageBusy then
        return
    end

    PageBusy = true

    if visible then

        page.Visible = true
        page.Position = UDim2.new(
            0,
            25,
            0,
            76
        )

        Tween(
            page,
            {
                Position = UDim2.new(
                    0,
                    0,
                    0,
                    76
                )
            },
            Config.Animation
        )

        task.delay(
            Config.Animation,
            function()
                PageBusy = false
            end
        )

    else

        Tween(
            page,
            {
                Position = UDim2.new(
                    0,
                    -25,
                    0,
                    76
                )
            },
            Config.Animation
        )

        task.delay(
            Config.Animation,
            function()

                if page then
                    page.Visible = false
                end

                PageBusy = false
            end
        )
    end
end


-- =========================================
-- REDEFINE PAGE SELECT
-- =========================================

local function ShowGamesPage()

    CurrentPage = "Games"

    GameList.Visible = true
    UpdatePage.Visible = false

    SearchContainer.Visible = true

    if SelectedIndicator then
        Tween(
            SelectedIndicator,
            {
                Position = UDim2.new(
                    0,
                    4,
                    0,
                    88
                )
            },
            Config.Animation
        )
    end

    if GamesButton then
        Tween(
            GamesButton,
            {
                BackgroundColor3 = Theme.ButtonHover
            },
            Config.Animation
        )
    end

    if UpdatesButton then
        Tween(
            UpdatesButton,
            {
                BackgroundColor3 = Theme.Button
            },
            Config.Animation
        )
    end
end


local function ShowUpdatesPage()

    CurrentPage = "Updates"

    GameList.Visible = false
    UpdatePage.Visible = true

    SearchContainer.Visible = false

    RefreshUpdatePage()

    if SelectedIndicator then
        Tween(
            SelectedIndicator,
            {
                Position = UDim2.new(
                    0,
                    4,
                    0,
                    142
                )
            },
            Config.Animation
        )
    end

    if GamesButton then
        Tween(
            GamesButton,
            {
                BackgroundColor3 = Theme.Button
            },
            Config.Animation
        )
    end

    if UpdatesButton then
        Tween(
            UpdatesButton,
            {
                BackgroundColor3 = Theme.ButtonHover
            },
            Config.Animation
        )
    end
end


-- =========================================
-- SIDEBAR BUTTON EVENTS
-- =========================================

if GamesButton then
    GamesButton.MouseButton1Click:Connect(
        function()
            ShowGamesPage()
        end
    )
end


if UpdatesButton then
    UpdatesButton.MouseButton1Click:Connect(
        function()
            ShowUpdatesPage()
        end
    )
end


-- =========================================
-- INITIAL PAGE
-- =========================================

ShowGamesPage()


-- =========================================
-- RESPONSIVE SIZE
-- =========================================

local Camera = workspace.CurrentCamera

local function UpdateResponsiveSize()

    if not Main or not Camera then
        return
    end

    local viewport = Camera.ViewportSize

    local width = Config.Width
    local height = Config.Height

    if viewport.X < 700 then
        width = Config.MobileWidth
        height = Config.MobileHeight
    end

    if viewport.X < 480 then
        width = math.max(
            340,
            viewport.X - 20
        )

        height = math.max(
            420,
            viewport.Y - 40
        )
    end

    if viewport.Y < 550 then
        height = math.max(
            400,
            viewport.Y - 30
        )
    end

    Main.Size = UDim2.new(
        0,
        width,
        0,
        height
    )

    Glow.Size = UDim2.new(
        0,
        width + 18,
        0,
        height + 18
    )
end


if Camera then
    Camera:GetPropertyChangedSignal(
        "ViewportSize"
    ):Connect(UpdateResponsiveSize)
end

UpdateResponsiveSize()


-- =========================================
-- MINIMIZE SYSTEM
-- =========================================

local Minimized = false

local NormalSize = Main.Size

MinimizeButton.MouseButton1Click:Connect(
    function()

        if Minimized then

            Minimized = false

            Body.Visible = true

            Tween(
                Main,
                {
                    Size = NormalSize
                },
                Config.Animation
            )

            Tween(
                Glow,
                {
                    Size = UDim2.new(
                        0,
                        NormalSize.X.Offset + 18,
                        0,
                        NormalSize.Y.Offset + 18
                    )
                },
                Config.Animation
            )

        else

            Minimized = true

            Tween(
                Main,
                {
                    Size = UDim2.new(
                        0,
                        NormalSize.X.Offset,
                        0,
                        Config.TopBarHeight
                    )
                },
                Config.Animation
            )

            Tween(
                Glow,
                {
                    Size = UDim2.new(
                        0,
                        NormalSize.X.Offset + 18,
                        0,
                        Config.TopBarHeight + 18
                    )
                },
                Config.Animation
            )

            task.delay(
                Config.Animation,
                function()

                    if Minimized then
                        Body.Visible = false
                    end
                end
            )
        end
    end
)


-- =========================================
-- CLOSE BUTTON
-- =========================================

local Closed = false

CloseButton.MouseButton1Click:Connect(
    function()

        if Closed then
            return
        end

        Closed = true

        Tween(
            Main,
            {
                Size = UDim2.new(
                    0,
                    0,
                    0,
                    0
                )
            },
            0.28
        )

        Tween(
            Glow,
            {
                Size = UDim2.new(
                    0,
                    0,
                    0,
                    0
                )
            },
            0.28
        )

        task.delay(
            0.32,
            function()

                if ScreenGui then
                    ScreenGui:Destroy()
                end
            end
        )
    end
)


-- =========================================
-- DRAG SYSTEM
-- =========================================

local Dragging = false
local DragStart = nil
local StartPosition = nil

local function UpdateDrag(input)

    if not Dragging then
        return
    end

    local Delta =
        input.Position - DragStart

    Main.Position = UDim2.new(
        StartPosition.X.Scale,
        StartPosition.X.Offset + Delta.X,
        StartPosition.Y.Scale,
        StartPosition.Y.Offset + Delta.Y
    )

    Glow.Position = UDim2.new(
        StartPosition.X.Scale,
        StartPosition.X.Offset + Delta.X,
        StartPosition.Y.Scale,
        StartPosition.Y.Offset + Delta.Y
    )
end


TopBar.InputBegan:Connect(
    function(input)

        if input.UserInputType ==
            Enum.UserInputType.MouseButton1
            or input.UserInputType ==
            Enum.UserInputType.Touch then

            Dragging = true
            DragStart = input.Position
            StartPosition = Main.Position

            input.Changed:Connect(
                function()

                    if input.UserInputState ==
                        Enum.UserInputState.End then

                        Dragging = false
                    end
                end
            )
        end
    end
)


UserInputService.InputChanged:Connect(
    function(input)

        if input.UserInputType ==
            Enum.UserInputType.MouseMovement
            or input.UserInputType ==
            Enum.UserInputType.Touch then

            UpdateDrag(input)
        end
    end
)


-- =========================================
-- FINAL INITIALIZATION
-- =========================================

SearchBox.Text = ""

for _, data in pairs(GameCards) do

    if data.Card then
        data.Card.Visible = true
    end
end

if EmptySearch then
    EmptySearch.Visible = false
end

print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
print("🌙 LUNAR HUB v32.0")
print("✓ UI loaded")
print("✓ Games loaded: " .. tostring(#Games))
print("✓ Search loaded")
print("✓ Updates loaded")
print("✓ Drag system loaded")
print("✓ Minimize system loaded")
print("✓ Close system loaded")
print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━")
    --[[
    🌙 LUNAR HUB v32.0
    NEW UI
    PART 3A / 2
]]

-- =========================================
-- GAME IMAGE SYSTEM
-- =========================================

local function SetGameImage(gameName, imageId)

    local data = GameCards[gameName]

    if not data then
        warn("[Lunar Hub] Game not found: " .. tostring(gameName))
        return
    end

    if not data.Image then
        return
    end

    if not imageId or imageId == "" then
        data.Image.Image = ""
        data.Fallback.Visible = true
        return
    end

    -- Поддержка:
    -- 123456789
    -- rbxassetid://123456789

    local image = tostring(imageId)

    if not string.find(image, "rbxassetid://", 1, true) then
        image = "rbxassetid://" .. image
    end

    data.Image.Image = image
    data.Fallback.Visible = false
end


-- =========================================
-- IMAGE LOAD WITH FALLBACK
-- =========================================

local function SetGameImageSafe(gameName, imageId)

    local data = GameCards[gameName]

    if not data then
        return
    end

    if not imageId or imageId == "" then

        data.Image.Image = ""
        data.Fallback.Visible = true

        return
    end

    local success = pcall(function()

        SetGameImage(
            gameName,
            imageId
        )

    end)

    if not success then

        data.Image.Image = ""
        data.Fallback.Visible = true

    end
end


-- =========================================
-- OPTIONAL IMAGE DATA
-- =========================================

-- Сюда можно добавлять изображения игр.
--
-- Пример:
--
-- GameImages["Forsaken"] = "123456789"
--
-- После этого изображение автоматически
-- появится на карточке Forsaken.

local GameImages = {}


-- =========================================
-- APPLY IMAGES
-- =========================================

for gameName, imageId in pairs(GameImages) do

    SetGameImageSafe(
        gameName,
        imageId
    )

end


-- =========================================
-- GAME CARD STATUS
-- =========================================

local function SetGameStatus(
    gameName,
    text,
    color
)

    local data = GameCards[gameName]

    if not data then
        return
    end

    if not data.Status then
        return
    end

    data.Status.Text = text or "● READY"

    data.Status.TextColor3 =
        color or Theme.Success
end


-- =========================================
-- GAME CARD BUTTON STATE
-- =========================================

local function SetGameButton(
    gameName,
    text,
    enabled
)

    local data = GameCards[gameName]

    if not data then
        return
    end

    if not data.Button then
        return
    end

    data.Button.Text =
        text or "LOAD"

    data.Button.Active =
        enabled ~= false

    data.Button.AutoButtonColor =
        enabled ~= false

    if enabled == false then

        Tween(
            data.Button,
            {
                BackgroundColor3 =
                    Theme.Background2
            },
            Config.FastAnimation
        )

        data.Button.TextColor3 =
            Theme.SubText

    else

        Tween(
            data.Button,
            {
                BackgroundColor3 =
                    Theme.Button
            },
            Config.FastAnimation
        )

        data.Button.TextColor3 =
            Theme.Text
    end
end


-- =========================================
-- CARD SELECTION
-- =========================================

local SelectedGame = nil


local function SelectGame(gameName)

    if SelectedGame == gameName then
        return
    end

    -- Reset old card

    if SelectedGame then

        local oldData =
            GameCards[SelectedGame]

        if oldData and oldData.Card then

            Tween(
                oldData.Card,
                {
                    BackgroundColor3 =
                        Theme.Card
                },
                Config.FastAnimation
            )
        end
    end

    SelectedGame = gameName

    -- Highlight new card

    local newData =
        GameCards[gameName]

    if newData and newData.Card then

        Tween(
            newData.Card,
            {
                BackgroundColor3 =
                    Theme.CardHover
            },
            Config.FastAnimation
        )
    end
end


-- =========================================
-- CLICK CARD TO SELECT
-- =========================================

for gameName, data in pairs(GameCards) do

    if data.Card then

        data.Card.InputBegan:Connect(
            function(input)

                if input.UserInputType ==
                    Enum.UserInputType.MouseButton1 then

                    SelectGame(gameName)

                elseif input.UserInputType ==
                    Enum.UserInputType.Touch then

                    SelectGame(gameName)

                end
            end
        )

    end
end


-- =========================================
-- DEFAULT GAME
-- =========================================

if Games[1] then

    task.defer(function()

        SelectGame(
            Games[1].Name
        )

    end)

end


-- =========================================
-- SEARCH RESET
-- =========================================

local function ClearSearch()

    if not SearchBox then
        return
    end

    SearchBox.Text = ""

    for _, data in pairs(GameCards) do

        if data.Card then
            data.Card.Visible = true
        end

    end

    if EmptySearch then
        EmptySearch.Visible = false
    end
end


-- =========================================
-- SEARCH CLEAR BUTTON
-- =========================================

local SearchClear = Create(
    "TextButton",
    {
        Name = "SearchClear",
        Parent = SearchContainer,
        AnchorPoint = Vector2.new(1, 0.5),
        Position = UDim2.new(
            1,
            -8,
            0.5,
            0
        ),
        Size = UDim2.new(
            0,
            30,
            0,
            30
        ),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Text = "×",
        Font = Enum.Font.GothamBold,
        TextSize = 20,
        TextColor3 = Theme.SubText,
        AutoButtonColor = false,
        ZIndex = 10
    }
)


SearchClear.MouseEnter:Connect(
    function()

        Tween(
            SearchClear,
            {
                TextColor3 =
                    Theme.Text
            },
            Config.FastAnimation
        )

    end
)


SearchClear.MouseLeave:Connect(
    function()

        Tween(
            SearchClear,
            {
                TextColor3 =
                    Theme.SubText
            },
            Config.FastAnimation
        )

    end
)


SearchClear.MouseButton1Click:Connect(
    function()

        ClearSearch()

    end
)


-- =========================================
-- SEARCH PLACEHOLDER
-- =========================================

if SearchBox then

    SearchBox.PlaceholderText =
        "Search games..."

    SearchBox.PlaceholderColor3 =
        Theme.SubText

end


-- =========================================
-- GAME COUNT
-- =========================================

local GameCount = Create(
    "TextLabel",
    {
        Name = "GameCount",
        Parent = Content,
        AnchorPoint = Vector2.new(1, 0),
        Position = UDim2.new(
            1,
            -20,
            0,
            70
        ),
        Size = UDim2.new(
            0,
            120,
            0,
            22
        ),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Text = tostring(#Games)
            .. " GAMES",
        Font = Enum.Font.GothamBold,
        TextSize = 11,
        TextColor3 = Theme.SubText,
        TextXAlignment = Enum.TextXAlignment.Right,
        TextYAlignment = Enum.TextYAlignment.Center,
        ZIndex = 6
    }
)


-- =========================================
-- UPDATE GAME COUNT
-- =========================================

local function RefreshGameCount()

    local visibleCount = 0

    for _, data in pairs(GameCards) do

        if data.Card
            and data.Card.Visible then

            visibleCount += 1

        end
    end

    if SearchBox and SearchBox.Text ~= "" then

        GameCount.Text =
            tostring(visibleCount)
            .. " FOUND"

    else

        GameCount.Text =
            tostring(#Games)
            .. " GAMES"

    end
end


if SearchBox then

    SearchBox:GetPropertyChangedSignal(
        "Text"
    ):Connect(function()

        task.defer(
            RefreshGameCount
        )

    end)

end


-- =========================================
-- CARD IMAGE HOVER
-- =========================================

for _, data in pairs(GameCards) do

    if data.Card and data.Image then

        data.Card.MouseEnter:Connect(
            function()

                Tween(
                    data.Image,
                    {
                        Size = UDim2.new(
                            1,
                            -2,
                            1,
                            -2
                        ),
                        Position = UDim2.new(
                            0,
                            1,
                            0,
                            1
                        )
                    },
                    Config.FastAnimation
                )

            end
        )


        data.Card.MouseLeave:Connect(
            function()

                Tween(
                    data.Image,
                    {
                        Size = UDim2.new(
                            1,
                            -6,
                            1,
                            -6
                        ),
                        Position = UDim2.new(
                            0,
                            3,
                            0,
                            3
                        )
                    },
                    Config.FastAnimation
                )

            end
        )

    end
end


RefreshGameCount()

print("🌙 Lunar Hub v32.0 - Part 3A loaded")
    --[[
    🌙 LUNAR HUB v32.0
    NEW UI
    PART 3B / 2
]]

-- =========================================
-- CARD LOAD ANIMATION
-- =========================================

local function AnimateCardsIn()

    for index, gameData in ipairs(Games) do

        local data = GameCards[gameData.Name]

        if data and data.Card then

            local card = data.Card

            card.BackgroundTransparency = 1

            for _, child in ipairs(card:GetChildren()) do
                if child:IsA("TextLabel")
                    or child:IsA("TextButton")
                    or child:IsA("ImageLabel")
                    or child:IsA("Frame") then

                    if child ~= card then
                        child:SetAttribute(
                            "OriginalTransparency",
                            child.BackgroundTransparency
                        )
                    end
                end
            end

            task.delay(
                (index - 1) * 0.035,
                function()

                    if not card
                        or not card.Parent then
                        return
                    end

                    Tween(
                        card,
                        {
                            BackgroundTransparency = 0
                        },
                        0.2
                    )

                end
            )
        end
    end
end


-- =========================================
-- SCROLL TO TOP
-- =========================================

local function ScrollGamesToTop()

    if not GameList then
        return
    end

    Tween(
        GameList,
        {
            CanvasPosition = Vector2.new(
                0,
                0
            )
        },
        Config.Animation
    )
end


-- =========================================
-- GAMES BUTTON IMPROVEMENT
-- =========================================

if GamesButton then

    GamesButton.MouseButton1Click:Connect(
        function()

            ScrollGamesToTop()

            if SearchBox
                and SearchBox.Text ~= "" then

                -- Оставляем поиск,
                -- но возвращаем список вверх.

                task.defer(
                    RefreshGameCount
                )
            end

        end
    )

end


-- =========================================
-- UPDATES BUTTON IMPROVEMENT
-- =========================================

if UpdatesButton then

    UpdatesButton.MouseButton1Click:Connect(
        function()

            if UpdatePage then
                UpdatePage.CanvasPosition =
                    Vector2.new(0, 0)
            end

        end
    )

end


-- =========================================
-- CLEAR SEARCH WHEN SWITCHING PAGE
-- =========================================

local function ResetGamesPage()

    if SearchBox then
        SearchBox.Text = ""
    end

    for _, data in pairs(GameCards) do

        if data.Card then
            data.Card.Visible = true
        end

    end

    if EmptySearch then
        EmptySearch.Visible = false
    end

    RefreshGameCount()
    ScrollGamesToTop()
end


-- =========================================
-- KEYBOARD SHORTCUT
-- =========================================

UserInputService.InputBegan:Connect(
    function(input, processed)

        if processed then
            return
        end

        -- ESC = close menu

        if input.KeyCode ==
            Enum.KeyCode.Escape then

            if not Closed then
                CloseButton:Activate()
            end

            return
        end

        -- CTRL + F = search

        if input.KeyCode ==
            Enum.KeyCode.F
            and UserInputService:IsKeyDown(
                Enum.KeyCode.LeftControl
            ) then

            if SearchBox
                and SearchBox.Visible then

                SearchBox:CaptureFocus()

            end

        end
    end
)


-- =========================================
-- MOBILE TOUCH FEEDBACK
-- =========================================

local function AddTouchEffect(button)

    if not button then
        return
    end

    button.InputBegan:Connect(
        function(input)

            if input.UserInputType ==
                Enum.UserInputType.Touch then

                Tween(
                    button,
                    {
                        Size = UDim2.new(
                            button.Size.X.Scale,
                            button.Size.X.Offset - 2,
                            button.Size.Y.Scale,
                            button.Size.Y.Offset - 2
                        )
                    },
                    0.08
                )

            end
        end
    )

    button.InputEnded:Connect(
        function(input)

            if input.UserInputType ==
                Enum.UserInputType.Touch then

                Tween(
                    button,
                    {
                        Size = UDim2.new(
                            button.Size.X.Scale,
                            button.Size.X.Offset + 2,
                            button.Size.Y.Scale,
                            button.Size.Y.Offset + 2
                        )
                    },
                    0.08
                )

            end
        end
    )
end


AddTouchEffect(
    GamesButton
)

AddTouchEffect(
    UpdatesButton
)

AddTouchEffect(
    MinimizeButton
)

AddTouchEffect(
    CloseButton
)

AddTouchEffect(
    SearchClear
)


-- =========================================
-- VERSION CLICK
-- =========================================

local VersionClicks = 0
local VersionClickTime = 0

Version.MouseButton1Click:Connect(
    function()

        local now = tick()

        if now - VersionClickTime > 2 then
            VersionClicks = 0
        end

        VersionClickTime = now
        VersionClicks += 1

        if VersionClicks >= 5 then

            VersionClicks = 0

            warn(
                "🌙 Lunar Hub v"
                .. VERSION
                .. " | Developer mode"
            )

            Version.Text =
                "DEVELOPER MODE"

            Tween(
                Version,
                {
                    TextColor3 =
                        Theme.AccentLight
                },
                Config.FastAnimation
            )

            task.delay(
                2,
                function()

                    if Version
                        and Version.Parent then

                        Version.Text =
                            "NEON EDITION • v"
                            .. VERSION

                        Version.TextColor3 =
                            Theme.SubText

                    end
                end
            )
        end
    end
)


-- =========================================
-- TOP BAR HOVER
-- =========================================

local function SetupTopButton(button)

    if not button then
        return
    end

    button.MouseEnter:Connect(
        function()

            Tween(
                button,
                {
                    BackgroundColor3 =
                        Theme.ButtonHover
                },
                Config.FastAnimation
            )

        end
    )

    button.MouseLeave:Connect(
        function()

            Tween(
                button,
                {
                    BackgroundColor3 =
                        Theme.Button
                },
                Config.FastAnimation
            )

        end
    )
end


SetupTopButton(
    MinimizeButton
)

SetupTopButton(
    CloseButton
)


-- =========================================
-- REFRESH UI
-- =========================================

local function RefreshUI()

    if not Main
        or not Main.Parent then
        return
    end

    RefreshGameCount()

    if CurrentPage == "Games" then

        if GameList then
            GameList.Visible = true
        end

        if UpdatePage then
            UpdatePage.Visible = false
        end

    elseif CurrentPage == "Updates" then

        if GameList then
            GameList.Visible = false
        end

        if UpdatePage then
            UpdatePage.Visible = true
        end

    end
end


-- =========================================
-- CLEAN EMPTY SEARCH
-- =========================================

if EmptySearch then

    EmptySearch.Visible = false

    EmptySearch.Text =
        "No games found."

    EmptySearch.TextColor3 =
        Theme.SubText

end


-- =========================================
-- FINAL CARD SETUP
-- =========================================

for index, gameData in ipairs(Games) do

    local data =
        GameCards[gameData.Name]

    if data then

        if data.Status then
            data.Status.Text =
                "● READY"

            data.Status.TextColor3 =
                Theme.Success
        end

        if data.Button then
            data.Button.Text =
                "LOAD"
        end

    end
end


-- =========================================
-- STARTUP
-- =========================================

task.defer(function()

    task.wait(0.1)

    RefreshUI()

    AnimateCardsIn()

end)


print("🌙 Lunar Hub v32.0 - Part 3B loaded")
    --[[
    🌙 LUNAR HUB v32.0
    NEW UI
    PART 4A / 2
]]

-- =========================================
-- FINAL UI POLISH
-- =========================================

-- Защита от повторного создания GUI
-- при повторном запуске скрипта.

local ExistingLunar = nil

pcall(function()
    ExistingLunar = game:GetService("CoreGui")
        :FindFirstChild("LunarHub")
end)

-- =========================================
-- MAIN VISUAL EFFECT
-- =========================================

local MainStroke = Main:FindFirstChildOfClass("UIStroke")

if MainStroke then

    MainStroke.Color =
        Theme.Border

    MainStroke.Thickness = 2
    MainStroke.Transparency = 0.15

end


-- =========================================
-- TOP BAR LINE
-- =========================================

local TopBarLine = Create(
    "Frame",
    {
        Name = "TopBarLine",
        Parent = TopBar,
        Position = UDim2.new(
            0,
            20,
            1,
            -1
        ),
        Size = UDim2.new(
            1,
            -40,
            0,
            1
        ),
        BackgroundColor3 =
            Theme.Border,
        BackgroundTransparency = 0.55,
        BorderSizePixel = 0,
        ZIndex = 5
    }
)


-- =========================================
-- CONTENT TOP LINE
-- =========================================

local ContentLine = Create(
    "Frame",
    {
        Name = "ContentLine",
        Parent = Content,
        Position = UDim2.new(
            0,
            20,
            0,
            68
        ),
        Size = UDim2.new(
            1,
            -40,
            0,
            1
        ),
        BackgroundColor3 =
            Theme.Border,
        BackgroundTransparency = 0.75,
        BorderSizePixel = 0,
        ZIndex = 4
    }
)


-- =========================================
-- SIDEBAR ACCENT
-- =========================================

local SidebarAccent = Create(
    "Frame",
    {
        Name = "SidebarAccent",
        Parent = Sidebar,
        Position = UDim2.new(
            0,
            0,
            0,
            0
        ),
        Size = UDim2.new(
            0,
            2,
            1,
            0
        ),
        BackgroundColor3 =
            Theme.Accent,
        BackgroundTransparency = 0.25,
        BorderSizePixel = 0,
        ZIndex = 5
    }
)


-- =========================================
-- MAIN SHADOW
-- =========================================

local Shadow = Create(
    "Frame",
    {
        Name = "Shadow",
        Parent = ScreenGui,
        AnchorPoint = Vector2.new(
            0.5,
            0.5
        ),
        Position = UDim2.new(
            0.5,
            0,
            0.5,
            7
        ),
        Size = Main.Size,
        BackgroundColor3 =
            Color3.fromRGB(
                0,
                0,
                0
            ),
        BackgroundTransparency = 0.72,
        BorderSizePixel = 0,
        ZIndex = 0
    }
)

AddCorner(
    Shadow,
    Config.Corner + 2
)


-- =========================================
-- KEEP SHADOW WITH MAIN
-- =========================================

local function UpdateShadow()

    if not Shadow
        or not Main then
        return
    end

    Shadow.Position =
        UDim2.new(
            Main.Position.X.Scale,
            Main.Position.X.Offset,
            Main.Position.Y.Scale,
            Main.Position.Y.Offset + 7
        )

    Shadow.Size = Main.Size
end


Main:GetPropertyChangedSignal(
    "Position"
):Connect(UpdateShadow)

Main:GetPropertyChangedSignal(
    "Size"
):Connect(UpdateShadow)

UpdateShadow()


-- =========================================
-- REORDER SHADOW
-- =========================================

Shadow.ZIndex = 0
Glow.ZIndex = 1
Main.ZIndex = 2


-- =========================================
-- STARTUP FADE
-- =========================================

local function StartupAnimation()

    Main.Visible = true
    Glow.Visible = true

    Main.BackgroundTransparency = 1
    Glow.BackgroundTransparency = 1

    Tween(
        Main,
        {
            BackgroundTransparency = 0
        },
        0.35
    )

    Tween(
        Glow,
        {
            BackgroundTransparency = 0.72
        },
        0.4
    )

end


-- =========================================
-- UPDATE SHADOW TRANSPARENCY
-- =========================================

local function SetShadowVisible(
    visible
)

    if not Shadow then
        return
    end

    if visible then

        Tween(
            Shadow,
            {
                BackgroundTransparency = 0.72
            },
            Config.Animation
        )

    else

        Tween(
            Shadow,
            {
                BackgroundTransparency = 1
            },
            Config.Animation
        )

    end
end


SetShadowVisible(true)


-- =========================================
-- FIX CONTENT CLIPPING
-- =========================================

if Content then
    Content.ClipsDescendants = true
end

if Sidebar then
    Sidebar.ClipsDescendants = true
end

if GameList then
    GameList.ClipsDescendants = true
end

if UpdatePage then
    UpdatePage.ClipsDescendants = true
end


-- =========================================
-- FIX SEARCH CONTAINER
-- =========================================

if SearchContainer then

    SearchContainer.ClipsDescendants = true

    local SearchStroke =
        SearchContainer:FindFirstChildOfClass(
            "UIStroke"
        )

    if SearchStroke then

        SearchStroke.Color =
            Theme.Border

        SearchStroke.Thickness = 1
        SearchStroke.Transparency = 0.45

    end
end


-- =========================================
-- SEARCH FOCUS EFFECT
-- =========================================

if SearchBox then

    SearchBox.Focused:Connect(
        function()

            local stroke =
                SearchContainer
                and SearchContainer:
                    FindFirstChildOfClass(
                        "UIStroke"
                    )

            if stroke then

                Tween(
                    stroke,
                    {
                        Color =
                            Theme.Accent,
                        Transparency = 0
                    },
                    Config.FastAnimation
                )

            end
        end
    )


    SearchBox.FocusLost:Connect(
        function()

            local stroke =
                SearchContainer
                and SearchContainer:
                    FindFirstChildOfClass(
                        "UIStroke"
                    )

            if stroke then

                Tween(
                    stroke,
                    {
                        Color =
                            Theme.Border,
                        Transparency = 0.45
                    },
                    Config.FastAnimation
                )

            end
        end
    )
end


-- =========================================
-- FINAL STARTUP
-- =========================================

task.defer(function()

    task.wait(0.05)

    UpdateShadow()
    RefreshUI()

    StartupAnimation()

end)


print("🌙 Lunar Hub v32.0 - Part 4A loaded")
