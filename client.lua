disPlayerNames = 250 --distance you see IDs at 
keyToToggleIDs = 344 -- f11

playerDistances = {}
showIDsAboveHead = false

local group = 0

RegisterNetEvent('setgroup')
AddEventHandler('setgroup', function()
	group = true
end)

Citizen.CreateThread(function()
	while true do
		-- Wait 5 seconds after player has loaded in and trigger the event.
		Citizen.Wait( 5000 )

		if NetworkIsSessionStarted() then
			TriggerServerEvent( "checkadmin")
		end
	end
end )

Citizen.CreateThread(function()
    while true do
        if IsControlJustPressed(0, keyToToggleIDs) then
			if group == true then 
				showIDsAboveHead = not showIDsAboveHead
				print("Players names showed")
				Wait(50)
			end
        end
        Wait(0)
    end
end)

Citizen.CreateThread(function()
    while true do
        for id = 0, 255 do
            if GetPlayerPed(id) ~= GetPlayerPed(-1) then
                x1, y1, z1 = table.unpack(GetEntityCoords(GetPlayerPed(-1), true))
                x2, y2, z2 = table.unpack(GetEntityCoords(GetPlayerPed(id), true))
                distance = math.floor(GetDistanceBetweenCoords(x1,  y1,  z1,  x2,  y2,  z2,  true))
                playerDistances[id] = distance
            end
        end
        Citizen.Wait(1000)
    end
end)




Citizen.CreateThread(function()
    while true do
        if showIDsAboveHead then
            for id = 0, 255 do 
                if NetworkIsPlayerActive(id) then
                    if GetPlayerPed(id) ~= GetPlayerPed(-1) then
                        if (playerDistances[id] < disPlayerNames) then
                            x2, y2, z2 = table.unpack(GetEntityCoords(GetPlayerPed(id), true))
                            if NetworkIsPlayerTalking(id) then
                                DrawText3D(x2, y2, z2+1, GetPlayerServerId(id) .. " | " .. GetPlayerName(id), 247,124,24)
                            else
                                DrawText3D(x2, y2, z2+1, GetPlayerServerId(id) .. " | " .. GetPlayerName(id), 255,255,255)
                            end
                        end  
                    end
                end
            end
        end
        Citizen.Wait(0)
    end
end)


function DrawText3D(x,y,z, text, r,g,b) 
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z+1*(math.random(1,2)), 1)
 
    local scale = (1/dist)*2
    local fov = (1/GetGameplayCamFov())*100
    local scale = 1
   
    if onScreen then
        SetTextScale(0.55*scale, 0.55*scale)
        SetTextFont(0)
        SetTextProportional(1)
        SetTextColour(r, g, b, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
    end
end
