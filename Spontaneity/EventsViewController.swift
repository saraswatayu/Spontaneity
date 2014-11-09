//
//  EventsViewController.swift
//  Spontaneity
//
//  Created by Ayush Saraswat on 11/8/14.
//  Copyright (c) 2014 SwatTech, LLC. All rights reserved.
//

import UIKit
import Parse

class EventsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var tableView: UITableView?
    var events: [AnyObject] = []
    var groupID: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView?.estimatedRowHeight = 56.0
        self.tableView?.rowHeight = UITableViewAutomaticDimension
        
        self.tableView?.contentInset = UIEdgeInsetsMake(-1.0, 0.0, 0.0, 0.0)
    }
    
    override func viewDidAppear(animated: Bool) {
        if let groupID = groupID {
            var query = PFQuery(className: "Groups")
            query.getObjectInBackgroundWithId(groupID) {
                (groupEvent: PFObject!, error: NSError!) -> Void in
                if error == nil {
                    if let groupEvents = groupEvent["events"] as? String {
                        var eventString = groupEvents.stringByReplacingOccurrencesOfString("[", withString: "").stringByReplacingOccurrencesOfString("]", withString: "")
                        var eventIDs: [String] = eventString.componentsSeparatedByString(", ")
                        println(eventIDs.description)
                        var eventQuery = PFQuery(className: "Events")
                        eventQuery.findObjectsInBackgroundWithBlock({
                            (objects: [AnyObject]!, error: NSError!) -> Void in
                            for var i = objects.count - 1; i >= 0; i-- {
                                if contains(eventIDs, objects[i].objectId) {
                                    self.events.append(objects[i])
                                }
                            }
                            self.tableView?.reloadData()
                        })
                    }
                } else {
                    
                }
            }
        }
    }

    // MARK: - Table View
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return events.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: UITableViewCell = self.tableView?.dequeueReusableCellWithIdentifier("events") as UITableViewCell
        
        (cell.viewWithTag(100) as UILabel).text = events[indexPath.section]["name"] as? String
        
        var startDate: NSDate = events[indexPath.section]["startTime"] as NSDate
        var dateFormatter: NSDateFormatter = NSDateFormatter()
        dateFormatter.timeStyle = .ShortStyle
        (cell.viewWithTag(200) as UILabel).text = dateFormatter.stringFromDate(startDate)
        
        var attending: String = events[indexPath.section]["attending"] as String
        attending = attending.stringByReplacingOccurrencesOfString("[", withString: "").stringByReplacingOccurrencesOfString("]", withString: "")
        var attendingList: [String] = attending.componentsSeparatedByString(", ")
        var attendingString = ""
        /*for attendee: String in attendingList {
            var query = PFQuery(className: "User")
            query.getObjectInBackgroundWithId(attendee) {
                (user: PFObject!, error: NSError!) -> Void in
                attendingString += user["firstName"]
            }
        }*/
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 1.0
        }
        return 0.0
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 56.0
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "Add Event" {
            let navController: UINavigationController = segue.destinationViewController as UINavigationController
            let newEventController: NewEventViewController = navController.viewControllers[0] as NewEventViewController
            newEventController.groupID = self.groupID
        }
    }
}
