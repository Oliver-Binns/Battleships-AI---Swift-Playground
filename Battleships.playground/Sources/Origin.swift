import Foundation

public class Origin: CustomStringConvertible, Equatable{
    /// Returns a Boolean value indicating whether two values are equal.
    ///
    /// Equality is the inverse of inequality. For any values `a` and `b`,
    /// `a == b` implies that `a != b` is `false`.
    ///
    /// - Parameters:
    ///   - lhs: A value to compare.
    ///   - rhs: Another value to compare.
    public static func ==(lhs: Origin, rhs: Origin) -> Bool {
        return lhs.x == rhs.x && lhs.y == rhs.y
    }

	private var x: Int
	private var y: Int
	
	public init(x: Int, y: Int){
		self.x = x
		self.y = y
	}
	
	public func getX() -> Int{
		return x
	}
	
	public func getY() -> Int{
		return y
	}
	
	public var description: String {
		var string = String(format: "%c", x+65)
		string += String(y+1)
		return string
	}
    
    public func isValid() -> Bool{
        if(x < 0 || x > BattleshipBoard.size){
            return false
        }else if (y < 0 || y > BattleshipBoard.size){
            return false
        }
        return true
    }
}
