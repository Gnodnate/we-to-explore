//
//  WENodeButton.swift
//  weToExplore
//
//  Created by Daniel Tan on 8/19/16.
//  Copyright © 2016 Gnodnate. All rights reserved.
//

import UIKit

//let height:CGFloat = 36
let labelSizeMargin:CGFloat = 30

class WENodeButton: UIButton {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    let titileFont: UIFont =  {
        return UIFont.systemFontOfSize(19)
    }()
    
    var width:CGFloat {
        let size = ((self.titleLabel?.text!)! as NSString).sizeWithAttributes([NSFontAttributeName : titileFont])
        return size.width + labelSizeMargin
    }
    
    required override init(frame: CGRect) {
        super.init(frame:frame)
        self.setTitleColor(UIColor.darkGrayColor(), forState: .Normal)
        self.titleLabel?.font = titileFont
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setTitleColor(UIColor.darkGrayColor(), forState: .Normal)
        self.titleLabel?.font = titileFont
    }
    
    var scale:CGFloat = 0 {
        didSet {
            let titleColor = UIColor(red: (scale*(55.0 - 104.0) + 104.0)/255, green: (scale * (221.0 - 104.0) + 104.0)/255, blue: (scale * (55.0 - 104.0) + 104.0)/255, alpha: 1.0)
            self.titleLabel?.textColor = titleColor
            
            self.titleLabel?.font = UIFont.systemFontOfSize(titileFont.pointSize * (1 + 0.3 * scale))
        }
    }
    
}
