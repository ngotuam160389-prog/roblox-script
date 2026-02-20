local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
 
local DIST_THRESHOLD = 20
local stopped = false
local connection

local COLLISION_PARTS = {"HumanoidRootPart", "Torso", "UpperTorso", "LowerTorso", "Head", "LeftArm", "RightArm", "LeftLeg", "RightLeg", "LeftUpperArm", "RightUpperArm", "LeftLowerArm", "RightLowerArm", "LeftFoot", "RightFoot", "LeftUpperLeg", "RightUpperLeg", "LeftLowerLeg", "RightLowerLeg"}

local function toggleCollision(character, canCollide)
    for i = 1, #COLLISION_PARTS do
        local part = character:FindFirstChild(COLLISION_PARTS[i])
        if part and part:IsA("BasePart") then
            if part.CanCollide ~= canCollide then
                part.CanCollide = canCollide
            end
        end
    end
end
 
local function startScript()
    if connection then connection:Disconnect() end
    stopped = false
 
    connection = RunService.Heartbeat:Connect(function()
        local character = LocalPlayer.Character
        local localHRP = character and character:FindFirstChild("HumanoidRootPart")
        
        if stopped or not localHRP then return end
 
        local localPos = localHRP.Position
        local allPlayers = Players:GetPlayers()
        
        for i = 1, #allPlayers do
            local player = allPlayers[i]
            if player ~= LocalPlayer and player.Character then
                local otherHRP = player.Character:FindFirstChild("HumanoidRootPart")
                if otherHRP then
                    local dist = (otherHRP.Position - localPos).Magnitude
                    toggleCollision(player.Character, dist >= DIST_THRESHOLD)
                end
            end
        end
    end)
end
 
LocalPlayer.Chatted:Connect(function(msg)
    if msg:lower() == "/e nc" then
        stopped = not stopped
    end
end)
 
startScript()
 
LocalPlayer.CharacterAdded:Connect(function()
    task.wait(1)
    startScript()
end)
