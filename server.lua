ESX = nil 

--TriggerEvent('' .. Config.GetShared .. '', function(obj) ESX = obj end) 
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local moiner = {}


RegisterServerEvent('suckdick:save')
AddEventHandler('suckdick:save', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    --ESX.SavePlayer(xPlayer)

    xPlayer.removeWeapon('WEAPON_HEAVYPISTOL')
    xPlayer.removeWeapon('WEAPON_GUSENBERG')
    xPlayer.removeWeapon('WEAPON_CARBINERIFLE')
    xPlayer.removeWeapon('WEAPON_ADVANCEDRIFLE')
    xPlayer.removeWeapon('WEAPON_APPISTOL')
    ESX.SavePlayers()


    MySQL.Async.execute('DELETE FROM ffa_in WHERE identifier = @identifier', {
        ['@identifier'] = xPlayer.identifier
    })

end)

AddEventHandler("playerDropped", function()
    if moiner[source] == true then
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.removeWeapon('WEAPON_HEAVYPISTOL')
    xPlayer.removeWeapon('WEAPON_GUSENBERG')
    xPlayer.removeWeapon('WEAPON_CARBINERIFLE')
    xPlayer.removeWeapon('WEAPON_ADVANCEDRIFLE')
    xPlayer.removeWeapon('WEAPON_APPISTOL')
    end
end)


RegisterServerEvent('suckdick:setDimension')
AddEventHandler('suckdick:setDimension', function(dimension)
    SetPlayerRoutingBucket(source, dimension)
    if dimension > 0 then
        moiner[source] = true
        else
        moiner[source] = false
        end
end)

RegisterServerEvent('killed')
AddEventHandler('killed', function (killer)
    xSource = ESX.GetPlayerFromId(source)
    
    
    if killer ~= nil then
        xPlayer = ESX.GetPlayerFromId(killer)    
        TriggerClientEvent('notify',killer, '1', 'FFA', 'Du hast ' .. xSource.getName() .. ' getötet')
        TriggerClientEvent('heal', killer)
        TriggerClientEvent('suckdick:addKill',killer)  
        TriggerClientEvent('notify',source, '4', 'FFA', 'Du wurdest von ' .. xPlayer.getName() .. ' getötet')
    end

    xSource.triggerEvent('suckdick:addDeath')  
    
end)

ESX.RegisterServerCallback('getpindi', function(source, cb)


    local heiner = {
        eins = 0,
        zwei = 0,
        drei = 0,
        vier = 0,
    }

    local players = ESX.GetPlayers()
    for i=1, #players do
        if GetPlayerRoutingBucket(players[i]) == 30 then
            heiner.eins = heiner.eins + 1
        elseif GetPlayerRoutingBucket(players[i]) == 31 then
            heiner.zwei = heiner.zwei + 1
        elseif GetPlayerRoutingBucket(players[i]) == 32 then
            heiner.drei = heiner.drei + 1    
        elseif GetPlayerRoutingBucket(players[i]) == 33 then
            heiner.vier = heiner.vier + 1    
        
        end


    end


cb(heiner)

end)



ESX.RegisterServerCallback('getInfo', function(source,cb) 
local xPlayer = ESX.GetPlayerFromId(source)
local info = {}
	MySQL.Async.fetchAll('SELECT * FROM ffa WHERE identifier = @identifier', {
		['@identifier'] = xPlayer.identifier
	}, function(data)
        
    if data[1] ~= nil then
        if data[1].kills ~= nil then
    table.insert(info, {kills = data[1].kills, deaths = data[1].deaths})

    cb(info)
   
    end
    
end
	end)

end)


ESX.RegisterServerCallback('isIn', function(source,cb) 
  
    local xPlayer = ESX.GetPlayerFromId(source)
    MySQL.Async.fetchAll('SELECT * FROM ffa_in WHERE identifier = @identifier', {
        ['@identifier'] = xPlayer.identifier
    }, function(data)
        if data[1] ~= nil then
        if data[1].identifier ~= nil then
            

            
            cb(true)



        end
    end
    end)
    
end)


RegisterServerEvent('removein')
AddEventHandler('removein', function ()
    local xPlayer = ESX.GetPlayerFromId(source)
    MySQL.Async.execute('DELETE FROM ffa_in WHERE identifier = @identifier', {
        ['@identifier'] = xPlayer.identifier
    })

    
end)

RegisterServerEvent('insertin')
AddEventHandler('insertin', function ()
    local xPlayer = ESX.GetPlayerFromId(source)
    MySQL.Async.execute('INSERT INTO ffa_in  (identifier) VALUES (@identifier)',
    {
        ['@identifier']   = xPlayer.identifier,
    }, function (rowsChanged)
       
    end)

    
end)


RegisterServerEvent('suckdick:saveInfo')
AddEventHandler('suckdick:saveInfo', function(_kills, _deaths)
    local deaths = _deaths
    local kills = _kills
    local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.fetchAll('SELECT * FROM ffa WHERE identifier = @identifier', {
		['@identifier'] = xPlayer.identifier
	}, function(data)
  	
    if data[1] ~= nil then

        MySQL.Async.execute('UPDATE ffa SET kills = @kills, deaths = @deaths WHERE identifier = @identifier', {
            ['@identifier'] = xPlayer.getIdentifier(),
            ['@kills'] = kills,
            ['@deaths'] = deaths
        }, function (rowsChanged)
        end)
    elseif data[1] == nil then

        MySQL.Async.execute('INSERT INTO ffa  (identifier, kills, deaths) VALUES (@identifier, @kills, @deaths)',
        {
            ['@identifier']   = xPlayer.identifier,
            ['@kills']   = kills,
            ['@deaths'] = deaths
        }, function (rowsChanged)
           
        end)

    end
    
    
	end)



end)