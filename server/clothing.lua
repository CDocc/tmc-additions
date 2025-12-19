TMC = exports.core:getCoreObject()

TMC.Commands.Add("copyoutfit", "Copy outfit data to clipboard", {{name="id", help="Player ID"}}, false, function(source, args)
    local targetId = source
    
    if args[1] then
        local targetServerId = tonumber(args[1])
        if targetServerId then
            local targetPlayer = TMC.Functions.GetPlayer(targetServerId)
            if targetPlayer then
                targetId = targetServerId
            else
                TMC.Functions.SimpleNotify(source, "Player not found", "error")
                return
            end
        else
            TMC.Functions.SimpleNotify(source, "Invalid player ID", "error")
            return
        end
    end
    
    TriggerClientEvent("outfitcopier:copyOutfit", targetId, source)
end, "god")

