--[[ ===================================================== ]]--
--[[          QBCore Housenames Script by MaDHouSe         ]]--
--[[ ===================================================== ]]--

local Translations = {
    error = {
        ["not_enough_money"]   = "No tienes suficiente dinero..",
        ["already_owned"]      = "Esta casa ya tiene propietario!",
        ["has_a_house"]        = "Tu ya tienes una casa",
    },
    
    info = {
        ["street"]             = "~b~%{calle}~s~",
        ["owner"]              = "Propiedad de ~g~%{owner}~s~",
        ["forsale"]            = "A la venta por ~g~$%{amount}~s~",
        ["seller"]             = "Vendedor ~b~%{seller}~s~",
        ["buy"]                = "[~b~E~s~] - ~b~Comprar~s~",
        ["move"]               = "[~y~F~s~] - ~y~Mudarte~s~",
        ["view"]               = "[~y~F~s~] - ~y~Ver~s~",
        ["price"]              = "$%{price}",
    },

    log = {
        ["house_created"]      = "Casa Creada:",
        ["house_address"]      = "**Direccion**: %{label}\n\n**Precio**: %{price}\n\n**Tier**: %{tier}\n\n**Comercial**: %{agent}",
        ["house_purchased"]    = "House Purchased:",
        ["house_purchased_by"] = "**Direccion**: %{house}\n\n**Precio de Compra**: %{price}\n\n**Comprador**: %{firstname} %{lastname}"
    }
}


Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})   
