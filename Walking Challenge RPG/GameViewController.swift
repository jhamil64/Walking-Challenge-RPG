import SpriteKit
import UIKit
 
class GameViewController: UIViewController {
    
    override func viewDidLoad() {
        let scene = TitleScreen(size: view.frame.size)
        let skView = view as! SKView
        skView.presentScene(scene)
        
    }
 
}
