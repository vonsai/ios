//
//  Api.swift
//  ios
//
//  Created by Jorge Izquierdo on 25/11/14.
//  Copyright (c) 2014 vonsai. All rights reserved.
//

import Foundation

class Api {
    
    let apiKey: String = "Test Api Key"
    let apiSecret: String = "Test Api Secret"
    let apiBase: String = "http://172.20.10.2:5000/api"
    
    var accessToken: String? {
        didSet {
            NSUserDefaults.standardUserDefaults().setObject(accessToken, forKey: "accessToken")
        }
    }
    var authenticated: Bool {
        get {
            return accessToken != nil
        }
    }
    
    init() {
        accessToken = NSUserDefaults.standardUserDefaults().stringForKey("accessToken")
        println("my access \(accessToken)")
    }
    
    func signedRequest(method: Method, path: String, parameters: Dictionary<String, String>, callback: (JSON, NSError?)->()){
        
        let timestamp: String = String(Int(NSDate().timeIntervalSince1970))
        var token: String = ""
        if let access = accessToken {
            token = access
        }
        
        Manager.sharedInstance.session.configuration.HTTPAdditionalHeaders = ["X-Api-Timestamp": timestamp, "X-Api-Key": apiKey, "X-Api-Signature": requestSignature(timestamp), "X-Api-Token":token]
        
        request(method, "\(self.apiBase)\(path)", parameters: parameters, encoding: .JSON).responseSwiftyJSON { (_, _, json, error) -> Void in
            
           callback(json, error)
        }
    }
    
    
    func auth(cb: (auth: Bool, hasSetCategories: Bool)->()) {
        
        var body = ["uuid": uuid()]
        signedRequest(.POST, path: "/auth", parameters: body) { (j, e) -> () in
            if (e != nil && j["token"]["token"] != nil)  {
                println("ERROR: \(e)")
            } else {
                
                self.accessToken = j["token"]["token"].string!
                if let hasSet = j["hasSetCategories"].bool {
                    cb (auth: true, hasSetCategories:hasSet)
                }
            }
            
        }
        
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
