//
//  BNRConnection.swift
//  Nerdfeed
//
//  Created by chain on 14-7-23.
//  Copyright (c) 2014 chain. All rights reserved.
//

import UIKit


var sharedConnectionList: Array<BNRConnection> = []



class BNRConnection: NSObject,
                     NSURLConnectionDelegate, NSURLConnectionDataDelegate {
    
    
    // - Properties
    
    
    var internalConnection: NSURLConnection?
    var container: NSMutableData? = NSMutableData()
    
    var request: NSURLRequest?
    var xmlRootObject: RSSChannel? //NSXMLParserDelegate?
    
    var completionBlock: (RSSChannel!, NSError!) -> Void = { obj, err in }
    
    init(request req: NSURLRequest) {
        self.request = req
        
        super.init()
    }
    
    
    
    //var callbackHandler = func (obj: AnyObject!, err: NSError!) -> Void
    
    
    // - Method
    
    
    func start() {
        internalConnection = NSURLConnection(request: request, delegate: self, startImmediately: true)
        
        sharedConnectionList.append(self)
    }
    
    
    
    // - Handle NSURLConnection Respond
    

    func connectionDidFinishLoading(connection: NSURLConnection!) {
        
        if xmlRootObject != nil {
            let parser = NSXMLParser(data: container)
            parser.delegate = xmlRootObject
            parser.parse()
            
            if completionBlock != nil {  // ???
                self.completionBlock(xmlRootObject, nil)
            }
            
            sharedConnectionList.removeObject(self)
        }
    }
}

extension Array {
    
    mutating func removeObject<U: Equatable>(object: U) {
        var index: Int?
        for (idx, objectToCompare) in enumerate(self) {
            if let to = objectToCompare as? U {
                if object == to {
                    index = idx
                }
            }
        }
        
        if index {
            self.removeAtIndex(index!)
        }
    }
}