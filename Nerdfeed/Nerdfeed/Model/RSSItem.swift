//
//  RSSItem.swift
//  Nerdfeed
//
//  Created by chain on 14-7-16.
//  Copyright (c) 2014 chain. All rights reserved.
//

import UIKit


class RSSItem: NSObject, NSCoding,
                NSXMLParserDelegate, JSONSerializable {
    
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
    let entryTag = "entry"
    
    
    // - Method
    
    
    override func isEqual(object: AnyObject!) -> Bool {
        
        if !object.isKindOfClass(RSSItem) {
            return false
        }
        
        return self.link == object.link
    }

    
    
    // - Conform JSONSerializable
    
    func readFromJSONDictionary(d: NSDictionary) {
        var title: NSDictionary = d.objectForKey("title") as NSDictionary
        self.title = title.objectForKey("label") as String
        
        
        var links: NSArray = d.objectForKey("link") as NSArray
        if links.count > 1 {
            var tmpDict: NSDictionary = links.objectAtIndex(1) as NSDictionary
            var sampleDict = tmpDict.objectForKey("attributes") as NSDictionary
            
            self.link = sampleDict.objectForKey("href") as String
        }
    }
    
    
    // Conform NSXMLParserDelegate
    func parser(parser: NSXMLParser!,
        didStartElement elementName: String!,
        namespaceURI: String!,
        qualifiedName qName: String!,
        attributes attributeDict: NSDictionary!) {
            
            //println("\(self) found \(elementName)")
            
            
            if elementName == titleTag {
                parseTag = elementName
            } else if elementName == linkTag {
                parseTag = elementName
            }
            
    }
    
    func parser(parser: NSXMLParser!, foundCharacters string: String!) {
        
        //println("foundCharacter: \(string)")
        
        if parseTag? == titleTag {
            self.title += string
        } else if parseTag? == linkTag {
            self.link += string
        }
        
    }
    
    
    func parser(parser: NSXMLParser!,
        didEndElement elementName: String!,
        namespaceURI: String!,
        qualifiedName qName: String!) {
            
            parseTag = nil
            
            if (elementName == itemTag) || (elementName == entryTag) {
                parser.delegate = parentParserDelegate!
            }
    }
    
    
    // - Archiving
    
    
    func encodeWithCoder(aCoder: NSCoder!) {
        aCoder.encodeObject(title, forKey: "title")
        aCoder.encodeObject(link, forKey: "link")
    }
    
    
    init(coder aDecoder: NSCoder!) {
        super.init()
        if self != nil {
            title = aDecoder.decodeObjectForKey("title") as String
            link = aDecoder.decodeObjectForKey("link") as String
        }
    }

    
    
}
