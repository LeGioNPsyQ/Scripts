local Player, Rayfield, Click, comma, Notify, CreateWindow, CurrentVersion = loadstring(game:HttpGet("https://raw.githubusercontent.com/alyssagithub/Scripts/main/Inferno%20X%20Scripts/Variables.lua"))()

CurrentVersion("v1.12.10")

local virtualInput = game:GetService("VirtualInputManager")

local ChestTeleporting

local Mob1

local Islands = {}
local Interactions = {}
local Quests = {}
local Mobs = {"Closest Mob", "None", "SEA KING", "SEA BEAST"}
local Players = {}
local SelectedMobs = {}

for i,v in pairs(game:GetService("Workspace")["__GAME"]["__SpawnLocations"]:GetChildren()) do
	table.insert(Islands, v.Name)
end

for i,v in pairs(game:GetService("Workspace")["__GAME"]["__Interactions"]:GetChildren()) do
	if not table.find(Interactions, v.Name) then
		table.insert(Interactions, v.Name)
	end
end

for i,v in pairs(game:GetService("Workspace")["__GAME"]["__Quests"]:GetChildren()) do
	table.insert(Quests, v.Head.Icon.TextLabel.Text:split("QUEST ")[2])
end

for i,v in pairs(game:GetService("Workspace")["__GAME"]["__Mobs"]:GetDescendants()) do
	if v:IsA("Model") and v:FindFirstChild("NpcHealth") and not table.find(Mobs, v.NpcHealth.ViewerFrame.TName.Text) then
		table.insert(Mobs, v.NpcHealth.ViewerFrame.TName.Text)
	elseif v:IsA("Model") and v:FindFirstChild("Wyoru") then
		table.insert(Mobs, "Great Gorilla King.")
	end
end

for e,r in pairs(game:GetService("Workspace")["__GAME"]["__Mobs"]:GetChildren()) do
	if not r.Name:match("__") then
		local ExistingOfMob = {}
		local CurrentNumber = 0
		local BestMob

		for i,v in pairs(r:GetChildren()) do
			if v:FindFirstChild("NpcHealth") and not ExistingOfMob[v.NpcHealth.ViewerFrame.TName.Text] then
				ExistingOfMob[v.NpcHealth.ViewerFrame.TName.Text] = 1
			elseif v:FindFirstChild("NpcHealth") then
				ExistingOfMob[v.NpcHealth.ViewerFrame.TName.Text] = ExistingOfMob[v.NpcHealth.ViewerFrame.TName.Text] + 1
			end
		end

		for i,v in pairs(ExistingOfMob) do
			if v > CurrentNumber then
				CurrentNumber = v
				BestMob = i
			end
		end

		if BestMob and not table.find(Mobs, r.Name.." ("..BestMob.."'s Island)") then
			table.insert(Mobs, r.Name.." ("..BestMob.."'s Island)")
		end
	end
end

for i,v in pairs(game:GetService("Players"):GetPlayers()) do
	if v and v ~= Player then
		table.insert(Players, (v.DisplayName ~= v.Name and v.DisplayName.." (@"..v.Name..")" or v.Name))
	end
end

task.spawn(function()
	while task.wait() do
		local Depth = game:GetService("Lighting"):FindFirstChildWhichIsA("DepthOfFieldEffect")
		if Depth then
			Depth:Destroy()
		end
	end
end)

Player:WaitForChild("PlayerGui"):WaitForChild("Menu"):WaitForChild("FramesBackground"):WaitForChild("Configs").Visible = false

local JebusPart = Instance.new("Part")
JebusPart.Anchored = true
JebusPart.Size = game:GetService("Workspace")["__GAME"]["__Ocean"].MovelOcean.Size + Vector3.new(0, 4, 0)
JebusPart.Position = game:GetService("Workspace")["__GAME"]["__Ocean"].MovelOcean.Position
JebusPart.CanCollide = false
JebusPart.Name = "Jebus"
JebusPart.Transparency = 1
JebusPart.Parent = game:GetService("Workspace")["__GAME"]["__Ocean"].Water

