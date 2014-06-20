//
//  BNRMapPoint.swift
//  Whereami
//
//  Created by chain on 14-6-19.
//  Copyright (c) 2014 chain. All rights reserved.
//

import Foundation
import MapKit

class BNRMapPoint: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String
    
    init(coordinate: CLLocationCoordinate2D, title: String) {
        self.coordinate = coordinate
        self.title = title
    }
    
  //  func initWithCoordinate(c: CLLocationCoordinate2D, t:String) -> AnyObject {
        
  //  }
}