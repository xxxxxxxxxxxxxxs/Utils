local module = {}
module["Name"] = "Universal"
	
	local ts = game:GetService("TweenService")
	
	table.insert(module, {
		Type = "Text",
		Args = {"Welcome to YARHM! The open, free script hub."}
	})
	table.insert(module, {
		Type = "Button",
		Args = {"Join our Discord", function(Self)
			if setclipboard then setclipboard("https://discord.gg/2jbYxvDkxr") end
			fu.notification('Discord link has been copied to clipboard!')
		end,}
	})
	table.insert(module, {
		Type = "Text",
		Args = {"---"}
	})
	
	table.insert(module, {
		Type = "Input",
		Args = {"Hitbox expander", "Expand everyone's hitbox", function(Self, ToExpand)
			local players = game:GetService("Players"):GetPlayers()
			for i,v in ipairs(players) do
				if v ~= game.Players.LocalPlayer and v.Character:FindFirstChild('HumanoidRootPart') then
					local sizeArg = tonumber(ToExpand)
					local Size = Vector3.new(sizeArg,sizeArg,sizeArg)
					local Root = v.Character:FindFirstChild('HumanoidRootPart')
					if Root:IsA("BasePart") then
						if not ToExpand or sizeArg == 1 then
							Root.Size = Vector3.new(2,1,1)
							Root.Transparency = 0.2
						else
							Root.Size = Size
							Root.Transparency = 0.2
						end
						Root.CanCollide = false
					end
				end
			end
			fu.notification("Hitboxes expanded.")
		end,}
	})
	
	table.insert(module, {
		Type = "Input",
		Args = {"Walkspeed", "Set speed", function(Self, speed)
			local lp = game:GetService("Players").LocalPlayer
			local char = lp.Character
			if not char then fu.notification("No character!") return end
			local hu = char:FindFirstChildOfClass("Humanoid")
			if not hu then fu.notification("No humanoid on your character..?") return end
			hu.WalkSpeed = tonumber(speed) or 16
			fu.notification("Walkspeed set.")
			ws = tonumber(speed) or 16
		end,}
	})
	
	
	local walkspeedInDeCrement = 3
	table.insert(module, {
		Type = "Button",
		Args = {"Increase walkspeed", function(Self)
			local lp = game:GetService("Players").LocalPlayer
			local char = lp.Character
			if not char then fu.notification("No character!") return end
			local hu = char:FindFirstChildOfClass("Humanoid")
			if not hu then fu.notification("No humanoid on your character..?") return end
			ws = ws + walkspeedInDeCrement
			hu.WalkSpeed = hu.WalkSpeed + walkspeedInDeCrement
			fu.notification("Walkspeed is now ".. hu.WalkSpeed)
		end,}
	})
	
	table.insert(module, {
		Type = "Button",
		Args = {"Decrease walkspeed", function(Self)
			local lp = game:GetService("Players").LocalPlayer
			local char = lp.Character
			if not char then fu.notification("No character!") return end
			local hu = char:FindFirstChildOfClass("Humanoid")
			if not hu then fu.notification("No humanoid on your character..?") return end
			ws = ws - walkspeedInDeCrement
			hu.WalkSpeed = hu.WalkSpeed - walkspeedInDeCrement
			fu.notification("Walkspeed is now ".. hu.WalkSpeed)
		end,}
	})
	
	table.insert(module, {
		Type = "Input",
		Args = {"Walkspeed increment (How big each increase/decrease is)", "Set", function(Self, input)
			walkspeedInDeCrement = tonumber(input) or 3
			if not tonumber(input) then fu.notification("Not a number. Setting to default.") end
			fu.notification("Set walkspeed increment to ".. walkspeedInDeCrement)
		end,}
	})
	
	table.insert(module, {
		Type = "Input",
		Args = {"FOV change", "Set FOV", function(Self, tofov)
			if not tonumber(tofov) then fu.notification("Not a number. Setting to default.") end
			ts:Create(workspace.CurrentCamera, TweenInfo.new(1, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
				FieldOfView = tonumber(tofov) or 70
			}):Play()
			fov = tonumber(tofov) or 70
		end,}
	})
	
	table.insert(module, {
		Type = "Toggle",
		Args = {"Loop walkspeed and FOV", function(Self, state)
			loopfovandws = state
		end,}
	})
	
	
	if uis.KeyboardEnabled and uis.MouseEnabled then
		table.insert(module, {
			Type = "Toggle",
			Args = {"CTRL+Click Teleport", function(Self, state)
				ctrlclicktp = state
			end,}
		})
	end
	
	local spectateLoop = nil
	table.insert(module, {
		Type = "Button",
		Args = {"Spectate players", function(Self)
			local listofplayers = game.Players:GetPlayers()
			local currentlyViewing = 1
			local currentPlayer = listofplayers[currentlyViewing]
			if not currentPlayer then return end
			workspace.CurrentCamera.CameraSubject = currentPlayer.Character.Humanoid
			spectateLoop = task.spawn(function()
				while true do
					fu.dialog("Spectating...", "Now spectating: " .. workspace.CurrentCamera.CameraSubject.Parent.Name, {"Previous", "Stop", "Next"})
					local action = fu.waitfordialog()
					if action == "Stop" then
						fu.closedialog()
						workspace.CurrentCamera.CameraSubject = game.Players.LocalPlayer.Character.Humanoid
						task.cancel(spectateLoop)
						break
					elseif action == "Next" then
						currentlyViewing = currentlyViewing + 1
						if currentlyViewing > #listofplayers then
							currentlyViewing = 1
						end
						currentPlayer = listofplayers[currentlyViewing]
						if not currentPlayer then return end
						workspace.CurrentCamera.CameraSubject = currentPlayer.Character.Humanoid
					elseif action == "Previous" then
						currentlyViewing = currentlyViewing - 1
						if currentlyViewing < 1 then
							currentlyViewing = #listofplayers
						end
						currentPlayer = listofplayers[currentlyViewing]
						if not currentPlayer then return end
						workspace.CurrentCamera.CameraSubject = currentPlayer.Character.Humanoid
					end
				end
				
			end)
		end,}
	})
	
	table.insert(module, {
		Type = "Text",
		Args = {"Miscellaneous"}
	})
	
	
	local playerToFling = "None"
	--table.insert(module, {
	--	Type = "Dropdown",
	--	Args = {"Player to fling", function()
	--		local playersAsStrings = {"None"}
	--		for _, p in ipairs(game.Players:GetPlayers()) do
	--			table.insert(playersAsStrings, p.Name)
	--		end
	--		return playersAsStrings
	--	end,
		
	--	function(Self, selected)
	--		print(selected)
	--	end,}
	--})
	
	table.insert(module, {
		Type = "Button",
		Args = {"Hide YARHM", function(Self)
			if uis.KeyboardEnabled then
				ts:Create(script.Parent.Menu.UIScale, TweenInfo.new(0.6, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
					Scale = 0
				}):Play()
				hidden=true
				fu.notification("Press CTRL+Y to bring back the menu.")
			elseif uis.AccelerometerEnabled then
				ts:Create(script.Parent.Menu.UIScale, TweenInfo.new(0.6, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
					Scale = 0
				}):Play()
				hidden=true
				fu.notification("Shake your device to bring back the menu.")
			else
				fu.notification("Can't hide YARHM!") -- how else are you gonna open???
			end
		end,}
	}
	)
	
	table.insert(module, {
		Type = "Button",
		Args = {"FPS Boost", function(Self)
			fu.dialog("FPS boosting", "FPS boosting can have unpredictable effects. You may instead lag more using this!", {"FPS boost anyway", "Nevermind"})
			local result = fu.waitfordialog()
			fu.closedialog()
			if result == "FPS boost anyway" then
				local Terrain = workspace:FindFirstChildOfClass('Terrain')
				Terrain.WaterWaveSize = 0
				Terrain.WaterWaveSpeed = 0
				Terrain.WaterReflectance = 0
				Terrain.WaterTransparency = 0
				game.Lighting.GlobalShadows = false
				game.Lighting.FogEnd = 9e9
				pcall(function()
					settings().Rendering.QualityLevel = 1
				end)
				for i,v in pairs(game:GetDescendants()) do
					if v:IsA("Part") or v:IsA("UnionOperation") or v:IsA("MeshPart") or v:IsA("CornerWedgePart") or v:IsA("TrussPart") then
						v.Material = "Plastic"
						v.Reflectance = 0
					elseif v:IsA("Decal") then
						v.Transparency = 1
					elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
						v.Lifetime = NumberRange.new(0)
					elseif v:IsA("Explosion") then
						v.BlastPressure = 1
						v.BlastRadius = 1
					end
				end
				for i,v in pairs(game.Lighting:GetDescendants()) do
					if v:IsA("BlurEffect") or v:IsA("SunRaysEffect") or v:IsA("ColorCorrectionEffect") or v:IsA("BloomEffect") or v:IsA("DepthOfFieldEffect") then
						v.Enabled = false
					end
				end
				workspace.DescendantAdded:Connect(function(child)
					task.spawn(function()
						if child:IsA('ForceField') then
							rs.Heartbeat:Wait()
							child:Destroy()
						elseif child:IsA('Sparkles') then
							rs.Heartbeat:Wait()
							child:Destroy()
						elseif child:IsA('Smoke') or child:IsA('Fire') then
							rs.Heartbeat:Wait()
							child:Destroy()
						end
					end)
				end)
			end
		end,}
	})
	
	local rsloopconnectionfling
	local clip = true
	local nocliploop
	
	
	table.insert(module, {
		Type = "ButtonGrid",
		Args = {2, {
			Noclip = function()
				clip = false
				nocliploop = rs.Stepped:Connect(function()
					if clip == false and game.Players.LocalPlayer.Character ~= nil then
						for _, child in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
							if child:IsA("BasePart") and child.CanCollide == true then
								child.CanCollide = false
							end
						end
					end
				end)
			end,
			
			Reclip = function()
				if clip then return end
				clip = true
				nocliploop:Disconnect()
				fu.notification("Reclipping may need you to reset your character.")
			end,
		}}})
	
	table.insert(module, {
		Type = "ButtonGrid",
		Args = {2, {
			
			Fling = function(Self)
				local bav = Instance.new("BodyAngularVelocity")
				bav.AngularVelocity = Vector3.new(0,99999,0)
				bav.MaxTorque = Vector3.new(0,math.huge,0)
				bav.P = math.huge
				bav.Parent = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
				if game.Players:FindFirstChild(playerToFling) then
					rs.PreSimulation:Connect(function()
						-- Repeatedly place localplayer character to the player to fling
						game.Players.LocalPlayer.Character:SetPrimaryPartCFrame(game.Players:FindFirstChild(playerToFling).Character.PrimaryPart.CFrame)
					end)
				end
			end,
			
			Stop_Fling = function(Self)
				if game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart"):FindFirstChild("BodyAngularVelocity") then
					game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart"):FindFirstChild("BodyAngularVelocity"):Destroy()
				end
			end,
			}
		}
	})
	
	
	
	table.insert(module, {
		Type = "Button",
		Args = {"Open developer console (debugging)", function(Self)
			game.StarterGui:SetCore("DevConsoleVisible", true)
			--_G.YARHM.Open.UIStroke.Transparency = 0
			--_G.YARHM.Open.TextTransparency = 0
			--ts:Create(_G.YARHM.Open, TweenInfo.new(1, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
			--	Position = UDim2.fromScale(0.5, 0.903)
			--}):Play()
	
			--ts:Create(_G.YARHM.Open.UIStroke, TweenInfo.new(1), {
			--	Transparency = 1
			--}):Play()
			--ts:Create(_G.YARHM.Open, TweenInfo.new(1), {
			--	TextTransparency = 1
			--}):Play()
		end}
	}
	)
	
	--table.insert(module, {
	--	Type = "Button",
	--	Args = {"SELF-DESTRUCT", function(Self)
	--		fu.notification("See you later!")
	--		task.wait(1.5)
	--		script.Parent:Destroy() -- Scary!
	--	end}
	--}
	--)
	--	Type = "Button",
	--	Args = {"Move YARHM trigger to the top", function(Self)
	--		_G.YARHM.Open.UIStroke.Transparency = 0
	--		_G.YARHM.Open.TextTransparency = 0
	--		ts:Create(_G.YARHM.Open, TweenInfo.new(1, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
	--			Position = UDim2.fromScale(0.5, 0.063)
	--		}):Play()
	
	--		ts:Create(_G.YARHM.Open.UIStroke, TweenInfo.new(1), {
	--			Transparency = 1
	--		}):Play()
	--		ts:Create(_G.YARHM.Open, TweenInfo.new(1), {
	--			TextTransparency = 1
	--		}):Play()
	--	end}
	--}
	
	_G.Modules[1] = module
return module
