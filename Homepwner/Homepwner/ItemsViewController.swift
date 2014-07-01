//
//  ItemsViewController.swift
//  Homepwner
//
//  Created by chain on 14-6-24.
//  Copyright (c) 2014 chain. All rights reserved.
//

import UIKit

class ItemsViewController: UITableViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var headerView : UIView?
    
    @IBAction func toggleEditingMode(sender : AnyObject) {
      
        if self.tableView.editing {
            sender.setTitle("Edit", forState: UIControlState.Normal)
            self.tableView.editing = false
        } else {
            sender.setTitle("Done", forState: UIControlState.Normal)
            self.tableView.editing = true
        }
    }
    
    @IBAction func addNewItem(sender : AnyObject) {
        var newItem: BNRItem = BNRItemStore.instance.createItem()
        var lastRow: Int = BNRItemStore.instance.allItems.indexOfObject(newItem)!
        var ips: NSIndexPath = NSIndexPath(forRow: lastRow, inSection: 0)
        
        self.tableView.insertRowsAtIndexPaths(NSArray(object:ips), withRowAnimation: UITableViewRowAnimation.Top)
    }
    
    init() {
        
        super.init(nibName: nil, bundle: nil)
        
        // load tableHeaderView
        if self.headerView == nil {
            NSBundle.mainBundle().loadNibNamed("HeaderView", owner: self, options: nil)
        }
        
        self.navigationItem.title = "Homepwner"
        
        
        for i in 0..2 {
            BNRItemStore.instance.createItem()
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }
    
    override func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        var detailView: DetailViewController = DetailViewController()
        
        var selectedItem: BNRItem = BNRItemStore.instance.allItems[indexPath.row]
        detailView.item = selectedItem
        
        self.navigationController.pushViewController(detailView, animated: true)
    }
    
    
    override func tableView(tableView: UITableView!, viewForHeaderInSection section: Int) -> UIView! {
        return self.headerView
    }
    
    override  func tableView(tableView: UITableView!, heightForHeaderInSection section: Int) -> CGFloat {
        return self.headerView!.bounds.size.height
    }
    
    
    override func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        return BNRItemStore.instance.allItems.count + 1
    }
    
    override func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        
        var cell: UITableViewCell? = tableView.dequeueReusableCellWithIdentifier("UITableViewCell") as? UITableViewCell
        
        if !cell {
            cell = UITableViewCell(style: UITableViewCellStyle.Default,
                                    reuseIdentifier: "UITableViewCell")
        }
        
        if indexPath.row == BNRItemStore.instance.allItems.count {
            cell!.textLabel.text = "No more items !"
        } else {
            var item: BNRItem = BNRItemStore.instance.allItems[indexPath.row]
            cell!.textLabel.text = item.description()
        }
        
        return cell!
    }
    
    override func tableView(tableView: UITableView!, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath!) {
        
        if editingStyle == UITableViewCellEditingStyle.Delete {
            BNRItemStore.instance.allItems.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths(NSArray(object: indexPath), withRowAnimation: UITableViewRowAnimation.Automatic)
        }
    }
    
    override  func tableView(tableView: UITableView!, moveRowAtIndexPath sourceIndexPath: NSIndexPath!, toIndexPath destinationIndexPath: NSIndexPath!) {
        
        BNRItemStore.instance.moveItemAtIndex(sourceIndexPath.row, toIndex: destinationIndexPath.row)
        
    }
    
    override func tableView(tableView: UITableView!, canMoveRowAtIndexPath indexPath: NSIndexPath!) -> Bool {
        if indexPath.row ==  BNRItemStore.instance.allItems.count {
            return false
        }
        return true
    }

    
    override func tableView(tableView: UITableView!, titleForDeleteConfirmationButtonForRowAtIndexPath indexPath: NSIndexPath!) -> String! {
        return "删除"
    }

}
