--========================================================--
-- PHUCMAX FULL MOBILE UI LIB - ALL IN ONE: 
-- Tabs, Buttons, Toggles, Sliders, Dropdowns, Textbox, List, 
-- Music Demo, Theme Changer, Ripple/Slide/Tooltip Animation,
-- Minimize, Delete, Kéo thả, Đổi màu, Icon nền, Hỗ trợ mobile/pc
-- Paste vào LocalScript StarterPlayerScripts
--========================================================--

--------------------------- CẤU HÌNH NHANH --------------------------
local BG_IMG_ID     = "rbxassetid://87746599009295"     -- đổi ID nền
local BTN_BG_ID    = "rbxassetid://87746599009295"     -- đổi ID nút tròn
local TITLE        = "PHUCMAX GUI"
local SUBTITLE     = "by PHUCMAX đẹp trai"
---------------------------------------------------------------------

local allThemes = {
  ["Purple"]={main=Color3.fromRGB(30,0,60), accent=Color3.fromRGB(170,85,255)};
  ["Pink"]={main=Color3.fromRGB(60,0,80), accent=Color3.fromRGB(255,120,202)};
  ["Dark"]={main=Color3.fromRGB(18,18,28), accent=Color3.fromRGB(90,105,255)};
  ["Green"]={main=Color3.fromRGB(14,32,14), accent=Color3.fromRGB(85,255,155)};
  ["Light"]={main=Color3.fromRGB(226,228,255), accent=Color3.fromRGB(135,120,255)};
}

--------------------------- CODE KIẾN TRÚC --------------------------
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local lp = Players.LocalPlayer
local playerGui = lp:WaitForChild("PlayerGui")

-- Xoá GUI cũ nếu còn
if playerGui:FindFirstChild("PHUCMAX_UI") then
    playerGui:FindFirstChild("PHUCMAX_UI"):Destroy()
end

local function tween(inst, props, time, style, dir)
    style = style or Enum.EasingStyle.Quint
    dir = dir or Enum.EasingDirection.Out
    local info = TweenInfo.new(time or 0.23, style, dir)
    return TweenService:Create(inst, info, props)
end

local function dragify(frame, dragArea)
    dragArea = dragArea or frame
    local dragging = false
    local dragInput, dragStart, startPos
    dragArea.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
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
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)
    UIS.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
end

local function shakeFrame(f)
    for i=1,6 do
        tween(f,{Position=f.Position+UDim2.new(0,math.random(-7,7),0,math.random(-7,7))},0.045):Play()
        wait(0.035)
    end
    tween(f,{Position=UDim2.new(f.Position.X.Scale,math.clamp(f.Position.X.Offset,0,math.huge),f.Position.Y.Scale,math.clamp(f.Position.Y.Offset,0,math.huge))},0.14):Play()
end

--------------------------- CẤU TRÚC GIAO DIỆN --------------------------

-- ScreenGui
local gui = Instance.new("ScreenGui")
gui.Name = "PHUCMAX_UI"
gui.IgnoreGuiInset = true
gui.ResetOnSpawn = false
gui.Parent = playerGui

-- Nút bật/tắt menu bo tròn, kéo thả trái giữa màn hình
local toggle = Instance.new("ImageButton")
toggle.Name = "MenuToggle"
toggle.Parent = gui
toggle.Size = UDim2.new(0, 56, 0, 56)
toggle.Position = UDim2.new(0.01, 0, 0.45, 0)
toggle.BackgroundColor3 = Color3.fromRGB(255,255,255)
toggle.BackgroundTransparency = 0.3
toggle.Image = BTN_BG_ID
toggle.ScaleType = Enum.ScaleType.Crop
toggle.ZIndex = 50
toggle.AutoButtonColor = false
dragify(toggle)

-- Main UI frame
local main = Instance.new("Frame")
main.Name = "MainFrame"
main.Parent = gui
main.Size = UDim2.new(0, 500, 0, 350)
main.Position = UDim2.new(0.2, 0, 0.2, 0)
main.AnchorPoint = Vector2.new(0,0)
main.BackgroundColor3 = allThemes["Purple"].main
main.BorderSizePixel = 0
main.ClipsDescendants = true
local mainCorner = Instance.new("UICorner", main)
mainCorner.CornerRadius = UDim.new(0, 16)
local mainStroke = Instance.new("UIStroke", main)
mainStroke.Color = allThemes["Purple"].accent
mainStroke.Thickness = 2

