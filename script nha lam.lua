local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()

local Window = Fluent:CreateWindow({
    Title = "PHUCMAX HUB",
    SubTitle = "Script Tổng Hợp",
    TabWidth = 150,
    Size = UDim2.fromOffset(560, 360),
    Acrylic = true,
    Theme = "Darker",
    MinimizeKey = Enum.KeyCode.End
})
-- HIỂN THỊ FPS
local RunService = game:GetService("RunService")

local fpsLabel = Instance.new("TextLabel")
fpsLabel.Size = UDim2.new(0, 100, 0, 30)
fpsLabel.Position = UDim2.new(1, -110, 0, 10)
fpsLabel.BackgroundTransparency = 1
fpsLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
fpsLabel.TextStrokeTransparency = 0
fpsLabel.TextScaled = true
fpsLabel.Font = Enum.Font.SourceSansBold
fpsLabel.Text = "FPS: 60"
fpsLabel.Parent = game:GetService("CoreGui"):FindFirstChildOfClass("ScreenGui") or Window -- Nếu có GUI gốc

local lastTime = tick()
local frameCount = 0
RunService.RenderStepped:Connect(function()
    frameCount += 1
    local now = tick()
    if now - lastTime >= 1 then
        fpsLabel.Text = "FPS: " .. frameCount
        frameCount = 0
        lastTime = now
    end
end)

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "ControlGUI"
screenGui.Parent = game.CoreGui

local toggleButton = Instance.new("ImageButton")
toggleButton.Size = UDim2.new(0, 45, 0, 45)
toggleButton.Position = UDim2.new(0, 10, 0, 10)
toggleButton.Image = "rbxassetid://114009263825021"
toggleButton.BackgroundTransparency = 1
toggleButton.Parent = screenGui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 10)
corner.Parent = toggleButton

local isFluentVisible = true
local dragging, dragInput, dragStart, startPos

local function update(input)
    local delta = input.Position - dragStart
    toggleButton.Position = UDim2.new(
        startPos.X.Scale,
        startPos.X.Offset + delta.X,
        startPos.Y.Scale,
        startPos.Y.Offset + delta.Y
    )
end

toggleButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = toggleButton.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

toggleButton.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
    if dragging and input == dragInput then
        update(input)
    end
end)

toggleButton.MouseButton1Click:Connect(function()
    isFluentVisible = not isFluentVisible
    Window:Minimize(not isFluentVisible)
end)

local MainTab = Window:AddTab({ Title = "Script Tổng Hợp ngon" })
MainTab:AddParagraph({ Title = "chú ý", Content = "không được dùng quá nhiều script cùng một lúc" })

local scripts = {
    {Title = "xero hub", URL = "https://raw.githubusercontent.com/Xero2409/XeroHub/refs/heads/main/main.lua", Extra = [[
        getgenv().Team = "Marines"
        getgenv().Hide_Menu = false
        getgenv().Auto_Execute = false
    ]]},
    {Title = "redz hub", URL = "https://raw.githubusercontent.com/newredz/BloxFruits/refs/heads/main/Source.luau"},
    {Title = "hoho hub", URL = "https://raw.githubusercontent.com/acsu123/HOHO_H/main/Loading_UI"},
    {Title = "Min Gaming", URL = "https://raw.githubusercontent.com/LuaCrack/Min/refs/heads/main/MinXoE"},
    {Title = "w-azure", URL = "https://api.luarmor.net/files/v3/loaders/3b2169cf53bc6104dabe8e19562e5cc2.lua"},
    {Title = "Turbo Lite", URL = "https://raw.githubusercontent.com/TurboLite/Script/refs/heads/main/Main.lua"},
    {Title = "tuấn anh IOS hub", URL = "https://raw.githubusercontent.com/AnhDzaiScript/TuanAnhIOS/refs/heads/main/TuanAnhIOS-Piaa.lua"},
    {Title = "AnDepZaiHub", URL = "https://raw.githubusercontent.com/AnDepZaiHub/AnDepZaiHubBeta/refs/heads/main/AnDepZaiHubNewUpdated.lua"},
    {Title = "cuttay", URL = "https://raw.githubusercontent.com/diemquy/CutTayHub/main/Cuttayhubreal.lua"},
    {Title = "ZINERHUB", URL = "https://raw.githubusercontent.com/Tienvn123tkvn/Test/main/ZINERHUB.lua"},
    {Title = "BapRedHub", URL = "https://raw.githubusercontent.com/LuaCrack/BapRed/main/BapRedHub"},
    {Title = "rubu", URL = "https://raw.githubusercontent.com/LuaCrack/RubuRoblox/refs/heads/main/RubuBF"},
    {Title = "min", URL = "https://raw.githubusercontent.com/Zunes-Bypassed/NOPE/main/Min.lua"},
    {Title = "hiru", URL = "https://raw.githubusercontent.com/NGUYENVUDUY1/Dev-Hiru/refs/heads/main/HiruHub.lua"},
    {Title = "Vehicle Fly Gui", URL = "https://raw.githubusercontent.com/GhostPlayer352/Test4/main/Vehicle%20Fly%20Gui"},
    {Title = "Vxezehub", URL = "https://raw.githubusercontent.com/Dex-Bear/Vxezehub/refs/heads/main/VxezeHubMain2"},
    {
        Title = "BlueX-Hub", URL = "https://raw.githubusercontent.com/Dev-BlueX/BlueX-Hub/refs/heads/main/Main.lua", Extra = [[
            _G.Team = "Pirates"
            _G.FixLag = false
        ]]
    }
}

