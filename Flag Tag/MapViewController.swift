//
//  MapViewController.swift
//  Flag Tag
//
//  Created by Ebony Nyenya and Bobby Towers on 3/6/15.
//  Copyright (c) 2015 Ebony Nyenya and Bobby Towers. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation



class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var gameMapView: MKMapView!
    
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Location Manager settings
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        
        GameSingleton.gameData().gameIsActive = true
        UserSingleton.userData().flagDropped = false
        
    /*
        // Check if game is active
        if GameSingleton.gameData().gameIsActive == true {
        
            // Long press gesture recognizer settings
            if UserSingleton.userData().userFlag == 0 {
                
                var longPress = UILongPressGestureRecognizer(target: self, action: "addFlagOnSelf:")
                longPress.minimumPressDuration = 2.0
                gameMapView.addGestureRecognizer(longPress)
            } else {
                println("Sorry, cannot drop another flag")
            }
        }
    */
        
        if GameSingleton.gameData().gameIsActive == true {
            
            var longPress = UILongPressGestureRecognizer(target: self, action: "addFlagOnSelf:")
            longPress.minimumPressDuration = 2.0
            gameMapView.addGestureRecognizer(longPress)
            
//            while GameSingleton.gameData()
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
    
        var userLocation = locations[0] as CLLocation
        
        UserSingleton.userData().userLatitude = userLocation.coordinate.latitude
        UserSingleton.userData().userLongitude = userLocation.coordinate.longitude
        
//        var latitude = userLocation.coordinate.latitude
//        var longitude = userLocation.coordinate.longitude
        
        var latDelta: CLLocationDegrees = 0.01
        var lonDelta: CLLocationDegrees = 0.01
        
        var span: MKCoordinateSpan = MKCoordinateSpanMake(latDelta, lonDelta)
        var location: CLLocationCoordinate2D = CLLocationCoordinate2DMake(UserSingleton.userData().userLatitude, UserSingleton.userData().userLongitude)
        var region: MKCoordinateRegion = MKCoordinateRegionMake(location, span)
        
        gameMapView.setRegion(region, animated: true)
        
        
        println("locations = \(locations)")
        
        
        
    }
    
//    func locationManager(manager: CLLocationManager!, didEnterRegion region: CLRegion!) {
//
//    }
    
    func addFlagOnSelf(gestureRecognizer: UIGestureRecognizer) {
        // Drop flag on local user's location
        
        if UserSingleton.userData().flagDropped == false {
            
            var localUserCoordinate: CLLocationCoordinate2D = CLLocationCoordinate2DMake(UserSingleton.userData().userLatitude, UserSingleton.userData().userLongitude)
            
            var localUserAnnotation = MKPointAnnotation()
            localUserAnnotation.coordinate = localUserCoordinate
            localUserAnnotation.title = "Player 1's Flag"
            localUserAnnotation.subtitle = "username@blah.com"
            
            gameMapView.addAnnotation(localUserAnnotation)
            
        } else {
            println("Sorry, you cannot drop another flag")
        }
        
        UserSingleton.userData().flagDropped = true
    }
    
    
    
    
    
    func action(gestureRecognizer: UIGestureRecognizer) {
        
        var touchPoint = gestureRecognizer.locationInView(self.gameMapView)
        
        var newCoordinate: CLLocationCoordinate2D = gameMapView.convertPoint(touchPoint, toCoordinateFromView: self.gameMapView)
        
        // Adds annotations to the map chosen by user pressing on the map
        var annotation = MKPointAnnotation()
        
        annotation.coordinate = newCoordinate
        
        annotation.title = ""
        annotation.subtitle = ""
        
        gameMapView.addAnnotation(annotation)
     
        
        
    }

    
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        
        println(error)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
