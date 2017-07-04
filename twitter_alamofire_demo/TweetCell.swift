//
//  TweetCell.swift
//  twitter_alamofire_demo
//
//  Created by Charles Hieger on 6/18/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//

import UIKit
import AlamofireImage

class TweetCell: UITableViewCell {
    
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var tweetImageView: UIImageView!
    @IBOutlet weak var tweetAuthorLabel: UILabel!
    @IBOutlet weak var tweetUsernameLabel: UILabel!
    @IBOutlet weak var tweetDateLabel: UILabel!
    
    var tweet: Tweet! {
        didSet {
            tweetTextLabel.text = tweet.text
            tweetAuthorLabel.text = tweet.user.name
            tweetImageView.af_setImage(withURL: tweet.user.imageURL!)
            tweetUsernameLabel.text = "@" + tweet.user.screenName
            tweetDateLabel.text = tweet.createdAtString
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
