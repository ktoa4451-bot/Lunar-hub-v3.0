-- 🌙 LUNAR HUB v30.1
-- Modern UI / Stable Loader

local VERSION = "30.1"

local UPDATE_BASE =
    "https://raw.githubusercontent.com/ktoa4451-bot/Lunar-hub-v3.0/main/"

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")

local LocalPlayer = Players.LocalPlayer

--------------------------------------------------
-- CONFIG
--------------------------------------------------

local Theme = {
    Background = Color3.fromRGB(15, 15, 22),
    Secondary = Color3.fromRGB(22, 22, 32),
    Card = Color3.fromRGB(27, 27, 39),
    Accent = Color3.fromRGB(145, 85, 255),
    AccentDark = Color3.fromRGB(105, 55, 200),
    Text = Color3.fromRGB(245, 245, 250),
    SubText = Color3.fromRGB(165, 165, 180),
    Success = Color3.fromRGB(80, 220, 130),
    Error = Color3.fromRGB(255, 80, 95),
    Warning = Color3.fromRGB(255, 190, 70)
}

local Games = {
    {
        Name = "Forsaken",
        Category = "Games",
        Description = "Forsaken scripts",
        Link = "https://raw.githubusercontent.com/ktoa4451-bot/Lunar-hub-v3.0/main/Games/Forsaken.lua"
    },

    {
        Name = "MM2",
        Category = "Games",
        Description = "Murder Mystery 2",
        Link = "https://raw.githubusercontent.com/ktoa4451-bot/Lunar-hub-v3.0/main/Games/MM2.lua"
    },

    {
        Name = "Rivals",
        Category = "Games",
        Description = "Rivals scripts",
        Link = "https://raw.githubusercontent.com/ktoa4451-bot/Lunar-hub-v3.0/main/Games/Rivals.lua"
    },

    {
        Name = "Slap Battles",
        Category = "Games",
        Description = "Slap Battles",
        Link = "https://raw.githubusercontent.com/ktoa4451-bot/Lunar-hub-v3.0/main/Games/SlapBattles.lua"
    },

    {
        Name = "King Legacy",
        Category = "Games",
        Description = "King Legacy",
        Link = "https://raw.githubusercontent.com/ktoa4451-bot/Lunar-hub-v3.0/main/Games/KingLegacy.lua"
    },

    {
        Name = "1+ Speed Keyboard",
        Category = "Games",
        Description = "Speed Keyboard",
        Link = "https://raw.githubusercontent.com/ktoa4451-bot/Lunar-hub-v3.0/main/Games/SpeedKeyboard.lua"
    },

    {
        Name = "Merge Nuke",
        Category = "Games",
        Description = "Merge Nuke",
        Link = "https://raw.githubusercontent.com/ktoa4451-bot/Lunar-hub-v3.0/main/Games/MergeNuke.lua"
    },

    {
        Name = "MorphUp",
        Category = "Games",
        Description = "MorphUp",
        Link = "https://raw.githubusercontent.com/ktoa4451-bot/Lunar-hub-v3.0/main/Games/MorphUp.lua"
    },

    {
        Name = "1 Magic Evolution",
        Category = "Games",
        Description = "1 Magic Evolution",
        Link = "https://raw.githubusercontent.com/ktoa4451-bot/Lunar-hub-v3.0/main/Games/1MagicEvolution.lua"
    },

    {
        Name = "99 Nights in Forest",
        Category = "Games",
        Description = "99 Nights in the Forest",
        Link = "https://raw.githubusercontent.com/ktoa4451-bot/Lunar-hub-v3.0/main/Games/99Nights.lua"
    },

    {
        Name = "Survive Zombie Arena",
        Category = "Games",
        Description = "Survive Zombie Arena",
        Link = "https://raw.githubusercontent.com/ktoa4451-bot/Lunar-hub-v3.0/main/Games/SurviveZombieArena.lua"
    },

    {
        Name = "Color or Die",
        Category = "Games",
        Description = "Color or Die",
        Link = "https://raw.githubusercontent.com/ktoa4451-bot/Lunar-hub-v3.0/main/Games/ColorOrDie.lua"
    },

    {
        Name = "Rost Alpha Premium",
        Category = "Games",
        Description = "Rost Alpha Premium",
        Link = "https://raw.githubusercontent.com/ktoa4451-bot/Lunar-hub-v3.0/main/Games/RostAlpha.lua"
    },

    {
        Name = "Prison Life Premium",
        Category = "Games",
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

local function Tween(object, properties, duration)
    local tween = TweenService:Create(
        object,
        TweenInfo.new(
            duration or 0.2,
            Enum.EasingStyle.Quart,
            Enum.EasingDirection.Out
        ),
        properties
    )

    tween:Play()

    return tween
end

--------------------------------------------------
-- NOTIFICATION SYSTEM
--------------------------------------------------

local notificationHolder

local function Notify(title, message, notificationType)
    if not notificationHolder then
        return
    end

    local accent = Theme.Accent

    if notificationType == "success" then
        accent = Theme.Success
    elseif notificationType == "error" then
        accent = Theme.Error
    elseif notificationType == "warning" then
        accent = Theme.Warning
    end

    local notification = Create("Frame", {
        Parent = notificationHolder,
        BackgroundColor3 = Theme.Card,
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0, 70),
        Position = UDim2.new(1, 20, 0, 0)
    })

    Create("UICorner", {
        Parent = notification,
        CornerRadius = UDim.new(0, 10)
    })

    Create("Frame", {
        Parent = notification,
        BackgroundColor3 = accent,
        BorderSizePixel = 0,
        Size = UDim2.new(0, 4, 1, 0)
    })

    local titleLabel = Create("TextLabel", {
        Parent = notification,
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 16, 0, 9),
        Size = UDim2.new(1, -25, 0, 20),
        Font = Enum.Font.GothamBold,
        Text = title,
        TextColor3 = Theme.Text,
        TextSize = 14,
        TextXAlignment = Enum.TextXAlignment.Left
    })

    local messageLabel = Create("TextLabel", {
        Parent = notification,
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 16, 0, 31),
        Size = UDim2.new(1, -25, 0, 28),
        Font = Enum.Font.Gotham,
        Text = message,
        TextColor3 = Theme.SubText,
        TextSize = 12,
        TextWrapped = true,
        TextXAlignment = Enum.TextXAlignment.Left
    })

    Tween(
        notification,
        {
            Position = UDim2.new(0, 0, 0, 0)
        },
        0.3
    )

    task.delay(3, function()
        if notification and notification.Parent then
            local tween = Tween(
                notification,
                {
                    Position = UDim2.new(1, 20, 0, 0)
                },
                0.3
            )

            tween.Completed:Wait()

            if notification then
                notification:Destroy()
            end
        end
    end)
