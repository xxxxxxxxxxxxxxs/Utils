local module = {}

module["Name"] = "Xs's Utilities"

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local FLYING = false
local QEfly = true
local iyflyspeed = 1
local vehicleflyspeed = 1
local IYMouse = Players.LocalPlayer:GetMouse()

local Clip = true
local Noclipping = nil
local floatName = "FloatingName"

local warps = {}
local flingActive = false
local originalCFrame

local function getRoot(char)
    local rootPart = char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("Torso")
    return rootPart
end

local function toggleFling()
    flingActive = not flingActive

    if flingActive then
        originalCFrame = Players.LocalPlayer.Character.HumanoidRootPart.CFrame
        
        local hiddenfling = true
        if not game:GetService("ReplicatedStorage"):FindFirstChild("juisdfj0i32i0eidsuf0iok") then
            local detection = Instance.new("Decal")
            detection.Name = "juisdfj0i32i0eidsuf0iok"
            detection.Parent = game:GetService("ReplicatedStorage")
            
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
            
            coroutine.wrap(fling)()
        end
        
        local function flingPlayer(target)
            local function moveToTarget(targetCFrame)
                Players.LocalPlayer.Character.HumanoidRootPart.CFrame = targetCFrame * CFrame.new(0, 0, 4)
                wait(0.01)
                Players.LocalPlayer.Character.HumanoidRootPart.CFrame = targetCFrame * CFrame.new(0, 0, -2)
                wait(0.01)
                Players.LocalPlayer.Character.HumanoidRootPart.CFrame = targetCFrame
                wait(0.01)
                Players.LocalPlayer.Character.HumanoidRootPart.CFrame = targetCFrame * CFrame.new(0, 0, -3)
                wait(0.01)
                Players.LocalPlayer.Character.HumanoidRootPart.CFrame = targetCFrame * CFrame.new(0, 0, 2)
                wait(0.01)
                Players.LocalPlayer.Character.HumanoidRootPart.CFrame = targetCFrame
                wait(0.01)
                Players.LocalPlayer.Character.HumanoidRootPart.CFrame = targetCFrame * CFrame.new(0, 0, -1)
                wait(0.01)
                Players.LocalPlayer.Character.HumanoidRootPart.CFrame = targetCFrame * CFrame.new(0, 0, -1)
            end
            
            if target == "all" or target == "others" then
                for _, x in next, Players:GetPlayers() do
                    for i = 1, 10 do
                        moveToTarget(x.Character.HumanoidRootPart.CFrame)
                    end
                end
            else
                local targetPlayer = Players:FindFirstChild(target)
                if targetPlayer then
                    for i = 1, 10 do
                        moveToTarget(targetPlayer.Character.HumanoidRootPart.CFrame)
                    end
                else
                    print("Player '" .. target .. "' not found.")
                end
            end
        end
        
        flingPlayer("targetPlayerName")  -- Replace with the actual player name or logic to get player name
        sFLY(true)
        iyflyspeed = 1
        wait(0.3)
        Players.LocalPlayer.Character.HumanoidRootPart.CFrame = originalCFrame
        wait(0.13)
        Players.LocalPlayer.Character.Humanoid.PlatformStand = false
        hiddenfling = false
        FLYING = false
    else
        Players.LocalPlayer.Character.HumanoidRootPart.CFrame = originalCFrame
        Players.LocalPlayer.Character.Humanoid.PlatformStand = false
        hiddenfling = false
        FLYING = false
    end
end

local function sFLY(vfly)
    repeat wait() until Players.LocalPlayer and Players.LocalPlayer.Character and getRoot(Players.LocalPlayer.Character) and Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
    repeat wait() until IYMouse
    if flyKeyDown or flyKeyUp then flyKeyDown:Disconnect() flyKeyUp:Disconnect() end

    local T = getRoot(Players.LocalPlayer.Character)
    local CONTROL = {F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0}
    local lCONTROL = {F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0}
    local SPEED = 0

    local function FLY()
        FLYING = true
        local BG = Instance.new('BodyGyro')
        local BV = Instance.new('BodyVelocity')
        BG.P = 9e4
        BG.Parent = T
        BV.Parent = T
        BG.maxTorque = Vector3.new(9e9, 9e9, 9e9)
        BG.cframe = T.CFrame
        BV.velocity = Vector3.new(0, 0, 0)
        BV.maxForce = Vector3.new(9e9, 9e9, 9e9)
        task.spawn(function()
            repeat wait()
                if not vfly and Players.LocalPlayer.Character:FindFirstChildOfClass('Humanoid') then
                    Players.LocalPlayer.Character:FindFirstChildOfClass('Humanoid').PlatformStand = true
                end
                if CONTROL.L + CONTROL.R ~= 0 or CONTROL.F + CONTROL.B ~= 0 or CONTROL.Q + CONTROL.E ~= 0 then
                    SPEED = 50
                elseif not (CONTROL.L + CONTROL.R ~= 0 or CONTROL.F + CONTROL.B ~= 0 or CONTROL.Q + CONTROL.E ~= 0) and SPEED ~= 0 then
                    SPEED = 0
                end
                if (CONTROL.L + CONTROL.R) ~= 0 or (CONTROL.F + CONTROL.B) ~= 0 or (CONTROL.Q + CONTROL.E) ~= 0 then
                    BV.velocity = ((workspace.CurrentCamera.CFrame.lookVector * (CONTROL.F + CONTROL.B)) + ((workspace.CurrentCamera.CFrame * CFrame.new(CONTROL.L + CONTROL.R, (CONTROL.F + CONTROL.B + CONTROL.Q + CONTROL.E) * 0.2, 0).p) - workspace.CurrentCamera.CFrame.p)) * SPEED
                    lCONTROL = {F = CONTROL.F, B = CONTROL.B, L = CONTROL.L, R = CONTROL.R}
                elseif (CONTROL.L + CONTROL.R) == 0 and (CONTROL.F + CONTROL.B) == 0 and (CONTROL.Q + CONTROL.E) == 0 and SPEED ~= 0 then
                    BV.velocity = ((workspace.CurrentCamera.CFrame.lookVector * (lCONTROL.F + lCONTROL.B)) + ((workspace.CurrentCamera.CFrame * CFrame.new(lCONTROL.L + lCONTROL.R, (lCONTROL.F + lCONTROL.B + CONTROL.Q + CONTROL.E) * 0.2, 0).p) - workspace.CurrentCamera.CFrame.p)) * SPEED
                else
                    BV.velocity = Vector3.new(0, 0, 0)
                end
                BG.cframe = workspace.CurrentCamera.CFrame
            until not FLYING
            CONTROL = {F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0}
            lCONTROL = {F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0}
            SPEED = 0
            BG:Destroy()
            BV:Destroy()
            if Players.LocalPlayer.Character:FindFirstChildOfClass('Humanoid') then
                Players.LocalPlayer.Character:FindFirstChildOfClass('Humanoid').PlatformStand = false
            end
        end)
    end
   
