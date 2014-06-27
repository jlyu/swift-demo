//
//  ItemsViewController.swift
//  Homepwner
//
//  Created by chain on 14-6-24.
//  Copyright (c) 2014 chain. All rights reserved.
//

import UIKit

class ItemsViewController: UITableViewController, UITableViewDelegate, UITableViewDataSource {
    
    init() {
        //super.init(style: UITableViewStyle.Grouped)
        super.init(nibName: nil, bundle: nil)
        for i in 0..5 {
            BNRItemStore.instance.createItem()
        }
        
    }
    /*
    convenience init(style: UITableViewStyle) {
        self.init()
    }
    
    convenience init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
        self.init()
    }
    */
    
    override func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        return BNRItemStore.instance.allItems.count
    }
    
    override func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        var cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Default,
                                                    reuseIdentifier: "UITableViewCell")
        var item: BNRItem = BNRItemStore.instance.allItems[indexPath.row]
        cell.textLabel.text = item.description()
        
        return cell
    }

}
