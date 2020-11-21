ESX               = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('promeniga1')
AddEventHandler('promeniga1', function(igrac, firstname)
    local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	
	if(xPlayer.getMoney() >= 10000) then
		xPlayer.removeMoney(10000)
		
        MySQL.Async.execute('UPDATE users SET firstname = @firstname WHERE identifier = @identifier', {
            ['@firstname'] = firstname,
            ['@identifier'] = xPlayer.identifier
        })
        TriggerEvent('esx_license:removeLicense', igrac, "ime")
        notification("~y~Promenjeno ime u ".. firstname)
        if xPlayer.getInventoryItem('idcard').count > 0 then
        xPlayer.removeInventoryItem('idcard', 1)
        notification("~y~Due to the change of identity, you have to get a new ID card, the old one has been revoked")
    end
	else
		notification("You dont have enough ~r~money")
end
end)

RegisterServerEvent('promeniga2')
AddEventHandler('promeniga2', function(igrac, lastname)
    local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	if(xPlayer.getMoney() >= 20000) then
		xPlayer.removeMoney(20000)
	MySQL.Async.execute('UPDATE users SET lastname = @lastname WHERE identifier = @identifier', {
		['@lastname'] = lastname,
		['@identifier'] = xPlayer.identifier
    })
    TriggerEvent('esx_license:removeLicense', igrac, "prezime")
    notification("~y~Promenjeno prezime u ".. lastname)
    if xPlayer.getInventoryItem('idcard').count > 0 then
        xPlayer.removeInventoryItem('idcard', 1)
        notification("~y~Due to the change of identity, you have to get a new ID card, the old one has been revoked")
    end
	else
		notification("You dont have enough ~r~money")
end
end)

function notification(text)
    TriggerClientEvent('esx:showNotification', source, text)
end
