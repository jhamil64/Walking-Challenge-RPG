
import Foundation
import SpriteKit

let staffIcon = SKTexture(imageNamed: "staff")
let stewIcon = SKTexture(imageNamed: "stew")
let rubyIcon = SKTexture(imageNamed: "ore_ruby")

protocol ExpButton1Delegate: AnyObject {
    func expButton1Clicked(sender: ExpButton1)
}

protocol ExpButton2Delegate: AnyObject {
    func expButton2Clicked(sender: ExpButton2)
}


class ExpButton1: SKSpriteNode {

    //weak so that you don't create a strong circular reference with the parent
    weak var delegate: ExpButton1Delegate!

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
        self.delegate.expButton1Clicked(sender: self)
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        setScale(1.0)
    }
}

class ExpButton2: SKSpriteNode {

    //weak so that you don't create a strong circular reference with the parent
    weak var delegate: ExpButton2Delegate!

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
        self.delegate.expButton2Clicked(sender: self)
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        setScale(1.0)
    }
}

class ShopScreen: SKScene, ButtonDelegate, BackButtonDelegate, ExpButton1Delegate, ExpButton2Delegate {
    

    
    private var button = Button()
    
    var sceneColor = UIColor(red: 1.0, green: 1.0, blue: 1.0,
                             alpha: 1.0)
    let title = SKLabelNode(text: "Shop")
    
    let currentGold = SKLabelNode(text: String(format:"%i",goldSaver.integer(forKey: "Gold")))
    let expText = SKLabelNode(text: String(format:"%i",experience.integer(forKey: "EXP")))
    let invalidExp = SKLabelNode(text: "Not enough exp to buy this")
    
    
    override func didMove(to view: SKView) {
        
        goldSaver.set(goldSaver.integer(forKey: "Gold"), forKey: "Gold")
        currentGold.text = String(format:"%i",goldSaver.integer(forKey: "Gold"))
        experience.set(experience.integer(forKey: "EXP"), forKey: "EXP")
        expText.text = String(format:"%i",experience.integer(forKey: "EXP"))
        
        if let button = self.childNode(withName: "button") as? Button {
                    self.button = button
                    button.delegate = self
                }
        
        let button2 = Button(texture: stewIcon, color: .green, size: CGSize(width: view.frame.width / 10, height: view.frame.height / 10))
        button2.position = CGPoint(x: view.frame.width / 1.2, y: view.frame.height / 2)
        button2.delegate = self
                addChild(button2)

        let button3 = BackButton(texture: nil, color: .black, size: CGSize(width: view.frame.width / 10, height: view.frame.height / 10))
        button3.position = CGPoint(x: view.frame.width / 100, y: view.frame.height / 1.1)
        button3.delegate = self
                addChild(button3)
        
        let button4 = ExpButton1(texture: staffIcon, color: .yellow, size: CGSize(width: view.frame.width / 10, height: view.frame.height / 10))
        button4.position = CGPoint(x: view.frame.width / 1.5, y: view.frame.height / 2)
                button4.delegate = self
                addChild(button4)
        
        let button5 = ExpButton2(texture: rubyIcon, color: .yellow, size: CGSize(width: view.frame.width / 10, height: view.frame.height / 10))
        button5.position = CGPoint(x: view.frame.width / 2.1, y: view.frame.height / 2)
                button5.delegate = self
                addChild(button5)
        
        title.fontSize = 32
        title.fontColor = SKColor.black
        title.position = CGPoint(x: view.frame.width / 2, y: view.frame.height / 1.2)
        currentGold.fontSize = 24
        currentGold.fontColor = SKColor.yellow
        currentGold.position = CGPoint(x: view.frame.width / 2, y: view.frame.height / 1.4)
        currentGold.fontName = "Helvetica"
        expText.fontSize = 24
        expText.fontColor = SKColor.blue
        expText.position = CGPoint(x: view.frame.width / 2, y: view.frame.height / 1.6)
        expText.fontName = "Helvetica"
        self.backgroundColor = sceneColor
        

        
    addChild(title)
    addChild(currentGold)
    addChild(expText)
    }
    
    func buttonClicked(sender: Button) {

        let transition:SKTransition = SKTransition.fade(withDuration: 1)
        let scene: SKScene = PotionConfirmation(size: self.size)
        self.view?.presentScene(scene, transition: transition)
        
        
    }
    
    func expButton1Clicked(sender: ExpButton1) {

        if (experience.integer(forKey: "EXP") <= 10){
            expText.text = "Not enough exp to buy this!"
        }
        else {
        
            let transition:SKTransition = SKTransition.fade(withDuration: 1)
            let scene: SKScene = StaffConfirmation(size: self.size)
            self.view?.presentScene(scene, transition: transition)
        }
        
    
        
        
    }
    
    func expButton2Clicked(sender: ExpButton2) {

        if (experience.integer(forKey: "EXP") <= 30){
            expText.text = "Not enough exp to buy this!"
        }
        else {
        
            let transition:SKTransition = SKTransition.fade(withDuration: 1)
            let scene: SKScene = RubyConfirmation(size: self.size)
            self.view?.presentScene(scene, transition: transition)
        }
        
    
        
        
    }
    
    func backButtonClicked(sender: BackButton) {
        let transition:SKTransition = SKTransition.fade(withDuration: 1)
        let scene: SKScene = CastleMenu(size: self.size)
        self.view?.presentScene(scene, transition: transition)
        
    }
    
}


