//
//  WENormalNodeTableModel.swift
//  weToExplore
//
//  Created by Daniel Tan on 8/13/16.
//  Copyright © 2016 Gnodnate. All rights reserved.
//

import UIKit

class WENormalNodeTableModel: NSObject, UITableViewDataSource, UITableViewDelegate {
//    private weak var tableView:UITableView?
    
    weak var tableViewController:UITableViewController?
    
    fileprivate var nodeGroupArray:[WENodeGroup]? {
        didSet {
            tableViewController?.tableView.reloadData()
        }
    }
    
    lazy var topicListViewController:WETopicListTableViewController =
        UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TopListTableViewController") as! WETopicListTableViewController
    var nodeButtonSegue:UIStoryboardSegue {
        return UIStoryboardSegue(identifier: "showNodeTopics",source: self.tableViewController! , destination: topicListViewController) { [unowned self] in
            self.tableViewController?.show(self.topicListViewController, sender: self.tableViewController)
            self.topicListViewController.clearTableView()
            self.topicListViewController.pullRefreshManual()
        }
    }
    // MARK: - Reload the tableview
    func getNodes() {
        WENodeModel.getNode(true) { (nodeGroupArray) in
            self.nodeGroupArray = nodeGroupArray
        }
    }
    
    // MARK: - Config the cell
    fileprivate func configureCell(_ cell:WENodeCell, withIndexPath indexPath:IndexPath) -> Void {
        cell.nodeGroup = nodeGroupArray![(indexPath as NSIndexPath).section]
        cell.showNodeSegue = nodeButtonSegue
        
    }
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return nodeGroupArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NodeListCell", for: indexPath) as! WENodeCell
        configureCell(cell, withIndexPath: indexPath)
        cell.laoutButtons()
        return cell
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return nodeGroupArray?[section].Name ?? "Not Good"
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var originX:CGFloat = 10
        var originY:CGFloat = 10
        
        for nodeInfo in (nodeGroupArray?[(indexPath as NSIndexPath).section].nodeArray)! {
            let buttonWidth = UIButton.widthWithTitle(nodeInfo.title!, andFont: UIFont.systemFont(ofSize: NodeButtonFontSize))
            if buttonWidth+10+originX < screenWidth {
                originX += buttonWidth+10
            } else {
                originX = 10
                originY += 5+NodeButtonHeight
            }
        }
        
        return originY+NodeButtonHeight+5
    }
}
