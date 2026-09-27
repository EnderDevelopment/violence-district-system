local ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end

    local playerCoords = GetEntityCoords(PlayerPedId())
    local districtCoords = Config.ViolenceDistrict.Coords
    local distance = #(playerCoords - districtCoords)

    if distance <= Config.ViolenceDistrict.Radius then
        TriggerServerEvent('violenceDistrict:enter', GetPlayerServerId(PlayerId()))
    else
        TriggerServerEvent('violenceDistrict:exit', GetPlayerServerId(PlayerId()))
    end

    Citizen.Wait(1000)
end)

RegisterNetEvent('violenceDistrict:enter')
AddEventHandler('violenceDistrict:enter', function()
    ESX.ShowNotification(Config.ViolenceDistrict.EnterMessage)
end)

RegisterNetEvent('violenceDistrict:exit')
AddEventHandler('violenceDistrict:exit', function()
    ESX.ShowNotification(Config.ViolenceDistrict.ExitMessage)
end)