game:GetService("Workspace")["__GAME"]["__Ocean"].MovelOcean:GetPropertyChangedSignal("Position"):Connect(function()
	JebusPart.Position = game:GetService("Workspace")["__GAME"]["__Ocean"].MovelOcean.Position
end)

local Window = CreateWindow()

local Main = Window:CreateTab("Main", 4483362458)

Main:CreateSection("Weapons")

local Dead = false

Player.Character:WaitForChild("Humanoid").Died:Connect(function()
	Dead = true
	if Player.Character:FindFirstChildOfClass("Tool") then
		for i,Tool in pairs(Player.Character:GetChildren()) do
			if Tool:IsA("Tool") then
				Tool.Parent = Player.Backpack
			end
		end
	end
	Player.CharacterAdded:Wait()
	Dead = false
end)

local EquippedTool

Main:CreateToggle({
	Name = "🛠 Auto Re-Equip Tool",
	Info = "Automatically re-equips the tool you have equipped when this is enabled",
	CurrentValue = false,
	Flag = "EquipTools",
	Callback = function(Value)
		if Value then
			EquippedTool = Player.Character:FindFirstChildOfClass("Tool").Name
		else
			EquippedTool = nil
		end
	end,
})

task.spawn(function()
	while task.wait() do
		if Rayfield.Flags.EquipTools.CurrentValue and not Dead and EquippedTool and not Player.Character:FindFirstChild(EquippedTool) and Player.Backpack:FindFirstChild(EquippedTool) then
			Player.Backpack:FindFirstChild(EquippedTool).Parent = Player.Character
		end
	end
end)

Main:CreateToggle({
	Name = "⚔ Auto Train",
	Info = "Automatically trains with your current items",
	CurrentValue = false,
	Flag = "AutoTrain",
	Callback = function(Value) end,
})

task.spawn(function()
	while task.wait() do
		if Rayfield.Flags.AutoTrain.CurrentValue and Player.Backpack:FindFirstChildOfClass("Tool") and not Dead then
			local Tool2 = Player.Character:FindFirstChildOfClass("Tool")
			if Tool2 and Player.Character:FindFirstChild("HumanoidRootPart") then
				require(game:GetService("ReplicatedStorage").SharedModules.Controllers.ToolController).UseTool("Combat", Enum.UserInputState.Begin)
			else
				for i,Tool in pairs(Player.Backpack:GetChildren()) do
					if Tool.Parent == Player.Backpack and Player.Character:FindFirstChild("HumanoidRootPart") then
						Tool.Parent = Player.Character
						require(game:GetService("ReplicatedStorage").SharedModules.Controllers.ToolController).UseTool("Combat", Enum.UserInputState.Begin)
						task.wait(.1)
						if Tool.Parent == Player.Character then
							Tool.Parent = Player.Backpack
						end
					end
				end
			end
		end
	end
end)

local AutoSkillsToggle = Main:CreateToggle({
	Name = "💨 Auto Skills",
	Info = "Automatically uses your weapon(s)' skills (Z-B)",
	CurrentValue = false,
	Flag = "AutoSkills",
	Callback = function(Value) end,
})

task.spawn(function()
	while task.wait() do
		if Rayfield.Flags.AutoSkills.CurrentValue and Player.Character:FindFirstChildOfClass("Tool") then
			for _,r in pairs(Player.Character:GetChildren()) do
				if r:IsA("Tool") and r.Name ~= "Defence" then
					for i,v in pairs({"Z", "X", "C", "V", "B"}) do
						if Player.Character:FindFirstChild("HumanoidRootPart") then
							virtualInput:SendKeyEvent(true, v, false, nil)
							virtualInput:SendKeyEvent(false, v, false, nil)
							task.wait(.1)
						end
					end
				end
			end
		end
	end
end)

Main:CreateSection("Collecting")

Main:CreateToggle({
	Name = "💼 Auto Collect Chests",
	Info = "Automatically collects chests that spawn",
	CurrentValue = false,
	Flag = "AutoChests",
	Callback = function(Value)	end,
})

