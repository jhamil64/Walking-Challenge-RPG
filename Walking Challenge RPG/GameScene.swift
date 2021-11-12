import SpriteKit

var sceneColor = UIColor(red: 0.6, green: 0.6, blue: 1.0,
                         alpha: 1.0)

class GameScene: SKScene {
    
    let title = SKLabelNode(text: "Walking Challenge RPG")
    let stepText = SKLabelNode(text: "Steps Walked")
    let moneyText = SKLabelNode(text: "Total Gold")
    let buttonText = SKLabelNode(text: "To Castle Area")
    let challengeText = SKLabelNode(text: "Active Challenges")
    let buttonTexture = SKSpriteNode(color: .blue, size: CGSize(width: 100, height: 100))
    
    override func didMove(to view: SKView) {
        
        self.backgroundColor = sceneColor
        
        title.position = CGPoint(x: view.frame.width / 2, y: view.frame.height / 1.2)
        title.fontSize = 26
        title.fontColor = SKColor.black
        title.fontName = "Helvetica"
        
        stepText.position = CGPoint(x: view.frame.width / 2, y: view.frame.height / 1.5)
        stepText.fontSize = 21
        stepText.fontColor = SKColor.black
        stepText.fontName = "Helvetica"
        
        moneyText.position = CGPoint(x: view.frame.width / 2, y: view.frame.height / 2.0)
        moneyText.fontSize = 21
        moneyText.fontColor = SKColor.black
        moneyText.fontName = "Helvetica"
        
        challengeText.position = CGPoint(x: view.frame.width / 2, y: view.frame.height / 3.0)
        challengeText.fontSize = 21
        challengeText.fontColor = SKColor.black
        challengeText.fontName = "Helvetica"
        
        buttonTexture.position = CGPoint(x: view.frame.width / 2, y: view.frame.height / 6.1)
        buttonTexture.size = CGSize(width: view.frame.width / 1.5, height: view.frame.height / 8)
        
        buttonText.position = CGPoint(x: view.frame.width / 2, y: view.frame.height / 6.0)
        buttonText.fontSize = 23
        buttonText.fontColor = SKColor.white
        buttonText.fontName = "Courier New Bold"
        
    addChild(title)
    addChild(stepText)
    addChild(moneyText)
    addChild(challengeText)
    addChild(buttonTexture)
    addChild(buttonText)
        
    }
 
}
