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

    Create("TextLabel", {
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

    Create("TextLabel", {
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
-- GAMES CATEGORY
--------------------------------------------------

local GameList = Create("ScrollingFrame", {
    Parent = Content,
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
    Position = UDim2.new(0, 15, 0, 15),
    Size = UDim2.new(1, -30, 1, -30),
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

--------------------------------------------------
-- SIDEBAR BUTTON
--------------------------------------------------

local function CreateSidebarButton(text, order)

    local button = Create("TextButton", {
        Parent = Sidebar,
        BackgroundColor3 = Theme.Secondary,
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0, 38),
        Font = Enum.Font.GothamMedium,
        Text = text,
        TextColor3 = Theme.SubText,
        TextSize = 12,
        AutoButtonColor = false,
        LayoutOrder = order
    })

    Create("UICorner", {
        Parent = button,
        CornerRadius = UDim.new(0, 8)
    })

    button.MouseEnter:Connect(function()

        if button.TextColor3 ~= Theme.Text then

            Tween(
                button,
                {
                    BackgroundColor3 = Theme.Card,
                    TextColor3 = Theme.Text
                },
                0.15
            )
        end
    end)

    button.MouseLeave:Connect(function()

        Tween(
            button,
            {
                BackgroundColor3 = Theme.Secondary
            },
            0.15
        )
    end)

    return button
end

local GamesButton = CreateSidebarButton(
    "🎮  Games",
    1
)

local UpdatesButton = CreateSidebarButton(
    "🔄  Updates",
    2
)
--------------------------------------------------
-- UPDATE PAGE
--------------------------------------------------

local UpdatePage = Create("Frame", {
    Parent = Content,
    BackgroundTransparency = 1,
    Size = UDim2.new(1, 0, 1, 0),
    Visible = false
})

local UpdateTitle = Create("TextLabel", {
    Parent = UpdatePage,
    BackgroundTransparency = 1,
    Position = UDim2.new(0, 20, 0, 20),
    Size = UDim2.new(1, -40, 0, 30),
    Font = Enum.Font.GothamBold,
    Text = "🔄 Updates",
    TextColor3 = Theme.Text,
    TextSize = 20,
    TextXAlignment = Enum.TextXAlignment.Left
})

local UpdateInfo = Create("TextLabel", {
    Parent = UpdatePage,
    BackgroundTransparency = 1,
    Position = UDim2.new(0, 20, 0, 60),
    Size = UDim2.new(1, -40, 0, 100),
    Font = Enum.Font.Gotham,
    Text = "Lunar Hub v" .. VERSION ..
        "\n\nThis version contains the latest interface updates.",
    TextColor3 = Theme.SubText,
    TextSize = 13,
    TextWrapped = true,
    TextXAlignment = Enum.TextXAlignment.Left,
    TextYAlignment = Enum.TextYAlignment.Top
})

--------------------------------------------------
-- EMPTY GAMES MESSAGE
--------------------------------------------------

local EmptyGames = Create("TextLabel", {
    Parent = GameList,
    BackgroundTransparency = 1,
    Size = UDim2.new(1, 0, 0, 80),
    Font = Enum.Font.GothamMedium,
    Text = "🎮  No games available",
    TextColor3 = Theme.SubText,
    TextSize = 14,
    TextXAlignment = Enum.TextXAlignment.Center,
    TextYAlignment = Enum.TextYAlignment.Center
})

--------------------------------------------------
-- PAGE SWITCHING
--------------------------------------------------

local function ShowGames()

    GameList.Visible = true
    UpdatePage.Visible = false

    GamesButton.BackgroundColor3 = Theme.Card
    GamesButton.TextColor3 = Theme.Text

    UpdatesButton.BackgroundColor3 = Theme.Secondary
    UpdatesButton.TextColor3 = Theme.SubText
end

local function ShowUpdates()

    GameList.Visible = false
    UpdatePage.Visible = true

    UpdatesButton.BackgroundColor3 = Theme.Card
    UpdatesButton.TextColor3 = Theme.Text

    GamesButton.BackgroundColor3 = Theme.Secondary
    GamesButton.TextColor3 = Theme.SubText
end

GamesButton.MouseButton1Click:Connect(function()
    ShowGames()
end)

UpdatesButton.MouseButton1Click:Connect(function()
    ShowUpdates()
end)

--------------------------------------------------
-- MINIMIZE
--------------------------------------------------

local minimized = false
local normalSize = Main.Size

MinimizeButton.MouseButton1Click:Connect(function()

    minimized = not minimized

    if minimized then

        Tween(
            Main,
            {
                Size = UDim2.new(
                    normalSize.X.Scale,
                    normalSize.X.Offset,
                    0,
                    55
                )
            },
            0.25
        )

        MinimizeButton.Text = "+"
    else

        Tween(
            Main,
            {
                Size = normalSize
            },
            0.25
        )

        MinimizeButton.Text = "—"
    end
end)

--------------------------------------------------
-- CLOSE
--------------------------------------------------

CloseButton.MouseButton1Click:Connect(function()

    Tween(
        Main,
        {
            Size = UDim2.new(0, 0, 0, 0)
        },
        0.25
    )

    task.wait(0.3)

    if ScreenGui then
        ScreenGui:Destroy()
    end
end)

--------------------------------------------------
-- BUTTON HOVER
--------------------------------------------------

MinimizeButton.MouseEnter:Connect(function()

    Tween(
        MinimizeButton,
        {
            BackgroundColor3 = Theme.Card
        },
        0.15
    )
end)

CloseButton.MouseEnter:Connect(function()

    Tween(
        CloseButton,
        {
            BackgroundColor3 = Theme.Error
        },
        0.15
    )
end)

CloseButton.MouseLeave:Connect(function()

    Tween(
        CloseButton,
        {
            BackgroundColor3 = Theme.Card
        },
        0.15
    )
end)

--------------------------------------------------
-- NOTIFICATION HOLDER
--------------------------------------------------

notificationHolder = Create("Frame", {
    Parent = ScreenGui,
    BackgroundTransparency = 1,
    Position = UDim2.new(1, -320, 0, 20),
    Size = UDim2.new(0, 300, 0, 400)
})

Create("UIListLayout", {
    Parent = notificationHolder,
    Padding = UDim.new(0, 8),
    HorizontalAlignment = Enum.HorizontalAlignment.Right,
    VerticalAlignment = Enum.VerticalAlignment.Top,
    SortOrder = Enum.SortOrder.LayoutOrder
})

--------------------------------------------------
-- STARTUP
--------------------------------------------------

ShowGames()

task.wait(0.5)

Notify(
    "🌙 Lunar Hub",
    "Lunar Hub v" .. VERSION .. " loaded!",
    "success"
)

--------------------------------------------------
-- END
--------------------------------------------------
