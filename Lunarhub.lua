-- ============================================
-- 🌙 LUNAR HUB v30.0
-- Improved UI / Loader / Search
-- ============================================

local VERSION = "30.0"

-- ============================================
-- ⚙️ SERVICES
-- ============================================

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- ============================================
-- 🎨 THEME
-- ============================================

local Theme = {
    Background = Color3.fromRGB(10, 10, 20),
    Secondary = Color3.fromRGB(17, 17, 32),
    Card = Color3.fromRGB(24, 24, 45),
    CardHover = Color3.fromRGB(40, 35, 75),

    Accent = Color3.fromRGB(125, 90, 255),
    AccentHover = Color3.fromRGB(150, 120, 255),

    Gold = Color3.fromRGB(255, 215, 80),

    Text = Color3.fromRGB(245, 245, 255),
    SubText = Color3.fromRGB(150, 150, 175),

    Success = Color3.fromRGB(70, 220, 130),
    Error = Color3.fromRGB(255, 80, 90),
    Warning = Color3.fromRGB(255, 190, 70),
}

-- ============================================
-- 🎮 GAMES
-- ============================================

local Games = {
    {
        name = "Forsaken",
        link = "https://raw.githubusercontent.com/ScriptDLC/ScriptDLC/refs/heads/main/ForsakenDLCHUB"
    },

    {
        name = "MM2",
        link = "https://raw.githubusercontent.com/pruzgar242-rgb/Update/refs/heads/main/out.lua%20(17).txt"
    },

    {
        name = "Rivals",
        link = "https://rawscripts.net/raw/RIVALS-Noks-hub-keyless-111339"
    },

    {
        name = "Slap Battles",
        link = "https://raw.githubusercontent.com/Articles-Hub/ROBLOXScript/refs/heads/main/File-Script/Slap_Battles.lua"
    },

    {
        name = "King Legacy",
        link = "https://pastefy.app/3xQp8vL9/raw"
    },

    {
        name = "1+ Speed Keyboard",
        link = "https://raw.githubusercontent.com/Gerreiro68/ShizaHub/refs/heads/main/loader.lua"
    },

    {
        name = "Merge Nuke",
        link = "https://raw.githubusercontent.com/gumanba/Scripts/main/MergeaNuke"
    },

    {
        name = "MorphUp",
        link = "https://raw.githubusercontent.com/gumanba/Scripts/main/MorphUp"
    },

    {
        name = "1 Magic Evolution",
        link = "https://raw.githubusercontent.com/gumanba/Scripts/main/1MagicEvolution"
    },

    {
        name = "99 Nights in Forest",
        link = "https://raw.githubusercontent.com/caomod2077/Script/refs/heads/main/FoxnameHub.lua"
    },

    {
        name = "Survive Zombie Arena",
        link = "https://raw.githubusercontent.com/caomod2077/Script/main/Foxname_SZA.lua"
    },

    {
        name = "Color or Die",
        link = "https://rawscripts.net/raw/Color-or-Die-Esp-12555"
    },

    {
        name = "Rost Alpha Premium",
        link = "https://api.jnkie.com/api/v1/luascripts/public/e629b8f01eed30630fc3cb93da70708fdac4e57f3fd11fc6dc308c4d7ba6c1bd/download"
    },

    {
        name = "Prison Life Premium",
        link = "https://rawscripts.net/raw/Prison-Life-Override-Hub-Silent-Aim-and-More-242218"
    },
}

-- ============================================
-- 🔄 UPDATE
-- ============================================

local UPDATE_BASE =
    "https://raw.githubusercontent.com/ktoa4451-bot/Lunar-hub-v3.0/main/"

local function checkUpdate()
    local ok, remoteVersion = pcall(function()
        return game:HttpGet(UPDATE_BASE .. "version.txt")
    end)

    if not ok or not remoteVersion then
        return false
    end

    remoteVersion = remoteVersion:gsub("%s+", "")

    if remoteVersion ~= VERSION then
        warn(
            "[Lunar Hub] Update available: "
            .. VERSION
            .. " -> "
            .. remoteVersion
        )

        return true, remoteVersion
    end

    return false
