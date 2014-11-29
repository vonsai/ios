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
        self.webView?.loadHTMLString(html, baseURL: nil)
        self.navigationController?.navigationBarHidden = true
        webView?.stringByEvaluatingJavaScriptFromString("document.body.style.fontFamily = '\(webViewFont)'")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
