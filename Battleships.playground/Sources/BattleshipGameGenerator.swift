import SpriteKit

public class BattleshipGameGenerator: AnyObject{
    public static var defaultAI = RandomSeekAI.self
    public static var padding: Int = 30
    
    private static func play(player: BattleshipAI.Type, gameNumber: Int) -> SKView{
        let game = BattleshipGame(player: player.init())
        
        let gameView = game.play(number: gameNumber)
        let summaryView = game.getSummaryView()
        
        let view = SKView(frame:
            CGRect(x: 0, y: 0,
                   width: max(gameView.frame.width, summaryView.frame.width),
                   height: gameView.frame.height + summaryView.frame.height))
        view.addSubview(summaryView)
        view.addSubview(gameView)
        return view
    }
    
    public static func play(player: BattleshipAI.Type) -> SKView{
        return play(player: player, gameNumber: 1)
    }
    
    public static func bestOf(player: BattleshipAI.Type, games: Int) -> SKView{
        let view = SKView(frame:
            CGRect(x: 0, y: 0,
                   width: BattleshipBoardView.size * 2,
                   height: games * (BattleshipBoardView.size + BattleshipGameGenerator.padding)
        ))
        
        for i in 0..<games{
            let gameView = play(player: player, gameNumber: i+1)
            let yPos = Int(gameView.frame.height) * i
            view.addSubview(gameView)
            gameView.frame.origin.y += CGFloat(yPos);
        }
        
        return view
    }
}
