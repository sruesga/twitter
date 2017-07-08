//
//  MessageCell.swift
//  twitter_alamofire_demo
//
//  Created by Skyler Ruesga on 7/7/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//

import UIKit
import AlamofireImage
import ActiveLabel

class MessageCell: UITableViewCell {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var messageContentLabel: ActiveLabel!
    
    
    var message: Message! {
        didSet {
            
            var user: User!
            
            if message.recipient.name != User.current!.name {
                user = message.recipient
            } else {
                user = message.sender
            }
            
            nameLabel.text = user.name
            profileImageView.clipsToBounds = true
            profileImageView.layer.masksToBounds = true
            profileImageView.layer.cornerRadius = 10
            profileImageView.af_setImage(withURL: user.imageURL!)
            usernameLabel.text = "@" + user.screenName
            dateLabel.text = message.createdAtString
            messageContentLabel.customize { (label) in
                label.text = message.text
                label.enabledTypes = [.url]
                label.URLColor = UIColor(red: 80.0/255, green: 168.0/255, blue: 252.0/255, alpha: 1)
                label.textColor = UIColor.black
                label.handleURLTap { url in UIApplication.shared.openURL(url) }
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
