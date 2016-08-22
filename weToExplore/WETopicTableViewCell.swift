//
//  WETopicTableViewCell.swift
//  weToExplore
//
//  Created by Daniel Tan on 8/20/16.
//  Copyright © 2016 Gnodnate. All rights reserved.
//

import UIKit

class WETopicTableViewCell: UITableViewCell {
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UIButton!
    @IBOutlet weak var replyTime: UILabel!
    @IBOutlet weak var nodeName: UIButton!
    @IBOutlet weak var topicTitle: UILabel!
    
    var ID:Int?
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
