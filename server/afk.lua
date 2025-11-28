if not Config.AFK.Enabled then return end

local afkPlayers = {}

local function IsExempt(source)
    if not Config.AFK.ExemptPermission then
        return false
    end

    return TMC.Functions.HasPermission(source, Config.AFK.ExemptPermission) or IsPlayerAceAllowed(source, Config.AFK.ExemptPermission)
end

TMC.Functions.RegisterServerEvent('cdocc-addons:server:UpdateAFKStatus', function(source, idleTime)
    if not afkPlayers[source] then
        afkPlayers[source] = {
            idleTime = 0,
            warningGiven = false
        }
    end
    
    afkPlayers[source].idleTime = idleTime

    if idleTime >= Config.AFK.WarningTime and not afkPlayers[source].warningGiven then
        afkPlayers[source].warningGiven = true
        local remainingTime = Config.AFK.MaxIdleTime - idleTime
        TriggerClientEvent('cdocc-addons:client:AFKWarning', source, math.floor(remainingTime))
        
        local playerName = GetPlayerName(source)
        print(string.format('[AFK] Warning sent to %s (%s) - Idle for %d seconds', playerName, source, math.floor(idleTime)))
    end

    if idleTime >= Config.AFK.MaxIdleTime and not IsExempt(source) then
        local playerName = GetPlayerName(source)
        print(string.format('[AFK] Kicking %s (%s) for being AFK - Idle for %d seconds', playerName, source, math.floor(idleTime)))
        
        DropPlayer(source, Config.AFK.KickMessage)
        afkPlayers[source] = nil
    end
end)

AddEventHandler('playerDropped', function(reason)
    local source = source
    if afkPlayers[source] then
        afkPlayers[source] = nil
    end
end)

TMC.Commands.Add('afkcheck', 'Check AFK status of all players (Admin Only)', {}, false, function(source, args)
    if not IsExempt(source) then
        TriggerClientEvent('TMC:SimpleNotify', source, "You don't have permission to use this command.", 'error')
        return
    end
    
    TriggerClientEvent('TMC:SimpleNotify', source, "=== AFK Players ===", 'info')
    
    local foundAFK = false
    for playerId, data in pairs(afkPlayers) do
        if data.idleTime > 60 then
            foundAFK = true
            local playerName = GetPlayerName(playerId)
            local minutes = math.floor(data.idleTime / 60)
            local seconds = math.floor(data.idleTime % 60)
            
            TriggerClientEvent('TMC:SimpleNotify', source, string.format("%s is AFK for %dm %ds", playerName, minutes, seconds), 'info')
        end
    end
    
    if not foundAFK then
        TriggerClientEvent('TMC:SimpleNotify', source, "No players are currently AFK.", 'info')
    end
end, 'admin')

exports('GetPlayerIdleTime', function(source)
    return afkPlayers[source] and afkPlayers[source].idleTime or 0
end)

exports('ResetPlayerAFK', function(source)
    if afkPlayers[source] then
        afkPlayers[source].idleTime = 0
        afkPlayers[source].warningGiven = false
    end
end)

print('[AFK System] Loaded - Max idle time: ' .. Config.AFK.MaxIdleTime .. ' seconds')
