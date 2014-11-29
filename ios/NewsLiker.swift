//
//  NewsLiker.swift
//  ios
//
//  Created by Alejandro Perezpaya on 29/11/14.
//  Copyright (c) 2014 vonsai. All rights reserved.
//

import UIKit
import AVFoundation

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
        api.getArticles(false, beacon: nil) {
            arts in
            self.articles = arts
            self.loadNextViewOrReloadSelf()
        }
    }
    
    func launchView() {
        var article = self.articles[self.articleCount]
        self.articleCategory?.text = article.category?.name
        self.articleShares?.text = article.shares
        self.articleContent?.text = article.subtitle
        self.articleContent?.textContainerInset = UIEdgeInsetsZero
        self.articleContent?.textContainer.lineFragmentPadding = 0
        self.articleTitle?.text = article.title
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "HH:mm dd-MM-yyyy"
        self.articleTime?.text = dateFormatter.stringFromDate(article.date!)
    }
    
    @IBAction func clickedLikeButton() {
        self.articleCount+=1
        self.playLikeSoundWithNumber(4)
        self.loadNextViewOrReloadSelf()
        self.likedArticle(true)
    }
    
    @IBAction func clickedCrossButton() {
        self.articleCount+=1
        self.loadNextViewOrReloadSelf()
        self.likedArticle(false)
    }
    
    func likedArticle (liked: Bool) {
        if self.articleCount >= self.articles.count {
            return
        }
        api.setArticle(self.articles[self.articleCount], save: liked)
        { (ok) -> () in
            if ok {
                println("Article set")
            }
        }
    }
    
    func loadNextViewOrReloadSelf () {
        println("\(self.articleCount) of \(self.articles.count)")
        if self.articleCount >= self.articles.count {
            self.tabBarController?.selectedIndex = 1
        } else {
            self.launchView()
        }
    }
    
    func playLikeSoundWithNumber (number: Int){
        if number == 1 {
            return
        }
        var soundURL = NSBundle.mainBundle().URLForResource("audio_like_\(number)", withExtension: "wav")
        var soundId: SystemSoundID = 0
        AudioServicesCreateSystemSoundID(soundURL, &soundId)
        AudioServicesPlaySystemSound(soundId)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}