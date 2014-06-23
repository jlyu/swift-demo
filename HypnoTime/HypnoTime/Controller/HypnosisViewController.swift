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
        //self.view = HypnosisView(frame: UIScreen.mainScreen().bounds)
    }
    
    convenience init() {
        var nibName: String = "HypnosisViewController"
        var appBundle: NSBundle = NSBundle.mainBundle()
        self.init(nibName: nibName, bundle: appBundle)
    }

    
    override func loadView() {
     //   var hypnosisView: HypnosisView = HypnosisView(frame: UIScreen.mainScreen().bounds)
      //  self.view = hypnosisView
       // self.view.drawRect(UIScreen.mainScreen().bounds)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        println("HypnosisViewController loaded its view")
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
       // var frame: CGRect = UIScreen.mainScreen().bounds
       // var hypnosisView: HypnosisView = HypnosisView(frame: frame)
       // self.view = hypnosisView
       // self.view.drawRect(frame)
    }

}
