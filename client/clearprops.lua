if not Config.ClearProps.Enabled then return end

local TMC = exports.core:getCoreObject()

local reloadSkinTimer = GetGameTimer()

local function InCooldown()
    return (GetGameTimer() - reloadSkinTimer) < Config.ClearProps.Cooldown
end

local function clearStuckProps()
    if InCooldown() or TMC.Functions.IsDead() then
        TMC.Functions.SimpleNotify('Please wait a moment before trying again.', 'error')
        return
    end

    reloadSkinTimer = GetGameTimer()

    for _, v in pairs(GetGamePool("CObject")) do
        if IsEntityAttachedToEntity(PlayerPedId(), v) then
            SetEntityAsMissionEntity(v, true, true)
            DeleteObject(v)
            DeleteEntity(v)
        end
    end
    
    TMC.Functions.SimpleNotify('Cleared stuck props.', 'success')
end

RegisterCommand("clearstuckprops", function(source, args)
    clearStuckProps()
end)

TriggerEvent('chat:addSuggestion', '/clearstuckprops', 'Clear any props or objects which are stuck to you.', {})

-- Export for other resources
exports('ClearStuckProps', clearStuckProps)
