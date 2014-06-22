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
        
        super.init(nibName: nil, bundle: nil)
        if self != nil {
            var tbi: UITabBarItem = self.tabBarItem
            tbi.title = "Hypnosis"
            
            var img: UIImage = UIImage(named: "Hypno@2x.png")
            tbi.image = img
        }
    }
    
    convenience init() {
        self.init(nibName: nil, bundle: nil)
    }

    
    //override func loadView() {
    //    var frame: CGRect = UIScreen.mainScreen().bounds
    //    var hypnosisView: HypnosisView = HypnosisView(frame: frame)
        
    //    self.view = hypnosisView
    //}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        println("HypnosisViewController loaded its view")
        
        
    }
    
    
}
