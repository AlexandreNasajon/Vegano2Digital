local Player = require("Player")
local Screens = {}

--Tela de Pack
Screens.Pack = {}
Screens.Pack.name = "Pack"
Screens.Pack.question = "Your pack has:"

--Tela de Quest
Screens.Quest = {}
Screens.Quest.name = "Quest"
Screens.Quest.question = "You wish to go on a quest! Where would you like to go?"

--Tela de Sword
Screens.Swords = {Items.bronze_sword,Items.silver_sword,Items.golden_sword} 
Screens.Swords.name = "Swords"
Screens.Swords.question = "It is a dangerous world..."
--Tela de Armor
Screens.Armors = {Items.bronze_armor,Items.silver_armor,Items.golden_armor}   
Screens.Armors.name = "Armors"
Screens.Armors.question = "Protect yourself!"
--Tela do Shop
Screens.Shop = {Screens.Swords,Screens.Armors}
Screens.Shop.name = "Shop"
Screens.Armors.parent = Screens.Shop
Screens.Swords.parent = Screens.Shop
Screens.Shop.question = "What do you wish to buy?"  

--Tela Inicial
Screens.Inicial = {Screens.Shop,Screens.Pack,Screens.Quest}
Screens.Inicial.question = "Choose your own path."
Screens.Inicial.parent = nil
Screens.Pack.parent = Screens.Inicial
Screens.Quest.parent = Screens.Inicial
Screens.Shop.parent = Screens.Inicial

return Screens
