//
//  ViewController.swift
//  Whereami
//
//  Created by chain on 14-6-18.
//  Copyright (c) 2014 chain. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit


class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate, UITextFieldDelegate {

    @IBOutlet var printLabel : UILabel = nil
    @IBOutlet var worldView : MKMapView = nil
    @IBOutlet var locationTitleField : UITextField = nil
    @IBOutlet var activityIndicator : UIActivityIndicatorView = nil
    
    var locationManager: CLLocationManager? = CLLocationManager()
                            
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.printLabel.text = ""
        self.printLabel.numberOfLines = 0
        self.printLabel.lineBreakMode = NSLineBreakMode.ByWordWrapping
        
        locationManager!.delegate = self
        locationManager!.desiredAccuracy = kCLLocationAccuracyBest
        locationManager!.distanceFilter = 10
        locationManager!.startUpdatingLocation()  // to be del..
        
        worldView.showsUserLocation = true
        //worldView.mapType = .Satellite
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        self.locationManager = nil
    }

    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: AnyObject[]!) {
        var location:CLLocation = locations[locations.count-1] as CLLocation
        self.locationManager!.stopUpdatingLocation()
        println("-> \(location.coordinate.latitude), \(location.coordinate.longitude)")
        self.printLabel.text = "Now we're here  -> \(location.coordinate.latitude), \(location.coordinate.longitude)"
    }
    
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        println("Could not find location: \(error)")
        self.printLabel.text = "Could not find location: \(error)"
    }
    
    
    func mapView(mapView: MKMapView!, didUpdateUserLocation userLocation: MKUserLocation!) {
        
        if userLocation.updating {
            var region :MKCoordinateRegion = MKCoordinateRegionMakeWithDistance(userLocation.location.coordinate, 50, 50)
            self.worldView.setRegion(region, animated: true)
            self.activityIndicator.stopAnimating()
        }
    }

    func locationManager(manager: CLLocationManager!, didUpdateToLocation newLocation: CLLocation!, fromLocation oldLocation: CLLocation!) {
        
        var t: NSTimeInterval = newLocation.timestamp.timeIntervalSinceNow
        if t < -10 {
            return;
        }
        
        foundLocation(newLocation)
    }

    func showPlaceMarksOnWorldMap(placeMarks:AnyObject[]!, error: NSError!) {
        
        if !placeMarks {
            println(error)
            self.printLabel.text = "Could not find location: \(error)"
            return
        }
    	
        var queryStr: String = self.locationTitleField.text
        var placeMarkArray: CLPlacemark[]?
    	//placeMarkArray = placeMarks as? CLPlacemark[]
        
        if placeMarks.count > 0 {
            self.worldView.removeAnnotations(self.worldView.annotations)
        }
            
        for var i=placeMarks.count-1; i>0; --i {

            if let placeMark = placeMarks[i] as? CLPlacemark {
                    
                var viewRegion: MKCoordinateRegion = MKCoordinateRegionMakeWithDistance(placeMark.location.coordinate, 10000, 10000)
                self.worldView.setRegion(viewRegion, animated: true)
                    
                var mapPoint: BNRMapPoint = BNRMapPoint(coordinate: placeMark.location.coordinate, title: queryStr)
                self.worldView.addAnnotation(mapPoint)
            }
            self.printLabel.text = "find \(queryStr)"
        }
        
        //if placeMarkArray {
        //    println("placeMarkArray -> \(placeMarkArray!.count)")
        //}
    }
    
    func findLocation(queryStr: String) {
        println(queryStr) // ok

        var geoCode: CLGeocoder = CLGeocoder()
        geoCode.geocodeAddressString(queryStr, completionHandler: showPlaceMarksOnWorldMap) 
            
    }
    
    func foundLocation(loc:CLLocation) {
        
        var mapPoint: BNRMapPoint = BNRMapPoint(coordinate: loc.coordinate, title: self.locationTitleField.text)
        self.worldView.addAnnotation(mapPoint)
        var region :MKCoordinateRegion = MKCoordinateRegionMakeWithDistance(loc.coordinate, 50, 50)
        self.worldView.setRegion(region, animated: true)
        
        self.locationTitleField.text = "moved"
        self.locationTitleField.hidden = false
        activityIndicator.stopAnimating()
        locationManager!.stopUpdatingLocation()
    }
    
    func textFieldShouldReturn(textField: UITextField!) -> Bool {
        
        locationManager!.stopUpdatingLocation()
        activityIndicator.startAnimating()
        locationTitleField.hidden = true
        findLocation(self.locationTitleField.text)
        locationTitleField.resignFirstResponder()
        locationTitleField.hidden = false
        activityIndicator.stopAnimating()
        return true
    }

}

