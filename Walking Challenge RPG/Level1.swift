
import Foundation
import SpriteKit

let damageInfo = SKLabelNode()
var playerHealthVariable: Float = gameStats.heroCat.maxHP
var playerHP = SKLabelNode(text: String(format: "%.01f", playerHealthVariable) + " HP")
let victoryText = SKLabelNode(text: "You Win!")
let gainedExp = SKLabelNode(text: "Gained 5 EXP")
let defeatText = SKLabelNode(text: "You Lose...")
let itemText = SKLabelNode(text: "Use Item")
let seconds = 1.0
let grayRatSprite = SKTexture(imageNamed: "gray_rat")
let heroCatSprite = SKSpriteNode(imageNamed: "HeroCat")

protocol EnemyButtonDelegate: AnyObject {
    func enemyButtonClicked(sender: EnemyButton)
}

protocol ItemButtonDelegate: AnyObject {
    func itemButtonClicked(sender: ItemButton)
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
        isUserInteractionEnabled = false
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            self.isUserInteractionEnabled = true
        }
        
    }
}



class ItemButton: SKSpriteNode {

    //weak so that you don't create a strong circular reference with the parent
    weak var delegate: ItemButtonDelegate!

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
        self.delegate.itemButtonClicked(sender: self)
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        setScale(1.0)
    }
}

class Level1: SKScene, EnemyButtonDelegate, BackButtonDelegate, ItemButtonDelegate {

    
    
    func setupBattle() {
        playerHealthVariable = Walking_Challenge_RPG.gameStats.heroCat.maxHP
        gameStats.grayRat.currentHP = gameStats.grayRat.maxHP
        playerHP = SKLabelNode(text: String(format: "%.01f", playerHealthVariable) + " HP")
        
    }

    
    private var button = EnemyButton()
    
    
    
    
    
    let button2 = EnemyButton(texture: grayRatSprite, color: .black, size: CGSize(width: 1, height: 1))
    
    
    
    var sceneColor = UIColor(red: 0.6, green: 1.0, blue: 0.6,
                             alpha: 1.0)
    
    
    override func didMove(to view: SKView) {
        setupBattle()
        self.backgroundColor = sceneColor
        
        button2.size = CGSize(width: view.frame.width / 8, height: view.frame.height / 8)
        button2.position = CGPoint(x: view.frame.width / 1.4, y: view.frame.height / 2)
        button2.delegate = self
        let button3 = BackButton(texture: nil, color: .black, size: CGSize(width: view.frame.width / 10, height: view.frame.height / 10))
        button3.position = CGPoint(x: view.frame.width / 100, y: view.frame.height / 1.1)
        button3.delegate = self
        let itemButton = ItemButton(texture: nil, color: .white, size: CGSize(width: view.frame.width / 4, height: view.frame.height / 4))
        itemButton.position = CGPoint(x: view.frame.width / 4, y: view.frame.height / 100)
        itemButton.delegate = self
        addChild(button3)
        addChild(button2)
        addChild(itemButton)
        
        heroCatSprite.position = CGPoint(x: view.frame.width / 4, y: view.frame.height / 2)
        heroCatSprite.setScale(3.0)
        addChild(heroCatSprite)
        
        damageInfo.position = CGPoint(x: view.frame.width / 1.4, y: view.frame.height / 1.7)
        damageInfo.fontSize = 24
        damageInfo.fontColor = SKColor.black
        damageInfo.fontName = "Helvetica"
        
        playerHP.position = CGPoint(x: view.frame.width / 4, y: view.frame.height / 1.7)
        playerHP.fontSize = 24
        playerHP.fontColor = SKColor.black
        playerHP.fontName = "Helvetica"
        addChild(playerHP)
        
        defeatText.position = CGPoint(x: view.frame.width / 2, y: view.frame.height / 1.25)
        defeatText.fontSize = 36
        defeatText.fontColor = SKColor.blue
        defeatText.fontName = "Helvetica"
        
        victoryText.position = CGPoint(x: view.frame.width / 2, y: view.frame.height / 1.25)
        victoryText.fontSize = 36
        victoryText.fontColor = SKColor.orange
        victoryText.fontName = "Helvetica"
        gainedExp.position = CGPoint(x: view.frame.width / 2, y: view.frame.height / 1.35)
        gainedExp.fontSize = 32
        gainedExp.fontColor = SKColor.orange
        gainedExp.fontName = "Helvetica"
        
        itemText.position = CGPoint(x: view.frame.width / 4, y: view.frame.height / 100)
        itemText.fontSize = 24
        itemText.fontColor = SKColor.black
        itemText.fontName = "Helvetica"
        addChild(itemText)
        
        
    }
    
    
    func enemyButtonClicked(sender: EnemyButton) {
        var damage: Float = round((gameStats.heroCat.baseAttack - (gameStats.grayRat.baseDefense/2))*Float.random(in: 0.9..<1.1))
        var floatToString: String = String(format: "%.01f", damage)
        
        damageInfo.text = floatToString + " damage dealt"
        addChild(damageInfo)
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            damageInfo.removeFromParent()
            
            gameStats.grayRat.currentHP -= damage
            if (gameStats.grayRat.currentHP <= 0)
            {
                self.addChild(victoryText)
                self.addChild(gainedExp)
                self.button2.size = CGSize(width: 0, height: 0)
                experience.set(experience.integer(forKey: "EXP")+5, forKey: "EXP")
                completionFlag.set(true, forKey: "true")
                return
            }
            
            damage = round((gameStats.grayRat.baseAttack - (gameStats.heroCat.baseDefense/2))*Float.random(in: 0.9..<1.1))
            playerHealthVariable -= damage
            floatToString = String(format: "%.01f", playerHealthVariable) + " HP"
            playerHP.text = floatToString
            
            if (playerHealthVariable <= 0)
            {
                self.addChild(defeatText)
                self.button2.size = CGSize(width: 0, height: 0)
                return
            }
        }
        
        
        
    }
    
    func backButtonClicked(sender: BackButton) {
        let transition:SKTransition = SKTransition.fade(withDuration: 1)
        let scene: SKScene = LevelSelect(size: self.size)
        self.view?.presentScene(scene, transition: transition)
        
    }
    
    func itemButtonClicked(sender: ItemButton) {
        var damage = round((gameStats.grayRat.baseAttack - (gameStats.heroCat.baseDefense/2))*Float.random(in: 0.9..<1.1))
        playerHealthVariable += 10
        var floatToString = String(format: "%.01f", playerHealthVariable) + " HP"

        let foundItem = GameState.findInventoryItemInEitherStorage(inventoryItemName: InventoryItemName.stew)
        foundItem?.numberInStack -= 1
    numStack.set(foundItem?.numberInStack, forKey: "num")
        NotificationCenter.default.post(name:Notification.Name("com.davidwnorman.updateEquippedSlots"), object: nil)

        playerHP.text = floatToString
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            playerHealthVariable -= damage
            floatToString = String(format: "%.01f", playerHealthVariable) + " HP"

            playerHP.text = floatToString

        if (playerHealthVariable <= 0)
        {
            self.addChild(defeatText)
            self.button2.size = CGSize(width: 0, height: 0)
            return
        }
    
        
    }
    
    }
}
