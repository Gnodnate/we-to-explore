//
//  WETopicTableViewController.swift
//  weToExplore
//
//  Created by Daniel Tan on 8/22/16.
//  Copyright © 2016 Gnodnate. All rights reserved.
//

import UIKit
import MJRefresh
import Alamofire

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
    
    var requestArray = [Request]()

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

                let topicRequest = WEDataManager.getJSON("api/topics/show.json", //topic
                    parameters: ["id" : self.topicID! as AnyObject],
                block: true) { [unowned self] (responeData) in
                    self.topicDetail = WETopicDetail(dic: responeData.first!)
                    
                    let repliesRequest = WEDataManager.getJSON("api/replies/show.json", // replies
                        parameters: ["topic_id" : self.topicID! as AnyObject],
                    block: true) { [unowned self] (responeData) in
                        self.topicReplies.removeAll()
                        for reply in responeData {
                            self.topicReplies.append(WEReplyDetail(reply))
                        }
                        self.tableView.mj_header.endRefreshing()
                    }
                    self.requestArray.append(repliesRequest)
                }
                self.requestArray.append(topicRequest)
            })
        
        self.tableView.mj_header.beginRefreshing()
        
        // Uncomment the following line to preserve selection between presentations
        self.clearsSelectionOnViewWillAppear = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        for request in requestArray {
            request.task?.cancel()
        }
        requestArray.removeAll()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2 // one for context, and one for replies
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return self.topicDetail != nil ? 1 : 0
        } else {
            return self.topicReplies.count ?? 0
        }
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var returnCell:UITableViewCell? = nil
        if (indexPath as NSIndexPath).section == 0 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "TopicManBody")  as? WETopicMainBodyTableViewCell {
                if self.topicDetail != nil {
                    cell.topicDetail = self.topicDetail
                }
                returnCell = cell
            }
        } else {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "TopicReply")  as? WETopicReplyTableViewCell {
                cell.replyDetail = self.topicReplies[(indexPath as NSIndexPath).row]
                returnCell = cell
            }
        }
        return returnCell!
    }

    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        if 0 == (indexPath as NSIndexPath).section {
            return 100
        }
        return 50
    }
}
