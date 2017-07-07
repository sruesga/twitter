//
//  ProfileViewController.swift
//  twitter_alamofire_demo
//
//  Created by Skyler Ruesga on 7/6/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userScreenNameLabel: UILabel!
    @IBOutlet weak var followingCountLabel: UILabel!
    @IBOutlet weak var followersCountLabel: UILabel!
    
    var user: User = User.current!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        profileImageView.layer.borderColor = UIColor.white.cgColor
        profileImageView.layer.borderWidth = 4
        

        
        profileImageView.af_setImage(withURL: user.imageURL!)
        userNameLabel.text = user.name
        userScreenNameLabel.text = "@\(user.screenName)"
        followingCountLabel.text = String(user.followingCount)
        followersCountLabel.text = String(user.followerCount)
        backgroundImageView.backgroundColor = UIColor(hex: user.backgroundColorHex)
        
        if let url = user.backgroundImageURL {
            backgroundImageView.af_setImage(withURL: url)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        switch segue.identifier! {
        case "EmbeddedTimeline":
            let vc = segue.destination as! PersonalTimelineViewController
            vc.user = self.user
        default:
            print("Bad segue with no identifier")
        }
    }
}
