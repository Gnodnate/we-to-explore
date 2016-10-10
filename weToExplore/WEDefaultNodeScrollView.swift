//
//  WEDefaultNodeScrollView.swift
//  weToExplore
//
//  Created by Daniel Tan on 8/19/16.
//  Copyright © 2016 Gnodnate. All rights reserved.
//

import UIKit

let nodeScrollViewHeight:CGFloat = 40 // There is another one in storyboard

class WEDefaultNodeScrollView: UIScrollView {
    fileprivate var lastSelectButton:WENodeButton?
    
    var nodeSelectChanged: ((_ nodeName:String)->())?
    let containerView = UIView()
    var nodeArray:[String:String]?{ // ID, Title
        didSet {
            for subView in self.containerView.subviews {
                subView.removeFromSuperview()
            }
            if (containerView.superview != nil) {
                containerView.removeFromSuperview()
            }
            
            var lastSubView:UIView? = nil
            for node in nodeArray! {
                let nodeButton = WENodeButton(type: .custom)
                nodeButton.ID = node.0
                nodeButton.setTitle(node.1, for: UIControlState())
                nodeButton.addTarget(self, action: #selector(changeNode(_:)), for: UIControlEvents.touchUpInside)
                nodeButton.frame.size = CGSize(width: nodeButton.calcWidth, height: nodeScrollViewHeight)
                nodeButton.frame.origin = CGPoint(x: lastSubView?.frame.maxX ?? 0 , y: 0)
                containerView.addSubview(nodeButton)
                lastSubView = nodeButton
            }
            let contentViewWidth = lastSubView?.frame.maxX ?? 0
            containerView.frame = CGRect(origin: CGPoint.zero, size: CGSize(width: contentViewWidth, height: nodeScrollViewHeight))
            self.addSubview(containerView)

            self.contentSize = CGSize(width: contentViewWidth, height: 0)

            self.hightlightNode(Index: 0)
        }
    }
    
    fileprivate func effectNodeButton (_ button:WENodeButton) {
        lastSelectButton?.scale = 0
        button.scale = 1
        lastSelectButton = button
    }
    func changeNode(_ button:WENodeButton) {
        effectNodeButton(button)
        nodeSelectChanged?(button.ID ?? "all")
    }
    
    func hightlightNode(Index index:Int) {
        if index < containerView.subviews.count {
            if let button = containerView.subviews[index] as? WENodeButton {
                self.effectNodeButton(button)
                let offsetY = self.bounds.origin.y
                // Right
                var offsetX = button.frame.maxX - self.bounds.origin.x
                if offsetX > screenWidth {
                    self.setContentOffset(CGPoint(x:(self.bounds.origin.x + offsetX - screenWidth), y:offsetY), animated: true)
                } else { // Left
                    offsetX = button.frame.minX - self.bounds.origin.x
                    if offsetX < 0 {
                        offsetX += self.bounds.minX
                        self.setContentOffset(CGPoint(x: offsetX, y:offsetY), animated: true)
                    }
                }
            }
        }
    }

}
