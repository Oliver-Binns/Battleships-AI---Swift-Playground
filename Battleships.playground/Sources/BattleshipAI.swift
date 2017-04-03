import Foundation

public protocol BattleshipAI{
	init()
	
	mutating func getShipLocations() -> [Ship]
	
	mutating func nextMove() -> Origin
	
	mutating func feedback(success: Bool)
}
