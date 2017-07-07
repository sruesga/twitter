//
//  ComposeViewController.swift
//  twitter_alamofire_demo
//
//  Created by Skyler Ruesga on 7/5/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//

import UIKit
import AlamofireImage

protocol ComposeViewControllerDelegate: class {
    func did(post: Tweet)
}

class ComposeViewController: UIViewController, UITextViewDelegate {
    
    weak var delegate: ComposeViewControllerDelegate?
    
    
    @IBOutlet weak var userProfileImageView: UIImageView!
    @IBOutlet weak var tweetButton: UIButton!
    @IBOutlet weak var characterCountLabel: UILabel!
    @IBOutlet weak var tweetTextView: UITextView!
    
    var buttonColor: UIColor!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        tweetTextView.delegate = self
        userProfileImageView.clipsToBounds = true
        userProfileImageView.layer.masksToBounds = true
        userProfileImageView.layer.cornerRadius = 25
        userProfileImageView.af_setImage(withURL: User.current!.imageURL!)

        tweetButton.layer.cornerRadius = tweetButton.frame.height/2
        tweetButton.isEnabled = false
        buttonColor = tweetButton.backgroundColor
        tweetButton.backgroundColor = buttonColor.withAlphaComponent(0.5)
    }
    
    
    func textViewDidChange(_ textView: UITextView) {
        let numChars = 140 - tweetTextView.text.characters.count
        characterCountLabel.text = String(numChars)
        
        if numChars > 20 {
            characterCountLabel.textColor = .darkGray
        } else {
            characterCountLabel.textColor = .red
        }
        
        if numChars >= 140 || numChars < 0 {
            tweetButton.isEnabled = false
            tweetButton.backgroundColor = buttonColor.withAlphaComponent(0.5)
        } else {
            tweetButton.isEnabled = true
            tweetButton.backgroundColor = buttonColor
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if (textView.text == "What's happening?") {
            textView.text = ""
            textView.textColor = .black
            tweetButton.backgroundColor = buttonColor.withAlphaComponent(0.5)
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didCloseCompose(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func didTapTweetButton(_ sender: Any) {
        APIManager.shared.composeTweet(with: tweetTextView.text) { (tweet, error) in
            if let error = error {
                print("Error composing Tweet: \(error.localizedDescription)")
            } else if let tweet = tweet {
                self.delegate?.did(post: tweet)
                print("Compose Tweet Success!")
            }
        }
        self.dismiss(animated: true, completion: nil)
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
