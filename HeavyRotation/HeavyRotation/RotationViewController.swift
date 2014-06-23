//
//  ViewController.swift
//  HeavyRotation
//
//  Created by chain on 14-6-23.
//  Copyright (c) 2014 chain. All rights reserved.
//

import UIKit

class RotationViewController: UIViewController {
        
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    override func shouldAutorotateToInterfaceOrientation(toInterfaceOrientation: UIInterfaceOrientation) -> Bool {
        return (toInterfaceOrientation == UIInterfaceOrientation.Portrait)
            || UIInterfaceOrientationIsLandscape(toInterfaceOrientation)
    }

}

