//
//  LoginViewController.swift
//  Twitter
//
//  Created by cory on 2/16/20.
//  Copyright © 2020 Dan. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {//If bool is true, Home view is immediately displayed
        if UserDefaults.standard.bool(forKey: "isLoggedIn") == true {
            self.performSegue(withIdentifier: "loginHome", sender: self)
        }
    }
    
    @IBAction func onLoginButton(_ sender: Any) {//Upon login/button press, do something
        let loginURL = "https://api.twitter.com/oauth/request_token"
        
        TwitterAPICaller.client?.login(url: loginURL, success: {
            UserDefaults.standard.set(true, forKey: "isLoggedIn")//Will save some value when app is opened (since this is called upon onLoginButton, this can be placed anywhere)
            self.performSegue(withIdentifier: "loginHome", sender: self)//Performs the segue by name
        }, failure: { (Error) in
            print("Could not login!")
        })
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
