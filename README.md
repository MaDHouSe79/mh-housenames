<p align="center">
    <img width="140" src="https://icons.iconarchive.com/icons/iconarchive/red-orb-alphabet/128/Letter-M-icon.png" />  
    <h1 align="center">Hi 👋, I'm MaDHouSe</h1>
    <h3 align="center">A passionate allround developer </h3>    
</p>

<p align="center">
  <a href="https://github.com/MaDHouSe79/mh-housenames/issues">
    <img src="https://img.shields.io/github/issues/MaDHouSe79/mh-housenames"/> 
  </a>
  <a href="https://github.com/MaDHouSe79/mh-housenames/network/members">
    <img src="https://img.shields.io/github/forks/MaDHouSe79/mh-housenames"/> 
  </a>  
  <a href="https://github.com/MaDHouSe79/mh-housenames/stargazers">
    <img src="https://img.shields.io/github/stars/MaDHouSe79/mh-housenames?color=white"/> 
  </a>
  <a href="https://github.com/MaDHouSe79/mh-housenames/blob/main/LICENSE">
    <img src="https://img.shields.io/github/license/MaDHouSe79/mh-housenames?color=black"/> 
  </a>      
</p>

<p align="center">
  <img alig src="https://github-profile-trophy.vercel.app/?username=MaDHouSe79&margin-w=15&column=6" />
</p>

<p align="center">
  <img alig src="https://raw.githubusercontent.com/kamranahmedse/driver.js/master/demo/images/split.png" />
</p>

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

## 🐞 Any bugs issues or suggestions, let my know.
- If you have any suggestions or nice ideas let me know and we can see what we can do 👊😎

## 🙈 Youtube
- [Youtube](https://www.youtube.com/channel/UC6431XeIqHjswry5OYtim0A)
