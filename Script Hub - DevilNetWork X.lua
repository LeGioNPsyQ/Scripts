local Games = {
--  GAME ID             GAME SCRIPT LINK
-- FAVORITEN
--    [8540346411] = "https://raw.githubusercontent.com/KrystekYTpv/Scripts/main/RebirthChampionsX.lua", -- Rebirth Chamption X
	[10404327868] = "https://raw.githubusercontent.com/LeGioNPsyQ/Scripts/main/DevilNetWork%20X%20Scripts/Games/Timber%20Champions.lua", -- Timber Champions
	[10821317529] = "https://raw.githubusercontent.com/LeGioNPsyQ/Scripts/main/DevilNetWork%20X%20Scripts/Games/Pickaxe%20Mining%20Simulator.lua", -- Pickaxe Mining Simulator

--    [11599913094] = "https://raw.githubusercontent.com/eufoni02/emperor/main/autocollectnukesim.lua", -- Nuke Simulator
--    [11448052802] = "https://raw.githubusercontent.com/danixbo/NoobHub/main/NoobHub", -- Pet Rift
--    [11542692507] = "https://raw.githubusercontent.com/bunnynwy/games/main/animesouls", -- Anime Souls Simulator
--    [11620947043] = "https://raw.githubusercontent.com/danixbo/NoobHub/main/NoobHub", -- Flappy Clicker
--    [11746859781] = "https://raw.githubusercontent.com/danixbo/NoobHub/main/NoobHub", -- Bubble Gum Clicker
--    [11542692507] = "", -- Anime Souls Simulator
--    [11430505281] = "", -- Anime Weapon Simulator
--    [9498006165] = "", -- Tapping Simulator
--    [10836055001] = "", -- Monster-Hunt-Simulator
--    [9759729519] = "", -- All of Us Are Dead
    [11542692507] = "https://raw.githubusercontent.com/bunnynwy/games/main/petlegends2", -- Pet Legends 2!
--    [11542692507] = "", -- 
--    [11542692507] = "", -- 

-- Andere GAMES

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
