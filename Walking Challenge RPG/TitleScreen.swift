//  Pedometer related code was created by Steven Lipton on 2/10/17.
//  Technically, it is not the same anymore because we had to make many edits, but better safe than sorry.
//

import SpriteKit
import CoreMotion
import UIKit

import Foundation

var goldSaver = UserDefaults.standard
var experience = UserDefaults.standard
var completionFlag = UserDefaults.standard

protocol ButtonDelegate: AnyObject {
    func buttonClicked(sender: Button)
}

class Button: SKSpriteNode {

    //weak so that you don't create a strong circular reference with the parent
    weak var delegate: ButtonDelegate!

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
        self.delegate.buttonClicked(sender: self)
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        setScale(1.0)
    }
}




@objcMembers class TitleScreen: SKScene, ButtonDelegate {

    private var button = Button()
    
    var sceneColor = UIColor(red: 0.6, green: 0.6, blue: 1.0,
                             alpha: 1.0)
    var pedometer = CMPedometer()
    var numberOfSteps:Int! = nil
    var stepDifference:Int! = nil
    var timer = Timer()
    var timerInterval = 1.0
    var timeElapsed:TimeInterval = 1.0

    
    
    let title = SKLabelNode(text: "Walking Challenge RPG")
    let stepText = SKLabelNode(text: "Steps Walked")
    let moneyText = SKLabelNode(text: "Total Gold")
    let buttonText = SKLabelNode(text: "To Castle Area")
    let challengeText = SKLabelNode(text: "Active Challenges")
    let stepsLabel = SKLabelNode(text: "(Steps This Session)")
    let currentGoldLabel = SKLabelNode(text: "Current Gold")

    
     
    func timeIntervalFormat(interval:TimeInterval)-> String{
            var seconds = Int(interval + 0.5) //round up seconds
            let hours = seconds / 3600
            let minutes = (seconds / 60) % 60
            seconds = seconds % 60
            return String(format:"%02i:%02i:%02i",hours,minutes,seconds)
        }
    
    func timerAction(timer:Timer) {
        displayPedometerData()
    }
    
    func startTimer(){
            if timer.isValid { timer.invalidate() }
            timer = Timer.scheduledTimer(timeInterval: timerInterval,target: self,selector: #selector(timerAction(timer:)) ,userInfo: nil,repeats: true)
        }
    

    
    
    func displayData()
    {
//        stepsLabel.text = String(format: "%i", numberOfSteps)
        pedometer.startUpdates(from: Date(), withHandler: { (pedometerData, error) in
                        if let pedData = pedometerData{
                            self.numberOfSteps = Int(truncating: pedData.numberOfSteps)
                            
                             
//                            //self.stepsLabel.text = "Steps:\(pedData.numberOfSteps)"
//                            stepSaver = numberOfSteps as NSInteger?
//                            stepsLabel.text = Int?(self.stepSaver)
                            
                        } else {
                            self.numberOfSteps = nil
                        }
                    })
    }
    
    func displayPedometerData()
    {
 
        if let numberOfSteps = self.numberOfSteps{
                    stepsLabel.text = String(format:"%i",numberOfSteps)
            let stepCheck1 = Int(self.numberOfSteps)
            do{
                sleep(2);
            }
            
            let stepCheck2 = Int(self.numberOfSteps)
            self.stepDifference = Int?(stepCheck2 - stepCheck1)
            let currentGold = goldSaver.integer(forKey: "Gold")+self.stepDifference
            goldSaver.set(currentGold, forKey: "Gold")
            currentGoldLabel.text = String(format:"%i",currentGold)
        }

    
        
        
    }
    

    
        override func didMove(to view: SKView) {
            
            if let button = self.childNode(withName: "button") as? Button {
                        self.button = button
                        button.delegate = self
                    }

                    let button2 = Button(texture: nil, color: .blue, size: CGSize(width: view.frame.width / 1.5, height: view.frame.height / 8))
                    button2.name = "button2"
                    button2.position = CGPoint(x: view.frame.width / 2, y: view.frame.height / 7.2)
                    button2.delegate = self
                    addChild(button2)
            
            buttonText.position = CGPoint(x: view.frame.width / 2, y: view.frame.height / 7.4)
            buttonText.fontSize = 23
            buttonText.fontColor = SKColor.white
            buttonText.fontName = "Courier New Bold"
            
        
        self.backgroundColor = sceneColor
        
        stepsLabel.position = CGPoint(x: view.frame.width / 2, y: view.frame.height / 1.7)
        stepsLabel.fontSize = 21
        stepsLabel.fontColor = SKColor.white
        stepsLabel.fontName = "Helvetica"
        
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
        
        currentGoldLabel.position = CGPoint(x: view.frame.width / 2, y: view.frame.height / 2.33)
        currentGoldLabel.fontSize = 21
        currentGoldLabel.fontColor = SKColor.yellow
        currentGoldLabel.fontName = "Helvetica"
        
        
        
    addChild(title)
    addChild(stepText)
    addChild(moneyText)
    addChild(challengeText)
    addChild(buttonText)
    addChild(stepsLabel)
    addChild(currentGoldLabel)
        
        goldSaver.set(goldSaver.integer(forKey: "Gold"), forKey: "Gold")
        currentGoldLabel.text = String(format:"%i",goldSaver.integer(forKey: "Gold"))
        startTimer()

        displayData()
    
        
    }
        
     
    func buttonClicked(sender: Button) {
        let transition:SKTransition = SKTransition.fade(withDuration: 1)
        let scene: SKScene = CastleMenu(size: self.size)
        self.view?.presentScene(scene, transition: transition)
        
    }
 
}
