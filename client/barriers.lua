if not Config.BarrierRemovals.Enabled then return end

CreateThread(function()
    for i = 1, #Config.BarrierRemovals.Barriers do
        local barrier = Config.BarrierRemovals.Barriers[i]
        CreateModelHide(barrier.coords, barrier.radius, barrier.model, true)
    end
end)
