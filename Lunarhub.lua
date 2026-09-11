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
        Link = "https://raw.githubusercontent.com/zxcursedsocute/Forsaken-Script/refs/heads/main/lua"
    },

    {
        Name = "MM2",
        Category = "Games",
        Description = "Murder Mystery 2",
        Link = "https://raw.githubusercontent.com/pruzgar242-rgb/Update/refs/heads/main/out.lua%20(17).txt"
    },

    {
        Name = "1+ Speed Keyboard",
        Category = "Games",
        Description = "Speed Keyboard",
        Link = "https://api.luarmor.net/files/v4/loaders/385c6d8937bfc4ef284dc8c27b50e1c5.lua"
    },

    {
        Name = "Merge Nuke",
        Category = "Games",
        Description = "Merge Nuke",
        Link = "https://raw.githubusercontent.com/gumanba/Scripts/main/MergeaNuke"
    },

    {
        Name = "MorphUp",
        Category = "Games",
        Description = "MorphUp",
        Link = "https://raw.githubusercontent.com/gumanba/Scripts/main/MorphUp"
    },

    {
        Name = "1 Magic Evolution",
        Category = "Games",
        Description = "1 Magic Evolution",
        Link = "https://raw.githubusercontent.com/gumanba/Scripts/main/1MagicEvolution"
    },

    {
        Name = "99 Nights in Forest",
        Category = "Games",
        Description = "99 Nights in the Forest",
        Link = "https://raw.githubusercontent.com/caomod2077/Script/refs/heads/main/FoxnameHub.lua"
    },

    {
        Name = "Survive Zombie Arena",
        Category = "Games",
        Description = "Survive Zombie Arena",
        Link = "https://raw.githubusercontent.com/caomod2077/Script/main/Foxname_SZA.lua"
    },

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
        Notify(
            "Loading",
            "Loading " .. gameData.Name .. "...",
            "warning"
        )

        task.spawn(function()
            local success, response = pcall(function()
                return game:HttpGet(gameData.Link)
            end)

            if not success then
                Notify(
                    "HTTP Error",
                    tostring(response),
                    "error"
                )
                return
            end

            if not response or response == "" then
                Notify(
                    "Error",
                    "The script returned empty content.",
                    "error"
                )
                return
            end

            local compileSuccess, compiled = pcall(function()
                return loadstring(response)
            end)

            if not compileSuccess then
                Notify(
                    "Compile Error",
                    tostring(compiled),
                    "error"
                )
                return
            end

            if not compiled then
                Notify(
                    "Error",
                    "loadstring returned nil.",
                    "error"
                )
                return
            end

            local executeSuccess, executeError = pcall(function()
                compiled()
            end)

            if not executeSuccess then
                Notify(
                    "Script Error",
                    tostring(executeError),
                    "error"
                )
                return
            end

            Notify(
                "Success",
                gameData.Name .. " loaded!",
                "success"
            )
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

local function UpdateSearch()
    local searchText = string.lower(SearchBox.Text or "")

    for _, item in ipairs(GameButtons) do
        local gameName = string.lower(item.Data.Name or "")
        local description = string.lower(item.Data.Description or "")

        local visible = false

        if searchText == "" then
            visible = true
        elseif string.find(gameName, searchText, 1, true) then
            visible = true
        elseif string.find(description, searchText, 1, true) then
            visible = true
        end

        item.Button.Visible = visible
    end
end

SearchBox:GetPropertyChangedSignal("Text"):Connect(UpdateSearch)

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
    Position = UDim2.new(0, 18, 0, 18),
    Size = UDim2.new(1, -36, 0, 30),
    Font = Enum.Font.GothamBold,
    Text = "Updates",
    TextColor3 = Theme.Text,
    TextSize = 20,
    TextXAlignment = Enum.TextXAlignment.Left
})

