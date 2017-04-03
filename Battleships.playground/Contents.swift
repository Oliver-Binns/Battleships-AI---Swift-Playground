//: # Battleships AI
//: The aim of this playground is to design and build an AI to play the game battleships.

//: Some suggestions of features to improve could be:
//: * Seeking and destroying an opponents ships once an attack has been successful.
//: * More efficient use of moves - as ships are two squares or greater in size, a diagonal pattern is potentially the most effective.
//: * Use your imagination, using the `bestOf` method below, allows you go check your progress over a number of games.

import SpriteKit
import PlaygroundSupport

public struct myAIPlayer: BattleshipAI{
    public init(){}
//: ## getShipLocations
//: This is the very first function to be called once the game is initiated. You will need to generate an array containing one of each of the five types of ship- Carrier, Battleship, Cruiser, Submarine and Destroyer
//: Each of these types of ship can be identified by the `ShipType` enum.
    public func getShipLocations() -> [Ship]{
        return [
            Ship(type: .Battleship, origin: Origin(x: 0, y: 0), orientation: .Horizontal),
            Ship(type: .Carrier, origin: Origin(x: 1, y: 1), orientation: .Horizontal),
            Ship(type: .Cruiser, origin: Origin(x: 2, y: 2), orientation: .Horizontal),
            Ship(type: .Destroyer, origin: Origin(x: 3, y: 3), orientation: .Horizontal),
            Ship(type: .Submarine, origin: Origin(x: 4, y: 4), orientation: .Vertical)
        ]
    }
    
//: ## nextMove
//: This method is called when the AI needs to generate a new move. Any logic for move generation can be in here, or additional private methods.
    private var turns = 0
    public mutating func nextMove() -> Origin {
        let x = turns % 10
        let y = Int(turns / 10)
        turns += 1
        return Origin(x: x, y: y)
    }
    
//: ## feedback
//: This method is called when the AI has returned a move using the `nextMove` method above. The success boolean parameter is true if the move returned successfully hit one of the opponents ships.
    public mutating func feedback(success: Bool) {
        
    }    
}

//: Implement your own AI above, or use one of the built in options:
//: * `SequentialAI` - Attacks the board in order A1, B1..J1, A2, etc. This is equivalent to the AI implemented above
//: * `RandomAI` - Attacks random squares each move
//: * `RandomSeekAI` - Attacks random squares each move, but attempts to seek and destroys a ship once one has been hit
//: By default your opponent is set to be a RandomSeekAI, but you can change this by uncommenting the line-
//BattleshipGameGenerator.defaultAI = RandomSeekAI.self

//: It is possible to resize the game grid to match your screen if required. Simply uncomment and adjust the following to an appropriate size for your monitor. The default is 250 pixels.
//BattleshipGameView.size = 250

//: The BattleshipGameGenerator class has several useful functions to test out your AI.
//: * `play(player: BattleshipAI.Type)` - runs a single game between your AI and the built in AI.
//: * `bestOf(player: BattleshipAI.Type, games: Int)` - runs a number games between your AI and the built in AI so you can see performance over a number of games
//: * `generateStats(games: Int)`
PlaygroundPage.current.liveView = BattleshipGameGenerator.bestOf(
    player: myAIPlayer.self,
    games: 5
)
