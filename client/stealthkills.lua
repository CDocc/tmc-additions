if not Config.StealthKills.Enabled then return end

CreateThread(function()
    for k, v in pairs(Config.StealthKills.Hashes) do
        local killHash = GetHashKey(v)
        RemoveStealthKill(killHash, true)
    end
end)