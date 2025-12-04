--========================================================--
--  PHUCMAX UI LIB - ALL IN (Tabs, Buttons, Toggles, Sliders,
--  Dropdowns, Textboxes, Lists, Animations, Minimize, Delete)
--  Paste into a LocalScript in StarterPlayerScripts
--========================================================--

-- Services
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local lp = Players.LocalPlayer
local playerGui = lp:WaitForChild("PlayerGui")

-- ================= CONFIG =================
local IMAGE_BG_ID = "87746599009295"    -- background image for main UI
local BUTTON_BG_ID = "87746599009295"   -- image for round toggle button
local TITLE = "PHUCMAX MENU"
local SUBTITLE = "By PHUCMAX đẹp trai"
-- ==========================================

-- Remove previous if exists
if playerGui:FindFirstChild("PHUCMAX_UI") then
    playerGui:FindFirstChild("PHUCMAX_UI"):Destroy()
end

-- Basic helper: tween
local function tween(inst, props, time, style, dir)
    style = style or Enum.EasingStyle.Quint
    dir = dir or Enum.EasingDirection.Out
    local info = TweenInfo.new(time or 0.25, style, dir)
    return TweenService:Create(inst, info, props)
end

-- Drag function (works with touch/mouse)
local function dragify(frame, dragArea)
    dragArea = dragArea or frame
    local dragging = false
    local dragInput, dragStart, startPos

    dragArea.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or
           input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    dragArea.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or
           input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)

    UIS.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X,
                                       startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
end

-- Create ScreenGui
local gui = Instance.new("ScreenGui")
gui.Name = "PHUCMAX_UI"
gui.ResetOnSpawn = false
gui.Parent = playerGui
gui.IgnoreGuiInset = true

-- Toggle (round draggable button)
local toggle = Instance.new("ImageButton")
toggle.Name = "PM_Toggle"
toggle.Parent = gui
toggle.Size = UDim2.new(0, 56, 0, 56)
toggle.Position = UDim2.new(0.02, 0, 0.45, 0)
toggle.AnchorPoint = Vector2.new(0,0)
toggle.BackgroundTransparency = 0
toggle.BackgroundColor3 = Color3.fromRGB(255,255,255)
toggle.Image = BUTTON_BG_ID
toggle.AutoButtonColor = false
toggle.ZIndex = 50
toggle.ScaleType = Enum.ScaleType.Crop
toggle.ClipsDescendants = true
tween(toggle, {BackgroundTransparency = 0.4}, 0.001):Play()
dragify(toggle)

-- Main frame
local main = Instance.new("Frame")
main.Name = "MainFrame"
main.Parent = gui
main.Size = UDim2.new(0, 520, 0, 360)
main.Position = UDim2.new(0.2, 0, 0.22, 0)
main.AnchorPoint = Vector2.new(0,0)
main.BackgroundColor3 = Color3.fromRGB(30,0,60)
main.BorderSizePixel = 0
main.ClipsDescendants = true

-- Rounded corners + stroke
local corner = Instance.new("UICorner", main)
corner.CornerRadius = UDim.new(0, 14)
local stroke = Instance.new("UIStroke", main)
stroke.Color = Color3.fromRGB(170, 85, 255)
stroke.Thickness = 2

-- Background image
local bg = Instance.new("ImageLabel", main)
bg.Name = "BG"
bg.Size = UDim2.new(1,0,1,0)
bg.Position = UDim2.new(0,0,0,0)
bg.BackgroundTransparency = 1
bg.Image = IMAGE_BG_ID
bg.ScaleType = Enum.ScaleType.Crop

-- Header
local header = Instance.new("Frame", main)
header.Name = "Header"
header.Size = UDim2.new(1,0,0,48)
header.Position = UDim2.new(0,0,0,0)
header.BackgroundTransparency = 1

