//
//  TweetViewController.swift
//  Twitter
//
//  Created by cory on 2/22/20.
//  Copyright © 2020 Dan. All rights reserved.
//

import UIKit

class TweetViewController: UIViewController {
    
    @IBOutlet weak var tweetTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tweetTextView.becomeFirstResponder()//Upon loading, keyboard pulls up to show it accepts text modification

        // Do any additional setup after loading the view.
    }
    
    @IBAction func cancelTweet(_ sender: Any) {
        dismiss(animated: true, completion: nil)//Dismisses the current view
    }
    
    @IBAction func postTweet(_ sender: Any) {
        if(!tweetTextView.text.isEmpty){
            TwitterAPICaller.client?.postTweet(tweetString: tweetTextView.text, success: {
                self.dismiss(animated: true, completion: nil)//Dismisses, since the twitterAPICaller (upon pressing the "Tweet" button) will publish and post the text in tweetTextView
            }, failure: { (error) in//"error" is of type "Error"
                print("This error message would appear in an alert dialog or something")
                self.dismiss(animated: true, completion: nil)
            })
        } else {
            self.dismiss(animated: true, completion: nil)//In this case, an alert would be made to warn the user there should be some kind of alert here
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
