
import Foundation
import SpriteKit

class LevelSelect: SKScene, ButtonDelegate, BackButtonDelegate {
    
    private var button = Button()
    
    var sceneColor = UIColor(red: 0.4, green: 1.0, blue: 0.4,
                             alpha: 1.0)
    let title = SKLabelNode(text: "Greenhorn Grassland")
    let alreadyDone = SKLabelNode(text: "Choose a level")
    
    override func didMove(to view: SKView) {
        self.backgroundColor = sceneColor
        title.position = CGPoint(x: view.frame.width / 2, y: view.frame.height / 1.2)
        alreadyDone.position = CGPoint(x: view.frame.width / 2, y: view.frame.height / 1.5)
        alreadyDone.fontSize = 24
        addChild(alreadyDone)
        
        let button2 = Button(texture: nil, color: .black, size: CGSize(width: view.frame.width / 10, height: view.frame.height / 10))
        button2.name = "stage1"
        button2.position = CGPoint(x: view.frame.width / 6, y: view.frame.height / 1.5)
        button2.delegate = self
        
        let button3 = BackButton(texture: nil, color: .black, size: CGSize(width: view.frame.width / 10, height: view.frame.height / 10))
        button3.position = CGPoint(x: view.frame.width / 100, y: view.frame.height / 1.1)
        button3.delegate = self
                addChild(button2)
                addChild(button3)
        
    addChild(title)
        
        
    }
    
    func buttonClicked(sender: Button) {
        if (completionFlag.bool(forKey: "true") == true)
        {
            alreadyDone.text = "Already completed this"
        }
        else {
        let transition:SKTransition = SKTransition.fade(withDuration: 1)
        let scene: SKScene = Level1(size: self.size)
        self.view?.presentScene(scene, transition: transition)
        }
        
    }
    
    func backButtonClicked(sender: BackButton) {
        let transition:SKTransition = SKTransition.fade(withDuration: 1)
        let scene: SKScene = WorldMap(size: self.size)
        self.view?.presentScene(scene, transition: transition)
        
    }
    
}
