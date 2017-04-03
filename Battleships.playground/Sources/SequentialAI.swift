public struct SequentialAI: BattleshipAI{
    private var turns = 0
    
    public init(){}
    
    public mutating func feedback(success: Bool) {
        
    }
    
    public mutating func nextMove() -> Origin{
        let x = turns % 10
        let y = Int(turns / 10)
        turns += 1
        return Origin(x: x, y: y)
    }
    
    public mutating func getShipLocations() -> [Ship] {
        return [
            Ship(type: .Battleship, origin: Origin(x: 0, y: 0), orientation: .Horizontal),
            Ship(type: .Carrier, origin: Origin(x: 1, y: 1), orientation: .Horizontal),
            Ship(type: .Cruiser, origin: Origin(x: 2, y: 2), orientation: .Horizontal),
            Ship(type: .Destroyer, origin: Origin(x: 3, y: 3), orientation: .Horizontal),
            Ship(type: .Submarine, origin: Origin(x: 4, y: 4), orientation: .Vertical)
        ]
    }
}
