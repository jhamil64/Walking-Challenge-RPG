
import Foundation
import SpriteKit

let damageInfo = SKLabelNode()
var damageNumber: Float = 0

protocol EnemyButtonDelegate: AnyObject {
    func enemyButtonClicked(sender: EnemyButton)
}

class EnemyButton: SKSpriteNode {

    //weak so that you don't create a strong circular reference with the parent
    weak var delegate: EnemyButtonDelegate!

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
        self.delegate.enemyButtonClicked(sender: self)
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        setScale(1.0)
    }
}

class Level1: SKScene, EnemyButtonDelegate, BackButtonDelegate {
    
    private var button = EnemyButton()
    
    let grayRatSprite = SKTexture(imageNamed: "gray_rat")
    let heroCatSprite = SKSpriteNode(imageNamed: "HeroCat")
    
    
    
    var sceneColor = UIColor(red: 0.6, green: 1.0, blue: 0.6,
                             alpha: 1.0)
    
    
    override func didMove(to view: SKView) {
        self.backgroundColor = sceneColor
        
        let button2 = EnemyButton(texture: grayRatSprite, color: .black, size: CGSize(width: view.frame.width / 8, height: view.frame.height / 8))
        button2.name = "stage1"
        button2.position = CGPoint(x: view.frame.width / 1.4, y: view.frame.height / 2)
        button2.delegate = self
        let button3 = BackButton(texture: nil, color: .black, size: CGSize(width: view.frame.width / 10, height: view.frame.height / 10))
        button3.position = CGPoint(x: view.frame.width / 100, y: view.frame.height / 1.1)
        button3.delegate = self
                addChild(button3)
        addChild(button2)
        heroCatSprite.position = CGPoint(x: view.frame.width / 4, y: view.frame.height / 2)
        heroCatSprite.setScale(3.0)
        addChild(heroCatSprite)
        
        damageInfo.position = CGPoint(x: view.frame.width / 1.4, y: view.frame.height / 1.7)
        damageInfo.fontSize = 24
        damageInfo.fontColor = SKColor.black
        damageInfo.fontName = "Helvetica"
        addChild(damageInfo)

        
        
    }
    
    
    func enemyButtonClicked(sender: EnemyButton) {
        let damage: Float = round((gameStats.heroCatTest.baseAttack - (gameStats.testEnemy.baseDefense/2))*Float.random(in: 0.9..<1.1))
        let floatToString: String = String(format: "%.01f", damage)
        
        damageInfo.text = floatToString
        
        print(damage)
        gameStats.testEnemy.currentHP -= damage
        if (gameStats.testEnemy.currentHP <= 0)
        {
            print("He's dead, Jim")
        }
        
    }
    
    func backButtonClicked(sender: BackButton) {
        let transition:SKTransition = SKTransition.fade(withDuration: 1)
        let scene: SKScene = WorldMap(size: self.size)
        self.view?.presentScene(scene, transition: transition)
        
    }
    
}
