//
//  WENormalNodeTableDataSource.swift
//  weToExplore
//
//  Created by Daniel Tan on 8/13/16.
//  Copyright © 2016 Gnodnate. All rights reserved.
//

import UIKit

class WENormalNodeTableDataSource: NSObject, UITableViewDataSource {
    private weak var tableView:UITableView?
    
    lazy var dataManager = {
        return WEDataManager()
    }()
    
    var nodeDic:NSDictionary {
        get {
            let infoPath = NSBundle.mainBundle().pathForResource("nodes", ofType: "plist", inDirectory: nil, forLocalization: nil)
            return NSDictionary(contentsOfFile: infoPath!)!;
        }
    }

    required init(tableview:UITableView) {
        super.init()
        self.tableView = tableview
        self.tableView?.dataSource = self
    }
    
    // MARK: - Config the cell
    func configureCell(cell:WENodeCell, withIndexPath indexPath:NSIndexPath) -> Void {
        let key = nodeDic.allKeys[indexPath.section] as! String
        cell.nodeNameArray = (nodeDic[key] as? NSDictionary)?.allKeys as! [String]
        
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
}
