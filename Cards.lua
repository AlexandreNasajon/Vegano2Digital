local Player = require("Player")
local Board = require("Board")
local Functions = require("Functions")
local Cards = {}

--ANIMALS
Cards.Crocodile = {
    name = "Crocodile",
    type = "Animal",
    environment = "Swamp",
    points = 4,
    text = "Its able to replace each of their 80 teeth up to 50 times"
}

Cards.Monkey = {
    name = "Monkey",
    type = "Animal",
    environment = "Land",
    points = 3,
    text = "Non-human humanoids."
}

Cards.Snake = {
    name = "Snake",
    type = "Animal",
    environment = "Land",
    points = 2,
    text = "Uses its tongue to understand its surroundings."
}

Cards.Rat = {
    name = "Rat",
    type = "Animal",
    environment = "Land",
    points = 1,
    text = "Over 40% of all mammal species are roddents."
}

Cards.Octopus = {
    name = "Octopus",
    type = "Animal",
    environment = "Sea",

    points = 3,
    text = "One of the most intelligent invertebrates."
}

Cards.Dolphin = {
    name = "Dolphin",
    type = "Animal",
    environment = "Sea",
    points = 2,
    text = "One of the most intelligent vertebrates."
}

Cards.Tuna = {
    name = "Tuna",
    type = "Animal",
    environment = "Sea",
    points = 1,
    text = "A fast fish."
}
--IMPACTS
Cards.Hunter = {
    name = "Hunter",
    type = "Impact",

    subtype = "Human",
    text = "Select one land animal in your opponent's field. Discard it.",
    effect = function( card , player , opponent )

        h = false

        while h == false do
            print("Select one land animal:")
            Functions.print_zone( opponent.field )
            local input = tonumber(io.read())

            if input ~= nil and input <= #opponent.field and input > 0 then
                
                local target = opponent.field[ input ]
                
                print(target.name.." was targeted!")
                print(opponent.name.." may play the Veganism card.")
                
                for k , v in pairs( opponent.hand ) do
                    if opponent.hand[ k ].name == "Veganism" then
                        print("Will you play the Veganism card?")
                        print("0 - No")
                        print("1 - Yes")
                        
                        local answer = tonumber(io.read())
                        
                        if answer == 0 then
                            
                        elseif answer == 1 then
                            Functions.move( opponent.hand[ k ] , opponent.hand , board.discard )
                            Functions.move( card , board.pile , board.discard )
                            print("Veganism countered "..card.name.."!")
                            h = true
                        end
                    end
                end
                
                if opponent.field[ input ].environment == "Land" or opponent.field[ input ].environment == "Swamp" then
                    Functions.move( opponent.field[input ] , opponent.field , board.discard )
                    h = true
                end

            els
                print("SELECT A VALID OPTION!")
            end
        end
    end
}

Cards.Fisher = {
    name = "Fisher",
    type = "Impact",
    subtype = "Human",
    text = "Select one sea animal in your opponent's field. Discard it.",
    effect = function( card , player , opponent )

        h = false

        while h == false do
            print("Select one sea animal:")
            Functions.print_zone( opponent.field )
            local input = tonumber(io.read())

            if input ~= nil and input <= #opponent.field and input > 0 then

                if opponent.field[ input ].environment == "Sea" or opponent.field[ input ].environment == "Swamp" then
                    Functions.move( opponent.field[input ] , opponent.field , board.discard )
                    h = true
                end
            else
                print("SELECT A VALID OPTION!")
            end
        end
    end
}

Cards.Plague = {
    name = "",
    type = "Impact",
    subtype = "Natural",
    text = "Choose an animal you control; Put that animal and all animals of the same environment on the bottom of the deck in a random order.",
    effect = function( card , player , opponent )
    end
}

Cards.Unbalance = {
    name = "",
    type = "Impact",
    subtype = "Natural",
    text = "If there are fewer animals of an environment than the other, put all animals of the environment with fewer animals on the bottom of the deck in a random order.",
    effect = function( card , player , opponent )
    end
}

Cards.Selection = {
    name = "",
    type = "Impact",
    subtype = "Human",
    text = "Choose an animal you control; Put that animal and all animals with same points on the bottom of the deck in a random order.",
    effect = function( card , player , opponent )
    end
}

