//
//  BNRItemStore.swift
//  Homepwner
//
//  Created by chain on 14-6-24.
//  Copyright (c) 2014 chain. All rights reserved.
//

import UIKit

class BNRItemStore: NSObject {
    
    var allItems: BNRItem[] = []
    
    func allOfItems() -> Array<BNRItem> {
        return allItems
    }
    
    func createItem() -> BNRItem {
        var item: BNRItem = BNRItem.randomItem()
        allItems.append(item)
        return item
    }
    
    
   // Singleton
    class var staticShareStore: BNRItemStore  {
       if self == nil {
            return super.allocWithZone(nil) as BNRItemStore
       }
       return self.staticShareStore
    }
    
    class func shareStore() -> BNRItemStore {
        return staticShareStore
    }
}