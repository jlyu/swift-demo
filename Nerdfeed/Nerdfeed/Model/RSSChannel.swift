//
//  RSSChannel.swift
//  Nerdfeed
//
//  Created by chain on 14-7-15.
//  Copyright (c) 2014 chain. All rights reserved.
//

import UIKit
import Foundation

class RSSChannel: NSObject, NSCoding, NSCopying,
                  NSXMLParserDelegate, JSONSerializable {
    
    // - Proporties
    
    
    var parentParserDelegate: BNRConnection? //ListViewController?
    var title: String = String()
    var infoString: String = String()
    var items: Array<RSSItem> = Array()

    
    //var currentString: String = String()
    
    init() {
        //items = []
        super.init()
    }
    
    var parseTag: String!
    
    let titleTag = "title"
    let descriptionTag = "description"
    let itemTag = "item"
    let channelTag = "channel"
    let entryTag = "entry"
    //let feedTag:String = "feed"

    
    
    // - Method
    
    
    func trimItemTitles() {
        var regx: NSRegularExpression = NSRegularExpression.regularExpressionWithPattern(".* :: [Re: ]*(.*) :: .*",
                                                                    options: nil, error: nil)
        for item in items {
            var matches = regx.matchesInString(item.title, options: nil, range: NSMakeRange(0, countElements(item.title)))
            if matches.count > 0 {
                var result: NSTextCheckingResult = matches[0] as NSTextCheckingResult
                var range: NSRange = result.range
                
                //println("Match at {\(range.location),\(range.length)} for \(item.title)")
                
                if result.numberOfRanges == 2 {
                    let r: NSRange = result.rangeAtIndex(1)
                    
                    var itemTitle = item.title as NSString
                    itemTitle = itemTitle.substringWithRange(NSRange(location: r.location, length: r.length))
                    
                    item.title = itemTitle
                }
            }
        }
    }
    
    
    func addItemsFromChannel(otherChannel: RSSChannel) {
        for item in otherChannel.items {
            if !items.containsObject(item) {
                items.append(item)
            }
        }
        // sort item by date
        items.sort({ (d1: RSSItem, d2: RSSItem) -> Bool in
            let date1 = d1.publicationDate as NSDate
            let date2 = d2.publicationDate as NSDate
            return date1.compare(date2) == NSComparisonResult.OrderedDescending
        })
        
    }
    
    
    // - Conform JSONSerializable
    
    func readFromJSONDictionary(d: NSDictionary) {
        
        var feed: NSDictionary = d.objectForKey("feed") as NSDictionary
        self.title = "itunes song" //feed.objectForKey("title") as String // FIX
        
        var entries: NSArray = feed.objectForKey("entry") as NSArray
        for entry: AnyObject in entries {
            var item = RSSItem()
            item.readFromJSONDictionary(entry as NSDictionary)
            items.append(item)
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
            } else if (elementName == itemTag) || (elementName == entryTag) {
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
    
    
    
    // - Archiving
    
    
    func encodeWithCoder(aCoder: NSCoder!) {
        
        aCoder.encodeObject(items.bridgeToObjectiveC(), forKey: "items")
        aCoder.encodeObject(title, forKey: "title")
        aCoder.encodeObject(infoString, forKey: "infoString")
        
    }
    
    
    init(coder aDecoder: NSCoder!) {
        super.init()
        if self != nil {
            items = aDecoder.decodeObjectForKey("items") as Array<RSSItem>
            title = aDecoder.decodeObjectForKey("title") as String
            infoString = aDecoder.decodeObjectForKey("infoString") as String
        }
    }
    
    
    func copyWithZone(zone: NSZone) -> AnyObject! {
        var copy = RSSChannel()
        copy.title = self.title
        copy.infoString = self.infoString
        copy.items = self.items //.copy() //TODO
        return copy
    }

    
    
}
