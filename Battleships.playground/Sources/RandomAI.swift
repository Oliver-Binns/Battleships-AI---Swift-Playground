import Foundation

public struct RandomAI: BattleshipAI{
    private var turns = 0
    private var attacked: [Origin] = []
    
    public init(){}

	public mutating func getShipLocations() -> [Ship]{
		let shipTypes: [ShipType] = [.Battleship, .Carrier, .Cruiser, .Submarine, .Destroyer];
		
		var ships: [Ship] = []
		for type in shipTypes{
			var orientation = ShipOrientation.Horizontal
			if(arc4random_uniform(2) == 0){
				orientation = ShipOrientation.Vertical
			}
            
			let x = Int(arc4random_uniform(10))
			let y = Int(arc4random_uniform(10))
            
            let ship = Ship(type: type,
                            origin: Origin(x: x, y: y),
                            orientation: orientation)
            
            while !ship.fallsOnGameBoard() || ship.overlapsWith(ships: ships){
                ship.setOrigin(origin:
                    Origin(x: Int(arc4random_uniform(10)),
                           y: Int(arc4random_uniform(10)))
                )
            }
            ships.append(ship)
		}
		return ships
	}
    
    private func getRandomCell() -> Origin{
        let x = Int(arc4random_uniform(10))
        let y = Int(arc4random_uniform(10))
        return Origin(x: x, y: y)
    }
    
    public mutating func nextMove() -> Origin{
        var origin = getRandomCell()
        while(attacked.contains(origin)){
            origin = getRandomCell()
        }
        attacked.append(origin)
        return origin
    }
    
    public mutating func feedback(success: Bool) {
        
    }
}
