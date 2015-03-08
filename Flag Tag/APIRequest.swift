//
//  APIRequest.swift
//  Flag Tag
//
//  Created by Bobby Towers on 3/7/15.
//  Copyright (c) 2015 Ebony Nyenya. All rights reserved.
//

import UIKit

typealias ResponseBlock = (responseInfo: [String: AnyObject]) -> ()

let API_URL = "https://safe-sands-7813.herokuapp.com/"

class APIRequest {
    
    class func requestWithEndpoint(endpoint: String, verb: String, completion: ResponseBlock) {
        
        var options = [
            
            "endpoint": endpoint,
            "verb": verb,
            "body": [
                "user": ["authentication_token": UserSingleton.userData().token!]
            ]
            
            ] as [String: AnyObject]
        
        requestWithOptions(options, andCompletion: completion)
        
    }
    
    class func requestWithOptions(options: [String: AnyObject], andCompletion completion: ResponseBlock) {
        
        // endpoint
        if let url = NSURL(string: API_URL + (options["endpoint"] as String)) {
        
            // verb
            var request = NSMutableURLRequest(URL: url)
            request.HTTPMethod = options["verb"] as String
            
            // body
            let bodyInfo = options["body"] as [String:AnyObject]
            let requestData = NSJSONSerialization.dataWithJSONObject(bodyInfo, options: NSJSONWritingOptions.allZeros, error: nil)
            
            let jsonString = NSString(data: requestData!, encoding: NSUTF8StringEncoding)
            
            let postLength = "\(jsonString!.length)"
            
            request.setValue(postLength, forHTTPHeaderField: "Content-Length")
            
            let postData = jsonString?.dataUsingEncoding(NSASCIIStringEncoding, allowLossyConversion: true)
            
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            request.HTTPBody = postData
            
            NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) { (response, data, error) -> Void in
                
                if error == nil {
                    
                    // do something with data
                    
                    let json = NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers, error: nil) as [String: AnyObject]
                    
                    completion (responseInfo: json)
                    
                } else {
                    println(error)
                }
            }
        }
    }
}