end

-- ============================================
-- 🛡️ SCREEN GUI
-- ============================================

local oldGui = PlayerGui:FindFirstChild("LunarHub")

if oldGui then
    oldGui:Destroy()
end

local screen = Instance.new("ScreenGui")
screen.Name = "LunarHub"
screen.ResetOnSpawn = false
screen.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screen.Parent = PlayerGui

-- ============================================
-- 🔊 SOUND
-- ============================================

local clickSound = Instance.new("Sound")
clickSound.SoundId = "rbxassetid://9120385735"
clickSound.Volume = 0.25
clickSound.Parent = screen

local function playClick()
    pcall(function()
        clickSound:Play()
    end)
end

-- ============================================
-- 🧩 HELPERS
-- ============================================

local function addCorner(object, radius)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, radius or 8)
    corner.Parent = object

    return corner
end

local function addStroke(object, color, transparency)
    local stroke = Instance.new("UIStroke")
    stroke.Color = color or Theme.Accent
    stroke.Transparency = transparency or 0.5
    stroke.Thickness = 1
    stroke.Parent = object

    return stroke
end

local function tween(object, info, properties)
    return TweenService:Create(object, info, properties)
end

-- ============================================
-- 🔔 NOTIFICATION
-- ============================================

local notificationHolder = Instance.new("Frame")
notificationHolder.Size = UDim2.new(0, 280, 0, 300)
notificationHolder.Position = UDim2.new(1, -300, 1, -320)
notificationHolder.BackgroundTransparency = 1
notificationHolder.Parent = screen

local notificationLayout = Instance.new("UIListLayout")
notificationLayout.VerticalAlignment = Enum.VerticalAlignment.Bottom
notificationLayout.Padding = UDim.new(0, 8)
notificationLayout.Parent = notificationHolder

local function notify(message, color)
    local item = Instance.new("Frame")

    item.Size = UDim2.new(1, 0, 0, 45)
    item.BackgroundColor3 = Theme.Secondary
    item.BackgroundTransparency = 0.05
    item.BorderSizePixel = 0
    item.Parent = notificationHolder

    addCorner(item, 10)
    addStroke(item, color or Theme.Accent, 0.55)

    local text = Instance.new("TextLabel")

    text.Size = UDim2.new(1, -20, 1, 0)
    text.Position = UDim2.new(0, 10, 0, 0)
    text.BackgroundTransparency = 1
    text.Text = message
    text.TextColor3 = Theme.Text
    text.TextSize = 13
    text.Font = Enum.Font.GothamMedium
    text.TextWrapped = true
    text.TextXAlignment = Enum.TextXAlignment.Left
    text.Parent = item

    item.Position = UDim2.new(1, 30, 0, 0)

    tween(
        item,
        TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
        {Position = UDim2.new(0, 0, 0, 0)}
    ):Play()

    task.delay(3, function()
        if item.Parent then
            tween(
                item,
                TweenInfo.new(0.2),
                {
                    Position = UDim2.new(1, 30, 0, 0),
                    BackgroundTransparency = 1
                }
            ):Play()

            task.wait(0.25)

            if item then
                item:Destroy()
            end
        end
    end)
end

-- ============================================
-- 🖥️ MAIN FRAME
-- ============================================

local frame = Instance.new("Frame")

frame.Name = "Main"
frame.Size = UDim2.new(0.8, 0, 0.72, 0)
frame.Position = UDim2.new(0.5, 0, 0.5, 0)
frame.AnchorPoint = Vector2.new(0.5, 0.5)
frame.BackgroundColor3 = Theme.Background
frame.BorderSizePixel = 0
frame.ClipsDescendants = true
frame.Active = true
frame.Parent = screen

addCorner(frame, 16)
addStroke(frame, Theme.Accent, 0.65)

