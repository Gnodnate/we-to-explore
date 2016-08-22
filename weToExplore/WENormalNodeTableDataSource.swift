//
//  WENormalNodeTableDataSource.swift
//  weToExplore
//
//  Created by Daniel Tan on 8/13/16.
//  Copyright © 2016 Gnodnate. All rights reserved.
//

import UIKit

class WENormalNodeTableDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {
//    private weak var tableView:UITableView?
    
    var exitSegue:UIStoryboardSegue?
    
    var nodeDic:NSDictionary {
        get {
            let infoPath = NSBundle.mainBundle().pathForResource("nodes", ofType: "plist", inDirectory: nil, forLocalization: nil)
            return NSDictionary(contentsOfFile: infoPath!)!;
        }
    }

//    required init(exitSegue:UIStoryboardSegue) {
//        super.init()
//        self.exitSegue = exitSegue
//    }
    
    // MARK: - Config the cell
    func configureCell(cell:WENodeCell, withIndexPath indexPath:NSIndexPath) -> Void {
        let key = nodeDic.allKeys[indexPath.section] as! String
        cell.nodeInfo = (nodeDic[key] as! [String:String])
        cell.exitSegue = self.exitSegue
        
    }
    // MARK: - Table view data source
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return nodeDic.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("nodeCell", forIndexPath: indexPath) as! WENodeCell
        configureCell(cell, withIndexPath: indexPath)
        cell.laoutButtons()
        return cell
    }

    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return nodeDic.allKeys[section] as? String
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        var originX:CGFloat = 10
        var originY:CGFloat = 10
        
        let key = nodeDic.allKeys[indexPath.section] as! String
        let nodeInfoDic = nodeDic.objectForKey(key) as! [String:String]
        for nodeInfo in nodeInfoDic {
            let buttonWidth = UIButton.widthWithTitle(nodeInfo.1, andFont: UIFont.systemFontOfSize(NodeButtonFontSize))
            if buttonWidth+10+originX < UIScreen.mainScreen().bounds.size.width {
                originX += buttonWidth+10
            } else {
                originX = 10
                originY += 5+NodeButtonHeight
            }
        }
        
        return originY+NodeButtonHeight+5
    }
}
