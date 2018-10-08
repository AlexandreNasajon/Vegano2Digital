local Player = require("Player")
local Board = require("Board")
local Functions = {}

--FIND
function Functions.find( where , what )
    for k,v in pairs( where ) do
        if v == what then
        return k
        end
    end
end

--SORT
function Functions.sort( tbl )
    local new = {}

    for i = 1 , #tbl do
        for j = 1 , #tbl do
            if tbl[ i ] < tbl[ j ] then
                tbl[ i ] , tbl[ j ] = tbl[ j ] , tbl[ i ]
            end
        end
    end
    return new
end

--MOVE
function Functions.move( what , origin , destiny )

    destiny[ #destiny + 1] = what

    local k = Functions.find( origin , what )

    while k <= #origin do
        origin[ k ] = origin[ k + 1 ]
        k = k + 1
    end
end

--SHUFFLE
function Functions.shuffle( pile )

	for i = 1, #pile do

		local j = math.random( 1 , #pile )

		pile[ j ], pile[ i ] = pile[ i ], pile[ j ]

	end
	return pile
end

--VIEW_CARD
function Functions.view_card( card )

    print("Name: "..card.name)
    print("Type: "..card.type)

    if card.type == "Animal" then

        print("Points: "..card.points)
        print("Environment: "..card.environment)
        print("Text: "..card.text)
    else
        print("Impact - "..card.subtype)
        print("Text: "..card.text)
    end
end

--PRINT_ZONE
function Functions.print_zone( zone )

    local i = 1
    print("#","Name" , "Type")
    while i <= #zone do
        print( i , zone[ i ].name , zone[ i ].type )
        i = i + 1
    end
end

--ENTER_ZONE    
function Functions.enter_zone( zone )

    local h = false

    while h == false do

        print("0 - Return")
        Functions.print_zone ( zone )

        local input = tonumber(io.read())

        if input == 0 then h = true break end

        local card = zone[ input ]

        local k = false

        while k == false do

            Functions.view_card( card )

            print("0 - Return")

            local input = tonumber(io.read())

            if input == 0 then k = true end
        end
    end
end

--DRAW_CARDS
function Functions.draw_cards( player )

    while #player.hand > 4 do

        print("Put a card from your hand on the bottom of the deck.")

        Functions.print_zone( player.hand ) --mostra a mão

        local input = tonumber(io.read()) --pega carta da mão

        Functions.move( player.hand[ input ] , player.hand , board.deck ) --move a carta da mão pro topo do deck

        board.deck[ #board.deck ] , board.deck[ 1 ] = board.deck[ 1 ] , board.deck[ #board.deck ] --troca a carta do topo do deck pela do fundo

        print( player.name.." recycled a card." )

    end

    --compra 2 cartas

    player.hand[ #player.hand + 1 ] = board.deck[ #board.deck ]
    board.deck[ #board.deck ] = nil
    player.hand[ #player.hand + 1 ] = board.deck[ #board.deck ]
    board.deck[ #board.deck ] = nil

    print( player.name.." drew two cards." )
end


--DRAW_HAND
function Functions.draw_hand( player )

    local i = 0
    while i < 5 do
        player.hand[ #player.hand + 1 ] = board.deck[ #board.deck ]
        board.deck[ #board.deck ] = nil
        i = i + 1
    end
end

--ABSTRACT_TO_CONCRETE
function Functions.abstract_to_concrete( abstract_card , concrete_card )

    for k,v in pairs( abstract_card ) do

        concrete_card[ k ] = v
    end

    return concrete_card
end

--PLAY_CARD
function Functions.play_card( card , player , opponent )

    if card.type == "Animal" then

        Functions.move( card , player.hand , player.field )

    elseif card.type == "Impact" then
	
	if card.name == "Veganism" then
		print("Veganism can't be played at this moment!")
		return
	else		
		Functions.move( card , player.hand , board.stack )	
        	card.effect( card , player , opponent )
        	Functions.move( card , board.stack , board.discard )
	end
    end
end

--END_TURN
function Functions.end_turn( player , opponent )
    local p = 0

    for i = 1 , #player.field do
        p = p + player.field[ i ].points
    end

    player.points = p

    if player.points > 6 then
        print( player.name.." is vegan!" )
    end

    local q = 0

    for i = 1 , #opponent.field do
        q = q + opponent.field[ i ].points
    end

    opponent.points = q

    if opponent.points > 6 then
        winner = opponent
    end

    print( player.name.."'s turn ends!" )
end

--ENTER_HAND
function Functions.enter_hand( player , opponent )

    local h = false

    while h == false do

        print("0 - Return")
        Functions.print_zone ( player.hand )

        local input = tonumber(io.read())

        if input == 0 then 
            h = true
            break
        else
            chosen_card = player.hand[ input ]
            h = true
        end

        local k = false

        while k == false do

            Functions.view_card( chosen_card )

            print("0 - Return")
            print("1 - Play")

            local new_input = tonumber(io.read())

            if new_input == 0 then 
                k = true
                break
            elseif new_input == 1 then
                Functions.play_card( chosen_card , player , opponent )
                k = true
                player.done = true
                break
            end
        end
    end
end

--TURN
function Functions.turn( player , opponent )

    while t == 1 or t == 2 do
        
        print("It's player "..player.name.." turn!")
        print(opponent.name)
        print("Points: "..opponent.points)
        print("--------------------------------------------------------------------------------")
        print("--------------------------------------------------------------------------------")
        print("--------------------------------------------------------------------------------")
        print("--------------------------------------------------------------------------------")
        print("-------------------------------------------------------------------------govegan")
        print(player.name)
        print("Points: "..player.points)
        print("1 - Your Hand")
        print("2 - Your Field")
        print("3 - Opponent's Field")
        print("4 - Discard Pile")
        print("5 - Draw two cards")

        player.done = false

        local input = tonumber(io.read())

        while input == 1 do
            Functions.enter_hand( player , opponent )
            break
        end

        if player.done == true then
            Functions.end_turn( player , opponent )
            break
        end

        while input == 2 do
            Functions.enter_zone( player.field )
            break
        end

        while input == 3 do
            Functions.enter_zone( opponent.field )
            break
        end

        while input == 4 do
            Functions.enter_zone( board.discard )
            break
        end

        if input == 5 then
            Functions.draw_cards( player )
            Functions.end_turn( player , opponent )
            break
        end
    end
end

--GAME
function Functions.game()

    Functions.shuffle( board.deck )
    Functions.draw_hand( player[ 1 ] )
    Functions.draw_hand( player[ 2 ] )
    
    while winner == nil do

        --player 1 turn
        t = 1  y = 2

        Functions.turn( player[ t ] , player[ y ] )

        if winner then
            print( winner.name.." wins!" )
        end

        --player 2 turn
        t = 2  y = 1

        Functions.turn( player[ t ] , player[ y ] )

        if winner then
            print( winner.name.." wins!" )
        end
    end
end

return Functions
