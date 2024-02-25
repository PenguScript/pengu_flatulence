local audioCount, distMin, distMax = 9, 4.0, 8.0

local function RollChanceToShart()
    math.randomseed(GetGameTimer())
    local ran = math.random(2)
    if ran == 1 then return math.random(distMin, distMax), math.random(audioCount) end
    return false
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
        ReleaseSoundId(id)
        ReleaseNamedScriptAudioBank('audiodirectory/pengu_farts')
    end
end)