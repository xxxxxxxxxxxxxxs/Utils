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

local function getRoot(char)
    local rootPart = char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("Torso")
    return rootPart
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
    flyKeyDown = IYMouse.KeyDown:Connect(function(KEY)
        if KEY:lower() == 'w' then
            CONTROL.F = (vfly and vehicleflyspeed or iyflyspeed)
        elseif KEY:lower() == 's' then
            CONTROL.B = - (vfly and vehicleflyspeed or iyflyspeed)
        elseif KEY:lower() == 'a' then
            CONTROL.L = - (vfly and vehicleflyspeed or iyflyspeed)
        elseif KEY:lower() == 'd' then 
            CONTROL.R = (vfly and vehicleflyspeed or iyflyspeed)
        elseif QEfly and KEY:lower() == 'e' then
            CONTROL.Q = (vfly and vehicleflyspeed or iyflyspeed)*2
        elseif QEfly and KEY:lower() == 'q' then
            CONTROL.E = -(vfly and vehicleflyspeed or iyflyspeed)*2
        end
        pcall(function() workspace.CurrentCamera.CameraType = Enum.CameraType.Track end)
    end)
    flyKeyUp = IYMouse.KeyUp:Connect(function(KEY)
        if KEY:lower() == 'w' then
            CONTROL.F = 0
        elseif KEY:lower() == 's' then
            CONTROL.B = 0
        elseif KEY:lower() == 'a' then
            CONTROL.L = 0
        elseif KEY:lower() == 'd' then
            CONTROL.R = 0
        elseif KEY:lower() == 'e' then
            CONTROL.Q = 0
        elseif KEY:lower() == 'q' then
            CONTROL.E = 0
        end
    end)
    FLY()
end

local function NOFLY()
    FLYING = false
    if flyKeyDown or flyKeyUp then flyKeyDown:Disconnect() flyKeyUp:Disconnect() end
    if Players.LocalPlayer.Character:FindFirstChildOfClass('Humanoid') then
        Players.LocalPlayer.Character:FindFirstChildOfClass('Humanoid').PlatformStand = false
    end
    pcall(function() workspace.CurrentCamera.CameraType = Enum.CameraType.Custom end)
end

local function noclip()
    Clip = false
    wait(0.1)
    local function NoclipLoop()
        if Clip == false and Players.LocalPlayer.Character ~= nil then
            for _, child in pairs(Players.LocalPlayer.Character:GetDescendants()) do
                if child:IsA("BasePart") and child.CanCollide == true and child.Name ~= floatName then
                    child.CanCollide = false
                end
            end
        end
    end
    Noclipping = RunService.Stepped:Connect(NoclipLoop)
end

local function clip()
    if Noclipping then
        Noclipping:Disconnect()
    end
    Clip = true
end

local function toggleNoclip()
    if Clip then
        noclip()
    else
        clip()
    end
end

local function setWarp(name)
    local player = Players.LocalPlayer
    local character = player.Character
    if character and getRoot(character) then
        warps[name] = getRoot(character).CFrame
        print("Warp '" .. name .. "' set.")
    else
        print("Error: Could not set warp. Player or root part not found.")
    end
end

local function gotoWarp(name)
    local player = Players.LocalPlayer
    local character = player.Character
    if character and getRoot(character) then
        if warps[name] then
            getRoot(character).CFrame = warps[name]
            print("Teleported to warp '" .. name .. "'.")
        else
            print("Error: Warp '" .. name .. "' not found.")
        end
    else
        print("Error: Could not teleport. Player or root part not found.")
    end
end

local function gotoPlayer(targetPlayerName)
    local targetPlayer = Players:FindFirstChild(targetPlayerName)
    if targetPlayer then
        local character = targetPlayer.Character
        if character and getRoot(character) then
            local targetPosition = getRoot(character).Position
            local playerCharacter = Players.LocalPlayer.Character
            if playerCharacter and getRoot(playerCharacter) then
                getRoot(playerCharacter).CFrame = CFrame.new(targetPosition + Vector3.new(0, 5, 0))
            end
        end
    else
        print("Player '" .. targetPlayerName .. "' not found.")
    end
