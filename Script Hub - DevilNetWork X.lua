local Games = {
	[10404327868] = "https://raw.githubusercontent.com/LeGioNPsyQ/Scripts/main/DevilNetWork%20X%20Scripts/Games/Timber%20Champions.lua", -- Timber Champions
	[10821317529] = "https://raw.githubusercontent.com/LeGioNPsyQ/Scripts/main/DevilNetWork%20X%20Scripts/Games/Pickaxe%20Mining%20Simulator.lua", -- Pickaxe Mining Simulator
	[9264596435] = "https://raw.githubusercontent.com/LeGioNPsyQ/Scripts/main/DevilNetWork%20X%20Scripts/Games/Idle%20Heroes%20Simulator.lua", -- Idle Heroes Simulator
	[10925589760] = "https://raw.githubusercontent.com/LeGioNPsyQ/Scripts/main/DevilNetWork%20X%20Scripts/Games/Merge%20Simulator.lua", -- Merge Simulator
	[11445923563] = "https://raw.githubusercontent.com/LeGioNPsyQ/Scripts/main/DevilNetWork%20X%20Scripts/Games/One%20Fruit%20Simulator.lua" -- One Fruit Simulator
}

if Games[game.PlaceId] then
	game.StarterGui:SetCore("SendNotification", {
	    Title = "DevilNetWork X Notification";
	    Text = "Script is loaded";
	    Duration = 10;
    })
	loadstring(game:HttpGet(Games[game.PlaceId]))()
else
	game.StarterGui:SetCore("SendNotification", {
	    Title = "DevilNetWork X Notify";
	    Text = "Game not supported";
	    Duration = 10;
    })
end
