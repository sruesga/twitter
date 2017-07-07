//
//  DetailViewController.swift
//  twitter_alamofire_demo
//
//  Created by Skyler Ruesga on 7/6/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var tweetUserImage: UIButton!
    @IBOutlet weak var tweetAuthorLabel: UILabel!
    @IBOutlet weak var tweetUsernameLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var tweetDateLabel: UILabel!
    @IBOutlet weak var retweetCountLabel: UILabel!
    @IBOutlet weak var favoriteCountLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    
    var tweet: Tweet!
    weak var delegate: TweetCellDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        tweetTextLabel.text = tweet.text
        tweetAuthorLabel.text = tweet.user.name
        tweetUserImage.clipsToBounds = true
        tweetUserImage.layer.masksToBounds = true
        tweetUserImage.layer.cornerRadius = 10
        tweetUserImage.af_setBackgroundImage(for: .normal, url: tweet.user.imageURL!)
        tweetUsernameLabel.text = "@" + tweet.user.screenName
        tweetDateLabel.text = tweet.createdAtString
        retweetCountLabel.text = String(tweet.retweetCount)
        favoriteCountLabel.text = String(tweet.favoriteCount)
        
        if tweet.favorited == true {
            favoriteButton.setImage(UIImage(named: "favor-icon-red"), for: .normal)
        } else {
            favoriteButton.setImage(UIImage(named: "favor-icon"), for: .normal)
        }
        
        if tweet.retweeted {
            retweetButton.setImage(UIImage(named: "retweet-icon-green"), for: .normal)
        } else {
            retweetButton.setImage(UIImage(named: "retweet-icon"), for: .normal)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didTapReply(_ sender: Any) {
    }
    
    @IBAction func didTapRetweet(_ sender: Any) {
        
        let button = sender as! UIButton
        
        if tweet.retweeted {
            tweet.retweeted = false
            tweet.retweetCount -= 1
            button.setImage(UIImage(named: "retweet-icon"), for: .normal)
            retweetCountLabel.text = String(tweet.retweetCount)
            
            APIManager.shared.unretweet(tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error unretweeting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully retweeted the following Tweet: \n\(tweet.text)")
                }
            }
            
        } else {
            tweet.retweeted = true
            tweet.retweetCount += 1
            button.setImage(UIImage(named: "retweet-icon-green"), for: .normal)
            retweetCountLabel.text = String(tweet.retweetCount)
            
            APIManager.shared.retweet(tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error retweeting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully retweeted the following Tweet: \n\(tweet.text)")
                }
            }
        }
        
    }
    
    @IBAction func didTapFavorite(_ sender: Any) {
        
        let button = sender as! UIButton
        
        if tweet.favorited == true {
            tweet.favorited = false
            tweet.favoriteCount -= 1
            button.setImage(UIImage(named: "favor-icon"), for: .normal)
            favoriteCountLabel.text = String(tweet.favoriteCount)
            
            APIManager.shared.unfavorite(tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error unfavoriting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully unfavorited the following Tweet: \n\(tweet.text)")
                }
            }
        } else {
            tweet.favorited = true
            tweet.favoriteCount += 1
            button.setImage(UIImage(named: "favor-icon-red"), for: .normal)
            favoriteCountLabel.text = String(tweet.favoriteCount)
            
            APIManager.shared.favorite(tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error favoriting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully favorited the following Tweet: \n\(tweet.text)")
                }
            }
        }
    }
    
    @IBAction func didTapProfile(_ sender: Any) {
        delegate?.didTapProfile(of: self.tweet.user)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}

extension DetailViewController: TweetCellDelegate {
    func didTapProfile(of user: User) {
        performSegue(withIdentifier: "OtherUserSegue", sender: user)
    }
}