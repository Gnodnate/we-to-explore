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
    
    var tableView:UITableView?
    var nodeButtonSegue:UIStoryboardSegue?
    
    private var nodeGroupArray:[WENodeGroup]? {
        didSet {
            tableView!.reloadData()
        }
    }
    
    // MARK: - Reload the tableview
    func getNodes() {
        WENodeModel.getNode(true) { (nodeGroupArray) in
            self.nodeGroupArray = nodeGroupArray
        }
    }
    
    // MARK: - Config the cell
    private func configureCell(cell:WENodeCell, withIndexPath indexPath:NSIndexPath) -> Void {
        cell.nodeGroup = nodeGroupArray![indexPath.section]
        cell.exitSegue = self.nodeButtonSegue
        
    }
    // MARK: - Table view data source
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return nodeGroupArray?.count ?? 0
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("NodeListCell", forIndexPath: indexPath) as! WENodeCell
        configureCell(cell, withIndexPath: indexPath)
        cell.laoutButtons()
        return cell
    }

    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return nodeGroupArray?[section].Name ?? "Not Good"
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        var originX:CGFloat = 10
        var originY:CGFloat = 10
        
        for nodeInfo in (nodeGroupArray?[indexPath.section].nodeArray)! {
            let buttonWidth = UIButton.widthWithTitle(nodeInfo.title!, andFont: UIFont.systemFontOfSize(NodeButtonFontSize))
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