end

--------------------------------------------------
-- SCREEN GUI
--------------------------------------------------

local oldGui = LocalPlayer:FindFirstChild("LunarHub")

if oldGui then
    oldGui:Destroy()
end

local ScreenGui = Create("ScreenGui", {
    Name = "LunarHub",
    Parent = LocalPlayer:WaitForChild("PlayerGui"),
    ResetOnSpawn = false,
    ZIndexBehavior = Enum.ZIndexBehavior.Sibling
})

--------------------------------------------------
-- MAIN WINDOW
--------------------------------------------------

local Main = Create("Frame", {
    Parent = ScreenGui,
    BackgroundColor3 = Theme.Background,
    BorderSizePixel = 0,
    Position = UDim2.new(0.5, -300, 0.5, -240),
    Size = UDim2.new(0, 600, 0, 480)
})

Create("UICorner", {
    Parent = Main,
    CornerRadius = UDim.new(0, 14)
})

Create("UIStroke", {
    Parent = Main,
    Color = Theme.Accent,
    Transparency = 0.65,
    Thickness = 1
})

--------------------------------------------------
-- TOP BAR
--------------------------------------------------

local TopBar = Create("Frame", {
    Parent = Main,
    BackgroundColor3 = Theme.Secondary,
    BorderSizePixel = 0,
    Size = UDim2.new(1, 0, 0, 55)
})

Create("UICorner", {
    Parent = TopBar,
    CornerRadius = UDim.new(0, 14)
})

local Title = Create("TextLabel", {
    Parent = TopBar,
    BackgroundTransparency = 1,
    Position = UDim2.new(0, 18, 0, 7),
    Size = UDim2.new(0, 250, 0, 25),
    Font = Enum.Font.GothamBold,
    Text = "🌙 LUNAR HUB",
    TextColor3 = Theme.Text,
    TextSize = 18,
    TextXAlignment = Enum.TextXAlignment.Left
})

local VersionLabel = Create("TextLabel", {
    Parent = TopBar,
    BackgroundTransparency = 1,
    Position = UDim2.new(0, 20, 0, 31),
    Size = UDim2.new(0, 100, 0, 16),
    Font = Enum.Font.Gotham,
    Text = "v" .. VERSION,
    TextColor3 = Theme.SubText,
    TextSize = 10,
    TextXAlignment = Enum.TextXAlignment.Left
})

