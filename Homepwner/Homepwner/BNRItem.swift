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
        var description: String = "\(self.itemName) (\(self.serialNumber)): Worth \(self.valueInDollars), recorded on \(self.dateCreated)"
        return description
    }
}
