local ScreenGui = Instance.new("ScreenGui")
local ToggleButton = Instance.new("TextButton")
local UICorner = Instance.new("UICorner")

-- Thiết lập Giao diện nút bấm
ScreenGui.Parent = game.CoreGui
ToggleButton.Parent = ScreenGui
ToggleButton.Size = UDim2.new(0, 100, 0, 40)
ToggleButton.Position = UDim2.new(0.5, -50, 0.05, 0) -- Nằm ở giữa phía trên màn hình
ToggleButton.Text = "Rotate: OFF"
ToggleButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
ToggleButton.TextColor3 = Color3.new(1, 1, 1)
ToggleButton.Font = Enum.Font.SourceSansBold
ToggleButton.TextSize = 18

UICorner.Parent = ToggleButton

local active = false
local player = game.Players.LocalPlayer
local camera = workspace.CurrentCamera
local RunService = game:GetService("RunService")

-- Hàm xử lý Bật/Tắt
ToggleButton.MouseButton1Click:Connect(function()
    active = not active
    if active then
        ToggleButton.Text = "Rotate: ON"
        ToggleButton.BackgroundColor3 = Color3.fromRGB(50, 255, 50)
    else
        ToggleButton.Text = "Rotate: OFF"
        ToggleButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
    end
end)

-- Vòng lặp cập nhật hướng nhân vật theo Camera
RunService.RenderStepped:Connect(function()
    if active then
        local char = player.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            local rootPart = char.HumanoidRootPart
            local lookVector = camera.CFrame.LookVector
            
            -- Tính toán góc quay (chỉ quay quanh trục Y để tránh nhân vật bị nghiêng)
            local targetRotation = math.atan2(-lookVector.X, -lookVector.Z)
            rootPart.CFrame = CFrame.new(rootPart.Position) * CFrame.Angles(0, targetRotation, 0)
        end
    end
end)

-- Thông báo cho người dùng
print("Script Free Rotate Camera đã sẵn sàng trên Delta!")
