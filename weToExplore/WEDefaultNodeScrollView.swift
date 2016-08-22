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
    let containerView = UIView()
    var nodeArray:[String:String]?{
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
            print("=======\(contentViewSize)=======\n=======\(self.bounds)=======\n")
            contentViewSize.height = nodeScrollViewHeight
            containerView.frame = CGRect(origin: CGPointZero, size: contentViewSize)
            self.addSubview(containerView)

            self.contentSize = CGSize(width: contentViewSize.width, height: 0)

            self.hightlightNode(Index: 0)
        }
    }
    
    func changeNode(button:WENodeButton) {
        lastSelectButton?.scale = 0
        button.scale = 1
        lastSelectButton = button
    }
    
    func hightlightNode(Index index:Int) {
        if index < containerView.subviews.count {
            if let button = containerView.subviews[index] as? WENodeButton {
                self.changeNode(button)
                self.contentOffset = button.frame.origin
            }
        }
    }

}
