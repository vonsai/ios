//
//  ArticleView.swift
//  ios
//
//  Created by Alejandro Perezpaya on 29/11/14.
//  Copyright (c) 2014 vonsai. All rights reserved.
//

import UIKit

class ArticleView: UIViewController {
    
    @IBOutlet var webView: UIWebView?
    @IBOutlet var imageView: UIImageView?
    @IBOutlet var titleLabel: UILabel?
    
    var article: Article?
    
    var webViewFont = "Helvetica"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var html = article?.text
        titleLabel?.text = article?.title
        if self.article != nil {
            if self.article?.imageURL != nil {
                dispatch_async(dispatch_get_main_queue(), {
                    var urlString = self.article?.imageURL!
                    var url = NSURL(string: urlString!)
                    var data = NSData(contentsOfURL: url!)
                    self.imageView?.image = UIImage(data: data!)
                })
            }
        }

        self.webView?.loadHTMLString(html, baseURL: nil)
        self.navigationController?.navigationBarHidden = true
        webView?.stringByEvaluatingJavaScriptFromString("document.body.style.fontFamily = '\(webViewFont)'")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func popView () {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func shareView (){
        let firstActivityItem = "\(self.article!.title) via @elmundoes #bonsai #theapproom"
        let activityViewController : UIActivityViewController = UIActivityViewController(activityItems: [firstActivityItem], applicationActivities: nil)
        self.presentViewController(activityViewController, animated: true, completion: nil)
    }
    
}
