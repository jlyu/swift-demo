//
//  BNRConnection.swift
//  Nerdfeed
//
//  Created by chain on 14-7-23.
//  Copyright (c) 2014 chain. All rights reserved.
//

import UIKit


// Global variable

var sharedConnectionListInstance: Array<BNRConnection> = []

class BNRConnection: NSObject,
                     NSURLConnectionDelegate, NSURLConnectionDataDelegate {
    
    
    // - Properties
    
    
    var internalConnection: NSURLConnection?
    var container: NSMutableData? = NSMutableData()
    
    var request: NSURLRequest?
    var xmlRootObject: NSXMLParserDelegate?
    
    class func sharedConnectionList()-> Array<BNRConnection> {
        return sharedConnectionListInstance
    }
    
    var completionBlock: (RSSChannel, NSError) -> Void = { obj, err in }
    
    init(request req: NSURLRequest) {
        self.request = req
        
        super.init()
    }
    
    
    
    //var callbackHandler = func (obj: AnyObject!, err: NSError!) -> Void
    
    
    // - Method
    
    func start() {
        internalConnection = NSURLConnection(request: request, delegate: self, startImmediately: true)
        
        BNRConnection.sharedConnectionList().append(self)
        
        
    }
}