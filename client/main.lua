local QBCore = exports['qb-core']:GetCoreObject()

local config = require 'config.client'

local currentGear = {
    mask = 0,
    tank = 0,
    enabled = false
}

local oxygenLevel = 0

local function enableScuba()
    SetEnableScuba(cache.ped, true)
    SetPedMaxTimeUnderwater(cache.ped, 2000.00)
end

local function disableScuba()
    SetEnableScuba(cache.ped, false)
    SetPedMaxTimeUnderwater(cache.ped, 1.00)
end

lib.callback.register('popcornrp-divegear:client:fillTank', function()
    if IsPedSwimmingUnderWater(cache.ped) then
        qBCore.Functions.Notify(Lang:t('error.underwater', {oxygenlevel = oxygenLevel}), 'error')
        return false
    end

    if lib.progressBar({
        duration = config.RefillTankTimeMs,
        label = Lang:t('info.filling_air'),
        useWhileDead = false,
        canCancel = true,
        anim = {
            dict = 'clothingshirt',
            clip = 'try_shirt_positive_d',
            blendIn = 8.0
        }
    }) then

        oxygenLevel = config.startingOxygenLevel
        qBCore.Functions.Notify(Lang:t('success.tube_filled'), 'success')
        if currentGear.enabled then
            enableScuba()
        end
        return true
    end
end)

local function deleteGear()
	if currentGear.mask ~= 0 then
        DetachEntity(currentGear.mask, false, true)
        DeleteEntity(currentGear.mask)
		currentGear.mask = 0
    end

	if currentGear.tank ~= 0 then
        DetachEntity(currentGear.tank, false, true)
        DeleteEntity(currentGear.tank)
		currentGear.tank = 0
	end
end

local function attachGear()
    local maskModel = `p_d_scuba_mask_s`
    local tankModel = `p_s_scuba_tank_s`
    lib.requestModel(maskModel)
    lib.requestModel(tankModel)

    currentGear.tank = CreateObject(tankModel, 1.0, 1.0, 1.0, true, true, false)
    local bone1 = GetPedBoneIndex(cache.ped, 24818)
    AttachEntityToEntity(currentGear.tank, cache.ped, bone1, -0.25, -0.25, 0.0, 180.0, 90.0, 0.0, true, true, false, false, 2, true)

    currentGear.mask = CreateObject(maskModel, 1.0, 1.0, 1.0, true, true, false)
    local bone2 = GetPedBoneIndex(cache.ped, 12844)
    AttachEntityToEntity(currentGear.mask, cache.ped, bone2, 0.0, 0.0, 0.0, 180.0, 90.0, 0.0, true, true, false, false, 2, true)
end

local function takeOffSuit()
    if lib.progressBar({
        duration = config.TakeOffSuitTimeMs,
        label = Lang:t('info.pullout_suit'),
        useWhileDead = false,
        canCancel = true,
        anim = {
            dict = 'clothingshirt',
            clip = 'try_shirt_positive_d',
            blendIn = 8.0
        }
    }) then
        SetEnableScuba(cache.ped, false)
        SetPedMaxTimeUnderwater(cache.ped, 50.00)
        currentGear.enabled = false
        deleteGear()
        qBCore.Functions.Notify(Lang:t('success.took_out'))
        TriggerServerEvent('InteractSound_SV:PlayOnSource', nil, 0.25)
    end
end

local function startOxygenLevelDrawTextThread()
    CreateThread(function()
        while currentGear.enabled do
            if IsPedSwimmingUnderWater(cache.ped) then
                DrawText2D(oxygenLevel..'⏱', vec2(1.0, 1.42), 1.0, 1.0, 0.45, 4)
            end
            Wait(0)
        end
    end)
end

local function startOxygenLevelDecrementerThread()
    CreateThread(function()
        while currentGear.enabled do
            if IsPedSwimmingUnderWater(cache.ped) and oxygenLevel > 0 then
                oxygenLevel -= 1
                if oxygenLevel % 10 == 0 and oxygenLevel ~= config.startingOxygenLevel then
                    TriggerServerEvent('InteractSound_SV:PlayOnSource', 'breathdivingsuit', 0.25)
                end
                if oxygenLevel == 0 then
                    disableScuba()
                    TriggerServerEvent('InteractSound_SV:PlayOnSource', nil, 0.25)
                end
            end
            Wait(1000)
        end
    end)
end

local function putOnSuit()
    if oxygenLevel <= 0 then
        qBCore.Functions.Notify(Lang:t('error.need_otube'), 'error')
        return
    end

    if IsPedSwimming(cache.ped) or cache.vehicle then
        qBCore.Functions.Notify(Lang:t('error.not_standing_up'), 'error')
        return
    end

    if lib.progressBar({
        duration = config.PutOnSuitTimeMs,
        label = Lang:t('info.put_suit'),
        useWhileDead = false,
        canCancel = true,
        anim = {
            dict = 'clothingshirt',
            clip = 'try_shirt_positive_d',
            blendIn = 8.0
        }
    }) then
        deleteGear()
        attachGear()
        enableScuba()
        currentGear.enabled = true
        TriggerServerEvent('InteractSound_SV:PlayOnSource', 'breathdivingsuit', 0.25)
        startOxygenLevelDecrementerThread()
        startOxygenLevelDrawTextThread()
    end
end

RegisterNetEvent('popcornrp-divegear:client:useGear', function()
    if currentGear.enabled then
        takeOffSuit()
    else
        putOnSuit()
    end
end)