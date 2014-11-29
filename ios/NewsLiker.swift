//
//  NewsLiker.swift
//  ios
//
//  Created by Alejandro Perezpaya on 29/11/14.
//  Copyright (c) 2014 vonsai. All rights reserved.
//

import UIKit

class NewsLiker: UIViewController {
    let beacon = Beacons()
    let api = Api()
    var articles = [Article]()
    
    @IBOutlet var articleTitle: UILabel?
    @IBOutlet var articleTime: UILabel?
    
    @IBOutlet var articleContent: UITextView?
    @IBOutlet var articleShares: UILabel?
    @IBOutlet var articleCategory: UILabel?
    

    var articleCount: Int = 0
    
    override func shouldAutorotate() -> Bool {
        return false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 242, green: 200, blue: 200, alpha: 1)
        self.loadArticles()
        //self.beacons()
    }
    func beacons() {
        beacon.start {
            (bId) in
            self.api.getArticles(false, beacon: bId) {
                (arts) -> () in
                println(arts[0].title)
            }
        }
    }
    func loadArticles(){
        if self.articleCount < self.articles.count {
            return launchView()
        }
        
        api.getArticles(false, beacon: nil) {
            arts in
            self.articleCount = 0
            self.articles = arts
            self.launchView()
            for a in arts {
               
            }
        }
    }
    
    func launchView() {
        var article = self.articles[self.articleCount]
        self.articleCategory?.text = article.category?.name
        self.articleShares?.text = article.shares
        self.articleContent?.text = article.description
        self.articleTitle?.text = article.title
    }
    
    @IBAction func clickedLikeButton() {
        self.articleCount+=1
        self.loadArticles()
    }
    
    @IBAction func clickedCrossButton() {
        self.articleCount+=1
        self.loadArticles()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}