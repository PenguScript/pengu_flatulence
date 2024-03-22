local audioCount, distMin, distMax = 9, 4.0, 8.0
local DoPoo = true
local PooCleanTime = 20000 --20 seconds

local function RollChanceToShart()
    math.randomseed(GetGameTimer())
    local ran = math.random(2)
    if ran == 1 then return math.random(distMin, distMax), math.random(audioCount) end
    return false
end

local function MakeADoodie()
    local playerPed = PlayerPedId()
    local coords    = GetEntityCoords(playerPed)
    local forward   = GetEntityForwardVector(playerPed)
    local x, y, z   = table.unpack(coords - forward * 1.0)
    local poo = 'prop_big_shit_01'
    RequestModel(poo)
    while (not HasModelLoaded(poo)) do
        Wait(1)
    end
    local bigpoo = CreateObject(poo, x, y, z, true, false, true)
    PlaceObjectOnGroundProperly(bigpoo)
    SetEntityAsMissionEntity(bigpoo)
    Wait(PooCleanTime)
    if DoesEntityExist(bigpoo) then
        DeleteEntity(bigpoo)
    end
end

AddEventHandler('entityDamaged', function(victim, culprit, weapon, damage)
    if weapon == -842959696 then
        local ped = PlayerPedId()
        local dist, sound = RollChanceToShart()
        if not dist then return end
        RequestScriptAudioBank('audiodirectory/pengu_farts', true)
        Wait(1)
        local id = GetSoundId()
        local coords = GetEntityCoords(ped)
        Wait(500)
        PlaySoundFromCoord(id, tostring(sound), coords.x, coords.y, coords.z, 'special_soundset', 0, dist, 0)
        if DoPoo then
            MakeADoodie()
        end
        ReleaseSoundId(id)
        ReleaseNamedScriptAudioBank('audiodirectory/pengu_farts')
    end
end)