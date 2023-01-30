local Player, Rayfield, Click, comma, Notify, CreateWindow, CurrentVersion = loadstring(game:HttpGet("https://raw.githubusercontent.com/alyssagithub/Scripts/main/Inferno%20X%20Scripts/Variables.lua"))()

CurrentVersion("v1.1.1")

local virtualInput = game:GetService("VirtualInputManager")

local Plot
local PlayerPlot

local SavedPosition

local SelectedHero
local SelectedChest

local SelectedHero2

local UpgradeLevel = 25
local SwingLooping
local Swing2Looping
local NextLevelLooping

local HireLooping
local BuyLooping
local UpgradeLooping

local ChestLooping

local ReincarnateLooping
local MobLooping
local SkillLooping

local RerollLooping

local IsInLoopReincarnate
local IsInLoopNextLevel
local IsInLoopAutoHire

local HeroesList = {"None"}
local PlotList = {"Your Own Plot"}
local EnchantList = {"None", "Sharp I", "Hero I", "Rich I", "Sharp II", "Hero II", "Rich II", "Luck I", "Sharp III", "Hero III", "Immortal I", "Rich III", "Luck II", "Sharp IV", "Hero IV", "Immortal II", "Rich IV", "Luck III", "Team Player", "Lifeless"}
local SkillsList = {}

local RarityBackgrounds = {
	["0 0.803922 0.803922 0.803922 0 1 0.803922 0.803922 0.803922 0 "] = "Common",
	["0 0.211765 0.513726 1 0 1 0.211765 0.513726 1 0 "] = "Rare",
	["0 0.411765 0.113725 1 0 1 0.411765 0.113725 1 0 "] = "Epic",
	["0 1 0.807843 0.180392 0 1 1 0.807843 0.180392 0 "] = "Legendary",
	["0 1 0 0.984314 0 1 1 1 0 0 "] = "Mythical",
	["0 0.796078 0.564706 1 0 1 0.796078 0.564706 1 0 "] = "Demonic",
	["0 0.835294 0.713726 0.231373 0 1 0.835294 0.713726 0.231373 0 "] = "Godly",
	["0 1 0.47451 0.47451 0 1 1 0.47451 0.47451 0 "] = "Celestial"
}

for i,v in pairs(workspace.Plots:GetChildren()) do
	if v.Owner.Value == Player then
		Plot = v
		PlayerPlot = v
	end
end

for i,v in pairs(workspace.Plots:GetChildren()) do
	if v.Owner.Value and v.Owner.Value ~= Player then
		table.insert(PlotList, v.Owner.Value.Name)
	end
end

repeat task.wait() until Plot and Plot:FindFirstChild("Heroes")

for i,v in pairs(Plot.Heroes:GetChildren()) do
	table.insert(HeroesList, v.Name)
end

local Window = CreateWindow()

local Main = Window:CreateTab("Main", 4483362458)

Main:CreateToggle({
	Name = "🤺 Auto Swing",
	CurrentValue = false,
	Flag = "AutoSwing",
	Callback = function(Value)
		SwingLooping = Value
	end,
})

task.spawn(function()
	while true do
		if SwingLooping then
			if #Plot.Enemy:GetChildren() == 0 then
				repeat task.wait() until Plot.Enemy:GetChildren()[1]
			end

			local Enemy = Plot.Enemy:GetChildren()[1]

			game:GetService("ReplicatedStorage").Packages._Index:FindFirstChild("sleitnick_knit@1.4.7").knit.Services.WeaponService.RE.Swing:FireServer(Enemy)
		end
		task.wait(.14)
	end
end)

Main:CreateToggle({
	Name = "🤺 Auto Swing 2",
	CurrentValue = false,
	Flag = "AutoSwing2",
	Callback = function(Value)
		Swing2Looping = Value
	end,
})

task.spawn(function()
	while true do
		if Swing2Looping then
			Click(Player.PlayerGui.Main.Tint)
		end
		task.wait(.14)
	end
end)

Main:CreateToggle({
	Name = "📊 Auto Progress",
	CurrentValue = false,
	Flag = "AutoNextLevel",
	Callback = function(Value)
		NextLevelLooping = Value
	end,
})

