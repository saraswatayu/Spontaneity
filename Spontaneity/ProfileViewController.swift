//
//  ProfileViewController.swift
//  Spontaneity
//
//  Created by Ayush Saraswat on 11/8/14.
//  Copyright (c) 2014 SwatTech, LLC. All rights reserved.
//

import UIKit
import Parse

class ProfileViewController: UIViewController {

    @IBOutlet var image: UIImage?
    @IBOutlet var name: UILabel?
    @IBOutlet var email: UILabel?
    
    @IBOutlet var signout: UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        signout?.layer.cornerRadius = 4.0
    }
    
    @IBAction func logout() {
        PFUser.logOut()
        
        self.dismissViewControllerAnimated(true, completion: nil)
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
