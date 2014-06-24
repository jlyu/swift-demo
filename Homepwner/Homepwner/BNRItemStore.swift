//
//  BNRItemStore.swift
//  Homepwner
//
//  Created by chain on 14-6-24.
//  Copyright (c) 2014 chain. All rights reserved.
//

import UIKit

@objc class BNRItemStore {
    
   // class shareStore: BNRItemStore?  {
   //     if !shareStore {
   //         shareStore = ???
   //     }
   // }
    
    class func shareStore() -> BNRItemStore {
        return BNRItemStore()
    }
}