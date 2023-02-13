local OnlinePlayers = {}

CreateThread(function()
	while not ESX.GetPlayers() do
		Wait(1000)
	end
	local Players = ESX.GetPlayers()
	for i = 1, #Players, 1 do
		table.insert(OnlinePlayers, {
			joinTime = os.date(),
			playerId = Players[i],
			name = GetPlayerName(Players[i]),
		})
	end
	TriggerClientEvent("scoreboard:setData", -1, OnlinePlayers)
end)

RegisterNetEvent("esx:playerLoaded")
AddEventHandler("esx:playerLoaded", function(xSource, isNew, skin)
	local xPlayer = ESX.GetPlayerFromId(xSource)
	table.insert(OnlinePlayers, {
		joinTime = os.date(),
		playerId = xPlayer.source,
		name = GetPlayerName(xPlayer.source),
	})
end)
AddEventHandler("playerDropped", function(reason)
	local source = source

	for k, v in pairs(OnlinePlayers) do
		if v.playerId == source then
			table.remove(OnlinePlayers, k)
		end
	end
end)

ESX.RegisterServerCallback("scoreboard:getCurrentPlayers", function(argument, cb)
	cb(OnlinePlayers, GetNumPlayerIndices())
end)
