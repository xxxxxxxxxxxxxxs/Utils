local module = {}
module["gameId"] = 0 -- Restrict module to a certain game ID only. 0 allows all games

module["Name"] = "Module name"

module[1] = { -- Each component is their own object in the module, for this one it's the first component
  Type = "Text",
  Args = {"Shows a simple text"},
}

module[2] = {
  Type = "Button",
  Args = {"The button's text", function(Self) -- Self is the button's TextButton object, can be used for effects, changing the text, etc
      print("This is the callback of the button, ran whenever the button is clicked")
    end,}
}

module[3] = {
  Type = "ButtonGrid", -- A grid of buttons with customizable column count
  Toggleable = false, -- Recolors buttons for you onclick, you still need to save the state yourself. This isn't on the normal button because god knows why but you can use a column of 1?
  Args = {3, { -- 3 is the number of columns
      ButtonName = function(Self)
        print("ButtonName is the displayed text for that button, this is it's callback, similar to the normal button")
      end,
      Second_Button_Name = function(Self)
        print("A second button, should appear next to the first button. Give the key name underscores and it'll be replaced with spaces")
      end,
    }
  }
}

module[4] = {
  Type = "Input",
  Args = {"The input's placeholder text", "The button next to the input's text", function(Self, text) -- text is the Input's value
      print(text)
    end
  }
}

module[5] = {
  Type = "Toggle", -- A switch that has two states, on (true) or off (false)
  Args = {"The toggle's text next to the switch", function(Self, state) -- state is the Toggle's state
      print(state)
    end
  }
}

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

module[6] = {
  Type = "Input",
  Args = {"Enter warp name", "Set Warp", function(Self, text) -- text is the Input's value
      setWarp(text)
    end
  }
}

module[7] = {
  Type = "Input",
  Args = {"Enter warp name", "Go to Warp", function(Self, text) -- text is the Input's value
      gotoWarp(text)
    end
  }
}

_G.Modules[#_G.Modules + 1] = module

