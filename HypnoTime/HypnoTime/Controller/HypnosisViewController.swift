//
//  HypnosisViewController.swift
//  HypnoTime
//
//  Created by chain on 14-6-21.
//  Copyright (c) 2014 chain. All rights reserved.
//

import UIKit

class HypnosisViewController: UIViewController {
    
    init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        if self != nil {
            var tbi: UITabBarItem = self.tabBarItem
            tbi.title = "Hypnosis"
            
            var img: UIImage = UIImage(named: "Hypno.png")
            tbi.image = img
        }
    }
    
    convenience init() {
        
        var nibName: String = "HypnosisView"
        var appBundle: NSBundle = NSBundle.mainBundle()
        self.init(nibName: nibName, bundle: appBundle)
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.view {
            
            var frontView = self.view
            var backView = HypnosisView(frame: UIScreen.mainScreen().bounds)
            
            //self.view = backView
            //self.view.addSubview(frontView)
            
            frontView.addSubview(backView)
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }

}
