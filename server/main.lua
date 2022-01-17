ESX = nil
local ox_inventory = exports.ox_inventory
GlobalState.blood = "blood" -- put here item that you want
GlobalState.AnalizedBlood = "analizedblood" -- other item that you get when blood is analized 

TriggerEvent("esx:getSharedObject", function(obj)
    ESX = obj
end)

RegisterNetEvent('create:drop')
AddEventHandler('create:drop', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local evidencedata = {}
    evidencedata.name = xPlayer.variables.firstName
    evidencedata.lastname = xPlayer.variables.lastName 
    evidencedata.caseid = math.random(1,50)..math.random(1,50)..math.random(1,50)
    evidencedata.sex = xPlayer.variables.sex
    local coords = vec3(xPlayer.coords.x, xPlayer.coords.y, xPlayer.coords.z + 0.5)
    ox_inventory:CustomDrop('Evidence', {
        {GlobalState.blood, 1, evidencedata},
    }, coords)
end)



RegisterNetEvent('giveanalizedblood')
AddEventHandler('giveanalizedblood', function(data)
    local xPlayer = ESX.GetPlayerFromId(source)
    data['AnalizedBy'] = xPlayer.variables.firstName.. ' '..xPlayer.variables.lastName
    data['Date'] = os.date("%c")
    xPlayer.addInventoryItem(GlobalState.AnalizedBlood, 1, data)
    xPlayer.removeInventoryItem(GlobalState.blood, 1)
end)
