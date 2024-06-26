local module = {}

module["Name"] = "Fly by xs"


local flying = false
local bodyVelocity
local bodyGyro
local UserInputService = game:GetService("UserInputService")

local function startFlying(character)
    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
    if humanoidRootPart then
        bodyVelocity = Instance.new("BodyVelocity")
        bodyVelocity.Velocity = Vector3.new(0, 0, 0)
        bodyVelocity.MaxForce = Vector3.new(4000, 4000, 4000)
        bodyVelocity.Parent = humanoidRootPart

        bodyGyro = Instance.new("BodyGyro")
        bodyGyro.CFrame = humanoidRootPart.CFrame
        bodyGyro.MaxTorque = Vector3.new(4000, 4000, 4000)
        bodyGyro.P = 3000
        bodyGyro.Parent = humanoidRootPart
    end
end

local function stopFlying()
    if bodyVelocity then
        bodyVelocity:Destroy()
        bodyVelocity = nil
    end
    if bodyGyro then
        bodyGyro:Destroy()
        bodyGyro = nil
    end
end

local function onInputBegan(input, gameProcessed)
    if gameProcessed then return end
    if not flying then return end

    local character = game.Players.LocalPlayer.Character
    if not character then return end

    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
    if not humanoidRootPart then return end

    if input.KeyCode == Enum.KeyCode.W then
        bodyVelocity.Velocity = humanoidRootPart.CFrame.LookVector * 50
    elseif input.KeyCode == Enum.KeyCode.S then
        bodyVelocity.Velocity = -humanoidRootPart.CFrame.LookVector * 50
    elseif input.KeyCode == Enum.KeyCode.A then
        bodyVelocity.Velocity = -humanoidRootPart.CFrame.RightVector * 50
    elseif input.KeyCode == Enum.KeyCode.D then
        bodyVelocity.Velocity = humanoidRootPart.CFrame.RightVector * 50
    elseif input.KeyCode == Enum.KeyCode.Space then
        bodyVelocity.Velocity = Vector3.new(0, 50, 0)
    elseif input.KeyCode == Enum.KeyCode.LeftControl then
        bodyVelocity.Velocity = Vector3.new(0, -50, 0)
    end
end

local function onInputEnded(input, gameProcessed)
    if gameProcessed then return end
    if not flying then return end

    bodyVelocity.Velocity = Vector3.new(0, 0, 0)
end

local function toggleFly(player)
    local character = player.Character
    if not character then return end

    flying = not flying
    if flying then
        startFlying(character)
        UserInputService.InputBegan:Connect(onInputBegan)
        UserInputService.InputEnded:Connect(onInputEnded)
    else
        stopFlying()
    end
end

module[3] = {
    Type = "Button",
    Args = {"Toggle Fly", function(Self)
        local player = game.Players.LocalPlayer
        toggleFly(player)
    end}
}

_G.Modules[#_G.Modules + 1] = module
return module
