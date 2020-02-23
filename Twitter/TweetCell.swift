//
//  TweetCell.swift
//  Twitter
//
//  Created by cory on 2/16/20.
//  Copyright © 2020 Dan. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {
    
    @IBOutlet weak var profileView: UIImageView!
    @IBOutlet weak var profileLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    var favorited: Bool = false
    var tweetId: Int = -1
    var retweeted: Bool = false
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setFavorited(_ isFavorited: Bool) {
        favorited = isFavorited
        if favorited {
            likeButton.setImage(UIImage(named: "favor-icon-red"), for: UIControl.State.normal)//Basic state to set image
        } else {
            likeButton.setImage(UIImage(named: "favor-icon"), for: UIControl.State.normal)//Basic state to set image
        }
    }
    
    @IBAction func favoriteTweet(_ sender: Any) {
        let toBeFavorited = !favorited
        if toBeFavorited {
            TwitterAPICaller.client?.favoriteTweet(tweetId: tweetId, success: {
                self.setFavorited(true)
            }, failure: { (Error) in
                print("Failed to favorite \(Error)")//Prints the error "Error"
            })
        } else {
            TwitterAPICaller.client?.unfavoriteTweet(tweetId: tweetId, success: {
                self.setFavorited(false)
            }, failure: { (Error) in
                print("Failed to unfavorite")
            })
        }
    }
    
    func setRetweeted(_ isRetweeted: Bool) {
        retweeted = isRetweeted
        if isRetweeted {
            retweetButton.setImage(UIImage(named: "retweet-icon-green"), for: UIControl.State.normal)
            //retweetButton.isEnabled = false//It cannot be tapped when green
        } else {
            retweetButton.setImage(UIImage(named: "retweet-icon"), for: UIControl.State.normal)
            //retweetButton.isEnabled = true
        }
    }
    
    @IBAction func retweetTweet(_ sender: Any) {
//        TwitterAPICaller.client?.retweet(tweetId: tweetId, success: {
//            self.setRetweeted(true)
//        }, failure: { (Error) in
//            print("Failed to retweet: \(Error)")
//        })
        
        let toBeRetweeted = !retweeted
        if toBeRetweeted {
            TwitterAPICaller.client?.retweet(tweetId: tweetId, success: {
                self.setRetweeted(true)
            }, failure: { (Error) in
                print("Failed to retweet: \(Error)")//Prints the error "Error"
            })
        } else {
            TwitterAPICaller.client?.unRetweet(tweetId: tweetId, success: {
                self.setRetweeted(false)
            }, failure: { (Error) in
                print("Failed to unretweet")
            })
        }
    }
    
}
