local module = {}
module["gameId"] = 0 -- Restrict module to a certain game ID only. 0 allows all games
module["Name"] = "Xs's Utilities"

-- Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

-- State variables
local hiddenfling = false
local oldCFrame

-- Function to toggle the fling behavior
local function toggleFling()
    hiddenfling = not hiddenfling
    if hiddenfling then
        -- Save the initial position of the player
        oldCFrame = Players.LocalPlayer.Character.HumanoidRootPart.CFrame

        -- Function to perform the fling repeatedly while fling is active
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
                    -- Fling logic
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
        -- Start the fling function
        fling()
    else
        -- Restore the player to their original position
        Players.LocalPlayer.Character.HumanoidRootPart.CFrame = oldCFrame
    end
end

-- Custom UI Elements
module[5] = {
    Type = "Toggle",
    Args = {"Fling", function(self, state)
        toggleFling()
    end}
}

_G.Modules = _G.Modules or {}
_G.Modules[#_G.Modules + 1] = module

-- Return the module table
return module
