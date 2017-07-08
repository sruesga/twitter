//
//  PersonalTimelineViewController.swift
//  twitter_alamofire_demo
//
//  Created by Skyler Ruesga on 7/6/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//

import UIKit

class PersonalTimelineViewController: TimelineViewController {
    
    
    var user: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    override func loadData(withRefresh refreshing: Bool) {
        if refreshing {
            self.refreshControl.beginRefreshing()
        }
        APIManager.shared.getPersonalTimeline(with: self.user) { (tweets, error) in
            if let tweets = tweets {
                self.tweets = tweets
                self.tableView.reloadData()
            } else if let error = error {
                print("Error getting home timeline: " + error.localizedDescription)
            }
            self.refreshControl.endRefreshing()
        }
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (!isMoreDataLoading) {
            // Calculate the position of one screen length before the bottom of the results
            let scrollViewContentHeight = tableView.contentSize.height
            let scrollOffsetThreshold = scrollViewContentHeight - tableView.bounds.size.height
            
            // When the user has scrolled past the threshold, start requesting
            if(scrollView.contentOffset.y > scrollOffsetThreshold && tableView.isDragging) {
                
                isMoreDataLoading = true
                let tweetId = tweets.last!.id
                // Code to load more results
                APIManager.shared.getMorePersonalTimeline(with: tweetId, user: self.user) { (tweets, error) in
                    if let tweets = tweets {
                        if tweets.count > 1 {
                            self.tweets += tweets
                        }
                        self.tableView.reloadData()
                    } else if let error = error {
                        print("Error getting user timeline: " + error.localizedDescription)
                    }
                    self.isMoreDataLoading = false
                }
            }
        }
    }
    
    // MARK: - Navigation
/*
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        }
    }*/
}
