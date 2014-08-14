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
