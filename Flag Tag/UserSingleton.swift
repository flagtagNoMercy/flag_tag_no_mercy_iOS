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
    
    var userFlag = 0
    var userFlagLimit = 1
    
    var userPoints = 0
    
    var userLatitude: CLLocationDegrees = 0
    var userLongitude: CLLocationDegrees = 0
    
    



    class func userData() -> UserSingleton {
    
        return _userData
    }


}