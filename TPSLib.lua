-- TPSLib.lua
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local CollectionService = game:GetService("CollectionService")
local LocalPlayer = Players.LocalPlayer

local TPSLib = {}

-- Helpers
local function new(class, props, parent)
    local inst = Instance.new(class)
    for k, v in pairs(props or {}) do inst[k] = v end
    if parent then inst.Parent = parent end
    return inst
end

local function tween(o, props, info)
    local t = TweenService:Create(
        o,
        info or TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        props
    )
    t:Play()
    return t
end

local colors = {
    vermelho = Color3.fromRGB(255, 84, 84),
    verde = Color3.fromRGB(118, 255, 118),
    azul = Color3.fromRGB(102, 102, 255),
    amarelo = Color3.fromRGB(242, 255, 118),
    roxo = Color3.fromRGB(178, 102, 255),
    rosa = Color3.fromRGB(255, 105, 180),
    laranja = Color3.fromRGB(255, 165, 0),
    ciano = Color3.fromRGB(0, 255, 255),
    marrom = Color3.fromRGB(139, 69, 19),
    branco = Color3.fromRGB(255, 255, 255),
    cinza = Color3.fromRGB(100, 100, 100),
    cinzaEscuro = Color3.fromRGB(50, 50, 50),
    preto = Color3.fromRGB(0, 0, 0),
}

local Themes = {
    Dark = {
        Background = colors.preto,
        Primary = colors.cinzaEscuro,
        Accent = colors.vermelho,
        Text = colors.branco,
    },
    Light = {
        Background = colors.branco,
        Primary = colors.cinza,
        Accent = colors.azul,
        Text = colors.preto,
    },
    Ocean = {
        Background = colors.azul,
        Primary = colors.ciano,
        Accent = colors.verde,
        Text = colors.branco,
    },
    Sunset = {
        Background = colors.laranja,
        Primary = colors.vermelho,
        Accent = colors.roxo,
        Text = colors.preto,
    },
    Neon = {
        Background = colors.preto,
        Primary = colors.verde,
        Accent = colors.rosa,
        Text = colors.ciano,
    },
}

