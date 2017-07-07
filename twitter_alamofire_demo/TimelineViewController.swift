//
//  TimelineViewController.swift
//  twitter_alamofire_demo
//
//  Created by Charles Hieger on 6/18/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//

import UIKit

class TimelineViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    
    var tweets: [Tweet] = []
    var refreshControl: UIRefreshControl!
    var isMoreDataLoading = false
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(loadData(withRefresh:)), for: UIControlEvents.valueChanged)
        tableView.insertSubview(refreshControl, at: 0)

        loadData(withRefresh: false)
        
        
        
        if let nav = self.navigationController {
            let logo = UIImage(named: "TwitterLogoBlue")
            let size = nav.navigationBar.frame.height
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: size, height: size))
            imageView.image = logo
            imageView.contentMode = .scaleAspectFit
            self.navigationItem.titleView = imageView
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath) as! TweetCell
        
        cell.tweet = tweets[indexPath.row]
        cell.delegate = self
        
        return cell
    }
    
    func loadData(withRefresh refreshing: Bool) {
        if refreshing {
            refreshControl.beginRefreshing()
        }
        APIManager.shared.getHomeTimeLine { (tweets, error) in
            if let tweets = tweets {
                self.tweets = tweets
                self.tableView.reloadData()
            } else if let error = error {
                print("Error getting home timeline: " + error.localizedDescription)
            }
            self.refreshControl.endRefreshing()
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (!isMoreDataLoading) {
            // Calculate the position of one screen length before the bottom of the results
            let scrollViewContentHeight = tableView.contentSize.height
            let scrollOffsetThreshold = scrollViewContentHeight - tableView.bounds.size.height
            
            // When the user has scrolled past the threshold, start requesting
            if(scrollView.contentOffset.y > scrollOffsetThreshold && tableView.isDragging) {
                
                isMoreDataLoading = true
                let tweetId = tweets.last!.id
                // Code to load more results
                APIManager.shared.getMoreTimelineTweets(with: tweetId) { (tweets, error) in
                    if let tweets = tweets {
                        if tweets.count > 1 {
                            self.tweets += tweets
                        }
                        self.tableView.reloadData()
                    } else if let error = error {
                        print("Error getting home timeline: " + error.localizedDescription)
                    }
                    self.isMoreDataLoading = false
                }
            }
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func cellPositionFor(_ sender: AnyObject) -> Tweet {
        let buttonPosition = sender.convert(CGPoint(), to: tableView)
        let indexPath = tableView.indexPathForRow(at: buttonPosition)!
        return tweets[indexPath.row]
    }
    
    
    @IBAction func didTapLogout(_ sender: Any) {
        APIManager.shared.logout()
    }
    
    @IBAction func didTapCompose(_ sender: Any) {
        self.performSegue(withIdentifier: "ComposeTweetSegue", sender: nil)
    }
    
    
    
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
        
        switch segue.identifier! {
        case "ComposeTweetSegue":
            let nav = segue.destination as! UINavigationController
            let vc = nav.topViewController as! ComposeViewController
            vc.delegate = self
        case "DetailSegue":
            let vc = segue.destination as! DetailViewController
            let cell = sender as! TweetCell
            vc.tweet = cell.tweet
        case "OtherUserSegue":
            let vc = segue.destination as! ProfileViewController
            vc.user = sender as! User
        default:
            print("Bad segue from TimelineViewController to \(segue.destination)")
        }
     }
}

extension TimelineViewController: ComposeViewControllerDelegate {
    func did(post: Tweet) {
        tweets.insert(post, at: 0)
        tableView.reloadData()
    }
}

extension TimelineViewController: TweetCellDelegate {
    func didTapProfile(of user: User) {
        performSegue(withIdentifier: "OtherUserSegue", sender: user)
    }
}

