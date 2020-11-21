ESX               = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterNetEvent("esx_miner:givestone")
AddEventHandler("esx_miner:givestone", function(item, count)
    local _source = source
    local xPlayer  = ESX.GetPlayerFromId(_source)
        if xPlayer ~= nil then
            if xPlayer.getInventoryItem('stones').count < 40 then
                xPlayer.addInventoryItem('stones', 5)
                TriggerClientEvent('esx:showNotification', source, 'You received ~b~stones.')
            end
        end
    end)

    
RegisterServerEvent('promeniga')
AddEventHandler('promeniga', function(source, pre)
    local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	MySQL.Async.execute('UPDATE users SET pre = @pre WHERE identifier = @identifier', {
		['@pre'] = pre,
		['@identifier'] = xPlayer.identifier
	})
end)

---SecondJob Included
TriggerEvent('es:addGroupCommand', 'setjoboffline', 'jobmaster', function(source, args, user) 

		

        MySQL.Async.execute('UPDATE users SET job = @job WHERE name = @name', {
            ['@name'] = args[1],
            ['@job'] =  args[2]
        })
        MySQL.Async.execute('UPDATE users SET job_grade = @job_grade WHERE name = @name', {
            ['@name'] = args[1],
            ['@job_grade']  = args[3]
        })
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Insufficient Permissions.' } })
end, {help = ('setjob'), params = {{name = "id", help = ('id_param')}, {name = "job", help = ('setjob_param2')}, {name = "grade_id", help = ('setjob_param3')}}})


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
        notification("~y~Zbog Promene identiteta morate izvaditi novu licnu kartu, stara je oduzeta")
    end
	else
		notification("Ti nemas dovoljno ~r~novca")
end
end)
    

RegisterServerEvent('promenigapica')
AddEventHandler('promenigapica', function(price, item)
    
    MySQL.Async.execute('UPDATE shops1 SET price = @price WHERE store = "Picerija" and item = @item', {
        ['@price'] = price,
        ['@item'] = item
    })
    TriggerClientEvent('esx:showNotification', source, '~y~Promenili ste cenu ~r~'.. item.. '~y~ na ~r~'.. price.. '$')
    Wait(500)
    StopResource('esx_shopsa')
    StartResource('esx_shopsa')
end)

RegisterServerEvent('promenigakafa')
AddEventHandler('promenigakafa', function( price, item)

    MySQL.Async.execute('UPDATE shops1 SET price = @price WHERE store = "bean" and item = @item', {
        ['@price'] = price,
        ['@item'] = item
    })
    TriggerClientEvent('esx:showNotification', source, '~y~Promenili ste cenu ~r~'.. item.. '~y~ na ~r~'.. price.. '$')
    Wait(500)
    StopResource('esx_shopsa')
    StartResource('esx_shopsa')
end)

ESX.RegisterServerCallback('proverikucu', function(source, cb)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    MySQL.Async.fetchAll("SELECT * FROM users WHERE identifier = @identifier", {['@identifier'] = xPlayer.identifier}, function(result)
        if result[1].house == '{"owns":false,"furniture":[],"houseId":0}' then
      cb(false)
        else
            cb(true)
        end
    end)
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
        notification("~y~Zbog Promene identiteta morate izvaditi novu licnu kartu, stara je oduzeta")
    end
	else
		notification("Ti nemas dovoljno ~r~novca")
end
end)

RegisterNetEvent('obrisivozilo')
AddEventHandler('obrisivozilo', function( plate)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local result = MySQL.Sync.fetchAll('SELECT finance FROM owned_vehicles WHERE plate = @plate', {
        ['@plate'] = plate
    }) 
    --MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE owner = @owner AND @plate = plate', {
        --['@owner'] = xPlayer.identifier,
        --['@plate'] = plate
    --}, function(resultt)
   -- if resultt[1] then
    if result[1].finance == 0 then
       xPlayer.showNotification('~y~Vlasnik ovog automobila ne duguje nista!')
    elseif result[1].finance > 0 then
    xPlayer.addAccountMoney('black_money', result[1].finance)
    xPlayer.showNotification('~y~Vlasnik autosalona je unovcio njihov dug u vas profit  i zaradili ste ~r~: '.. result[1].finance.. "€")
        MySQL.Async.execute('DELETE FROM owned_vehicles WHERE plate = @plate', {
            ['@plate'] = plate
        })
        TriggerClientEvent('brisigaa', xPlayer.source)
    end
