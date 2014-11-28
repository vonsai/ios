//
//  Api.swift
//  ios
//
//  Created by Jorge Izquierdo on 25/11/14.
//  Copyright (c) 2014 vonsai. All rights reserved.
//

import Foundation
import Alamofire

class Api {
    
    let apiKey: String = "Test Api Key"
    let apiSecret: String = "Test Api Secret"
    
    var accessToken: String?
    var authenticated: Bool {
        get {
            return accessToken != nil
        }
    }
    
    init() {
        accessToken = NSUserDefaults.standardUserDefaults().stringForKey("accessToken")
    }
    
    func signedRequest(method: Method, path: String, callback: ()->()){
        
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
