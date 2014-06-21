//
//  HypnosisView.swift
//  Hypnosister
//
//  Created by chain on 14-6-20.
//  Copyright (c) 2014 chain. All rights reserved.
//

import UIKit


class HypnosisView: UIView {
    
    var circleColor: UIColor = UIColor.clearColor()
    
    var circleColorAgent: UIColor
    {
        get { return UIColor.clearColor() }
        set {
            self.circleColor = newValue
            self.setNeedsDisplay()
        }
    }
    
    init(frame: CGRect) {
        super.init(frame:frame)

        self.circleColorAgent = UIColor.lightGrayColor()
        self.backgroundColor = UIColor.clearColor()
    }
    
    override func drawRect(rect: CGRect) {
        
        var ctx: CGContextRef = UIGraphicsGetCurrentContext()
        var bounds: CGRect = self.bounds
        
        var center: CGPoint = CGPointMake(bounds.origin.x + bounds.size.width / 2.0 ,
                                          bounds.origin.y + bounds.size.height / 2.0)
        var maxRadius: CGFloat = hypotf(bounds.size.width, bounds.size.height) / 2.0
        CGContextSetLineWidth(ctx, 10)
        self.circleColor.setStroke() //UIColor.lightGrayColor().setStroke()
        for var currentRadius = maxRadius; currentRadius > 0; currentRadius -= 20 {
            CGContextAddArc(ctx, center.x, center.y, currentRadius, 0.0, 3.141592653589792388 * 2.0, 0)
            CGContextStrokePath(ctx)
        }
        
        var text: NSString = "You are getting sleepy."
        var textFont: UIFont = UIFont.boldSystemFontOfSize(28)
        
        var textRect: CGRect = CGRect()
        textRect.size = text.sizeWithFont(textFont)
        textRect.origin.x = center.x - textRect.size.width / 2.0
        textRect.origin.y = center.y - textRect.size.height / 2.0
        
        UIColor.blackColor().setFill()
        
        // add font shadow effect
        var offSet: CGSize = CGSizeMake(4.0, 3.0)
        var shadowColor: CGColorRef = UIColor.darkGrayColor().CGColor
        CGContextSetShadowWithColor(ctx, offSet, 2.0, shadowColor)
        
        text.drawInRect(textRect, withFont: textFont)
        
    }
 
    override func canBecomeFirstResponder() -> Bool {
        return true
    }
    
    override func motionBegan(motion: UIEventSubtype, withEvent event: UIEvent!) {
        if motion == UIEventSubtype.MotionShake {
            print("Device started sharked")
            self.circleColorAgent = UIColor.redColor()
        }
    }
}