-- ============================================
-- 📏 SIZE LIMIT
-- ============================================

local sizeConstraint = Instance.new("UISizeConstraint")
sizeConstraint.MinSize = Vector2.new(320, 360)
sizeConstraint.MaxSize = Vector2.new(760, 600)
sizeConstraint.Parent = frame

-- ============================================
-- 🎯 HEADER
-- ============================================

local header = Instance.new("Frame")

header.Size = UDim2.new(1, 0, 0, 62)
header.BackgroundColor3 = Theme.Secondary
header.BorderSizePixel = 0
header.Parent = frame

local headerCorner = Instance.new("UICorner")
headerCorner.CornerRadius = UDim.new(0, 16)
headerCorner.Parent = header

-- title

local title = Instance.new("TextLabel")

title.Size = UDim2.new(0, 180, 1, 0)
title.Position = UDim2.new(0, 18, 0, 0)
title.BackgroundTransparency = 1
title.Text = "🌙 LUNAR HUB"
title.TextColor3 = Theme.Gold
title.TextSize = 20
title.Font = Enum.Font.GothamBold
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = header

-- version

local versionLabel = Instance.new("TextLabel")

versionLabel.Size = UDim2.new(0, 70, 1, 0)
versionLabel.Position = UDim2.new(0, 180, 0, 0)
versionLabel.BackgroundTransparency = 1
versionLabel.Text = "v" .. VERSION
versionLabel.TextColor3 = Theme.SubText
versionLabel.TextSize = 12
versionLabel.Font = Enum.Font.Gotham
versionLabel.TextXAlignment = Enum.TextXAlignment.Left
versionLabel.Parent = header

-- minimize

local minimize = Instance.new("TextButton")

minimize.Size = UDim2.new(0, 36, 0, 36)
minimize.Position = UDim2.new(1, -82, 0, 13)
minimize.Text = "—"
minimize.TextColor3 = Theme.Text
minimize.TextSize = 20
minimize.Font = Enum.Font.GothamBold
minimize.BackgroundColor3 = Theme.Card
minimize.BorderSizePixel = 0
minimize.Parent = header

addCorner(minimize, 9)

-- close

local close = Instance.new("TextButton")

close.Size = UDim2.new(0, 36, 0, 36)
close.Position = UDim2.new(1, -40, 0, 13)
close.Text = "×"
close.TextColor3 = Theme.Text
close.TextSize = 20
close.Font = Enum.Font.GothamBold
close.BackgroundColor3 = Color3.fromRGB(80, 35, 45)
close.BorderSizePixel = 0
close.Parent = header

addCorner(close, 9)

-- ============================================
-- 🖱️ CUSTOM DRAG
-- ============================================

local dragging = false
local dragStart
local startPosition

header.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then

        dragging = true
        dragStart = input.Position
        startPosition = frame.Position
    end
end)

header.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then

        dragging = false
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if not dragging then
        return
    end

    if input.UserInputType ~= Enum.UserInputType.MouseMovement
        and input.UserInputType ~= Enum.UserInputType.Touch then
        return
    end

    local delta = input.Position - dragStart

    frame.Position = UDim2.new(
        startPosition.X.Scale,
        startPosition.X.Offset + delta.X,
        startPosition.Y.Scale,
        startPosition.Y.Offset + delta.Y
    )
end)

-- ============================================
-- 🔍 SEARCH
-- ============================================

local searchBox = Instance.new("TextBox")

searchBox.Size = UDim2.new(1, -40, 0, 40)
searchBox.Position = UDim2.new(0, 20, 0, 76)
searchBox.BackgroundColor3 = Theme.Card
searchBox.BorderSizePixel = 0
searchBox.ClearTextOnFocus = false
searchBox.PlaceholderText = "🔍  Search games..."
searchBox.PlaceholderColor3 = Theme.SubText
searchBox.TextColor3 = Theme.Text
searchBox.TextSize = 14
searchBox.Font = Enum.Font.Gotham
searchBox.TextXAlignment = Enum.TextXAlignment.Left
searchBox.Parent = frame

