
import Foundation
import SpriteKit

protocol Level2ButtonDelegate: AnyObject {
    func level2ButtonClicked(sender: Level2Button)
}

class Level2Button: SKSpriteNode {

    //weak so that you don't create a strong circular reference with the parent
    weak var delegate: Level2ButtonDelegate!

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
        self.delegate.level2ButtonClicked(sender: self)
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        setScale(1.0)
    }
}

class LevelSelect: SKScene, ButtonDelegate, BackButtonDelegate, Level2ButtonDelegate {
    
    private var button = Button()
    
    var sceneColor = UIColor(red: 0.4, green: 1.0, blue: 0.4,
                             alpha: 1.0)
    let title = SKLabelNode(text: "Greenhorn Grassland")
    let alreadyDone = SKLabelNode(text: "Choose a level")
    
    override func didMove(to view: SKView) {
        self.backgroundColor = sceneColor
        title.position = CGPoint(x: view.frame.width / 2, y: view.frame.height / 1.2)
        title.fontName = "Helvetica"
        alreadyDone.position = CGPoint(x: view.frame.width / 2, y: view.frame.height / 1.5)
        alreadyDone.fontSize = 20
        alreadyDone.fontName = "Helvetica"
        addChild(alreadyDone)
        
        let Stage1 = Button(texture: nil, color: .black, size: CGSize(width: view.frame.width / 10, height: view.frame.height / 10))
        Stage1.name = "stage1"
        Stage1.position = CGPoint(x: view.frame.width / 6, y: view.frame.height / 1.5)
        Stage1.delegate = self
        
        let Stage2 = Level2Button(texture: nil, color: .black, size: CGSize(width: view.frame.width / 10, height: view.frame.height / 10))
        Stage2.name = "stage2"
        Stage2.position = CGPoint(x: view.frame.width / 4, y: view.frame.height / 2)
        Stage2.delegate = self
        
        let button3 = BackButton(texture: nil, color: .black, size: CGSize(width: view.frame.width / 10, height: view.frame.height / 10))
        button3.position = CGPoint(x: view.frame.width / 100, y: view.frame.height / 1.1)
        button3.delegate = self
                addChild(Stage1)
                addChild(Stage2)
                addChild(button3)
        
    addChild(title)
        
        
    }
    
    func buttonClicked(sender: Button) {
//        if (completionFlag.bool(forKey: "true") == true)
//        {
//            alreadyDone.text = "Already completed this"
//        }
//        else {
        let transition:SKTransition = SKTransition.fade(withDuration: 1)
        let scene: SKScene = Level1(size: self.size)
        self.view?.presentScene(scene, transition: transition)
//        }
        
    }
    
    func backButtonClicked(sender: BackButton) {
        let transition:SKTransition = SKTransition.fade(withDuration: 1)
        let scene: SKScene = WorldMap(size: self.size)
        self.view?.presentScene(scene, transition: transition)
        
    }
    
    func level2ButtonClicked(sender: Level2Button) {
//        if (completionFlag.bool(forKey: "true") == true)
//        {
//            alreadyDone.text = "Already completed this"
//        }
        let transition:SKTransition = SKTransition.fade(withDuration: 1)
        let scene: SKScene = Level2(size: self.size)
        self.view?.presentScene(scene, transition: transition)
        
    }
    
}
