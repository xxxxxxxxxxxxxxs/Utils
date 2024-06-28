local module = {}

module["Name"] = "Xs's Utilities"

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local hiddenfling = false
local oldCFrame

local warps = {}

local function toggleFling()
    hiddenfling = not hiddenfling
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
end

-- UI Setup
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = game.CoreGui

local buttonFling = Instance.new("TextButton")
buttonFling.Size = UDim2.new(0, 100, 0, 50)
buttonFling.Position = UDim2.new(0, 10, 0, 10)
buttonFling.Text = "Fling"
buttonFling.Parent = ScreenGui

buttonFling.MouseButton1Click:Connect(function()
    toggleFling()
end)

return module