addCorner(searchBox, 10)

local searchPadding = Instance.new("UIPadding")
searchPadding.PaddingLeft = UDim.new(0, 14)
searchPadding.PaddingRight = UDim.new(0, 14)
searchPadding.Parent = searchBox

-- ============================================
-- 📊 GAME COUNT
-- ============================================

local countLabel = Instance.new("TextLabel")

countLabel.Size = UDim2.new(0, 130, 0, 25)
countLabel.Position = UDim2.new(0, 20, 0, 122)
countLabel.BackgroundTransparency = 1
countLabel.TextColor3 = Theme.SubText
countLabel.TextSize = 12
countLabel.Font = Enum.Font.GothamMedium
countLabel.TextXAlignment = Enum.TextXAlignment.Left
countLabel.Parent = frame

-- ============================================
-- 📜 CONTENT
-- ============================================

local content = Instance.new("ScrollingFrame")

content.Size = UDim2.new(1, -40, 1, -175)
content.Position = UDim2.new(0, 20, 0, 150)
content.BackgroundTransparency = 1
content.BorderSizePixel = 0
content.ScrollBarThickness = 4
content.ScrollBarImageColor3 = Theme.Accent
content.CanvasSize = UDim2.new(0, 0, 0, 0)
content.AutomaticCanvasSize = Enum.AutomaticSize.Y
content.Parent = frame

local layout = Instance.new("UIListLayout")

layout.Padding = UDim.new(0, 7)
layout.SortOrder = Enum.SortOrder.LayoutOrder
layout.Parent = content

local contentPadding = Instance.new("UIPadding")
contentPadding.PaddingBottom = UDim.new(0, 10)
contentPadding.Parent = content

-- ============================================
-- 🔄 LOADER STATE
-- ============================================

local running = {}

local function loadScript(gameData)
    if running[gameData.name] then
        return false, "Already loading"
    end

    running[gameData.name] = true

    local success, result = pcall(function()

        local source = game:HttpGet(gameData.link)

        if not source or source == "" then
            error("Empty response")
        end

        local compiled, compileError = loadstring(source)

        if not compiled then
            error(
                "Compile error: "
                .. tostring(compileError)
            )
        end

        local executed, executeError = pcall(compiled)

        if not executed then
            error(
                "Runtime error: "
                .. tostring(executeError)
            )
        end

        return true
    end)

    running[gameData.name] = nil

    if success and result then
        return true
    end

    return false, tostring(result)
end

-- ============================================
-- 🎮 GAME BUTTON
-- ============================================

