if not Config.AFK.Enabled then return end

local TMC = exports.core:getCoreObject()
local warningShown = false

CreateThread(function()
    while true do
        Wait(Config.AFK.CheckInterval * 1000)

        local idleTime = GetTimeSinceLastInput() / 1000
        
        -- if pause menu is open and we're counting it as AFK
        if Config.AFK.CountPauseMenu and IsPauseMenuActive() then
            -- use the actual idle time (pause menu counts as AFK)
        elseif IsPauseMenuActive() then
            -- reset the idle time to 0 if pause menu is open and we're not counting it
            idleTime = 0
        end
        
        TMC.Functions.TriggerServerEvent('cdocc-addons:server:UpdateAFKStatus', idleTime)

        if idleTime < Config.AFK.WarningTime then
            warningShown = false
        end
    end
end)

RegisterNetEvent('cdocc-addons:client:AFKWarning', function(remainingTime)
    if not warningShown then
        warningShown = true
        TMC.Functions.SimpleNotify(string.format(Config.AFK.WarningMessage, remainingTime), 'error')
    end
end)

exports('GetIdleTime', function()
    return GetTimeSinceLastInput() / 1000
end)
