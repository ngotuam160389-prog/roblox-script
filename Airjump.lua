local player = game.Players.LocalPlayer
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

-- CÀI ĐẶT
local AirControlSpeed = 40 -- Tốc độ di chuyển khi đang trên không

print("Air Control Activated!")

RunService.RenderStepped:Connect(function()
    local char = player.Character
    if char and char:FindFirstChild("Humanoid") and char:FindFirstChild("HumanoidRootPart") then
        local humanoid = char.Humanoid
        local rootPart = char.HumanoidRootPart
        
        -- Kiểm tra nếu nhân vật đang ở trên không (nhảy hoặc rơi)
        if humanoid:GetState() == Enum.HumanoidStateType.Jumping or humanoid:GetState() == Enum.HumanoidStateType.Freefall then
            
            -- Lấy hướng di chuyển từ nút bấm (Joystick/Keyboard)
            local moveDirection = humanoid.MoveDirection
            
            if moveDirection.Magnitude > 0 then
                -- Cho phép nhân vật di chuyển theo hướng bạn điều khiển ngay cả khi đang trên không
                rootPart.Velocity = Vector3.new(moveDirection.X * AirControlSpeed, rootPart.Velocity.Y, moveDirection.Z * AirControlSpeed)
            end
        end
    end
end)
