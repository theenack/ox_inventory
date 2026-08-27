-- NERP-throwitem integration
-- Keeps the inventory UI patch isolated from core ox_inventory logic.

RegisterNUICallback('nerpThrowItem', function(data, cb)
    cb(1)

    if GetResourceState('NERP-throwitem') ~= 'started' then
        return lib.notify({
            type = 'error',
            description = 'NERP-throwitem is not started.'
        })
    end

    local slot = tonumber(data and data.slot)
    local count = math.floor(tonumber(data and data.count) or 1)
    local action = data and data.action

    if not slot or count < 1 then return end
    if action ~= 'drop' and action ~= 'throw' and action ~= 'give' then return end

    if client and client.closeInventory then
        client.closeInventory()
        Wait(250)
    end

    if action == 'drop' then
        exports['NERP-throwitem']:DropSlot(slot, count)
    elseif action == 'throw' then
        exports['NERP-throwitem']:ThrowSlot(slot, count)
    elseif action == 'give' then
        exports['NERP-throwitem']:GiveSlot(slot, count)
    end
end)
