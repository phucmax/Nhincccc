--========================================================--
--   FLUENT-LIKE UI by PHUCMAX
--   - Fluent style (rounded, soft background)
--   - Left draggable round toggle (image background)
--   - Main UI uses image background (image ID)
--   - Tabs, Buttons, Toggles, Sliders, Dropdowns, Textboxes
--   - Minimize (to top bar) + restore, Delete confirm
--   Paste into a LocalScript under StarterPlayerScripts
--========================================================--

-- Services
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local lp = Players.LocalPlayer
local playerGui = lp:WaitForChild("PlayerGui")

-- ============== CONFIG ==============
local IMAGE_BG_ID = "rbxassetid://1234567890"  -- main UI background image
local TOGGLE_BG_ID = "rbxassetid://0987654321" -- round toggle image (button)
local TITLE = "Fluent UI"
local SUBTITLE = "By PHUCMAX"
-- =====================================

-- Remove old
if playerGui:FindFirstChild("PHUCMAX_FLUENT_UI") then
    playerGui:FindFirstChild("PHUCMAX_FLUENT_UI"):Destroy()
end

-- Helpers
local function tween(inst, props, t, style, dir)
    style = style or Enum.EasingStyle.Quint
    dir = dir or Enum.EasingDirection.Out
    local ti = TweenInfo.new(t or 0.25, style, dir)
    local obj = TweenService:Create(inst, ti, props)
    obj:Play()
    return obj
end

local function newInst(class, props)
    local i = Instance.new(class)
    for k,v in pairs(props or {}) do
        if type(k) == "number" then
            -- ignore numeric keys
        else
            i[k] = v
        end
    end
    return i
end

-- Drag function (works for mouse & touch)
local function makeDraggable(target, dragArea)
    dragArea = dragArea or target
    local dragging, dragInput, dragStart, startPos = false, nil, nil, nil

    local function onInputBegan(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = UDim2.new(target.Position.X.Scale, target.Position.X.Offset, target.Position.Y.Scale, target.Position.Y.Offset)
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end

    dragArea.InputBegan:Connect(onInputBegan)

    dragArea.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)

    UIS.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            local newX = startPos.X.Offset + delta.X
            local newY = startPos.Y.Offset + delta.Y
            target.Position = UDim2.new(startPos.X.Scale, newX, startPos.Y.Scale, newY)
        end
    end)
end

-- Create ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.ResetOnSpawn = false
screenGui.Name = "PHUCMAX_FLUENT_UI"
screenGui.Parent = playerGui
screenGui.IgnoreGuiInset = true

-- ========== LEFT ROUND TOGGLE (DRAGGABLE) ==========
local roundToggle = newInst("ImageButton", {
    Name = "RoundToggle",
    Parent = screenGui,
    Size = UDim2.new(0, 60, 0, 60),
    Position = UDim2.new(0.02, 0, 0.45, 0),
    BackgroundTransparency = 0,
    BackgroundColor3 = Color3.fromRGB(255,255,255),
    Image = TOGGLE_BG_ID,
    AutoButtonColor = false,
    ZIndex = 50,
})

local rtCorner = Instance.new("UICorner", roundToggle)
rtCorner.CornerRadius = UDim.new(1,0)

-- slight inner glow/overlay for fluent look
local overlay = newInst("Frame", {
    Parent = roundToggle,
    Size = UDim2.new(1,0,1,0),
    Position = UDim2.new(0,0,0,0),
    BackgroundTransparency = 0.6,
    BackgroundColor3 = Color3.fromRGB(255,255,255),
    ZIndex = 51
})
local ovCorner = Instance.new("UICorner", overlay)
ovCorner.CornerRadius = UDim.new(1,0)

makeDraggable(roundToggle) -- draggable

-- ========== MAIN FLUENT UI ==========
local main = newInst("Frame", {
    Name = "FluentMain",
    Parent = screenGui,
    Size = UDim2.new(0, 540, 0, 370),
    Position = UDim2.new(0.2, 0, 0.18, 0),
    BackgroundColor3 = Color3.fromRGB(28,28,30),
    BackgroundTransparency = 0.05,
    BorderSizePixel = 0,
    ClipsDescendants = true,
})
local mainCorner = Instance.new("UICorner", main); mainCorner.CornerRadius = UDim.new(0, 16)
local mainStroke = Instance.new("UIStroke", main); mainStroke.Color = Color3.fromRGB(165, 85, 255); mainStroke.Thickness = 2