-- Background ảnh
local bg = Instance.new("ImageLabel", main)
bg.Name = "BG"
bg.Size = UDim2.new(1,0,1,0)
bg.Position = UDim2.new(0,0,0,0)
bg.BackgroundTransparency = 1
bg.Image = BG_IMG_ID
bg.ScaleType = Enum.ScaleType.Crop

-- HEADER
local header = Instance.new("Frame", main)
header.Name = "Header"
header.Size = UDim2.new(1,0,0,50)
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
subLabel.Position = UDim2.new(0.04,0,0.6,0)
subLabel.Size = UDim2.new(0.6,0,0.4,0)
subLabel.BackgroundTransparency = 1
subLabel.Text = SUBTITLE
subLabel.TextColor3 = Color3.fromRGB(200,200,200)
subLabel.Font = Enum.Font.Gotham
subLabel.TextSize = 13
subLabel.TextXAlignment = Enum.TextXAlignment.Left

-- Nút X đóng/thu nhỏ
local closeBtn = Instance.new("TextButton", header)
closeBtn.Name = "Close"
closeBtn.Size = UDim2.new(0, 36, 0, 28)
closeBtn.Position = UDim2.new(0.92, 0, 0.13, 0)
closeBtn.BackgroundTransparency = 0.4
closeBtn.BackgroundColor3 = Color3.fromRGB(60,0,60)
local closeCorner = Instance.new("UICorner", closeBtn)
closeCorner.CornerRadius = UDim.new(0,7)
closeBtn.Text = "X"
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextColor3 = Color3.fromRGB(255,120,120)
closeBtn.TextSize = 18

-- Tabbar trái cuộn
local tabbar = Instance.new("ScrollingFrame", main)
tabbar.Name = "TabBar"
tabbar.Size = UDim2.new(0,120,1, -50)
tabbar.Position = UDim2.new(0,0,0,50)
tabbar.CanvasSize = UDim2.new(0,0,0,0)
tabbar.ScrollBarThickness = 7
tabbar.BackgroundColor3 = Color3.fromRGB(25,0,45)
tabbar.BackgroundTransparency = 0.4
tabbar.BorderSizePixel = 0
tabbar.ScrollingEnabled = true
tabbar.AutomaticCanvasSize = Enum.AutomaticSize.Y
local tabCorner = Instance.new("UICorner", tabbar)
tabCorner.CornerRadius = UDim.new(0,12)

-- Content
local content = Instance.new("Frame", main)
content.Name = "Content"
content.Size = UDim2.new(1, -120, 1, -50)
content.Position = UDim2.new(0,120,0,50)
content.BackgroundTransparency = 0.22
content.BackgroundColor3 = Color3.fromRGB(40,0,70)
local contentCorner = Instance.new("UICorner", content)
contentCorner.CornerRadius = UDim.new(0,12)
local contentScroller = Instance.new("ScrollingFrame", content)
contentScroller.Name = "ContentScroll"
contentScroller.Size = UDim2.new(1,-8,1,-8)
contentScroller.Position = UDim2.new(0,4,0,4)
contentScroller.BackgroundTransparency = 1
contentScroller.CanvasSize = UDim2.new(0,0,0,0)
contentScroller.ScrollBarThickness = 6
contentScroller.ScrollingEnabled = true
contentScroller.AutomaticCanvasSize = Enum.AutomaticSize.Y

-- Popup xác nhận xoá
local popup = Instance.new("Frame", gui)
popup.Name = "DeletePopup"
popup.Size = UDim2.new(0,260,0,130)
popup.Position = UDim2.new(0.5, -130, 0.5, -65)
popup.BackgroundColor3 = Color3.fromRGB(35,0,55)
popup.Visible = false
popup.ZIndex = 70
local popupCorner = Instance.new("UICorner", popup)
popupCorner.CornerRadius = UDim.new(0,8)
local popupLabel = Instance.new("TextLabel", popup)
popupLabel.Size = UDim2.new(1,0,0.5,0)
popupLabel.Position = UDim2.new(0,0,0.1,0)
popupLabel.BackgroundTransparency = 1
popupLabel.Text = "Xoá toàn GUI?"
popupLabel.Font = Enum.Font.GothamBold
popupLabel.TextSize = 18
popupLabel.TextColor3 = Color3.fromRGB(255,255,255)
popupLabel.TextYAlignment = Enum.TextYAlignment.Top
local btnYes = Instance.new("TextButton", popup)
btnYes.Size = UDim2.new(0.4,0,0.25,0)
btnYes.Position = UDim2.new(0.09,0,0.65,0)
btnYes.Text = "Có"
btnYes.Font = Enum.Font.GothamBold
btnYes.TextSize = 15
btnYes.BackgroundColor3 = Color3.fromRGB(200,0,0)
btnYes.TextColor3 = Color3.fromRGB(255,255,255)
local btnYesCorner = Instance.new("UICorner", btnYes)
btnYesCorner.CornerRadius = UDim.new(0,7)
local btnNo = Instance.new("TextButton", popup)
btnNo.Size = UDim2.new(0.4,0,0.25,0)
btnNo.Position = UDim2.new(0.51,0,0.65,0)
btnNo.Text = "Không"
btnNo.Font = Enum.Font.GothamBold
btnNo.TextSize = 15
btnNo.BackgroundColor3 = Color3.fromRGB(80,0,120)
btnNo.TextColor3 = Color3.fromRGB(255,255,255)
local btnNoCorner = Instance.new("UICorner", btnNo)
btnNoCorner.CornerRadius = UDim.new(0,7)

