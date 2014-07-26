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
    func fetchRSSFeedWithCompletion(callback block: fetchRSSFeedWithCompletionHandler) {
        
        let requestURL = NSURL(string: "http://forums.bignerdranch.com/smartfeed.php?limit=1_DAY&sort_by=standard&feed_type=RSS2.0&feed_style=COMPACT")
        let request = NSURLRequest(URL: requestURL)
        
        var channel: RSSChannel = RSSChannel()
        var connection: BNRConnection = BNRConnection(request: request)
        connection.completionBlock = block
        connection.xmlRootObject = channel
        
        connection.start()
    }
    
    
    
}
