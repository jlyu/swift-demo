//
//  BNRFeedStore.swift
//  Nerdfeed
//
//  Created by chain on 14-7-22.
//  Copyright (c) 2014 chain. All rights reserved.
//

import UIKit
import Foundation

class BNRFeedStore: NSObject {
    
    // - Singleton
    
    struct Static {
        static var token: dispatch_once_t = 0
        static var sharedStore: BNRFeedStore?
    }
    
    class var sharedStore: BNRFeedStore {
        dispatch_once(&Static.token) { Static.sharedStore = BNRFeedStore() }
        return Static.sharedStore!
    }
    
    init() {
        
    }
    
    
    // - Method
    
    typealias fetchRSSFeedWithCompletionHandler = (obj: RSSChannel!, err: NSError!) -> Void
    func fetchRSSFeedWithCompletion(callback completionHandler: fetchRSSFeedWithCompletionHandler) {
        
    }
    
    
    
}