--end
--end)
end)
RegisterNetEvent("esx_miner:washing")
AddEventHandler("esx_miner:washing", function(item, count)
    local _source = source
    local xPlayer  = ESX.GetPlayerFromId(_source)
        if xPlayer ~= nil then
            if xPlayer.getInventoryItem('stones').count > 9 then
                TriggerClientEvent("esx_miner:washing", source)
                Citizen.Wait(15900)
                xPlayer.addInventoryItem('washedstones', 10)
                xPlayer.removeInventoryItem("stones", 10)
            elseif xPlayer.getInventoryItem('stones').count < 10 then
                TriggerClientEvent('esx:showNotification', source, 'You do not have ~b~stones.')
            end
        end
    end)

    RegisterNetEvent("imaskucu")
    AddEventHandler("imaskucu", function()
        local _source = source
        local xPlayer = ESX.GetPlayerFromId(_source)
        xPlayer.addMoney(100)
        notification('Dobio si obicnu platu u iznosu od 100 dolara')
        end)

        RegisterNetEvent("nemaskucu")
        AddEventHandler("nemaskucu", function()
            local _source = source
            local xPlayer = ESX.GetPlayerFromId(_source)
            xPlayer.addMoney(100)
            xPlayer.removeMoney(100 * 0.20)
            notification('Skinuto ti je 20% od plate')
            end)
    RegisterServerEvent('dajpare')
    AddEventHandler('dajpare', function(pare)
        local xPlayers = ESX.GetPlayers()

		for i=1, #xPlayers, 1 do
			local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
            xPlayer.addAccountMoney('bank', pare)
            
        end	
    end)
    RegisterServerEvent('dalmoze:true')
    AddEventHandler('dalmoze:true', function()
        poseduje = false
    end)

    RegisterServerEvent('dalmoze:false')
    AddEventHandler('dalmoze:false', function()
        poseduje = true
    end)

    RegisterServerEvent('dajplatu1')
AddEventHandler('dajplatu1', function(novac, source)
    local xPlayers = ESX.GetPlayers()

    for i=1, #xPlayers, 1 do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
    if poseduje == false then
        xPlayer.addAccountMoney('bank', novac * 5)
        print('nemakucu')
             TriggerClientEvent('esx:showAdvancedNotification',  ('Narodna Banka'), ('Uplata na vas racun'), ('~yPrimili ste satnicu:~g~ '.. (novac * 5).. "€"), 'CHAR_BANK_FLEECA', 9)
    end
                if poseduje == true then
             xPlayer.addAccountMoney('bank', (novac * 5 * 0.80))
            print('imakucu')
            TriggerClientEvent('esx:showAdvancedNotification',  ('Narodna Banka'), ('Uplata na vas racun'), ('~y~Primili ste satnicu:~g~ '.. (novac * 5).. "€"), 'CHAR_BANK_FLEECA', 9)
            TriggerClientEvent('esx:showAdvancedNotification',  ('Narodna Banka'), ('Uplata na porez'), ('~y~Platili ste porez na svu nepokretnu imovinu u iznosu od ~r~'.. (novac * 0.20).. "~g~€"), 'CHAR_BANK_FLEECA', 9)
        end
    end
end)
RegisterServerEvent('licnakarta')
AddEventHandler('licnakarta', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	
	if(xPlayer.getMoney() >= 50) then
		xPlayer.removeMoney(50)
		
		xPlayer.addInventoryItem('idcard', 1)
		
		notification("Ti si preuzeo  ~g~licnu kartu")
	else
		notification("Ti nemas dovoljno ~r~novca")
	end	
end)

RegisterServerEvent('paraa')
AddEventHandler('paraa', function(source, pare)
	local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    xPlayer.addAccountMoney('black_money', pare)
end)


RegisterServerEvent('licnakarta123')
AddEventHandler('licnakarta123', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	
	if(xPlayer.getMoney() >= 500) then
		xPlayer.removeMoney(500)
		
		TriggerEvent('promeniga', source, 'Sandy Shores')
		
		notification("~y~Promenjeno prebivaliste na ~r~Sandy Shores")
	else
		notification("Ti nemas dovoljno ~r~novca")
	end	
end)

RegisterServerEvent('licnakarta1234')
AddEventHandler('licnakarta1234', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	
	if(xPlayer.getMoney() >= 500) then
		xPlayer.removeMoney(500)
		
		TriggerEvent('promeniga', source, 'Paleto Bay')
		
		notification("~y~Promenjeno prebivaliste na ~r~Paleto Bay")
	else
		notification("Ti nemas dovoljno ~r~novca")
	end	
end)

RegisterServerEvent('licnakarta12345')
AddEventHandler('licnakarta12345', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	
	if(xPlayer.getMoney() >= 3000) then
		xPlayer.removeMoney(3000)
		
		TriggerEvent('promeniga', source, 'Los Santos')
		
		notification("~y~Promenjeno prebivaliste na ~r~Los Santos")
	else
		notification("Ti nemas dovoljno ~r~novca")
	end	
end)

RegisterServerEvent('licnakartaa')
AddEventHandler('licnakartaa', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	
	if(xPlayer.getMoney() >= 50) then
		xPlayer.removeMoney(100)
		
		xPlayer.addInventoryItem('zdravstvena_knjziica', 1)
		TriggerEvent('esx_addonaccount:getSharedAccount', 'society_domzdravlja', function(account)
            account.addMoney(100)
        end)
		notification("Ti si preuzeo  ~r~Zdravstvenu Knjzizicu")
	else
		notification("Ti nemas dovoljno ~r~novca")
	end	
end)


