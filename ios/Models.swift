//
//  Models.swift
//  ios
//
//  Created by Jorge Izquierdo on 28/11/14.
//  Copyright (c) 2014 vonsai. All rights reserved.
//

import UIKit

class Category {
    let id: String
    let name: String
    let color: UIColor?
    let imageURL: String?
    
    var value: Float
    
    init(data: AnyObject) {
        self.name = data["name"] as String
        self.value = data["value"] as Float
        self.id = data["id"] as String
    }
}

class Article {
    let id: String
    let title: String
    let subtitle: String
    let description: String?
    let text: String
    let imageURL: String?
    let stats: Stats?
    
    init(data: AnyObject) {
        
        self.id = data["id"] as String
        self.title = data["title"] as String
        self.subtitle = data["subtitle"] as String
        self.description = data["description"] as String?
        self.text = data["text"] as String
        self.imageURL = data["imageURL"] as String?
        
        if let stats: AnyObject? = data["stats"] {
            self.stats = Stats(data: stats!)
        }
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