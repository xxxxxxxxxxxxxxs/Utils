local module = {}

module["gameId"] = 0 -- Restrict module to a certain game ID only. 0 allows all games
module["Name"] = "Fling Command Module"

module[1] = {
  Type = "Button",
  Args = {"Fling3", function(Self)
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer

    local oldCFrame = LocalPlayer.Character.HumanoidRootPart.CFrame
    local Target = getPlr("all")  -- Adjust as needed to get the player(s) to fling

    local hiddenFling = true

    if game:GetService("ReplicatedStorage"):FindFirstChild("juisdfj0i32i0eidsuf0iok") then
      hiddenFling = true
    else
      local detection = Instance.new("Decal")
      detection.Name = "juisdfj0i32i0eidsuf0iok"
      detection.Parent = game:GetService("ReplicatedStorage")
    end

    local function fling()
      local hrp, c, vel, movel = nil, nil, nil, 0.1
      while true do
        game:GetService("RunService").Heartbeat:Wait()
        if hiddenFling then
          local lp = Players.LocalPlayer
          while hiddenFling and not (c and c.Parent and hrp and hrp.Parent) do
            game:GetService("RunService").Heartbeat:Wait()
            c = lp.Character
            hrp = c:FindFirstChild("HumanoidRootPart") or c:FindFirstChild("Torso") or c:FindFirstChild("UpperTorso")
          end
          if hiddenFling then
            vel = hrp.Velocity
            hrp.Velocity = vel * 10000 + Vector3.new(0, 10000, 0)
            game:GetService("RunService").RenderStepped:Wait()
            if c and c.Parent and hrp and hrp.Parent then
              hrp.Velocity = vel
            end
            game:GetService("RunService").Stepped:Wait()
            if c and c.Parent and hrp and hrp.Parent then
              hrp.Velocity = vel + Vector3.new(0, movel, 0)
              movel = movel * -1
            end
          end
        end
      end
    end

    fling()

    -- Perform the fling motion
    LocalPlayer.Character.Humanoid:SetStateEnabled("Seated", false)
    LocalPlayer.Character.Humanoid.Sit = true

    if Target == "all" or Target == "others" then
      for _, x in ipairs(Players:GetPlayers()) do
        for i = 1, 10 do
          wait(0.017)
          LocalPlayer.Character.HumanoidRootPart.CFrame = x.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 4)
          wait(0.01)
          LocalPlayer.Character.HumanoidRootPart.CFrame = x.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, -2)
          wait(0.01)
          LocalPlayer.Character.HumanoidRootPart.CFrame = x.Character.HumanoidRootPart.CFrame
          wait(0.01)
          LocalPlayer.Character.HumanoidRootPart.CFrame = x.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, -3)
          wait(0.01)
          LocalPlayer.Character.HumanoidRootPart.CFrame = x.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 2)
          wait(0.01)
          LocalPlayer.Character.HumanoidRootPart.CFrame = x.Character.HumanoidRootPart.CFrame
          wait(0.01)
          LocalPlayer.Character.HumanoidRootPart.CFrame = x.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, -1)
          wait(0.01)
          LocalPlayer.Character.HumanoidRootPart.CFrame = x.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, -1)
        end
      end
    else
      for i = 1, 10 do
        wait(0.017)
        LocalPlayer.Character.HumanoidRootPart.CFrame = Target.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 4)
        wait(0.01)
        LocalPlayer.Character.HumanoidRootPart.CFrame = Target.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, -2)
        wait(0.01)
        LocalPlayer.Character.HumanoidRootPart.CFrame = Target.Character.HumanoidRootPart.CFrame
        wait(0.01)
        LocalPlayer.Character.HumanoidRootPart.CFrame = Target.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, -3)
        wait(0.01)
        LocalPlayer.Character.HumanoidRootPart.CFrame = Target.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 2)
        wait(0.01)
        LocalPlayer.Character.HumanoidRootPart.CFrame = Target.Character.HumanoidRootPart.CFrame
        wait(0.01)
        LocalPlayer.Character.HumanoidRootPart.CFrame = Target.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, -1)
        wait(0.01)
        LocalPlayer.Character.HumanoidRootPart.CFrame = Target.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, -1)
      end
    end

    -- Reset the player's position after the fling
    wait(0.3)
    LocalPlayer.Character.HumanoidRootPart.CFrame = oldCFrame
    wait(0.13)
    LocalPlayer.Character.Humanoid:SetStateEnabled("Seated", true)
    LocalPlayer.Character.Humanoid.Sit = false
  end
}

-- Add the module to _G.Modules
_G.Modules = _G.Modules or {}
table.insert(_G.Modules, module)
