//
//  WETopicReplyTableViewCell.swift
//  weToExplore
//
//  Created by Daniel Tan on 8/1/16.
//  Copyright © 2016 Gnodnate. All rights reserved.
//

import UIKit

class WETopicReplyTableViewCell: UITableViewCell {

    @IBOutlet weak var replierImage: UIImageView!
    @IBOutlet weak var replierName: UILabel!
    @IBOutlet weak var replyTime: UILabel!
    @IBOutlet weak var replyText: UILabel!
    
    var replyDetail:WEReplyDetail? {
        didSet {
            replierImage.sd_setImageWithURL(NSURL(string: replyDetail!.replierImageURLString))
            replierName.text = replyDetail!.replierName
            replyTime.text = NSString.humanFriendlyDate(NSDate(timeIntervalSince1970: replyDetail!.replyTime.doubleValue))
            replyText.text = replyDetail!.replyText

        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
