//
//  WETopicListTableViewController.swift
//  weToExplore
//
//  Created by Daniel Tan on 8/20/16.
//  Copyright © 2016 Gnodnate. All rights reserved.
//

import UIKit
import SDWebImage
import MJRefresh


func _L(_ aString:String) -> String {
    return NSLocalizedString(aString, comment: aString)
}

class WETopicListTableViewController: UITableViewController {

    var nodeName:String = "all"
    
    var topicArray:[WETopicDetail]? {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    var viewModel:WETopicListViewModel {
        let model = WETopicListViewModel()
        model.topicsDidChange =  { model in
            self.topicArray = model.topics
            self.tableView.mj_header.endRefreshing()
        }
        return model
    }
    
    @IBAction func showUser(_ sender: UIButton) {
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.clearsSelectionOnViewWillAppear = true

        // hide the footer
        self.tableView.tableFooterView = UIView()
        
        // auto height
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 50.0

        let header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(pullRefresh))
        header?.setTitle(_L("Pull down to refresh"), for: MJRefreshState.idle)
        header?.setTitle(_L("Refreshing"), for: .refreshing)
        self.tableView.mj_header = header
        
        self.tableView.mj_header.beginRefreshing()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.topicArray?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "topicCellID") as! WETopicTableViewCell
        if let topicInfo = self.topicArray?[(indexPath as NSIndexPath).row] {
            cell.userImage.sd_setImage(with: topicInfo.avaterImageURL, placeholderImage: UIImage(named: "default"))
            cell.userName.setTitle(topicInfo.avaterName, for: UIControlState())
            cell.nodeName.nodeInfo = WENode(Title: topicInfo.nodeTitle, Name: topicInfo.nodeName)
            cell.nodeName.setTitle(topicInfo.nodeTitle, for: UIControlState())
            cell.nodeName.addTarget(self, action:#selector(switchNode(_:)) , for: UIControlEvents.touchUpInside)
            cell.replyTime.text = topicInfo.lastTouchTime
            cell.topicTitle.text = topicInfo.title
            cell.ID = topicInfo.ID
        }
        return cell
    }
    
    // MARK: -Refresh action
    func pullRefresh() {
        viewModel.showTopics(self.nodeName)
    }
    
    func pullRefreshManual() {
        if !self.tableView.mj_header.isRefreshing() {
            self.tableView.mj_header.beginRefreshing()
            viewModel.showTopics(self.nodeName)
        }
    }
    
    // MARK: - clear tableview
    func clearTableView() {
        self.topicArray?.removeAll()
    }
    
    // MARK: - switch node
    func switchNode(_ nodeButton:UIButton) {
        if self.parent is WETwoScrollViewController {
            if nil != nodeButton.nodeInfo {
                let topicListViewController:WETopicListTableViewController =
                    UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TopListTableViewController") as! WETopicListTableViewController
                
                topicListViewController.nodeName = (nodeButton.nodeInfo?.name)!
                topicListViewController.title = nodeButton.nodeInfo?.title
                self.navigationController?.pushViewController(topicListViewController, animated: true)
            }
        }
    }
    
    // MARK: segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destVC = segue.destination as? WETopicTableViewController {
            if let senderView = sender as? WETopicTableViewCell {
                destVC.topicID = senderView.ID
            }
        }
    }
}
