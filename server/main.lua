local QBCore = exports['qb-core']:GetCoreObject()

QBCore.Functions.CreateUseableItem('diving_gear', function(source)
    TriggerClientEvent('popcornrp-divegear:client:useGear', source)
end)

QBCore.Functions.CreateUseableItem('diving_fill', function(source)
    local success = lib.callback.await('popcornrp-divegear:client:fillTank', source)
    if success then
        exports.ox_inventory:RemoveItem(source, 'diving_fill', 1)
    end
end)