//
//  ViewController.swift
//  WhereAmI
//
//  Created by Rommel Rico on 3/2/15.
//  Copyright (c) 2015 Rommel Rico. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    var manager:CLLocationManager!
    
    @IBOutlet weak var myLatitudeLabel: UILabel!
    @IBOutlet weak var myLongitudeLabel: UILabel!
    @IBOutlet weak var mySpeedLabel: UILabel!
    @IBOutlet weak var myHeadingLabel: UILabel!
    @IBOutlet weak var myAltitudeLabel: UILabel!
    @IBOutlet weak var myNearestAddressTextView: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        manager = CLLocationManager()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        var userLocation:CLLocation = locations[0] as CLLocation
        
        //Latitude
        myLatitudeLabel.text = "Latitude: \(userLocation.coordinate.latitude)"
        
        //Longitude
        myLongitudeLabel.text = "Longitude: \(userLocation.coordinate.longitude)"
        
        //Speed
        mySpeedLabel.text = "Speed: \(userLocation.speed)"
        
        //Heading
        myHeadingLabel.text = "Heading: \(userLocation.course)"
        
        //Altitude 
        myAltitudeLabel.text = "Altitude: \(userLocation.altitude)"
        
        //Nearest Address
        CLGeocoder().reverseGeocodeLocation(userLocation, completionHandler: { (placemarks, error) -> Void in
            if (error != nil) {
                NSLog("ERROR: \(error)")
            } else {
                let place = CLPlacemark(placemark: placemarks?[0] as CLPlacemark)
                
                var subThoroughfare = ""
                if (place.subThoroughfare != nil) {
                    subThoroughfare = place.subThoroughfare
                }
                
                self.myNearestAddressTextView.text = "\(subThoroughfare) \(place.thoroughfare) \n \(place.subLocality) \n \(place.subAdministrativeArea) \n \(place.country) \(place.postalCode) "
            }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

