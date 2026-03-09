--╔════════════════════════════════════════╗                                        
--║           Read Plate Command           ║
--║       /rp to read rear license plate   ║
--║       /fp to read front license plate  ║
--╚════════════════════════════════════════╝


RegisterCommand('rp', function(source, args, rawCommand)
    local playerPed = PlayerPedId()
    local coords = GetEntityCoords(playerPed)
    local behind = GetOffsetFromEntityInWorldCoords(playerPed, 0.0, -5.0, 0.0)
    local rayHandle = StartShapeTestRay(coords.x, coords.y, coords.z, behind.x, behind.y, behind.z, 10, playerPed, 0)
    local _, hit, endCoords, surfaceNormal, entityHit = GetShapeTestResult(rayHandle)
    
    if hit == 1 and DoesEntityExist(entityHit) and IsEntityAVehicle(entityHit) then
        local plate = GetVehicleNumberPlateText(entityHit)
        exports['jd_lib']:notify({
            title       = 'Rear Plate Reader',
            description = 'Rear Plate: ' .. plate,
            type        = 'info',
            duration    = 6000,
        })
    else
        exports['jd_lib']:notify({
            title = 'Rear Plate Reader',
            description = 'No vehicle found behind you.',
            type  = 'error',
            duration = 4000,
        })
    end
end, false)

RegisterCommand('fp', function(source, args, rawCommand)
    local playerPed = PlayerPedId()
    local coords = GetEntityCoords(playerPed)
    local front = GetOffsetFromEntityInWorldCoords(playerPed, 0.0, 5.0, 0.0)
    local rayHandle = StartShapeTestRay(coords.x, coords.y, coords.z, front.x, front.y, front.z, 10, playerPed, 0)
    local _, hit, endCoords, surfaceNormal, entityHit = GetShapeTestResult(rayHandle)
    
    if hit == 1 and DoesEntityExist(entityHit) and IsEntityAVehicle(entityHit) then
        local plate = GetVehicleNumberPlateText(entityHit)
        exports['jd_lib']:notify({
            title       = 'Front Plate Reader',
            description = 'Front Plate: ' .. plate,
            type        = 'info',
            duration    = 6000,
        })
    else
        exports['jd_lib']:notify({
            title = 'Front Plate Reader',
            description = 'No vehicle found in front of you.',
            type  = 'error',
            duration = 4000,
        })
    end
end, false)
