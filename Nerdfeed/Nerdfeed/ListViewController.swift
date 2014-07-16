//
//  ListViewController.swift
//  Nerdfeed
//
//  Created by chain on 14-7-14.
//  Copyright (c) 2014 chain. All rights reserved.
//

import UIKit

class ListViewController: UITableViewController,
                            NSXMLParserDelegate{
    
    var connection: NSURLConnection?
    var xmlData: NSMutableData? = NSMutableData()
    var channel: RSSChannel?
    
    init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
        super.init(nibName: nil, bundle: nil)
        if self != nil {
            self.fetchEntries()
        }
    }
    
    override func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        if channel {
            return channel!.items.count
        }
        return 0
    }
    
    
    override func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
       
        // TODO: why?
        //var cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("UITableViewCell") as UITableViewCell
       
        //if cell != nil {
          var  cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "UITableViewCell")
        //}

        
        if channel {
            
            var item: RSSItem = channel!.items[indexPath.row]
            cell.textLabel.text = item.title
        }
        
        return cell
    }
    
    func fetchEntries() {
        let requestURL = NSURL(string: "http://forums.bignerdranch.com/smartfeed.php?limit=1_DAY&sort_by=standard&feed_type=RSS2.0&feed_style=COMPACT")
        let reqest = NSURLRequest(URL: requestURL)
        self.connection = NSURLConnection(request: reqest, delegate: self, startImmediately: true)
    }
    
    // Get XML Data
    func connection(connection: NSURLConnection!, didReceiveData data: NSData!) {
        xmlData!.appendData(data)
    }
    
    func connectionDidFinishLoading(connection: NSURLConnection!) {
        //var xmlCheck = NSString(data: xmlData, encoding: NSUTF8StringEncoding)
        //println("xmlCheck = \(xmlCheck)")
        
        let parser = NSXMLParser(data: xmlData)
        parser.delegate = self
        parser.parse() // blocking..
        self.xmlData = nil
        self.connection = nil
        self.tableView.reloadData()
        
        println("\(channel) --------------------\n \(channel?.title) ========================\n \(channel?.infoString)")
    }
    
    func connection(connection: NSURLConnection!, didFailWithError error: NSError!) {
        self.connection = nil
        self.xmlData = nil
        var errorString = "Fetch failed: \(error.localizedDescription)"
        var alertController = UIAlertController(title: "Error", message: errorString, preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    // Conform NSXMLParserDelegate
    func parser(parser: NSXMLParser!,
        didStartElement elementName: String!,
        namespaceURI: String!,
        qualifiedName qName: String!,
        attributes attributeDict: NSDictionary!) {
            
            println("\(self) found \(elementName)")
            
            if elementName == "channel" {
                channel = RSSChannel()
                self.channel!.parentParserDelegate = self
                parser.delegate = channel!
            }
        
    }

}
