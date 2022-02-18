//
//  EquippedSlotsSpriteNode.swift
//  Inventory
//
//  Created by David Norman on 8/16/15.
//  Copyright (c) 2015 David Norman. All rights reserved.
//

import SpriteKit
import Foundation



class EquippedSlotsSpriteNode: SKSpriteNode,InventoryItemNodeProtocol, InventoryProtocol {
    
    var slotSelected: Bool
    
    init(size: CGSize) {
        slotSelected = false
        super.init(texture:nil, color: UIColor.clear, size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func showInventory() {
        
        let columns = EquippedSlotsConfig.numberOfColumns
        let rows = EquippedSlotsConfig.numberOfRows
        let squareWidth = CGFloat(50)
        
        self.size = CGSize(width: squareWidth, height: CGFloat(rows) * squareWidth)
        self.anchorPoint = CGPoint(x: 0.0,y: 0.5)
        self.position = CGPoint(x: self.parent!.frame.width / 2 - (squareWidth * 3), y: 0)
        var overallCount = 0
        
        for i in 0 ..< columns {
            for j in 0 ..< rows {
                
                let inventoryItem = InventoryItemNode(rectOf: CGSize(width: squareWidth, height: squareWidth))
                inventoryItem.delegate = self
                let updatedX = CGFloat(squareWidth / 2) + CGFloat(i * 50) - CGFloat(1)
                let updatedY = CGFloat(self.frame.size.height - (CGFloat(inventoryItem.frame.size.height))) / CGFloat(2) - (squareWidth * CGFloat(j))
                
                inventoryItem.position = CGPoint(x:updatedX, y:updatedY )
                inventoryItem.fillColor = UIColor.black
                inventoryItem.strokeColor = UIColor.white
                inventoryItem.lineWidth = 2.0
                inventoryItem.number = overallCount
                overallCount+=1
                if i == 0 && j == 0 {
                    inventoryItem.selectItem()
                }
                self.addChild(inventoryItem)
                
            }
        }


        updateSlotsWithEquippedItems()
    }
    
    func selectedNode()->InventoryItemNode? {
        for node in self.children as [AnyObject] {
            if node.isKind(of: InventoryItemNode.self)
            {
                if (node as! InventoryItemNode).selected {
                    slotSelected = true
                    return node as? InventoryItemNode
                }
            }
        }
        
        return nil
    }
    
    func InventoryNodeTouched(item: InventoryItem?) {
    }
    
    func resetAllNodesToDefault() {
        for node in self.children as [AnyObject] {
            if node.isKind(of: InventoryItemNode.self) {
                (node as! InventoryItemNode).deselect()
            }
        }
    }
    
    func updateSlot(item: InventoryItem?, childIndex:Int){
        (self.children[childIndex] as! InventoryItemNode).updateWithItem(item: item)
        if item != nil {
        GameState.sharedInstance.equippedItems[childIndex] = item!
        }
    }
    
    func listItemsInSlots()->[InventoryItemNode] {
        return self.children as! [InventoryItemNode]
    }
    
    func updateSlotsWithEquippedItems() {
        var i = 0
        for key in GameState.sharedInstance.equippedItems {
            (self.children[i] as! InventoryItemNode).updateWithItem(item: key)
            i += 1
        }
        
    }
    
    

}
