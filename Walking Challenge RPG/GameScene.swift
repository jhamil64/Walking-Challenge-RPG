import SpriteKit

var sceneColor = UIColor(red: 0.5, green: 0.5, blue: 1.0,
                         alpha: 1.0)

class GameScene: SKScene {
    
    let label = SKLabelNode(text: "Walking Challenge RPG")
    
    override func didMove(to view: SKView) {
        
        self.backgroundColor = sceneColor
        
        label.position = CGPoint(x: view.frame.width / 2, y: view.frame.height / 1.2)
        
        label.fontSize = 26
        label.fontColor = SKColor.black
        label.fontName = "Helvetica"
        
    addChild(label)
        
    }
 
}
