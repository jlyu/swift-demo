//
//  RSSChannel.swift
//  Nerdfeed
//
//  Created by chain on 14-7-15.
//  Copyright (c) 2014 chain. All rights reserved.
//

import UIKit
import Foundation

class RSSChannel: NSObject,
                  NSXMLParserDelegate {
    
    // - Proporties
    
    
    var parentParserDelegate: ListViewController?
    var title: String = String()
    var infoString: String = String()
    var items: Array<RSSItem> = Array()
    
    var currentString: String = String()
    
    init() {
        super.init()
    }
    
    var parseTag: String!
    
    let titleTag = "title"
    let descriptionTag = "description"
    let itemTag = "item"
    let channelTag = "channel"
    
    
    // - Method
    
    
    func trimItemTitles() {
        var regx: NSRegularExpression = NSRegularExpression.regularExpressionWithPattern(".* :: (.*) :: .*",
                                                                    options: nil, error: nil)
        for item in items {
            var matches = regx.matchesInString(item.title, options: nil, range: NSMakeRange(0, countElements(item.title)))
            if matches.count > 0 {
                var result: NSTextCheckingResult = matches[0] as NSTextCheckingResult
                var range: NSRange = result.range
                
                println("Match at {\(range.location),\(range.length)} for \(item.title)")
                
                if result.numberOfRanges == 2 {
                    let r: NSRange = result.rangeAtIndex(1)
                    
                    var itemTitle = item.title as NSString
                    itemTitle = itemTitle.substringWithRange(NSRange(location: r.location, length: r.length))
                    
                    item.title = itemTitle
                }
                
            }
            
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
            } else if elementName == descriptionTag {
                parseTag = elementName
            } else if elementName == itemTag {
                var entry = RSSItem()
                entry.parentParserDelegate = self
                parser.delegate = entry
                items.append(entry)
            }
            
    }
    
    func parser(parser: NSXMLParser!, foundCharacters string: String!) {
        
        //println("foundCharacter: \(string)")
        
        if parseTag? == titleTag {
            self.title = string
        } else if parseTag? == descriptionTag {
            self.infoString = string
        }
        
    }
    
    func parser(parser: NSXMLParser!,
        didEndElement elementName: String!,
        namespaceURI: String!,
        qualifiedName qName: String!) {
            
            parseTag = nil
            
            if elementName == channelTag {
                parser.delegate = parentParserDelegate!
                self.trimItemTitles()
            }
    }
    
    


}