-- background image (softly blended)
local bg = newInst("ImageLabel", {
    Parent = main,
    Size = UDim2.new(1,0,1,0),
    Position = UDim2.new(0,0,0,0),
    BackgroundTransparency = 1,
    Image = IMAGE_BG_ID,
    ScaleType = Enum.ScaleType.Crop,
    ImageTransparency = 0.18,
    ZIndex = 1
})
-- frosted overlay
local frost = newInst("Frame", {
    Parent = main,
    Size = UDim2.new(1,0,1,0),
    Position = UDim2.new(0,0,0,0),
    BackgroundColor3 = Color3.fromRGB(15,12,20),
    BackgroundTransparency = 0.25,
    ZIndex = 2
})
Instance.new("UICorner", frost).CornerRadius = UDim.new(0, 16)

-- Header
local header = newInst("Frame", {
    Parent = main,
    Size = UDim2.new(1,0,0,52),
    Position = UDim2.new(0,0,0,0),
    BackgroundTransparency = 1,
    ZIndex = 3,
})
local title = newInst("TextLabel", {
    Parent = header,
    Text = TITLE,
    TextSize = 18,
    Font = Enum.Font.GothamBold,
    TextColor3 = Color3.fromRGB(245,245,250),
    BackgroundTransparency = 1,
    Position = UDim2.new(0.04,0,0,0),
    Size = UDim2.new(0.6,0,1,0),
    TextXAlignment = Enum.TextXAlignment.Left,
})
local subtitle = newInst("TextLabel", {
    Parent = header,
    Text = SUBTITLE,
    TextSize = 12,
    Font = Enum.Font.Gotham,
    TextColor3 = Color3.fromRGB(200,200,210),
    BackgroundTransparency = 1,
    Position = UDim2.new(0.04,0,0.55,0),
    Size = UDim2.new(0.6,0,0.45,0),
    TextXAlignment = Enum.TextXAlignment.Left,
})

-- Minimize / Close controls
local closeBtn = newInst("TextButton", {
    Parent = header,
    Size = UDim2.new(0,36,0,28),
    Position = UDim2.new(0.92,0,0.12,0),
    BackgroundTransparency = 0.6,
    BackgroundColor3 = Color3.fromRGB(45,20,50),
    Text = "X",
    TextColor3 = Color3.fromRGB(255,120,120),
    Font = Enum.Font.GothamBold,
    TextSize = 18,
})
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0,6)

local minimizeBtn = newInst("TextButton", {
    Parent = header,
    Size = UDim2.new(0,36,0,28),
    Position = UDim2.new(0.86,0,0.12,0),
    BackgroundTransparency = 0.6,
    BackgroundColor3 = Color3.fromRGB(45,20,50),
    Text = "-",
    TextColor3 = Color3.fromRGB(220,220,220),
    Font = Enum.Font.GothamBold,
    TextSize = 18,
})
Instance.new("UICorner", minimizeBtn).CornerRadius = UDim.new(0,6)

-- Left tabbar
local tabbar = newInst("ScrollingFrame", {
    Parent = main,
    Size = UDim2.new(0, 140, 1, -52),
    Position = UDim2.new(0,0,0,52),
    BackgroundTransparency = 0.3,
    BackgroundColor3 = Color3.fromRGB(22,12,34),
    ScrollBarThickness = 6,
    BorderSizePixel = 0,
    ZIndex = 3,
})
Instance.new("UICorner", tabbar).CornerRadius = UDim.new(0,12)

-- Content area
local content = newInst("Frame", {
    Parent = main,
    Size = UDim2.new(1, -140, 1, -52),
    Position = UDim2.new(0,140,0,52),
    BackgroundTransparency = 0.16,
    BackgroundColor3 = Color3.fromRGB(30,10,50),
    ZIndex = 3,
})
Instance.new("UICorner", content).CornerRadius = UDim.new(0,12)
local contentScroll = newInst("ScrollingFrame", {
    Parent = content,
    Size = UDim2.new(1,-12,1,-12),
    Position = UDim2.new(0,6,0,6),
    BackgroundTransparency = 1,
    ScrollBarThickness = 6,
    CanvasSize = UDim2.new(0,0,0,0),
    ZIndex = 4,
})
contentScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y