task.spawn(function()
	while task.wait() do
		if Rayfield.Flags.AutoChests.CurrentValue then
			for i,v in pairs(game:GetService("Workspace"):GetChildren()) do
				if v:GetAttribute("Type") and v:FindFirstChild("ChestInteract") then
					ChestTeleporting = true
					local SavedPosition = Player.Character:WaitForChild("HumanoidRootPart").CFrame
					task.wait()
					Player.Character:WaitForChild("HumanoidRootPart").CFrame = v.PrimaryPart.CFrame
					task.wait(Rayfield.Flags.CollectDelay.CurrentValue)
					if v:FindFirstChild("ChestInteract") then
						fireproximityprompt(v.ChestInteract)
					end
					Player.Character:WaitForChild("HumanoidRootPart").CFrame = SavedPosition
					ChestTeleporting = false
				end
			end
		end
	end
end)

Main:CreateToggle({
	Name = "🥭 Auto Collect Fruit",
	Info = "Automatically collects fruit that spawn",
	CurrentValue = false,
	Flag = "AutoFruit",
	Callback = function(Value)	end,
})

task.spawn(function()
	while task.wait() do
		if Rayfield.Flags.AutoFruit.CurrentValue then
			for i,v in pairs(game:GetService("Workspace"):GetChildren()) do
				if v:FindFirstChild("Eat") or (not v:IsA("Folder") and v.Name:lower():match("fruit")) then
					local PreviousPosition = Player.Character.HumanoidRootPart.CFrame
					repeat
						game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v:FindFirstChildWhichIsA("BasePart").CFrame
						if fireproximityprompt then
							fireproximityprompt(v.Eat)
						else
							virtualInput:SendKeyEvent(true, tostring(v.Eat.KeyboardKeyCode), false, nil)
							task.wait(v.Eat.HoldDuration + 1)
							virtualInput:SendKeyEvent(false, tostring(v.Eat.KeyboardKeyCode), false, nil)
						end
						task.wait()
					until not v or not v:FindFirstChild("Eat") or not Rayfield.Flags.AutoFruit.CurrentValue
					Player.Character.HumanoidRootPart.CFrame = PreviousPosition
				end
			end
		end
	end
end)

Main:CreateToggle({
	Name = "🎁 Auto Collect Gifts",
	Info = "Automatically collects gifts that spawn",
	CurrentValue = false,
	Flag = "AutoGift",
	Callback = function(Value)	end,
})

task.spawn(function()
	while task.wait() do
		if Rayfield.Flags.AutoGift.CurrentValue then
			for i,v in pairs(game:GetService("Workspace"):GetChildren()) do
				if v.Name == "GiftModel" and v:FindFirstChild("ChestInteract") then
					ChestTeleporting = true
					local SavedPosition = Player.Character:WaitForChild("HumanoidRootPart").CFrame
					task.wait()
					Player.Character:WaitForChild("HumanoidRootPart").CFrame = v.Model:FindFirstChildWhichIsA("BasePart").CFrame
					task.wait(Rayfield.Flags.CollectDelay.CurrentValue)
					if v:FindFirstChild("ChestInteract") then
						fireproximityprompt(v.ChestInteract)
					end
					Player.Character:WaitForChild("HumanoidRootPart").CFrame = SavedPosition
					ChestTeleporting = false
				end
			end
		end
	end
end)

Main:CreateSlider({
	Name = "🐌 Collect Delay",
	Range = {1.5, 5},
	Increment = .1,
	Suffix = "Seconds",
	CurrentValue = 2.5,
	Flag = "CollectDelay",
	Callback = function(Value)	end,
})

Main:CreateToggle({
	Name = "✅ Remove Name Tag",
	Info = "Removes your name tag from others and yourself",
	CurrentValue = false,
	Flag = "RemoveNameTag",
	Callback = function(Value)	end,
})

