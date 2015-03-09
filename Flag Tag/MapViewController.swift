//
//  MapViewController.swift
//  Flag Tag
//
//  Created by Ebony Nyenya and Bobby Towers on 3/6/15.
//  Copyright (c) 2015 Ebony Nyenya and Bobby Towers. All rights reserved.
//

import UIKit
import MapKit

// Simulator custom location:
// lat: 33.752077
// long: -84.391434


class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var gameMapView: MKMapView!
    
    @IBOutlet weak var gameMapTimeLabel: UILabel!
    @IBOutlet weak var userPointsLabel: UILabel! // My Points: ##
    @IBOutlet weak var leaderPointsLabel: UILabel! // Leader: ##
    
    var gameTimeLimit = GameSingleton.gameData().timeLimit
    var gameTimeCount = 0
    var secondsCount = 0
    var minutesCount = 0
    var timer = NSTimer()
    var timerIsActive = false
    
    // Hard code enemy flags (0 is 2nd player, 1 is 3rd player... 8 is 10th player)
    var enemyArray = [0, 1, 2, 3, 4, 5, 6, 7, 8]
    var enemyCountIndex = 0
    
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Location Manager settings
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        gameMapView.delegate = self
        
        
        var latitude: CLLocationDegrees = 33.752077
        var longitude: CLLocationDegrees = -84.391434
        
        var latDelta: CLLocationDegrees = 0.04
        var lonDelta: CLLocationDegrees = 0.04
        
        var span: MKCoordinateSpan = MKCoordinateSpanMake(latDelta, lonDelta)
        var location: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        var region: MKCoordinateRegion = MKCoordinateRegionMake(location, span)
        
        gameMapView.setRegion(region, animated: true)
        
        // Hard code game conditions
        GameSingleton.gameData().gameIsActive = true
        UserSingleton.userData().flagDropped = false
        
        startGameClock()
        
        // Check if game is active
        if GameSingleton.gameData().gameIsActive == true {
        
            // Create long press gesture recognizer for Local User flag
            var longPressSelf = UILongPressGestureRecognizer(target: self, action: "addFlagOnSelf:")
            longPressSelf.minimumPressDuration = 1.5
            gameMapView.addGestureRecognizer(longPressSelf)
            
            // Create tap gesture recognizer
            var tapPressEnemies = UITapGestureRecognizer(target: self, action: "addFlagForEnemies:")
            gameMapView.addGestureRecognizer(tapPressEnemies)
            
//            var longPressEnemies = UILongPressGestureRecognizer(target: self, action: "addFlagForEnemies:")
//            longPressEnemies.minimumPressDuration = 2.5
//            gameMapView.addGestureRecognizer(longPressEnemies)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    ///// EXIT SEGUE
    
    @IBAction func backToMap(segue: UIStoryboardSegue) {
    }
    
    ///// GAME CLOCK
    
    func startGameClock() {
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("timerIncrement"), userInfo: nil, repeats: true)
        timerIsActive = true
    }
    
    func timerIncrement() {
        gameTimeCount++
        updateClockLabel()
    }
    
    func stopGameClock() {
        timerIsActive = false
        timer.invalidate()
    }
    
    func resetGameClock() {
        stopGameClock()
        gameTimeCount = 0
    }
    
    func updateClockLabel() {
        
        if timerIsActive {
            if secondsCount == 59 {
                secondsCount = 0
                minutesCount++
            } else {
                secondsCount++
            }
        }
    
        if secondsCount < 10 && minutesCount < 10 {
            gameMapTimeLabel.text = "0\(minutesCount):0\(secondsCount)"
        } else if minutesCount < 10 {
            gameMapTimeLabel.text = "0\(minutesCount):\(secondsCount)"
        } else if secondsCount < 10 {
            gameMapTimeLabel.text = "\(minutesCount):0\(secondsCount)"
        } else {
            gameMapTimeLabel.text = "\(minutesCount):\(secondsCount)"
        }
    }
    
    ///// LOCATION MANAGER
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        
        var userLocation = locations[0] as CLLocation
        
        UserSingleton.userData().userLatitude = userLocation.coordinate.latitude
        UserSingleton.userData().userLongitude = userLocation.coordinate.longitude
        
        //        var latitude = userLocation.coordinate.latitude
        //        var longitude = userLocation.coordinate.longitude
        
        var latDelta: CLLocationDegrees = 0.01
        var lonDelta: CLLocationDegrees = 0.01
        
//        var span: MKCoordinateSpan = MKCoordinateSpanMake(latDelta, lonDelta)
//        var location: CLLocationCoordinate2D = CLLocationCoordinate2DMake(UserSingleton.userData().userLatitude, UserSingleton.userData().userLongitude)
//        var region: MKCoordinateRegion = MKCoordinateRegionMake(location, span)
//        
//        gameMapView.setRegion(region, animated: true)
        
        
        println("locations = \(locations)")
        
        // When game time is done
