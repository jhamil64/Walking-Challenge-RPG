import Foundation
import SpriteKit


class StaffConfirmation: SKScene, ButtonDelegate, BackButtonDelegate {
    private var button = Button()
    var sceneColor = UIColor(red: 1.0, green: 1.0, blue: 1.0,
                             alpha: 1.0)
    let confirmationText = SKLabelNode(text: "Do you want to buy the Staff for 10 Gold?")
    let yes = SKLabelNode(text: "Yes")
    let no = SKLabelNode(text: "No")

    override func didMove(to view: SKView) {
        
        
        
    if let button = self.childNode(withName: "button") as? Button {
                    self.button = button
                    button.delegate = self
                }
        
    let button2 = Button(texture: nil, color: .green, size: CGSize(width: view.frame.width / 5, height: view.frame.height / 5))
        button2.position = CGPoint(x: view.frame.width / 1.5, y: view.frame.height / 2)
        button2.delegate = self
                addChild(button2)
        
    let button3 = BackButton(texture: nil, color: .red, size: CGSize(width: view.frame.width / 5, height: view.frame.height / 5))
            button3.position = CGPoint(x: view.frame.width / 3, y: view.frame.height / 2)
            button3.delegate = self
                    addChild(button3)
        
        confirmationText.position = CGPoint(x: view.frame.width / 2, y: view.frame.height / 1.1)
        confirmationText.fontSize = 24
        confirmationText.fontName = "Helvetica"
        addChild(confirmationText)
        yes.position = CGPoint(x: view.frame.width / 1.5, y: view.frame.height / 2)
        no.position = CGPoint(x: view.frame.width / 3, y: view.frame.height / 2)
        yes.fontSize = 24
        yes.fontName = "Helvetica"
        no.fontSize = 24
        no.fontName = "Helvetica"
        addChild(yes)
        addChild(no)
        
    }
    
    
    func buttonClicked(sender: Button) {
        
        goldSaver.set(goldSaver.integer(forKey: "Gold")+10, forKey: "Gold")
        experience.set(experience.integer(forKey: "EXP"), forKey: "EXP")

        let boughtStaff = GameState.findInventoryItemInEitherStorage(inventoryItemName: InventoryItemName.staff)
            staffOwned.set(true, forKey: "staffCheck")
            boughtStaff?.isOwned = staffOwned.bool(forKey: "staffCheck");
            
         
            print(staffOwned)
        
        
    }
    
    func backButtonClicked(sender: BackButton) {
        let transition:SKTransition = SKTransition.fade(withDuration: 1)
        let scene: SKScene = ShopScreen(size: self.size)
        self.view?.presentScene(scene, transition: transition)
        
    }


    
}





