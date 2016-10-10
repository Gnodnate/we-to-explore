//
//  WETopicMainBodyTableViewCell.swift
//  weToExplore
//
//  Created by Daniel Tan on 7/31/16.
//  Copyright © 2016 Gnodnate. All rights reserved.
//

import UIKit

class WETopicMainBodyTableViewCell: UITableViewCell {

    @IBOutlet weak var tilte: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var mainBodyText: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var lastModTime: UILabel!
    
    var topicDetail:WETopicDetail? {
        didSet {
            tilte.text                  = topicDetail?.title
            userImageView.sd_setImage(with: topicDetail?.avaterImageURL, placeholderImage: UIImage(named: "default"))
            lastModTime.text            = topicDetail?.lastModTime
            userName.text               = topicDetail!.memberInfo?.name
//            self.mainBodyText.text = topicDetail!.content
            
            if let data = self.topicDetail?.content_rendered?.data(using: String.Encoding.unicode) {
                do {
                    try mainBodyText.attributedText = NSAttributedString(data: data, options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType], documentAttributes: nil)
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
