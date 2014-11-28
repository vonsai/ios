//
//  Models.swift
//  ios
//
//  Created by Jorge Izquierdo on 28/11/14.
//  Copyright (c) 2014 vonsai. All rights reserved.
//

import UIKit

class Category {
    let name: String
    let color: UIColor?
    let imageURL: String?
    
    var value: Float
    
    init(name:String, value: Float) {
        self.name = name
        self.value = value
    }
}