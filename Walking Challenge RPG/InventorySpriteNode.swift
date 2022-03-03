    //
    //  InventorySpriteNode.swift
    //  Inventory
    //
    //  Created by David Norman on 8/15/15.
    //  Copyright (c) 2015 David Norman. All rights reserved.
    //
    
    import Foundation
    import SpriteKit
    
    extension Dictionary {
        mutating func map(transform: (_ key:Key, _ value:Value) -> (Value)) {
            for key in self.keys {
                let newValue = transform(key, self[key]!)
                self.updateValue(newValue, forKey: key)
            }
        }
    }
    
    protocol InventoryProtocol {
        func updateSlot(item: InventoryItem?, childIndex:Int)
        func selectedNode()->InventoryItemNode?
        var slotSelected: Bool {get set}
    }
    
    class InventorySpriteNode: SKSpriteNode, InventoryItemNodeProtocol {
        
        var delegate: InventoryProtocol?
        
        
        //MARK: - Lifecycle 
        
        init(size: CGSize) {
            super.init(texture:nil, color: UIColor.clear, size: size)
        }
        
        
        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
        }
        
        
        
        func showInventory() {
            var tempInvArray = [InventoryItem]()
            for key in GameState.sharedInstance.inventoryStorage {
                
                tempInvArray.append(key)
            }
            
            let columns = InventoryConfig.numberOfColumns
            let rows = InventoryConfig.numberOfRows
            let squareWidth = CGFloat(50)
            self.size = CGSize(width: parent!.frame.size.width, height: CGFloat(rows) * squareWidth)
            self.anchorPoint = CGPoint(x: 0.5,y: 0.5)
            self.position = CGPoint(x: 0, y: 0)
            self.color = UIColor.black
            
            var overallCount = 0
            
            for i in 0 ..< columns {
                for j in 0 ..< rows {
                    let inventoryItemNode = InventoryItemNode(rectOf: CGSize(width: squareWidth, height: squareWidth))
                    inventoryItemNode.delegate = self
                    let updatedX = self.frame.origin.x + (CGFloat(inventoryItemNode.frame.size.width) / CGFloat(2)) + squareWidth * CGFloat(i)
                    let updatedY = CGFloat(self.frame.size.height - (CGFloat(inventoryItemNode.frame.size.height))) / CGFloat(2) - (squareWidth * CGFloat(j))
                    inventoryItemNode.position = CGPoint(x:updatedX, y:updatedY )
                    inventoryItemNode.fillColor = UIColor.black
                    inventoryItemNode.strokeColor = UIColor.white
                    inventoryItemNode.lineWidth = 2.0
                    inventoryItemNode.number = overallCount
                    overallCount+=1
                    
                    self.addChild(inventoryItemNode)
                    
                    if tempInvArray.count > 0 {
                        let item = tempInvArray.removeFirst()
                        inventoryItemNode.itemName = InventoryItemName(rawValue:item.imageName!)
                        inventoryItemNode.updateWithItem(item: item)
                        
                    }
                }
            }
        }
        
        func InventoryNodeTouched(item: InventoryItem?) {
            for node in self.children as! [InventoryItemNode] {
                //slot and inv node selected
                if node.selected && self.delegate?.selectedNode() != nil {
                    self.swapInvAndSlot(selectedInvNode: node)
                }
            }
            NotificationCenter.default.post(name:Notification.Name("com.davidwnorman.updateEquippedSlots"), object: nil)
        }
        
        func swapInvAndSlot(selectedInvNode: InventoryItemNode) {
            let slot = self.delegate?.selectedNode()
            let tempSlotNode = slot!.copy() as! InventoryItemNode
            let tempInvNode = selectedInvNode.copy() as! InventoryItemNode
            self.updateInvetoryNode(item: tempSlotNode.item, childIndex: tempInvNode.number)
            self.delegate?.updateSlot(item: tempInvNode.item, childIndex: tempSlotNode.number)
            GameState.sharedInstance.inventoryStorage[tempInvNode.number] = tempSlotNode.item!
        }
        
        func updateInvetoryNode(item: InventoryItem?, childIndex:Int){
            (self.children[childIndex] as! InventoryItemNode).updateWithItem(item: item)
        }
        
        func resetAllNodesToDefault() {
            for node in self.children as [AnyObject] {
                if node.isKind(of: InventoryItemNode.self)
                {
                    (node as! InventoryItemNode).deselect()
                }
            }
        }
    
    }
