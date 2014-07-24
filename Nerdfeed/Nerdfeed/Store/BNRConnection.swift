//
//  BNRConnection.swift
//  Nerdfeed
//
//  Created by chain on 14-7-23.
//  Copyright (c) 2014 chain. All rights reserved.
//

import UIKit


class BNRConnection: NSObject,
                     NSURLConnectionDelegate, NSURLConnectionDataDelegate {
    
    
    // - Properties
    
    
    var internalConnection: NSURLConnection?
    var container: NSMutableData? = NSMutableData()
    
    var request: NSURLRequest?
    var xmlParseResult: NSXMLParserDelegate?
    
    
    
    //var callbackHandler = func (obj: AnyObject!, err: NSError!) -> Void
    
    
    // - Method
    
    func start() {
        
    }
}