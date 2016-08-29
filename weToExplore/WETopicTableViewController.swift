//
//  WETopicTableViewController.swift
//  weToExplore
//
//  Created by Daniel Tan on 8/22/16.
//  Copyright © 2016 Gnodnate. All rights reserved.
//

import UIKit
import MJRefresh


class WETopicTableViewController: UITableViewController {
    
    var topicDetail:WETopicDetail? {
        didSet {
            self.tableView.reloadData()
        }
    }
    var topicReplies = [WEReplyDetail]() {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    var topicID:Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // hide footer
        self.tableView.tableFooterView = UIView()
        
        // cell height auto calculate
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        // disable select highlight
        self.tableView.allowsSelection = false
        
        self.tableView.mj_header =
            MJRefreshNormalHeader(refreshingBlock: { [unowned self] in

                WEDataManager.getJSON("api/topics/show.json",
                    parameters: ["id" : self.topicID!],
                block: true) { [unowned self] (responeData) in
                    self.topicDetail = WETopicDetail(dic: responeData.first!)
                    self.tableView.mj_header.endRefreshing()
                }
                WEDataManager.getJSON("api/replies/show.json",
                    parameters: ["topic_id" : self.topicID!],
                block: true) { [unowned self] (responeData) in
                    self.topicReplies.removeAll()
                    for reply in responeData {
                        self.topicReplies.append(WEReplyDetail(reply))
                    }
                }
                
            })
        
        self.tableView.mj_header.beginRefreshing()
        

            // Uncomment the following line to preserve selection between presentations
            self.clearsSelectionOnViewWillAppear = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return self.topicDetail != nil ? 1 : 0
        } else {
            return self.topicReplies.count ?? 0
        }
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var returnCell:UITableViewCell? = nil
        if indexPath.section == 0 {
            if let cell = tableView.dequeueReusableCellWithIdentifier("TopicManBody")  as? WETopicMainBodyTableViewCell {
                if self.topicDetail != nil {
                    cell.topicDetail = self.topicDetail
                }
                returnCell = cell
            }
        } else {
            if let cell = tableView.dequeueReusableCellWithIdentifier("TopicReply")  as? WETopicReplyTableViewCell {
                cell.replyDetail = self.topicReplies[indexPath.row]
                returnCell = cell
            }
        }
        return returnCell!
    }

    override func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if 0 == indexPath.section {
            return 100
        }
        return 50
    }
}
