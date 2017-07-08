//
//  Message.swift
//  twitter_alamofire_demo
//
//  Created by Skyler Ruesga on 7/7/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//

import Foundation
import DateToolsSwift

class Message {
    
    // MARK: Properties
    var id: Int64 // For favoriting, retweeting & replying
    var text: String // Text content of message
    var recipient: User // Contains name, screenname, etc. of message recipient
    var sender: User // Contains name, screenname, etc. of message sender
    var createdAtString: String // Display date
    
    // MARK: - Create initializer with dictionary
    init(dictionary: [String: Any]) {
        id = dictionary["id"] as! Int64
        text = dictionary["text"] as! String
        
        let recipient = dictionary["recipient"] as! [String: Any]
        self.recipient = User(dictionary: recipient)
        
        
        let sender = dictionary["sender"] as! [String: Any]
        self.sender = User(dictionary: sender)
        
        let createdAtOriginalString = dictionary["created_at"] as! String
        let formatter = DateFormatter()
        // Configure the input format to parse the date string
        formatter.dateFormat = "E MMM d HH:mm:ss Z y"
        // Convert String to Date
        let date = formatter.date(from: createdAtOriginalString)!
        // Configure output format
        formatter.dateStyle = .short
        formatter.timeStyle = .none
        // Convert Date to String
        //        createdAtString = formatter.string(from: date)
        self.createdAtString = date.shortTimeAgoSinceNow
    }
}
