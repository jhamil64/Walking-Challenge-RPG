import SpriteKit

var sceneColor = UIColor(red: 0.5, green: 0.5, blue: 1.0,
                         alpha: 1.0)

class GameScene: SKScene {
    
    let title = SKLabelNode(text: "Walking Challenge RPG")
    let stepText = SKLabelNode(text: "Steps Walked")
    let moneyText = SKLabelNode(text: "Total Gold")
    
    override func didMove(to view: SKView) {
        
        self.backgroundColor = sceneColor
        
        title.position = CGPoint(x: view.frame.width / 2, y: view.frame.height / 1.2)
        title.fontSize = 26
        title.fontColor = SKColor.black
        title.fontName = "Helvetica"
        
        stepText.position = CGPoint(x: view.frame.width / 2, y: view.frame.height / 1.6)
        stepText.fontSize = 18
        stepText.fontColor = SKColor.black
        stepText.fontName = "Helvetica"
        
        moneyText.position = CGPoint(x: view.frame.width / 2, y: view.frame.height / 2.0)
        moneyText.fontSize = 18
        moneyText.fontColor = SKColor.black
        moneyText.fontName = "Helvetica"
        
    addChild(title)
    addChild(stepText)
    addChild(moneyText)
        
    }
 
}
