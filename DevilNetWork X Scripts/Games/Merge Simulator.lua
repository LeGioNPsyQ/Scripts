local Player, Rayfield, Click, comma, Notify, CreateWindow, CurrentVersion = loadstring(game:HttpGet("https://raw.githubusercontent.com/alyssagithub/Scripts/main/Inferno%20X%20Scripts/Variables.lua"))()

CurrentVersion("v1.1.0")

local Plot = workspace.Plots:FindFirstChild(Player.Name)

local AutoTapLooping
local AutoMergeLooping
local AutoUpgradeLooping
local AutoObbyLooping
local AutoRebirthLooping
local InfObbyMultiLooping
local HatchLooping

local SelectedEgg

local Eggs = {}

for i,v in pairs(game:GetService("Workspace").Plot.Eggs:GetChildren()) do
	if not v.Name:match("Robux") then
		table.insert(Eggs, v.Name)
	end
end

local Window = CreateWindow()

local Main = Window:CreateTab("Main", 4483362458)

Main:CreateToggle({
	Name = "🖱 Auto Tap",
	CurrentValue = false,
	Flag = "AutoTap",
	Callback = function(Value)
		AutoTapLooping = Value
	end,
})

task.spawn(function()
	while task.wait() do
		if AutoTapLooping then
			for i,v in pairs(Plot.Blocks:GetChildren()) do
				game:GetService("ReplicatedStorage").Functions.Tap:FireServer(v)
				task.wait()
			end
		end
	end
end)

Main:CreateToggle({
	Name = "🤝 Auto Merge",
	CurrentValue = false,
	Flag = "AutoMerge",
	Callback = function(Value)
		AutoMergeLooping = Value
	end,
})

task.spawn(function()
	while task.wait() do
		if AutoMergeLooping then
			for i,v in pairs(Plot.Blocks:GetChildren()) do
				v.CFrame = CFrame.new(Plot.Main.Position.X + 10, Plot.Main.Position.Y + 10, Plot.Main.Position.Z + 10)
			end
		end
	end
end)

Main:CreateToggle({
	Name = "📈 Auto Buy Upgrades",
	CurrentValue = false,
	Flag = "AutoBuyUpgrades",
	Callback = function(Value)
		AutoUpgradeLooping = Value
	end,
})

task.spawn(function()
	while task.wait() do
		if AutoUpgradeLooping then
			for i,v in pairs(Player.PlayerGui.World.Upgrades.Main:GetChildren()) do
				if v:IsA("Frame") then
					firesignal(v.Buy.Activated)
				end
			end
		end
	end
end)

Main:CreateToggle({
	Name = "🏁 Auto Complete Obby",
	CurrentValue = false,
	Flag = "AutoCompleteObby",
	Callback = function(Value)
		AutoObbyLooping = Value
	end,
})

task.spawn(function()
	while task.wait() do
		if AutoObbyLooping then
			if game:GetService("Workspace").Obby.Blocker.Transparency == 1 then
				Player.Character.HumanoidRootPart.CFrame = CFrame.new(267, 81, 4)
				repeat task.wait() until game:GetService("Workspace").Obby.Blocker.Transparency ~= 1
			end
		end
	end
end)

Main:CreateToggle({
	Name = "🔁 Auto Rebirth",
	CurrentValue = false,
	Flag = "AutoRebirth",
	Callback = function(Value)
		AutoRebirthLooping = Value
	end,
})

task.spawn(function()
	while true do
		if AutoRebirthLooping then
			game:GetService("ReplicatedStorage").Functions.Rebirth:InvokeServer()
		end
		task.wait(1)
	end
end)

Main:CreateToggle({
	Name = "🎉 Infinite Obby Multiplier",
	CurrentValue = false,
	Flag = "InfObbyMulti",
	Callback = function(Value)
		InfObbyMultiLooping = Value
	end,
})

task.spawn(function()
	while true do
		if InfObbyMultiLooping then
			firetouchinterest(Player.Character.HumanoidRootPart, workspace.Obby.Finish, 0)
			firetouchinterest(Player.Character.HumanoidRootPart, workspace.Obby.Finish, 1)
		end
		task.wait(1)
	end
end)

local Pets = Window:CreateTab("Pets", 4483362458)

Pets:CreateDropdown({
	Name = "🥚 Egg",
	Options = Eggs,
	CurrentOption = "",
	Flag = "SelectedEgg",
	Callback = function(Option)
		SelectedEgg = Option
	end,
})

Pets:CreateToggle({
	Name = "🐣 Auto Hatch Egg",
	CurrentValue = false,
	Flag = "AutoHatch",
	Callback = function(Value)
		HatchLooping = Value
	end,
})

task.spawn(function()
	while task.wait(1) do
		if HatchLooping and SelectedEgg then
			game:GetService("ReplicatedStorage").Functions.Minions.BuyEgg:InvokeServer(SelectedEgg)
		end
	end
end)