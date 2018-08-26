math.randomseed(os.time())
local Player = require("Player")
local Board = require("Board")
local Functions = require("Functions")
local Cards = require("Cards")
local Decks = require("Decks")

os.execute("clear")
print("           VEGANO2DIGITAL")
print("           Version 1.0")
print("           Game Designer")
print("          Alexandre Nasajon        ")
print("           Lead Developer           ")
print("          Alexandre Nasajon        ")
print("           Game Producer           ")
print("          Alexandre Nasajon        ")
print("          Game Programmer          ")
print("          Alexandre Nasajon       ")
print("         Special thanks to       ")
print("          Leonardo Kaplan")
print(" Every playtester (list to be made)")

print("What's player 1's name")
player[1].name = io.read()
print("So player 1's name is "..player[1].name.."!")
print("And what's player 2's name?")
player[2].name = io.read()
print("So player 2's name is "..player[2].name.."!")
print("I imagine both player read the manual, right? Right! Then good luck!")
print("-----GAME START-----")

    tempcard = {}

    for k,v in pairs( Decks.inicial ) do
        tempcard = Functions.abstract_to_concrete( v , tempcard )
        board.deck[ #board.deck + 1 ] = tempcard
        tempcard = {}
    end

Functions.game()