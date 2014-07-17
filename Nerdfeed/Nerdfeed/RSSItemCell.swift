//
//  RSSItemCell.swift
//  Nerdfeed
//
//  Created by chain on 14-7-17.
//  Copyright (c) 2014 chain. All rights reserved.
//

import UIKit

class RSSItemCell: UITableViewCell {
    
    @IBOutlet var authorLabel : UILabel
    @IBOutlet var titleLabel : UILabel
    @IBOutlet var catagoryLabel : UILabel
    
    var controller: ListViewController!
}