task.spawn(function()
	while task.wait() do
		if Rayfield.Flags.RemoveNameTag.CurrentValue and Player.Character:WaitForChild("Head"):FindFirstChild("PlayerHealth") then
			for i,v in pairs(Player.Character:GetDescendants())do
				if v:IsA("BillboardGui") or v:IsA("SurfaceGui") then
					v:Destroy()
				end
			end
		end
	end
end)

Main:CreateSection("Performance")

Main:CreateToggle({
	Name = "💥 Disable Effects",
	Info = "Disable effects from skills (must rejoin to reverse)",
	CurrentValue = false,
	Flag = "DisableEffects",
	Callback = function(Value) end,
})

task.spawn(function()
	while task.wait() do
		if Rayfield.Flags.DisableEffects.CurrentValue and #game:GetService("ReplicatedStorage").Game["__Extra"].Modules.Skills:GetChildren() > 0 then
			for i,v in pairs(game:GetService("ReplicatedStorage").Game["__Extra"].Modules.Skills:GetChildren()) do
				v:Destroy()
			end

			for i,v in pairs(game:GetService("ReplicatedStorage").Game["__SkillsModules"]:GetChildren()) do
				v:Destroy()
			end
		end
	end
end)

Main:CreateButton({
	Name = "🐛 Load Island Mobs",
	Callback = function()
		local ReturnPosition = Player.Character.HumanoidRootPart.CFrame

		for i,v in pairs(Islands) do
			Player.Character.HumanoidRootPart.CFrame = game:GetService("Workspace")["__GAME"]["__SpawnLocations"]:FindFirstChild(v).CFrame
			task.wait(1.5)
		end

		Player.Character.HumanoidRootPart.CFrame = ReturnPosition
	end,
})

local Misc = Window:CreateTab("Misc", 4483362458)

Misc:CreateSection("Mob Teleports")

local MobLabel = Misc:CreateLabel("Selected Mobs:")

Mob1 = Misc:CreateDropdown({
	Name = "👾 Mob",
	Options = Mobs,
	CurrentOption = "None",
	--Flag = "SelectedMob",
	Callback = function(Option)
		if table.find(SelectedMobs, Option) then
			table.remove(SelectedMobs, table.find(SelectedMobs, Option))
		else
			table.insert(SelectedMobs, Option)
		end
		pcall(function()
			Mob1:Set("")
			MobLabel:Set("Selected Mobs: "..table.concat(SelectedMobs, ", "))
		end)
	end,
})

game:GetService("Workspace")["__GAME"]["__Mobs"].ChildAdded:Connect(function(Child)
	if Child:IsA("Folder") then
		local ExistingOfMob = {}
		local CurrentNumber = 0
		local BestMob

		for i,v in pairs(Child:GetChildren()) do
			if v:FindFirstChild("NpcHealth") and not ExistingOfMob[v.NpcHealth.ViewerFrame.TName.Text] then
				ExistingOfMob[v.NpcHealth.ViewerFrame.TName.Text] = 1
			elseif v:FindFirstChild("NpcHealth") then
				ExistingOfMob[v.NpcHealth.ViewerFrame.TName.Text] = ExistingOfMob[v.NpcHealth.ViewerFrame.TName.Text] + 1
			end
		end

		for i,v in pairs(ExistingOfMob) do
			if v > CurrentNumber then
				CurrentNumber = v
				BestMob = i
			end
		end

		if BestMob and not table.find(Mobs, Child.Name.." ("..BestMob.."'s Island)" ) then
			Mob1:Add(Child.Name.." ("..BestMob.."'s Island)")
		end

		Child.ChildAdded:Connect(function(Descendant)
			if Descendant:IsA("Model") and not table.find(Mobs, Descendant:WaitForChild("NpcHealth"):WaitForChild("ViewerFrame"):WaitForChild("TName").Text) then
				table.insert(Mobs, Descendant:WaitForChild("NpcHealth"):WaitForChild("ViewerFrame"):WaitForChild("TName").Text)
				Mob1:Add(Descendant:WaitForChild("NpcHealth"):WaitForChild("ViewerFrame"):WaitForChild("TName").Text)
			end
		end)

		for i,v in pairs(Child:GetChildren()) do
			if v:FindFirstChild("NpcHealth") and not table.find(Mobs, v.NpcHealth.ViewerFrame.TName.Text) then
				table.insert(Mobs, v.NpcHealth.ViewerFrame.TName.Text)
				Mob1:Add(v.NpcHealth.ViewerFrame.TName.Text)
			end
		end
	end
end)

