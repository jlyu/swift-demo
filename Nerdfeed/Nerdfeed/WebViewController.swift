//
//  WebViewController.swift
//  Nerdfeed
//
//  Created by chain on 14-7-17.
//  Copyright (c) 2014 chain. All rights reserved.
//

import UIKit

class WebViewController: UIViewController,
                         UISplitViewControllerDelegate {
    
    
    // - Property
    
    
    var webView: UIWebView = UIWebView()
    
    init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
        
        super.init(nibName: nil, bundle: nil)
    }
    
    
    // - View
    
    
    override func loadView() {
        super.loadView()
        self.view.addSubview(self.webView)

        self.webView.frame = UIScreen.mainScreen().applicationFrame
        self.webView.scalesPageToFit = true
        
    }
    
    override func shouldAutorotateToInterfaceOrientation(toInterfaceOrientation: UIInterfaceOrientation) -> Bool {
        if deviceIsPad() {
            return true
        } else {
            return toInterfaceOrientation == UIInterfaceOrientation.Portrait
        }
    }
    
}

