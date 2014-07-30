//
//  ListViewController.swift
//  Nerdfeed
//
//  Created by chain on 14-7-14.
//  Copyright (c) 2014 chain. All rights reserved.
//

import UIKit

class ListViewController: UITableViewController,
                            NSXMLParserDelegate {
    
    enum ListViewControllerRSSType: Int {
        case ListViewControllerRSSTypeBNR = 0
        case ListViewControllerRSSTypeApple = 1
    }
    
    // - Properties
    
    
    var channel: RSSChannel?
    var rssType: ListViewControllerRSSType = .ListViewControllerRSSTypeBNR
    var webViewController: WebViewController!
    
    init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
        super.init(nibName: nil, bundle: nil)
        
        if self != nil {
            var barButtonItem = UIBarButtonItem(title: "Info",
                                                style: UIBarButtonItemStyle.Bordered,
                                                target: self,
                                                action: Selector("showInfo:"))
            self.navigationItem.rightBarButtonItem = barButtonItem
            
            // add UISegmentedControl
            var rssTypeControl = UISegmentedControl(items: ["BNR", "Apple"])
            rssTypeControl.selectedSegmentIndex = 0
            rssTypeControl.segmentedControlStyle = .Bar
            rssTypeControl.addTarget(self, action: Selector("changeType:"), forControlEvents: UIControlEvents.ValueChanged)
            self.navigationItem.titleView = rssTypeControl
            
            self.fetchEntries()
        }
    }
    
    
    // - Method
    
    
    func fetchEntries() {
        
        var currentTitleView = navigationItem.titleView
        var activityView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.Gray)
        navigationItem.titleView = activityView
        activityView.startAnimating()
        
        
        var completionBlock: (obj: RSSChannel!, err: NSError!)-> Void = { obj, err in
            
            println("2. CompletionBlock called")
            
            self.navigationItem.titleView = currentTitleView
            
            if err == nil {
                self.channel = obj
                self.tableView.reloadData()
            } else {
                let errorString = "Fetch failed: \(err.localizedDescription)"
                let alertView = UIAlertView()
                alertView.title = "Warning"
                alertView.message = errorString
                alertView.addButtonWithTitle("Dismiss")
                alertView.show()
            }
        }
        
        if rssType == .ListViewControllerRSSTypeBNR {
            BNRFeedStore.sharedStore.fetchRSSFeedWithCompletion(completionBlock: completionBlock)
        } else if rssType == .ListViewControllerRSSTypeApple {
            BNRFeedStore.sharedStore.fetchTopSongs(count: 10, withCompletion: completionBlock)
        }
        
        println("1. End of fetchEntries()")
    }

    
    
    func showInfo(sender: AnyObject?) {
        
        var channelViewController = ChannelViewController(nibName: nil, bundle: nil)
        
        if self.splitViewController {
            var naviViewController = UINavigationController(rootViewController: channelViewController)
            
            var barButtonItem = UIBarButtonItem()
            barButtonItem.title = "List" // TODO: add target-action event
            channelViewController.navigationItem.leftBarButtonItem = barButtonItem
            
            self.splitViewController.viewControllers = [self.navigationController, naviViewController]
            self.splitViewController.delegate = channelViewController
            
            if let selectedRow = self.tableView.indexPathForSelectedRow() {
                self.tableView.deselectRowAtIndexPath(selectedRow, animated: true)
            }
        } else {
            self.navigationController.pushViewController(channelViewController, animated: true)
        }
        
        channelViewController.listViewController(self, handleObject: self.channel!)
    }
    
    
    func changeType(sender: AnyObject?) {
        var rssTypeControl: UISegmentedControl = sender! as UISegmentedControl
        let segmentIndex = rssTypeControl.selectedSegmentIndex
        rssType = ListViewControllerRSSType.fromRaw(segmentIndex)!
        self.fetchEntries()
    }
    
    
    // - View
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var xib: UINib = UINib(nibName: "RSSItemCell", bundle: nil)
        self.tableView.registerNib(xib, forCellReuseIdentifier: "RSSItemCell")
    }
    
    override func shouldAutorotateToInterfaceOrientation(toInterfaceOrientation: UIInterfaceOrientation) -> Bool {
        
        if deviceIsPad() {
            return true
        } else {
            return toInterfaceOrientation == UIInterfaceOrientation.Portrait
        }
    }
    
    
    // - UITableView DataSource
    
    
    override func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        if channel {
            return channel!.items.count
        }
        return 0
    }
    
    
    override func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        
        var cell: RSSItemCell = tableView.dequeueReusableCellWithIdentifier("RSSItemCell") as RSSItemCell
        cell.controller = self
        
        var item: RSSItem = channel!.items[indexPath.row]
        //var cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "UITableViewCell")
        //cell.textLabel.text = item.title
        cell.authorLabel.text = item.title
        cell.titleLabel.text = item.link
        cell.catagoryLabel.text = "Pro"
        return cell
    }
    
    override func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        
        if self.splitViewController == nil {
            
            self.navigationController.pushViewController(webViewController, animated: true)
        } else {
            var naviController = UINavigationController(rootViewController: webViewController)
            self.splitViewController.viewControllers = [self.navigationController, naviController]
            self.splitViewController.delegate = webViewController
        }
        
        var entry: RSSItem = channel!.items[indexPath.row]
        
        webViewController.listViewController(self, handleObject: entry) //send protocol message
    }
    
    
    
}


// - Protocol


protocol ListViewControllerDelegate {
    func listViewController(lvc: ListViewController, handleObject object: AnyObject)
}

protocol JSONSerializable {
    func readFromJSONDictionary(d: NSDictionary)
}