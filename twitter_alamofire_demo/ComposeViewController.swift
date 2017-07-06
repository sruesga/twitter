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
    
    var user: User!
    var profileImage: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        tweetTextView.delegate = self
        userProfileImageView.clipsToBounds = true
        userProfileImageView.layer.masksToBounds = true
        userProfileImageView.layer.cornerRadius = 40
        userProfileImageView.image = profileImage
        
        tweetButton.layer.cornerRadius = tweetButton.frame.height/2
        tweetButton.isEnabled = false
    }
    
    
    // #4C9DEB r:76 g:157 b:235 for 20 < count < 140 for tweetButton
    // #F02C32 r:240 g:44 b:50 for count <= 20 for tweetButton
    func textViewDidChange(_ textView: UITextView) {
        let numChars = 140 - tweetTextView.text.characters.count
        characterCountLabel.text = String(numChars)
        
        if numChars > 20 {
            characterCountLabel.textColor = .darkGray
        } else {
            characterCountLabel.textColor = UIColor(red: 240.0/255.0, green: 44.0/255.0, blue: 50.0/255.0, alpha: 1.0)
        }
        
        var color: UIColor
        if numChars >= 0 {
            color = UIColor(red: 76.0/255.0, green: 157.0/255.0, blue: 235.0/255.0, alpha: 1.0)
        } else {
            color = characterCountLabel.textColor
        }
        
        if numChars >= 140 || numChars < 0 {
            tweetButton.isEnabled = false
//            color = color.withAlphaComponent(0.5)
        } else {
            tweetButton.isEnabled = true
//            color = color.withAlphaComponent(1.0)
        }
        
        tweetButton.backgroundColor = color
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if (textView.text == "What's happening?")
        {
            textView.text = ""
            textView.textColor = .black
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
