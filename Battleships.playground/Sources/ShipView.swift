import SpriteKit

internal class ShipView: SKSpriteNode{
	let unit = BattleshipBoardView.size / BattleshipBoard.size
	
	init(type: ShipType, length: Int, origin: Origin, orientation: ShipOrientation){
		let size = CGSize(width: unit * length, height: unit)
		let texture = SKTexture(imageNamed: type.rawValue)
		super.init(texture: texture, color: UIColor.clear, size: size)
		
        self.anchorPoint = CGPoint(x: 0, y: 1)
        setUpView(origin: origin, orientation: orientation)
	}
    
    private func setUpView(origin: Origin, orientation: ShipOrientation){
        self.position.x = CGFloat(unit * origin.getX())
        self.position.y = CGFloat(BattleshipBoardView.size - (unit * origin.getY()))
        
        if orientation == .Vertical{
            self.zRotation = -CGFloat(Double.pi / 2)
            self.position.x += CGFloat(unit)
        }
    }
    
    func updateLocation(ship: Ship){
        setUpView(origin: ship.getOrigin(), orientation: ship.getOrientation())
    }
	
    func attack(diff: Int, rotate: Bool){
		let spark = SKEmitterNode(fileNamed: "Fire.sks")!
        let halfUnit = CGFloat(unit) * 0.5
        spark.targetNode = self
        spark.position = CGPoint(
            x: halfUnit - (spark.frame.width / 2) + CGFloat(unit * diff),
            y: -halfUnit - spark.frame.height
        )
        
        if(rotate){
            spark.emissionAngle += CGFloat(Double.pi / 2)
        }
        
		self.addChild(spark)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
