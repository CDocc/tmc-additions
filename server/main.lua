local TMC = exports.core:getCoreObject()

TMC.Commands.Add('setbucket', "Set a players routing bucket", {{name="id", help="Player ID"}, {name="bucket", help="Bucket ID (number)"}}, true, function(source, args)
    local target = tonumber(source)
    if args[1] then
        target = tonumber(args[1])
    end

    local bucketId = tonumber(args[2]) or 0

    local Target = TMC.Functions.GetPlayer(target)
    if Target ~= nil then
        SetPlayerRoutingBucket(target, bucketId)
        TMC.Functions.TriggerEvent("tmc:log", "staff", "Set Bucket", "blue", "**"..Player(source).state.name .. "** ("..Player(source).state.citizenid..") has set **"..Target.PlayerData.name.."**'s routing bucket to "..bucketId.." using the /setbucket command.")
        TriggerClientEvent('chatMessage', source, "SYSTEM", "success", "Player's routing bucket set to: " .. bucketId)
    else
        TriggerClientEvent('chatMessage', source, "SYSTEM", "error", "Player is not online")
    end
end, 'god')