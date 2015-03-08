//
//  UserSingleton.swift
//  Flag Tag
//
//  Created by Ebony Nyenya and Bobby Towers on 3/7/15.
//  Copyright (c) 2015 Ebony Nyenya and Bobby Towers. All rights reserved.
//

// UserSingleton.userData().flagDropped

import UIKit
import MapKit

let _userData: UserSingleton = UserSingleton()

class UserSingleton: NSObject {
    
    var flagDropped: Bool = false
    
    var userPoints = 0
    
    var userLatitude: CLLocationDegrees = 33.752077
    var userLongitude: CLLocationDegrees = -84.391434
    
    var userFlagLat: CLLocationDegrees = 0
    var userFlagLong: CLLocationDegrees = 0
    
    var userEmail = ""
    var userSessionAuthToken = ""
    var userID = 0
    
    var gameID = 0
    var gameIDArray = [Int]()
    
    
    class func userData() -> UserSingleton {
    
        return _userData
    }

    override init() {
        
        let defaults = NSUserDefaults.standardUserDefaults()
        token = defaults.objectForKey("token") as? NSString
    }
    
    var token: String? {
        
        didSet {
            
            let defaults = NSUserDefaults.standardUserDefaults()
            
            defaults.setObject(token, forKey: "token")
            defaults.synchronize()
        }
    }
    
    func register(email: String, password: String) {
        
        let options : [String:AnyObject] = [
            "endpoint" : "users",
            "verb" : "POST",
            "body" : [
                "user" : ["email" : email, "password" : password]
            ]
        ]
        
        APIRequest.requestWithOptions(options, andCompletion: { (responseInfo) -> () in
            println(responseInfo)
            if let dataInfo = responseInfo["user"] as [NSString:NSString]? {
                self.token = dataInfo["authentication_token"]
            }
        })
    }
    
    func login(email: String, password: String) {
        
        let options : [String:AnyObject] = [
            "endpoint" : "users/sign_in",
            "verb" : "POST",
            "body" : [
                "user" : ["email": email, "password": password]
            ]
        ]
        
        APIRequest.requestWithOptions(options, andCompletion: { (responseInfo) -> () in
            println(responseInfo)
            if let dataInfo = responseInfo["user"] as [NSString:NSString]? {
                self.token = dataInfo["authentication_token"]
            }
        })
    }
    
    // Do we need to use these?
    // UserSingleton.UserData().gameID
    // UserSingleton.UserData().userID
    // UserSingleton.UserData().userSessionAuthToken
    
    
    func joinGame(authToken: String, userNumber: Int, gameNumber: Int) {
        
        let options : [String:AnyObject] = [
            "endpoint" : "users/\(userID)/games/\(gameID)",
            "verb" : "PATCH",
            "body" : [
                "authentication_token" : authToken,
                "id" : userNumber,
                "game_id" : gameNumber // "game_id" might be incorrect
            ]
        ]
        
        APIRequest.requestWithOptions(options, andCompletion: { (responseInfo) -> () in
            println(responseInfo)
            if let dataInfo = responseInfo["user"] as [NSString:NSString]? {
                self.token = dataInfo["authentication_token"]
            }
        })
    }
    
    func requestGameID(authToken: String, userNumber: Int) {
        
        let options : [String:AnyObject] = [
            "endpoint" : "users/\(userID)",
            "verb" : "GET",
            "body" : [
                "authentication_token": authToken,
                "id": userNumber
            ]
        ]
        
        APIRequest.requestWithOptions(options, andCompletion: { (responseInfo) -> () in
            println(responseInfo)
            if let dataInfo = responseInfo["user"] as [NSString:NSString]? {
                self.token = dataInfo["authentication_token"]
            }
        })
    }
    
    func showGame(authToken: String, userNumber: Int, gameNumber: Int) {
        
        let options : [String:AnyObject] = [
            "endpoint" : "users/\(userID)/games/\(gameID)",
            "verb" : "GET",
            "body" : [
                "authentication_token" : authToken,
                "id" : userNumber,
                "game_id" : gameNumber  // "game_id" might be incorrect
            ]
        ]
        
        APIRequest.requestWithOptions(options, andCompletion: { (responseInfo) -> () in
            println(responseInfo)
            if let dataInfo = responseInfo["user"] as [NSString:NSString]? {
                self.token = dataInfo["authentication_token"]
            }
        })
    }
    

}