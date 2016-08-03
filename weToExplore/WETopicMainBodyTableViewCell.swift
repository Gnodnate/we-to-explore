//
//  WETopicMainBodyTableViewCell.swift
//  weToExplore
//
//  Created by Daniel Tan on 7/31/16.
//  Copyright © 2016 Gnodnate. All rights reserved.
//

import UIKit

class WETopicMainBodyTableViewCell: UITableViewCell {

    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var mainBodyText: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    
    var topicDetail:WETopicDetail? {
        didSet {
            var memberIconURLString = topicDetail!.memberInfo["avatar_normal"] as! String
            if memberIconURLString.hasPrefix("//") {
                memberIconURLString = String.localizedStringWithFormat("https:%@", memberIconURLString)
            }
            self.userImageView.sd_setImageWithURL(NSURL(string:memberIconURLString))
            self.userName.text = topicDetail!.memberInfo["username"] as? String
            self.mainBodyText.text = topicDetail!.topicContent
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
