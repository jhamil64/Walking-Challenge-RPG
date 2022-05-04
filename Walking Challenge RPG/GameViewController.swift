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
    func assignbackgroundCastle(){
    let background = UIImage(named: "grass")
    var imageView : UIImageView!
    imageView = UIImageView(frame: view.bounds)
    imageView.contentMode = UIView.ContentMode.scaleAspectFill
    imageView.clipsToBounds = true
    imageView.image = background
    imageView.center = view.center
    view.addSubview(imageView)
    self.view.sendSubviewToBack(imageView)
    }
    
    @IBAction func addStew(sender: AnyObject) {
        let foundItem = GameState.findInventoryItemInEitherStorage(inventoryItemName: InventoryItemName.stew)
        foundItem?.numberInStack += 1
        NotificationCenter.default.post(name:Notification.Name("com.davidwnorman.updateEquippedSlots"), object: nil)
    }

 
}
