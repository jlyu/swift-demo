//
//  RSSItem.swift
//  Nerdfeed
//
//  Created by chain on 14-7-16.
//  Copyright (c) 2014 chain. All rights reserved.
//

import UIKit


class RSSItem: NSObject,
                NSXMLParserDelegate {
    
    var currentString: NSString?
    var parentParserDelegate: RSSChannel?
    var title: String = ""
    var link: String = ""
    
    // Conform NSXMLParserDelegate
    func parser(parser: NSXMLParser!,
        didStartElement elementName: String!,
        namespaceURI: String!,
        qualifiedName qName: String!,
        attributes attributeDict: NSDictionary!) {
            
            println("\(self) found \(elementName)")
            
            currentString = NSMutableString()
            
            if elementName == "title" {
                self.title = currentString!
            } else if elementName == "description" {
                self.link = currentString!
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
            
            if elementName == "item" {
                parser.delegate = parentParserDelegate!
            }
    }
    
    
}
