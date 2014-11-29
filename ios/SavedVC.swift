//
//  SavedVC.swift
//  ios
//
//  Created by Jorge Izquierdo on 29/11/14.
//  Copyright (c) 2014 vonsai. All rights reserved.
//

import UIKit

class SavedVC: UITableViewController {
    let kCellIdentifier = "celll"
    
    var articles = [Article]()
    var api = Api()
    
    override func shouldAutorotate() -> Bool {
        return false
    }
    
    override func viewDidLoad() {
        self.title = "Archive"
        super.viewDidLoad()
        self.loadArticles()
        //self.beacons()
    }

    func loadArticles(){
        api.getArticles(true, beacon: nil) {
            arts in
            println("got em\(arts.count)")
            self.articles = arts
            self.tableView.reloadData()
        }
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell: UITableViewCell? = tableView.dequeueReusableCellWithIdentifier(kCellIdentifier) as UITableViewCell?
        if (cell == nil) {
            
            cell = UITableViewCell(style: .Default, reuseIdentifier: kCellIdentifier)
        }
        
        var article = self.articles[indexPath.row]
        cell!.textLabel.text = article.title
        cell!.detailTextLabel?.text = article.category?.name
        cell!.tag = indexPath.row
        
        return cell!
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var vc = segue.destinationViewController as ArticleView
        vc.article = self.articles[sender!.tag]
    }
}