RegisterNetEvent("esx_miner:remelting")
AddEventHandler("esx_miner:remelting", function(item, count)
    local _source = source
    local xPlayer  = ESX.GetPlayerFromId(_source)
    local randomChance = math.random(1, 100)
        if xPlayer ~= nil then
            if xPlayer.getInventoryItem('washedstones').count > 9 then
                TriggerClientEvent("esx_miner:remelting", source)
                Citizen.Wait(15900)
                if randomChance < 10 then
                    xPlayer.addInventoryItem("diamond", 1)
                    xPlayer.removeInventoryItem("washedstones", 10)
                    TriggerClientEvent('esx:showNotification', _source, 'You get ~b~1 diamond ~w~for 10 washed stones.')
                elseif randomChance > 9 and randomChance < 25 then
                    xPlayer.addInventoryItem("gold", 5)
                    xPlayer.removeInventoryItem("washedstones", 10)
                    TriggerClientEvent('esx:showNotification', _source, 'You get ~y~5 gold ~w~for 10 washed stones.')
                elseif randomChance > 24 and randomChance < 50 then
                    xPlayer.addInventoryItem("iron", 10)
                    xPlayer.removeInventoryItem("washedstones", 10)
                    TriggerClientEvent('esx:showNotification', _source, 'You got ~w~10 iron for 10 washed stones.')
                elseif randomChance > 49 then
                    xPlayer.addInventoryItem("copper", 20)
                    xPlayer.removeInventoryItem("washedstones", 10)
                    TriggerClientEvent('esx:showNotification', _source, 'You got ~o~20 copper ~w~for 10 washed stones.')
                end
            elseif xPlayer.getInventoryItem('stones').count < 10 then
                TriggerClientEvent('esx:showNotification', source, 'You do not have ~b~stones.')
            end
        end
    end)

RegisterNetEvent("esx_miner:selldiamond")
AddEventHandler("esx_miner:selldiamond", function(item, count)
    local _source = source
    local xPlayer  = ESX.GetPlayerFromId(_source)
        if xPlayer ~= nil then
            if xPlayer.getInventoryItem('diamond').count > 0 then
                local pieniadze = Config.DiamondPrice
                xPlayer.removeInventoryItem('diamond', 1)
                xPlayer.addMoney(pieniadze)
                TriggerClientEvent('esx:showNotification', source, 'You sell ~b~1 diamond.')
            elseif xPlayer.getInventoryItem('diamond').count < 1 then
                TriggerClientEvent('esx:showNotification', source, 'You do not have ~b~diamonds.')
            end
        end
    end)

RegisterNetEvent("esx_miner:sellgold")
AddEventHandler("esx_miner:sellgold", function(item, count)
    local _source = source
    local xPlayer  = ESX.GetPlayerFromId(_source)
        if xPlayer ~= nil then
            if xPlayer.getInventoryItem('gold').count > 4 then
                local pieniadze = Config.GoldPrice
                xPlayer.removeInventoryItem('gold', 5)
                xPlayer.addMoney(pieniadze)
                TriggerClientEvent('esx:showNotification', source, 'You sell ~y~5 gold.')
            elseif xPlayer.getInventoryItem('gold').count < 5 then
                TriggerClientEvent('esx:showNotification', source, 'You do not have ~b~gold')
            end
        end
    end)

function notification(text)
	TriggerClientEvent('esx:showNotification', source, text)
end

RegisterNetEvent("esx_miner:selliron")
AddEventHandler("esx_miner:selliron", function(item, count)
    local _source = source
    local xPlayer  = ESX.GetPlayerFromId(_source)
        if xPlayer ~= nil then
            if xPlayer.getInventoryItem('iron').count > 9 then
                local pieniadze = Config.IronPrice
                xPlayer.removeInventoryItem('iron', 10)
                xPlayer.addMoney(pieniadze)
                TriggerClientEvent('esx:showNotification', source, 'You sell ~w~10 iron.')
            elseif xPlayer.getInventoryItem('iron').count < 10 then
                TriggerClientEvent('esx:showNotification', source, 'You do not have ~b~iron.')
            end
        end
    end)

RegisterNetEvent("esx_miner:sellcopper")
AddEventHandler("esx_miner:sellcopper", function(item, count)
    local _source = source
    local xPlayer  = ESX.GetPlayerFromId(_source)
        if xPlayer ~= nil then
            if xPlayer.getInventoryItem('copper').count > 19 then
                local pieniadze = Config.CopperPrice
                xPlayer.removeInventoryItem('copper', 20)
                xPlayer.addMoney(pieniadze)
                TriggerClientEvent('esx:showNotification', source, 'You sell ~o~20 copper.')
            elseif xPlayer.getInventoryItem('copper').count < 20 then
                TriggerClientEvent('esx:showNotification', source, 'You do not have ~b~copper.')
            end
        end
    end)
