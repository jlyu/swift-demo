//
//  TimeViewController.swift
//  HypnoTime
//
//  Created by chain on 14-6-22.
//  Copyright (c) 2014 chain. All rights reserved.
//

import UIKit

class TimeViewController: UIViewController {
    
    @IBOutlet weak var timeLabel : UILabel = nil
    
    init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        if self != nil {
            var tbi: UITabBarItem = self.tabBarItem
            tbi.title = "Time"
            
            var img: UIImage = UIImage(named: "Time.png")
            tbi.image = img
        }
    }
    
    convenience init() {
        var nibName: String = "TimeViewController"
        var appBundle: NSBundle = NSBundle.mainBundle()
        self.init(nibName: nibName, bundle: appBundle)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.lightGrayColor()
        println("TimeViewController loaded its view")
    }

    override func viewWillAppear(animated: Bool) {
        println("Time View Controller will appear")
        super.viewWillAppear(animated)
       // self.showCurrentTime(nil)
    }
    
    override func viewWillDisappear(animated: Bool) {
        println("Time View Controll will disappear")
        super.viewWillDisappear(animated)
    }
    
    @IBAction func showCurrentTime(sender : AnyObject?) {
        
        var now: NSDate = NSDate()
        var formatter: NSDateFormatter = NSDateFormatter()
        formatter.dateStyle = NSDateFormatterStyle.MediumStyle
        timeLabel.text = formatter.stringFromDate(now)
    }
}