local UpdateInfo = Create("TextLabel", {
    Parent = UpdatePage,
    BackgroundTransparency = 1,
    Position = UDim2.new(0, 18, 0, 55),
    Size = UDim2.new(1, -36, 0, 90),
    Font = Enum.Font.Gotham,
    Text = "Lunar Hub v" .. VERSION ..
        "\n\nModern interface, improved loader, search system and error handling.",
    TextColor3 = Theme.SubText,
    TextSize = 12,
    TextWrapped = true,
    TextXAlignment = Enum.TextXAlignment.Left,
    TextYAlignment = Enum.TextYAlignment.Top
})

local VersionCard = Create("Frame", {
    Parent = UpdatePage,
    BackgroundColor3 = Theme.Card,
    BorderSizePixel = 0,
    Position = UDim2.new(0, 18, 0, 160),
    Size = UDim2.new(1, -36, 0, 75)
})

Create("UICorner", {
    Parent = VersionCard,
    CornerRadius = UDim.new(0, 10)
})

Create("TextLabel", {
    Parent = VersionCard,
    BackgroundTransparency = 1,
    Position = UDim2.new(0, 15, 0, 10),
    Size = UDim2.new(1, -30, 0, 22),
    Font = Enum.Font.GothamBold,
    Text = "Current version",
    TextColor3 = Theme.Text,
    TextSize = 13,
    TextXAlignment = Enum.TextXAlignment.Left
})

Create("TextLabel", {
    Parent = VersionCard,
    BackgroundTransparency = 1,
    Position = UDim2.new(0, 15, 0, 35),
    Size = UDim2.new(1, -30, 0, 20),
    Font = Enum.Font.Gotham,
    Text = "Lunar Hub v" .. VERSION,
    TextColor3 = Theme.Success,
    TextSize = 11,
    TextXAlignment = Enum.TextXAlignment.Left
})

--------------------------------------------------
-- PAGE SWITCHING
--------------------------------------------------

local function ShowGames()
    GameList.Visible = true
    SearchBox.Visible = true
    UpdatePage.Visible = false

    Tween(
        GamesButton,
        {
            BackgroundColor3 = Theme.AccentDark,
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
    UpdatePage.Visible = true

    Tween(
        UpdatesButton,
        {
            BackgroundColor3 = Theme.AccentDark,
            TextColor3 = Theme.Text
        },
        0.15
    )

    Tween(
        GamesButton,
        {
            BackgroundColor3 = Theme.Secondary,
            TextColor3 = Theme.SubText
        },
        0.15
    )
end

GamesButton.MouseButton1Click:Connect(ShowGames)
UpdatesButton.MouseButton1Click:Connect(ShowUpdates)

--------------------------------------------------
-- INITIAL PAGE
--------------------------------------------------

ShowGames()

--------------------------------------------------
-- NOTIFICATION HOLDER
--------------------------------------------------

notificationHolder = Create("Frame", {
    Parent = ScreenGui,
    BackgroundTransparency = 1,
    Position = UDim2.new(1, -235, 0, 20),
    Size = UDim2.new(0, 215, 0, 300)
})

Create("UIListLayout", {
    Parent = notificationHolder,
    Padding = UDim.new(0, 8),
    HorizontalAlignment = Enum.HorizontalAlignment.Right,
    VerticalAlignment = Enum.VerticalAlignment.Top
})

--------------------------------------------------
-- WINDOW STATE
--------------------------------------------------

local minimized = false
local normalSize = Main.Size

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

        MinimizeButton.Text = "+"
    else
        Sidebar.Visible = true
        Content.Visible = true

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
            Size = UDim2.new(0, 600, 0, 0)
        },
        0.25
    )

    task.wait(0.25)

    if ScreenGui then
        ScreenGui:Destroy()
    end
end)

--------------------------------------------------
-- STARTUP
--------------------------------------------------

task.defer(function()
    task.wait(0.5)

    Notify(
        "Lunar Hub",
        "v" .. VERSION .. " loaded successfully!",
        "success"
    )
end)