--------------------------------------------------
-- WINDOW BUTTONS
--------------------------------------------------

local MinimizeButton = Create("TextButton", {
    Parent = TopBar,
    BackgroundColor3 = Theme.Card,
    BorderSizePixel = 0,
    Position = UDim2.new(1, -80, 0, 13),
    Size = UDim2.new(0, 30, 0, 30),
    Font = Enum.Font.GothamBold,
    Text = "—",
    TextColor3 = Theme.Text,
    TextSize = 16,
    AutoButtonColor = false
})

Create("UICorner", {
    Parent = MinimizeButton,
    CornerRadius = UDim.new(0, 8)
})

local CloseButton = Create("TextButton", {
    Parent = TopBar,
    BackgroundColor3 = Theme.Card,
    BorderSizePixel = 0,
    Position = UDim2.new(1, -43, 0, 13),
    Size = UDim2.new(0, 30, 0, 30),
    Font = Enum.Font.GothamBold,
    Text = "×",
    TextColor3 = Theme.Text,
    TextSize = 18,
    AutoButtonColor = false
})

Create("UICorner", {
    Parent = CloseButton,
    CornerRadius = UDim.new(0, 8)
})

--------------------------------------------------
-- DRAG SYSTEM
--------------------------------------------------

local dragging = false
local dragStart
local startPosition

TopBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then

        dragging = true
        dragStart = input.Position
        startPosition = Main.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if not dragging then
        return
    end

    if input.UserInputType == Enum.UserInputType.MouseMovement
        or input.UserInputType == Enum.UserInputType.Touch then

        local delta = input.Position - dragStart

        Main.Position = UDim2.new(
            startPosition.X.Scale,
            startPosition.X.Offset + delta.X,
            startPosition.Y.Scale,
            startPosition.Y.Offset + delta.Y
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
    Position = UDim2.new(0, 0, 0, 55),
    Size = UDim2.new(0, 145, 1, -55)
})

local SidebarLayout = Create("UIListLayout", {
    Parent = Sidebar,
    Padding = UDim.new(0, 7),
    SortOrder = Enum.SortOrder.LayoutOrder
})

Create("UIPadding", {
    Parent = Sidebar,
    PaddingTop = UDim.new(0, 15),
    PaddingLeft = UDim.new(0, 10),
    PaddingRight = UDim.new(0, 10)
})

--------------------------------------------------
-- CONTENT
--------------------------------------------------

local Content = Create("Frame", {
    Parent = Main,
    BackgroundTransparency = 1,
    Position = UDim2.new(0, 145, 0, 55),
    Size = UDim2.new(1, -145, 1, -55)
})

--------------------------------------------------
-- SEARCH
--------------------------------------------------

local SearchBox = Create("TextBox", {
    Parent = Content,
    BackgroundColor3 = Theme.Card,
    BorderSizePixel = 0,
    Position = UDim2.new(0, 15, 0, 15),
    Size = UDim2.new(1, -30, 0, 38),
    Font = Enum.Font.Gotham,
    PlaceholderText = "Search games...",
    PlaceholderColor3 = Theme.SubText,
    Text = "",
    TextColor3 = Theme.Text,
    TextSize = 13,
    ClearTextOnFocus = false
})

Create("UICorner", {
    Parent = SearchBox,
    CornerRadius = UDim.new(0, 9)
})

Create("UIPadding", {
    Parent = SearchBox,
    PaddingLeft = UDim.new(0, 12),
    PaddingRight = UDim.new(0, 12)
})

--------------------------------------------------
-- GAME LIST
--------------------------------------------------

local GameList = Create("ScrollingFrame", {
    Parent = Content,
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
    Position = UDim2.new(0, 15, 0, 65),
    Size = UDim2.new(1, -30, 1, -80),
    CanvasSize = UDim2.new(0, 0, 0, 0),
    AutomaticCanvasSize = Enum.AutomaticSize.Y,
    ScrollBarThickness = 3,
    ScrollBarImageColor3 = Theme.Accent
})

Create("UIListLayout", {
    Parent = GameList,
    Padding = UDim.new(0, 8),
    SortOrder = Enum.SortOrder.LayoutOrder
})

Create("UIPadding", {
    Parent = GameList,
    PaddingBottom = UDim.new(0, 10)
})
