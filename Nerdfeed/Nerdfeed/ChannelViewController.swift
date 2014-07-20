//
//  ChannelViewController.swift
//  Nerdfeed
//
//  Created by chain on 14-7-19.
//  Copyright (c) 2014 chain. All rights reserved.
//

import UIKit

class ChannelViewController: UITableViewController,
                                UISplitViewControllerDelegate, ListViewControllerDelegate {
    
    // - Properties
    
    
    var channel: RSSChannel!
    
    
    init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
        super.init(nibName: nil, bundle: nil)
    }
    
    
    // - View 
    
    
    func splitViewController(svc: UISplitViewController!, willHideViewController aViewController: UIViewController!, withBarButtonItem barButtonItem: UIBarButtonItem!, forPopoverController pc: UIPopoverController!) {
        
        barButtonItem.title = "List"
        self.navigationItem.leftBarButtonItem = barButtonItem
        
    }
    
    func splitViewController(svc: UISplitViewController!, willShowViewController aViewController: UIViewController!, invalidatingBarButtonItem barButtonItem: UIBarButtonItem!) {
        
        if barButtonItem == self.navigationItem?.leftBarButtonItem {
            self.navigationItem.leftBarButtonItem = nil
        }
    }
    
    func splitViewController(svc: UISplitViewController!, popoverController pc: UIPopoverController!, willPresentViewController aViewController: UIViewController!) {
        
        do {} while(false)
        /*
        if !self.navigationItem.leftBarButtonItem {
            var barButtonItem = UIBarButtonItem()
            barButtonItem.title = "List.."
            self.navigationItem.leftBarButtonItem = barButtonItem
        }
        */
    }
    
    
    
    // - UITableView DataSource
    
    
    override func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    override func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        
        //var cell = tableView.dequeueReusableCellWithIdentifier("UITableViewCell") as UITableViewCell
        var cell = UITableViewCell(style: UITableViewCellStyle.Value2, reuseIdentifier: "UITableViewCell")
        
        //if cell == nil {
        //    cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "UITableViewCell")
        //}
        
        if indexPath.row == 0 {
            cell.textLabel.text = "Title"
            cell.detailTextLabel.text = self.channel!.title
        } else {
            cell.textLabel.text = "Description"
            cell.detailTextLabel.text = self.channel!.infoString
        }
        
        return cell
    }
    
    
    //  - Protocol
    
    
    func listViewController(lvc: ListViewController, handleObject object: AnyObject) {
        
        if (!object.isKindOfClass(RSSChannel.self)) {
            return
        }
        
        channel = object as RSSChannel
        //println(channel.title)
        self.tableView.reloadData()
    }

}