//        if gameTimeCount == gameTimeLimit {
//            println("Time limit has been reached! Game is complete.")
//            resetGameClock()
//        }
    }
    
    ///// MAP VIEW
    
    func addFlagOnSelf(gestureRecognizer: UIGestureRecognizer) {
        // Drop flag on local user's location
        
        if UserSingleton.userData().flagDropped == false {
            
            var localUserCoordinate: CLLocationCoordinate2D = CLLocationCoordinate2DMake(UserSingleton.userData().userLatitude, UserSingleton.userData().userLongitude)
            
//            var localUserAnnotation = MKPointAnnotation()
//            localUserAnnotation.coordinate = localUserCoordinate
//            localUserAnnotation.title = "Player 1's Flag"
//            localUserAnnotation.subtitle = "username@blah.com"
            
//            var customUserFlag = FlagAnnotation(coordinate: localUserCoordinate, title: "Player 1's Flag", subtitle: "We did it guys")
            
            var customUserFlag = FlagAnnotation()
            customUserFlag.coordinate = localUserCoordinate
            customUserFlag.title = "Player 1 Flag"
            customUserFlag.subtitle = "booyahbaby1"
            customUserFlag.flagImageName = "blackFlag92x92"
            
            gameMapView.addAnnotation(customUserFlag)
            
        } else {
            println("Sorry, you cannot drop another flag")
        }
        
        UserSingleton.userData().flagDropped = true
    }
    
    ///// HARD CODE FLAGS FOR ENEMIES
    
    func addFlagForEnemies(gestureRecognizer: UIGestureRecognizer) {
        // Drop flag on enemy, on location in view tap
        
        var localUserCoordinate: CLLocationCoordinate2D = CLLocationCoordinate2DMake(UserSingleton.userData().userLatitude, UserSingleton.userData().userLongitude)
        
        var touchPoint = gestureRecognizer.locationInView(self.gameMapView)
        
        var viewTapCoordinate: CLLocationCoordinate2D = gameMapView.convertPoint(touchPoint, toCoordinateFromView: self.gameMapView)
        
        var enemyUserFlag = FlagAnnotation()
        enemyUserFlag.coordinate = viewTapCoordinate
        enemyUserFlag.title = "Player \(enemyCountIndex + 2) Flag"
        
        if enemyCountIndex == 0 {
            enemyUserFlag.subtitle = "Coolest Nerd Ever"
            enemyUserFlag.flagImageName = "blackFlagBlue92x92"
        } else if enemyCountIndex == 1 {
            enemyUserFlag.subtitle = "Dingleberry Dane"
            enemyUserFlag.flagImageName = "blackFlagGreen92x92"
        } else if enemyCountIndex == 2 {
            enemyUserFlag.subtitle = "Jack McKraken"
            enemyUserFlag.flagImageName = "blackFlagOrange92x92"
        } else if enemyCountIndex == 3 {
            enemyUserFlag.subtitle = "Yeti on Fire"
            enemyUserFlag.flagImageName = "blackFlagPurple92x92"
        } else if enemyCountIndex == 4 {
            enemyUserFlag.subtitle = "Iron Dog"
            enemyUserFlag.flagImageName = "blackFlagYellow92x92"
        } else if enemyCountIndex == 5 {
            enemyUserFlag.subtitle = "I Love BBQ"
            enemyUserFlag.flagImageName = "blackFlagTeal92x92"
        } else if enemyCountIndex == 6 {
            enemyUserFlag.subtitle = "Superman"
            enemyUserFlag.flagImageName = "blackFlagViolet92x92"
        } else if enemyCountIndex == 7 {
            enemyUserFlag.subtitle = "Bart Simpson"
            enemyUserFlag.flagImageName = "blackFlagMaroon92x92"
        } else if enemyCountIndex == 8 {
            enemyUserFlag.subtitle = "Don't Taze Me Jo"
            enemyUserFlag.flagImageName = "blackFlagGrey92x92"
        } else {
            return
        }
        
        gameMapView.addAnnotation(enemyUserFlag)
        enemyCountIndex++
    }
    
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        println(error)
    }
    
    func mapView(mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
        if !(annotation is FlagAnnotation) {
            return nil
        }
        
        let reuseId = "test"
        
        var anView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseId)
        if anView == nil {
            anView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            anView.canShowCallout = true
        }
        else {
            anView.annotation = annotation
        }
        
        //Set annotation-specific properties **AFTER**
        //the view is dequeued or created...
        
        let flagAnno = annotation as FlagAnnotation
        if let flagImage = flagAnno.flagImageName {
            anView.image = UIImage(named:flagAnno.flagImageName!)
        }
        
        
        return anView
    }
    
    
//    func locationManager(manager: CLLocationManager!, didEnterRegion region: CLRegion!) {
//
//    }
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}