task.spawn(function()
	while task.wait() do
		if NextLevelLooping then
			if Plot.Buttons:FindFirstChild("NextLevel") then
				IsInLoopNextLevel = true

				if IsInLoopReincarnate then
					repeat task.wait() until not IsInLoopReincarnate
				elseif IsInLoopAutoHire then
					repeat task.wait() until not IsInLoopAutoHire
				end

				SavedPosition = Player.Character:WaitForChild("HumanoidRootPart").Position

				repeat task.wait() until Plot.Buttons:FindFirstChild("NextLevel"):FindFirstChild("Touch")

				repeat
					Player.Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(Plot.Buttons:FindFirstChild("NextLevel").Touch.Position)
					task.wait()
				until not Plot.Buttons:FindFirstChild("NextLevel") or not NextLevelLooping

				Player.Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(SavedPosition)

				IsInLoopNextLevel = false
			end
			IsInLoopNextLevel = false
		end
	end
end)

local RequiredLevel = 80
local OtherLevel = 0

Main:CreateToggle({
	Name = "🔁 Auto Reincarnate",
	CurrentValue = false,
	Flag = "AutoReincarnate",
	Callback = function(Value)
		ReincarnateLooping = Value
	end,
})

task.spawn(function()
	while task.wait() do
		if ReincarnateLooping then
			local ReincarnationsAmount = tonumber(Player.PlayerGui.Main.Frames.Achievements.Container.Stats.Container.Reincarnations.Label.Text:split(" ")[2])
			local ReincarnationsTable = {
				[1] = 80,
				[2] = 80,
				[3] = 80,
				[4] = 80,
				[5] = 85,
				[6] = 85,
				[7] = 85,
				[8] = 85,
				[9] = 85,
				[10] = 90,
				[11] = 90,
				[12] = 90,
				[13] = 90,
				[14] = 90,
				[15] = 95,
				[16] = 95,
				[17] = 95,
				[18] = 95,
				[19] = 95,
				[20] = 100,
				[21] = 100,
				[22] = 100,
				[23] = 100,
				[24] = 100,
				[25] = 105,
				[26] = 105,
				[27] = 105,
				[28] = 105,
				[29] = 105
			}

			if ReincarnationsTable[ReincarnationsAmount] and tonumber(Player.PlayerGui.Main.Top.Level.Text:split(" ")[2]) >= ReincarnationsTable[ReincarnationsAmount] then
				OtherLevel = ReincarnationsTable[ReincarnationsAmount]
			elseif ReincarnationsTable[ReincarnationsAmount] then
				OtherLevel = 0
			end

			if Player.PlayerGui.Main.Top.Wave.Wave.Text == "1/1" and (tonumber(Player.PlayerGui.Main.Top.Level.Text:split(" ")[2]) == RequiredLevel and Player.PlayerGui.Main.Top.Level.Text:split(" ")[3] ~= "Complete!") or OtherLevel ~= 0 then
				if Player.PlayerGui.Main.Top.Wave.Wave.Text == "1/1" then
					IsInLoopReincarnate = true

					if IsInLoopNextLevel then
						repeat task.wait() until not IsInLoopNextLevel
					elseif IsInLoopAutoHire then
						repeat task.wait() until not IsInLoopAutoHire
					end

					SavedPosition = Player.Character:WaitForChild("HumanoidRootPart").Position

					task.wait()

					Player.Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(-2041, 59, -26)

					repeat task.wait() until Player.PlayerGui.Main.Frames.Reincarnate.Visible == true or not ReincarnateLooping

					repeat
						game:GetService("ReplicatedStorage").Packages._Index:FindFirstChild("sleitnick_knit@1.4.7").knit.Services.HeroService.RE.Reincarnate:FireServer()
						task.wait()
					until Player.PlayerGui.Main.ChestOpening.Visible == true or not ReincarnateLooping

					Player.Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(SavedPosition)

					IsInLoopReincarnate = false
				end
				IsInLoopReincarnate = false
			elseif tonumber(Player.PlayerGui.Main.Top.Level.Text:split(" ")[2]) > RequiredLevel or (tonumber(Player.PlayerGui.Main.Top.Level.Text:split(" ")[2]) == RequiredLevel and Player.PlayerGui.Main.Top.Level.Text:split(" ")[3] == "Complete!") then
				RequiredLevel = RequiredLevel + 10
				print("[Inferno X] Debug: Set RequiredLevel to "..RequiredLevel)
			end
		end
	end
end)

