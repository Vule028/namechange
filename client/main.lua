local PlayerData                = {}
ESX                             = nil

Citizen.CreateThread(function()
    while ESX == nil do
      TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
      Citizen.Wait(0)
      ESX.PlayerData = ESX.GetPlayerData()
    end
end)  

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
end)


 function OpenMenu()
    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open(
        'default', GetCurrentResourceName(), 'gym_shop_menu',
        {
            title    = 'Municipality',
			align   = 'bottom-right',
            elements = {
                {label = 'Change Name/Lastname', value = 'namechange'},
            }
        },
        function(data, menu)
            if data.current.value == 'namechange' then
                promenaimena() 
            end
        end,
        function(data, menu)
            menu.close()
        end
    )
end


function promenaimena()
    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open(
        'default', GetCurrentResourceName(), 'gym_shop_menu',
        {
            title    = 'Municipality',
			align   = 'bottom-right',
            elements = {
                {label = 'Change Name <span style="color:green";>[10000€]', value = 'name'},
                {label = 'Change Lastname <span style="color:green";>[20000€]', value = 'lastname'},
            }
        },
        function(data, menu)
            if data.current.value == 'name' then
                ESX.TriggerServerCallback('esx_license:checkLicense', function(hasLicense)
                    if hasLicense then
                ESX.UI.Menu.Open(
                    'dialog', GetCurrentResourceName(), 'menjaj_ime',
                    {
                        title = ('Your future name?'),
                    },
                    function(data3, menu3)
                        menu3.close()
                TriggerServerEvent('promeniga1',  GetPlayerServerId(PlayerId()), data3.value)
            end,
            function(data3, menu3)
                menu3.close()
            end
        )
    else
        ESX.ShowNotification('~y~You do not have permission from the city judge for this action')
    end
end, GetPlayerServerId(PlayerId()), 'ime')
            elseif data.current.value == 'lastname' then    
                ESX.TriggerServerCallback('esx_license:checkLicense', function(hasLicense)
                    if hasLicense then               
                ESX.UI.Menu.Open(
                    'dialog', GetCurrentResourceName(), 'menjaj_prezime',
                    {
                        title = ('Your future lastname?'),
                    },
                    function(data4, menu4)
                        menu4.close()
                TriggerServerEvent('promeniga2',  GetPlayerServerId(PlayerId()), data4.value)
            end,
            function(data4, menu4)
                menu4.close()
            end
        )
    else
        ESX.ShowNotification('~y~You do not have permission from the city judge for this action')
    end
end, GetPlayerServerId(PlayerId()), 'prezime')
            end
        end,
        function(data, menu)
            menu.close()
        end
    )
end
 
Citizen.CreateThread(function()
    while true do
	local ped = PlayerPedId()
	local distance = GetDistanceBetweenCoords(GetEntityCoords(ped))
        Citizen.Wait(1)

                if GetDistanceBetweenCoords(GetEntityCoords(ped), Config.CoordsX, Config.CoordsY, Config.CoordsZ, true) < 100 then
                    DrawMarker(0, Config.CoordsX, Config.CoordsY, Config.CoordsZ, 0, 0, 0, 0, 0, 90.0, 1.7, 1.7, 1.0, 0, 253, 110, 155, 0, 0, 2, 0, 0, 0, 0)
                        if GetDistanceBetweenCoords(GetEntityCoords(ped), Config.CoordsX, Config.CoordsY, Config.CoordsZ, true) < 1 then
                            ESX.ShowHelpNotification('Press ~INPUT_CONTEXT~ to access municipality')
                                if IsControlJustReleased(1, 51) then
                                   OpenMenu()
                                end
                            end                           
                        end
                        end
                    end)
