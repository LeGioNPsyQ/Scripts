local Player, Rayfield, Click, comma, Notify, CreateWindow, CurrentVersion = loadstring(game:HttpGet("https://raw.githubusercontent.com/alyssagithub/Scripts/main/Inferno%20X%20Scripts/Variables.lua"))()

CurrentVersion("v1.1")

local Services = game:GetService("ReplicatedStorage").Knit.Services
local workspace = workspace

local ChildAdded = false

local Folders = {}
local Areas = {}
local Ores = {"1", "2", "3", "4", "MegaOre", "All"}
local Eggs = {}

for i,v in pairs(workspace:GetChildren()) do
	if v.Name == "Drops" then
		table.insert(Folders, v)
	end
end

if #Folders == 2 then
	Folders[1]:Destroy()
end

for i,v in pairs(workspace.WorldBox:GetChildren()) do
	table.insert(Areas, v.Name)
end

for i,v in pairs(workspace.Eggs:GetChildren()) do
	table.insert(Eggs, v.Name)
end

local Window = CreateWindow()

local Main = Window:CreateTab("Main", 4483362458)

Main:CreateSection("Mining")

Main:CreateDropdown({
	Name = "🌏 Area",
	Options = Areas,
	CurrentOption = "",
	Flag = "Area",
	Callback = function(Option)	end,
})

Main:CreateDropdown({
	Name = "🔱 Ore",
	Options = Ores,
	CurrentOption = "",
	Flag = "Ore",
	Callback = function(Option)	end,
})

Main:CreateToggle({
	Name = "⛏ Auto Mine",
	CurrentValue = false,
	Flag = "Mine",
	Callback = function(Value)	end,
})

task.spawn(function()
	while task.wait() do
		if Rayfield.Flags.Mine.CurrentValue and Rayfield.Flags.Area.CurrentOption ~= "" and Rayfield.Flags.Ore.CurrentOption ~= "" then
			local SelectedArea = workspace.SpawnedMineables:FindFirstChild(Rayfield.Flags.Area.CurrentOption)
			for i,v in pairs(SelectedArea:GetChildren()) do
				if v and v:FindFirstChild("Type") and (v.Type.Value:split("Ore")[2] == Rayfield.Flags.Ore.CurrentOption or v.Type.Value == Rayfield.Flags.Ore.CurrentOption or Rayfield.Flags.Ore.CurrentOption == "All") then
					for e,r in pairs(Player.PlayerGui.Main.Prompts.Inventory.ScrollingFrame:GetChildren()) do
						pcall(function()
							if r.ClassName == "ImageButton" and r:FindFirstChild("Equipped") and r.Equipped.Visible then
								Services.MineableService.RF.StartMining:InvokeServer({["Mineable"] = v, ["PickaxeId"] = r.Name})
							end
						end)
					end

					local StartTime = tick()

					repeat task.wait() until not v or not SelectedArea:FindFirstChild(v.Name) or not Rayfield.Flags.Mine.CurrentValue or ChildAdded or (tick() - StartTime > 2 and Player.PlayerGui.Main.Prompts.Click.DPS.Text == "DPS: 0")

					if not ChildAdded then
						print("[Inferno X] Debug: Mined "..v.Name.." in "..math.round(tick() - StartTime).." seconds")
					else
						ChildAdded = false
					end
				end
			end
		end
	end
end)

Main:CreateToggle({
	Name = "🖱 Auto Click",
	CurrentValue = false,
	Flag = "Click",
	Callback = function(Value)	end,
})

task.spawn(function()
	while task.wait() do
		if Rayfield.Flags.Click.CurrentValue then
			Services.MineableService.RE.MineableRemote:FireServer("Click")
		end
	end
end)

Main:CreateToggle({
	Name = "💎 Auto Collect Drops",
	CurrentValue = false,
	Flag = "Drops",
	Callback = function(Value)	end,
})

task.spawn(function()
	while task.wait() do
		if Rayfield.Flags.Drops.CurrentValue then
			for i,v in pairs(workspace.Drops:GetChildren()) do
				v.Drop.CFrame = Player.Character.HumanoidRootPart.CFrame
			end
		end
	end
end)

Main:CreateSection("Other")

