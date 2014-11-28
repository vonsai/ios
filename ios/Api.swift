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
    let apiBase: String = "http://localhost:5000/api"
    
    var accessToken: String? {
        didSet {
            NSUserDefaults.standardUserDefaults().setObject(accessToken, forKey: "accessToken")
        }
    }
    var isAuthenticated: Bool {
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
        
        if method == .GET {
            
            request(.GET, "\(self.apiBase)\(path)").responseSwiftyJSON { (_, _, json, error) -> Void in
                
                callback(json, error)
            }

        } else {
            
            request(method, "\(self.apiBase)\(path)", parameters: parameters, encoding: .JSON).responseSwiftyJSON { (_, _, json, error) -> Void in
                
                callback(json, error)
            }
        }
    }
    func requestSignature(timestamp: String) -> String {
        
        //String(Int(NSDate().timeIntervalSince1970))
        return "\(self.apiSecret) \(timestamp)".sha1()
    }
    
    
}

// MARK: AUTH
extension Api {
    func auth(cb: (auth: Bool, hasSetCategories: Bool)->()) {
        
        var body = ["uuid": uuid()]
        signedRequest(.POST, path: "/auth", parameters: body) { (j, e) -> () in
            if e != nil || j["token"]["token"].string == nil {
                println("ERROR: \(e)")
            } else {
                
                self.accessToken = j["token"]["token"].string!
                if let hasSet = j["hasSetCategories"].bool {
                    cb (auth: true, hasSetCategories:hasSet)
                }
            }
        }
    }
}

// MARK: CATEGORIES
extension Api {
    
    func getCategories(cb: ([Category]) -> ()){
    
        signedRequest(.GET, path:"/categories", parameters: Dictionary<String, String>()){ (j, e) -> () in
            
            if e != nil || j["categories"].arrayObject == nil {
                println("ERROR: \(e)")
                
            } else {
                
                var cats = [Category]()
                for cat in j["categories"].arrayObject! {
                    
                    cats.append(Category(data: cat))
                }
                
                cb(cats)
            }
        }
    }
    
    /*func postCategories(categories: [Category], (ok: Bool)->()){
        
        var json = [Dictionary<String, String>]
        for c in categories {
            
            
        }
        
        signedRequest(.POST, path: "/categories", parameters: , callback: <#(JSON, NSError?) -> ()##(JSON, NSError?) -> ()#>)
    }*/
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
