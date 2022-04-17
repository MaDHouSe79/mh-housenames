# QB House Names
- A easy way to interact with houses.
- You just have to press [E] to buy a house.

# NOTE
- To make this script work you need to add houses with the realestate job, only then you can use this script.

# Install QB Housenames
- add the qb-housenames.sql to your correct database
- Add this to resources/[qb]/qb-houses/locales/en.lua file, or your language file.
- in Translations error = { }
```lua
["has_a_house"] = "You already have a House",
```

- You have to change this same function in resources/[qb]/qb-houses/server/main.lua file, someware around line 145
- replace that function for this function below. 
- this immediately solves the problem that you could buy the same house twice, with the Buy house NUI. 
```lua
local function isHouseOwned(house)
    local result = MySQL.Sync.fetchAll("SELECT owned FROM houselocations WHERE name = ?", {house})
    Wait(500)
    if result[1] and result[1].owned == 1 then
        return true
    end
    return false
end
```

- Add this function in resources/[qb]/qb-houses/server/main.lua file., below the isHouseOwned function
```lua
local function hasAHouse(citizenid)
    local result = MySQL.Sync.fetchAll('SELECT * FROM player_houses WHERE citizenid = ?', {citizenid})
    Wait(500)
    if result[1] and result[1].citizenid == citizenid then
        return true
    end
    return false
end
```

- Add this to resources/[qb]/qb-houses/server/main.lua file, around line 285
- under the RegisterNetEvent `qb-houses:server:buyHouse`
```lua
RegisterNetEvent('qb-houses:server:buyHouse2', function(house)
    local src         = source
    local pData       = QBCore.Functions.GetPlayer(src)
    local price       = house.price
    local HousePrice  = math.ceil(price * 1.21)
    local bankBalance = pData.PlayerData.money["bank"]

    local hasHouse = hasAHouse(pData.PlayerData.citizenid)
    if hasHouse then
        TriggerClientEvent('QBCore:Notify', src, Lang:t("error.has_a_house"), "error")
        Wait(100)
        TriggerClientEvent('qb-housenames:client:RefreshHouses', -1)
        return
    end

    local isOwned = isHouseOwned(house.name)
    if isOwned then
        TriggerClientEvent('QBCore:Notify', src, Lang:t("error.already_owned"), "error")
        Wait(100)
        TriggerClientEvent('qb-housenames:client:RefreshHouses', -1)
        return
    end

    if (bankBalance >= HousePrice) then
        houseowneridentifier[house.name] = pData.PlayerData.license
        houseownercid[house.name] = pData.PlayerData.citizenid
        housekeyholders[house.name] = {
            [1] = pData.PlayerData.citizenid
        }
        MySQL.Async.insert('INSERT INTO player_houses (house, identifier, citizenid, keyholders) VALUES (?, ?, ?, ?)',{
            house.name, 
            pData.PlayerData.license, 
            pData.PlayerData.citizenid, 
            json.encode(housekeyholders[house.name])
        })
        MySQL.Async.execute('UPDATE houselocations SET owned = ? WHERE name = ?', {1, house.name})
        TriggerClientEvent('qb-houses:client:SetClosestHouse', src)
        pData.Functions.RemoveMoney('bank', HousePrice, "bought-house") -- 21% Extra house costs
        TriggerEvent('qb-bossmenu:server:addAccountMoney', "realestate", (HousePrice / 100) * math.random(18, 25))
        Wait(1000)
        TriggerClientEvent('qb-housenames:client:RefreshHouses', -1)
    else
        TriggerClientEvent('QBCore:Notify', source, Lang:t("error.not_enough_money"), "error")
    end
end)
```