Main:CreateToggle({
	Name = "⚡ Auto Mob TP",
	CurrentValue = false,
	Flag = "AutoMobTP",
	Callback = function(Value)
		MobLooping = Value
	end,
})

task.spawn(function()
	while task.wait() do
		if MobLooping then
			if #Plot.Enemy:GetChildren() == 0 then
				repeat task.wait() until Plot.Enemy:GetChildren()[1]
			end

			local Enemy = Plot.Enemy:GetChildren()[1]

			if IsInLoopReincarnate then
				repeat task.wait() until not IsInLoopReincarnate
			elseif IsInLoopNextLevel then
				repeat task.wait() until not IsInLoopNextLevel
			elseif IsInLoopAutoHire then
				repeat task.wait() until not IsInLoopAutoHire
			end

			if not Player.Character:FindFirstChild("HumanoidRootPart") then
				repeat task.wait() until Player.Character:FindFirstChild("HumanoidRootPart") or not MobLooping
			end

			Player.Character:FindFirstChild("HumanoidRootPart").CFrame = CFrame.new(Enemy.Position.X, Enemy.Position.Y, Enemy.Position.Z + 5)
			if not MobLooping then
				Player.Character:FindFirstChild("HumanoidRootPart").CFrame = Plot.Teleport.CFrame
			end
		end
	end
end)

Main:CreateToggle({
	Name = "⚔ Auto Use Skills",
	CurrentValue = false,
	Flag = "AutoUseSkills",
	Callback = function(Value)
		SkillLooping = Value
	end,
})

task.spawn(function()
	while task.wait() do
		if SkillLooping then
			for i,v in pairs(Player.PlayerGui.Main.Bottom.Skills.Container:GetChildren()) do
				if v:IsA("Frame") then
					game:GetService("ReplicatedStorage").Packages._Index:FindFirstChild("sleitnick_knit@1.4.7").knit.Services.HeroService.RE.UseSkill:FireServer(v.Name)
					task.wait()
				end
			end
		end
	end
end)

Main:CreateSection("")

Main:CreateDropdown({
	Name = "🏠 Plot",
	Options = PlotList,
	CurrentOption = "Your Own Plot",
	--Flag = "SelectedPlot",
	Callback = function(Value)
		if Value == "Your Own Plot" then
			Plot = PlayerPlot
		else
			for i,v in pairs(workspace.Plots:GetChildren()) do
				if v.Owner.Value == game.Players:FindFirstChild(Value) then
					game:GetService("ReplicatedStorage").Packages._Index:FindFirstChild("sleitnick_knit@1.4.7").knit.Services.WeaponService.RE.TeleportToPlot:FireServer(game.Players:FindFirstChild(Value))
					Plot = v
				end
			end
		end
	end,
})

local Heroes = Window:CreateTab("Heroes", 4483362458)

Heroes:CreateToggle({
	Name = "👍 Auto Hire Heroes",
	CurrentValue = false,
	Flag = "AutoHire",
	Callback = function(Value)
		HireLooping = Value
	end,
})

