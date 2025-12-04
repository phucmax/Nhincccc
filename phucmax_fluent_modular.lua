--== PHUCMAX FLUENT UI - MODULAR, FULL FEATURE, IMAGE BACKGROUND ==--

--------------------------- CONFIG ---------------------------
local BG_IMG_ID     = "rbxassetid://87746599009295" -- ID ảnh nền GUI
local BTN_BG_ID     = "rbxassetid://87746599009295" -- ID ảnh nền nút bật/tắt
local TITLE         = "PHUCMAX Fluent UI"
local SUBTITLE      = "by PHUCMAX đẹp trai"

local FLUENT_THEMES = {
    ["Default"]={main=Color3.fromRGB(30,34,44), accent=Color3.fromRGB(82,123,255), text=Color3.fromRGB(230,230,238)},
    ["Purple"]={main=Color3.fromRGB(50,42,67), accent=Color3.fromRGB(196,129,255), text=Color3.fromRGB(238,231,255)},
    ["Teal"]={main=Color3.fromRGB(30,52,52), accent=Color3.fromRGB(80,255,205), text=Color3.fromRGB(222,255,241)},
    ["Light"]={main=Color3.fromRGB(220,230,244), accent=Color3.fromRGB(82,123,255), text=Color3.fromRGB(44,44,48)},
    ["Pink"]={main=Color3.fromRGB(74,35,56), accent=Color3.fromRGB(255,140,210), text=Color3.fromRGB(255,235,245)},
}
local CUR_THEME = "Default"
-------------------------------------------------------------

--------------------------- UTILITIES --------------------------
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local lp = Players.LocalPlayer
local playerGui = lp:WaitForChild("PlayerGui")

if playerGui:FindFirstChild("FluentUI") then playerGui.FluentUI:Destroy() end

local function tween(inst, props, time, ...)
    local info = TweenInfo.new(time or 0.23, ...)
    return TweenService:Create(inst, info, props)
end

local function rippleEffect(parent, accent)
    local ripple = Instance.new("Frame", parent)
    ripple.BackgroundColor3 = accent or FLUENT_THEMES[CUR_THEME].accent
    ripple.BackgroundTransparency = 0.5
    ripple.AnchorPoint = Vector2.new(0.5,0.5)
    ripple.Position = UDim2.fromScale(0.5,0.5)
    ripple.Size = UDim2.fromOffset(0,0)
    ripple.ZIndex = parent.ZIndex+1
    local corner = Instance.new("UICorner", ripple)
    corner.CornerRadius = UDim.new(1,0)
    tween(ripple,{Size=UDim2.fromScale(2,2),BackgroundTransparency=1},0.35,Enum.EasingStyle.Sine):Play()
    game.Debris:AddItem(ripple,0.36)
end

local function dragify(frame, area)
    area = area or frame
    local drag, input, startPoint, startPos
    area.InputBegan:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1 then
            drag = true
            startPoint = inp.Position
            startPos = frame.Position
            inp.Changed:Connect(function() if inp.UserInputState==Enum.UserInputState.End then drag=false end end)
        end
    end)
    UIS.InputChanged:Connect(function(inp)
        if drag and inp.UserInputType==Enum.UserInputType.MouseMovement then
            local d = inp.Position - startPoint
            frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset+d.X, startPos.Y.Scale, startPos.Y.Offset+d.Y)
        end
    end)
end

--------------------------- UI LAYOUT: MAIN + BG + TOGGLE BTN --------------------------

local gui = Instance.new("ScreenGui")
gui.Name = "FluentUI"
gui.IgnoreGuiInset = true
gui.ResetOnSpawn = false
gui.Parent = playerGui

-- Nút bật/tắt hình tròn bên trái
local toggleBtn = Instance.new("ImageButton", gui)
toggleBtn.Name = "MenuToggle"
toggleBtn.Size = UDim2.fromOffset(62,62)
toggleBtn.Position = UDim2.new(0.01,0,0.47,0)
toggleBtn.BackgroundColor3 = Color3.fromRGB(255,255,255)
toggleBtn.BackgroundTransparency = 0.3
toggleBtn.Image = BTN_BG_ID
toggleBtn.ScaleType = Enum.ScaleType.Crop
toggleBtn.ZIndex = 50
toggleBtn.AutoButtonColor = false
local circleCorner = Instance.new("UICorner", toggleBtn)
circleCorner.CornerRadius = UDim.new(1,0)
dragify(toggleBtn)

