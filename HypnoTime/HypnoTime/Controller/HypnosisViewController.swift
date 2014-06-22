//
//  HypnosisViewController.swift
//  HypnoTime
//
//  Created by chain on 14-6-21.
//  Copyright (c) 2014 chain. All rights reserved.
//

import UIKit

class HypnosisViewController: UIViewController {
    
    
    
    override func loadView() {
        var frame: CGRect = UIScreen.mainScreen().bounds
        var hypnosisView: HypnosisView = HypnosisView(frame: frame)
        
        self.view = hypnosisView
    }
}
