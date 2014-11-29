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
    
    var article: Article?
    
    var webViewFont = "Helvetica Neue"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var html = article?.text
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
    
}
