//
//  WelcomeViewController.swift
//  Spontaneity
//
//  Created by Ayush Saraswat on 11/8/14.
//  Copyright (c) 2014 SwatTech, LLC. All rights reserved.
//

import UIKit
import Parse

class WelcomeViewController: UIViewController {

    @IBOutlet var b_signup: UIButton?
    @IBOutlet var b_signin: UIButton?
    @IBOutlet var b_facebook: UIButton?
    
    var v_signup: UIView?
    var v_login: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        b_signup?.layer.cornerRadius = 6.0
        b_signin?.layer.cornerRadius = 6.0
        b_facebook?.layer.cornerRadius = 6.0

        b_signup?.layer.borderColor = UIColor.blackColor().CGColor
        b_signup?.layer.borderWidth = 1.0
        
        b_signin?.layer.borderColor = UIColor.blackColor().CGColor
        b_signin?.layer.borderWidth = 1.0
        
        var tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: Selector("dismissViews"))
        self.view.addGestureRecognizer(tapGesture)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("adjustViews:"), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("adjustViews:"), name: UIKeyboardWillHideNotification, object: nil)
        
        // Add Sign Up View
        v_signup = UIView()
        let joinViewController: JoinViewController = self.storyboard?.instantiateViewControllerWithIdentifier("Join") as JoinViewController
        self.addChildViewController(joinViewController)
        v_signup?.addSubview(joinViewController.view)
        joinViewController.didMoveToParentViewController(self)
        
        v_signup?.frame = CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 267.0)
        if let signup = v_signup {
            joinViewController.view.frame = signup.bounds
            self.view.addSubview(signup)
        }
        
        // Add Login View
        v_login = UIView()
        let loginViewController: LoginViewController = self.storyboard?.instantiateViewControllerWithIdentifier("Login") as LoginViewController
        self.addChildViewController(loginViewController)
        v_login?.addSubview(loginViewController.view)
        loginViewController.didMoveToParentViewController(self)
        
        v_login?.frame = CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 151.0)
        if let login = v_login {
            loginViewController.view.frame = login.bounds
            self.view.addSubview(login)
        }
        
        var user = PFUser.currentUser()
        if user != nil {
            self.performSegueWithIdentifier("LoggedIn", sender: self)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Sign Up
    
    @IBAction func signWithFacebook() {
        PFFacebookUtils.logInWithPermissions(["email"] as [String], {
            (user: PFUser!, error: NSError!) -> Void in
            if user == nil {
                var alertView: UIAlertController = UIAlertController(title: "Login Failed", message: "Could not login in through Facebook. Please try again later.", preferredStyle: .Alert)
                
                let cancel = UIAlertAction(title: "Dismiss", style: .Default) { (action) in
                }
                alertView.addAction(cancel)

                
                self.presentViewController(alertView, animated: true, completion: nil)
            } else {
                self.performSegueWithIdentifier("LoggedIn", sender: self)
            }
        })
    }
    
    @IBAction func signUp() {
        UIView.animateWithDuration(0.5, animations: {
            if let frame = self.v_signup?.frame {
                self.v_signup?.frame = CGRectMake(frame.origin.x, self.view.frame.size.height - frame.size.height, frame.size.width, frame.size.height)
            }
        })
    }
    
    @IBAction func signIn() {
        UIView.animateWithDuration(0.5, animations: {
            if let frame = self.v_login?.frame {
                self.v_login?.frame = CGRectMake(frame.origin.x, self.view.frame.size.height - frame.size.height, frame.size.width, frame.size.height)
            }
        })
    }
    
    func adjustViews(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            var keyboardSize = userInfo[UIKeyboardFrameEndUserInfoKey]?.CGRectValue().size
            if let keyboard = keyboardSize {
                UIView.animateWithDuration(0.25, animations: {
                    if let frame: CGRect = self.v_signup?.frame {
                        if frame.origin.y != self.view.frame.size.height {
                            self.v_signup?.frame = CGRectMake(frame.origin.x, self.view.frame.size.height - keyboard.height - frame.size.height, frame.size.width, frame.size.height)
                        }
                    }
                    
                    if let frame: CGRect = self.v_login?.frame {
                        if frame.origin.y != self.view.frame.size.height {
                            self.v_login?.frame = CGRectMake(frame.origin.x, self.view.frame.size.height - keyboard.height - frame.size.height, frame.size.width, frame.size.height)
                        }
                    }
                })
            }
        }
    }
    
    func dismissViews() {
        UIView.animateWithDuration(0.5, animations: {
            if let frame = self.v_signup?.frame {
                self.v_signup?.frame = CGRectMake(frame.origin.x, self.view.frame.size.height, frame.size.width, frame.size.height)
            }
            
            if let frame = self.v_login?.frame {
                self.v_login?.frame = CGRectMake(frame.origin.x, self.view.frame.size.height, frame.size.width, frame.size.height)
            }
            
            self.view.endEditing(true)
        })
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
