local isUsingExtinguisher = false

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if IsControlJustPressed(1, 38) then -- Change the control code to the desired one
            if not isUsingExtinguisher then
                StartUsingExtinguisher()
            else
                StopUsingExtinguisher()
            end
        end
    end
end)

function StartUsingExtinguisher()
    isUsingExtinguisher = true
    Citizen.CreateThread(function()
        while isUsingExtinguisher do
            Citizen.Wait(0)
            local playerPed = GetPlayerPed(-1)
            local coords = GetEntityCoords(playerPed)
            DrawMarker(22, coords.x, coords.y, coords.z - 1.0, 0, 0, 0, 0, 0, 0, 0.3, 0.3, 0.3, 255, 0, 0, 200, 0, 1, 2, 0, nil, nil, 0)
            if IsEntityInArea(playerPed, coords.x, coords.y, coords.z, 1.0, 1.0, 1.0, false, true, 0) then
                local vehicle = GetVehiclePedIsIn(playerPed, false)
                if DoesEntityExist(vehicle) then
                    if GetVehicleClass(vehicle) == 8 then
                        if IsVehicleOnFire(vehicle) then
                            DisableControlAction(0, 21, true) -- Disable sprint key
                            DisableControlAction(0, 22, true) -- Disable jump key
                            DisableControlAction(0, 23, true) -- Disable enter vehicle key
                            DisableControlAction(0, 24, true) -- Disable attack key
                            SetCurrentPedWeapon(playerPed, GetHashKey("WEAPON_UNARMED"), true)
                            StartVehicleFire(vehicle)
                        end
                    end
                end
            end
        end
    end)
end

function StopUsingExtinguisher()
    isUsingExtinguisher = false
end
