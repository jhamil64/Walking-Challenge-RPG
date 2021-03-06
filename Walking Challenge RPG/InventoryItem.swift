//
//  InventoryItem.swift
//  Inventory
//
//  Created by David Norman on 8/15/15.
//  Copyright (c) 2015 David Norman. All rights reserved.
//

import Foundation


enum InventoryItemName: String {
    case flail_bronze = "flail_bronze"
    case hammer_gold = "hammer_gold"
    case ore_ruby = "ore_ruby"
    case pick_silver = "pick_silver"
    case stew = "stew"
    case sword_silver = "sword_silver"
    case staff = "staff"
    case empty = "empty"
    
}

class InventoryItem: NSObject, NSCopying, NSCoding {
    func copy(with zone: NSZone? = nil) -> Any {
        return InventoryItem(name: self.name!, numberInStack:self.numberInStack, isOwned: self.isOwned)
    }
    
    
    
    var name: InventoryItemName?
    var imageName: String?
    var numberInStack = 0
    var isOwned = false
    
    func encode(with coder: NSCoder) {
        coder.encode(name?.rawValue, forKey: "Item-name")
        coder.encode(imageName, forKey: "Item-imageName")
        coder.encode(numberInStack, forKey: "Item-numberInStack")
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.name = InventoryItemName(rawValue: aDecoder.decodeObject(forKey: "Item-name") as! String)
        self.imageName = aDecoder.decodeObject(forKey: "Item-imageName") as? String
        self.numberInStack = aDecoder.decodeInteger(forKey: "Item-numberInStack")
        
    }
    
    init(name: InventoryItemName) {
        self.name = name
        self.imageName = name.rawValue
    }
    
    init(name: InventoryItemName, numberInStack:Int, isOwned:Bool) {
        self.name = name
        self.imageName = name.rawValue
        self.numberInStack = numberInStack
        self.isOwned = isOwned
    }

}
