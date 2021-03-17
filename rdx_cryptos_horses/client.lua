RDX = nil
Citizen.CreateThread(function()
	while RDX == nil do
		TriggerEvent('rdx:getSharedObject', function(obj) RDX = obj end)
		Citizen.Wait(100)
	end
end)

local Horses = {}
  
function Brush(player, horse)
    Citizen.InvokeNative(0xCD181A959CFDD7F4, player, horse, GetHashKey("INTERACTION_BRUSH"), 0, 0)
    if Horses[horse] == 0 then
        Wait(8000)
        ClearPedEnvDirt(horse)
        brushcount = 1
    elseif Horses[horse] > 0 then
        Wait(8000)
        Citizen.InvokeNative(0xE3144B932DFDFF65, horse, 0.0, -1, 1, 1)
        ClearPedEnvDirt(horse)
        ClearPedDamageDecalByZone(horse ,10 ,"ALL")
        ClearPedBloodDamage(horse)
        Citizen.InvokeNative(0xD8544F6260F5F01E, horse, 10)
        Horses[horse] = 0
    end
end

function Feed(player, horse, increase)
    TriggerServerEvent("cryptos_horses:Consume")
    Citizen.InvokeNative(0xCD181A959CFDD7F4, player, horse, -224471938, 0, 0)
    Wait(5000)
    PlaySoundFrontend("Core_Fill_Up", "Consumption_Sounds", true, 0)
    local Health = GetAttributeCoreValue(horse, 0)
    local newHealth = Health + increase
    local Stamina = GetAttributeCoreValue(horse, 0)
    local newStamina = Stamina + increase
    Citizen.InvokeNative(0xC6258F41D86676E0, horse, 0, newHealth) --core
    Citizen.InvokeNative(0xC6258F41D86676E0, horse, 1, newStamina) --core
end

function Feed2(player, horse, increase)
    TriggerServerEvent("cryptos_horses:Consume2")
    Citizen.InvokeNative(0xCD181A959CFDD7F4, player, horse, -224471938, 0, 0)
    Wait(5000)
    PlaySoundFrontend("Core_Fill_Up", "Consumption_Sounds", true, 0)
    local Health = GetAttributeCoreValue(horse, 0)
    local newHealth = Health + increase
    local Stamina = GetAttributeCoreValue(horse, 0)
    local newStamina = Stamina + increase
    Citizen.InvokeNative(0xC6258F41D86676E0, horse, 0, newHealth) --core
    Citizen.InvokeNative(0xC6258F41D86676E0, horse, 1, newStamina) --core
end

RegisterNetEvent('cryptos_horses:Brush')
AddEventHandler('cryptos_horses:Brush', function (horse)
    local player = PlayerPedId()
    local horse = GetLastMount(player)
    local coords = GetEntityCoords(player)
    local coordshorse = GetEntityCoords(horse)
    local distance = #(coords - coordshorse)        
        
    if distance < 2.0 then            
            Brush(player, horse)        
    elseif IsPedOnMount(player) then
            Brush(player, horse)
        
    end
end)

RegisterNetEvent('cryptos_horses:Feed')   
AddEventHandler('cryptos_horses:Feed', function(horse, increase)
    local player = PlayerPedId()
    local horse = GetLastMount(player)
    local coords = GetEntityCoords(player)
    local coordshorse = GetEntityCoords(horse)
    local distance = #(coords - coordshorse)
 
          if distance < 2.0 then        
            Feed(player, horse, increase)        
    elseif IsPedOnMount(player) then           
            Feed(player, horse, increase) 
    end
end)

RegisterNetEvent('cryptos_horses:Feed2')   
AddEventHandler('cryptos_horses:Feed2', function(horse, increase)
    local player = PlayerPedId()
    local horse = GetLastMount(player)
    local coords = GetEntityCoords(player)
    local coordshorse = GetEntityCoords(horse)
    local distance = #(coords - coordshorse)
 
          if distance < 2.0 then        
            Feed2(player, horse, increase)        
    elseif IsPedOnMount(player) then           
            Feed2(player, horse, increase) 
    end
end)

function GetLastMount(ped)
	return Citizen.InvokeNative(0x4C8B59171957BCF7, ped)
end
