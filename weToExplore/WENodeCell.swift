//
//  WENodeCell.swift
//  weToExplore
//
//  Created by Daniel Tan on 8/13/16.
//  Copyright © 2016 Gnodnate. All rights reserved.
//

import UIKit

let ButtonHeight:CGFloat = 24
let FontSize:CGFloat = 14


class WENodeCell: UITableViewCell {
    
    weak var exitSegue:UIStoryboardSegue?
    
    var nodeButtonArray = [UIButton]()
    var nodeInfo:[String:String]! {
        didSet {
            for node in nodeInfo {
                let button = UIButton()
                button.nodeInfo = [node.0:node.1]
                button.setTile(node.0, font: UIFont.systemFontOfSize(FontSize))
                button.addTarget(self, action: #selector(showTopicInNode(_:)), forControlEvents: UIControlEvents.TouchDown)
                button.addTarget(self, action: #selector(buttonTouchUpInside(_:)), forControlEvents: .TouchUpInside)
                button.addTarget(self, action: #selector(buttonTouchUpOutside(_:)), forControlEvents: .TouchUpOutside)
                nodeButtonArray.append(button)
            }
            
            
        }
    }
    
    // MARK: - init
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.selectionStyle = UITableViewCellSelectionStyle.None
    }
    
    // MARK: - button action
    
    func showTopicInNode(nodeButton:UIButton) {
        nodeButton.backgroundColor = UIColor.blueColor()
    }
    
    func buttonTouchUpInside(nodeButton:UIButton) {
        nodeButton.backgroundColor = UIColor.whiteColor()
//        NSNotificationCenter.defaultCenter().postNotificationName("NODENAMECHANGE", object: nodeButton.nodeName)
        NSUserDefaults.standardUserDefaults().setObject(nodeButton.nodeInfo, forKey: DefaultNodeName)
        NSUserDefaults.standardUserDefaults().synchronize()
        self.exitSegue?.perform()
    }
    func buttonTouchUpOutside(nodeButton:UIButton) {
        nodeButton.backgroundColor = UIColor.whiteColor()
    }

    // MARK: - layout buttons
    func laoutButtons() {
        var originX:CGFloat = 10
        var originY:CGFloat = 10
        for index in 0...nodeButtonArray.count-1 {
            let button = nodeButtonArray[index]
            if button.frame.size.width + 10 + originX < UIScreen.mainScreen().bounds.size.width {
                button.frame.origin = CGPointMake(originX, originY)
            } else {
                button.frame.origin = CGPointMake(10, originY+5+ButtonHeight)
            }
            originX = button.frame.origin.x + 10 + button.frame.size.width
            originY = button.frame.origin.y
            self.contentView.addSubview(button)
        }
    }
}

// MARK: - UIButton extension
private var nodeID:Int8 = 0
private extension UIButton {
    func setTile(title:String, font:UIFont) -> Void {
        self.titleLabel?.font = font
        self.setTitleColor(UIColor.blueColor(), forState: .Normal)
        self.setTitleColor(UIColor.whiteColor(), forState: .Selected)
        self.setTitleColor(UIColor.whiteColor(), forState: .Highlighted)
        self.setTitle(title, forState: .Normal)
        let rect = (title as NSString).boundingRectWithSize(CGSizeMake(CGFloat.max, CGFloat.max),
                                                            options:.UsesLineFragmentOrigin,
                                                            attributes: [NSFontAttributeName:UIFont.systemFontOfSize(FontSize)],
                                                            context: nil)
        self.frame.size = CGSizeMake(CGRectGetWidth(rect)+10, ButtonHeight);
    }
    
    var nodeInfo:[String:String]! {
        get {
            return objc_getAssociatedObject(self, &nodeID) as? [String:String]
        }
        set {
            objc_setAssociatedObject(self, &nodeID, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
    }
}

