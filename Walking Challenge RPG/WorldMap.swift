
import Foundation
import SpriteKit



class WorldMap: SKScene, ButtonDelegate, BackButtonDelegate {
    
    private var button = Button()
    
    var sceneColor = UIColor(red: 1.0, green: 1.0, blue: 1.0,
                             alpha: 1.0)
    let title = SKLabelNode(text: "Walking Challenge RPG")
    let buttonText = SKLabelNode(text: "To World Map")
    let buttonTexture = SKSpriteNode(color: .blue, size: CGSize(width: 100, height: 100))
    let buttonTexture2 = SKSpriteNode(color: .black, size: CGSize(width: 10, height: 10))
    
    
    override func didMove(to view: SKView) {
        if let button = self.childNode(withName: "button") as? Button {
                    self.button = button
                    button.delegate = self
                }

                let button2 = Button(texture: nil, color: .blue, size: CGSize(width: view.frame.width / 10, height: view.frame.height / 10))
        let button3 = BackButton(texture: nil, color: .black, size: CGSize(width: view.frame.width / 10, height: view.frame.height / 10))
                button2.name = "button2"
        button2.position = CGPoint(x: view.frame.width / 6, y: view.frame.height / 1.5)
                button2.delegate = self
        button3.position = CGPoint(x: view.frame.width / 100, y: view.frame.height / 1.1)
        button3.delegate = self
                addChild(button2)
                addChild(button3)
        
        
//
//        buttonTexture.position = CGPoint(x: view.frame.width / 2, y: view.frame.height / 7.2)
//        buttonTexture.size = CGSize(width: view.frame.width / 1.5, height: view.frame.height / 8)
//        buttonTexture2.position = CGPoint(x: view.frame.width / 10, y: view.frame.height / 1)
//        buttonTexture2.size = CGSize(width: view.frame.width / 10, height: view.frame.height / 3)
        
        buttonText.position = CGPoint(x: view.frame.width / 2, y: view.frame.height / 7.4)
        buttonText.fontSize = 23
        buttonText.fontColor = SKColor.white
        buttonText.fontName = "Courier New Bold"
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
