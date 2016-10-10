//
//  WENodeCell.swift
//  weToExplore
//
//  Created by Daniel Tan on 8/13/16.
//  Copyright © 2016 Gnodnate. All rights reserved.
//

import UIKit

let NodeButtonHeight:CGFloat = 24
let NodeButtonFontSize:CGFloat = 14


class WENodeCell: UITableViewCell {
    
    var showNodeSegue:UIStoryboardSegue?
    
    var nodeButtonArray = [UIButton]()
    var nodeGroup:WENodeGroup! {
        didSet {
            for node in nodeGroup.nodeArray {
                let button = UIButton()
                button.nodeInfo = node
                button.setTile(node.title!, font: UIFont.systemFont(ofSize: NodeButtonFontSize))
                button.addTarget(self, action: #selector(showTopicInNode(_:)), for: UIControlEvents.touchDown)
                button.addTarget(self, action: #selector(buttonTouchUpInside(_:)), for: .touchUpInside)
                button.addTarget(self, action: #selector(buttonTouchUpOutside(_:)), for: .touchUpOutside)
                nodeButtonArray.append(button)
            }
            
            
        }
    }
    
    // MARK: - init
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.selectionStyle = UITableViewCellSelectionStyle.none
    }
    
    // MARK: - button action
    
    func showTopicInNode(_ nodeButton:UIButton) {
        nodeButton.backgroundColor = UIColor.v2exGreen()
    }
    
    func buttonTouchUpInside(_ nodeButton:UIButton) {
        nodeButton.backgroundColor = UIColor.white
        if let topicListVC = self.showNodeSegue?.destination as? WETopicListTableViewController {
            topicListVC.nodeName = (nodeButton.nodeInfo?.name)!
        }
        self.showNodeSegue?.perform()
    }
    func buttonTouchUpOutside(_ nodeButton:UIButton) {
        nodeButton.backgroundColor = UIColor.white
    }

    // MARK: - layout buttons
    func laoutButtons() {
        var originX:CGFloat = 10
        var originY:CGFloat = 10
        for index in 0...nodeButtonArray.count-1 {
            let button = nodeButtonArray[index]
            if button.frame.size.width + 10 + originX < UIScreen.main.bounds.size.width {
                button.frame.origin = CGPoint(x: originX, y: originY)
            } else {
                button.frame.origin = CGPoint(x: 10, y: originY+5+NodeButtonHeight)
            }
            originX = button.frame.origin.x + 10 + button.frame.size.width
            originY = button.frame.origin.y
            self.contentView.addSubview(button)
        }
    }
}

// MARK: - UIButton extension
private var nodeInfoID:Int8 = 0
extension UIButton {
    func setTile(_ title:String, font:UIFont) -> Void {
        self.titleLabel?.font = font
        self.setTitleColor(UIColor.v2exGreen(), for: UIControlState())
        self.setTitleColor(UIColor.white, for: .selected)
        self.setTitleColor(UIColor.white, for: .highlighted)
        self.setTitle(title, for: UIControlState())
        self.frame.size = CGSize(width: UIButton.widthWithTitle(title, andFont: font)+10, height: NodeButtonHeight);
    }
    
    static func widthWithTitle(_ title:String, andFont:UIFont) ->CGFloat {
        let rect = (title as NSString).boundingRect(with: CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude),
                                                            options:.usesLineFragmentOrigin,
                                                            attributes: [NSFontAttributeName:UIFont.systemFont(ofSize: NodeButtonFontSize)],
                                                            context: nil)
        return rect.width
    }
    
    var nodeInfo:WENode? {
        get {
            return objc_getAssociatedObject(self, &nodeInfoID) as? WENode
        }
        set (newValue) {
            objc_setAssociatedObject(self, &nodeInfoID, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }
}

