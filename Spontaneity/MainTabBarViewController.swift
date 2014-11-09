//
//  MainTabBarViewController.swift
//  Spontaneity
//
//  Created by Ayush Saraswat on 11/8/14.
//  Copyright (c) 2014 SwatTech, LLC. All rights reserved.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Groups"
        var addGroup: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: Selector("addGroup"))
        self.navigationItem.rightBarButtonItem = addGroup
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func tabBar(tabBar: UITabBar, didSelectItem item: UITabBarItem!) {
        self.title = item.title
        
        if item.title == "Groups" {
            var addGroup: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: Selector("addGroup"))
            self.navigationItem.rightBarButtonItem = addGroup
        } else {
            self.navigationItem.rightBarButtonItem = nil
        }
    }
    
    func addGroup() {
        self.selectedViewController?.performSegueWithIdentifier("Add Group", sender: self)
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