-- Make draggable by header
makeDraggable(main, header)

-- Make round toggle show/hide main on click (and draggable already)
local opened = true
roundToggle.MouseButton1Click:Connect(function()
    opened = not opened
    if opened then
        tween(main, {Size = UDim2.new(0,540,0,370)}, 0.28)
        tween(main, {Position = UDim2.new(0.2,0,0.18,0)}, 0.28)
    else
        tween(main, {Size = UDim2.new(0,0,0,370)}, 0.28)
    end
end)

-- Minimize to a small top bar (shrinks height)
local minimized = false
minimizeBtn.MouseButton1Click:Connect(function()
    minimized = not minimized
    if minimized then
        tween(main, {Size = UDim2.new(0,540,0,52)}, 0.25)
    else
        tween(main, {Size = UDim2.new(0,540,0,370)}, 0.25)
    end
end)

-- Close right click opens delete confirm (we'll do right-click on closeBtn)
local popup = newInst("Frame", {
    Parent = screenGui,
    Size = UDim2.new(0, 280, 0, 150),
    Position = UDim2.new(0.5, -140, 0.5, -75),
    BackgroundColor3 = Color3.fromRGB(30,8,50),
    Visible = false,
    ZIndex = 90,
})
Instance.new("UICorner", popup).CornerRadius = UDim.new(0,10)
local popupLabel = newInst("TextLabel", {
    Parent = popup,
    Size = UDim2.new(1,0,0.5,0),
    Position = UDim2.new(0,0,0.12,0),
    BackgroundTransparency = 1,
    Text = "Xóa toàn bộ GUI?",
    TextColor3 = Color3.fromRGB(240,240,240),
    Font = Enum.Font.GothamBold,
    TextSize = 16,
})
local yesBtn = newInst("TextButton", {
    Parent = popup,
    Size = UDim2.new(0.44,0,0.28,0),
    Position = UDim2.new(0.05,0,0.6,0),
    Text = "Có",
    BackgroundColor3 = Color3.fromRGB(200,0,0),
    TextColor3 = Color3.fromRGB(255,255,255),
    Font = Enum.Font.GothamBold,
    TextSize = 14,
})
Instance.new("UICorner", yesBtn).CornerRadius = UDim.new(0,6)
local noBtn = newInst("TextButton", {
    Parent = popup,
    Size = UDim2.new(0.44,0,0.28,0),
    Position = UDim2.new(0.51,0,0.6,0),
    Text = "Không",
    BackgroundColor3 = Color3.fromRGB(75,0,120),
    TextColor3 = Color3.fromRGB(255,255,255),
    Font = Enum.Font.GothamBold,
    TextSize = 14,
})
Instance.new("UICorner", noBtn).CornerRadius = UDim.new(0,6)

closeBtn.MouseButton1Click:Connect(function()
    -- toggle minimized (same as minimize)
    minimized = not minimized
    if minimized then
        tween(main, {Size = UDim2.new(0,540,0,52)}, 0.25)
    else
        tween(main, {Size = UDim2.new(0,540,0,370)}, 0.25)
    end
end)

closeBtn.MouseButton2Click:Connect(function()
    popup.Visible = true
    tween(popup, {Position = UDim2.new(0.5, -140, 0.5, -75)}, 0.18)
end)
yesBtn.MouseButton1Click:Connect(function() screenGui:Destroy() end)
noBtn.MouseButton1Click:Connect(function() popup.Visible = false end)

-- ========== TAB SYSTEM & UI CREATION ==========
local Tabs = {}
local function updateContentCanvas()
    RunService.Heartbeat:Wait()
    -- contentScroll.AutomaticCanvasSize already set, but ensure small delay for layout
end

local function createTab(name)
    local idx = #Tabs + 1
    -- button
    local btn = newInst("TextButton", {
        Parent = tabbar,
        Size = UDim2.new(1,-16,0,48),
        Position = UDim2.new(0,8,0, (idx-1)*56 + 8),
        BackgroundColor3 = Color3.fromRGB(28,12,44),
        BackgroundTransparency = 0.2,
        Text = name,
        TextColor3 = Color3.fromRGB(220,220,240),
        Font = Enum.Font.GothamSemibold,
        TextSize = 14,
        AutoButtonColor = false,
        ZIndex = 4,
    })
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0,10)
    local indicator = newInst("Frame", {Parent = btn, Size = UDim2.new(0,6,1,0), Position = UDim2.new(0,0,0,0), BackgroundColor3 = Color3.fromRGB(165,85,255), Visible = false})
    -- page
    local page = newInst("Frame", {Parent = contentScroll, Size = UDim2.new(1, -12, 0, 10), BackgroundTransparency = 1, Position = UDim2.new(0,6,0,0)})
    local holder = newInst("Frame", {Parent = page, Size = UDim2.new(1,0,0,0), BackgroundTransparency = 1})
    local layout = Instance.new("UIListLayout", holder); layout.Padding = UDim.new(0,10); layout.SortOrder = Enum.SortOrder.LayoutOrder
    local pad = Instance.new("UIPadding", holder); pad.PaddingLeft = UDim.new(0,8); pad.PaddingRight = UDim.new(0,8); pad.PaddingTop = UDim.new(0,8)

    local function activate()
        for _,t in ipairs(Tabs) do
            t.button.BackgroundTransparency = 0.2
            t.button.TextColor3 = Color3.fromRGB(220,220,240)
            if t.button:FindFirstChildWhichIsA("Frame") then
                t.button:FindFirstChildWhichIsA("Frame").Visible = false
            end
            t.page.Visible = false
        end
        btn.BackgroundTransparency = 0.05
        btn.TextColor3 = Color3.fromRGB(255,255,255)
        indicator.Visible = true
        page.Visible = true

        -- adjust page size to content
        RunService.Heartbeat:Wait()
        page.Size = UDim2.new(1, -12, 0, holder.AbsoluteSize.Y + 16)
        updateContentCanvas()
    end

    btn.MouseButton1Click:Connect(activate)

    table.insert(Tabs, {name = name, button = btn, page = page, holder = holder})
    tabbar.CanvasSize = UDim2.new(0,0,0,#Tabs*56 + 12)

    -- auto activate first
    if #Tabs == 1 then
        activate()
    end

    return Tabs[#Tabs]
end

-- UI ELEMENT CREATORS (append into holder)
local function createLabel(holder, text)
    local f = newInst("Frame", {Parent = holder, Size = UDim2.new(1,0,0,36), BackgroundTransparency = 1})
    local lbl = newInst("TextLabel", {Parent = f, Size = UDim2.new(1,0,1,0), BackgroundTransparency = 1, Text = text, Font = Enum.Font.GothamBold, TextSize = 15, TextColor3 = Color3.fromRGB(245,245,250), TextXAlignment = Enum.TextXAlignment.Left})
    return f
end

local function createButton(holder, text, callback)
    local f = newInst("Frame", {Parent = holder, Size = UDim2.new(1,0,0,42), BackgroundTransparency = 1})
    local btn = newInst("TextButton", {Parent = f, Size = UDim2.new(1,0,1,0), BackgroundColor3 = Color3.fromRGB(90,30,150), Text = text, Font = Enum.Font.GothamBold, TextSize = 14, TextColor3 = Color3.fromRGB(255,255,255), AutoButtonColor = false})
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0,8)
    local stroke = Instance.new("UIStroke", btn); stroke.Color = Color3.fromRGB(180,110,255); stroke.Thickness = 1

    btn.MouseEnter:Connect(function() tween(btn, {BackgroundColor3 = Color3.fromRGB(110,40,190)}, 0.12) end)
    btn.MouseLeave:Connect(function() tween(btn, {BackgroundColor3 = Color3.fromRGB(90,30,150)}, 0.12) end)
    btn.MouseButton1Click:Connect(function()
        tween(btn, {Size = UDim2.new(1, -6, 1, -6)}, 0.06)
        wait(0.06)
        tween(btn, {Size = UDim2.new(1,0,1,0)}, 0.06)
        if callback then pcall(callback) end
    end)
    return btn
end

local function createToggle(holder, text, default, callback)
    local f = newInst("Frame", {Parent = holder, Size = UDim2.new(1,0,0,36), BackgroundTransparency = 1})
    local lbl = newInst("TextLabel", {Parent = f, Size = UDim2.new(0.7,0,1,0), BackgroundTransparency = 1, Text = text, Font = Enum.Font.Gotham, TextSize = 14, TextColor3 = Color3.fromRGB(230,230,240), TextXAlignment = Enum.TextXAlignment.Left})
    local togg = newInst("Frame", {Parent = f, Size = UDim2.new(0,48,0,26), Position = UDim2.new(0.78,0,0.1,0), BackgroundColor3 = Color3.fromRGB(60,30,100)})
    local tcorner = Instance.new("UICorner", togg); tcorner.CornerRadius = UDim.new(0,14)
    local dot = newInst("Frame", {Parent = togg, Size = UDim2.new(0,20,0,20), Position = default and UDim2.new(0.78,0,0.08,0) or UDim2.new(0.05,0,0.08,0), BackgroundColor3 = default and Color3.fromRGB(120,230,120) or Color3.fromRGB(200,200,200)})
    Instance.new("UICorner", dot).CornerRadius = UDim.new(0,12)
    local enabled = default or false
    togg:SetAttribute("Enabled", enabled)
    togg.MouseButton1Click = nil
    -- convert togg into clickable ImageButton for mobile touches
    local btn = newInst("TextButton", {Parent = togg, BackgroundTransparency = 1, Size = UDim2.new(1,0,1,0), Text = "", AutoButtonColor = false})
    btn.MouseButton1Click:Connect(function()
        enabled = not enabled
        if enabled then
            tween(dot, {Position = UDim2.new(0.78,0,0.08,0)}, 0.18)
            tween(dot, {BackgroundColor3 = Color3.fromRGB(120,230,120)}, 0.18)
        else
            tween(dot, {Position = UDim2.new(0.05,0,0.08,0)}, 0.18)
            tween(dot, {BackgroundColor3 = Color3.fromRGB(200,200,200)}, 0.18)
        end
        if callback then pcall(callback, enabled) end
    end)
    return f, function() return enabled end
end

local function createSlider(holder, labelText, min, max, default, callback)
    local f = newInst("Frame", {Parent = holder, Size = UDim2.new(1,0,0,64), BackgroundTransparency = 1})
    local lbl = newInst("TextLabel", {Parent = f, Text = labelText.." : "..tostring(default), BackgroundTransparency = 1, Font = Enum.Font.Gotham, TextSize = 13, TextColor3 = Color3.fromRGB(230,230,240), TextXAlignment = Enum.TextXAlignment.Left, Size = UDim2.new(1,0,0,20), Position = UDim2.new(0,8,0,4)})
    local barBg = newInst("Frame", {Parent = f, Size = UDim2.new(1,-16,0,16), Position = UDim2.new(0,8,0,36), BackgroundColor3 = Color3.fromRGB(60,25,110)})
    Instance.new("UICorner", barBg).CornerRadius = UDim.new(0,8)
    local fill = newInst("Frame", {Parent = barBg, Size = UDim2.new((default-min)/(max-min),0,1,0), BackgroundColor3 = Color3.fromRGB(165,85,255)})
    Instance.new("UICorner", fill).CornerRadius = UDim.new(0,8)
    local dragging = false
    barBg.InputBegan:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
            dragging = true
        end
    end)
    barBg.InputEnded:Connect(function(inp)
        if inp.UserInputState == Enum.UserInputState.End then
            dragging = false
        end
    end)
    UIS.InputChanged:Connect(function(inp)
        if dragging and (inp.UserInputType == Enum.UserInputType.MouseMovement or inp.UserInputType == Enum.UserInputType.Touch) then
            local rel = math.clamp((inp.Position.X - barBg.AbsolutePosition.X) / barBg.AbsoluteSize.X, 0, 1)
            fill.Size = UDim2.new(rel,0,1,0)
            local val = min + rel * (max-min)
            lbl.Text = labelText.." : "..string.format("%.2f", val)
            if callback then pcall(callback, val) end
        end
    end)
    return f
