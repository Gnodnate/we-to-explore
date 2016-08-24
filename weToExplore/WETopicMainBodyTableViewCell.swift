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
            self.tilte.text = topicDetail?.title
            self.userImageView.sd_setImageWithURL(topicDetail?.avaterImageURL, placeholderImage: UIImage(named: "default"))
            self.lastModTime.text = topicDetail?.lastModTime
            self.userName.text = topicDetail!.memberInfo?.name
            self.mainBodyText.text = topicDetail!.content
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
