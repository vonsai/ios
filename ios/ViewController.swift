//
//  ViewController.swift
//  ios
//
//  Created by Jorge Izquierdo on 25/11/14.
//  Copyright (c) 2014 vonsai. All rights reserved.
//

import UIKit
import QuartzCore

class ViewController: UIViewController {
    
    @IBOutlet var categoryBackgroundImage: UIImageView?
    @IBOutlet var categoryLikeImageView: UIImageView?
    @IBOutlet var categoryNameLabel: UILabel?
    
    @IBOutlet var backButton: UIButton?
    
    let api = Api()
    let beacon = Beacons()
    var categories: [Category]?
    var categoryCount: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        beacon.start()
        self.loadCategories()
        
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
        if api.isAuthenticated && !NSUserDefaults.standardUserDefaults().boolForKey("setCategories"){
            api.getCategories { (cats) -> () in
                self.categories = cats
                println(cats)
                self.launchView()
            }
        } else {
            api.auth {
                (auth, hasSet) in
                if !hasSet {
                    self.loadCategories()
                } else {
                    println("NO CARGO OSTIAS")
                }
            }
        }
    }
    
    func launchView() {
        self.shouldShowBackItem()
        if let cats = self.categories {
            var category = cats[self.categoryCount]
            
            var trans = CATransition()
            trans.duration = 0.4
            trans.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
            trans.type = kCATransitionFade
            categoryBackgroundImage!.layer.addAnimation(trans, forKey:nil)
            categoryNameLabel!.layer.addAnimation(trans, forKey: nil)
            
            self.categoryNameLabel?.text = category.name
            var bgImage = UIImage(named: "category_\(category.name.lowercaseString)")
            if bgImage != nil {
                
                categoryBackgroundImage!.image = bgImage
            }
            var likeStep = self.convertValueToLikeStep(category.value)
            var likeImage = UIImage(named: "lovecircle_\(likeStep).png")
            self.categoryLikeImageView?.image = likeImage?
        }
    }
    
    func shouldShowBackItem() {
        if categoryCount == 0 {
            self.backButton?.hidden = true
        } else {
            self.backButton?.hidden = false
        }
        
    }
    
    func convertValueToLikeStep (value: Float) -> Int {
        return Int(value * 5.0)
    }
    
    @IBAction func clickedLikeButton() {
        if let cats = self.categories {
            
            var category = cats[self.categoryCount]
            category.value += 0.2
            if category.value > 1 {
                category.value = 0.2
            }
            changeLikeImageWithValue(category.value)
        }
    }
    
    func changeLikeImageWithValue (value: Float) {
        var likeStep = convertValueToLikeStep(value)
        var likeImage = UIImage(named: "lovecircle_\(likeStep).png")
        self.categoryLikeImageView?.image = likeImage?
    }
    
    @IBAction func clickedNextButton (){
        if self.categoryCount+1 >= self.categories?.count {
            api.postCategories(self.categories!, cb: { (ok) -> () in
                
                if ok {
                    NSUserDefaults.standardUserDefaults().setBool(true, forKey: "setCategories")
                    println("everything is good bro")
                }
                
            })
        } else {
            self.categoryCount += 1
            self.launchView()
        }
    }
    
    @IBAction func clickedBackButton (){
        self.categoryCount -= 1
        self.launchView()
    }

}

