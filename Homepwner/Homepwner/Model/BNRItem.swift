//
//  BNRItem.swift
//  Homepwner
//
//  Created by chain on 14-6-24.
//  Copyright (c) 2014 chain. All rights reserved.
//

import UIKit

class BNRItem: NSObject, NSCoding {
    
    var itemName: String = ""
    var valueInDollars: Int = 0
    var serialNumber: String = ""
    var dateCreated: NSDate = NSDate()
    var imageKey: String?
    var thumbnailData: NSData?
    var thumbnail: UIImage? {
        didSet {
            if !thumbnailData { self.thumbnail = nil }
            if !self.thumbnail { self.thumbnail = UIImage(data: thumbnailData) }
        }
    }
    
    init() { }
    
    init(itemName name: String, valueInDollars value: Int, serialNumber num: String) {
        self.itemName = name
        self.valueInDollars = value
        self.serialNumber = num
        self.dateCreated = NSDate()
        
        // init thumbnail. without using getter / setter
        // Wrong.
    }
        
    func description() -> String! {
        var description: String = "\(self.itemName) (\(self.serialNumber)): $\(self.valueInDollars)@\(self.dateCreated)"
        return description
    }
    
    class func randomItem() -> BNRItem {
        let randomAdjectiveList = ["Swift", "Rusty", "ObjC"]
        let randomNounList = ["iPad", "iPhone", "Mac"]
        let rA = ["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]
        let randomName = "\(randomAdjectiveList.randomItem()) \(randomNounList.randomItem())"
        let randomValue = Int(arc4random() % UInt32(100 + 1))
        let randomSerialNumber = "0\(rA.randomItem())A\(rA.randomItem())"
        
        return BNRItem(itemName: randomName, valueInDollars: randomValue, serialNumber: randomSerialNumber)
    }
    
    //Archiving
    func encodeWithCoder(aCoder: NSCoder!) {
        aCoder.encodeObject(itemName, forKey: "itemName")
        aCoder.encodeInteger(valueInDollars, forKey: "valueInDollars")
        aCoder.encodeObject(serialNumber, forKey: "serialNumber")
        aCoder.encodeObject(dateCreated, forKey: "dateCreated")
        aCoder.encodeObject(imageKey, forKey: "imageKey")
    }
    
    init(coder aDecoder: NSCoder!) {
        self.itemName = aDecoder.decodeObjectForKey("itemName") as String
        self.valueInDollars = aDecoder.decodeIntegerForKey("valueInDollars") as Int
        self.serialNumber = aDecoder.decodeObjectForKey("serialNumber") as String
        self.dateCreated = aDecoder.decodeObjectForKey("dateCreated") as NSDate
        self.imageKey = aDecoder.decodeObjectForKey("imageKey") as? String
    }
}

extension Array {
    func randomItem() -> T {
        let index = Int(arc4random() % UInt32(self.count))
        return self[index]
    }
    
    func indexOfObject(object: AnyObject) -> Int? {
        return (self as NSArray).indexOfObject(object)
    }
    
    func objectAtIndex(index: Int) -> AnyObject? {
        return (self as NSArray).objectAtIndex(index)
    }
}
