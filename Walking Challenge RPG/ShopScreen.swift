
import Foundation
import SpriteKit



class ShopScreen: SKScene, ButtonDelegate, BackButtonDelegate {
    
    private var button = Button()
    
    var sceneColor = UIColor(red: 1.0, green: 1.0, blue: 1.0,
                             alpha: 1.0)
    let title = SKLabelNode(text: "World Map")
    
    
    override func didMove(to view: SKView) {
        if let button = self.childNode(withName: "button") as? Button {
                    self.button = button
                    button.delegate = self
                }

        let button3 = BackButton(texture: nil, color: .black, size: CGSize(width: view.frame.width / 10, height: view.frame.height / 10))
        button3.position = CGPoint(x: view.frame.width / 100, y: view.frame.height / 1.1)
        button3.delegate = self
                addChild(button3)
        
                title.fontSize = 32
        title.fontColor = SKColor.black
        self.backgroundColor = sceneColor
        title.position = CGPoint(x: view.frame.width / 2, y: view.frame.height / 1.2)
        
    addChild(title)
    }
    
    func buttonClicked(sender: Button) {
        let transition:SKTransition = SKTransition.fade(withDuration: 1)
        let scene: SKScene = LevelSelect(size: self.size)
        self.view?.presentScene(scene, transition: transition)
        
    }
    
    func backButtonClicked(sender: BackButton) {
        let transition:SKTransition = SKTransition.fade(withDuration: 1)
        let scene: SKScene = CastleMenu(size: self.size)
        self.view?.presentScene(scene, transition: transition)
        
    }
    
}