local main = Instance.new("Frame", gui)
main.Name = "Main"
main.Size = UDim2.fromOffset(520,360)
main.Position = UDim2.new(0.18,0,0.18,0)
main.BackgroundColor3 = FLUENT_THEMES[CUR_THEME].main
main.BorderSizePixel = 0
main.ClipsDescendants = true
main.ZIndex = 2
local mainCorner = Instance.new("UICorner", main)
mainCorner.CornerRadius = UDim.new(0,18)
dragify(main)

local bg = Instance.new("ImageLabel", main)
bg.Name = "Background"
bg.Size = UDim2.new(1,0,1,0)
bg.Position = UDim2.new(0,0,0,0)
bg.BackgroundTransparency = 1
bg.Image = BG_IMG_ID
bg.ScaleType = Enum.ScaleType.Crop
bg.ZIndex = 1

local header = Instance.new("Frame", main)
header.Size = UDim2.new(1,0,0,54)
header.BackgroundTransparency = 1
local title = Instance.new("TextLabel", header)
title.Text = TITLE
title.Font = Enum.Font.GothamBold
title.TextSize = 18
title.Size = UDim2.new(0.62,0,1,0)
title.Position = UDim2.new(0.045,0,0,0)
title.BackgroundTransparency = 1
title.TextColor3 = FLUENT_THEMES[CUR_THEME].accent
local sub = Instance.new("TextLabel", header)
sub.Text = SUBTITLE
sub.Font = Enum.Font.Gotham
sub.TextSize = 13
sub.Size = UDim2.new(0.5,0,0.5,0)
sub.Position = UDim2.new(0.045,0,0.6,0)
sub.BackgroundTransparency = 1
sub.TextColor3 = FLUENT_THEMES[CUR_THEME].text

local closeBtn = Instance.new("TextButton", header)
closeBtn.Size = UDim2.fromOffset(34,30)
closeBtn.Position = UDim2.new(0.93,0,0.14,0)
closeBtn.BackgroundColor3 = FLUENT_THEMES[CUR_THEME].accent
closeBtn.Text = "×"
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 23
closeBtn.TextColor3 = Color3.fromRGB(255,255,255)
local xCorner = Instance.new("UICorner", closeBtn)
xCorner.CornerRadius = UDim.new(0,8)

local tabbar = Instance.new("ScrollingFrame", main)
tabbar.Name = "TabBar"
tabbar.Size = UDim2.new(0,116,1,-54)
tabbar.Position = UDim2.new(0,0,0,54)
tabbar.CanvasSize = UDim2.new(0,0,0,0)
tabbar.ScrollBarThickness = 6
tabbar.BackgroundColor3 = FLUENT_THEMES[CUR_THEME].accent:lerp(FLUENT_THEMES[CUR_THEME].main,0.80)
tabbar.BorderSizePixel = 0
tabbar.ScrollingEnabled = true
tabbar.AutomaticCanvasSize = Enum.AutomaticSize.Y
local tabbarCorner = Instance.new("UICorner", tabbar)
tabbarCorner.CornerRadius = UDim.new(0,11)

local content = Instance.new("Frame", main)
content.Name = "Content"
content.Size = UDim2.new(1,-116,1,-54)
content.Position = UDim2.new(0,116,0,54)
content.BackgroundColor3 = FLUENT_THEMES[CUR_THEME].main:lerp(FLUENT_THEMES[CUR_THEME].accent,0.1)
local contentCorner = Instance.new("UICorner", content)
contentCorner.CornerRadius = UDim.new(0,12)
local contentScroll = Instance.new("ScrollingFrame", content)
contentScroll.Name = "ContentScroll"
contentScroll.Size = UDim2.new(1,-8,1,-8)
contentScroll.Position = UDim2.new(0,4,0,4)
contentScroll.BackgroundTransparency = 1
contentScroll.CanvasSize = UDim2.new(0,0,0,0)
contentScroll.ScrollBarThickness = 7
contentScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y