Main:CreateToggle({
	Name = "🎁 Auto Claim Rewards",
	CurrentValue = false,
	Flag = "Rewards",
	Callback = function(Value)	end,
})

task.spawn(function()
	while task.wait() do
		if Rayfield.Flags.Rewards.CurrentValue and Player.PlayerGui.Main.Prompts.HUD.RightButtons.Rewards.Notification.Visible then
			for i = 1, 9 do
				Services.RewardService.RF.RequestCompletion:InvokeServer({["Id"] = i})
			end
		end
	end
end)

Main:CreateToggle({
	Name = "🏆 Auto Claim Quests",
	CurrentValue = false,
	Flag = "Quests",
	Callback = function(Value)	end,
})

task.spawn(function()
	while task.wait() do
		if Rayfield.Flags.Quests.CurrentValue and Player.PlayerGui.Main.Prompts.HUD.RightButtons.Achievements.Notification.Visible then
			for _,v in pairs(Player.PlayerGui.Main.Prompts.Achievements.ScrollingFrame:GetChildren()) do
				if v.ClassName == "ImageLabel" and v.Completed.Visible then
					Services.AchievementService.RF.RequestCompletion:InvokeServer({["Id"] = v.Name})
					v.Completed.Visible = false
				end
			end
		end
	end
end)

Main:CreateButton({
	Name = "🐦 Redeem all Codes",
	Interact = 'redeem',
	Callback = function()
		for _,v in pairs({"release", "wow500likes", "likes1000thx", "update1", "newgame", "thx2500likes", "update2", "visits2m"}) do
			game:GetService("ReplicatedStorage").Knit.Services.CodeService.RF.UseCode:InvokeServer(v)
			print("[Inferno X] Debug: Redeemed code "..v)
			task.wait(2)
		end
	end,
})

local Teleport

Teleport = Main:CreateDropdown({
	Name = "🏔 Teleport to Area",
	Options = Areas,
	CurrentOption = "",
	--Flag = "Teleport",
	Callback = function(Option)
		pcall(function()
			Player.Character.HumanoidRootPart.CFrame = workspace.WorldBox[Option].CFrame

			Teleport:Set("")
		end)
	end,
})

local Items = Window:CreateTab("Items/Pets", 4483362458)

Items:CreateSection("Hatching")

Items:CreateDropdown({
	Name = "🥚 Egg",
	Options = Eggs,
	CurrentOption = "",
	Flag = "Egg",
	Callback = function(Option)	end,
})

Items:CreateDropdown({
	Name = "🔢 Amount",
	Options = {"1", "2", "3"},
	CurrentOption = "1",
	Flag = "Amount",
	Callback = function(Option)	end,
})

Items:CreateToggle({
	Name = "🐣 Auto Hatch Egg",
	CurrentValue = false,
	Flag = "Hatch",
	Callback = function(Value)	end,
})

task.spawn(function()
	while task.wait() do
		if Rayfield.Flags.Hatch.CurrentValue and Rayfield.Flags.Egg.CurrentOption ~= "" then
			Services.EggService.RF.OpenEgg:InvokeServer({["UpdateType"] = "Open", ["EggType"] = Rayfield.Flags.Egg.CurrentOption, ["Auto"] = false, ["Amount"] = tonumber(Rayfield.Flags.Amount.CurrentOption)})
		end
	end
end)

Items:CreateSection("Equipping")

Items:CreateToggle({
	Name = "👍 Auto Equip Best Pickaxe",
	CurrentValue = false,
	Flag = "BestPick",
	Callback = function(Value)	end,
})

Player.PlayerGui.Main.Prompts.Inventory.ScrollingFrame.ChildAdded:Connect(function(Child)
	if Rayfield.Flags.BestPick.CurrentValue and Child.ClassName == "ImageButton" then
		ChildAdded = true
		firesignal(Player.PlayerGui.Main.Prompts.Inventory.EquipBest.Activated)
	end
end)

Items:CreateToggle({
	Name = "👎 Auto Equip Best Pet",
	CurrentValue = false,
	Flag = "BestPet",
	Callback = function(Value)	end,
})

