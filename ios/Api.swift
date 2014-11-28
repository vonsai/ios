//
//  Api.swift
//  ios
//
//  Created by Jorge Izquierdo on 25/11/14.
//  Copyright (c) 2014 vonsai. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class Api {
    
    let apiKey: String = "Test Api Key"
    let apiSecret: String = "Test Api Secret"
    let apiBase: String = "http://localhost:5000/api"
    
    var accessToken: String?
    var authenticated: Bool {
        get {
            return accessToken != nil
        }
    }
    
    init() {
        accessToken = NSUserDefaults.standardUserDefaults().stringForKey("accessToken")
    }
    
    func signedRequest(method: Alamofire.Method, path: String, parameters: Dictionary<String, String>, callback: ()->(SwiftyJSON.JSON)){
        
        let timestamp: String = String(Int(NSDate().timeIntervalSince1970))
        var token: String = ""
        if let access = accessToken {
            token = access
        }
        
        Alamofire.Manager.sharedInstance.session.configuration.HTTPAdditionalHeaders = ["X-Api-Timestamp": timestamp, "X-Api-Key": apiKey, "X-Api-Signature": requestSignature(timestamp), "X-Api-Token":token]
        
        Alamofire.request(method, path, parameters: parameters, encoding: .JSON).responseSwiftyJSON { (req, response, json, error) -> Void in
            
            println(json)
        }
    }
    
    func auth() {
        
        
    }
    func requestSignature(timestamp: String) -> String {
        
        //String(Int(NSDate().timeIntervalSince1970))
        return "\(self.apiSecret) \(timestamp)".sha1()
    }
    
    
}

func uuid() -> String {
    
    //TODO: Don't fake it
    return "holas"
}

extension String {
    func sha1() -> String {
        let data = self.dataUsingEncoding(NSUTF8StringEncoding)!
        var digest = [UInt8](count:Int(CC_SHA1_DIGEST_LENGTH), repeatedValue: 0)
        CC_SHA1(data.bytes, CC_LONG(data.length), &digest)
        let output = NSMutableString(capacity: Int(CC_SHA1_DIGEST_LENGTH))
        for byte in digest {
            output.appendFormat("%02x", byte)
        }
        return output
    }
}
