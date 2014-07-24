//
//  WebViewController.swift
//  Nerdfeed
//
//  Created by chain on 14-7-17.
//  Copyright (c) 2014 chain. All rights reserved.
//

import UIKit

class WebViewController: UIViewController,
                         UISplitViewControllerDelegate, ListViewControllerDelegate {
    
    
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
    
    func splitViewController(svc: UISplitViewController!, willHideViewController aViewController: UIViewController!, withBarButtonItem barButtonItem: UIBarButtonItem!, forPopoverController pc: UIPopoverController!) {
        
        barButtonItem.title = "List"
        self.navigationItem.leftBarButtonItem = barButtonItem
        
    }
    
    func splitViewController(svc: UISplitViewController!, willShowViewController aViewController: UIViewController!, invalidatingBarButtonItem barButtonItem: UIBarButtonItem!) {
        
        if barButtonItem == self.navigationItem.leftBarButtonItem {
            self.navigationItem.leftBarButtonItem = nil
        }
    }
    
    
    
    //  - Protocol
    
    
    func listViewController(lvc: ListViewController, handleObject object: AnyObject) {
        
        if (!object.isKindOfClass(RSSItem.self)) {
            return
        }
        
        var entry: RSSItem = object as RSSItem
        
        let url = NSURL(string: entry.link)
        let request = NSURLRequest(URL: url)
        self.webView.loadRequest(request)
        
        self.navigationItem.title = entry.title
    }
    
}

