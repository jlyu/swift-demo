//
//  DetailViewController.swift
//  Homepwner
//
//  Created by chain on 14-6-30.
//  Copyright (c) 2014 chain. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet var nameField : UITextField
    @IBOutlet var serialNumberField : UITextField
    @IBOutlet var valueField : UITextField
    @IBOutlet var dateLabel : UILabel
    
    var item: BNRItem?
    
    /*
    init() {
        super.init(nibName: "DetailView", bundle: NSBundle.mainBundle())
    }
    
    convenience init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
        self.init()
    }
    */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.groupTableViewBackgroundColor()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        nameField.text = item!.itemName
        serialNumberField.text = item!.serialNumber
        valueField.text = String(item!.valueInDollars)
        
        var dateFormatter: NSDateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
        dateFormatter.timeStyle = NSDateFormatterStyle.NoStyle
        dateLabel.text = dateFormatter.stringFromDate(item!.dateCreated)
    }
}