for _, v in ipairs(scripts) do
    MainTab:AddButton({
        Title = v.Title,
        Description = "nhấn để chạy script",
        Callback = function()
            if v.Extra then
                loadstring(v.Extra .. "\n" .. "loadstring(game:HttpGet('" .. v.URL .. "'))()")()
            else
                loadstring(game:HttpGet(v.URL))()
            end
        end
    })
end

local severTab = Window:AddTab({ Title = "Script HOP VIP" })
severTab:AddButton({
    Title = "TeddyHop-FREE",
    Description = "nhấn để chạy script",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/skibiditoiletgojo/Haidepzai/refs/heads/main/TeddyHop-FREE"))()
    end
})
severTab:AddButton({
    Title = "Min Hop Boss",
    Description = "nhấn để chạy script",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/LuaCrack/Min/refs/heads/main/MinHopBoss"))()
    end
})
severTab:AddButton({
    Title = "TeddyHop-vip",
    Description = "nhấn để chạy script",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/skibiditoiletgojo/Haidepzai/refs/heads/main/TEDDY-PREMIUM"))()
    end
})
severTab:AddButton({
    Title = "VxezeHubHopBoss",
    Description = "nhấn để chạy script",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Dex-Bear/VxezeHubHopBoss/refs/heads/main/SkidConCacBaM"))()
    end
})
severTab:AddButton({
    Title = "hopfullmon",
    Description = "nhấn để chạy script",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/PorryDepTrai/exploit/main/OpenSourceHopServer.lua"))()
    end
})

local bountyTab = Window:AddTab({ Title = "Script AUTO BOUNTY" })
bountyTab:AddButton({
    Title = "Lion Auto Bounty",
    Description = "nhấn để chạy script",
    Callback = function()
        loadstring(game:HttpGet("https://pastefy.app/l1siGJS1/raw"))()
    end
})

local fixlagTab = Window:AddTab({ Title = "Script FIX LAG" })

fixlagTab:AddButton({
    Title = "Fix Lag X1 (Nhẹ)",
    Description = "Tắt hiệu ứng cơ bản và giảm đồ họa",
    Callback = function()
        local Lighting = game:GetService("Lighting")
        Lighting.GlobalShadows = false
        Lighting.FogEnd = 1e10
        for _, v in pairs(workspace:GetDescendants()) do
            if v:IsA("BasePart") then
                v.Material = Enum.Material.Plastic
                v.Reflectance = 0
            end
        end
    end
})

fixlagTab:AddButton({
    Title = "Fix Lag X2 (Vừa)",
    Description = "Tắt hiệu ứng nâng cao, giảm chi tiết",
    Callback = function()
        local function ClearEffects()
            for _, v in pairs(workspace:GetDescendants()) do
                if v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Smoke") or v:IsA("Fire") then
                    v:Destroy()
                end
            end
        end
        ClearEffects()
        game:GetService("Lighting").Brightness = 1
    end
})

fixlagTab:AddButton({
    Title = "Fix Lag X3 (Mạnh)",
    Description = "Giảm tối đa chi tiết vật thể và hiệu ứng",
    Callback = function()
        for _, v in pairs(workspace:GetDescendants()) do
            if v:IsA("Decal") or v:IsA("Texture") then
                v:Destroy()
            end
        end
        game:GetService("Lighting").Ambient = Color3.new(1, 1, 1)
    end
})

fixlagTab:AddButton({
    Title = "Fix Lag MAX (Cực Mạnh)",
    Description = "Xóa cây, nhà, hiệu ứng, chỉ giữ nền để đứng",
    Callback = function()
        -- Xóa tất cả đối tượng không cần thiết trong workspace
        for _, obj in pairs(workspace:GetChildren()) do
            if obj:IsA("Model") or obj:IsA("Folder") then
                if not obj:FindFirstChildWhichIsA("Humanoid") and obj.Name ~= "Map" and obj.Name ~= "Ignore" and not obj:IsA("Terrain") then
                    pcall(function() obj:Destroy() end)
                end
            elseif obj:IsA("BasePart") and not obj:IsDescendantOf(game.Players.LocalPlayer.Character) then
                if obj.Name ~= "Baseplate" then
                    pcall(function() obj:Destroy() end)
                end
            end
        end

        -- Xóa chi tiết nhỏ, hiệu ứng
        for _, v in pairs(workspace:GetDescendants()) do
            if not v:IsA("Terrain") and not v:IsA("Camera") and not v:IsDescendantOf(game.Players.LocalPlayer.Character) then
                if v:IsA("Decal") or v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Beam") or v:IsA("Explosion") or v:IsA("Smoke") or v:IsA("Fire") then
                    pcall(function() v:Destroy() end)
                end
            end
        end

        -- Tối ưu ánh sáng
        local Lighting = game:GetService("Lighting")
        Lighting.GlobalShadows = false
        Lighting.FogEnd = 1e10
        Lighting.Brightness = 0
        Lighting.Ambient = Color3.new(1, 1, 1)
    end
})

local lastNotificationTime = 0
local notificationCooldown = 10
local currentTime = tick()

if currentTime - lastNotificationTime >= notificationCooldown then
    game.StarterGui:SetCore("SendNotification", {
        Title = "phucmaxtonghop", 
        Text = "Đã Tải Xong",
        Duration = 1,
        Icon = "rbxassetid://114009263825021" -- Thay bằng ID logo bạn muốn
    })
    lastNotificationTime = currentTime
end
 