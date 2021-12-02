

import Foundation
import SpriteKit

class CastleMenu: SKScene {
    
    var sceneColor = UIColor(red: 0.6, green: 1.0, blue: 0.6,
                             alpha: 1.0)
    let title = SKLabelNode(text: "Walking Challenge RPG")
    override func didMove(to view: SKView) {
        self.backgroundColor = sceneColor
        title.position = CGPoint(x: view.frame.width / 2, y: view.frame.height / 1.2)
        
    addChild(title)
    }
    
}
