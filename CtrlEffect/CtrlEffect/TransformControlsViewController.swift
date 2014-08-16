//
//  TransformControlsViewController.swift
//  CtrlEffect
//
//  Created by chain on 14-8-14.
//  Copyright (c) 2014 Chain. All rights reserved.
//

import UIKit

protocol TransformControlsDelegate {
    func transformDidChange(transform: CGAffineTransform, sender: AnyObject)
}


struct Vect2D {
    var x: Float
    var y: Float
    
    var xCG: CGFloat {
        return CGFloat(x)
    }
    var yCG: CGFloat {
        return CGFloat(y)
    }
}



class TransformControlsViewController: UIViewController {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var rotationSlider: UISlider!
    
    var transformDelegate: TransformControlsDelegate?
    var currentTransform: CGAffineTransform?
    var backgroundView: UIVisualEffectView?
    
    override func viewDidLoad() {
        if currentTransform != nil {
            applyTransformToSliders(currentTransform!)
        }
        
        backgroundView = prepareVisualEffectView()
        view.addSubview(backgroundView!)
        applyEqualSizeConstraints(view, v2: backgroundView!, includeTop: false)
        view.backgroundColor = UIColor.clearColor()
    }

    func applyTransformToSliders(transform: CGAffineTransform) {
        let decomposition = decomposeAffineTransform(transform)
        rotationSlider.value = decomposition.rotation
    }
    
    func prepareVisualEffectView() -> UIVisualEffectView {
        // Create the blur effect
        let blurEffect = UIBlurEffect(style: .Light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.contentView.backgroundColor = UIColor.clearColor()
        
        // Create the vibrancy effect - to be added to the blur
        let vibrancyEffect = UIVibrancyEffect(forBlurEffect: blurEffect)
        let vibrancyEffectView = UIVisualEffectView(effect: vibrancyEffect)
        
        // Add the content to the views appropriately
        vibrancyEffectView.contentView.addSubview(containerView)
        blurEffectView.contentView.addSubview(vibrancyEffectView)
        
        // Prepare autolayout
        containerView.setTranslatesAutoresizingMaskIntoConstraints(false)
        blurEffectView.setTranslatesAutoresizingMaskIntoConstraints(false)
        vibrancyEffectView.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        applyEqualSizeConstraints(vibrancyEffectView.contentView, v2: containerView, includeTop: true)
        applyEqualSizeConstraints(blurEffectView.contentView, v2: vibrancyEffectView, includeTop: true)
        
        return blurEffectView
    }
    
    func applyEqualSizeConstraints(v1: UIView, v2: UIView, includeTop: Bool) {
        v1.addConstraint(NSLayoutConstraint(item: v1, attribute: .Left, relatedBy: .Equal, toItem: v2, attribute: .Left, multiplier: 1, constant: 0))
        v1.addConstraint(NSLayoutConstraint(item: v1, attribute: .Right, relatedBy: .Equal, toItem: v2, attribute: .Right, multiplier: 1, constant: 0))
        v1.addConstraint(NSLayoutConstraint(item: v1, attribute: .Bottom, relatedBy: .Equal, toItem: v2, attribute: .Bottom, multiplier: 1, constant: 0))
        if(includeTop) {
            v1.addConstraint(NSLayoutConstraint(item: v1, attribute: .Top, relatedBy: .Equal, toItem: v2, attribute: .Top, multiplier: 1, constant: 0))
        }
    }

    func decomposeAffineTransform(transform: CGAffineTransform) -> (rotation: Float, scale: Vect2D, translation: Vect2D) {
        // This requires a specific ordering (and no skewing). It matches the constructTransform method
        
        // Translation first
        let translation = Vect2D(x: Float(transform.tx), y: Float(transform.ty))
        
        // Then scale
        let scaleX = sqrt(Double(transform.a * transform.a + transform.c * transform.c))
        let scaleY = sqrt(Double(transform.b * transform.b + transform.d * transform.d))
        let scale = Vect2D(x: Float(scaleX), y: Float(scaleY))
        
        // And rotation
        let rotation = Float(atan2(Double(transform.b), Double(transform.a)))
        
        return (rotation, scale, translation)
    }
}