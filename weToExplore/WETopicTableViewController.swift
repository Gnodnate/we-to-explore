//
//  WETopicTableViewController.swift
//  weToExplore
//
//  Created by Daniel Tan on 8/22/16.
//  Copyright © 2016 Gnodnate. All rights reserved.
//

import UIKit

class WETopicTableViewController: UITableViewController {
    
    var topicDetail:WETopicDetail?
    var topicReplies:[WEReplyDetail]?
    
    var topicID:Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // hide footer
        self.tableView.tableFooterView = UIView()
        
        // 
        self.tableView.rowHeight = UITableViewAutomaticDimension
        

        WEDataManager.getJSON("api/topics/show.json",
                              parameters: ["id" : topicID!],
                              block: true) { (responeData) in
                                self.topicDetail = WETopicDetail(dic: responeData.first!)
                                self.tableView.reloadData()
        }
        WEDataManager.getJSON("api/replies/show.json",
                              parameters: ["topic_id" : topicID!],
                              block: true) { (responeData) in
                                self.topicReplies = [WEReplyDetail]()
                                for reply in responeData {
                                    self.topicReplies?.append(WEReplyDetail(reply))
                                }
                                self.tableView.reloadData()
        }
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
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
            return self.topicReplies?.count ?? 0
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
                cell.replyDetail = self.topicReplies![indexPath.row]
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

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
