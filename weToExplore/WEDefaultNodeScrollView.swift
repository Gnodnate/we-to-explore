//
//  WEDefaultNodeScrollView.swift
//  weToExplore
//
//  Created by Daniel Tan on 8/19/16.
//  Copyright © 2016 Gnodnate. All rights reserved.
//

import UIKit
import SnapKit

let nodeScrollViewHeight:CGFloat = 40 // There is another one in storyboard

class WEDefaultNodeScrollView: UIScrollView {
    private var lastSelectButton:WENodeButton?
    
    var nodeSelectChanged: ((nodeID:String)->())?
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
                let nodeButton = WENodeButton(type: .Custom)
                nodeButton.ID = node.0
                nodeButton.setTitle(node.1, forState: .Normal)
                nodeButton.addTarget(self, action: #selector(changeNode(_:)), forControlEvents: UIControlEvents.TouchUpInside)
                containerView.addSubview(nodeButton)
                let width = nodeButton.width

                nodeButton.snp_makeConstraints(closure: {[unowned self]  (make) in
                    make.width.equalTo(width)
                    make.height.equalTo(nodeScrollViewHeight)
                    make.top.bottom.equalTo(self.containerView)
                    if lastSubView != nil {
                        make.leading.equalTo(lastSubView!.snp_trailing)
                    } else {
                        make.leading.equalTo(self.containerView)
                    }
                    lastSubView = nodeButton
                })
            }
            if lastSubView != nil {
                lastSubView?.snp_makeConstraints(closure: { (make) in
                    make.trailing.equalTo(self.containerView).offset(0)
                })
            }
            var contentViewSize = containerView.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize)
            contentViewSize.height = nodeScrollViewHeight
            containerView.frame = CGRect(origin: CGPointZero, size: contentViewSize)
            self.addSubview(containerView)

            self.contentSize = CGSize(width: contentViewSize.width, height: 0)

            self.hightlightNode(Index: 0)
        }
    }
    
    private func effectNodeButton (button:WENodeButton) {
        lastSelectButton?.scale = 0
        button.scale = 1
        lastSelectButton = button
    }
    func changeNode(button:WENodeButton) {
        effectNodeButton(button)
        nodeSelectChanged?(nodeID: button.ID ?? "all")
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
