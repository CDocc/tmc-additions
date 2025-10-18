local TMC = exports.core:getCoreObject()

AddEventHandler('core_game:deathState', function(dead)
	if dead == "stage2" then
		exports['pma-voice']:overrideProximityCheck(function()
            return false
        end)
	else
		exports['pma-voice']:resetProximityCheck()
	end
end)

RegisterCommand("copycsn", function()
    local csnString = LocalPlayer.state.citizenid
    TMC.Functions.Clipboard(csnString, "Citizen ID (CSN)")
end)

TriggerEvent('chat:addSuggestion', '/copycsn', 'Copy your Citizen Id (CSN) to your clipboard.', {})