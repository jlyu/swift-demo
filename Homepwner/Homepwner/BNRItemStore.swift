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
    }
    
    
    var allItems: BNRItem[] = []
    
    func allOfItems() -> Array<BNRItem> {
        return allItems
    }
    
    func createItem() -> BNRItem {
        var item: BNRItem = BNRItem.randomItem()
        //println(item.description())
        allItems.append(item)
        return item
    }
    
    
   /* Singleton
    class var staticShareStore: BNRItemStore  {
       if self == nil {
            return super.allocWithZone(nil) as BNRItemStore
       }
       return self
    }
    
    class func shareStore() -> BNRItemStore {
        return staticShareStore
    }
    */
}