Misc:CreateToggle({
	Name = "⚡ Teleport to Mob",
	CurrentValue = false,
	Flag = "MobTeleport",
	Callback = function(Value) end,
})

task.spawn(function()
	while task.wait() do
		if Rayfield.Flags.MobTeleport.CurrentValue and #SelectedMobs > 0 and not ChestTeleporting then
			for t,b in pairs(SelectedMobs) do
				local CurrentNumber = math.huge
				local Mob

				for i,v in pairs(game:GetService("Workspace")["__GAME"]["__Mobs"]:GetDescendants()) do
					if v:IsA("Model") and v.Name == "NpcModel" and v.Parent:FindFirstChild("NpcHealth") and v.Parent.NpcHealth.ViewerFrame.Frame.HealthText.Text:split("/")[1] ~= "0" and Player.Character:FindFirstChild("HumanoidRootPart") then
						local Magnitude = (Player.Character.HumanoidRootPart.Position - v.HumanoidRootPart.Position).Magnitude

						if (v.Parent.NpcHealth.ViewerFrame.TName.Text == b or b == "Closest Mob" or (b:match("_") and v.Parent.Parent.Name == b:split(" ")[1])) then
							CurrentNumber = Magnitude
							Mob = v.HumanoidRootPart
						elseif (v.Parent.NpcHealth.ViewerFrame.TName.Text == b or b == "Closest Mob" or (b:match("_") and v.Parent.Parent.Name == b:split(" ")[1])) and Magnitude < CurrentNumber then
							CurrentNumber = Magnitude
							Mob = v.HumanoidRootPart
						end
					end
				end

				if Mob and not ChestTeleporting then
					Player.Character.HumanoidRootPart.CFrame = Mob.CFrame + Vector3.new(0, Rayfield.Flags.YOffset.CurrentValue, 0) + Mob.CFrame.LookVector * Rayfield.Flags.LookVector.CurrentValue
					break
				end
			end
		end
	end
end)

Misc:CreateSlider({
	Name = "LookVector Offset",
	Info = "Changes the LookVector Offset (how far you are away)",
	Range = {-50, 50},
	Increment = .1,
	Suffix = "",
	CurrentValue = -14,
	Flag = "LookVector",
	Callback = function(Value) end,
})

Misc:CreateSlider({
	Name = "Y Offset",
	Info = "Changes the Y Offset (how high you are)",
	Range = {-50, 50},
	Increment = .1,
	Suffix = "",
	CurrentValue = 0,
	Flag = "YOffset",
	Callback = function(Value) end,
})

Misc:CreateSection("Area Teleports")

Misc:CreateDropdown({
	Name = "🏝 Teleport to Island",
	Options = Islands,
	CurrentOption = "",
	--Flag = "SelectedIsland",
	Callback = function(Option)
		Player.Character.HumanoidRootPart.CFrame = game:GetService("Workspace")["__GAME"]["__SpawnLocations"]:FindFirstChild(Option).CFrame
	end,
})

Misc:CreateDropdown({
	Name = "🛡 Teleport to Interaction",
	Options = Interactions,
	CurrentOption = "",
	--Flag = "SelectedInteraction",
	Callback = function(Option)
		Player.Character.HumanoidRootPart.CFrame = game:GetService("Workspace")["__GAME"]["__Interactions"]:FindFirstChild(Option).PrimaryPart.CFrame
	end,
})

Misc:CreateSection("Quests")

Misc:CreateDropdown({
	Name = "📰 Quest",
	Options = Quests,
	CurrentOption = "",
	Flag = "SelectedQuest",
	Callback = function(Option) end,
})

