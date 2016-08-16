//
//  WEAllNodeTableViewController.swift
//  weToExplore
//
//  Created by Daniel Tan on 8/12/16.
//  Copyright © 2016 Gnodnate. All rights reserved.
//

import UIKit

class WENormalNodeListTableViewController: UITableViewController {
    
//    lazy var showRootViewSegue =  {
//        return UIStoryboardSegue(identifier: "ReturnToRootView",
//                                 source: self,
//                                 destination: (self.navigationController?.presentingViewController)!)
//    }()

    var dataSource:WENormalNodeTableDataSource! {
        didSet {
            self.tableView.dataSource = dataSource
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = WENormalNodeTableDataSource()
        let rootViewController = (self.navigationController?.presentingViewController as! UINavigationController).topViewController!
        dataSource.exitSegue = UIStoryboardSegue(identifier: "ReturnToRootView",
                                                 source: self,
                                                 destination:rootViewController,
                                                 performHandler: {[unowned self] in
                                                    self.dismissViewControllerAnimated(true, completion: {
                                                        (rootViewController as! WERootViewController).pullToRefresh(nil)
                                                    })
        })
        // Hide unsed cell
        let view = UIView()
        view.backgroundColor = UIColor.clearColor()
        self.tableView.tableFooterView = view
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        print("%@", segue.identifier)
    }

}
