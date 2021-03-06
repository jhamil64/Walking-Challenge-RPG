//
//  TouchableShapeNode.swift
//  Inventory
//
//  Created by David Norman on 8/16/15.
//  Copyright (c) 2015 David Norman. All rights reserved.
//

import SpriteKit

protocol InventoryItemNodeProtocol {
    func InventoryNodeTouched(item:InventoryItem?)
    func resetAllNodesToDefault()
}

var INV_COLOR_SELECTED = UIColor.blue
var INV_COLOR_DESELECTED = UIColor.black

class InventoryItemNode: SKShapeNode {
    
    var delegate : InventoryItemNodeProtocol?
    var itemName : InventoryItemName?
    var selected = false
    var imageNode : SKSpriteNode?
    var backgroundImage: SKSpriteNode?
    var number = 0
    var item : InventoryItem?
    
    override init() {
        super.init()
        self.isUserInteractionEnabled = true
    }
    
    func updateWithItem(item: InventoryItem?) {
        self.removeAllChildren()
        if let realItem = item {
            self.item = item
            self.itemName = InventoryItemName(rawValue: realItem.imageName!)
            imageNode = SKSpriteNode(imageNamed: realItem.imageName!)
            imageNode?.size = CGSize(width: 35, height: 35)
            self.addChild(imageNode!)
            
            let countLabel = SKLabelNode(text: realItem.numberInStack == 0 ? "" : String(realItem.numberInStack))
            countLabel.fontSize = 20
            countLabel.position = CGPoint(x: -15, y: 5)
            countLabel.fontColor = UIColor.white
            countLabel.fontName = "AmericanTypewriter-Bold"
            countLabel.zPosition = 10
            self.addChild(countLabel)
            updateWithBackgroundImageNode()
        } else {
            self.imageNode = SKSpriteNode(imageNamed: "")
            updateWithBackgroundImageNode()
        }

    }
    
    func addImageOnly(item: InventoryItem?) {
        if let realItem = item {
            self.itemName = InventoryItemName(rawValue: realItem.imageName!)
            imageNode = SKSpriteNode(imageNamed: realItem.imageName!)
            self.addChild(imageNode!)
            imageNode!.size = CGSize(width: 35, height: 35)
        }
    }
    
    func updateWithBackgroundImageNode() {
        if self.backgroundImage != nil {
            self.addChild(backgroundImage!)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        delegate?.resetAllNodesToDefault()

            self.selectItem()
        
        delegate?.InventoryNodeTouched(item: self.item)

    }
    
    func selectItem() {
        
        if (self.item?.isOwned == true) {
            self.fillColor = INV_COLOR_SELECTED
            self.selected = true
            
        }
        
        print("selected: \(String(describing: self.itemName))")

    }
    
    func deselect() {
        self.fillColor = INV_COLOR_DESELECTED
        self.selected = false
    }
    
    override func copy(with zone: NSZone? = nil) -> Any {
        let invItemNodeCopy = InventoryItemNode()
        invItemNodeCopy.delegate = delegate
        invItemNodeCopy.itemName = itemName
        invItemNodeCopy.selected = selected
        invItemNodeCopy.imageNode = imageNode
        invItemNodeCopy.backgroundImage = backgroundImage
        invItemNodeCopy.number = number
        invItemNodeCopy.item = item
        return invItemNodeCopy
    }

    
}
