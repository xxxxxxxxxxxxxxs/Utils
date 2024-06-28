local module = {}

module["Name"] = "Xs's Utilities"

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local hiddenfling = false
local oldCFrame

local warps = {}

-- Function to create a toggle switch UI element
local function createToggleSwitch(text, callback)
    local toggleState = false

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 200, 0, 50)
    frame.Position = UDim2.new(0, 10, 0, 10)
    frame.BackgroundTransparency = 0.5
    frame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    frame.BorderSizePixel = 0
    frame.Parent = game.CoreGui

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0.5, 0, 1, 0)
    label.Position = UDim2.new(0, 5, 0, 0)
    label.Text = text
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.TextSize = 20
    label.BackgroundTransparency = 1
    label.Parent = frame

    local switch = Instance.new("TextButton")
    switch.Size = UDim2.new(0.3, 0, 0.8, 0)
    switch.Position = UDim2.new(0.7, 0, 0.1, 0)
    switch.Text = "OFF"
    switch.TextColor3 = Color3.fromRGB(255, 255, 255)
    switch.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
    switch.Parent = frame

    local function toggleSwitch()
        toggleState = not toggleState
        switch.Text = toggleState and "ON" or "OFF"
        callback(toggleState)
    end

    switch.MouseButton1Click:Connect(toggleSwitch)

    return frame
end

-- Define UI elements using the template
module[5] = {
    Type = "Toggle",
    Args = {"Toggle Fling", function(self, state)
        hiddenfling = state
        if hiddenfling then
            oldCFrame = Players.LocalPlayer.Character.HumanoidRootPart.CFrame

            local function fling()
                local hrp, c, vel, movel = nil, nil, nil, 0.1
                while hiddenfling do
                    RunService.Heartbeat:Wait()
                    local lp = Players.LocalPlayer
                    while hiddenfling and not (c and c.Parent and hrp and hrp.Parent) do
                        RunService.Heartbeat:Wait()
                        c = lp.Character
                        hrp = c:FindFirstChild("HumanoidRootPart") or c:FindFirstChild("Torso") or c:FindFirstChild("UpperTorso")
                    end
                    if hiddenfling then
                        vel = hrp.Velocity
                        hrp.Velocity = vel * 10000 + Vector3.new(0, 10000, 0)
                        RunService.RenderStepped:Wait()
                        if c and c.Parent and hrp and hrp.Parent then
                            hrp.Velocity = vel
                        end
                        RunService.Stepped:Wait()
                        if c and c.Parent and hrp and hrp.Parent then
                            hrp.Velocity = vel + Vector3.new(0, movel, 0)
                            movel = movel * -1
                        end
                    end
                end
            end
            fling()
        else
            Players.LocalPlayer.Character.HumanoidRootPart.CFrame = oldCFrame
        end
    end}
}

-- Create UI elements based on the template
for index, element in ipairs(module) do
    if element.Type == "Toggle" then
        createToggleSwitch(element.Args[1], element.Args[2])
    end
end

return module
