//
//  GameState.swift
//  PestControl
//
//  Created by David Norman on 8/5/15.
//  Copyright (c) 2015 Razeware LLC. All rights reserved.
//

import Foundation

class InventoryConfig {
   static let numberOfRows = 5 // modify as desired
   static let numberOfColumns = 5  // modify as desired
    static var totalInventoryNodes : Int {
        get {
        return numberOfColumns * numberOfRows
        }
    }
}

class EquippedSlotsConfig {
    static let numberOfRows = 3  // modify as desired
    static let numberOfColumns = 1  // modify as desired
    static var totalInventoryNodes : Int {
        get {
            return numberOfColumns * numberOfRows
        }
    }
}

class GameState {
    
    static let sharedInstance = GameState()
    var inventoryStorage = [InventoryItem]()
    var equippedItems = [InventoryItem]()
    var gameTimer : Timer?
    var inventoryStorageTempClone = [InventoryItemName : InventoryItem]()
    var equippedItemsTempClone = [InventoryItemName : InventoryItem]()
    var equippedArmor = [String : InventoryItem]()
    var selectedWeapon: InventoryItem?
    
    let totalLevels = 5
    
    
    
    class func findInventoryItemInEitherStorage(inventoryItemName: InventoryItemName)->InventoryItem? {
        
        if let indexOfItem = GameState.sharedInstance.inventoryStorage.map({ $0.name!.rawValue }).firstIndex(of: inventoryItemName.rawValue) {
            return GameState.sharedInstance.inventoryStorage[indexOfItem]
        }
        else {
            if let indexOfItem = GameState.sharedInstance.equippedItems.map({ $0.name!.rawValue }).firstIndex(of: inventoryItemName.rawValue) {
                return GameState.sharedInstance.equippedItems[indexOfItem]
            }
        }
        return nil
    }
    
    class func inititialSetup() {
        //add new inventory items
        let empty = InventoryItem(name: InventoryItemName.empty, numberInStack: 0, isOwned: true)
        
        
        
        for _ in 0 ..< EquippedSlotsConfig.totalInventoryNodes {
            GameState.sharedInstance.equippedItems.append(empty)
        }
        
        let flail_bronze = InventoryItem(name:InventoryItemName.flail_bronze,numberInStack: 1, isOwned: false)
        let hammer_gold = InventoryItem(name:InventoryItemName.hammer_gold,numberInStack: 1, isOwned: false)
        let pick_silver = InventoryItem(name:InventoryItemName.pick_silver, numberInStack: 1, isOwned: false)
        let stew = InventoryItem(name:InventoryItemName.stew, numberInStack: numStack.integer(forKey: "num"), isOwned: true)
        let sword_silver = InventoryItem(name:InventoryItemName.sword_silver,numberInStack: 1, isOwned: false)
        let rubies = InventoryItem(name:InventoryItemName.ore_ruby, numberInStack: 1, isOwned: rubyOwned.bool(forKey: "rubyCheck"))
        let staff = InventoryItem(name:InventoryItemName.staff,numberInStack: 1, isOwned: staffOwned.bool(forKey: "staffCheck"))
        GameState.sharedInstance.inventoryStorage.append(staff)
 
  
        
        GameState.sharedInstance.inventoryStorage.append(flail_bronze)
        GameState.sharedInstance.inventoryStorage.append(hammer_gold)
        GameState.sharedInstance.inventoryStorage.append(pick_silver)
        GameState.sharedInstance.inventoryStorage.append(stew)
        GameState.sharedInstance.inventoryStorage.append(sword_silver)
        GameState.sharedInstance.inventoryStorage.append(rubies)
        
        for _ in 0 ..< 40 {
            GameState.sharedInstance.inventoryStorage.append(empty)
        }

    }
    
}