end

local function flingPlayer(targetPlayerName)
    local oldCFrame = Players.LocalPlayer.Character.HumanoidRootPart.CFrame
    local targetPlayer = Players:FindFirstChild(targetPlayerName)

    if not targetPlayer then
        print("Player '" .. targetPlayerName .. "' not found.")
        return
    end

    local targetCharacter = targetPlayer.Character
    if not targetCharacter then
        print("Target player's character not found.")
        return
    end

    local targetHRP = targetCharacter:FindFirstChild("HumanoidRootPart")
    if not targetHRP then
        print("Target player's HumanoidRootPart not found.")
        return
    end

    hiddenfling = true

    if game:GetService("ReplicatedStorage"):FindFirstChild("juisdfj0i32i0eidsuf0iok") then
        hiddenfling = true
    else
        local detection = Instance.new("Decal")
        detection.Name = "juisdfj0i32i0eidsuf0iok"
        detection.Parent = game:GetService("ReplicatedStorage")
        local function fling()
            local hrp, c, vel, movel = nil, nil, nil, 0.1
            while true do
                RunService.Heartbeat:Wait()
                if hiddenfling then
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
        end
        fling()
    end

    local playerCharacter = Players.LocalPlayer.Character
    local playerHRP = getRoot(playerCharacter)
    playerCharacter.Humanoid:SetStateEnabled("Seated", false)
    playerCharacter.Humanoid.Sit = true

    for i = 1, 10 do
        wait(0.017)
        playerHRP.CFrame = targetHRP.CFrame * CFrame.new(0, 0, 4)
        wait(0.01)
        playerHRP.CFrame = targetHRP.CFrame * CFrame.new(0, 0, -2)
        wait(0.01)
        playerHRP.CFrame = targetHRP.CFrame
        wait(0.01)
        playerHRP.CFrame = targetHRP.CFrame * CFrame.new(0, 0, -3)
        wait(0.01)
        playerHRP.CFrame = targetHRP.CFrame * CFrame.new(0, 0, 2)
        wait(0.01)
        playerHRP.CFrame = targetHRP.CFrame
        wait(0.01)
        playerHRP.CFrame = targetHRP.CFrame * CFrame.new(0, 0, -1)
        wait(0.01)
        playerHRP.CFrame = targetHRP.CFrame * CFrame.new(0, 0, -1)
    end

    sFLY(true)
    wait(0.3)
    playerHRP.CFrame = oldCFrame
    wait(0.13)
    playerCharacter.Humanoid:SetStateEnabled("Seated", true)
    playerCharacter.Humanoid.Sit = false
    FLYING = false
    playerCharacter.Humanoid.PlatformStand = false
    hiddenfling = false
end

module[1] = {
    Type = "Button",
    Args = {"Toggle Fly", function()
        if FLYING then
            NOFLY()
        else
            sFLY()
        end
    end}
}

module[2] = {
    Type = "Button",
    Args = {"Toggle Noclip", function()
        toggleNoclip()
    end}
}

module[3] = {
    Type = "Input",
    Args = {"Enter warp name", "Set Warp", function(Self, text)
        setWarp(text)
    end}
}

module[4] = {
    Type = "Input",
    Args = {"Enter warp name", "Teleport to Warp", function(Self, text)
        gotoWarp(text)
    end}
}

module[5] = {
    Type = "Input",
    Args = {"Enter player's name", "Teleport", function(Self, text)
        gotoPlayer(text)
    end}
}

module[6] = {
    Type = "Input",
    Args = {"Enter player's name", "Fling Player", function(Self, text)
        flingPlayer(text)
    end}
}

_G.Modules = _G.Modules or {}
_G.Modules[#_G.Modules + 1] = module

return module

