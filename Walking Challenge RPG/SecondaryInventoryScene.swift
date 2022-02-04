//
//  SecondaryInventoryScene.swift
//  PestControl
//
//  Created by David Norman on 8/22/15.
//  Copyright (c) 2015 Razeware LLC. All rights reserved.
//

import SpriteKit

class SecondaryInventoryScene: SKScene, MenuButtonDelegate {
    
    var inventorySpriteNode: InventorySpriteNode?
    var equippedSlotsSpriteNode: EquippedSlotsSpriteNode?
    
    //MARK: - Lifecycle 
    override func didMove(to view: SKView) {
        
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        inventorySpriteNode = InventorySpriteNode(size: CGSize(width: 0, height: 0))
        self.addChild(inventorySpriteNode!)
        inventorySpriteNode!.showInventory()
        
        equippedSlotsSpriteNode = EquippedSlotsSpriteNode(size: CGSize(width: 0, height: 0))
        self.addChild(equippedSlotsSpriteNode!)
        equippedSlotsSpriteNode!.showInventory()
        
        inventorySpriteNode!.delegate = equippedSlotsSpriteNode
        
        let updateButton = MenuButton(color: UIColor.black, size: CGSize(width: 25, height: 25))
        updateButton.name = "updateSlotsButton"
        updateButton.texture = SKTexture(image: UIImage(named: "closeButton")!)
        updateButton.color = UIColor.black
        updateButton.position = CGPoint(x: self.size.width / 2 - updateButton.size.width, y: 140)
        updateButton.delegate = self
        updateButton.isUserInteractionEnabled = true
        self.addChild(updateButton)
        print("\(self.equippedSlotsSpriteNode?.listItemsInSlots())")
    }
    
    func menuButtonTouched() {
        NotificationCenter.default.post(name:Notification.Name("com.davidwnorman.dismissMainMenu"), object: nil)
    }
   
}
