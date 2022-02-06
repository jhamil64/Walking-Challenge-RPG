
import Foundation
import SpriteKit


protocol BackButtonDelegate: AnyObject {
    func backButtonClicked(sender: BackButton)
}

class BackButton: SKSpriteNode {

    //weak so that you don't create a strong circular reference with the parent
    weak var delegate: BackButtonDelegate!

    override init(texture: SKTexture?, color: SKColor, size: CGSize) {

        super.init(texture: texture, color: color, size: size)

        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        setup()
    }

    func setup() {
        isUserInteractionEnabled = true
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        setScale(0.9)
        self.delegate.backButtonClicked(sender: self)
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        setScale(1.0)
    }
}


class CastleMenu: SKScene, ButtonDelegate, BackButtonDelegate {
    
    private var button = Button()
    
    var sceneColor = UIColor(red: 0.6, green: 1.0, blue: 0.6,
                             alpha: 1.0)
    let title = SKLabelNode(text: "Walking Challenge RPG")
    let buttonText = SKLabelNode(text: "To World Map")
    let buttonTexture = SKSpriteNode(color: .gray, size: CGSize(width: 100, height: 100))
    let buttonTexture2 = SKSpriteNode(color: .gray, size: CGSize(width: 100, height: 100))
    
    override func didMove(to view: SKView) {
        if let button = self.childNode(withName: "button") as? Button {
                    self.button = button
                    button.delegate = self
                }

        let button2 = Button(texture: nil, color: .gray, size: CGSize(width: view.frame.width / 2.8, height: view.frame.height / 3))
        let button3 = BackButton(texture: nil, color: .black, size: CGSize(width: view.frame.width / 10, height: view.frame.height / 10))
                button2.name = "button2"
                button2.position = CGPoint(x: view.frame.width / 2, y: view.frame.height / 10)
                button2.delegate = self
        button3.position = CGPoint(x: view.frame.width / 100, y: view.frame.height / 1.1)
                button3.delegate = self
                addChild(button2)
                addChild(button3)
        
        buttonTexture.position = CGPoint(x: view.frame.width / 2, y: view.frame.height / 10)
        buttonTexture.size = CGSize(width: view.frame.width / 3, height: view.frame.height / 3)
        buttonTexture2.position = CGPoint(x: view.frame.width / 10, y: view.frame.height / 1)
        buttonTexture2.size = CGSize(width: view.frame.width / 10, height: view.frame.height / 3)
        
        buttonText.position = CGPoint(x: view.frame.width / 2, y: view.frame.height / 7.4)
        buttonText.fontSize = 18
        buttonText.fontColor = SKColor.white
        buttonText.fontName = "Courier New Bold"
        self.backgroundColor = sceneColor
        
    addChild(buttonText)
    }
    
    func buttonClicked(sender: Button) {
        let transition:SKTransition = SKTransition.fade(withDuration: 1)
        let scene: SKScene = WorldMap(size: self.size)
        self.view?.presentScene(scene, transition: transition)
        
    }
    
    func backButtonClicked(sender: BackButton) {
        let transition:SKTransition = SKTransition.fade(withDuration: 1)
        let scene: SKScene = TitleScreen(size: self.size)
        self.view?.presentScene(scene, transition: transition)
        
    }
    
}