function TPSLib:Window(config)
    local Name = config.Name or "TPS Window"
    local TopbarTheme = colors[config.TopbarTheme] or colors.azul
    local Theme = Themes[config.WindowTheme] or Themes.Dark

    local TARGET_W, TARGET_H = 520, 300
    local TOPBAR_H = 44

    local gui = new("ScreenGui", {
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
        ResetOnSpawn = false,
        Parent = LocalPlayer:WaitForChild("PlayerGui")
    })
    CollectionService:AddTag(gui, "main")

    local window = new("Frame", {
        Name = "Window",
        AnchorPoint = Vector2.new(0.5, 0.5),
        Size = UDim2.fromOffset(math.floor(TARGET_W*0.5), TOPBAR_H),
        Position = UDim2.new(0.5, 0, 1.1, 0),
        BackgroundColor3 = theme.Background,
        BorderSizePixel = 0,
        ClipsDescendants = true
    }, gui)
    new("UICorner", {CornerRadius = UDim.new(0, 14)}, window)
    new("UIStroke", {
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
        Color = theme.Accent,
        Transparency = 0.25,
        Thickness = 1
    }, window)

    local topBar = new("Frame", {
        Name = "TopBar",
        Size = UDim2.new(1, 0, 0, TOPBAR_H),
        BackgroundColor3 = topbarTheme,
        BorderSizePixel = 0,
        ZIndex = 2,
        Active = true
    }, window)
    new("UICorner", {CornerRadius = UDim.new(0, 14)}, topBar)

    local title = new("TextLabel", {
        BackgroundTransparency = 1,
        Size = UDim2.new(1, -120, 1, 0),
        Position = UDim2.fromOffset(12, 0),
        Text = name,
        Font = Enum.Font.GothamSemibold,
        TextSize = 16,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextColor3 = theme.Text,
        ZIndex = 3
    }, topBar)

    local closeBtn = new("TextButton", {
        Name = "CloseButton",
        Text = "X",
        Size = UDim2.fromOffset(32, 30),
        Position = UDim2.new(1, -38, 0, 7),
        BackgroundColor3 = colors.vermelho,
        TextColor3 = colors.branco,
        Font = Enum.Font.GothamBold,
        TextSize = 18,
        BorderSizePixel = 0,
        ZIndex = 3
    }, topBar)
    new("UICorner", {CornerRadius = UDim.new(0, 8)}, closeBtn)

    local minBtn = new("TextButton", {
        Name = "MinimizeButton",
        Text = "−",
        Size = UDim2.fromOffset(32, 30),
        Position = UDim2.new(1, -76, 0, 7),
        BackgroundColor3 = colors.amarelo,
        TextColor3 = colors.preto,
        Font = Enum.Font.GothamBold,
        TextSize = 18,
        BorderSizePixel = 0,
        ZIndex = 3
    }, topBar)
    new("UICorner", {CornerRadius = UDim.new(0, 8)}, minBtn)

    local mainContent = new("ScrollingFrame", {
        Name = "MainFrame",
        Size = UDim2.new(1, -20, 1, -(TOPBAR_H + 16)),
        Position = UDim2.fromOffset(10, TOPBAR_H + 6),
        BackgroundColor3 = theme.Primary,
        BorderSizePixel = 0,
        ZIndex = 1,
        CanvasSize = UDim2.new(0,0,0,0),
        ScrollBarThickness = 6,
        ScrollBarImageColor3 = topbarTheme,
        AutomaticCanvasSize = Enum.AutomaticSize.Y,
    }, window)
    new("UICorner", {CornerRadius = UDim.new(0, 12)}, mainContent)
    new("UIListLayout", {Padding = UDim.new(0,6), SortOrder = Enum.SortOrder.LayoutOrder}, mainContent)

    -- INTRO
    task.defer(function()
        tween(window, {
            Position = UDim2.new(0.5, 0, 0.5, 0),
            Size = UDim2.fromOffset(TARGET_W, TARGET_H)
        }, TweenInfo.new(0.55, Enum.EasingStyle.Back, Enum.EasingDirection.Out))
    end)

    -- DRAG
    do
        local dragging = false
        local dragInput, dragStart, startPos
        local function setPosFromDelta(input)
            local delta = input.Position - dragStart
            window.Position = UDim2.new(
                startPos.X.Scale, startPos.X.Offset + delta.X,
                startPos.Y.Scale, startPos.Y.Offset + delta.Y
            )
        end

        topBar.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1
            or input.UserInputType == Enum.UserInputType.Touch then
                dragging = true
                dragStart = input.Position
                startPos = window.Position
                input.Changed:Connect(function()
                    if input.UserInputState == Enum.UserInputState.End then
                        dragging = false
                        tween(window, {Position = window.Position}, TweenInfo.new(0.12, Enum.EasingStyle.Quad))
                    end
                end)
            end
        end)

        topBar.InputChanged:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseMovement
            or input.UserInputType == Enum.UserInputType.Touch then
                dragInput = input
            end
        end)

        UserInputService.InputChanged:Connect(function(input)
            if input == dragInput and dragging then
                setPosFromDelta(input)
            end
        end)
    end

    local minimized = false
    minBtn.MouseButton1Click:Connect(function()
        minimized = not minimized
        if minimized then
            mainContent.Visible = false
            tween(window, {Size = UDim2.fromOffset(TARGET_W, TOPBAR_H)}, TweenInfo.new(0.28, Enum.EasingStyle.Quad))
            minBtn.Text = "+"
        else
            tween(window, {Size = UDim2.fromOffset(TARGET_W, TARGET_H)}, TweenInfo.new(0.32, Enum.EasingStyle.Back))
            task.delay(0.08, function()
                mainContent.Visible = true
                minBtn.Text = "−"
            end)
        end
    end)

    closeBtn.MouseButton1Click:Connect(function()
        local t = tween(window, {
            Size = UDim2.fromOffset(math.floor(TARGET_W*0.5), TOPBAR_H),
            Position = UDim2.new(0.5, 0, 1.1, 0)
        }, TweenInfo.new(0.32, Enum.EasingStyle.Back, Enum.EasingDirection.In))
        t.Completed:Connect(function() gui:Destroy() end)
    end)

    local WindowObj = {}
    
    function WindowObj:Button(text, colorName, callback)
        local btn = new("TextButton", {
            Size = UDim2.new(1, -20, 0, 40),
            Position = UDim2.fromOffset(10, (#mainContent:GetChildren()-1)*46),
            BackgroundColor3 = colors[colorName] or theme.Accent,
            TextColor3 = theme.Text,
            Font = Enum.Font.GothamBold,
            TextSize = 16,
            Text = text,
            BorderSizePixel = 0,
            ZIndex = 2
        }, mainContent)
        new("UICorner", {CornerRadius = UDim.new(0,8)}, btn)

        if callback then
            btn.MouseButton1Click:Connect(callback)
        end
        return btn
    end

    WindowObj.Gui = gui
    WindowObj.MainFrame = mainContent
    WindowObj.TopBar = topBar

    return WindowObj
end

return TPSLib

