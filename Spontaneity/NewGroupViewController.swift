//
//  NewGroupViewController.swift
//  Spontaneity
//
//  Created by Ayush Saraswat on 11/8/14.
//  Copyright (c) 2014 SwatTech, LLC. All rights reserved.
//

import UIKit

class NewGroupViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var name: UITextField?
    @IBOutlet var avatar: UIImageView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.avatar?.layer.cornerRadius = 60.0
        self.avatar?.image = UIImage(forName: "S", size: CGSizeMake(120.0, 120.0))
        
        self.name?.addTarget(self, action: Selector("nameChanged:"), forControlEvents: .EditingChanged)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancel() {
        if let name = name?.text {
            if name.utf16Count == 0 {
                var alertView: UIAlertController = UIAlertController(title: "Cancel Group?", message: "You'll lose any information you entered.", preferredStyle: .Alert)
                
                let goBack = UIAlertAction(title: "Go Back", style: .Default) { (action) in
                    return
                }
                
                let cancel = UIAlertAction(title: "Cancel", style: .Cancel) { (action) in
                }
                
                alertView.addAction(cancel)
                
                self.parentViewController?.presentViewController(alertView, animated: true, completion: nil)
            }
        }
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func nameChanged(textField: UITextField) {
        if textField.text.utf16Count > 0 {
            self.avatar?.image = UIImage(forName: textField.text, size: CGSizeMake(120.0, 120.0))
        } else {
            self.avatar?.image = UIImage(forName: "S", size: CGSizeMake(120.0, 120.0))
        }
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
