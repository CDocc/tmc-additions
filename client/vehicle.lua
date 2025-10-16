if not Config.Vehicle.Enabled then return end

CreateThread(function()
    while true do
        Wait(Config.Vehicle.ConfigUpdateInterval)
        
        local ped = PlayerPedId()

        if Config.Vehicle.DisableAutoStart then
            SetPedConfigFlag(ped, 429, true)
        end
        
        if Config.Vehicle.DisableAutoOff then
            SetPedConfigFlag(ped, 241, true)
        end

        if Config.Vehicle.DisableHelmetArmor then
            SetPedConfigFlag(ped, 438, false)
        end
        
        if Config.Vehicle.DisableBikeAndAircraftHelmets then
            SetPedConfigFlag(ped, 35, false)
        end

        if Config.Vehicle.DisableAircraftMusic then
            SetAudioFlag('DisableFlightMusic', true)
        end
    end
end)

if Config.Vehicle.DisableDriveBy then
    CreateThread(function()
        while true do
            Wait(0)
            local ped = PlayerPedId()
            if IsPedInAnyVehicle(ped, false) then
                SetPlayerCanDoDriveBy(PlayerId(), false)
            end
        end
    end)
end

if Config.Vehicle.EnableHeliSubmix then
    local heliSubmixActive = false
    local currentVehicle = nil

    local function EnableSubmix()
        SetAudioSubmixEffectRadioFx(0, 0)
        SetAudioSubmixEffectParamInt(0, 0, `default`, 1)
        SetAudioSubmixEffectParamFloat(0, 0, `freq_low`, 1200.0)
        SetAudioSubmixEffectParamFloat(0, 0, `freq_hi`, 9000.0)
        SetAudioSubmixEffectParamFloat(0, 0, `fudge`, 0.5)
        SetAudioSubmixEffectParamFloat(0, 0, `rm_mix`, 20.0)
        heliSubmixActive = true
    end

    local function DisableSubmix()
        SetAudioSubmixEffectRadioFx(0, 0)
        SetAudioSubmixEffectParamInt(0, 0, `enabled`, 0)
        heliSubmixActive = false
    end

    DisableSubmix()

    AddEventHandler('gameEventTriggered', function(name, args)
        if name == 'CEventNetworkPlayerEnteredVehicle' and args[1] == PlayerId() then
            local vehicle = args[2]
            local vehModel = GetEntityModel(vehicle)
            local isHeli = IsThisModelAHeli(vehModel)
            local isPlane = IsThisModelAPlane(vehModel)

            if isHeli or isPlane then
                currentVehicle = vehicle

                CreateThread(function()
                    while IsPedInAnyVehicle(PlayerPedId(), false) and currentVehicle == vehicle do
                        local engineRunning = GetIsVehicleEngineRunning(vehicle)
                        
                        if engineRunning and not heliSubmixActive then
                            EnableSubmix()
                        elseif not engineRunning and heliSubmixActive then
                            DisableSubmix()
                        end
                        
                        Wait(Config.Vehicle.SubmixCheckInterval)
                    end

                    if heliSubmixActive then
                        DisableSubmix()
                    end
                    currentVehicle = nil
                end)
            else
                if heliSubmixActive then
                    DisableSubmix()
                end
            end
        end
    end)
end
