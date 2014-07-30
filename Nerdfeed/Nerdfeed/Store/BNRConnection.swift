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
                     NSURLConnectionDelegate, NSURLConnectionDataDelegate,
                     NSXMLParserDelegate {
    
    
    // - Properties
    
    
    var internalConnection: NSURLConnection?
    var container: NSMutableData? = NSMutableData()
    
    var request: NSURLRequest?
    var xmlRootObject: RSSChannel? //NSXMLParserDelegate?
    var jsonRootObject: RSSChannel? //JSONSerializable
    
    var completionBlock: (RSSChannel!, NSError!) -> Void = { obj, err in }
    
    init(request req: NSURLRequest) {
        self.request = req
        
        super.init()
    }
    
    
    
    //var callbackHandler = func (obj: AnyObject!, err: NSError!) -> Void
    
    
    // - Method
    
    
    func start() {
        
        container = NSMutableData()
        internalConnection = NSURLConnection(request: request, delegate: self, startImmediately: true)
        
        sharedConnectionList.append(self)
    }
    
    
    
    // - Handle NSURLConnection Respond
    
    
    func connection(connection: NSURLConnection!, didReceiveData data: NSData!) {
        container!.appendData(data)
    }
    

    func connectionDidFinishLoading(connection: NSURLConnection!) {
        
        var rootObject: RSSChannel? = nil
        
        if xmlRootObject != nil {
            let parser = NSXMLParser(data: container)
            parser.delegate = xmlRootObject
            xmlRootObject!.parentParserDelegate = self
            
            parser.parse()
            rootObject = xmlRootObject
            
        } else if jsonRootObject != nil {
            var err: AutoreleasingUnsafePointer<NSError?> = nil
            let d: NSDictionary = NSJSONSerialization.JSONObjectWithData(container,
                                                                            options: NSJSONReadingOptions.MutableContainers,
                                                                            error: err) as NSDictionary
            jsonRootObject!.readFromJSONDictionary(d)
            rootObject = jsonRootObject
        }
        
        if completionBlock != nil {  // ???
            self.completionBlock(rootObject, nil)
        }
            
        sharedConnectionList.removeObject(self)
        
    }
    
    
    func connection(connection: NSURLConnection!, didFailWithError error: NSError!) {
        if completionBlock != nil {
            self.completionBlock(nil, error)
        }
        
        sharedConnectionList.removeObject(self)
    }
}




// - Extension

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
    
    
    func containsObject(object: AnyObject!) -> Bool {
        if self.isEmpty {
            return false
        }
        
        let array: NSArray = self.bridgeToObjectiveC()
        return array.containsObject(object)
    }
}