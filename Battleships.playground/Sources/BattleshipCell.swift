import Foundation
import SpriteKit

internal class BattleshipCell: AnyObject{
	private var ship: Ship?
	private var attacked: Bool
    private var origin: Origin
    private var view: SKSpriteNode?
	
    public init(origin: Origin){
        self.origin = origin
		attacked = false
	}
    
    public func getView() -> SKSpriteNode?{
        return view
    }
	
	public func setShip(ship: Ship) -> Bool{
		let previouslySet = self.ship == nil
		self.ship = ship
		return previouslySet
	}
    
    public func previouslyAttacked() -> Bool{
        return attacked
    }
    
    public func containsShip() -> Bool{
        return ship != nil
    }
	
	public func attack() -> Bool{
		attacked = true
		
		//Update UI to show status
		if(!containsShip()){
			//Add cross to show cell has been hit
            let unit = BattleshipBoardView.size / BattleshipBoard.size
            
            view = SKSpriteNode(imageNamed: "Cross.png")
            view!.anchorPoint = CGPoint(x: 0, y: 1)
            view!.size = CGSize(width: unit, height: unit)
            view!.position = CGPoint(x: unit * origin.getX(), y: BattleshipBoardView.size - unit * origin.getY())
            return false
        }
        ship?.attack(cell: origin)
        return true
	}
}
