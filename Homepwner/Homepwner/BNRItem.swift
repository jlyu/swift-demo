//
//  BNRItem.swift
//  Homepwner
//
//  Created by chain on 14-6-24.
//  Copyright (c) 2014 chain. All rights reserved.
//

import UIKit

class BNRItem {
    var itemName: String = ""
    var valueInDollars: Int = 0
    var serialNumber: String = "0000"
    var dateCreated: NSDate = NSDate()
    
    init(itemName name: String, valueInDollars value: Int, serialNumber num: String) {
        self.itemName = name
        self.valueInDollars = value
        self.serialNumber = num
        self.dateCreated = NSDate()
    }
    
    func description() -> String! {
        var description: String = "\(self.itemName) (\(self.serialNumber)): Worth $\(self.valueInDollars), recorded on \(self.dateCreated)"
        return description
    }
    
    class func randomItem() -> BNRItem {
        let randomAdjectiveList = ["Fluffy", "Rusty", "ObjC"]
        let randomNounList = ["Bear", "Spork", "Mac"]
        let rA = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]
        let randomName = "\(randomAdjectiveList.randomItem()) \(randomNounList.randomItem())"
        let randomValue = Int(arc4random() % UInt32(100 + 1))
        let randomSerialNumber = "0\(rA.randomItem())A\(rA.randomItem())0\(rA.randomItem())A\(rA.randomItem())O\(rA.randomItem())"
        
        return BNRItem(itemName: randomName, valueInDollars: randomValue, serialNumber: randomSerialNumber)
    }
}

extension Array {
    func randomItem() -> T {
        let index = Int(arc4random() % UInt32(self.count))
        return self[index]
    }
}