Player.PlayerGui.Main.Prompts.PetInventory.ScrollingFrame.ChildAdded:Connect(function(Child)
	if Rayfield.Flags.BestPet.CurrentValue and Child.ClassName == "ImageButton" then
		firesignal(Player.PlayerGui.Main.Prompts.PetInventory.EquipBest.Activated)
	end
end)

Items:CreateSection("Giant")

Items:CreateToggle({
	Name = "⚒ Auto Giant Pets",
	Info = "Turns 5 of the same pet into a giant!",
	CurrentValue = false,
	Flag = "GiantPets",
	Callback = function(Value)	end,
})

local function Giant(ToGiant, ScrollingFrame, Remote)
	local Items = {}

	for i,v in pairs(Player.PlayerGui.Main.Prompts.Giant[ScrollingFrame]:GetChildren()) do
		if v.ClassName == "ImageButton" then
			if not Items[v.Icon.Image] then
				Items[v.Icon.Image] = {Amount = 1, Ids = {v.Name}}
			else
				table.insert(Items[v.Icon.Image].Ids, v.Name)
				Items[v.Icon.Image].Amount = Items[v.Icon.Image].Amount + 1
			end
		end
	end

	for i,v in pairs(Items) do
		if v.Amount >= 5 then
			local Selected = {}

			for e = 1, 5 do
				Selected[Items[i].Ids[e]] = true
				print("[Inferno X] Debug: Selected Giant ID "..Items[i].Ids[e])
			end

			Services.GiantService.RF[Remote]:InvokeServer({["Current"..ToGiant] = Items[i].Ids[1], ["Chosen"] = Selected})
		end
	end
end

task.spawn(function()
	while task.wait() do
		if Rayfield.Flags.GiantPets.CurrentValue then
			Giant("Pet", "ScrollingFramePets", "RequestGiantPet")
		end
	end
end)

Items:CreateToggle({
	Name = "🛠 Auto Giant Pickaxes",
	Info = "Turns 5 of the same pickaxe into a giant!",
	CurrentValue = false,
	Flag = "GiantPicks",
	Callback = function(Value)	end,
})

task.spawn(function()
	while task.wait() do
		if Rayfield.Flags.GiantPicks.CurrentValue then
			Giant("Pickaxe", "ScrollingFrame", "RequestGiant")
		end
	end
end)


Items:CreateSection("Rainbow")
Items:CreateToggle({
	Name = "⚒ Auto Rainbow Pets",
	Info = "Turns 5 Giant Pet into a Rainbow!",
	CurrentValue = false,
	Flag = "RainbowPets",
	Callback = function(Value)	end,
})

local function Rainbow(ToRainbow, ScrollingFrame, Remote)
	local Items = {}

	for i,v in pairs(Player.PlayerGui.Main.Prompts.Rainbow[ScrollingFrame]:GetChildren()) do
		if v.ClassName == "ImageButton" then
			if not Items[v.Icon.Image] then
				Items[v.Icon.Image] = {Amount = 1, Ids = {v.Name}}
			else
				table.insert(Items[v.Icon.Image].Ids, v.Name)
				Items[v.Icon.Image].Amount = Items[v.Icon.Image].Amount + 1
			end
		end
	end

	for i,v in pairs(Items) do
		if v.Amount >= 5 then
			local Selected = {}

			for e = 1, 5 do
				Selected[Items[i].Ids[e]] = true
				print("[Inferno X] Debug: Selected Rainbow ID "..Items[i].Ids[e])
			end

			Services.RainbowService.RF[Remote]:InvokeServer({["Current"..ToRainbow] = Items[i].Ids[1], ["Chosen"] = Selected})
		end
	end
end

task.spawn(function()
	while task.wait() do
		if Rayfield.Flags.RainbowPets.CurrentValue then
			Rainbow("Pet", "ScrollingFramePets", "RequestRainbowPet")
		end
	end
end)

Items:CreateToggle({
	Name = "🛠 Auto Rainbow Pickaxes",
	Info = "Turns 5 Giant Pickaxe into a Rainbow!",
	CurrentValue = false,
	Flag = "RainbowPicks",
	Callback = function(Value)	end,
})

task.spawn(function()
	while task.wait() do
		if Rayfield.Flags.RainbowPicks.CurrentValue then
			Rainbow("Pickaxe", "ScrollingFrame", "RequestRainbow")
		end
	end
end)