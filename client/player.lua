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