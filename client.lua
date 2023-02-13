Visible = false

Data = {}

serverInfos = {
	MaxClients = Scoreboard.MaxClients,
	Logo = Scoreboard.Logo,
	Players = 0,
}

dataRequested = false
y = 0

SetVisible = function(set)
	if set then
		ESX.TriggerServerCallback("scoreboard:getCurrentPlayers", function(Players, PlayersCount)
			serverInfos.Players = PlayersCount
			Data = Players
			table.sort(Data, function(k1, k2)
				return k1.playerId < k2.playerId
			end)
			SendNUIMessage({
				visible = true,
				Data = Data,
				serverInfos = serverInfos,
			})
		end)
		Visible = true
		dataRequested = true
	else
		if Visible then
			SendNUIMessage({ visible = false })
		end
		Visible = false
		dataRequested = false
	end
end

CreateThread(function()
	while true do
		if IsControlPressed(0, Scoreboard.OpenKey) then
			if not dataRequested then
				SetVisible(true)
			end
		else
			SetVisible(false)
		end
		-- SCROLLWHEEL UP
		if IsControlPressed(0, 15) then
			y = math.max(0, y - 50)
			SendNUIMessage({
				scrollY = y,
			})
		end
		-- SCROLLWHEEL DOWN
		if IsControlPressed(0, 242) then
			y = y + 50
			SendNUIMessage({
				scrollY = y,
			})
		end
		Wait(0)
	end
end)

RegisterNUICallback("setMaxScroll", function(data, cb)
	if data.max then
		y = data.max
	end
	cb("ok")
end)

RegisterNetEvent("scoreboard:setData", function(Players)
	Data = Players
end)
