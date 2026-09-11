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
-- GAMES
--------------------------------------------------

local Games = {

    -- Пример:
    -- {
    --     Name = "Forsaken",
    --     Description = "Forsaken script",
    --     Link = "ТВОЯ_РАБОЧАЯ_ССЫЛКА"
    -- },

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

--------------------------------------------------
-- GAME BUTTON CREATOR
--------------------------------------------------

local GameButtons = {}

local function CreateGameButton(gameData)

    local button = Create("TextButton", {
        Parent = GameList,
        BackgroundColor3 = Theme.Card,
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0, 62),
        AutoButtonColor = false,
        Text = ""
    })

    Create("UICorner", {
        Parent = button,
        CornerRadius = UDim.new(0, 10)
    })

    local icon = Create("Frame", {
        Parent = button,
        BackgroundColor3 = Theme.AccentDark,
        BorderSizePixel = 0,
        Position = UDim2.new(0, 10, 0.5, -20),
        Size = UDim2.new(0, 40, 0, 40)
    })

    Create("UICorner", {
        Parent = icon,
        CornerRadius = UDim.new(0, 9)
    })

    Create("TextLabel", {
        Parent = icon,
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 1, 0),
        Font = Enum.Font.GothamBold,
        Text = "🌙",
        TextColor3 = Theme.Text,
        TextSize = 18
    })

    local nameLabel = Create("TextLabel", {
        Parent = button,
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 62, 0, 10),
        Size = UDim2.new(1, -75, 0, 20),
        Font = Enum.Font.GothamBold,
        Text = gameData.Name,
        TextColor3 = Theme.Text,
        TextSize = 13,
        TextXAlignment = Enum.TextXAlignment.Left
    })

    local descriptionLabel = Create("TextLabel", {
        Parent = button,
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 62, 0, 31),
        Size = UDim2.new(1, -75, 0, 18),
        Font = Enum.Font.Gotham,
        Text = gameData.Description or "No description",
        TextColor3 = Theme.SubText,
        TextSize = 10,
        TextXAlignment = Enum.TextXAlignment.Left
    })

    local arrow = Create("TextLabel", {
        Parent = button,
        BackgroundTransparency = 1,
        Position = UDim2.new(1, -32, 0.5, -10),
        Size = UDim2.new(0, 20, 0, 20),
        Font = Enum.Font.GothamBold,
        Text = "›",
        TextColor3 = Theme.SubText,
        TextSize = 20
    })

    button.MouseEnter:Connect(function()

        Tween(
            button,
            {
                BackgroundColor3 = Color3.fromRGB(34, 34, 48)
            },
            0.15
        )

        Tween(
            arrow,
            {
                TextColor3 = Theme.Accent
            },
            0.15
        )

    end)

    button.MouseLeave:Connect(function()

        Tween(
            button,
            {
                BackgroundColor3 = Theme.Card
            },
            0.15
        )

        Tween(
            arrow,
            {
                TextColor3 = Theme.SubText
            },
            0.15
        )

    end)
        button.MouseButton1Click:Connect(function()

        if not gameData.Link or gameData.Link == "" then
            Notify(
                "Lunar Hub",
                "Для этой игры не указана ссылка.",
                "warning"
            )
            return
        end

        Notify(
            "Lunar Hub",
            "Загрузка " .. gameData.Name .. "...",
            "success"
        )

        task.spawn(function()

            local success, result = pcall(function()

                return loadstring(
                    game:HttpGet(gameData.Link)
                )()

            end)

            if success then

                Notify(
                    "Lunar Hub",
                    gameData.Name .. " успешно загружен!",
                    "success"
                )

            else

                warn(
                    "[Lunar Hub] Ошибка загрузки " ..
                    gameData.Name .. ": " ..
                    tostring(result)
                )

                Notify(
                    "Lunar Hub",
                    "Ошибка загрузки " .. gameData.Name,
                    "error"
                )

            end

        end)

    end)

    table.insert(GameButtons, {
        Button = button,
        Data = gameData
    })

    return button
end

--------------------------------------------------
-- CREATE ALL GAME BUTTONS
--------------------------------------------------

for _, gameData in ipairs(Games) do
    CreateGameButton(gameData)
end

--------------------------------------------------
-- SEARCH SYSTEM
--------------------------------------------------

SearchBox:GetPropertyChangedSignal("Text"):Connect(function()

    local searchText = string.lower(
        SearchBox.Text or ""
    )

    for _, gameButton in ipairs(GameButtons) do

        local gameName = string.lower(
            gameButton.Data.Name or ""
        )

        local description = string.lower(
            gameButton.Data.Description or ""
        )

        if searchText == ""
            or string.find(gameName, searchText, 1, true)
            or string.find(description, searchText, 1, true) then

            gameButton.Button.Visible = true

        else

            gameButton.Button.Visible = false

        end

    end

end)

--------------------------------------------------
-- EMPTY GAMES MESSAGE
--------------------------------------------------

local EmptyGames = Create("TextLabel", {
    Parent = Content,
    BackgroundTransparency = 1,
    Position = UDim2.new(0, 15, 0, 125),
    Size = UDim2.new(1, -30, 0, 60),
    Font = Enum.Font.Gotham,
    Text = "Игры пока не добавлены",
    TextColor3 = Theme.SubText,
    TextSize = 14,
    TextXAlignment = Enum.TextXAlignment.Center,
    TextYAlignment = Enum.TextYAlignment.Center,
    Visible = #Games == 0
})

