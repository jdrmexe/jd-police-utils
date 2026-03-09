--╔════════════════════════════════════════╗                                      
--║        Gun Shot Residue Checker        ║ 
--║   /checkgsr to see if they have shot   ║
--║      within the last 10 minutes        ║
--╚════════════════════════════════════════╝

RegisterCommand('checkgsr', function(source, args, rawCommand)
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)
    local players = GetActivePlayers()
    local closestPlayer = nil
    local closestDist = 3.0

    for _, i in ipairs(players) do
        local targetPed = GetPlayerPed(i)
        if targetPed ~= playerPed then
            local targetCoords = GetEntityCoords(targetPed)
            local dist = #(playerCoords - targetCoords)
            if dist < closestDist and dist < 3.0 then
                closestDist = dist
                closestPlayer = i
            end
        end
    end

    if closestPlayer then
        local name = GetPlayerName(closestPlayer)
        local id = GetPlayerServerId(closestPlayer)
        exports['jd_lib']:notify({
            title = 'GSR Checker',
            description = ('Checking %s [ID: %s] for gun shot residue...'):format(name, id),
            type = 'info',
            duration = 3500,
        })
        TriggerServerEvent('checkgsr:request', id)
    else
        exports['jd_lib']:notify({
            title = 'GSR Checker',
            description = 'No player found nearby.',
            type = 'error',
            duration = 4000,
        })
    end
end, false)

-- Listen for notification from the server
RegisterNetEvent('checkgsr:notify')
AddEventHandler('checkgsr:notify', function(playerName, playerId)
    exports['jd_lib']:notify({
        title       = 'GSR Result',
        description = ('%s [ID: %s] has fired a gun in the last 10 minutes!'):format(playerName, playerId or "unknown"),
        type        = 'success',
        duration    = 5000,
    })
end)