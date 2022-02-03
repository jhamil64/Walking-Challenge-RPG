import SpriteKit
import UIKit
 
class GameViewController: UIViewController {
    
    var scene: InventoryScene?
    @IBOutlet weak var inventoryMenuView: SKView!

    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Configure the game state for this demo!
        GameState.inititialSetup()

        //setup view
        self.view.backgroundColor = UIColor.black

        //setup scene
        self.scene = InventoryScene(size: self.view.bounds.size)
        inventoryMenuView.showsFPS = true
        inventoryMenuView.showsNodeCount = true
        inventoryMenuView.ignoresSiblingOrder = true
        self.scene!.scaleMode = .resizeFill
        inventoryMenuView.presentScene(scene)
        
        let scene = TitleScreen(size: view.frame.size)
        let skView = view as! SKView
        skView.presentScene(scene)
        
    }

    
    @IBAction func addSword(sender: AnyObject) {
        let foundItem = GameState.findInventoryItemInEitherStorage(inventoryItemName: InventoryItemName.sword_silver)
        foundItem?.numberInStack += 1
        NotificationCenter.default.post(name:Notification.Name("com.davidwnorman.updateEquippedSlots"), object: nil)
    }

 
}