Misc:CreateToggle({
	Name = "📜 Auto Start Quest",
	CurrentValue = false,
	Flag = "Quest",
	Callback = function(Value) end,
})

task.spawn(function()
	while task.wait() do
		if Rayfield.Flags.Quest.CurrentValue and Rayfield.Flags.SelectedQuest.CurrentOption ~= "" and tostring(Player.PlayerGui.Quests.CurrentQuestContainer.Position):split(",")[1] == "{1.5" and Player.Character:FindFirstChild("HumanoidRootPart") then
			for i,v in pairs(game:GetService("Workspace")["__GAME"]["__Quests"]:GetChildren()) do
				if v.Head.Icon.TextLabel.Text:split("QUEST ")[2] == Rayfield.Flags.SelectedQuest.CurrentOption then
					local PreviousPosition = Player.Character:WaitForChild("HumanoidRootPart").CFrame
					repeat
						Player.Character:WaitForChild("HumanoidRootPart").CFrame = v.HumanoidRootPart.CFrame
						task.wait()
						if fireproximityprompt then
							fireproximityprompt(v.Interact)
						else
							virtualInput:SendKeyEvent(true, tostring(v.Interact.KeyboardKeyCode), false, nil)
							task.wait(v.Interact.HoldDuration + 1)
							virtualInput:SendKeyEvent(false, tostring(v.Interact.KeyboardKeyCode), false, nil)
						end
					until Player.PlayerGui.Quests.Container.Visible or not Player.Character:FindFirstChild("HumanoidRootPart") or not Rayfield.Flags.Quest.CurrentValue

					if firesignal then
						firesignal(Player.PlayerGui.Quests.Container.Accept.Click.Activated)
					else
						Click(Player.PlayerGui.Quests.Container.Accept.Click)
					end

					Player.Character:WaitForChild("HumanoidRootPart").CFrame = PreviousPosition
					break
				end
			end
		end
	end
end)

Misc:CreateSection("Other")

Misc:CreateToggle({
	Name = "🍐 Auto Store Fruit",
	CurrentValue = false,
	Flag = "StoreFruit",
	Callback = function(Value) end,
})

task.spawn(function()
	while task.wait() do
		if Rayfield.Flags.StoreFruit.CurrentValue then
			for i,v in pairs(Player.Backpack:GetChildren()) do
				if v.Name:lower():match("fruit") and v:FindFirstChildWhichIsA("BasePart") then
					v.Parent = Player.Character
					if firesignal then
						firesignal(Player.PlayerGui.HUD.Background.StorageButton.Click.Activated)
					else
						Click(Player.PlayerGui.HUD.Background.StorageButton.Click)
					end
				end
			end
		end
	end
end)

Misc:CreateToggle({
	Name = "🔥 Auto Enable Haki",
	CurrentValue = false,
	Flag = "Haki",
	Callback = function(Value) end,
})

task.spawn(function()
	while task.wait() do
		if Rayfield.Flags.Haki.CurrentValue and (not Player.Character:FindFirstChild("BusoH") or Player.Character:FindFirstChild("BusoH"):FindFirstChildWhichIsA("BasePart").Transparency ~= 0) then
			virtualInput:SendKeyEvent(true, "T", false, nil)
			virtualInput:SendKeyEvent(false, "T", false, nil)
			virtualInput:SendKeyEvent(true, "R", false, nil)
			virtualInput:SendKeyEvent(false, "R", false, nil)
		end
	end
end)

Misc:CreateToggle({
	Name = "🌊 Jebus",
	Info = "Allows you to walk on water",
	CurrentValue = false,
	Flag = "Jebus",
	Callback = function(Value)
		JebusPart.CanCollide = Value
	end,
})

local Combat = Window:CreateTab("Combat", 4483362458)

local PlayerDropdown = Combat:CreateDropdown({
	Name = "😎 Player",
	Options = Players,
	CurrentOption = "",
	Flag = "SelectedPlayer",
	Callback = function(Option) end,
})