end

local function createDropdown(holder, labelText, options, callback)
    local f = newInst("Frame", {Parent = holder, Size = UDim2.new(1,0,0,44), BackgroundTransparency = 1})
    local lbl = newInst("TextLabel", {Parent = f, Text = labelText, BackgroundTransparency = 1, Font = Enum.Font.Gotham, TextSize = 14, TextColor3 = Color3.fromRGB(230,230,240), Size = UDim2.new(0.6,0,1,0), Position = UDim2.new(0,8,0,0), TextXAlignment = Enum.TextXAlignment.Left})
    local box = newInst("TextButton", {Parent = f, Size = UDim2.new(0.36,-12,0,34), Position = UDim2.new(0.64,4,0,6), Text = tostring(options[1] or "None"), Font = Enum.Font.Gotham, TextSize = 13, BackgroundColor3 = Color3.fromRGB(60,25,110), TextColor3 = Color3.fromRGB(255,255,255), AutoButtonColor = false})
    Instance.new("UICorner", box).CornerRadius = UDim.new(0,8)
    local panel = newInst("Frame", {Parent = f, Size = UDim2.new(0, box.AbsoluteSize.X, 0, 0), Position = UDim2.new(0.64,4,0,48), BackgroundColor3 = Color3.fromRGB(40,10,80), Visible = false})
    Instance.new("UICorner", panel).CornerRadius = UDim.new(0,8)
    local layout = Instance.new("UIListLayout", panel); layout.SortOrder = Enum.SortOrder.LayoutOrder; layout.Padding = UDim.new(0,6)
    local function rebuild()
        for _,c in ipairs(panel:GetChildren()) do if c:IsA("TextButton") then c:Destroy() end end
        local h = 8
        for i,opt in ipairs(options) do
            local optBtn = newInst("TextButton", {Parent = panel, Size = UDim2.new(1,-12,0,30), Position = UDim2.new(0,6,0,h), Text = tostring(opt), BackgroundColor3 = Color3.fromRGB(80,30,140), TextColor3 = Color3.fromRGB(255,255,255), Font = Enum.Font.Gotham, TextSize = 13, AutoButtonColor = false})
            Instance.new("UICorner", optBtn).CornerRadius = UDim.new(0,6)
            optBtn.MouseButton1Click:Connect(function()
                box.Text = tostring(opt)
                tween(panel, {Size = UDim2.new(0, box.AbsoluteSize.X, 0, 0)}, 0.14)
                wait(0.14)
                panel.Visible = false
                if callback then pcall(callback, opt) end
            end)
            h = h + 36
        end
        panel.Size = UDim2.new(0, box.AbsoluteSize.X, 0, math.min(h, 200))
    end
    box.MouseButton1Click:Connect(function()
        panel.Visible = not panel.Visible
        if panel.Visible then rebuild(); tween(panel, {Size = UDim2.new(0, box.AbsoluteSize.X, 0, math.min(#options*36 + 8, 200))}, 0.16) end
    end)
    return f
end

local function createTextbox(holder, placeholder, callback)
    local f = newInst("Frame", {Parent = holder, Size = UDim2.new(1,0,0,46), BackgroundTransparency = 1})
    local tb = newInst("TextBox", {Parent = f, Size = UDim2.new(1,-12,1,0), Position = UDim2.new(0,8,0,0), PlaceholderText = placeholder or "", Text = "", BackgroundColor3 = Color3.fromRGB(50,20,95), Font = Enum.Font.Gotham, TextSize = 14, TextColor3 = Color3.fromRGB(255,255,255)})
    Instance.new("UICorner", tb).CornerRadius = UDim.new(0,8)
    tb.ClearTextOnFocus = false
    tb.FocusLost:Connect(function(enter)
        if callback then pcall(callback, tb.Text) end
    end)
    return tb
end

local function createList(holder, items)
    local f = newInst("Frame", {Parent = holder, Size = UDim2.new(1,0,0,160), BackgroundTransparency = 1})
    local scroll = newInst("ScrollingFrame", {Parent = f, Size = UDim2.new(1,0,1,0), BackgroundTransparency = 1, CanvasSize = UDim2.new(0,0,0,0), ScrollBarThickness = 6})
    local layout = Instance.new("UIListLayout", scroll); layout.Padding = UDim.new(0,8); layout.SortOrder = Enum.SortOrder.LayoutOrder
    local pad = Instance.new("UIPadding", scroll); pad.PaddingTop = UDim.new(0,8); pad.PaddingLeft = UDim.new(0,8); pad.PaddingRight = UDim.new(0,8)
    local function rebuild()
        for _,c in ipairs(scroll:GetChildren()) do if c:IsA("Frame") then c:Destroy() end end
        local h = 8
        for i,v in ipairs(items) do
            local it = newInst("Frame", {Parent = scroll, Size = UDim2.new(1,-12,0,36), Position = UDim2.new(0,6,0,h), BackgroundColor3 = Color3.fromRGB(60,20,120)})
            Instance.new("UICorner", it).CornerRadius = UDim.new(0,8)
            local label = newInst("TextLabel", {Parent = it, Text = tostring(v), BackgroundTransparency = 1, Position = UDim2.new(0,8,0,0), Size = UDim2.new(0.7,0,1,0), Font = Enum.Font.Gotham, TextSize = 14, TextColor3 = Color3.fromRGB(245,245,250), TextXAlignment = Enum.TextXAlignment.Left})
            local btn = newInst("TextButton", {Parent = it, Text = "Select", Size = UDim2.new(0.24,-8,0.72,0), Position = UDim2.new(0.74, -8, 0.14, 0), BackgroundColor3 = Color3.fromRGB(120,30,170), Font = Enum.Font.GothamBold, TextSize = 13, TextColor3 = Color3.fromRGB(255,255,255)})
            Instance.new("UICorner", btn).CornerRadius = UDim.new(0,6)
            h = h + 44
        end
        scroll.CanvasSize = UDim2.new(0,0,0,h)
    end
    rebuild()
    return f
end

-- ========== BUILD SAMPLE TABS ==========
local tHome = createTab("Home")
local h = tHome.holder
createLabel(h, "Welcome to Fluent UI - PHUCMAX")
createButton(h, "Do Example Action", function()
    local notif = newInst("TextLabel", {Parent = screenGui, Size = UDim2.new(0,260,0,44), Position = UDim2.new(0.5,-130,0.12,0), BackgroundColor3 = Color3.fromRGB(45,15,70), Text = "Action done!", Font = Enum.Font.GothamBold, TextSize = 16, TextColor3 = Color3.fromRGB(255,255,255)})
    Instance.new("UICorner", notif).CornerRadius = UDim.new(0,8)
    tween(notif, {BackgroundTransparency = 0}, 0.15)
    wait(1.1)
    tween(notif, {BackgroundTransparency = 1, Position = UDim2.new(0.5,-130,0.06,0)}, 0.18)
    delay(0.4, function() notif:Destroy() end)
end)
local _,getAuto = createToggle(h, "Auto Mode", false, function(s) print("Auto", s) end)
createSlider(h, "Speed", 0, 100, 45, function(v) --print(v) end)
createDropdown(h, "Theme", {"Fluent Purple","Dark","Light"}, function(t) print("Theme", t) end)

local tControls = createTab("Controls")
local ch = tControls.holder
createLabel(ch, "Controls")
local tb = createTextbox(ch, "Type here...", function(txt) print("Typed:", txt) end)
createList(ch, {"Alpha","Beta","Gamma","Delta","Epsilon"})

local tSettings = createTab("Settings")
local sh = tSettings.holder
createLabel(sh, "Settings")
createToggle(sh, "Enable X", true, function(s) print("Enable X", s) end)
createSlider(sh, "Volume", 0, 1, 0.7, function(v) end)
createDropdown(sh, "Quality", {"Low","Medium","High"}, function(q) end)

-- finalize layout sizing for pages
RunService.Heartbeat:Wait()
for _,t in ipairs(Tabs) do
    t.page.Size = UDim2.new(1, -12, 0, t.holder.AbsoluteSize.Y + 16)
end
RunService.Heartbeat:Wait()
local totalH = 0
for _,p in ipairs(contentScroll:GetChildren()) do
    if p:IsA("Frame") then totalH = totalH + p.AbsoluteSize.Y + 12 end
end
contentScroll.CanvasSize = UDim2.new(0,0,0, math.max(totalH + 8, 10))

-- small animations for hover/press for roundToggle & main
roundToggle.MouseEnter:Connect(function() tween(roundToggle, {Size = UDim2.new(0,66,0,66)}, 0.12) end)
roundToggle.MouseLeave:Connect(function() tween(roundToggle, {Size = UDim2.new(0,60,0,60)}, 0.12) end)
roundToggle.MouseButton1Down:Connect(function() tween(overlay, {BackgroundTransparency = 0.3}, 0.06) end)
roundToggle.MouseButton1Up:Connect(function() tween(overlay, {BackgroundTransparency = 0.6}, 0.06) end)

-- initial appear animation
main.Position = UDim2.new(0.2, 0, 0.18, -40)
main.Size = UDim2.new(0,540,0,0)
tween(main, {Position = UDim2.new(0.2,0,0.18,0), Size = UDim2.new(0,540,0,370)}, 0.35, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)

print("PHUCMAX FLUENT UI loaded")