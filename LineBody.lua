-- Xóa Menu cũ tránh lag
if game:GetService("CoreGui"):FindFirstChild("DeltaDirectionESP") then
    game:GetService("CoreGui").DeltaDirectionESP:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local ToggleBtn = Instance.new("TextButton")
local LengthBox = Instance.new("TextBox")
local Title = Instance.new("TextLabel")

ScreenGui.Name = "DeltaDirectionESP"
ScreenGui.Parent = game:GetService("CoreGui")

-- Giao diện Menu nhỏ gọn cho Mobile
MainFrame.Size = UDim2.new(0, 150, 0, 130)
MainFrame.Position = UDim2.new(0.1, 0, 0.4, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local Corner = Instance.new("UICorner")
Corner.Parent = MainFrame

Title.Size = UDim2.new(1, 0, 0, 30)
Title.Text = "LINE ESP (DELTA)"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.BackgroundTransparency = 1
Title.Parent = MainFrame

-- Nút Bật/Tắt
ToggleBtn.Size = UDim2.new(0.8, 0, 0, 35)
ToggleBtn.Position = UDim2.new(0.1, 0, 0.3, 0)
ToggleBtn.Text = "ESP: OFF"
ToggleBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
ToggleBtn.Parent = MainFrame

-- Ô nhập độ dài
LengthBox.Size = UDim2.new(0.8, 0, 0, 35)
LengthBox.Position = UDim2.new(0.1, 0, 0.65, 0)
LengthBox.Text = "20"
LengthBox.PlaceholderText = "Độ dài..."
LengthBox.Parent = MainFrame

-- Hệ thống Logic
local ESP_Enabled = false
local Line_Length = 20
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

ToggleBtn.MouseButton1Click:Connect(function()
    ESP_Enabled = not ESP_Enabled
    ToggleBtn.Text = ESP_Enabled and "ESP: ON" or "ESP: OFF"
    ToggleBtn.BackgroundColor3 = ESP_Enabled and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(150, 0, 0)
end)

LengthBox.FocusLost:Connect(function()
    Line_Length = tonumber(LengthBox.Text) or 20
end)

-- Hàm tạo Line bằng Cylinder (Hoạt động cực ổn định trên Mobile)
local function CreateDirectionLine(plr)
    local part = Instance.new("Part")
    part.Name = "DirectionLine_" .. plr.Name
    part.Anchored = true
    part.CanCollide = false
    part.CastShadow = false
    part.Color = Color3.fromRGB(0, 255, 255) -- Màu xanh Neon
    part.Material = Enum.Material.Neon
    part.Size = Vector3.new(0.2, 0.2, Line_Length)
    part.Parent = workspace
    return part
end

game:GetService("RunService").RenderStepped:Connect(function()
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
            local root = plr.Character.HumanoidRootPart
            local lineName = "DirectionLine_" .. plr.Name
            local line = workspace:FindFirstChild(lineName) or CreateDirectionLine(plr)
            
            if ESP_Enabled then
                line.Size = Vector3.new(0.2, 0.2, Line_Length)
                -- Đặt line ở vị trí bụng nhân vật và hướng theo LookVector
                line.CFrame = root.CFrame * CFrame.new(0, 0, -Line_Length/2)
                line.Transparency = 0.3
            else
                line.Transparency = 1
            end
        end
    end
end)

-- Dọn dẹp khi người chơi thoát
Players.PlayerRemoving:Connect(function(plr)
    local line = workspace:FindFirstChild("DirectionLine_" .. plr.Name)
    if line then line:Destroy() end
end)