local function createGameButton(gameData, index)

    local button = Instance.new("TextButton")

    button.Name = gameData.name
    button.Size = UDim2.new(1, 0, 0, 52)
    button.BackgroundColor3 = Theme.Card
    button.BorderSizePixel = 0
    button.Text = ""
    button.AutoButtonColor = false
    button.LayoutOrder = index
    button.Parent = content

    addCorner(button, 11)

    -- icon

    local icon = Instance.new("TextLabel")

    icon.Size = UDim2.new(0, 40, 1, 0)
    icon.Position = UDim2.new(0, 8, 0, 0)
    icon.BackgroundTransparency = 1
    icon.Text = "🎮"
    icon.TextSize = 19
    icon.Parent = button

    -- name

    local name = Instance.new("TextLabel")

    name.Size = UDim2.new(1, -90, 1, 0)
    name.Position = UDim2.new(0, 52, 0, 0)
    name.BackgroundTransparency = 1
    name.Text = gameData.name
    name.TextColor3 = Theme.Text
    name.TextSize = 14
    name.Font = Enum.Font.GothamMedium
    name.TextXAlignment = Enum.TextXAlignment.Left
    name.Parent = button

    -- arrow

    local arrow = Instance.new("TextLabel")

    arrow.Size = UDim2.new(0, 30, 1, 0)
    arrow.Position = UDim2.new(1, -38, 0, 0)
    arrow.BackgroundTransparency = 1
    arrow.Text = "›"
    arrow.TextColor3 = Theme.SubText
    arrow.TextSize = 25
    arrow.Font = Enum.Font.GothamBold
    arrow.Parent = button

    -- hover

    button.MouseEnter:Connect(function()

        tween(
            button,
            TweenInfo.new(0.15),
            {
                BackgroundColor3 = Theme.CardHover
            }
        ):Play()

        tween(
            arrow,
            TweenInfo.new(0.15),
            {
                TextColor3 = Theme.Gold
            }
        ):Play()
    end)

    button.MouseLeave:Connect(function()

        tween(
            button,
            TweenInfo.new(0.15),
            {
                BackgroundColor3 = Theme.Card
            }
        ):Play()

        tween(
            arrow,
            TweenInfo.new(0.15),
            {
                TextColor3 = Theme.SubText
            }
        ):Play()
    end)

    -- click

    button.MouseButton1Click:Connect(function()

        if running[gameData.name] then
            notify(
                "⏳ " .. gameData.name .. " уже загружается",
                Theme.Warning
            )

            return
        end

        playClick()

        name.Text = "Загрузка..."
        icon.Text = "⏳"
        arrow.Text = "..."

        button.Active = false

        task.spawn(function()

            local success, errorMessage =
                loadScript(gameData)

            if success then

                icon.Text = "✓"
                arrow.Text = "✓"
                name.Text = gameData.name

                tween(
                    button,
                    TweenInfo.new(0.2),
                    {
                        BackgroundColor3 = Color3.fromRGB(25, 65, 45)
                    }
                ):Play()

                notify(
                    "✓ " .. gameData.name .. " загружен",
                    Theme.Success
                )

                task.wait(1)

            else

                icon.Text = "!"
                arrow.Text = "!"
                name.Text = gameData.name

                tween(
                    button,
                    TweenInfo.new(0.2),
                    {
                        BackgroundColor3 = Color3.fromRGB(70, 30, 40)
                    }
                ):Play()

                notify(
                    "✕ Ошибка: " .. gameData.name,
                    Theme.Error
                )

                warn(
                    "[Lunar Hub] "
                    .. gameData.name
                    .. ": "
                    .. tostring(errorMessage)
                )

                task.wait(1.5)
            end

            button.Active = true

            tween(
                button,
                TweenInfo.new(0.25),
                {
                    BackgroundColor3 = Theme.Card
                }
            ):Play()

            icon.Text = "🎮"
            arrow.Text = "›"
        end)
    end)

    return button
end

-- ============================================
-- 🔎 SEARCH / FILTER
-- ============================================

local buttons = {}

local function sortGames()
    local copy = {}

    for _, gameData in ipairs(Games) do
        table.insert(copy, gameData)
    end

    table.sort(copy, function(a, b)
        return a.name:lower() < b.name:lower()
    end)

    return copy
end

local sortedGames = sortGames()

for index, gameData in ipairs(sortedGames) do

    local button = createGameButton(
        gameData,
        index
    )

    buttons[gameData.name] = button
end

local function filterGames()

    local query = searchBox.Text:lower()

    local visible = 0

    for _, gameData in ipairs(sortedGames) do

        local button = buttons[gameData.name]

        if button then

            local matches =
                query == ""
                or gameData.name:lower():find(query, 1, true)

            button.Visible = matches

            if matches then
                visible += 1
                button.LayoutOrder = visible
            end
        end
    end

    countLabel.Text =
        "🎮 "
        .. visible
        .. " / "
        .. #Games
        .. " games"
end

searchBox:GetPropertyChangedSignal("Text"):Connect(
    filterGames
)

filterGames()

-- ============================================
-- ⌨️ CTRL + F
-- ============================================

UserInputService.InputBegan:Connect(function(
    input,
    proces
