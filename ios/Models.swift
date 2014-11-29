//
//  Models.swift
//  ios
//
//  Created by Jorge Izquierdo on 28/11/14.
//  Copyright (c) 2014 vonsai. All rights reserved.
//

import UIKit

class Category {
    let id: String?
    let name: String
    let color: UIColor?
    let imageURL: String?
    
    var value: Float
    
    init(data: AnyObject) {
        self.name = data["name"] as String
        self.value = 0
        if let v = (data["value"] as Float?) {
            self.value = v
        }
        self.id = data["id"] as String?
        if let c = (data["color"] as String?){
            var comps = c.componentsSeparatedByString(".")
            
            let r = CGFloat((comps[0].stringByReplacingOccurrencesOfString(",", withString: ".") as NSString).floatValue)
            let g = CGFloat((comps[1].stringByReplacingOccurrencesOfString(",", withString: ".") as NSString).floatValue)
            let b = CGFloat((comps[2].stringByReplacingOccurrencesOfString(",", withString: ".") as NSString).floatValue)
            
            self.color = UIColor(red: r, green: g, blue: b, alpha: 1)
        }
    }
}

class Article {
    let id: String
    let title: String
    let subtitle: String?
    let description: String?
    let text: String
    let imageURL: String?
    let shares: String?
    let stats: Stats?
    let category: Category?
    let date: NSDate?
    let ts: NSTimeInterval?
    
    init(data: AnyObject) {
        
        self.id = data["id"] as String
        self.title = data["title"] as String
        self.subtitle = data["subtitle"] as String?
        self.description = data["description"] as String?
        self.text = data["text"] as String
        self.imageURL = data["imageURL"] as String?
        self.shares = data["shares"] as String?
        
        self.ts = data["timestamp"] as NSTimeInterval?
        
        if let stats: AnyObject? = data["stats"] {
            self.stats = Stats(data: stats!)
        }
        if let cat: AnyObject? = data["category"] {
            self.category = Category(data: cat!)
        }
        
        self.date = NSDate(timeIntervalSince1970: self.ts!)
        
    }
}

class Stats {
    let saved: Int
    let readingTime: Int
    
    init(data: AnyObject) {
        self.saved = data["saved"] as Int
        self.readingTime = data["readingTime"] as Int
    }
}