//
//  NewsLiker.swift
//  ios
//
//  Created by Alejandro Perezpaya on 29/11/14.
//  Copyright (c) 2014 vonsai. All rights reserved.
//

import UIKit

class NewsLiker: UIViewController {

    let api = Api()
    
    var categories: [Category]?
    var categoryCount: Int = 0
    
    override func shouldAutorotate() -> Bool {
        return false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 242, green: 242, blue: 242, alpha: 1)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}