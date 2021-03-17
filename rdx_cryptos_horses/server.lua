RDX = nil
TriggerEvent('rdx:getSharedObject', function(obj) RDX = obj end)


RDX.RegisterUsableItem('item_horse_brush', function(source)
        TriggerClientEvent('cryptos_horses:Brush', source)	
end)

RDX.RegisterUsableItem("item_wildcarrot", function(source)       
        TriggerClientEvent('cryptos_horses:Feed', source, false, Config.FeedPercentage)
end)

RDX.RegisterUsableItem("item_apple", function(source)       
        TriggerClientEvent('cryptos_horses:Feed2', source, false, Config.FeedPercentage2)
end)

RegisterServerEvent("cryptos_horses:requestbrush")
AddEventHandler("cryptos_horses:requestbrush", function(horse)
    local xPlayer = RDX.GetPlayerFromId(source)        
         if xPlayer.getInventoryItem('item_horse_brush') > 0 then
            TriggerClientEvent('cryptos_horses:Brush', source, horse)
        else
              xPlayer.showNotification( "You don\'t have a brush" , "error")            
        end    
end)

RegisterServerEvent("cryptos_horses:requestfeed")
AddEventHandler("cryptos_horses:requestfeed", function(horse)
   local xPlayer = RDX.GetPlayerFromId(source)       
        if xPlayer.getInventoryItem("item_wildcarrot") >= 1 then
            TriggerClientEvent('cryptos_horses:Feed', source, horse, Config.FeedPercentage)            
        else
              xPlayer.showNotification( "You don\'t any food for your horse" , "error")             
        end   
end)

RegisterServerEvent("cryptos_horses:requestfeed2")
AddEventHandler("cryptos_horses:requestfeed2", function(horse)
   local xPlayer = RDX.GetPlayerFromId(source)       
        if xPlayer.getInventoryItem("item_apple") >= 1 then
            TriggerClientEvent('cryptos_horses:Feed2', source, horse, Config.FeedPercentage2)            
        else
              xPlayer.showNotification( "You don\'t any food for your horse" , "error")             
        end   
end)

RegisterServerEvent("cryptos_horses:Consume")
AddEventHandler("cryptos_horses:Consume", function()
   local xPlayer = RDX.GetPlayerFromId(source)   
   xPlayer.removeInventoryItem("item_wildcarrot", 1)
    
end)

RegisterServerEvent("cryptos_horses:Consume2")
AddEventHandler("cryptos_horses:Consume2", function()
   local xPlayer = RDX.GetPlayerFromId(source)   
   xPlayer.removeInventoryItem("item_apple", 1)
    
end)