local tipRoot = Instance.new("Folder", gui) -- chứa tooltip

---------------------- HÀM HỖ TRỢ ANIMATION + TOOLTIP --------------------

local function animateAppear(f)
    f.BackgroundTransparency = 1
    spawn(function()
        wait(math.random() * 0.08)
        tween(f, {BackgroundTransparency = 0}, 0.20):Play()
        if f:FindFirstChildOfClass("TextLabel") then
            f:FindFirstChildOfClass("TextLabel").TextTransparency = 1
            tween(f:FindFirstChildOfClass("TextLabel"), {TextTransparency = 0}, 0.13):Play()
        end
    end)
end

local function addTooltip(obj, tiptext)
    local tip = Instance.new("TextLabel", tipRoot)
    tip.Size = UDim2.new(0,180,0,28)
    tip.BackgroundColor3 = Color3.fromRGB(60,0,60)
    tip.BackgroundTransparency = 0.2
    tip.TextColor3 = Color3.fromRGB(255,255,255)
    tip.Font = Enum.Font.GothamBold
    tip.TextSize = 13
    tip.Visible = false
    tip.Text = tiptext
    local tcorner = Instance.new("UICorner", tip)
    tcorner.CornerRadius = UDim.new(0,6)
    obj.MouseEnter:Connect(function()
        tip.Visible = true
        tip.Text = tiptext
        tip.Position = UDim2.new(0, obj.AbsolutePosition.X+obj.AbsoluteSize.X+5, 0, obj.AbsolutePosition.Y)
        tip.ZIndex = obj.ZIndex+30
        tween(tip,{BackgroundTransparency=0.1},0.14):Play()
    end)
    obj.MouseLeave:Connect(function()
        tween(tip,{BackgroundTransparency=1},0.18):Play()
        delay(0.2, function() tip.Visible=false end)
    end)
end

--------------------------- LOGIC NÚT, CLOSE, TOGGLE --------------------

local isOpen, isMinimized = true, false
toggle.MouseButton1Click:Connect(function()
    isOpen = not isOpen
    if isOpen then
        tween(main, {Size = UDim2.new(0,500,0,350)}, 0.25):Play()
        shakeFrame(main)
    else
        tween(main, {Size = UDim2.new(0,0,0,350)}, 0.18):Play()
        shakeFrame(main)
    end
end)
closeBtn.MouseButton1Click:Connect(function()
    isMinimized = not isMinimized
    if isMinimized then
        tween(main, {Size = UDim2.new(0,500,0,50)}, 0.21):Play()
        shakeFrame(main)
    else
        tween(main, {Size = UDim2.new(0,500,0,350)}, 0.21):Play()
        shakeFrame(main)
    end
end)
closeBtn.MouseButton2Click:Connect(function()
    popup.Visible = true
    tween(popup, {Position = UDim2.new(0.5, -130, 0.5, -65)}, 0.14):Play()
end)
closeBtn.MouseButton1Down:Connect(function()
    task.wait(1)
    if not isMinimized then
        popup.Visible = true
        tween(popup, {Position = UDim2.new(0.5, -130, 0.5, -65)}, 0.14):Play()
    end
end)
btnYes.MouseButton1Click:Connect(function() gui:Destroy() end)
btnNo.MouseButton1Click:Connect(function() popup.Visible = false end)
dragify(main, header)
toggle.MouseEnter:Connect(function() tween(toggle, {Size = UDim2.new(0,62,0,62)}, 0.14):Play() end)
toggle.MouseLeave:Connect(function() tween(toggle, {Size = UDim2.new(0,56,0,56)}, 0.12):Play() end)
toggle.MouseButton1Down:Connect(function() tween(toggle, {BackgroundTransparency = 0.10}, 0.08):Play() end)
toggle.MouseButton1Up:Connect(function() tween(toggle, {BackgroundTransparency = 0.3}, 0.08):Play() end)
main.Size = UDim2.new(0,0,0,350)
tween(main, {Size = UDim2.new(0,500,0,350)}, 0.24):Play()

