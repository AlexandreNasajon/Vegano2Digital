local Player = require("Player")
local Board = require("Board")
local Cards = require("Cards")
local Decks = {}

Decks.inicial = {
    Cards.Monkey , Cards.Monkey , Cards.Monkey , 
    Cards.Snake , Cards.Snake , Cards.Snake , Cards.Snake ,
    Cards.Rat , Cards.Rat , Cards.Rat , Cards.Rat , Cards.Rat ,

    Cards.Octopus , Cards.Octopus , Cards.Octopus , 
    Cards.Dolphin , Cards.Dolphin , Cards.Dolphin , Cards.Dolphin ,
    Cards.Tuna , Cards.Tuna , Cards.Tuna , Cards.Tuna , Cards.Tuna ,

    Cards.Hunter , Cards.Hunter , Cards.Hunter , 
    Cards.Fisher , Cards.Fisher , Cards.Fisher ,
    Cards.Domesticate , 
    Cards.Storm , Cards.Tremor , Cards.Earthquake
}

return Decks