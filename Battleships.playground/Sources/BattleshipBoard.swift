import SpriteKit

internal class BattleshipBoard: AnyObject{
	public static let size = 10
	
	let view: BattleshipBoardView
	
	private var squares: [[BattleshipCell]] = []
    
    private var attackedShips = 0
	
	public init(playerNo: Int){
		view = BattleshipBoardView(playerNo: playerNo)
		
		for x in 0..<BattleshipBoard.size{
			var row = [BattleshipCell]()
			for y in 0..<BattleshipBoard.size{
                row.append(BattleshipCell(origin: Origin(x: x, y: y)))
			}
			squares.append(row)
		}
	}
	
	//-:
	func addShip(ship: Ship) throws{
		var row: Int = ship.getOrigin().getX()
		var column: Int = ship.getOrigin().getY()
		
		for _ in 0..<ship.getLength(){
			guard row <= BattleshipBoard.size && column <= BattleshipBoard.size else{ throw AddShipError.CellOffBoard }
			
			if(!squares[row][column].setShip(ship: ship)){
				throw AddShipError.CellContainsShip
			}
            
            if ship.getOrientation() == .Horizontal{
                row += 1
            }else{
                column += 1
            }
		}
		
		self.view.scene?.addChild(ship.view)
	}
	
	func attack(cell: Origin) -> Bool{
        let cellObj = squares[cell.getX()][cell.getY()]
        var result = false
        if(!cellObj.previouslyAttacked()){
            result = cellObj.attack()
            if(cellObj.containsShip()){
                attackedShips += 1
            }else{
                view.scene?.addChild(cellObj.getView()!)
            }
        }else{
            print("This cell (" + cell.description + ") has been attacked before.")
        }
        return result
	}
	
	//-:
	func isComplete() -> Bool{
        //There are 17 places where a ship can be hit
		return attackedShips >= 17
	}
}
