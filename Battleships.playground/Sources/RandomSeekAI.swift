import Foundation

public struct RandomSeekAI: BattleshipAI{
    private var turns = 0
    private var attacked: [Origin] = []
    private var knownShips: [SeekAndDestroy] = []
    private var lastMove: Move?
    
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
        for ship in knownShips{
            if(!ship.isDestroyed){
                //If ship has not been destroyed- return the next suggested move..
                var nextMove = ship.nextMove()
                lastMove = Move(origin: nextMove, ship: ship)
                while(!nextMove.isValid() || attacked.contains(nextMove)){
                    if(ship.isDestroyed){
                        return getRandomMove()
                    }
                    ship.feedback(success: false)
                    attacked.append(nextMove)
                    nextMove = ship.nextMove()
                    lastMove = Move(origin: nextMove, ship: ship)
                }
                attacked.append(nextMove)
                return nextMove
            }
        }
        //All KNOWN ships have been destroyed- move randomly.
        return getRandomMove()
    }
    
    private mutating func getRandomMove() -> Origin{
        var origin = getRandomCell()
        while(attacked.contains(origin)){
            origin = getRandomCell()
        }
        attacked.append(origin)
        lastMove = Move(origin: origin, ship: nil)
        return origin
    }
    
    public mutating func feedback(success: Bool) {
        //Our attack was successful, we want to remember this!
        if(success){
            //If we are already attacking a specific ship..
            if let attackedShip = lastMove!.ship{
                attackedShip.feedback(success: success)
            }else{
                self.knownShips.append(SeekAndDestroy(location: lastMove!.origin))
            }
        }
    }
    
    class Move{
        let origin: Origin
        let ship: SeekAndDestroy?
        
        init(origin: Origin, ship: SeekAndDestroy?){
            self.origin = origin
            self.ship = ship
        }
    }
    
    class SeekAndDestroy{
        var distanceAttacked = 0;
        var destroyed = 1 //Seek and Destroy has been created- so the ship must have been hit once..
        
        var top = false
        var left = false
        var bottom = false
       
        var knownLocation: Origin
        
        var isDestroyed = false
        
        init(location: Origin){
            self.knownLocation = location
        }
        
        func feedback(success: Bool){
            if(success){
                destroyed += 1
                distanceAttacked += 1
            }else{
                distanceAttacked = 0
                
                if(!top){
                    top = !top
                }else if(!bottom){
                    bottom = !bottom
                }else if(!left){
                    left = !left
                }else{
                    isDestroyed = true
                }
            }
        }
        
        func nextMove() -> Origin{
            if(!top){
                return knownLocation.increment(x: 0, y: -1 - distanceAttacked)
            }else if(!bottom){
                return knownLocation.increment(x: 0, y: 1 + distanceAttacked)
            }else if(!left){
                return knownLocation.increment(x: -1 - distanceAttacked, y: 0)
            }else{
                return knownLocation.increment(x: 1 + distanceAttacked, y: 0)
            }
        }
    }
}
extension Origin{
    func increment(x: Int, y: Int) -> Origin{
        let newOrigin = Origin(x: self.getX() + x, y: self.getY() + y)
        return newOrigin
    }
}
