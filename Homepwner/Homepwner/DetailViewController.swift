//
//  DetailViewController.swift
//  Homepwner
//
//  Created by chain on 14-6-30.
//  Copyright (c) 2014 chain. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController,
                            UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet var nameField : UITextField
    @IBOutlet var serialNumberField : UITextField
    @IBOutlet var valueField : UITextField
    @IBOutlet var dateLabel : UILabel
    @IBOutlet var imageView : UIImageView
    
    var item: BNRItem? = nil {
        willSet(newValue) {
            self.navigationItem.title = newValue!.itemName
        }
    }
    
    /*
    init() {
        super.init(nibName: "DetailView", bundle: NSBundle.mainBundle())
    }
    
    convenience init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
        self.init()
    }
    */
    @IBAction func takePicture(sender : AnyObject) {
        var imagePickerController: UIImagePickerController = UIImagePickerController()
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) {
            imagePickerController.sourceType = UIImagePickerControllerSourceType.Camera
        } else {
            imagePickerController.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        }
        imagePickerController.delegate = self
        
        //set modal view
        self.presentViewController(imagePickerController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.groupTableViewBackgroundColor()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        nameField.text = item!.itemName
        serialNumberField.text = item!.serialNumber
        valueField.text = String(item!.valueInDollars)
        
        var dateFormatter: NSDateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
        dateFormatter.timeStyle = NSDateFormatterStyle.NoStyle
        dateLabel.text = dateFormatter.stringFromDate(item!.dateCreated)
    }
    
    override func viewWillDisappear(animated: Bool) {
        self.editing = true
        
        item!.itemName = nameField.text
        item!.serialNumber = serialNumberField.text
        item!.valueInDollars = valueField.text.toInt()!

    }
    
    // conform UIImagePickerControllerDelegation
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingMediaWithInfo info: NSDictionary!) {
        var image: UIImage  = info.objectForKey(UIImagePickerControllerOriginalImage) as UIImage
        
        imageView.image = image //NG
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
