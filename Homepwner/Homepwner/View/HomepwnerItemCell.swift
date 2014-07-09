//
//  HomepwnerItemCell.swift
//  Homepwner
//
//  Created by chain on 14-7-8.
//  Copyright (c) 2014 chain. All rights reserved.
//

import UIKit

class HomepwnerItemCell: UITableViewCell {
    
    @IBOutlet var thumbnailView : UIImageView
    @IBOutlet var nameLabel : UILabel
    @IBOutlet var serialNumberLabel : UILabel
    @IBOutlet var valueLabel : UILabel
    
    var controller: ItemsViewController!
    var tableView: UITableView!
    
    @IBAction func showImage(sender : AnyObject) {
        self.image = nil
        var indexPath: NSIndexPath = self.tableView.indexPathForCell(self)
        self.controller.showImage(sender, atIndexPath: indexPath)
    }
}