--------------------------------------------------
-- UPDATES PAGE
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
    Position = UDim2.new(0, 15, 0, 20),
    Size = UDim2.new(1, -30, 0, 30),
    Font = Enum.Font.GothamBold,
    Text = "Updates",
    TextColor3 = Theme.Text,
    TextSize = 20,
    TextXAlignment = Enum.TextXAlignment.Left
})

local UpdateVersion = Create("TextLabel", {
    Parent = UpdatePage,
    BackgroundTransparency = 1,
    Position = UDim2.new(0, 15, 0, 53),
    Size = UDim2.new(1, -30, 0, 25),
    Font = Enum.Font.Gotham,
    Text = "Current version: v" .. VERSION,
    TextColor3 = Theme.SubText,
    TextSize = 12,
    TextXAlignment = Enum.TextXAlignment.Left
})

local UpdateCard = Create("Frame", {
    Parent = UpdatePage,
    BackgroundColor3 = Theme.Card,
    BorderSizePixel = 0,
    Position = UDim2.new(0, 15, 0, 95),
    Size = UDim2.new(1, -30, 0, 120)
})

Create("UICorner", {
    Parent = UpdateCard,
    CornerRadius = UDim.new(0, 10)
})

local UpdateText = Create("TextLabel", {
    Parent = UpdateCard,
    BackgroundTransparency = 1,
    Position = UDim2.new(0, 15, 0, 15),
    Size = UDim2.new(1, -30, 1, -30),
    Font = Enum.Font.Gotham,
    Text = "🌙 Lunar Hub v" .. VERSION ..
        "\n\nModern UI / Stable Loader",
    TextColor3 = Theme.Text,
    TextSize = 13,
    TextWrapped = true,
    TextXAlignment = Enum.TextXAlignment.Left,
    TextYAlignment = Enum.TextYAlignment.Top
})

--------------------------------------------------
-- SIDEBAR BUTTON
--------------------------------------------------

local function CreateSidebarButton(text, order)

    local button = Create("TextButton", {
        Parent = Sidebar,
        BackgroundColor3 = Theme.Secondary,
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0, 42),
        LayoutOrder = order,
        AutoButtonColor = false,
        Font = Enum.Font.GothamMedium,
        Text = text,
        TextColor3 = Theme.SubText,
        TextSize = 12
    })

    Create("UICorner", {
        Parent = button,
        CornerRadius = UDim.new(0, 9)
    })

    button.MouseEnter:Connect(function()

        Tween(
            button,
            {
                BackgroundColor3 = Theme.Card,
                TextColor3 = Theme.Text
            },
            0.15
        )

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

--------------------------------------------------
-- SIDEBAR BUTTONS
--------------------------------------------------

local GamesButton = CreateSidebarButton(
    "🎮  Games",
    1
)

local UpdatesButton = CreateSidebarButton(
    "🔄  Updates",
    2
)

--------------------------------------------------
-- PAGE SWITCHING
--------------------------------------------------

local function ShowGames()

    GameList.Visible = true
    SearchBox.Visible = true
    UpdatePage.Visible = false

    EmptyGames.Visible = #Games == 0

    Tween(
        GamesButton,
        {
            BackgroundColor3 = Theme.Card,
            TextColor3 = Theme.Text
        },
        0.15
    )

    Tween(
        UpdatesButton,
        {
            BackgroundColor3 = Theme.Secondary,
            TextColor3 = Theme.SubText
        },
        0.15
    )

end

local function ShowUpdates()

    GameList.Visible = false
    SearchBox.Visible = false
    EmptyGames.Visible = false
    UpdatePage.Visible = true

    Tween(
        GamesButton,
        {
            BackgroundColor3 = Theme.Secondary,
            TextColor3 = Theme.SubText
        },
        0.15
    )

    Tween(
        UpdatesButton,
        {
            BackgroundColor3 = Theme.Card,
            TextColor3 = Theme.Text
        },
        0.15
    )

end

GamesButton.MouseButton1Click:Connect(
    ShowGames
)

UpdatesButton.MouseButton1Click:Connect(
    ShowUpdates
)

--------------------------------------------------
-- NOTIFICATION HOLDER
--------------------------------------------------

notificationHolder = Create("Frame", {
    Parent = ScreenGui,
    BackgroundTransparency = 1,
    Position = UDim2.new(1, -250, 0, 20),
    Size = UDim2.new(0, 230, 0, 300)
})

Create("UIListLayout", {
    Parent = notificationHolder,
    Padding = UDim.new(0, 8),
    HorizontalAlignment = Enum.HorizontalAlignment.Right,
    SortOrder = Enum.SortOrder.LayoutOrder
})

--------------------------------------------------
-- MINIMIZE
--------------------------------------------------

local minimized = false

MinimizeButton.MouseButton1Click:Connect(function()

    minimized = not minimized

    if minimized then

        Tween(
            Main,
            {
                Size = UDim2.new(0, 600, 0, 55)
            },
            0.25
        )

        Sidebar.Visible = false
        Content.Visible = false

    else

        Sidebar.Visible = true
        Content.Visible = true

        Tween(
            Main,
            {
                Size = UDim2.new(0, 600, 0, 480)
            },
            0.25
        )

    end

end)

--------------------------------------------------
-- CLOSE
--------------------------------------------------

CloseButton.MouseButton1Click:Connect(function()

    Tween(
        Main,
        {
            Size = UDim2.new(0, 600, 0, 0)
        },
        0.25
    )

    task.wait(0.25)

    ScreenGui:Destroy()

end)

--------------------------------------------------
-- STARTUP
--------------------------------------------------

ShowGames()

task.wait(0.2)

Notify(
    "Lunar Hub",
    "Lunar Hub v" .. VERSION .. " запущен!",
    "success"
)