task.spawn(function()
	while task.wait() do
		if HireLooping then
			if game:GetService("Workspace").Main.Hire:FindFirstChild("_displayHero") and not Plot.Heroes:FindFirstChild("The Reaper") then
				if tostring(game:GetService("Workspace").Main.Hire["_displayHero"].Highlight.OutlineColor) == "0.215686, 1, 0.266667" then
					IsInLoopAutoHire = true

					if IsInLoopReincarnate then
						repeat task.wait() until not IsInLoopReincarnate
					elseif IsInLoopNextLevel then
						repeat task.wait() until not IsInLoopNextLevel
					end

					SavedPosition = Player.Character:WaitForChild("HumanoidRootPart").Position

					task.wait()

					Player.Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(-1886, 61, -92)

					task.wait(.25)

					game:GetService("ReplicatedStorage").Packages._Index:FindFirstChild("sleitnick_knit@1.4.7").knit.Services.HeroService.RE.HireHero:FireServer(game:GetService("Workspace").Main.Hire["_displayHero"].Head.Nametag.Subject.Text)

					task.wait(.25)

					Player.Character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(SavedPosition)

					IsInLoopAutoHire = false

					task.wait(1)
				end
			elseif not game:GetService("Workspace").Main.Hire:FindFirstChild("_displayHero") and not Plot.Heroes:FindFirstChild("The Reaper") then
				IsInLoopAutoHire = true

				if IsInLoopReincarnate then
					repeat task.wait() until not IsInLoopReincarnate
				elseif IsInLoopNextLevel then
					repeat task.wait() until not IsInLoopNextLevel
				end

				game:GetService("ReplicatedStorage").Packages._Index:FindFirstChild("sleitnick_knit@1.4.7").knit.Services.WeaponService.RE.TeleportToMain:FireServer()

				repeat task.wait() until game:GetService("Workspace").Main.Hire:FindFirstChild("_displayHero") or Plot.Heroes:FindFirstChild("The Reaper")

				game:GetService("ReplicatedStorage").Packages._Index:FindFirstChild("sleitnick_knit@1.4.7").knit.Services.WeaponService.RE.TeleportToPlot:FireServer(Plot.Owner.Value)

				IsInLoopAutoHire = false
			end
			IsInLoopAutoHire = false
		end
	end
end)

Heroes:CreateSection("")

local HeroUpgrade = Heroes:CreateDropdown({
	Name = "📃 Hero to Upgrade (leave blank for all)",
	Options = HeroesList,
	CurrentOption = "None",
	Flag = "SelectedHero",
	Callback = function(Value)
		if Value == "None" then
			SelectedHero = nil
			SelectedHero2 = nil
		else
			SelectedHero = Value
			SelectedHero2 = Value
		end
	end,
})

PlayerPlot.Heroes.ChildAdded:Connect(function(child)
	if not table.find(HeroesList, child.Name) then
		table.insert(HeroesList, child.Name)
		HeroUpgrade:Add(child.Name)
	end
end)

PlayerPlot.Heroes.ChildRemoved:Connect(function(child)
	if table.find(HeroesList, child.Name) then
		table.remove(HeroesList, child.Name)
		HeroUpgrade:Remove(child.Name)
	end
end)

Heroes:CreateSlider({
	Name = "🎚 Max Upgrade Level",
	Range = {0, 1000},
	Increment = 1,
	CurrentValue = 25,
	Flag = "MaxUpgradeLevel",
	Callback = function(Value)
		UpgradeLevel = Value
	end,
})

require(Player.PlayerScripts.Client.Controllers.UIController.BuyCoins).Set = function()
	return
end

Heroes:CreateToggle({
	Name = "📈 Auto Upgrade Hero(es)",
	CurrentValue = false,
	Flag = "AutoUpgrade",
	Callback = function(Value)
		UpgradeLooping = Value
	end,
})

task.spawn(function()
	while task.wait() do
		if UpgradeLooping and #PlayerPlot.Heroes:GetChildren() > 0 then
			pcall(function()
				for i,v in pairs(PlayerPlot.Heroes:GetChildren()) do
					if tonumber(v:WaitForChild("Head").Nametag.Level.Text:split(" ")[2]) and tonumber(v:WaitForChild("Head").Nametag.Level.Text:split(" ")[2]) <= (UpgradeLevel - 1) then
						if not SelectedHero then
							SelectedHero = v.Name
						end

						if game:GetService("ReplicatedStorage").Packages._Index:FindFirstChild("sleitnick_knit@1.4.7").knit.Services.HeroService.RF.BuyLevel:InvokeServer(SelectedHero, 0) then
							print("[Inferno X] Debug: Upgraded "..SelectedHero)
						end

						SelectedHero = SelectedHero2
					end
				end
			end)
		end
	end
end)

Heroes:CreateSection("")

Heroes:CreateToggle({
	Name = "💨 Auto Buy Skills",
	CurrentValue = false,
	Flag = "AutoSkills",
	Callback = function(Value)
		BuyLooping = Value
		game:GetService("Players").LocalPlayer.PlayerGui.Main.Alerts.Visible = not BuyLooping
	end,
})

