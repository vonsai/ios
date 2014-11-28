//
//  ViewController.swift
//  ios
//
//  Created by Jorge Izquierdo on 25/11/14.
//  Copyright (c) 2014 vonsai. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var categoryBackgroundImage: UIImageView?
    @IBOutlet var categoryLikeImageView: UIImageView?
    @IBOutlet var categoryNameLabel: UILabel?
    
    @IBOutlet var backButton: UIButton?
    
    let api = Api()
    
    var categories: [Category]?
    var categoryCount: Int = 0
    
    override func viewDidLoad() {
        self.loadCategories()
        if categoryCount == 0 {
            self.backButton?.hidden = true
        }
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func shouldAutorotate() -> Bool {
        return false
    }
    
    func loadCategories() {
        api.getCategories { (cats) -> () in
            self.categories = cats
            self.launchView()
        }
    }
    
    func launchView() {
        if let cats = self.categories {
            var category = cats[self.categoryCount]
            self.categoryNameLabel?.text = category.name
            var likeStep = self.convertValueToLikeStep(category.value)
            var likeImage = UIImage(named: "lovecircle_\(likeStep).png")
            self.categoryLikeImageView?.image = likeImage?
        }
    }
    
    func convertValueToLikeStep (value: Float) -> Int {
        return Int(value * 5)
    }
    
    @IBAction func clickedLikeButton() {
        if let cats = self.categories {
            println("HOLA MIRA")
            var category = cats[self.categoryCount]
            category.value *= 2
            if category.value > 1 {
                category.value = 0.2
            }
        }
    }
    
    func changeLikeImageWithValue (value: Float) {
        var likeStep = convertValueToLikeStep(value)
        var likeImage = UIImage(named: "lovecircle_\(likeStep).png")
        self.categoryLikeImageView?.image = likeImage?
    }
    


}

