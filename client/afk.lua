if not Config.AFK.Enabled then return end

local TMC = exports.core:getCoreObject()
local isWarningActive = false

CreateThread(function()
    while true do
        Wait(Config.AFK.CheckInterval * 1000)

        local idleTime = GetTimeSinceLastInput() / 1000

        if IsPauseMenuActive() and not Config.AFK.CountPauseMenu then
            idleTime = 0
        end
        
        TMC.Functions.TriggerServerEvent('cdocc-addons:server:UpdateAFKStatus', idleTime)
    end
end)

RegisterNetEvent('cdocc-addons:client:AFKWarning', function(remainingTime)
    if isWarningActive then return end
    
    isWarningActive = true
    local warningDurationMs = remainingTime * 1000
    local timeRemaining = warningDurationMs
    
    TMC.Functions.SimpleNotify(string.format(Config.AFK.WarningMessage, remainingTime), 'error')

    CreateThread(function()
        while timeRemaining > 0 do
            Wait(100)

            if GetTimeSinceLastInput() < 1000 then
                isWarningActive = false
                return
            end
            
            timeRemaining = timeRemaining - 100
        end

        isWarningActive = false
    end)
end)

exports('GetIdleTime', function()
    return GetTimeSinceLastInput() / 1000
end)
