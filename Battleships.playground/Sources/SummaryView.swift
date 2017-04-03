import SpriteKit

class SummaryView: UIView{
    public init(winner: Bool){
        let padding = BattleshipGameGenerator.padding
        super.init(frame:
            CGRect(x: 0, y: 0,
                   width: (BattleshipBoardView.size * 2) + padding,
                   height: padding))
        
        let label = UILabel(frame: self.frame)
        label.textAlignment = .center
        self.addSubview(label)
        
        if(winner){
            self.backgroundColor = UIColor.green
            label.text = "You Win"
        }else{
            self.backgroundColor = UIColor.red
            label.text = "Oliver's AI Wins"
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

