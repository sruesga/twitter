//
//  ComposeViewController.swift
//  twitter_alamofire_demo
//
//  Created by Skyler Ruesga on 7/5/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//

import UIKit
import AlamofireImage

class ComposeViewController: UIViewController {

    
    @IBOutlet weak var userProfileImageView: UIImageView!
    
    var user: User!
    var profileImage: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        userProfileImageView.clipsToBounds = true
        userProfileImageView.layer.masksToBounds = true
        userProfileImageView.layer.cornerRadius = 40
        userProfileImageView.image = profileImage
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
