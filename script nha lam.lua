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

-- Tạo GUI điều khiển toggle
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

-- Tab Tổng Hợp
local generalTab = Window:AddTab({
    Title = "Script Tổng Hợp",
    Icon = "package"
})

generalTab:AddParagraph({
    Title = "Chú Ý",
    Content = "Không được dùng quá nhiều script cùng một lúc"
})

generalTab:AddButton({Title = "TsuoHub", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/Tsuo7/TsuoHub/main/Tsuoscripts"))() end})
generalTab:AddButton({Title = "Xero Hub", Callback = function() getgenv().Team = "Marines"; getgenv().Hide_Menu = false; getgenv().Auto_Execute = false; loadstring(game:HttpGet("https://raw.githubusercontent.com/Xero2409/XeroHub/refs/heads/main/main.lua"))() end})
generalTab:AddButton({Title = "Redz Hub", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/newredz/BloxFruits/refs/heads/main/Source.luau"))() end})
generalTab:AddButton({Title = "Hoho Hub", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/acsu123/HOHO_H/main/Loading_UI"))() end})
generalTab:AddButton({Title = "W-Azure", Callback = function() loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/3b2169cf53bc6104dabe8e19562e5cc2.lua"))() end})
generalTab:AddButton({Title = "Turbo Lite", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/TurboLite/Script/refs/heads/main/Main.lua"))() end})
generalTab:AddButton({Title = "Tuấn Anh IOS Hub", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/AnhDzaiScript/TuanAnhIOS/refs/heads/main/TuanAnhIOS-Piaa.lua"))() end})

-- Tab Script Việt Nam
local scripvnTab = Window:AddTab({
    Title = "Script VN",
    Icon = "package"
})

scripvnTab:AddParagraph({
    Title = "Chú Ý",
    Content = "Không được dùng quá nhiều script cùng một lúc"
})

scripvnTab:AddButton({Title = "RUBU", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/LuaCrack/RubuRoblox/refs/heads/main/RubuBF"))() end})
scripvnTab:AddButton({Title = "AnDepZaiHub", Callback = function() repeat wait() until game:IsLoaded() and game.Players.LocalPlayer; loadstring(game:HttpGet("https://raw.githubusercontent.com/AnDepZaiHub/AnDepZaiHubBeta/refs/heads/main/AnDepZaiHubNewUpdated.lua"))() end})
scripvnTab:AddButton({Title = "Min", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/Zunes-Bypassed/NOPE/main/Min.lua"))() end})
scripvnTab:AddButton({Title = "BapRed", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/LuaCrack/BapRed/main/BapRedHub"))() end})

-- Tab Auto Bounty
local bountyTab = Window:AddTab({
    Title = "Script Auto Bounty",
    Icon = "sword"
})

bountyTab:AddButton({
    Title = "Auto Bounty Full Config",
    Callback = function()
        repeat wait() until game:IsLoaded() and game.Players.LocalPlayer
        getgenv().Team = "Pirates"
        getgenv().Config = {
            ["Safe Health"] = {50},
            ["Custom Y Run"] = {Enabled = true, ["Y Run"] = 5000},
            ["Hunt Method"] = {
                ["Use Move Predict"] = true,
                ["Hit and Run"] = true,
                ["Aimbot"] = true,
                ["ESP Player"] = true,
                ["Max Attack Time"] = 60
            },
            ["Shop"] = {["Random Fruit"] = false, ["Store Fruit"] = true, ["Zoro Sword"] = false},
            ["Setting"] = {
                ["World"] = 3,
                ["White Screen"] = false,
                ["Click Delay"] = 0.1,
                ["Url"] = "Your_Webhook_Url",
                ["Chat"] = {Enabled = true, Wait = 350, Massage = {"Lion Hub On Top", "Get Best Script g g / lionhub"}}
            },
            ["Skip"] = {["Avoid V4"] = false},
            ["Spam All Skill On V4"] = {
                Enabled = true,
                ["Weapons"] = {"Melee", "Sword", "Gun", "Blox Fruit"}
            },
            Items = {
                Use = {"Melee", "Sword"},
                Melee = {
                    Enable = true,
                    Delay = 0.6,
                    Skills = {
                        Z = {Enable = true, HoldTime = 0.3},
                        X = {Enable = true, HoldTime = 0.2},
                        C = {Enable = true, HoldTime = 0.5}
                    }
                },
                Sword = {
                    Enable = true,
                    Delay = 0.5,
                    Skills = {
                        Z = {Enable = true, HoldTime = 1},
                        X = {Enable = true, HoldTime = 0}
                    }
                },
                Gun = {
                    Enable = false,
                    Delay = 0.2,
                    Skills = {
                        Z = {Enable = false, HoldTime = 0.1},
                        X = {Enable = false, HoldTime = 0.1}
                    }
                },
                ["Blox Fruit"] = {
                    Enable = true,
                    Delay = 0.4,
                    Skills = {
                        Z = {Enable = true, HoldTime = 0.1},
                        X = {Enable = true, HoldTime = 0.1},
                        C = {Enable = true, HoldTime = 0.15},
                        V = {Enable = false, HoldTime = 0.2},
                        F = {Enable = true, HoldTime = 0.1}
                    }
                }
            }
        }
        loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/10f7f97cebba24a87808c36ebd345a97.lua"))()
    end
})
bountyTab:AddButton({
    Title = "Lion Auto Bounty",
    Callback = function()
        loadstring(game:HttpGet("https://pastefy.app/l1siGJS1/raw"))()
    end
})
local FixLagTab = Window:AddTab({
    Title = "FixLag",
    Icon = "wrench"
})

FixLagTab:AddParagraph({
    Title = "Fix Lag Chú Ý",
    Content = "không dùng x1x2x3max cùng một lúc"
})

-- Mức FixLag X1
FixLagTab:AddButton({
    Title = "FixLag X1",
    Description = "50%",
    Callback = function()
        -- Xóa cây và bóng
        for _, object in pairs(workspace:GetDescendants()) do
            if object:IsA("Part") and object.Name == "Tree" then
                object:Destroy()
            end
            if object:IsA("Part") and object.Name == "Shadow" then
                object:Destroy()
            end
        end
        game.Lighting:ClearAllChildren()  -- Xóa hiệu ứng trời
    end
})

-- Mức FixLag X2
FixLagTab:AddButton({
    Title = "FixLag X2",
    Description = "60%",
    Callback = function()
        -- Xóa cây, bóng, và xóa hiệu ứng skill
        for _, object in pairs(workspace:GetDescendants()) do
            if object:IsA("Part") and (object.Name == "Tree" or object.Name == "Shadow") then
                object:Destroy()
            end
            if object:IsA("ParticleEmitter") or object:IsA("Trail") then
                object:Destroy()  -- Xóa hiệu ứng skill
            end
        end
        game.Lighting:ClearAllChildren()  -- Xóa hiệu ứng trời
        -- Xóa vật thể nhỏ
        for _, object in pairs(workspace:GetDescendants()) do
            if object:IsA("Part") and object.Size.Magnitude < 10 then
                object:Destroy()
            end
        end
    end
})

-- Mức FixLag X3 (Giảm độ họa hết mức có thể và xóa sạch hoàn toàn cây)
FixLagTab:AddButton({
    Title = "FixLag X3",
    Description = " 70%",
    Callback = function()
        -- Xóa cây, bóng, và xóa hiệu ứng skill
        for _, object in pairs(workspace:GetDescendants()) do
            if object:IsA("Part") and (object.Name == "Tree" or object.Name == "Shadow") then
                object:Destroy()
            end
            if object:IsA("ParticleEmitter") or object:IsA("Trail") then
                object:Destroy()  -- Xóa hiệu ứng skill
            end
        end
        game.Lighting:ClearAllChildren()  -- Xóa hiệu ứng trời
        -- Xóa vật thể nhỏ
        for _, object in pairs(workspace:GetDescendants()) do
            if object:IsA("Part") and object.Size.Magnitude < 10 then
                object:Destroy()
            end
        end
        -- Giảm độ sáng xuống 70%
        game.Lighting.Ambient = Color3.fromRGB(179, 179, 179)  -- 70% độ sáng
        game.Lighting.OutdoorAmbient = Color3.fromRGB(179, 179, 179)  -- 70% độ sáng
    end
})

-- Fix Lag MAX (Giữ ánh sáng + Xóa nhà nhưng đứng được)
FixLagTab:AddButton({
    Title = "Fix Lag MAX",
    Description = "80%",
    Callback = function()
        -- Remove Skybox Only
        local Lighting = game:GetService("Lighting")
        for _, v in pairs(Lighting:GetChildren()) do
            if v:IsA("Sky") then
                v:Destroy()
            end
        end

        -- Rendering Settings
        settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
        pcall(function()
            settings().Rendering.VSync = false
        end)

        -- Workspace Optimization
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj:IsA("BasePart") or obj:IsA("MeshPart") or obj:IsA("UnionOperation") then
                -- Nếu vật thể là sàn nhà hoặc nền, giữ lại màu
                if obj.Position.Y < 5 then -- Tọa độ thấp => là mặt đất/sàn
                    obj.Material = Enum.Material.SmoothPlastic
                    obj.Reflectance = 0
                    obj.CastShadow = false
                else
                    -- Là nhà, đồ vật, làm trong suốt
                    obj.Material = Enum.Material.SmoothPlastic
                    obj.Reflectance = 0
                    obj.CastShadow = false
                    obj.Transparency = 1 -- Làm trong suốt nhưng vẫn đứng được
                    if obj:FindFirstChild("Texture") then
                        obj.Texture:Destroy()
                    end
                end
            elseif obj:IsA("Decal") or obj:IsA("Texture") then
                obj:Destroy()
            elseif obj:IsA("ParticleEmitter") or obj:IsA("Trail") or obj:IsA("Smoke") or obj:IsA("Fire") or obj:IsA("Sparkles") then
                obj:Destroy()
            elseif obj:IsA("Mesh") then
                obj:Destroy()
            end
        end

        -- Clear Terrain Water
        local terrain = workspace:FindFirstChildOfClass("Terrain")
        if terrain then
            terrain.WaterWaveSize = 0
            terrain.WaterWaveSpeed = 0
            terrain.WaterReflectance = 0
            terrain.WaterTransparency = 1
        end

        -- Clear Effects Folder
        if workspace:FindFirstChild("Effects") then
            workspace.Effects:Destroy()
        end
    end
})
local hopsevervipTab= Window:AddTab({
    Title = "hop sever full mon",
    Icon = "server"
})


hopsevervipTab:AddButton({
    Title = "script hop vip",
    Description = "nhấn để chạy script",
    Callback = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/AnhTuanDzai-Hub/ScriptHopBoss/refs/heads/main/HopFullMom.lua"))()
end
})
hopsevervipTab:AddButton({
    Title = "script hop boss",
    Description = "nhấn để chạy script",
    Callback = function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/LuaCrack/Min/refs/heads/main/MinHopBoss"))()
end
})
local fruitTab = Window:AddTab({
    Title = "script auto nhặt trái",
    Icon = "apple"
})


fruitTab:AddButton({
    Title = "Turbo Lite Nhặt Trái",
    Description = "nhấn để chạy script ",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/TurboLite/Script/refs/heads/main/TraiCay.lua"))()
    end
})

local aimbotvipTab = Window:AddTab({
    Title = "aimbot vip",
    Icon = "crosshair"
})
aimbotvipTab:AddParagraph({
    Title = "chú ý",
    Content = "chú ý com cặc script aimbot chứ gì mà chú ý "

aimbotvipTab:AddButton({
    Title = "aimbot Tuấn Anh IOS",
    Description = "nhấn để chạy script ",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/AnhTuanDzai-Hub/AimBotSkibidi/refs/heads/main/TuanAnhIOS-AIMBOT.Lua"))()
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
 
