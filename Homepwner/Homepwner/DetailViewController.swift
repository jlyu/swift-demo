//
//  DetailViewController.swift
//  Homepwner
//
//  Created by chain on 14-6-30.
//  Copyright (c) 2014 chain. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet var detailView : UIView = nil
    @IBOutlet var nameField : UITextField
    @IBOutlet var serialNumberField : UITextField
    @IBOutlet var valueField : UITextField
    @IBOutlet var dateLabel : UILabel
    
    init() {
        super.init(nibName: "DetailView", bundle: NSBundle.mainBundle())
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.groupTableViewBackgroundColor()
    }
}