Cards.Prey_Upon = {
    name = "",
    type = "Impact",
    subtype = "Natural",
    text = "Choose an animal you control; put all animals of the same environment with less points than the chosen animal on the bottom of the deck in a random order.",
    effect = function( card , player , opponent )
    end
}

Cards.Submarine = {
    name = "",
    type = "Impact",
    subtype = "Human",
    text = "Look at the top six cards of the deck; You may put a sea animal from among them onto your field; Shuffle the rest into the deck.",
    effect = function( card , player , opponent )
    end
}

Cards.Lake = {
    name = "",
    type = "Impact",
    subtype = "Natural",
    text = "Put a land animal from the discard pile onto your field.",
    effect = function( card , player , opponent )
    end
}

Cards.Domesticate = {
    name = "Domesticate",
    type = "Impact",
    subtype = "Human",
    text = "Gain control of an animal with 2 points.",
    effect = function( card , player , opponent )

        print("Gain control of an animal with 2 points:")

        Functions.print_zone( opponent.field )

        local input = tonumber(io.read())

        Functions.move( opponent.field[ input ] , opponent.field , player.field )

    end
}

Cards.Trade = {
    name = "",
    type = "Impact",
    subtype = "Human",
    text = "Switch control between two animals.",
    effect = function( card , player , opponent )
    end
}

Cards.Storm = {
    name = "Storm",
    type = "Impact",
    subtype = "Natural",
    text = "Shuffle all animals with 1 point into the deck.",
    effect = function( card , player , opponent )

        for i = 1 , #player.field do
            if player.field[ i ].points == 1 then
                Functions.move( player.field[ i ] , player.field , board.deck )
            end
        end

        for i = 1 , #opponent.field do
            if opponent.field[ i ].points == 1 then
                Functions.move( opponent.field[ i ] , opponent.field , board.deck )
            end
        end

        Functions.shuffle( board.deck )
    end
}

Cards.Tremor = {
    name = "Tremor",
    type = "Impact",
    subtype = "Natural",
    text = "Shuffle all animals with 2 points into the deck.",
    effect = function( card , player , opponent )

        for i = 1 , #player.field do
            if player.field[ i ].points == 2 then
                Functions.move( player.field[ i ] , player.field , board.deck )
            end
        end

        for i = 1 , #opponent.field do
            if opponent.field[ i ].points == 2 then
                Functions.move( opponent.field[ i ] , opponent.field , board.deck )
            end
        end

        Functions.shuffle( board.deck )
    end
}

Cards.Earthquake = {
    name = "Earthquake",
    type = "Impact",
    subtype = "Natural",
    text = "Shuffle all animals with 3 points into the deck.",
    effect = function( card , player , opponent )

        for i = 1 , #player.field do
            if player.field[ i ].points == 3 then
                Functions.move( player.field[ i ] , player.field , board.deck )
            end
        end

        for i = 1 , #opponent.field do
            if opponent.field[ i ].points == 3 then
                Functions.move( opponent.field[ i ] , opponent.field , board.deck )
            end
        end

        Functions.shuffle( board.deck )
    end
}

Cards.Flood = {
    name = "",
    type = "Impact",
    subtype = "Natural",
    text = "Each player chooses two animals they control; Shuffle those animals into the deck.",
    effect = function( card , player , opponent )
    end
}

Cards.Drought = {
    name = "",
    type = "Impact",
    subtype = "Natural",
    text = "Each player chooses two animals they control; Shuffle all other animals into the deck.",
    effect = function( card , player , opponent )
    end
}

Cards.Historian = {
    name = "",
    type = "Impact",
    subtype = "Human",
    text = "Put a human impact from the discard pile into your hand.",
    effect = function( card , player , opponent )
    end
}

Cards.Archaeologist = {
    name = "",
    type = "Impact",
    subtype = "Human",
    text = "Put a natural impact from the discard pile into your hand.",
    effect = function( card , player , opponent )
    end
}

Cards.Deforestation = {
    name = "",
    type = "Impact",
    subtype = "Human",
    text = "Shuffle all land animals into the deck.",
    effect = function( card , player , opponent )
    end
}

Cards.Stream = {
    name = "",
    type = "Impact",
    subtype = "Natural",
    text = "Shuffle all sea animals into the deck.",
    effect = function( card , player , opponent )
    end
}

Cards.Veganism = {
    name = "",
    type = "Impact",
    subtype = "Human",
    text = "",
    effect = function( card , player , opponent )
    end
}

return Cards
