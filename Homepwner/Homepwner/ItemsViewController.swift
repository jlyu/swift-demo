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
}