local titleLabel = Instance.new("TextLabel", header)
titleLabel.Name = "Title"
titleLabel.Position = UDim2.new(0.04,0,0,0)
titleLabel.Size = UDim2.new(0.6,0,1,0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = TITLE
titleLabel.TextColor3 = Color3.fromRGB(255,255,255)
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextSize = 18
titleLabel.TextXAlignment = Enum.TextXAlignment.Left

local subLabel = Instance.new("TextLabel", header)
subLabel.Name = "Sub"
subLabel.Position = UDim2.new(0.04,0,0.55,0)
subLabel.Size = UDim2.new(0.6,0,0.4,0)
subLabel.BackgroundTransparency = 1
subLabel.Text = SUBTITLE
subLabel.TextColor3 = Color3.fromRGB(200,200,200)
subLabel.Font = Enum.Font.Gotham
subLabel.TextSize = 13
subLabel.TextXAlignment = Enum.TextXAlignment.Left

-- Close (X) button - left-click toggles minimize, right-click opens delete confirm
local closeBtn = Instance.new("TextButton", header)
closeBtn.Name = "Close"
closeBtn.Size = UDim2.new(0, 36, 0, 28)
closeBtn.Position = UDim2.new(0.92, 0, 0.12, 0)
closeBtn.BackgroundTransparency = 0.6
closeBtn.BackgroundColor3 = Color3.fromRGB(60,0,60)
local closeCorner = Instance.new("UICorner", closeBtn); closeCorner.CornerRadius = UDim.new(0,6)
closeBtn.Text = "X"
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextColor3 = Color3.fromRGB(255,120,120)
closeBtn.TextSize = 18

-- Left tab bar (scrolling)
local tabbar = Instance.new("ScrollingFrame", main)
tabbar.Name = "TabBar"
tabbar.Size = UDim2.new(0,120,1, -48)
tabbar.Position = UDim2.new(0,0,0,48)
tabbar.CanvasSize = UDim2.new(0,0,0,0)
tabbar.ScrollBarThickness = 6
tabbar.BackgroundTransparency = 0.35
tabbar.BackgroundColor3 = Color3.fromRGB(25,0,45)
tabbar.BorderSizePixel = 0
tabbar.AutomaticCanvasSize = Enum.AutomaticSize.Y
local tabCorner = Instance.new("UICorner", tabbar); tabCorner.CornerRadius = UDim.new(0,12)

-- Content container (right area)
local content = Instance.new("Frame", main)
content.Name = "Content"
content.Size = UDim2.new(1, -120, 1, -48)
content.Position = UDim2.new(0,120,0,48)
content.BackgroundTransparency = 0.25
content.BackgroundColor3 = Color3.fromRGB(40,0,70)
local contentCorner = Instance.new("UICorner", content); contentCorner.CornerRadius = UDim.new(0,12)

-- Inner scrolling content frame
local contentScroller = Instance.new("ScrollingFrame", content)
contentScroller.Name = "ContentScroll"
contentScroller.Size = UDim2.new(1,-12,1,-12)
contentScroller.Position = UDim2.new(0,6,0,6)
contentScroller.BackgroundTransparency = 1
contentScroller.CanvasSize = UDim2.new(0,0,0,0)
contentScroller.ScrollBarThickness = 6
contentScroller.AutomaticCanvasSize = Enum.AutomaticSize.Y

-- Popup confirm delete
local popup = Instance.new("Frame", gui)
popup.Name = "DeletePopup"
popup.Size = UDim2.new(0,260,0,140)
popup.Position = UDim2.new(0.5, -130, 0.5, -70)
popup.BackgroundColor3 = Color3.fromRGB(35,0,55)
popup.Visible = false
popup.ZIndex = 70
local popupCorner = Instance.new("UICorner", popup); popupCorner.CornerRadius = UDim.new(0,8)
local popupLabel = Instance.new("TextLabel", popup)
popupLabel.Size = UDim2.new(1,0,0.45,0)
popupLabel.Position = UDim2.new(0,0,0.12,0)
popupLabel.BackgroundTransparency = 1
popupLabel.Text = "Xoá toàn GUI?"
popupLabel.Font = Enum.Font.GothamBold
popupLabel.TextSize = 18
popupLabel.TextColor3 = Color3.fromRGB(255,255,255)
popupLabel.TextYAlignment = Enum.TextYAlignment.Top

local btnYes = Instance.new("TextButton", popup)
btnYes.Size = UDim2.new(0.45,0,0.28,0)
btnYes.Position = UDim2.new(0.05,0,0.6,0)
btnYes.Text = "Có"
btnYes.Font = Enum.Font.GothamBold
btnYes.TextSize = 16
btnYes.BackgroundColor3 = Color3.fromRGB(200,0,0)
btnYes.TextColor3 = Color3.fromRGB(255,255,255)
local btnYesCorner = Instance.new("UICorner", btnYes); btnYesCorner.CornerRadius = UDim.new(0,6)

local btnNo = Instance.new("TextButton", popup)
btnNo.Size = UDim2.new(0.45,0,0.28,0)
btnNo.Position = UDim2.new(0.5,0,0.6,0)
btnNo.Text = "Không"
btnNo.Font = Enum.Font.GothamBold
btnNo.TextSize = 16
btnNo.BackgroundColor3 = Color3.fromRGB(75,0,120)
btnNo.TextColor3 = Color3.fromRGB(255,255,255)
local btnNoCorner = Instance.new("UICorner", btnNo); btnNoCorner.CornerRadius = UDim.new(0,6)

-- state
local isOpen = true
local isMinimized = false

-- Toggle click opens/closes (scale horizontally)
toggle.MouseButton1Click:Connect(function()
    isOpen = not isOpen
    if isOpen then
        tween(main, {Size = UDim2.new(0,520,0,360)}, 0.28):Play()
    else
        tween(main, {Size = UDim2.new(0,0,0,360)}, 0.28):Play()
    end
end)

-- Close left click toggles minimized
closeBtn.MouseButton1Click:Connect(function()
    isMinimized = not isMinimized
    if isMinimized then
        tween(main, {Size = UDim2.new(0,520,0,48)}, 0.28):Play()
    else
        tween(main, {Size = UDim2.new(0,520,0,360)}, 0.28):Play()
    end
end)

-- Close right click opens delete popup
closeBtn.MouseButton2Click:Connect(function()
    popup.Visible = true
    tween(popup, {Position = UDim2.new(0.5, -130, 0.5, -70)}, 0.18):Play()
end)
btnYes.MouseButton1Click:Connect(function()
    gui:Destroy()
end)
btnNo.MouseButton1Click:Connect(function()
    popup.Visible = false
end)

-- drag main by header
dragify(main, header)

-- ================ UI LIB FUNCTIONS ================

local Tabs = {}
local currentTab = nil

-- utility to update content scroller CanvasSize
local function updateCanvas(scroller)
    -- wait one frame to let content adjust
    RunService.Heartbeat:Wait()
    local maxY = 0
    for _,c in ipairs(scroller:GetChildren()) do
        if c:IsA("Frame") or c:IsA("TextLabel") or c:IsA("ScrollingFrame") then
            local bottom = c.Position.Y.Offset + (c.Size.Y.Offset or 0)
            local bottomScale = c.Position.Y.Scale*scroller.AbsoluteSize.Y + c.Size.Y.Scale*scroller.AbsoluteSize.Y
            local candidate = c.AbsolutePosition.Y + c.AbsoluteSize.Y - scroller.AbsolutePosition.Y
            if candidate > maxY then maxY = candidate end
        end
    end
    scroller.CanvasSize = UDim2.new(0,0,0, math.max(maxY + 16, scroller.CanvasSize.Y.Offset or 0))
end

-- create tab button in left bar and container in content
local function createTab(name)
    local idx = #Tabs + 1
    -- tab button
    local btn = Instance.new("TextButton", tabbar)
    btn.Name = "Tab_"..idx
    btn.Size = UDim2.new(1, -12, 0, 46)
    btn.Position = UDim2.new(0, 6, 0, (idx-1)*52 + 6)
    btn.BackgroundTransparency = 0.6
    btn.BackgroundColor3 = Color3.fromRGB(40,0,70)
    btn.Text = name
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 14
    btn.TextColor3 = Color3.fromRGB(220,220,255)
    btn.AutoButtonColor = false
    local btnCorner = Instance.new("UICorner", btn); btnCorner.CornerRadius = UDim.new(0,10)
    local hover = Instance.new("Frame", btn); hover.Size = UDim2.new(0,6,1,0); hover.Position = UDim2.new(0,0,0,0); hover.BackgroundColor3 = Color3.fromRGB(170,85,255); hover.Visible = false
    hover.Name = "Hover"

    -- tab content frame
    local page = Instance.new("Frame", contentScroller)
    page.Name = "Page_"..idx
    page.Size = UDim2.new(1, -12, 0, 10)
    page.Position = UDim2.new(0,6,0,0)
    page.BackgroundTransparency = 1

    local pageScroll = Instance.new("Frame", page)
    pageScroll.Size = UDim2.new(1,0,1,0)
    pageScroll.BackgroundTransparency = 1

    -- container for content children (we will use automatic layout)
    local holder = Instance.new("Frame", page)
    holder.Name = "Holder"
    holder.Position = UDim2.new(0,0,0,0)
    holder.Size = UDim2.new(1,0,0,0)
    holder.BackgroundTransparency = 1

    local layout = Instance.new("UIListLayout", holder)
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Padding = UDim.new(0,8)

    local padding = Instance.new("UIPadding", holder)
    padding.PaddingTop = UDim.new(0,6)
    padding.PaddingLeft = UDim.new(0,6)
    padding.PaddingRight = UDim.new(0,6)
    padding.PaddingBottom = UDim.new(0,6)

    -- button behavior
    local function setActive()
        -- visually mark
        for _,b in ipairs(tabbar:GetChildren()) do
            if b:IsA("TextButton") then
                b.BackgroundTransparency = 0.6
                b.TextColor3 = Color3.fromRGB(220,220,255)
                if b:FindFirstChild("Hover") then b.Hover.Visible = false end
            end
        end
        btn.BackgroundTransparency = 0.12
        btn.TextColor3 = Color3.fromRGB(255,255,255)
        if hover then hover.Visible = true end

        -- hide others pages and show this
        for _,p in ipairs(contentScroller:GetChildren()) do
            p.Visible = false
        end
        page.Visible = true
        -- animate page size based on content
        updateCanvas(holder)
        page.Size = UDim2.new(1, -12, 0, holder.AbsoluteSize.Y + 12)
        contentScroller.CanvasSize = UDim2.new(0,0,0, page.AbsoluteSize.Y + 20)
        currentTab = page
    end

    btn.MouseButton1Click:Connect(function()
        setActive()
    end)

    -- add to Tabs list
    Tabs[#Tabs+1] = {name = name, button = btn, page = page, holder = holder}
    -- auto select first
    if #Tabs == 1 then
        setActive()
    end

    -- update tabbar CanvasSize
    tabbar.CanvasSize = UDim2.new(0,0,0, (#Tabs)*52 + 16)
    return Tabs[#Tabs]
end

-- UI ELEMENT CREATORS (adds into a tab's holder)
local function createLabel(holder, text)
    local frame = Instance.new("Frame", holder)
    frame.Size = UDim2.new(1,0,0,36)
    frame.BackgroundTransparency = 1
    local tl = Instance.new("TextLabel", frame)
    tl.Size = UDim2.new(1,0,1,0)
    tl.BackgroundTransparency = 1
    tl.Text = text
    tl.Font = Enum.Font.GothamBold
    tl.TextColor3 = Color3.fromRGB(245,245,255)
    tl.TextSize = 15
    tl.TextXAlignment = Enum.TextXAlignment.Left
    return frame
end

local function createButton(holder, text, callback)
    local frame = Instance.new("Frame", holder)
    frame.Size = UDim2.new(1,0,0,40)
    frame.BackgroundTransparency = 1

    local btn = Instance.new("TextButton", frame)
    btn.Size = UDim2.new(1,0,1,0)
    btn.BackgroundColor3 = Color3.fromRGB(100,30,140)
    btn.Text = text
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 15
    btn.TextColor3 = Color3.fromRGB(255,255,255)
    btn.AutoButtonColor = false
    local c = Instance.new("UICorner", btn); c.CornerRadius = UDim.new(0,8)
    local stroke = Instance.new("UIStroke", btn); stroke.Color = Color3.fromRGB(200,120,255); stroke.Thickness = 1

    btn.MouseEnter:Connect(function() tween(btn, {BackgroundColor3 = Color3.fromRGB(130,40,180)}, 0.14):Play() end)
    btn.MouseLeave:Connect(function() tween(btn, {BackgroundColor3 = Color3.fromRGB(100,30,140)}, 0.14):Play() end)
    btn.MouseButton1Click:Connect(function()
        -- press animation
        tween(btn, {Size = UDim2.new(1, -6, 1, -6)}, 0.06):Play()
        wait(0.06)
        tween(btn, {Size = UDim2.new(1,0,1,0)}, 0.06):Play()
        if callback then
            pcall(callback)
        end
    end)
    return btn
end

local function createToggle(holder, text, default, callback)
    local frame = Instance.new("Frame", holder)
    frame.Size = UDim2.new(1,0,0,36)
    frame.BackgroundTransparency = 1

    local label = Instance.new("TextLabel", frame)
    label.Size = UDim2.new(0.75,0,1,0)
    label.Position = UDim2.new(0,6,0,0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.Font = Enum.Font.Gotham
    label.TextSize = 14
    label.TextColor3 = Color3.fromRGB(230,230,255)
    label.TextXAlignment = Enum.TextXAlignment.Left

    local togg = Instance.new("ImageButton", frame)
    togg.Size = UDim2.new(0,46,0,26)
    togg.Position = UDim2.new(0.8,0,0.12,0)
    togg.BackgroundTransparency = 0
    togg.BackgroundColor3 = Color3.fromRGB(70,30,120)
    local tcorner = Instance.new("UICorner", togg); tcorner.CornerRadius = UDim.new(0,12)
    local dot = Instance.new("Frame", togg)
    dot.Size = UDim2.new(0,20,0,20)
    dot.Position = UDim2.new(default and 0.85 or 0.05,0,0.08,0)
    dot.BackgroundColor3 = default and Color3.fromRGB(120,230,120) or Color3.fromRGB(200,200,200)
    local dcorner = Instance.new("UICorner", dot); dcorner.CornerRadius = UDim.new(0,12)

    local enabled = default or false
    togg.MouseButton1Click:Connect(function()
        enabled = not enabled
        if enabled then
            tween(dot, {Position = UDim2.new(0.85,0,0.08,0)}, 0.18):Play()
            tween(dot, {BackgroundColor3 = Color3.fromRGB(120,230,120)}, 0.18):Play()
        else
            tween(dot, {Position = UDim2.new(0.05,0,0.08,0)}, 0.18):Play()
            tween(dot, {BackgroundColor3 = Color3.fromRGB(200,200,200)}, 0.18):Play()
        end
        if callback then pcall(callback, enabled) end
    end)
    return frame, function() return enabled end
end

local function createSlider(holder, text, min, max, default, callback)
    local frame = Instance.new("Frame", holder)
    frame.Size = UDim2.new(1,0,0,58)
    frame.BackgroundTransparency = 1

    local label = Instance.new("TextLabel", frame)
    label.Size = UDim2.new(1,0,0,18)
    label.Position = UDim2.new(0,6,0,0)
    label.BackgroundTransparency = 1
    label.Text = text.." : "..tostring(default)
    label.Font = Enum.Font.Gotham
    label.TextSize = 14
    label.TextColor3 = Color3.fromRGB(230,230,255)
    label.TextXAlignment = Enum.TextXAlignment.Left

    local barBg = Instance.new("Frame", frame)
    barBg.Size = UDim2.new(1,-12,0,16)
    barBg.Position = UDim2.new(0,6,0,28)
    barBg.BackgroundColor3 = Color3.fromRGB(70,30,120)
    local barCorner = Instance.new("UICorner", barBg); barCorner.CornerRadius = UDim.new(0,8)
    local fill = Instance.new("Frame", barBg)
    fill.Size = UDim2.new((default-min)/(max-min),0,1,0)
    fill.BackgroundColor3 = Color3.fromRGB(170,85,255)
    local fillCorner = Instance.new("UICorner", fill); fillCorner.CornerRadius = UDim.new(0,8)

    local dragging = false
    barBg.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
        end
    end)
    barBg.InputEnded:Connect(function(input)
        if input.UserInputState == Enum.UserInputState.End then
            dragging = false
        end
    end)
    UIS.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local rel = math.clamp((input.Position.X - barBg.AbsolutePosition.X) / barBg.AbsoluteSize.X, 0, 1)
            fill.Size = UDim2.new(rel,0,1,0)
            local value = min + rel * (max-min)
            label.Text = text.." : "..string.format("%.2f", value)
            if callback then pcall(callback, value) end
        end
    end)

    return frame
end

local function createDropdown(holder, text, options, callback)
    local frame = Instance.new("Frame", holder)
    frame.Size = UDim2.new(1,0,0,40)
    frame.BackgroundTransparency = 1

    local label = Instance.new("TextLabel", frame)
    label.Size = UDim2.new(0.6,0,1,0)
    label.Position = UDim2.new(0,6,0,0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.Font = Enum.Font.Gotham
    label.TextSize = 14
    label.TextColor3 = Color3.fromRGB(230,230,255)
    label.TextXAlignment = Enum.TextXAlignment.Left

    local box = Instance.new("TextButton", frame)
    box.Size = UDim2.new(0.38, -10, 0.9, 0)
    box.Position = UDim2.new(0.62,6,0.05,0)
    box.Text = tostring(options[1] or "None")
    box.Font = Enum.Font.Gotham
    box.TextSize = 14
    box.BackgroundColor3 = Color3.fromRGB(70,30,120)
    box.TextColor3 = Color3.fromRGB(255,255,255)
    box.AutoButtonColor = false
    local boxCorner = Instance.new("UICorner", box); boxCorner.CornerRadius = UDim.new(0,6)

    -- dropdown panel
    local panel = Instance.new("Frame", frame)
    panel.Size = UDim2.new(0, box.AbsoluteSize.X, 0, 0)
    panel.Position = UDim2.new(0.62,6,0, 46)
    panel.BackgroundColor3 = Color3.fromRGB(50,10,80)
    panel.Visible = false
    local panelCorner = Instance.new("UICorner", panel); panelCorner.CornerRadius = UDim.new(0,6)

    local listLayout = Instance.new("UIListLayout", panel)
    listLayout.SortOrder = Enum.SortOrder.LayoutOrder
    listLayout.Padding = UDim.new(0,4)

    local function rebuildPanel()
        for i,v in ipairs(panel:GetChildren()) do
            if v:IsA("TextButton") then v:Destroy() end
        end
        local totalHeight = 6
        for i,opt in ipairs(options) do
            local optBtn = Instance.new("TextButton", panel)
            optBtn.Size = UDim2.new(1, -8, 0, 30)
            optBtn.Position = UDim2.new(0,4,0, totalHeight - 4)
            optBtn.BackgroundColor3 = Color3.fromRGB(85,40,155)
            optBtn.Text = tostring(opt)
            optBtn.Font = Enum.Font.Gotham
            optBtn.TextSize = 14
            optBtn.TextColor3 = Color3.fromRGB(255,255,255)
            local oc = Instance.new("UICorner", optBtn); oc.CornerRadius = UDim.new(0,6)
            optBtn.MouseButton1Click:Connect(function()
                box.Text = tostring(opt)
                panel.Visible = false
                tween(panel, {Size = UDim2.new(0, box.AbsoluteSize.X, 0, 0)}, 0.18):Play()
                if callback then pcall(callback, opt) end
            end)
            totalHeight = totalHeight + 34
        end
        panel.Size = UDim2.new(0, box.AbsoluteSize.X, 0, totalHeight)
    end

    box.MouseButton1Click:Connect(function()
        panel.Visible = not panel.Visible
        if panel.Visible then
            rebuildPanel()
            tween(panel, {Size = UDim2.new(0, box.AbsoluteSize.X, 0, math.min(200, (#options)*34 + 8))}, 0.17):Play()
        else
            tween(panel, {Size = UDim2.new(0, box.AbsoluteSize.X, 0, 0)}, 0.12):Play()
        end
    end)

    return frame
end

local function createTextbox(holder, placeholder, callback)
    local frame = Instance.new("Frame", holder)
    frame.Size = UDim2.new(1,0,0,44)
    frame.BackgroundTransparency = 1

    local box = Instance.new("TextBox", frame)
    box.Size = UDim2.new(1,-12,1,0)
    box.Position = UDim2.new(0,6,0,0)
    box.PlaceholderText = placeholder or ""
    box.Text = ""
    box.ClearTextOnFocus = false
    box.Font = Enum.Font.Gotham
    box.TextSize = 14
    box.TextColor3 = Color3.fromRGB(255,255,255)
    box.BackgroundColor3 = Color3.fromRGB(60,20,100)
    box.TextXAlignment = Enum.TextXAlignment.Left
    local bc = Instance.new("UICorner", box); bc.CornerRadius = UDim.new(0,8)

    box.FocusLost:Connect(function(enter)
        if callback then pcall(callback, box.Text) end
    end)
    return box
end

local function createList(holder, items)
    local frame = Instance.new("Frame", holder)
    frame.Size = UDim2.new(1,0,0,150)
    frame.BackgroundTransparency = 1

    local scroll = Instance.new("ScrollingFrame", frame)
    scroll.Size = UDim2.new(1,0,1,0)
    scroll.BackgroundTransparency = 1
    scroll.CanvasSize = UDim2.new(0,0,0,0)
    scroll.ScrollBarThickness = 6

    local layout = Instance.new("UIListLayout", scroll)
    layout.Padding = UDim.new(0,6)
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    local padding = Instance.new("UIPadding", scroll)
    padding.PaddingTop = UDim.new(0,6)
    padding.PaddingLeft = UDim.new(0,6)
    padding.PaddingRight = UDim.new(0,6)
    padding.PaddingBottom = UDim.new(0,6)

    local function rebuild()
        for _,c in ipairs(scroll:GetChildren()) do
            if c:IsA("Frame") and c.Name ~= "UIListLayout" then c:Destroy() end
        end
        local total = 6
        for i,item in ipairs(items) do
            local it = Instance.new("Frame", scroll)
            it.Size = UDim2.new(1, -12, 0, 34)
            it.Position = UDim2.new(0,6,0, total)
            it.BackgroundColor3 = Color3.fromRGB(60,20,120)
            it.Name = "Item_"..i
            local c = Instance.new("UICorner", it); c.CornerRadius = UDim.new(0,8)
            local label = Instance.new("TextLabel", it)
            label.Size = UDim2.new(0.8,0,1,0)
            label.Position = UDim2.new(0,8,0,0)
            label.BackgroundTransparency = 1
            label.Text = tostring(item)
            label.Font = Enum.Font.Gotham
            label.TextSize = 14
            label.TextColor3 = Color3.fromRGB(240,240,255)
            local btn = Instance.new("TextButton", it)
            btn.Size = UDim2.new(0.18, -8, 0.8, 0)
            btn.Position = UDim2.new(0.82, -6, 0.1, 0)
            btn.Text = "Select"
            btn.Font = Enum.Font.GothamBold
            btn.TextSize = 12
            btn.BackgroundColor3 = Color3.fromRGB(120,30,170)
            btn.TextColor3 = Color3.fromRGB(255,255,255)
            local bc = Instance.new("UICorner", btn); bc.CornerRadius = UDim.new(0,6)
            total = total + 40
        end
        scroll.CanvasSize = UDim2.new(0,0,0, total)
    end

    rebuild()
    return frame
end

-- ============== BUILD SAMPLE TABS & ELEMENTS ==============

-- Tab: Home
local tHome = createTab("Home")
local h = tHome.holder
createLabel(h, "Welcome to PHUCMAX UI!")
local btn1 = createButton(h, "Example Action", function()
    -- small notification animation
    local notif = Instance.new("TextLabel", gui)
    notif.Size = UDim2.new(0,240,0,44)
    notif.Position = UDim2.new(0.5, -120, 0.1, 0)
    notif.BackgroundColor3 = Color3.fromRGB(50,0,80)
    notif.TextColor3 = Color3.fromRGB(255,255,255)
    notif.Text = "Action executed!"
    notif.Font = Enum.Font.GothamBold
    notif.TextSize = 16
    notif.AnchorPoint = Vector2.new(0.5,0)
    local nc = Instance.new("UICorner", notif); nc.CornerRadius = UDim.new(0,8)
    tween(notif, {Position = UDim2.new(0.5, -120, 0.08, 0), BackgroundTransparency = 0}, 0.18):Play()
    wait(1.2)
    tween(notif, {Position = UDim2.new(0.5, -120, 0.02, 0), BackgroundTransparency = 1}, 0.18):Play()
    delay(0.4, function() notif:Destroy() end)
end)

local toggleFrame, toggleGetter = createToggle(h, "Auto Mode", false, function(state)
    print("Auto Mode:", state)
end)

local sl = createSlider(h, "Speed", 0, 100, 50, function(v)
    -- do something with v
end)

local dd = createDropdown(h, "Choose", {"Option A", "Option B", "Option C"}, function(opt)
    print("Picked", opt)
end)

-- Tab: Controls
local tControl = createTab("Controls")
local ch = tControl.holder
createLabel(ch, "Interactive Controls")
local tb = createTextbox(ch, "Nhập gì đó...", function(text)
    print("Textbox:", text)
end)
local list = createList(ch, {"Item 1", "Item 2", "Item 3", "Item 4", "Item 5"})

-- Tab: Misc
local tMisc = createTab("Misc")
local mh = tMisc.holder
createLabel(mh, "All Buttons")
for i=1,6 do
    createButton(mh, "Button "..i, function()
        print("Button "..i.." clicked")
    end)
end

-- Tab: Settings
local tSet = createTab("Settings")
local sh = tSet.holder
createLabel(sh, "Configurables")
createToggle(sh, "Enable Feature X", true, function(s) print("X", s) end)
createSlider(sh, "Volume", 0, 1, 0.5, function(v) end)
createDropdown(sh, "Theme", {"Purple","Blue","Dark"}, function(t) end)

-- After adding elements, update sizes
for _,tab in ipairs(Tabs) do
    -- set holder height to content
    RunService.Heartbeat:Wait()
    tab.page.Size = UDim2.new(1, -12, 0, tab.holder.AbsoluteSize.Y + 12)
end
-- adjust contentScroller canvas
RunService.Heartbeat:Wait()
local totalHeight = 0
for _,p in ipairs(contentScroller:GetChildren()) do
    if p:IsA("Frame") then
        totalHeight = totalHeight + p.AbsoluteSize.Y + 8
    end
end
contentScroller.CanvasSize = UDim2.new(0,0,0, totalHeight + 8)

-- Smooth scroll optimization: clamp input
tabbar.ScrollingEnabled = true
contentScroller.ScrollingEnabled = true

-- Make toggle draggable to reposition (already handled), but animate on press
toggle.MouseEnter:Connect(function() tween(toggle, {Size = UDim2.new(0,62,0,62)}, 0.12):Play() end)
toggle.MouseLeave:Connect(function() tween(toggle, {Size = UDim2.new(0,56,0,56)}, 0.12):Play() end)
toggle.MouseButton1Down:Connect(function() tween(toggle, {BackgroundTransparency = 0.2}, 0.06):Play() end)
toggle.MouseButton1Up:Connect(function() tween(toggle, {BackgroundTransparency = 0.4}, 0.06):Play() end)

-- ensure main initially visible with animation
main.Size = UDim2.new(0,0,0,360)
tween(main, {Size = UDim2.new(0,520,0,360)}, 0.28):Play()

print("PHUCMAX UI (ALL-IN) loaded")