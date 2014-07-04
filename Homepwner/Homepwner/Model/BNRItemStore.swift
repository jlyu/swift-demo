//
//  BNRItemStore.swift
//  Homepwner
//
//  Created by chain on 14-6-24.
//  Copyright (c) 2014 chain. All rights reserved.
//

import Foundation
import UIKit

class BNRItemStore: NSObject {
    // singleton
    struct Static {
        static var token: dispatch_once_t = 0
        static var instance: BNRItemStore?
    }
    
    class var instance: BNRItemStore {
        dispatch_once(&Static.token) { Static.instance = BNRItemStore() }
        return Static.instance!
    }
    
    init() {
        //assert(Static.instance == nil, "Singleton already initialized!")
        super.init()
        if loadChanges() {
            println("All BNRItems loaded")
        }
    }
    
    
    var allItems: Array<BNRItem> = []
        
    func createItem() -> BNRItem {
        var item: BNRItem = BNRItem() //.randomItem()
        allItems.append(item)
        return item
    }
    
    func removeItem(item: BNRItem) {
        for i in 0..allItems.count {
            if item === allItems[i] {
                allItems.removeAtIndex(i)
                return
            }
        }
    }
    
    func moveItemAtIndex(from: Int, toIndex to: Int) {
        if from == to { return }
        var fromItem: BNRItem = BNRItemStore.instance.allItems.objectAtIndex(from) as BNRItem
        allItems.removeAtIndex(from)
        allItems.insert(fromItem, atIndex: to)
    }
    
    func itemArchivePath() -> String {
        var documentDirectories = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
        return documentDirectories.stringByAppendingPathComponent("items.archive")
    }
    
    func saveChanges() -> Bool {
        var path = self.itemArchivePath()
        return NSKeyedArchiver.archiveRootObject(allItems as Array<BNRItem>, toFile: path) //note: must do explicit convert here
    }
    
    func loadChanges() -> Bool {
        var path = self.itemArchivePath()
        if let loadAllItems = NSKeyedUnarchiver.unarchiveObjectWithFile(path) as? Array<BNRItem> {
            if loadAllItems.count == 0 {
                return false
            }
            
            allItems = loadAllItems
            return true
        }
        return false
    }
    
    
}