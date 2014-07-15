//
//  RSSChannel.swift
//  Nerdfeed
//
//  Created by chain on 14-7-15.
//  Copyright (c) 2014 chain. All rights reserved.
//

import UIKit

class RSSChannel: NSObject,
                    NSXMLParserDelegate {
    
    var parentParserDelegate: ListViewController?
    var title: String = ""
    var infoString: String = ""
    var items = []
    
    var currentString: String?
    
    init() {
        super.init()
    }
    
    
    // Conform NSXMLParserDelegate
    func parser(parser: NSXMLParser!,
        didStartElement elementName: String!,
        namespaceURI: String!,
        qualifiedName qName: String!,
        attributes attributeDict: NSDictionary!) {
            
            println("\(self) found \(elementName)")
            
            //currentString = String()
            
            if elementName == "title" {
                self.title = currentString!
            } else if elementName == "description" {
                self.infoString = currentString!
            }
            
    }
    
    func parser(parser: NSXMLParser!, foundCharacters string: String!) {
        
        println("foundCharacter: \(string)")
        
        if currentString {
            currentString = currentString! + string
        } else {
            currentString = string
        }
    }
    
    func parser(parser: NSXMLParser!,
        didEndElement elementName: String!,
        namespaceURI: String!,
        qualifiedName qName: String!) {
            
            currentString = nil
            
            if elementName == "channel" {
                parser.delegate = parentParserDelegate!
            }
    }
    
    


}
