//
//  AppDelegate.swift
//  Hypnosister
//
//  Created by chain on 14-6-20.
//  Copyright (c) 2014 chain. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UIScrollViewDelegate {
                            
    var window: UIWindow?
    var hypnosisView: HypnosisView!


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: NSDictionary?) -> Bool {
        
        // hide status bar
        application.setStatusBarHidden(true, animated: true)
        
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        var screenFrame: CGRect = self.window!.bounds
        
        var scrollView: UIScrollView = UIScrollView(frame: screenFrame)
        //scrollView.pagingEnabled = true
        var doubleFrame: CGRect = screenFrame
        hypnosisView = HypnosisView(frame: screenFrame)
        scrollView.addSubview(hypnosisView)
        
        scrollView.contentSize = doubleFrame.size
        scrollView.maximumZoomScale = 50.0
        scrollView.minimumZoomScale = 0.1
        scrollView.delegate = self
        
        self.window!.addSubview(scrollView)
        
        
        var becomeFirstResponder = hypnosisView.becomeFirstResponder()
        //anotherView.becomeFirstResponder()
        if becomeFirstResponder {
            print("HypnosisView became First Responder")
        } else {
            print("Could not become First Responder")
        }
        
        self.window!.backgroundColor = UIColor.whiteColor()
        self.window!.makeKeyAndVisible()
        return true
    }
    
    func viewForZoomingInScrollView(scrollView: UIScrollView!) -> UIView! {
        return hypnosisView
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

