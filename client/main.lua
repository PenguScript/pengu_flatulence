local audioCount = 9 -- DO NOT CHANGE UNLESS YOU KNOW WHAT YOU'RE DOING!!!!!
local distMin = 4.0
local distMax = 8.0


local function RollChanceToShart()
    local ran = math.random(1, 2)
    if ran == ran then
        return math.random(distMin, distMax), math.random(audioCount)
    else
        return false
    end
end

AddEventHandler('entityDamaged', function(victim, culprit, weapon, damage)
    if weapon == -842959696 then
        local ped = PlayerPedId()
        RequestScriptAudioBank('audiodirectory/pengu_farts', true)
        Wait(1)
        local id = GetSoundId()
        local coords = GetEntityCoords(ped)
        local dist, sound = RollChanceToShart()
        if dist == false then return end
        Wait(500)
        PlaySoundFromCoord(id, tostring(sound), coords.x, coords.y, coords.z, 'special_soundset', 0, dist, 0)
        ReleaseSoundId(id)
        ReleaseNamedScriptAudioBank('audiodirectory/pengu_farts')
    end
end)
