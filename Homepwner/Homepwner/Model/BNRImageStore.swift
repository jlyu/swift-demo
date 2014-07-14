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
    
    init() {
        super.init()
        var nc: NSNotificationCenter = NSNotificationCenter.defaultCenter()
        nc.addObserver(self, selector: "clearCache:", name: UIApplicationDidReceiveMemoryWarningNotification, object: nil)
    }

    var imageDict: Dictionary<String, UIImage> = Dictionary()
    
    func setImage(img: UIImage, forKey key: String) {
        self.imageDict[key] = img
        
        var imagePath = imagePathForKey(key)
        var imageData: NSData = UIImageJPEGRepresentation(img, 1.0)
        if imageData.writeToFile(imagePath, atomically: true) {
            println("Saved BNRItem ->image")
        }
    }
    
    func imageForKey(key: String) -> UIImage? {
        
        var result = self.imageDict[key]
        if result == nil {
            result = UIImage(contentsOfFile: imagePathForKey(key))
            
            if result != nil {
                setImage(result!, forKey: key)
            } else {
                println("Error: unable to find \(imagePathForKey(key))")
            }
        }
        return result
    }
    
    func deleteImageForKey(key: String) {
        self.imageDict.removeValueForKey(key)
        
        var imagePath = imagePathForKey(key)
        NSFileManager.defaultManager().removeItemAtPath(imagePath, error: nil)
    }
    
    func imagePathForKey(key: String) -> String {
        var documentDictories = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
        return documentDictories.stringByAppendingPathComponent(key)
    }
    
    func clearCache(note: NSNotification) {
        println("\(imageDict.count) out of the cache")
        imageDict.removeAll(keepCapacity: true)
    }
}
