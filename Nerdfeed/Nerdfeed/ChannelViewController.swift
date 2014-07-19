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
    
    
    // - Method
    
    
    func showInfo() {
        
        var channelViewController = ChannelViewController(nibName: nil, bundle: nil)
        
        if self.splitViewController {
            var naviViewController = UINavigationController(rootViewController: channelViewController)
            
            self.splitViewController.viewControllers = [self.navigationController, navigationController]
            self.splitViewController.delegate = channelViewController
            
            if let selectedRow = self.tableView.indexPathForSelectedRow() {
                self.tableView.deselectRowAtIndexPath(selectedRow, animated: true)
            }
        } else {
            self.navigationController.pushViewController(channelViewController, animated: true)
        }
        
        channelViewController.listViewController(self, handleObject: channel)
    }
    
    
    
    // - UITableView DataSource
    
    
    override func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    override func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        
        var cell = tableView.dequeueReusableCellWithIdentifier("UITableViewCell") as UITableViewCell
        
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "UITableViewCell")
        }
        
        if indexPath.row == 0 {
            cell.textLabel.text = "Title"
            cell.detailTextLabel.text = channel.title
        } else {
            cell.textLabel.text = "Description"
            cell.detailTextLabel.text = channel.infoString
        }
        
        return cell
    }
    
    
    //  - Protocol
    
    
    func listViewController(lvc: ListViewController, handleObject object: AnyObject) {
        
        if (!object.isKindOfClass(RSSChannel.self)) {
            return
        }
        
        channel = object as RSSChannel
        self.tableView.reloadData()
    }

}
