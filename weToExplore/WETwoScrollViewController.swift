//
//  WERootViewController.swift
//  weToExplore
//
//  Created by Daniel Tan on 8/19/16.
//  Copyright © 2016 Gnodnate. All rights reserved.
//

import UIKit

func _keyAndTitle( key:String ) -> (String, String) {
    return (key, NSLocalizedString(key, comment: ""))
}

let defaultNodes:[String:String] = {
    return Dictionary(dictionaryLiteral:_keyAndTitle("tech"),
                      _keyAndTitle("creative"),
                      _keyAndTitle("play"),
                      _keyAndTitle("apple"),
                      _keyAndTitle("deals"),
                      _keyAndTitle("city"),
                      _keyAndTitle("qna"),
                      _keyAndTitle("hot"),
                      _keyAndTitle("all"),
                      _keyAndTitle("r2"),
                      _keyAndTitle("nodes"),
                      _keyAndTitle("members"))
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
        nodesScrollView.nodeSelectChanged = {[unowned self] nodeName in
            var index:CGFloat = 0.0
            for topicCV in self.childViewControllers {
                if let topicListCV = topicCV as? WETopicListTableViewController {
                    if topicListCV.nodeName == nodeName {
                        let offSetY = self.topicListScrolView.bounds.origin.y
                        let offSetX = index*screenWidth
                        topicListCV.view.frame = CGRect(origin: CGPoint(x: offSetX, y: offSetY), size: CGSize(width: screenWidth, height: self.topicListHeight))
                        self.topicListContainerView.addSubview(topicListCV.view)
                        self.topicListScrolView.setContentOffset(topicListCV.view.frame.origin, animated: true)
                    }
                }
                index += 1
            }
        }
        
        topicListScrolView.delegate = self;
        
        for  (nodeName, _) in defaultNodes {
            if let newTC = storyboard?.instantiateViewControllerWithIdentifier("TopListTableViewController") as? WETopicListTableViewController {
                newTC.nodeName = nodeName
                
                self.addChildViewController(newTC)
            }
        }
        var contentViewSize = CGSize(width: screenWidth * CGFloat(defaultNodes.count), height: topicListHeight)
        topicListContainerView.frame = CGRect(origin: CGPointZero, size: contentViewSize)
        topicListScrolView.addSubview(topicListContainerView)
        contentViewSize.height = 0
        topicListScrolView.contentSize = contentViewSize
        
        if let firestVC = self.childViewControllers.first {
            firestVC.view.frame  = CGRect(origin: CGPointZero, size: CGSize(width: screenWidth, height: self.topicListHeight))
            topicListContainerView.addSubview(firestVC.view)
        }
    }
    
    // MARK: -scroll view delegate
    func scrollViewDidEndScrollingAnimation(scrollView: UIScrollView) {
        if scrollView.isEqual(topicListScrolView) {
            var index:Int = (Int)(scrollView.contentOffset.x/UIScreen.mainScreen().bounds.width)
            if index < 0 {
                index = 0
            }
            let childVC = self.childViewControllers[index]
            childVC.view.frame = scrollView.bounds
            if nil == childVC.view.superview {
//                scrollView.addSubview(childVC.view)
                topicListContainerView.addSubview(childVC.view)
            }
            
            nodesScrollView.hightlightNode(Index: index)
        }
    }

    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        self.scrollViewDidEndScrollingAnimation(scrollView)
    }
    


}
