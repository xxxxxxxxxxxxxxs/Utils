local module = {}
module["gameId"] = 0 -- Restrict module to a certain game ID only. 0 allows all games

module["Name"] = "Warp Module"

local warps = {}

local function setWarp(name)
    local player = game.Players.LocalPlayer
    local character = player.Character
    if character and character:FindFirstChild("HumanoidRootPart") then
        warps[name] = character.HumanoidRootPart.CFrame
        print("Warp '" .. name .. "' set.")
    else
        print("Error: Could not set warp. Player or HumanoidRootPart not found.")
    end
end

local function gotoWarp(name)
    local player = game.Players.LocalPlayer
    local character = player.Character
    if character and character:FindFirstChild("HumanoidRootPart") then
        if warps[name] then
            character.HumanoidRootPart.CFrame = warps[name]
            print("Teleported to warp '" .. name .. "'.")
        else
            print("Error: Warp '" .. name .. "' not found.")
        end
    else
        print("Error: Could not teleport. Player or HumanoidRootPart not found.")
    end
end

module[1] = {
  Type = "Input",
  Args = {"Enter warp name", "Set Warp", function(Self, text) -- text is the Input's value
      setWarp(text)
    end
  }
}

module[2] = {
  Type = "Input",
  Args = {"Enter warp name", "Go to Warp", function(Self, text) -- text is the Input's value
      gotoWarp(text)
    end
  }
}

_G.Modules[#_G.Modules + 1] = module
