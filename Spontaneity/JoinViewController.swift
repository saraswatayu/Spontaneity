//
//  JoinViewController.swift
//  Spontaneity
//
//  Created by Ayush Saraswat on 11/8/14.
//  Copyright (c) 2014 SwatTech, LLC. All rights reserved.
//

import UIKit
import Parse

class JoinViewController: UIViewController {

    @IBOutlet var username: UITextField?
    @IBOutlet var firstName: UITextField?
    @IBOutlet var lastName: UITextField?
    @IBOutlet var email: UITextField?
    @IBOutlet var password: UITextField?
    
    @IBOutlet var join: UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        join?.layer.cornerRadius = 4.0
        
        if let height = username?.frame.size.height {
            var paddingView: UIView = UIView(frame: CGRectMake(0, 0, 16, height))
            username?.leftView = paddingView;
            username?.leftViewMode = .Always
        }
        
        if let height = firstName?.frame.size.height {
            var paddingView: UIView = UIView(frame: CGRectMake(0, 0, 16, height))
            firstName?.leftView = paddingView;
            firstName?.leftViewMode = .Always
        }
        
        if let height = lastName?.frame.size.height {
            var paddingView: UIView = UIView(frame: CGRectMake(0, 0, 16, height))
            lastName?.leftView = paddingView;
            lastName?.leftViewMode = .Always
        }
        
        if let height = email?.frame.size.height {
            var paddingView: UIView = UIView(frame: CGRectMake(0, 0, 16, height))
            email?.leftView = paddingView;
            email?.leftViewMode = .Always
        }
        
        if let height = password?.frame.size.height {
            var paddingView: UIView = UIView(frame: CGRectMake(0, 0, 16, height))
            password?.leftView = paddingView;
            password?.leftViewMode = .Always
        }
    }

    @IBAction func joinSpontaneity() {
        var user: PFUser = PFUser()
        var emptyField: Bool = false
        
        if let username = self.username? { user.username = username.text }
        else { emptyField = true }
        
        if let firstName = self.firstName? { user["firstName"] = firstName.text }
        else { emptyField = true }
        
        if let lastName = self.lastName? { user["lastName"] = lastName.text }
        else { emptyField = true }
        
        if let email = self.email? { user.email = email.text }
        else { emptyField = true }
        
        if let password = self.password? { user.password = password.text }
        else { emptyField = true }
        
        if user.username.utf16Count == 0 || (user["firstName"] as String).utf16Count == 0 || (user["lastName"] as String).utf16Count == 0 || user.email.utf16Count == 0 || user.password.utf16Count == 0 { emptyField = true }
        
        if emptyField {
            displayEmptyFieldError()
            return
        }
        
        user.signUpInBackgroundWithBlock {
            (succeeded: Bool!, error: NSError!) -> Void in
            if error == nil {
                self.parentViewController?.performSegueWithIdentifier("LoggedIn", sender: self)
            } else {
                let errorString = error.userInfo?["error"] as String
                var alertView: UIAlertController = UIAlertController(title: "Signup Failed", message: errorString, preferredStyle: .Alert)
                
                let cancel = UIAlertAction(title: "Dismiss", style: .Cancel) { (action) in
                }
                alertView.addAction(cancel)
                
                self.parentViewController?.presentViewController(alertView, animated: true, completion: nil)
            }
        }
    }
    
    func displayEmptyFieldError() {
        var alertView: UIAlertController = UIAlertController(title: "Signup Error", message: "Please fill in all fields to join Spontaneity.", preferredStyle: .Alert)
        
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
