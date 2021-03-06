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
            replierImage.sd_setImage(with: replyDetail?.replierImageURL, placeholderImage: UIImage(named: "default"))
            replierName.text = replyDetail!.replierName
            replyTime.text =  Date(timeIntervalSince1970: replyDetail!.replyTime!.doubleValue).humanReadableDate()
            if let data = self.replyDetail?.content_rendered?.data(using: String.Encoding.unicode) {
                do {
                    try replyText.attributedText = NSAttributedString(data: data, options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType], documentAttributes: nil)
                } catch let error as NSError{
                    NSLog("%@", error)
                }
            }
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
