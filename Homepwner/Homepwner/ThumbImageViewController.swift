//
//  ThumbImageViewController.swift
//  Homepwner
//
//  Created by chain on 14-7-10.
//  Copyright (c) 2014 chain. All rights reserved.
//

import UIKit

class ThumbImageViewController: UIViewController {

    @IBOutlet var scrollView : UIScrollView
    @IBOutlet var imageView : UIImageView
    
    var image: UIImage?
    
    init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
        super.init(nibName: nil, bundle: nibBundleOrNil)
        
        var tapRecognizer: UITapGestureRecognizer = UITapGestureRecognizer(target: self.view,
                                                                            action: Selector("tap:"))
        self.view?.addGestureRecognizer(tapRecognizer)
    }
    
    func tap(gr: UIGestureRecognizer) {
        println("tapped")
        self.presentingViewController.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func touchesBegan(touches: NSSet!, withEvent event: UIEvent!) {
        println("touches Began")
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        var sz: CGSize = self.image!.size
        scrollView.contentSize = sz
        imageView.frame = CGRectMake(0, 0, sz.width, sz.height)
        imageView.image = image
    }
}