task.spawn(function()
	while task.wait() do
		if BuyLooping then
			for i,v in pairs(SkillsList) do
				if game:GetService("ReplicatedStorage").Packages._Index:FindFirstChild("sleitnick_knit@1.4.7").knit.Services.HeroService.RF.LearnSkill:InvokeServer(v, i) then
					print("[Inferno X] Debug: Bought "..v.."'s skill "..i)
					table.remove(SkillsList, table.find(SkillsList, v))
				end
			end
		end
	end
end)

Heroes:CreateButton({
	Name = "🔁 Refresh Skills",
	Interact = "Click Me!",
	Callback = function()
		for i,v in pairs(Plot.Heroes:GetChildren()) do
			local Looping = true

			local connection = game:GetService("Players").LocalPlayer.PlayerGui.Main.Frames.UpgradeHero.HeroName:GetPropertyChangedSignal("Text"):Connect(function()
				Looping = false
			end)

			repeat
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame
				virtualInput:SendKeyEvent(true, "E", false, nil)
				virtualInput:SendKeyEvent(false, "E", false, nil)
				task.wait()
			until not Looping

			connection:Disconnect()

			for e,r in pairs(game:GetService("Players").LocalPlayer.PlayerGui.Main.Frames.UpgradeHero.Frames.Skills.Container:GetChildren()) do
				if r:IsA("Frame") and not SkillsList[r.Name] then
					SkillsList[r.Name] = v.Name
				end
			end
		end

		local Number = 0

		for i,v in pairs(SkillsList) do
			Number = Number + 1
		end

		print("[Inferno X] Debug: Collected "..Number.." Skills")
	end,
})

local Passive = Window:CreateTab("Passive", 4483362458)

local SelectedEnchants = {}

Passive:CreateDropdown({
	Name = "✨ Enchant(s) to Stop at (multiple choice)",
	Options = EnchantList,
	CurrentOption = "None",
	--Flag = "SelectedEnchant",
	Callback = function(Value)
		if not table.find(SelectedEnchants, Value) and Value ~= "None" then
			table.insert(SelectedEnchants, Value)
		elseif Value ~= "None" then
			table.remove(SelectedEnchants, Value)
		end

		task.spawn(function()
			repeat task.wait() until EnchantLabel
			EnchantLabel:Set("Selected Enchants: "..table.concat(SelectedEnchants, ", "))
		end)
	end,
})

EnchantLabel = Passive:CreateLabel("Selected Enchants: None")

Player.PlayerGui.Main.ChestResult.Container.ChildAdded:Connect(function(child)
	repeat task.wait() until child.ItemName.Text ~= "OP Sword"

	print("[Inferno X] Debug: Opened "..child.ItemName.Text)

	if table.find(SelectedEnchants, child.ItemName.Text) then
		RerollLooping = false
	end
end)

Passive:CreateToggle({
	Name = "🎲 Auto Reroll Passive (must have ui open)",
	CurrentValue = false,
	Flag = "AutoRerollPassive",
	Callback = function(Value)
		RerollLooping = Value
	end,
})

task.spawn(function()
	while true do
		if RerollLooping then
			if Player.PlayerGui.Main.Frames.Passives.Visible == true and Player.PlayerGui.Main.ChestOpening.Visible == false then
				Click(Player.PlayerGui.Main.Frames.Passives.CoreReroll.Button)

				repeat task.wait() until #Player.PlayerGui.Main.ChestResult.Container:GetChildren() == 1
			end
		end
		task.wait(.25)
	end
end)

local Chest = Window:CreateTab("Chest", 4483362458)

Chest:CreateDropdown({
	Name = "📦 Chest to Purchase",
	Options = {"Wooden", "Silver", "Golden", "Legendary", "Divine"},
	CurrentOption = "",
	Flag = "SelectedChest",
	Callback = function(Value)
		SelectedChest = Value
	end,
})

Chest:CreateToggle({
	Name = "💵 Auto Buy Chest",
	CurrentValue = false,
	--Flag = "AutoChest",
	Callback = function(Value)
		ChestLooping = Value
	end,
})

task.spawn(function()
	while true do
		if ChestLooping and SelectedChest then
			game:GetService("ReplicatedStorage").Packages._Index:FindFirstChild("sleitnick_knit@1.4.7").knit.Services.ChestService.RF.BuyChest:InvokeServer(SelectedChest, "single")
		end
		task.wait(1)
	end
end)