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
    
    var parentParserDelegate: RSSChannel?
    var title: String = String()
    var link: String = String()
    
    init()  {
        super.init()
    }
    
    
    var parseTag: String!
    
    let titleTag = "title"
    let linkTag = "link"
    let itemTag = "item"

    
    // Conform NSXMLParserDelegate
    func parser(parser: NSXMLParser!,
        didStartElement elementName: String!,
        namespaceURI: String!,
        qualifiedName qName: String!,
        attributes attributeDict: NSDictionary!) {
            
            println("\(self) found \(elementName)")
            
            
            if elementName == titleTag {
                parseTag = elementName
            } else if elementName == linkTag {
                parseTag = elementName
            }
            
    }
    
    func parser(parser: NSXMLParser!, foundCharacters string: String!) {
        
        println("foundCharacter: \(string)")
        
        if parseTag? == titleTag {
            self.title = string
        } else if parseTag? == linkTag {
            self.link = string
        }
        
    }
    
    
    func parser(parser: NSXMLParser!,
        didEndElement elementName: String!,
        namespaceURI: String!,
        qualifiedName qName: String!) {
            
            parseTag = nil
            
            if elementName == itemTag {
                parser.delegate = parentParserDelegate!
            }
    }
    
    
}
