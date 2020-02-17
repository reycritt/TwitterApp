//
//  HomeTableViewController.swift
//  Twitter
//
//  Created by cory on 2/16/20.
//  Copyright © 2020 Dan. All rights reserved.
//

import UIKit

class HomeTableViewController: UITableViewController {
    var tweetArray = [NSDictionary]()
    var tweetAmount: Int!//"!" means we don't have to set value just yet

    override func viewDidLoad() {
        super.viewDidLoad()
        loadTweets()//Needs to be called here to be used

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    func loadTweets() {
        let url = "https://api.twitter.com/1.1/statuses/home_timeline.json"
        let myParams = ["count": 10]//Creates a parameter for the amount of tweets to pull by a value, in this case 10
        
        TwitterAPICaller.client?.getDictionariesRequest(url: url, parameters: myParams, success: { (tweets: [NSDictionary]) in//"tweets" reffers to the values of NSDictionary
            
            self.tweetArray.removeAll()//Empties array to pull most accurate/recent tweets
            for tweet in tweets {//"tweet" is a value of "tweets"
                self.tweetArray.append(tweet)//Adds a tweet to the tweetArray; writing inside a closure is why "self" is required
            }
            self.tableView.reloadData()//Add this to make sure data is updated
        }, failure: { (Error) in
            print("Could not retrieve tweets! oof")
        })//"Dictionaries" pulls multiple tweets, while "Dictionary" will only pull 1
    }
    
    @IBAction func logout(_ sender: Any) {
        TwitterAPICaller.client?.logout()
        self.dismiss(animated: true, completion: nil)
        UserDefaults.standard.set(false, forKey: "isLoggedIn")//Sets bool to false, since upon login it is forever true
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath) as! TweetCell//Names the cell; as TweetCell allows used of TweetCell's outlets
        let user = tweetArray[indexPath.row]["user"] as! NSDictionary
        
        cell.profileLabel.text = user["name"] as? String//Finds key "name" under "user" key "user"
        cell.tweetLabel.text = tweetArray[indexPath.row]["text"] as? String//Sets the tweetLabel to the value stored in the array under "text"
        
        let imageUrl = URL(string: (user["profile_image_url_https"] as? String)!)//Takes the image URL from API
        let data = try? Data(contentsOf: imageUrl!)//Attempts to set data to the image
        if let imageData = data{
            cell.profileView.image = UIImage(data: imageData)
        }
        
        return cell
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1//Will create amount of rows in the tableview based on the count of tweetArray, which contains the tweets from the NSDicationary
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tweetArray.count
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
