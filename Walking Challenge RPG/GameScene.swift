import SpriteKit

class GameScene: SKScene {
    
    let label = SKLabelNode(text: "Walking Challenge RPG")
    
    override func didMove(to view: SKView) {
        
        label.position = CGPoint(x: view.frame.width / 2, y: view.frame.height / 1.2)
        
    addChild(label)
        
    }
 
}
