local ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('violenceDistrict:checkDistrict', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    local playerCoords = GetEntityCoords(GetPlayerPed(source))
    local districtCoords = Config.ViolenceDistrict.Coords
    local distance = #(playerCoords - districtCoords)

    if distance <= Config.ViolenceDistrict.Radius then
        cb(true)
    else
        cb(false)
    end
end)

RegisterServerEvent('violenceDistrict:enter')
AddEventHandler('violenceDistrict:enter', function(playerId)
    local xPlayer = ESX.GetPlayerFromId(playerId)
    local identifier = xPlayer.identifier

    MySQL.Async.execute('INSERT INTO violence_district (player_id) VALUES (@identifier)', {
        ['@identifier'] = identifier
    }, function(rowsChanged)
        if rowsChanged > 0 then
            TriggerClientEvent('violenceDistrict:enter', playerId)
        end
    end)
end)

RegisterServerEvent('violenceDistrict:exit')
AddEventHandler('violenceDistrict:exit', function(playerId)
    local xPlayer = ESX.GetPlayerFromId(playerId)
    local identifier = xPlayer.identifier

    MySQL.Async.execute('UPDATE violence_district SET exited_at = CURRENT_TIMESTAMP WHERE player_id = @identifier AND exited_at IS NULL', {
        ['@identifier'] = identifier
    }, function(rowsChanged)
        if rowsChanged > 0 then
            TriggerClientEvent('violenceDistrict:exit', playerId)
        end
    end)
end)