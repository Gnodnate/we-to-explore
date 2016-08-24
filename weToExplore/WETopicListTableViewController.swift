//
//  WETopicListTableViewController.swift
//  weToExplore
//
//  Created by Daniel Tan on 8/20/16.
//  Copyright © 2016 Gnodnate. All rights reserved.
//

import UIKit
import SDWebImage

func _L(aString:String) -> String {
    return NSLocalizedString(aString, comment: aString)
}

class WETopicListTableViewController: UITableViewController {

    var nodeID:String = "all"
    
    var topicArray:[WETopicDetail]? {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    var viewModel:WETopicListViewModel {
        let model = WETopicListViewModel()
        model.topicsDidChange =  { model in
            self.topicArray = model.topics
            self.tableView.reloadData()
            self.refreshControl?.endRefreshing()
        }
        return model
    }
    
    @IBAction func showUser(sender: UIButton) {
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // hide the footer
        self.tableView.tableFooterView = UIView()
        
        // auto height
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 50.0

        let pullRefreshController = UIRefreshControl()
        pullRefreshController.addTarget(self, action: #selector(pullRefresh), forControlEvents: UIControlEvents.ValueChanged)
        pullRefreshController.attributedTitle = NSAttributedString(string: "下拉刷新")
        self.refreshControl = pullRefreshController
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.topicArray?.count ?? 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("topicCellID") as! WETopicTableViewCell
        if let topicInfo = self.topicArray?[indexPath.row] {
            cell.userImage.sd_setImageWithURL(topicInfo.avaterImageURL, placeholderImage: UIImage(named: "default"))
            cell.userName.setTitle(topicInfo.avaterName, forState: .Normal)
            cell.nodeName.setTitle(topicInfo.nodeName, forState: .Normal)
            cell.replyTime.text = "\(topicInfo.replyTime)"
            cell.topicTitle.text = topicInfo.title
            cell.ID = topicInfo.ID
        }
        return cell
    }
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 134
    }
    
    // MARK: -Refresh action
    func pullRefresh() {
        viewModel.showTopics(self.nodeID)
    }
    
    func pullRefreshManual() {
        refreshControl?.beginRefreshing()
        viewModel.showTopics(self.nodeID)
    }
    
    // MARK: segue
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let destVC = segue.destinationViewController as? WETopicTableViewController {
            if let senderView = sender as? WETopicTableViewCell {
                destVC.topicID = senderView.ID
            }
        }
    }
}