-------------------- UI LIBRARY (TABS, ELEMENTS, ... ) -------------------

local Tabs, currentTab = {}, nil
local function updateCanvas(scroller)
    RunService.Heartbeat:Wait()
    local maxY = 0
    for _,c in ipairs(scroller:GetChildren()) do
        if c:IsA("Frame") or c:IsA("TextLabel") or c:IsA("ScrollingFrame") then
            local bottom = c.Position.Y.Offset + (c.Size.Y.Offset or 0)
            local candidate = c.AbsolutePosition.Y + c.AbsoluteSize.Y - scroller.AbsolutePosition.Y
            if candidate > maxY then maxY = candidate end
        end
    end
    scroller.CanvasSize = UDim2.new(0,0,0, math.max(maxY + 16, scroller.CanvasSize.Y.Offset or 0))
end

local function createTab(name)
    local idx = #Tabs+1
    local btn = Instance.new("TextButton", tabbar)
    btn.Name = "Tab_" .. idx
    btn.Size = UDim2.new(1,-12,0,44)
    btn.Position = UDim2.new(0,6,0,(idx-1)*50+6)
    btn.BackgroundTransparency = 0.65
    btn.BackgroundColor3 = Color3.fromRGB(40,0,70)
    btn.Text = name
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 14
    btn.TextColor3 = Color3.fromRGB(220,220,255)
    btn.AutoButtonColor = false
    local tabBtnCorner = Instance.new("UICorner", btn)
    tabBtnCorner.CornerRadius = UDim.new(0,9)
    local hover = Instance.new("Frame", btn)
    hover.Size = UDim2.new(0,5,1,0)
    hover.Position = UDim2.new(0,0,0,0)
    hover.BackgroundColor3 = allThemes["Purple"].accent
    hover.Visible = false
    hover.Name = "Hover"
    -- Content page
    local page = Instance.new("Frame", contentScroller)
    page.Name = "Page_"..idx
    page.Size = UDim2.new(1,-10,0,10)
    page.Position = UDim2.new(0,6,0,0)
    page.BackgroundTransparency = 1
    local holder = Instance.new("Frame", page)
    holder.Name = "Holder"
    holder.Position = UDim2.new(0,0,0,0)
    holder.Size = UDim2.new(1,0,0,1)
    holder.BackgroundTransparency = 1
    local layout = Instance.new("UIListLayout", holder)
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Padding = UDim.new(0,8)
    local padding = Instance.new("UIPadding", holder)
    padding.PaddingTop = UDim.new(0,6)
    padding.PaddingLeft = UDim.new(0,6)
    padding.PaddingRight = UDim.new(0,6)
    padding.PaddingBottom = UDim.new(0,6)
    local function setActive()
        for _,b in ipairs(tabbar:GetChildren()) do
            if b:IsA("TextButton") then
                b.BackgroundTransparency = 0.65
                b.TextColor3 = Color3.fromRGB(220,220,255)
                if b:FindFirstChild("Hover") then b.Hover.Visible = false end
            end
        end
        btn.BackgroundTransparency = 0.11
        btn.TextColor3 = Color3.fromRGB(255,255,255)
        hover.Visible = true
        tween(btn, {BackgroundColor3=allThemes["Purple"].accent}, 0.17):Play()
        wait(0.10)
        tween(btn, {BackgroundColor3=Color3.fromRGB(40,0,70)}, 0.18):Play()
        for _,p in ipairs(contentScroller:GetChildren()) do
            p.Visible = false
        end
        page.Visible = true
        updateCanvas(holder)
        page.Size = UDim2.new(1, -10, 0, holder.AbsoluteSize.Y + 10)
        contentScroller.CanvasSize = UDim2.new(0,0,0, page.AbsoluteSize.Y + 20)
        currentTab = page
    end
    btn.MouseButton1Click:Connect(function() setActive() end)
    Tabs[idx] = {name = name, button = btn, page = page, holder = holder}
    if #Tabs==1 then setActive() end
    tabbar.CanvasSize = UDim2.new(0,0,0, (#Tabs)*50 + 16)
    animateAppear(btn)
    return Tabs[idx]
end

-- LABEL
local function createLabel(holder, text)
    local frame = Instance.new("Frame", holder)
    frame.Size = UDim2.new(1,0,0,34)
    frame.BackgroundTransparency = 1
    local tl = Instance.new("TextLabel", frame)
    tl.Size = UDim2.new(1,0,1,0)
    tl.BackgroundTransparency = 1
    tl.Text = text
    tl.Font = Enum.Font.GothamBold
    tl.TextColor3 = Color3.fromRGB(245,245,255)
    tl.TextSize = 15
    tl.TextXAlignment = Enum.TextXAlignment.Left
    animateAppear(frame)
    return frame
end

-- BUTTON
local function createButton(holder, text, callback)
    local frame = Instance.new("Frame", holder)
    frame.Size = UDim2.new(1,0,0,38)
    frame.BackgroundTransparency = 1
    local btn = Instance.new("TextButton", frame)
    btn.Size = UDim2.new(1,0,1,0)
    btn.BackgroundColor3 = Color3.fromRGB(100,30,140)
    btn.Text = text
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 15
    btn.TextColor3 = Color3.fromRGB(255,255,255)
    btn.AutoButtonColor = false
    local c = Instance.new("UICorner", btn)
    c.CornerRadius = UDim.new(0,8)
    local stroke = Instance.new("UIStroke", btn)
    stroke.Color = Color3.fromRGB(200,120,255)
    stroke.Thickness = 1
    btn.ClipsDescendants = true
    btn.MouseEnter:Connect(function() 
        tween(btn, {BackgroundColor3 = Color3.fromRGB(130,40,180)}, 0.14):Play() 
    end)
    btn.MouseLeave:Connect(function() 
        tween(btn, {BackgroundColor3 = Color3.fromRGB(100,30,140)}, 0.14):Play()
    end)
    btn.MouseButton1Click:Connect(function()
        local ripple = Instance.new("Frame", btn)
        ripple.Size = UDim2.new(0,0,0,0)
        ripple.AnchorPoint = Vector2.new(0.5,0.5)
        ripple.Position = UDim2.new(0.5,0,0.5,0)
        ripple.BackgroundTransparency = 0.4
        ripple.BackgroundColor3 = Color3.fromRGB(210,115,255)
        ripple.ZIndex = btn.ZIndex+2
        local rc = Instance.new("UICorner", ripple)
        rc.CornerRadius = UDim.new(1,0)
        tween(ripple, {Size = UDim2.new(2,0,2,0), BackgroundTransparency = 1}, 0.4):Play()
        delay(0.42, function() ripple:Destroy() end)
        tween(btn, {Size = UDim2.new(1, -6, 1, -6)}, 0.07):Play()
        wait(0.07)
        tween(btn, {Size = UDim2.new(1,0,1,0)}, 0.07):Play()
        if callback then pcall(callback) end
    end)
    animateAppear(frame)
    return btn
end

-- TOGGLE
local function createToggle(holder, text, default, callback)
    local frame = Instance.new("Frame", holder)
    frame.Size = UDim2.new(1,0,0,35)
    frame.BackgroundTransparency = 1
    local label = Instance.new("TextLabel", frame)
    label.Size = UDim2.new(0.7,0,1,0)
    label.Position = UDim2.new(0,6,0,0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.Font = Enum.Font.Gotham
    label.TextSize = 14
    label.TextColor3 = Color3.fromRGB(230,230,255)
    label.TextXAlignment = Enum.TextXAlignment.Left
    local togg = Instance.new("ImageButton", frame)
    togg.Size = UDim2.new(0,44,0,25)
    togg.Position = UDim2.new(0.75,0,0.14,0)
    togg.BackgroundTransparency = 0
    togg.BackgroundColor3 = Color3.fromRGB(70,30,120)
    local tcorner = Instance.new("UICorner", togg)
    tcorner.CornerRadius = UDim.new(0,12)
    local dot = Instance.new("Frame", togg)
    dot.Size = UDim2.new(0,19,0,19)
    dot.Position = UDim2.new(default and 0.82 or 0.04,0,0.12,0)
    dot.BackgroundColor3 = default and Color3.fromRGB(120,230,120) or Color3.fromRGB(210,210,210)
    local dcorner = Instance.new("UICorner", dot)
    dcorner.CornerRadius = UDim.new(0,12)
    local enabled = default or false
    togg.MouseButton1Click:Connect(function()
        enabled = not enabled
        if enabled then
            tween(dot, {Position = UDim2.new(0.82,0,0.12,0)}, 0.13):Play()
            tween(dot, {BackgroundColor3 = Color3.fromRGB(120,230,120)}, 0.13):Play()
        else
            tween(dot, {Position = UDim2.new(0.04,0,0.12,0)}, 0.13):Play()
            tween(dot, {BackgroundColor3 = Color3.fromRGB(210,210,210)}, 0.13):Play()
        end
        if callback then pcall(callback, enabled) end
    end)
    animateAppear(frame)
    return frame, function() return enabled end
end

-- SLIDER
local function createSlider(holder, text, min, max, default, callback)
    local frame = Instance.new("Frame", holder)
    frame.Size = UDim2.new(1,0,0,56)
    frame.BackgroundTransparency = 1
    local label = Instance.new("TextLabel", frame)
    label.Size = UDim2.new(1,0,0,17)
    label.Position = UDim2.new(0,6,0,0)
    label.BackgroundTransparency = 1
    label.Text = text.." : "..tostring(default)
    label.Font = Enum.Font.Gotham
    label.TextSize = 14
    label.TextColor3 = Color3.fromRGB(230,230,255)
    label.TextXAlignment = Enum.TextXAlignment.Left
    local barBg = Instance.new("Frame", frame)
    barBg.Size = UDim2.new(1,-10,0,14)
    barBg.Position = UDim2.new(0,6,0,28)
    barBg.BackgroundColor3 = Color3.fromRGB(70,30,120)
    local barCorner = Instance.new("UICorner", barBg)
    barCorner.CornerRadius = UDim.new(0,7)
    local fill = Instance.new("Frame", barBg)
    fill.Size = UDim2.new((default-min)/(max-min),0,1,0)
    fill.BackgroundColor3 = allThemes["Purple"].accent
    local fillCorner = Instance.new("UICorner", fill)
    fillCorner.CornerRadius = UDim.new(0,7)
    local dragging = false
    barBg.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
        end
    end)
    barBg.InputEnded:Connect(function(input)
        if input.UserInputState == Enum.UserInputState.End then dragging = false end
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
    animateAppear(frame)
    return frame
end

-- DROPDOWN
local function createDropdown(holder, text, options, callback)
    local frame = Instance.new("Frame", holder)
    frame.Size = UDim2.new(1,0,0,36)
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
    box.Size = UDim2.new(0.36, -5, 0.9, 0)
    box.Position = UDim2.new(0.62,6,0.05,0)
    box.Text = tostring(options[1] or "None")
    box.Font = Enum.Font.Gotham
    box.TextSize = 14
    box.BackgroundColor3 = Color3.fromRGB(70,30,120)
    box.TextColor3 = Color3.fromRGB(255,255,255)
    box.AutoButtonColor = false
    local boxCorner = Instance.new("UICorner", box)
    boxCorner.CornerRadius = UDim.new(0,6)
    local panel = Instance.new("Frame", frame)
    panel.Size = UDim2.new(0, box.AbsoluteSize.X, 0, 0)
    panel.Position = UDim2.new(0.62,6,0, 40)
    panel.BackgroundColor3 = Color3.fromRGB(50,10,80)
    panel.Visible = false
    local panelCorner = Instance.new("UICorner", panel)
    panelCorner.CornerRadius = UDim.new(0,6)
    local listLayout = Instance.new("UIListLayout", panel)
    listLayout.SortOrder = Enum.SortOrder.LayoutOrder
    listLayout.Padding = UDim.new(0,3)
    local function rebuildPanel()
        for _,v in ipairs(panel:GetChildren()) do if v:IsA("TextButton") then v:Destroy() end end
        local totalHeight = 5
        for i,opt in ipairs(options) do
            local optBtn = Instance.new("TextButton", panel)
            optBtn.Size = UDim2.new(1, -4, 0, 30)
            optBtn.Position = UDim2.new(0,2,0, totalHeight-2)
            optBtn.BackgroundColor3 = Color3.fromRGB(85,40,155)
            optBtn.Text = tostring(opt)
            optBtn.Font = Enum.Font.Gotham
            optBtn.TextSize = 14
            optBtn.TextColor3 = Color3.fromRGB(255,255,255)
            local oc = Instance.new("UICorner", optBtn)
            oc.CornerRadius = UDim.new(0,5)
            optBtn.MouseButton1Click:Connect(function()
                box.Text = tostring(opt)
                panel.Visible = false
                tween(panel, {Size = UDim2.new(0, box.AbsoluteSize.X, 0, 0)}, 0.12):Play()
                if callback then pcall(callback, opt) end
            end)
            totalHeight = totalHeight + 33
        end
        panel.Size = UDim2.new(0, box.AbsoluteSize.X, 0, totalHeight)
    end
    box.MouseButton1Click:Connect(function()
        panel.Visible = not panel.Visible
        if panel.Visible then
            rebuildPanel()
            tween(panel, {Size = UDim2.new(0, box.AbsoluteSize.X, 0, math.min(200, (#options)*34+7))}, 0.13):Play()
        else
            tween(panel, {Size = UDim2.new(0, box.AbsoluteSize.X, 0, 0)}, 0.09):Play()
        end
    end)
    animateAppear(frame)
    return frame
end

-- TEXTBOX
local function createTextbox(holder, placeholder, callback)
    local frame = Instance.new("Frame", holder)
    frame.Size = UDim2.new(1,0,0,40)
    frame.BackgroundTransparency = 1
    local box = Instance.new("TextBox", frame)
    box.Size = UDim2.new(1,-10,1,0)
    box.Position = UDim2.new(0,5,0,0)
    box.PlaceholderText = placeholder or ""
    box.Text = ""
    box.ClearTextOnFocus = false
    box.Font = Enum.Font.Gotham
    box.TextSize = 14
    box.TextColor3 = Color3.fromRGB(255,255,255)
    box.BackgroundColor3 = Color3.fromRGB(60,20,100)
    box.TextXAlignment = Enum.TextXAlignment.Left
    local bc = Instance.new("UICorner", box)
    bc.CornerRadius = UDim.new(0,7)
    box.FocusLost:Connect(function(enter)
        if callback then pcall(callback, box.Text) end
    end)
    animateAppear(frame)
    return box
end

-- DANH SÁCH LIST ĐƠN GIẢN
local function createList(holder, items)
    local frame = Instance.new("Frame", holder)
    frame.Size = UDim2.new(1,0,0,140)
    frame.BackgroundTransparency = 1
    local scroll = Instance.new("ScrollingFrame", frame)
    scroll.Size = UDim2.new(1,0,1,0)
    scroll.BackgroundTransparency = 1
    scroll.CanvasSize = UDim2.new(0,0,0,0)
    scroll.ScrollBarThickness = 6
    local layout = Instance.new("UIListLayout", scroll)
    layout.Padding = UDim.new(0,5)
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    local padding = Instance.new("UIPadding", scroll)
    padding.PaddingTop = UDim.new(0,5)
    padding.PaddingLeft = UDim.new(0,5)
    padding.PaddingRight = UDim.new(0,5)
    padding.PaddingBottom = UDim.new(0,5)
    local function rebuild()
        for _,c in ipairs(scroll:GetChildren()) do
            if c:IsA("Frame") and c.Name ~= "UIListLayout" then c:Destroy() end
        end
        local total = 5
        for i,item in ipairs(items) do
            local it = Instance.new("Frame", scroll)
            it.Size = UDim2.new(1, -8, 0, 31)
            it.Position = UDim2.new(0,5,0, total)
            it.BackgroundColor3 = Color3.fromRGB(60,20,120)
            it.Name = "Item_"..i
            local c = Instance.new("UICorner", it)
            c.CornerRadius = UDim.new(0,7)
            local label = Instance.new("TextLabel", it)
            label.Size = UDim2.new(0.85,0,1,0)
            label.Position = UDim2.new(0,7,0,0)
            label.BackgroundTransparency = 1
            label.Text = tostring(item)
            label.Font = Enum.Font.Gotham
            label.TextSize = 14
            label.TextColor3 = Color3.fromRGB(240,240,255)
            total = total + 34
        end
        scroll.CanvasSize = UDim2.new(0,0,0, total)
    end
    rebuild()
    animateAppear(frame)
    return frame
end

--------------------- DEMO UI/CONTENT ĐẦY ĐỦ ----------------------

-- Tab HOME
local tHome = createTab("🏠 Home")
local h = tHome.holder
createLabel(h, "PHUCMAX UI - All in one, full animation!")
local btn1 = createButton(h, "Bấm để thử hiệu ứng thông báo", function()
    local notif = Instance.new("TextLabel", gui)
    notif.Size = UDim2.new(0,200,0,40)
    notif.Position = UDim2.new(0.5, -100, 0.09, 0)
    notif.BackgroundColor3 = Color3.fromRGB(50,0,88)
    notif.TextColor3 = Color3.fromRGB(255,255,255)
    notif.Text = "Đã bấm!"
    notif.Font = Enum.Font.GothamBold
    notif.TextSize = 16
    notif.AnchorPoint = Vector2.new(0.5,0)
    notif.BackgroundTransparency = 0.1
    notif.ZIndex = 200
    local nc = Instance.new("UICorner", notif)
    nc.CornerRadius = UDim.new(0,7)
    tween(notif, {Position = UDim2.new(0.5, -100, 0.07, 0), BackgroundTransparency = 0}, 0.16):Play()
    wait(1)
    tween(notif, {Position = UDim2.new(0.5, -100, 0.01, 0), BackgroundTransparency = 1}, 0.16):Play()
    delay(0.35, function() notif:Destroy() end)
end)
addTooltip(btn1, "Thông báo demo animation!")
local tog, getTog = createToggle(h, "AUTO MODE", false, function(state)
    createLabel(h, state and "Bật auto rồi!" or "Đã tắt auto."):TweenPosition(UDim2.new(0,0,0,0),'Out','Quad',0.33,true)
end)
createSlider(h, "Speed", 0, 100, 25, function(val) end)
createDropdown(h, "Chọn gì nè:", {"A", "B", "C"}, function(opt) 
    shakeFrame(main)
end)

-- Tab INPUT
local tInput = createTab("✍️ Nhập Liệu")
local inp = tInput.holder
createLabel(inp, "Tất cả loại nhập liệu")
createTextbox(inp, "Nhập text...", function(txt) end)
createList(inp, {"Item 1", "Item 2", "Item 3", "Item 4","Item Dài Demo"})

-- Tab BUTTONS
local tBtn = createTab("🔘 All Button")
local bh = tBtn.holder
for i=1,5 do
    local b = createButton(bh, "Button "..i, function() 
        shakeFrame(main)
    end)
    addTooltip(b, "Button số "..i)
end

-- Tab TOGGLE
local ttg = createTab("🎚️ Toggle/Slider")
local tg = ttg.holder
createToggle(tg, "Demo Toggle", true, function(s) end)
createSlider(tg, "Volume", 0, 1, 0.5, function(v) end)
createDropdown(tg, "Theme", {"Purple","Pink","Dark","Green","Light"}, function(t)
    if allThemes[t] then
        tween(main, {BackgroundColor3=allThemes[t].main}, 0.21):Play()
        tween(mainStroke, {Color=allThemes[t].accent}, 0.18):Play()
    end
end)

-- Tab MUSIC
local tMusic = createTab("🎵 Music")
local mh = tMusic.holder
createLabel(mh, "Chọn bài chơi thử trên UI (Roblox SoundId)")
local musicList = {"1843554123", "169073988", "142376088"}
for _,id in ipairs(musicList) do
    createButton(mh, "Play ["..id.."]", function()
        if workspace:FindFirstChild("PHUCMAX_MUSIC") then workspace.PHUCMAX_MUSIC:Destroy() end
        local s = Instance.new("Sound", workspace)
        s.Name = "PHUCMAX_MUSIC"
        s.SoundId = "rbxassetid://"..id
        s.Volume = 1
        s:Play()
    end)
end
createButton(mh, "Stop Music", function()
    if workspace:FindFirstChild("PHUCMAX_MUSIC") then workspace.PHUCMAX_MUSIC:Destroy() end
end)

-- Tab INFO
local tInfo = createTab("ℹ️ Info")
local ib = tInfo.holder
createLabel(ib,"Script này được tạo bởi PHUCMAX đẹp trai - bản full")
createLabel(ib,"Đủ type button, toggle, slider, dropdown, textbox, list,...")
createLabel(ib,"Test/Ý tưởng liên hệ PHUCMAX")

-- Sau khi add, sửa lại height các page
for _,tab in ipairs(Tabs) do
    RunService.Heartbeat:Wait()
    tab.page.Size = UDim2.new(1, -10, 0, tab.holder.AbsoluteSize.Y + 10)
end
RunService.Heartbeat:Wait()
local totalHeight = 0
for _,p in ipairs(contentScroller:GetChildren()) do
    if p:IsA("Frame") then totalHeight = totalHeight + p.AbsoluteSize.Y + 7 end
end
contentScroller.CanvasSize = UDim2.new(0,0,0, totalHeight + 7)

print("PHUCMAX UI (ALL-IN, HOÀN CHỈNH) loaded!")