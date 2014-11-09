//
//  GroupsViewController.swift
//  Spontaneity
//
//  Created by Ayush Saraswat on 11/8/14.
//  Copyright (c) 2014 SwatTech, LLC. All rights reserved.
//

import UIKit
import Parse

class GroupsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var tableView: UITableView?
    var groups: [AnyObject] = []
    var selectedIndex: NSIndexPath = NSIndexPath()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView?.estimatedRowHeight = 60.0
        self.tableView?.rowHeight = UITableViewAutomaticDimension
        
        self.tableView?.contentInset = UIEdgeInsetsMake(-1.0, 0.0, 0.0, 0.0)
    }

    override func viewDidAppear(animated: Bool) {
        var query = PFQuery(className: "Groups")
        query.whereKey("members", containsString: PFUser.currentUser().objectId)
        query.findObjectsInBackgroundWithBlock({
            (objects: [AnyObject]!, error: NSError!) -> Void in
            if error == nil {
                self.groups = objects
                self.tableView?.reloadData()
            } else {
                
            }
        })
    }
    
    // MARK: - Table View
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: UITableViewCell = self.tableView?.dequeueReusableCellWithIdentifier("group") as UITableViewCell
        
        if let groupName = groups[indexPath.row]["name"] as? String {
            cell.textLabel.text = groupName
        }
        
        if let events = groups[indexPath.row]["events"] as? String {
            var parsedEvents = events.stringByReplacingOccurrencesOfString("[", withString: "")
            var eventArray = parsedEvents.componentsSeparatedByString(", ")
            cell.detailTextLabel?.text = String(eventArray.count) + ((eventArray.count > 1) ? " events" : " event")
            cell.accessoryType = .DisclosureIndicator
        } else {
            cell.detailTextLabel?.text = ""
            cell.accessoryType = .None
        }
        
        cell.selectionStyle = .None
        cell.imageView.image = UIImage(forName: groups[indexPath.row]["name"] as? String, size: CGSize(width: 36, height: 36))
        
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if let accessoryType = tableView.cellForRowAtIndexPath(indexPath)?.accessoryType {
            if accessoryType == .DisclosureIndicator {
                selectedIndex = indexPath
                self.performSegueWithIdentifier("View Events", sender: self)
            }
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 56.0
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 1.0
        }
        return 0.0
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "View Events" {
            var destination: EventsViewController = segue.destinationViewController as EventsViewController
            destination.groupID = groups[selectedIndex.row].objectId
        }
    }
}
