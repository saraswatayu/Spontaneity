//
//  LoginViewController.swift
//  Spontaneity
//
//  Created by Ayush Saraswat on 11/8/14.
//  Copyright (c) 2014 SwatTech, LLC. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet var username: UITextField?
    @IBOutlet var password: UITextField?
    
    @IBOutlet var login: UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        login?.layer.cornerRadius = 4.0
    
        if let height = username?.frame.size.height {
            var paddingView: UIView = UIView(frame: CGRectMake(0, 0, 16, height))
            username?.leftView = paddingView;
            username?.leftViewMode = .Always
        }
        
        if let height = password?.frame.size.height {
            var paddingView: UIView = UIView(frame: CGRectMake(0, 0, 16, height))
            password?.leftView = paddingView;
            password?.leftViewMode = .Always
        }
    }
    
    @IBAction func signIntoSpontaneity() {
        var emptyField: Bool = false

        if self.username?.text.utf16Count == 0 || self.password?.text.utf16Count == 0 { emptyField = true }
        
        if emptyField {
            displayEmptyFieldError()
            return
        }
        
        PFUser.logInWithUsernameInBackground(self.username?.text, password:self.password?.text) {
            (user: PFUser!, error: NSError!) -> Void in
            if user != nil {
                self.parentViewController?.performSegueWithIdentifier("LoggedIn", sender: self)
            } else {
                let errorString = error.userInfo?["error"] as String
                var alertView: UIAlertController = UIAlertController(title: "Login Failed", message: errorString, preferredStyle: .Alert)
                
                let cancel = UIAlertAction(title: "Dismiss", style: .Cancel) { (action) in
                }
                alertView.addAction(cancel)
                
                self.parentViewController?.presentViewController(alertView, animated: true, completion: nil)
            }
        }
    }
    
    func displayEmptyFieldError() {
        var alertView: UIAlertController = UIAlertController(title: "Login Error", message: "Please fill in all fields to log into Spontaneity.", preferredStyle: .Alert)
        
        let cancel = UIAlertAction(title: "Dismiss", style: .Cancel) { (action) in
        }
        alertView.addAction(cancel)
        
        self.parentViewController?.presentViewController(alertView, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */

}
