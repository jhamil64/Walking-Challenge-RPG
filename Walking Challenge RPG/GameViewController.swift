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
        
        let scene = TitleScreen(size: view.frame.size)
        let skView = view as! SKView
        skView.presentScene(scene)
        
    }

    
    @IBAction func addStew(sender: AnyObject) {
        let foundItem = GameState.findInventoryItemInEitherStorage(inventoryItemName: InventoryItemName.stew)
        foundItem?.numberInStack += 1
        NotificationCenter.default.post(name:Notification.Name("com.davidwnorman.updateEquippedSlots"), object: nil)
    }

 
}
