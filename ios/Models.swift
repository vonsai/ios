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