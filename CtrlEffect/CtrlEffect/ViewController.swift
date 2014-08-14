//
//  ViewController.swift
//  CtrlEffect
//
//  Created by chain on 14-8-14.
//  Copyright (c) 2014 Chain. All rights reserved.
//

import UIKit

class ViewController: UIViewController,
                        TransformControlsDelegate {
                            
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // MARK: <TransformControlsDelegate>
    func transformDidChange(transform: CGAffineTransform, sender: AnyObject) {
        imageView.transform = transform
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        if segue.identifier? == "showTransformController" {
            if let transformController = segue.destinationViewController as? TransformControlsViewController {
                transformController.transformDelegate = self
                transformController.currentTransform = imageView.transform
            }
        }
    }
    

}

