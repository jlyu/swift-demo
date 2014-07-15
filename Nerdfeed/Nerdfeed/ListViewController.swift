//
//  ListViewController.swift
//  Nerdfeed
//
//  Created by chain on 14-7-14.
//  Copyright (c) 2014 chain. All rights reserved.
//

import UIKit

class ListViewController: UITableViewController,
                            UIAlertViewDelegate{
    
    var connection: NSURLConnection?
    var xmlData: NSMutableData = NSMutableData()
    
    init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
        super.init(nibName: nil, bundle: nil)
        if self != nil {
            self.fetchEntries()
        }
    }
    
    
    override func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    
    override func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        return nil
    }
    
    func fetchEntries() {
        //xmlData = NSMutableData()
        
        let requestURL = NSURL(string: "http://forums.bignerdranch.com/smartfeed.php?limit=1_DAY&sort_by=standard&feed_type=RSS2.0&feed_style=COMPACT")
        
        let reqest = NSURLRequest(URL: requestURL)
        self.connection = NSURLConnection(request: reqest, delegate: self, startImmediately: true)
    }
    
    // Get XML Data
    func connection(connection: NSURLConnection!, didReceiveData data: NSData!) {
        xmlData.appendData(data)
    }
    
    func connectionDidFinishLoading(connection: NSURLConnection!) {
        var xmlCheck = NSString(data: xmlData, encoding: NSUTF8StringEncoding)
        println("xmlCheck = \(xmlCheck)")
    }
    
    func connection(connection: NSURLConnection!, didFailWithError error: NSError!) {
        self.connection = nil
        //self.xmlData
        var errorString = "Fetch failed: \(error.localizedDescription)"
        var alertController = UIAlertController(title: "Error", message: errorString, preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alertController, animated: true, completion: nil)
    }

}
