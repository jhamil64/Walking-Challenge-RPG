import SpriteKit
 
class GameViewController: UIViewController {
    
    override func viewDidLoad() {
        let scene = GameScene(size: view.frame.size)
        let skView = view as! SKView
        skView.presentScene(scene)
    }
 
}

class GoldCount: NSObject, NSCoding {
    var gold = 0

    func encode(with coder: NSCoder) {
        coder.encode(gold, forKey: "gold")
    }
    
    required convenience init(coder decoder: NSCoder) {
        self.init()
        gold = decoder.decodeInteger(forKey: "gold")
    }
    
    
    
}

func saveGame(notification: NSNotification) {
    var player: GoldCount
    let saveData = NSMutableData()
    let archiver = NSKeyedArchiver(forWritingWith: saveData)

    archiver.encode(player.gold, forKey: "gold")
    archiver.finishEncoding()

    let saveLocation = saveFileLocation()
    _ = saveData.write(to: saveLocation, atomically: true)
    
    NotificationCenter.default.addObserver(self,
        selector:#selector(GameViewController.saveGame(_:)),
        name:NSNotification.Name.NSApplicationWillTerminateNotification, object:nil)
}

func loadGame() {
    let saveLocation = saveFileLocation()
    if let saveData = try? Data(contentsOf: saveLocation) {
        let unarchiver = NSKeyedUnarchiver(forReadingWith: saveData)
        player.score = unarchiver.decodeInteger(forKey: "gold")
        unarchiver.finishDecoding()
    }
}
