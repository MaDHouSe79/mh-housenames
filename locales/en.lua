--[[ ===================================================== ]]--
--[[          QBCore Housenames Script by MaDHouSe         ]]--
--[[ ===================================================== ]]--

local Translations = {
    error = {
        ["not_enough_money"]   = "You dont have enough money..",
        ["already_owned"]      = "This house is already owned!",
        ["has_a_house"]        = "You already have a House",
    },
    
    info = {
        ["street"]             = "~b~%{street}~s~",
        ["owner"]              = "Owned by ~g~%{owner}~s~",
        ["forsale"]            = "For sale ~g~$%{amount}~s~",
        ["seller"]             = "Seller ~b~%{seller}~s~",
        ["buy"]                = "[~b~E~s~] - ~b~Buy~s~",
        ["move"]               = "[~y~F~s~] - ~y~Move~s~",
        ["view"]               = "[~y~F~s~] - ~y~View~s~",
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