local notifHolder = Instance.new("Folder", gui)
--------------------------- TAB SYSTEM --------------------------
local Tabs, currentTab = {}, nil
local function createTab(name)
    local idx = #Tabs+1
    local btn = Instance.new("TextButton", tabbar)
    btn.Name = "Tab_" .. idx
    btn.Size = UDim2.new(1,-14,0,40)
    btn.Position = UDim2.new(0,8,0,(idx-1)*44+8)
    btn.BackgroundColor3 = FLUENT_THEMES[CUR_THEME].main:lerp(FLUENT_THEMES[CUR_THEME].accent,0.07)
    btn.Text = name
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 14
    btn.TextColor3 = FLUENT_THEMES[CUR_THEME].text
    btn.AutoButtonColor = false
    local corner = Instance.new("UICorner", btn) corner.CornerRadius = UDim.new(0,10)
    local hover = Instance.new("Frame", btn)
    hover.Size = UDim2.new(0,6,1,0)
    hover.Position = UDim2.new(0,0,0,0)
    hover.BackgroundColor3 = FLUENT_THEMES[CUR_THEME].accent
    hover.Visible = false
    hover.Name = "Hover"

    -- Page
    local page = Instance.new("Frame", contentScroll)
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
    layout.Padding = UDim.new(0,9)
    local padding = Instance.new("UIPadding", holder)
    padding.PaddingTop = UDim.new(0,8)
    padding.PaddingLeft = UDim.new(0,8)
    padding.PaddingRight = UDim.new(0,8)
    padding.PaddingBottom = UDim.new(0,8)

    local function setActive()
        for _,b in ipairs(tabbar:GetChildren()) do
            if b:IsA("TextButton") then
                b.BackgroundColor3 = FLUENT_THEMES[CUR_THEME].main:lerp(FLUENT_THEMES[CUR_THEME].accent,0.07)
                b.TextColor3 = FLUENT_THEMES[CUR_THEME].text
                if b:FindFirstChild("Hover") then b.Hover.Visible = false end
            end
        end
        btn.BackgroundColor3 = FLUENT_THEMES[CUR_THEME].accent:lerp(FLUENT_THEMES[CUR_THEME].main, 0.3)
        btn.TextColor3 = Color3.fromRGB(255,255,255)
        hover.Visible = true
        tween(btn,{BackgroundColor3=FLUENT_THEMES[CUR_THEME].accent},0.14,Enum.EasingStyle.Quad):Play()
        for _,p in ipairs(contentScroll:GetChildren()) do
            p.Visible = false
        end
        page.Visible = true
        RunService.Heartbeat:Wait()
        page.Size = UDim2.new(1,-10,0,holder.AbsoluteSize.Y+12)
        contentScroll.CanvasSize = UDim2.new(0,0,0,page.AbsoluteSize.Y+18)
        currentTab = page
    end
    btn.MouseButton1Click:Connect(function()
        rippleEffect(btn,FLUENT_THEMES[CUR_THEME].accent)
        setActive()
    end)
    Tabs[idx] = {name = name, button = btn, page = page, holder = holder}
    if #Tabs==1 then setActive() end
    tabbar.CanvasSize = UDim2.new(0,0,0,(#Tabs)*44+16)
    return Tabs[idx]
end

------------------ UI COMPONENTS ------------------
local function createLabel(holder, text)
    local lbl = Instance.new("TextLabel", holder)
    lbl.Size = UDim2.new(1,0,0,34)
    lbl.BackgroundTransparency = 1
    lbl.Text = text
    lbl.Font = Enum.Font.GothamBold
    lbl.TextColor3 = FLUENT_THEMES[CUR_THEME].text
    lbl.TextSize = 16
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    return lbl
end

local function createButton(holder, text, cb)
    local btn = Instance.new("TextButton", holder)
    btn.Size = UDim2.new(1,0,0,38)
    btn.BackgroundColor3 = FLUENT_THEMES[CUR_THEME].accent
    btn.Text = text
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 15
    btn.TextColor3 = Color3.fromRGB(255,255,255)
    btn.AutoButtonColor = false
    local c = Instance.new("UICorner", btn)
    c.CornerRadius = UDim.new(0,10)
    local stroke = Instance.new("UIStroke", btn)
    stroke.Color = FLUENT_THEMES[CUR_THEME].main
    stroke.Thickness = 1
    btn.MouseEnter:Connect(function()
        tween(btn, {BackgroundColor3=FLUENT_THEMES[CUR_THEME].accent:lerp(FLUENT_THEMES[CUR_THEME].main, .18)}, 0.12):Play()
    end)
    btn.MouseLeave:Connect(function()
        tween(btn, {BackgroundColor3=FLUENT_THEMES[CUR_THEME].accent}, 0.12):Play()
    end)
    btn.MouseButton1Click:Connect(function()
        rippleEffect(btn,FLUENT_THEMES[CUR_THEME].main)
        tween(btn, {Size=UDim2.new(1,-7,0,33)},0.08):Play()
        wait(0.085)
        tween(btn, {Size=UDim2.new(1,0,0,38)},0.08):Play()
        if cb then pcall(cb) end
    end)
    return btn
end

local function createToggle(holder, text, init, cb)
    local frame = Instance.new("Frame", holder)
    frame.Size = UDim2.new(1,0,0,34)
    frame.BackgroundTransparency = 1
    local label = Instance.new("TextLabel", frame)
    label.Size = UDim2.new(0.7,0,1,0)
    label.Position = UDim2.new(0.04,0,0,0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = FLUENT_THEMES[CUR_THEME].text
    label.Font = Enum.Font.Gotham
    label.TextSize = 14
    local togg = Instance.new("ImageButton", frame)
    togg.Size = UDim2.fromOffset(46,22)
    togg.Position = UDim2.new(0.77,0,0.18,0)
    togg.BackgroundColor3 = FLUENT_THEMES[CUR_THEME].accent
    local tCorner = Instance.new("UICorner", togg) tCorner.CornerRadius = UDim.new(0,12)
    local dot = Instance.new("Frame", togg)
    dot.Size = UDim2.fromOffset(18,18)
    dot.Position = UDim2.new(init and 0.65 or 0.05,0,0.1,0)
    dot.BackgroundColor3 = init and Color3.fromRGB(120,230,152) or FLUENT_THEMES[CUR_THEME].main
    local dCorner = Instance.new("UICorner", dot) dCorner.CornerRadius = UDim.new(1,0)
    local state = init or false
    togg.MouseButton1Click:Connect(function()
        rippleEffect(togg)
        state = not state
        if state then
            tween(dot, {Position=UDim2.new(0.65,0,0.1,0), BackgroundColor3=Color3.fromRGB(120,230,152)}, 0.16):Play()
        else
            tween(dot, {Position=UDim2.new(0.05,0,0.1,0), BackgroundColor3=FLUENT_THEMES[CUR_THEME].main}, 0.16):Play()
        end
        if cb then pcall(cb, state) end
    end)
    return frame, function() return state end
end

local function createSlider(holder, text, min, max, def, cb)
    local frame = Instance.new("Frame", holder)
    frame.Size = UDim2.new(1,0,0,44)
    frame.BackgroundTransparency = 1
    local title = Instance.new("TextLabel", frame)
    title.Size = UDim2.new(1,0,0,17)
    title.Position = UDim2.new(0,0,0,0)
    title.BackgroundTransparency = 1
    title.Text = text..": "..tostring(def)
    title.TextColor3 = FLUENT_THEMES[CUR_THEME].text
    title.Font = Enum.Font.Gotham
    title.TextSize = 13
    title.TextXAlignment = Enum.TextXAlignment.Left
    local bar = Instance.new("Frame", frame)
    bar.Size = UDim2.new(1,0,0,14)
    bar.Position = UDim2.new(0,0,0,26)
    bar.BackgroundColor3 = FLUENT_THEMES[CUR_THEME].accent:lerp(FLUENT_THEMES[CUR_THEME].main,0.65)
    local bcorner = Instance.new("UICorner", bar) bcorner.CornerRadius = UDim.new(1,0)
    local fill = Instance.new("Frame", bar)
    fill.Size = UDim2.new((def-min)/(max-min),0,1,0)
    fill.BackgroundColor3 = FLUENT_THEMES[CUR_THEME].accent
    local fcorner = Instance.new("UICorner", fill) fcorner.CornerRadius = UDim.new(1,0)
    local dragging = false
    bar.InputBegan:Connect(function(input)
        if input.UserInputType==Enum.UserInputType.MouseButton1 then dragging=true end
    end)
    bar.InputEnded:Connect(function(input)
        if input.UserInputState==Enum.UserInputState.End then dragging=false end
    end)
    UIS.InputChanged:Connect(function(input)
        if dragging and input.UserInputType==Enum.UserInputType.MouseMovement then
            local rel = math.clamp((input.Position.X-bar.AbsolutePosition.X)/bar.AbsoluteSize.X,0,1)
            fill.Size = UDim2.new(rel,0,1,0)
            local v = min+rel*(max-min)
            title.Text = text..": "..string.format("%.2f",v)
            if cb then pcall(cb, v) end
        end
    end)
    return frame
end

local function createDropdown(holder, text, options, cb)
    local frame = Instance.new("Frame", holder)
    frame.Size = UDim2.new(1,0,0,38)
    frame.BackgroundTransparency = 1
    local label = Instance.new("TextLabel", frame)
    label.Size = UDim2.new(0.6,0,1,0)
    label.Position = UDim2.new(0,0,0,0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.Font = Enum.Font.Gotham
    label.TextSize = 14
    label.TextColor3 = FLUENT_THEMES[CUR_THEME].text
    label.TextXAlignment = Enum.TextXAlignment.Left
    local box = Instance.new("TextButton", frame)
    box.Size = UDim2.new(0.36,0,0.85,0)
    box.Position = UDim2.new(0.62,0,0.05,0)
    box.Text = tostring(options[1] or "None")
    box.Font = Enum.Font.Gotham
    box.TextSize = 14
    box.BackgroundColor3 = FLUENT_THEMES[CUR_THEME].accent
    box.TextColor3 = Color3.fromRGB(255,255,255)
    box.AutoButtonColor = false
    local boxCorner = Instance.new("UICorner", box) boxCorner.CornerRadius = UDim.new(0,8)

    local panel = Instance.new("Frame", frame)
    panel.Size = UDim2.new(0, box.AbsoluteSize.X, 0, 0)
    panel.Position = UDim2.new(0.62,0,0,40)
    panel.BackgroundColor3 = FLUENT_THEMES[CUR_THEME].main
    panel.Visible = false
    local panelCorner = Instance.new("UICorner", panel) panelCorner.CornerRadius = UDim.new(0,8)
    local listLayout = Instance.new("UIListLayout", panel)
    listLayout.SortOrder = Enum.SortOrder.LayoutOrder
    listLayout.Padding = UDim.new(0,2)
    local function refreshPanel()
        for _,v in ipairs(panel:GetChildren()) do if v:IsA("TextButton") then v:Destroy() end end
        local tot = 7
        for i,opt in ipairs(options) do
            local optBtn = Instance.new("TextButton", panel)
            optBtn.Size = UDim2.new(1,-4,0,28)
            optBtn.Position = UDim2.new(0,2,0,tot-2)
            optBtn.BackgroundColor3 = FLUENT_THEMES[CUR_THEME].accent
            optBtn.Text = tostring(opt)
            optBtn.Font = Enum.Font.Gotham
            optBtn.TextSize = 14
            optBtn.TextColor3 = FLUENT_THEMES[CUR_THEME].main
            local oc = Instance.new("UICorner", optBtn) oc.CornerRadius = UDim.new(0,7)
            optBtn.MouseButton1Click:Connect(function()
                rippleEffect(optBtn)
                box.Text = tostring(opt)
                panel.Visible = false
                tween(panel, {Size=UDim2.new(0, box.AbsoluteSize.X, 0, 0)}, .11):Play()
                if cb then pcall(cb, opt) end
            end)
            tot = tot+30
        end
        panel.Size = UDim2.new(0, box.AbsoluteSize.X, 0, tot)
    end
    box.MouseButton1Click:Connect(function()
        rippleEffect(box)
        panel.Visible = not panel.Visible
        if panel.Visible then
            refreshPanel()
            tween(panel, {Size=UDim2.new(0, box.AbsoluteSize.X, 0, math.min(160,(#options)*30+8))}, .13):Play()
        else
            tween(panel, {Size=UDim2.new(0, box.AbsoluteSize.X, 0, 0)}, .09):Play()
        end
    end)
    return frame
end

local function createTextbox(holder, placeholder, cb)
    local box = Instance.new("TextBox", holder)
    box.Size = UDim2.new(1,0,0,34)
    box.BackgroundColor3 = FLUENT_THEMES[CUR_THEME].accent:lerp(FLUENT_THEMES[CUR_THEME].main,0.72)
    box.PlaceholderText = placeholder or ""
    box.Text = ""
    box.ClearTextOnFocus = false
    box.Font = Enum.Font.Gotham
    box.TextSize = 14
    box.TextColor3 = FLUENT_THEMES[CUR_THEME].text
    local bc = Instance.new("UICorner", box) bc.CornerRadius = UDim.new(0,9)
    box.FocusLost:Connect(function()
        if cb then pcall(cb, box.Text) end
    end)
    return box
end

local function createList(holder, items)
    local frame = Instance.new("Frame", holder)
    frame.Size = UDim2.new(1,0,0,132)
    frame.BackgroundTransparency = 1
    local scroll = Instance.new("ScrollingFrame", frame)
    scroll.Size = UDim2.new(1,0,1,0)
    scroll.BackgroundTransparency = 1
    scroll.CanvasSize = UDim2.new(0,0,0,0)
    scroll.ScrollBarThickness = 6
    local layout = Instance.new("UIListLayout", scroll)
    layout.Padding = UDim.new(0,6)
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    local function rebuild()
        for _,c in ipairs(scroll:GetChildren()) do
            if c:IsA("Frame") then c:Destroy() end
        end
        local total = 7
        for i,item in ipairs(items) do
            local it = Instance.new("Frame", scroll)
            it.Size = UDim2.new(1,-8,0,28)
            it.Position = UDim2.new(0,5,0,total)
            it.BackgroundColor3 = FLUENT_THEMES[CUR_THEME].accent:lerp(FLUENT_THEMES[CUR_THEME].main,0.49)
            local c = Instance.new("UICorner", it) c.CornerRadius = UDim.new(1,0)
            local label = Instance.new("TextLabel", it)
            label.Size = UDim2.new(0.85,0,1,0)
            label.Position = UDim2.new(0,6,0,0)
            label.BackgroundTransparency = 1
            label.Text = tostring(item)
            label.Font = Enum.Font.Gotham
            label.TextSize = 14
            label.TextColor3 = FLUENT_THEMES[CUR_THEME].text
            total = total+29
        end
        scroll.CanvasSize = UDim2.new(0,0,0,total)
    end
    rebuild()
    return frame
end

local function showNotification(text, duration)
    local notif = Instance.new("TextLabel", notifHolder)
    notif.Size = UDim2.fromOffset(215,44)
    notif.Position = UDim2.new(0.5,-107,0.09,0)
    notif.BackgroundColor3 = FLUENT_THEMES[CUR_THEME].accent
    notif.TextColor3 = Color3.fromRGB(255,255,255)
    notif.Text = text
    notif.Font = Enum.Font.GothamBold
    notif.TextSize = 16
    notif.AnchorPoint = Vector2.new(0.5,0)
    notif.BackgroundTransparency = 0.12
    local nc = Instance.new("UICorner", notif)
    nc.CornerRadius = UDim.new(0,10)
    notif.ZIndex = 200
    rippleEffect(notif,FLUENT_THEMES[CUR_THEME].main)
    tween(notif,{Position=UDim2.new(0.5,-107,0.07,0),BackgroundTransparency=0},.17):Play()
    wait(duration or 1)
    tween(notif,{Position=UDim2.new(0.5,-107,0.01,0),BackgroundTransparency=1},.18):Play()
    game.Debris:AddItem(notif,0.37)
end

--------------------- DEMO USAGE --------------------------

-- TAB HOME
local tHome = createTab("🏠 Home")
local h = tHome.holder
createLabel(h, "FluentUI Demo - All in one modern UI!")
local btn1 = createButton(h, "Show notification demo", function()
    showNotification("Bạn vừa bấm nút!",1.1)
end)
local tog, getTog = createToggle(h, "AUTO MODE", false, function(state)
    showNotification(state and "Auto Enabled" or "Auto Disabled",1)
end)
createSlider(h,"Speed",0,200,85,function(val) end)
createDropdown(h,"Pick Option:",{"One","Two","Three"},function(sel) showNotification("Selected: "..sel,1) end)

-- TAB INPUT
local tInput = createTab("✏️ Input")
local inp = tInput.holder
createLabel(inp, "Tất cả loại nhập liệu:")
createTextbox(inp, "Nhập văn bản ở đây...", function(txt)
    showNotification("Text: "..txt,1)
end)
createList(inp, {"Item 1","Item 2","Item 3","Demo dài"})

-- TAB BUTTONS
local tBtn = createTab("🔘 Buttons")
local bh = tBtn.holder
for i=1,4 do
    local b = createButton(bh, "Button #"..i, function()
        showNotification("Pressed Button "..i,1)
    end)
end

-- TAB TOGGLE & SLIDER
local ttg = createTab("🎚️ Toggle/Slider")
local tg = ttg.holder
createToggle(tg, "Demo Toggle", true, function(s) end)
createSlider(tg, "Volume", 0,1,0.5, function(v) end)
createDropdown(tg,"Theme",{"Default","Purple","Teal","Light","Pink"},function(t)
    if FLUENT_THEMES[t] then
        CUR_THEME = t
        tween(main, {BackgroundColor3=FLUENT_THEMES[CUR_THEME].main},0.21):Play()
        tween(content, {BackgroundColor3=FLUENT_THEMES[CUR_THEME].main:lerp(FLUENT_THEMES[CUR_THEME].accent,0.1)},.13):Play()
        tween(title, {TextColor3=FLUENT_THEMES[CUR_THEME].accent},.16):Play()
        tween(sub, {TextColor3=FLUENT_THEMES[CUR_THEME].text},.13):Play()
        tween(tabbar,{BackgroundColor3=FLUENT_THEMES[CUR_THEME].accent:lerp(FLUENT_THEMES[CUR_THEME].main,0.80)},.13):Play()
        bg.Image = BG_IMG_ID -- giữ luôn ảnh nền, nếu muốn đổi ảnh theo theme thì đổi giá trị ở đây.
    end
end)

-- TAB INFO
local tInfo = createTab("ℹ️ Info")
local ib = tInfo.holder
createLabel(ib, "Script by PHUCMAX - Fluent UI demo cho Roblox")
createLabel(ib, "Đầy đủ element hiện đại, theme, hiệu ứng...")

-------------------- TOGGLE LOGIC ---------------------
local isOpen, isMin = true, false
toggleBtn.MouseButton1Click:Connect(function()
    isOpen = not isOpen
    if isOpen then
        tween(main, {Size=UDim2.fromOffset(520,360)}, .21):Play()
    else
        tween(main, {Size=UDim2.fromOffset(0,360)}, .18):Play()
    end
end)
toggleBtn.MouseEnter:Connect(function() tween(toggleBtn, {Size=UDim2.fromOffset(70,70)}, .14):Play() end)
toggleBtn.MouseLeave:Connect(function() tween(toggleBtn, {Size=UDim2.fromOffset(62,62)}, .12):Play() end)
toggleBtn.MouseButton1Down:Connect(function() tween(toggleBtn, {BackgroundTransparency = 0.14}, .07):Play() end)
toggleBtn.MouseButton1Up:Connect(function() tween(toggleBtn, {BackgroundTransparency = 0.3}, .08):Play() end)

closeBtn.MouseButton1Click:Connect(function()
    isMin = not isMin
    if isMin then
        tween(main,{Size=UDim2.fromOffset(520,54)},.18):Play()
    else
        tween(main,{Size=UDim2.fromOffset(520,360)},.18):Play()
    end
end)
main.Size = UDim2.fromOffset(0,360)
tween(main, {Size=UDim2.fromOffset(520,360)}, .22):Play()

print("PHUCMAX FLUENT UI - MODULAR VERSION loaded!")