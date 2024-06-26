local module = {}

module["Name"] = "Custom module test"

module[1] = {
    Type = "Text",
    Args = {"Hello!"}
}

module[2] = {
    Type = "Button",
    Args = {"Say hi", function(Self)
        print("Hi!")
    end}
}

local flying = false
local bodyVelocity
local bodyGyro

local function startFlying(character)
    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
    if humanoidRootPart then
        bodyVelocity = Instance.new("BodyVelocity")
        bodyVelocity.Velocity = Vector3.new(0, 0, 0)
        bodyVelocity.MaxForce = Vector3.new(4000, 4000, 4000)
        bodyVelocity.P = 1250
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

local function toggleFly(player)
    local character = player.Character
    if not character then return end

    flying = not flying
    if flying then
        startFlying(character)
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
