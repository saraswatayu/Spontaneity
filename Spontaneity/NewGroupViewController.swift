//
//  NewGroupViewController.swift
//  Spontaneity
//
//  Created by Ayush Saraswat on 11/8/14.
//  Copyright (c) 2014 SwatTech, LLC. All rights reserved.
//

import UIKit
import Parse

class NewGroupViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var name: UITextField?
    @IBOutlet var avatar: UIImageView?
    
    @IBOutlet var search: UITextField?
    @IBOutlet var tableView: UITableView?
    
    var people: [AnyObject] = []
    var searchPeople: [AnyObject] = []
    
    var selectedPeople: [String] = []
    
    var isSearching: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.avatar?.layer.cornerRadius = 60.0
        self.avatar?.image = UIImage(forName: "S", size: CGSizeMake(120.0, 120.0))
        
        self.name?.addTarget(self, action: Selector("nameChanged:"), forControlEvents: .EditingChanged)
        self.search?.addTarget(self, action: Selector("searchTextChanged:"), forControlEvents: .EditingChanged)
        
        selectedPeople.append(PFUser.currentUser().objectId)
        
        var query = PFQuery(className: "_User")
        query.findObjectsInBackgroundWithBlock({
            (objects: [AnyObject]!, error: NSError!) -> Void in
            if error == nil {
                self.people = objects
                self.people.sort({
                    if let firstName = $0["firstName"] as? String {
                        if let firstName2 = $1["firstName"] as?  String {
                            return firstName.lowercaseString < firstName2.lowercaseString
                        }
                    }
                    return false
                })
                for var i = 0; i < self.people.count; i++ {
                    if self.people[i].objectId == PFUser.currentUser().objectId {
                        self.people.removeAtIndex(i)
                        break
                    }
                }
                self.tableView?.reloadData()
            } else {
                let errorString = error.userInfo?["error"] as String
                var alertView: UIAlertController = UIAlertController(title: "Database Error", message: errorString, preferredStyle: .Alert)
                
                let cancel = UIAlertAction(title: "Dismiss", style: .Cancel) { (action) in
                }
                alertView.addAction(cancel)
                
                self.parentViewController?.presentViewController(alertView, animated: true, completion: nil)
            }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation Bar Items
    
    @IBAction func cancel() {
        if let name = name?.text {
            if name.utf16Count != 0 {
                var alertView: UIAlertController = UIAlertController(title: "Cancel Group?", message: "You'll lose any information you entered.", preferredStyle: .Alert)
                
                let goBack = UIAlertAction(title: "Go Back", style: .Default) { (action) in
                    return
                }
                
                let cancel = UIAlertAction(title: "Cancel", style: .Cancel) { (action) in
                }
                
                alertView.addAction(goBack)
                alertView.addAction(cancel)
                
                self.presentViewController(alertView, animated: true, completion: nil)
            }
        }
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func create() {
        if let name = name?.text {
            if name.utf16Count != 0 {
                if selectedPeople.count > 1 {
                    var group: PFObject = PFObject(className: "Groups")
                    group["name"] = name
                    group["members"] = selectedPeople.description
                    group.saveInBackgroundWithBlock {
                        (succeeded: Bool!, error: NSError!) -> Void in
                        if error == nil {
                            self.dismissViewControllerAnimated(true, completion: nil)
                        } else {

                        }
                    }
                } else {
                    var alertView: UIAlertController = UIAlertController(title: "Add People", message: "Add people to your group to spontaneously create events.", preferredStyle: .Alert)
                    let cancel = UIAlertAction(title: "Dismiss", style: .Cancel) { (action) in
                    }
                    alertView.addAction(cancel)
                    self.presentViewController(alertView, animated: true, completion: nil)
                }
            } else {
                var alertView: UIAlertController = UIAlertController(title: "Choose a Name", message: "Choose a name for your group to spontaneously create events.", preferredStyle: .Alert)
                let cancel = UIAlertAction(title: "Dismiss", style: .Cancel) { (action) in
                }
                alertView.addAction(cancel)
                self.presentViewController(alertView, animated: true, completion: nil)
            }
        }
    }
    
    // MARK: - Text Field Change
    
    func nameChanged(textField: UITextField) {
        if textField.text.utf16Count > 0 {
            self.avatar?.image = UIImage(forName: textField.text, size: CGSizeMake(120.0, 120.0))
        } else {
            self.avatar?.image = UIImage(forName: "S", size: CGSizeMake(120.0, 120.0))
        }
    }
    
    func dismissKeyboard() {
        self.view.endEditing(true)
    }
    
    // MARK: - Search
    
    func searchTextChanged(textField: UITextField) {
        if textField.text.utf16Count > 0 {
            searchPeople = people.filter() {
                if let firstName = $0["firstName"] as? String {
                    if let lastName = $0["lastName"] as? String {
                        return firstName.lowercaseString.rangeOfString(textField.text.lowercaseString) != nil || lastName.lowercaseString.rangeOfString(textField.text.lowercaseString) != nil
                    }
                }
                return false
            }
            searchPeople.sort({
                if let firstName = $0["firstName"] as? String {
                    if let firstName2 = $1["firstName"] as?  String {
                        return firstName > firstName2
                    }
                }
                return false
            })
            isSearching = true
        } else {
            isSearching = false
        }
        
        self.tableView?.reloadData()
    }
    
    // MARK: - Table View
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if search?.text.utf16Count > 0 {
            return searchPeople.count
        }
        return people.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: UITableViewCell = self.tableView?.dequeueReusableCellWithIdentifier("people") as UITableViewCell
        
        if let firstName = people[indexPath.row]["firstName"] as? String {
            if let lastName = people[indexPath.row]["lastName"] as? String {
                cell.textLabel.text = firstName + " " + lastName
                if let userID = people[indexPath.row].objectId {
                    if contains(selectedPeople, userID) {
                        cell.accessoryType = .Checkmark
                    } else {
                        cell.accessoryType = .None
                    }
                }
            }
        }

        if let searchText = search?.text {
            if searchText.utf16Count > 0 {
                cell.textLabel.text = (searchPeople[indexPath.row]["firstName"] as? String)! + " " + (searchPeople[indexPath.row]["lastName"] as? String)!
                if let userID = searchPeople[indexPath.row].objectId {
                    if contains(selectedPeople, userID) {
                        cell.accessoryType = .Checkmark
                    } else {
                        cell.accessoryType = .None
                    }
                }
            }
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if let userID = people[indexPath.row].objectId {
            if contains(selectedPeople, userID) {
                for var i = 0; i < selectedPeople.count; i++ {
                    if selectedPeople[i] == userID {
                        selectedPeople.removeAtIndex(i)
                    }
                }
            } else {
                selectedPeople.append(userID)
            }
        }
        
        if let searchText = search?.text {
            if searchText.utf16Count > 0 {
                if let userID = searchPeople[indexPath.row].objectId {
                    if contains(selectedPeople, userID) {
                        for var i = 0; i < selectedPeople.count; i++ {
                            if selectedPeople[i] == userID {
                                selectedPeople.removeAtIndex(i)
                            }
                        }
                    } else {
                        selectedPeople.append(userID)
                    }
                }
            }
        }
        
        self.tableView?.reloadData()
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
