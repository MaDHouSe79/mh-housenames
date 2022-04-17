--[[ ===================================================== ]]--
--[[          QBCore Housenames Script by MaDHouSe         ]]--
--[[ ===================================================== ]]--

local Translations = {
    error = {
        ["not_enough_money"]   = "Je hebt niet genoeg geld..",
        ["already_owned"]      = "Dit huis is al in bezit!",
        ["has_a_house"]        = "Je hebt al een huis",
    },

    info = {
        ["street"]             = "~b~%{street}~s~",
        ["owner"]              = "Eigenaar ~g~%{owner}~s~",
        ["forsale"]            = "Te Koop ~g~€%{amount}~s~",
        ["seller"]             = "Verkoper ~b~%{seller}~s~",
        ["buy"]                = "[~g~E~s~] - ~g~Koop~s~",
        ["move"]               = "[~y~F~s~] - ~y~Verhuizen~s~",
        ["view"]               = "[~y~F~s~] - ~y~Bekijk~s~",
        ["price"]              = "$%{price}",
    },

    log = {
        ["house_created"]      = "House Created:",
        ["house_address"]      = "**Address**: %{label}\n\n**Listing Price**: %{price}\n\n**Tier**: %{tier}\n\n**Listing Agent**: %{agent}",
        ["house_purchased"]    = "House Purchased:",
        ["house_purchased_by"] = "**Address**: %{house}\n\n**Purchase Price**: %{price}\n\n**Purchaser**: %{firstname} %{lastname}"
    }
}

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})  