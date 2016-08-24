//
//  WERootViewController.swift
//  weToExplore
//
//  Created by Daniel Tan on 8/19/16.
//  Copyright © 2016 Gnodnate. All rights reserved.
//

import UIKit

func _keyAndName( key:String ) -> (String, String) {
    return (key, NSLocalizedString(key, comment: ""))
}

let defaultNodes:[String:String] = {
    return Dictionary(dictionaryLiteral:_keyAndName("tech"),
                      _keyAndName("creative"),
                      _keyAndName("play"),
                      _keyAndName("apple"),
                      _keyAndName("deals"),
                      _keyAndName("city"),
                      _keyAndName("qna"),
                      _keyAndName("hot"),
                      _keyAndName("all"),
                      _keyAndName("r2"),
                      _keyAndName("nodes"),
                      _keyAndName("members"))
}()

let screenWidth = UIScreen.mainScreen().bounds.width
let screenHeight = UIScreen.mainScreen().bounds.height

let tableViewMargn:CGFloat = 8

class WETwoScrollViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var nodesScrollView: WEDefaultNodeScrollView!
    
    @IBOutlet weak var topicListScrolView: UIScrollView!
    let topicListContainerView = UIView()
    
    var topicListHeight:CGFloat {
        var height:CGFloat = screenHeight - nodeScrollViewHeight -  UIApplication.sharedApplication().statusBarFrame.height
        if let barHeight = self.navigationController?.navigationBar.bounds.height {
            height -= barHeight
        }
        return height
    }
    
    override func viewDidLoad() {
        nodesScrollView.delegate = self;
        nodesScrollView.nodeArray = defaultNodes
        nodesScrollView.nodeSelectChanged = {[unowned self] nodeID in
            for topicCV in self.childViewControllers {
                if let topicListCV = topicCV as? WETopicListTableViewController {
                    if topicListCV.nodeID == nodeID {
                        self.topicListScrolView.setContentOffset(topicListCV.view.frame.origin, animated: true)
                    }
                }
            }
        }
        
        topicListScrolView.delegate = self;
        
        var lastestTV:UIView? = nil
        for  (nodeID, _) in defaultNodes {
            if let newTC = storyboard?.instantiateViewControllerWithIdentifier("TopListTableViewController") as? WETopicListTableViewController {
                self.addChildViewController(newTC)
                newTC.nodeID = nodeID

                topicListContainerView.addSubview(newTC.view)
                newTC.view.snp_makeConstraints(closure: { (make) in
                    make.top.bottom.equalTo(topicListContainerView)
                    make.width.equalTo(screenWidth)
                })
                if let ltv = lastestTV {
                    newTC.view.snp_makeConstraints(closure: { (make) in
                        make.leading.equalTo(ltv.snp_trailing)
                    })
                } else {
                    newTC.view.snp_makeConstraints(closure: { (make) in
                        make.leading.equalTo(topicListContainerView)
                    })
                }
                lastestTV = newTC.view
            }
        }
        lastestTV?.snp_makeConstraints(closure: { (make) in
            make.trailing.equalTo(topicListContainerView)
        })
        var contentViewSize = topicListContainerView.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize)
        contentViewSize.height = topicListHeight
        topicListContainerView.frame = CGRect(origin: CGPointZero, size: contentViewSize)
        topicListScrolView.addSubview(topicListContainerView)
        contentViewSize.height = 0
        topicListScrolView.contentSize = contentViewSize
    }
    
    // MARK: -scroll view delegate
    func scrollViewDidEndScrollingAnimation(scrollView: UIScrollView) {
        if scrollView.isEqual(topicListScrolView) {
            var index:Int = (Int)(scrollView.contentOffset.x/UIScreen.mainScreen().bounds.width)
            if index < 0 {
                index = 0
            }
            nodesScrollView.hightlightNode(Index: index)
        }
    }

    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        self.scrollViewDidEndScrollingAnimation(scrollView)
    }
    


}
