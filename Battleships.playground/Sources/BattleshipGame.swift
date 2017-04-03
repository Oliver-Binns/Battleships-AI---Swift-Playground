import SpriteKit

internal class BattleshipGame: AnyObject{
	var players: [BattleshipAI]
	var boards: [BattleshipBoard]
	var view: SKView
    private var gameLabel: UILabel
	
	public init(player: BattleshipAI){
		self.players = [BattleshipGameGenerator.defaultAI.init(), player]
		self.boards = [
			BattleshipBoard(playerNo: 0),
			BattleshipBoard(playerNo: 1)
		]
		
		self.view = SKView(frame:
            CGRect(x: 0, y: 30,
                   width: BattleshipBoardView.size * 2 + BattleshipGameGenerator.padding,
                   height: BattleshipBoardView.size)
        )
        
        view.addSubview(boards[0].view)
        
        let dividerView = UIView(frame:
            CGRect(x: BattleshipBoardView.size,
                   y: 0,
                   width: BattleshipGameGenerator.padding,
                   height: BattleshipBoardView.size)
        )
        
        dividerView.backgroundColor = UIColor.black
        gameLabel = UILabel(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: dividerView.frame.size))
        gameLabel.textColor = UIColor.white
        gameLabel.numberOfLines = 0
        gameLabel.textAlignment = .center
        dividerView.addSubview(gameLabel)
        
        view.addSubview(dividerView)
        view.addSubview(boards[1].view)
	}
    
    private func setGameNumber(number: Int){
        gameLabel.text = "G\nA\nM\nE\n\n" + String(number)
    }
	
	func addShips() throws{
		for i in 0..<self.players.count{
			let ships = self.players[i].getShipLocations()
			
			guard ships.count == 5 else { throw AddShipError.IncorrectNumberOfShips }
			var shipTypes = [
				ShipType.Battleship: false,
				ShipType.Carrier: false,
				ShipType.Cruiser: false,
				ShipType.Destroyer: false,
				ShipType.Submarine: false
			]
			
			for ship in ships{
				shipTypes[ship.getType()] = true
				try self.boards[i].addShip(ship: ship)
			}
			
			//Ensures one of each type of ship is given
			for (type, result) in shipTypes{
				if !result{
					throw AddShipError.MissingShip(type: type)
				}
			}
		}
	}
	
	public func isComplete() -> Bool{
		var complete = false
		for board in boards{
			complete = complete || board.isComplete()
		}
		return complete
	}
	
    internal func play(number: Int) -> SKView{
        setGameNumber(number: number)
        return play()
    }
    
    public func play() -> SKView{
		//Run the game...
		do{
			//Get the AIs to give their chosen ship locations
			try addShips()
			
			//Continuously take each player's next move until the game is complete
			while !isComplete(){
				for i in 0..<players.count{
					let nextMove = players[i].nextMove()
					
					var otherPlayersBoard: BattleshipBoard
					if(i == players.count - 1){
						otherPlayersBoard = boards[0]
					}else{
						otherPlayersBoard = boards[i + 1]
					}
                    
                    players[i].feedback(success:
                        otherPlayersBoard.attack(cell: nextMove)
                    )
                    
                    if(otherPlayersBoard.isComplete()){
                        break
                    }
				}
			}
		}catch let error as AddShipError{
			print(error)
		}catch{}
        return self.view
	}
    
    public func getSummaryView() -> SummaryView{
        let aiBoard = self.boards[0].isComplete();
        return SummaryView(winner: aiBoard)
    }
}

enum AddShipError: Error {
	case CellOffBoard
	case CellContainsShip
	case IncorrectNumberOfShips
	case MissingShip(type: ShipType)
}
