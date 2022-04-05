
import Foundation
import SpriteKit


protocol BackButtonDelegate: AnyObject {
    func backButtonClicked(sender: BackButton)
}

protocol InventoryButtonDelegate: AnyObject {
    func inventoryButtonClicked(sender: InventoryButton)
}

protocol ShopButtonDelegate: AnyObject {
    func shopButtonClicked(sender: ShopButton)
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

class ShopButton: SKSpriteNode {

    //weak so that you don't create a strong circular reference with the parent
    weak var delegate: ShopButtonDelegate!

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
        self.delegate.shopButtonClicked(sender: self)
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        setScale(1.0)
    }
}

class InventoryButton: SKSpriteNode {

    //weak so that you don't create a strong circular reference with the parent
    weak var delegate: InventoryButtonDelegate!

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
        self.delegate.inventoryButtonClicked(sender: self)
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        setScale(1.0)
    }
}


class CastleMenu: SKScene, ButtonDelegate, BackButtonDelegate, InventoryButtonDelegate, ShopButtonDelegate {
    
    
    private var button = Button()
    
    var sceneColor = UIColor(red: 0.6, green: 1.0, blue: 0.6,
                             alpha: 1.0)

    let buttonText = SKLabelNode(text: "To World Map")
    
    override func didMove(to view: SKView) {
        if let button = self.childNode(withName: "button") as? Button {
                    self.button = button
                    button.delegate = self
                }

        let button2 = Button(texture: nil, color: .gray, size: CGSize(width: view.frame.width / 2.8, height: view.frame.height / 3))
        let button3 = BackButton(texture: nil, color: .black, size: CGSize(width: view.frame.width / 10, height: view.frame.height / 10))
        let button4 = InventoryButton(texture: nil, color: .white, size: CGSize(width: view.frame.width / 3.4, height: view.frame.height / 4))
        let button5 = ShopButton(texture: nil, color: .yellow, size: CGSize(width: view.frame.width / 8, height: view.frame.height / 6))
                button2.position = CGPoint(x: view.frame.width / 2, y: view.frame.height / 10)
                button2.delegate = self
                button3.position = CGPoint(x: view.frame.width / 100, y: view.frame.height / 1.1)
                button3.delegate = self
                button4.position = CGPoint(x: view.frame.width / 2, y: view.frame.height / 2)
                button4.delegate = self
        button5.position = CGPoint(x: view.frame.width / 1.23, y: view.frame.height / 1.3)
                button5.delegate = self
                addChild(button2)
                addChild(button3)
                addChild(button4)
                addChild(button5)

        
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
    
    func shopButtonClicked(sender: ShopButton) {
        let transition:SKTransition = SKTransition.fade(withDuration: 1)
        let scene: SKScene = ShopScreen(size: self.size)
        self.view?.presentScene(scene, transition: transition)
        
    }
    
    func backButtonClicked(sender: BackButton) {
        let transition:SKTransition = SKTransition.fade(withDuration: 1)
        let scene: SKScene = TitleScreen(size: self.size)
        self.view?.presentScene(scene, transition: transition)
        
    }
    
    func inventoryButtonClicked(sender: InventoryButton) {
        let transition:SKTransition = SKTransition.fade(withDuration: 1)
        let scene: SKScene = SecondaryInventoryScene(size: self.size)
        self.view?.presentScene(scene, transition: transition)
        
    }
    
}
