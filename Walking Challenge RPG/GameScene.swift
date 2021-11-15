//  Pedometer related code was created by Steven Lipton on 2/10/17.
//  Technically, it is not the same anymore because we had to make many edits, but better safe than sorry.
//

import SpriteKit
import CoreMotion
import UIKit



@objcMembers class GameScene: SKScene {
    var sceneColor = UIColor(red: 0.6, green: 0.6, blue: 1.0,
                             alpha: 1.0)
    var pedometer = CMPedometer()
    var distance:Double! = nil
    var averagePace:Double! = nil
    var pace:Double! = nil
    var numberOfSteps:Int! = nil
    var timer = Timer()
    var timerInterval = 1.0
    var timeElapsed:TimeInterval = 1.0
    
    
    let title = SKLabelNode(text: "Walking Challenge RPG")
    let stepText = SKLabelNode(text: "Steps Walked")
    let moneyText = SKLabelNode(text: "Total Gold")
    let buttonText = SKLabelNode(text: "To Castle Area")
    let challengeText = SKLabelNode(text: "Active Challenges")
    let buttonTexture = SKSpriteNode(color: .blue, size: CGSize(width: 100, height: 100))
    let statusTitle = SKLabelNode(text: "Text")
    let stepsLabel = SKLabelNode(text: "(Steps This Session)")
    let avgPaceLabel = SKLabelNode(text: "avgPace")
    let paceLabel = SKLabelNode(text: "pace")
    let distanceLabel = SKLabelNode(text: "distance")
    

     
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
                            //self.stepsLabel.text = "Steps:\(pedData.numberOfSteps)"
                            
                        } else {
                            self.numberOfSteps = nil
                        }
                    })
    }
    
    func displayPedometerData()
    {
            timeElapsed += 1.0
        if let numberOfSteps = self.numberOfSteps{
                    stepsLabel.text = String(format:"%i",numberOfSteps)
        }
        
    }
    
    override func didMove(to view: SKView) {
        
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
        
        buttonTexture.position = CGPoint(x: view.frame.width / 2, y: view.frame.height / 7.2)
        buttonTexture.size = CGSize(width: view.frame.width / 1.5, height: view.frame.height / 8)
        
        buttonText.position = CGPoint(x: view.frame.width / 2, y: view.frame.height / 7.4)
        buttonText.fontSize = 23
        buttonText.fontColor = SKColor.white
        buttonText.fontName = "Courier New Bold"
        
    addChild(title)
    addChild(stepText)
    addChild(moneyText)
    addChild(challengeText)
    addChild(buttonTexture)
    addChild(buttonText)
    addChild(stepsLabel)
        
        
        startTimer()
        displayData()
    
        
    }
 
}