game:GetService("Players").PlayerAdded:Connect(function(PlayerAdded)
	PlayerDropdown:Add((PlayerAdded.DisplayName ~= PlayerAdded.Name and PlayerAdded.DisplayName.." (@"..PlayerAdded.Name..")" or PlayerAdded.Name))
end)

game:GetService("Players").PlayerRemoving:Connect(function(PlayerAdded)
	PlayerDropdown:Remove((PlayerAdded.DisplayName ~= PlayerAdded.Name and PlayerAdded.DisplayName.." (@"..PlayerAdded.Name..")" or PlayerAdded.Name))
end)

Combat:CreateToggle({
	Name = "💰 Select Highest Bounty Player",
	CurrentValue = false,
	Flag = "Bounty",
	Callback = function(Value) end,
})

task.spawn(function()
	while task.wait() do
		if Rayfield.Flags.Bounty.CurrentValue then
			local CurrentNumber = 0
			local HighestBounty

			for i,v in pairs(game:GetService("Players"):GetPlayers()) do
				if v and v ~= Player and v:FindFirstChild("leaderstats") and v.leaderstats.Bounty.Value > CurrentNumber then
					CurrentNumber = v.leaderstats.Bounty.Value
					HighestBounty = v
				end
			end

			if HighestBounty and Rayfield.Flags.SelectedPlayer.CurrentOption ~= (HighestBounty.DisplayName ~= HighestBounty.Name and HighestBounty.DisplayName.." (@"..HighestBounty.Name..")" or HighestBounty.Name) then
				PlayerDropdown:Set((HighestBounty.DisplayName ~= HighestBounty.Name and HighestBounty.DisplayName.." (@"..HighestBounty.Name..")" or HighestBounty.Name))
			end
		end
	end
end)

Combat:CreateToggle({
	Name = "⚪ Teleport to Player",
	Info = "Constantly teleports to the selected player",
	CurrentValue = false,
	Flag = "Teleport",
	Callback = function(Value) end,
})

task.spawn(function()
	while task.wait() do
		if Rayfield.Flags.Teleport.CurrentValue then
			local CurrentPlayer = game:GetService("Players"):FindFirstChild(Rayfield.Flags.SelectedPlayer.CurrentOption) or game:GetService("Players"):FindFirstChild(Rayfield.Flags.SelectedPlayer.CurrentOption:split("@")[2]:split(")")[1])
			if CurrentPlayer then
				Player.Character:WaitForChild("HumanoidRootPart").CFrame = CurrentPlayer.Character:WaitForChild("HumanoidRootPart").CFrame
			end
		end
	end
end)

Combat:CreateToggle({
	Name = "⭕ Killaura",
	Info = "Enables/Disables Auto Skills if killaura distance is met (non-safezone)",
	CurrentValue = false,
	Flag = "Killaura",
	Callback = function(Value) end,
})

task.spawn(function()
	while task.wait() do
		if Rayfield.Flags.Killaura.CurrentValue and not Player.PlayerGui.HUD.Background.Safe.Visible then
			local IsPlayer = false

			for i,v in pairs(game:GetService("Players"):GetPlayers()) do
				if v and v ~= Player and v.Character and (v.Character:WaitForChild("HumanoidRootPart").Position - Player.Character:WaitForChild("HumanoidRootPart").Position).Magnitude <= Rayfield.Flags.KillauraDistance.CurrentValue then
					IsPlayer = true
				end
			end

			if not IsPlayer and Rayfield.Flags.AutoSkills.CurrentValue then
				AutoSkillsToggle:Set(false)
			elseif IsPlayer and not Rayfield.Flags.AutoSkills.CurrentValue then
				AutoSkillsToggle:Set(true)
			end
		end
	end
end)

Combat:CreateSlider({
	Name = "🔢 Killaura Distance",
	Range = {0, 100},
	Increment = 1,
	Suffix = "Studs",
	CurrentValue = 30,
	Flag = "KillauraDistance",
	Callback = function(Value)	end,
})