import SpriteKit

public class BattleshipBoardView: SKView{
	public static var size = 250
	
	public init(playerNo: Int) {
		let size = BattleshipBoardView.size
		
		super.init(frame:
            CGRect(x: (size + 30) * playerNo, y: 0,
                width: size, height: size))
		self.presentScene(SKScene(size: self.frame.size))
        
        let backgroundImage = SKSpriteNode(imageNamed: "BattleshipGrid.png")
        backgroundImage.anchorPoint = CGPoint(x: 0, y: 0)
        backgroundImage.size = self.frame.size
        self.scene?.addChild(backgroundImage)
	}
	
	required public init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

