//
//  BNRImageStore.swift
//  Homepwner
//
//  Created by chain on 14-7-2.
//  Copyright (c) 2014 chain. All rights reserved.
//

import Foundation
import UIKit

class BNRImageStore: NSObject {
    struct Static {
        static var token: dispatch_once_t = 0
        static var instance: BNRImageStore?
    }
    
    class var instance: BNRImageStore {
        dispatch_once(&Static.token) { Static.instance = BNRImageStore() }
        return Static.instance!
    }
    
    init() { }

    var imageDict: Dictionary<NSString, UIImage> = Dictionary()
    
    func setImage(img: UIImage, forKey key: NSString) {
        self.imageDict[key] = img
    }
    
    func imageForKey(key: NSString) -> UIImage? {
        return self.imageDict[key]
    }
    
    func deleteImageForKey(key: NSString) {
        self.imageDict.removeValueForKey(key)
    }
    
}
