import SpriteKit

public class Ship: AnyObject{
	private var type: ShipType
	private var orientation: ShipOrientation
	private var origin: Origin
	internal var view: ShipView
	
	public init(type: ShipType, origin: Origin, orientation: ShipOrientation){
		self.type = type
		self.origin = origin
		self.orientation = orientation
		
		self.view = ShipView(type: type, length: Ship.getLength(type: type), origin: origin, orientation: orientation)
	}
    
    public func getOrigin() -> Origin{
        return self.origin
    }
    
    public func getOrientation() -> ShipOrientation{
        return self.orientation
    }
    
    public func getType() -> ShipType{
        return self.type
    }
    
    public func setOrigin(origin: Origin){
        self.origin = origin
        self.view.updateLocation(ship: self)
    }
	
	public func getLength() -> Int{
		return Ship.getLength(type: type)
	}
    
    public func fallsOnGameBoard() -> Bool{
        let width = BattleshipBoard.size
        
        guard origin.getX() < width else { return false }
        guard origin.getY() < width else { return false }
        
        if orientation == .Horizontal{
            guard origin.getX() + getLength() < width else { return false }
        }else{
            guard origin.getY() + getLength() < width else { return false }
        }
        
        return true
    }
    
    public func overlapsWith(ship: Ship) -> Bool{
        guard ship.origin != origin else { return true }
        
        for i in 0..<getLength(){
            var x = origin.getX()
            var y = origin.getY()
            
            if self.orientation == .Horizontal{
                x += i
            }else{
                y += i
            }
            
            for j in 0..<ship.getLength(){
                var x2 = ship.origin.getX()
                var y2 = ship.origin.getY()
                
                if ship.orientation == .Horizontal{
                    x2 += j
                }else{
                    y2 += j
                }
                
                guard Origin(x: x, y: y) != Origin(x: x2, y: y2) else {
                    return true
                }
            }
        }
        
        return false
    }
    
    public func overlapsWith(ships: [Ship]) -> Bool{
        var overlap = false
        for ship in ships{
            overlap = overlap || self.overlapsWith(ship: ship)
        }
        return overlap
    }
	
	public static func getLength(type: ShipType) -> Int{
		switch type{
		case .Carrier:
			return 5
		case .Battleship:
			return 4
		case .Cruiser:
			return 3
		case .Submarine:
			return 3
		case .Destroyer:
			return 2
		}
	}
	
	func attack(cell: Origin){
		let diffX = cell.getX() - origin.getX()
		let diffY = cell.getY() - origin.getY()

        self.view.attack(diff: max(diffX, diffY), rotate: orientation == .Vertical)
	}
}

public enum ShipType: String{
	case Carrier
	case Battleship
	case Cruiser
	case Submarine
	case Destroyer
}

public enum ShipOrientation{
	case Horizontal
	case Vertical
}
