//
//  NewEventViewController.swift
//  Spontaneity
//
//  Created by Ayush Saraswat on 11/9/14.
//  Copyright (c) 2014 SwatTech, LLC. All rights reserved.
//

import UIKit
import Parse

class NewEventViewController: UIViewController {

    @IBOutlet var name: UITextField?
    @IBOutlet var currentTime: UILabel?
    
    @IBOutlet var m_5: UIButton?
    @IBOutlet var m_15: UIButton?
    @IBOutlet var m_30: UIButton?
    @IBOutlet var h_1: UIButton?
    
    @IBOutlet var location: UITextField?
    
    var groupID: String?
    
    var currentDate: NSDate = NSDate()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        var formatter: NSDateFormatter = NSDateFormatter()
        formatter.timeStyle = .ShortStyle
        
        var timeStamp: NSDateComponents = NSCalendar.currentCalendar().components(.CalendarUnitHour | .CalendarUnitMinute, fromDate: NSDate())
        var minutes = timeStamp.minute
        var minuteUnit = ceil(Double(minutes) / 5.0)
        minutes = Int(minuteUnit * 5.0)
        timeStamp.minute = minutes
        timeStamp.second = 0
        if let date = NSCalendar.currentCalendar().dateFromComponents(timeStamp) {
            currentDate = date
        }
        
        currentTime?.text = formatter.stringFromDate(NSCalendar.currentCalendar().dateFromComponents(timeStamp)!)
        
        m_5?.layer.borderColor = UIColor.whiteColor().CGColor
        m_5?.layer.borderWidth = 2.0
        m_5?.layer.cornerRadius = 25.0
        
        m_15?.layer.borderColor = UIColor.whiteColor().CGColor
        m_15?.layer.borderWidth = 2.0
        m_15?.layer.cornerRadius = 25.0
        
        m_30?.layer.borderColor = UIColor.whiteColor().CGColor
        m_30?.layer.borderWidth = 2.0
        m_30?.layer.cornerRadius = 25.0
        
        h_1?.layer.borderColor = UIColor.whiteColor().CGColor
        h_1?.layer.borderWidth = 2.0
        h_1?.layer.cornerRadius = 25.0
    }
    
    @IBAction func addTime(sender: UIButton) {
        currentDate = currentDate.dateByAddingTimeInterval(Double(sender.tag) * 60.0)
        
        var formatter: NSDateFormatter = NSDateFormatter()
        formatter.timeStyle = .ShortStyle
        currentTime?.text = formatter.stringFromDate(currentDate)
    }
    
    @IBAction func cancel() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func create() {
        if let name = name?.text {
            if let location = location?.text {
                if let groupID = groupID {
                    var event: PFObject = PFObject(className: "Events")
                    event["name"] = name
                    event["location"] = location
                    event["startTime"] = currentDate
                    event["attending"] = "[" + PFUser.currentUser().objectId + "]"
                    event.saveInBackgroundWithBlock {
                        (succeeded: Bool!, error: NSError!) -> Void in
                        if error == nil {
                            var query: PFQuery = PFQuery(className: "Groups")
                            query.getObjectInBackgroundWithId(groupID) {
                                (group: PFObject!, error: NSError!) -> Void in
                                if error == nil {
                                    if let events = group["events"] as? String {
                                        var eventsString = ""
                                        if events.rangeOfString("[") != nil {
                                            eventsString = events.stringByReplacingOccurrencesOfString("]", withString: "")
                                            eventsString += ", " + event.objectId + "]"
                                        } else {
                                            eventsString = "[" + event.objectId + "]"
                                        }
                                        group["events"] = eventsString
                                    }
                                    group.saveInBackgroundWithBlock {
                                        (succeeded: Bool!, error: NSError!) -> Void in
                                        self.dismissViewControllerAnimated(true, completion: nil)
                                    }
                                } else {
                                    
                                }
                            }
                        } else {
                            
                        }
                    }
                } else {
                    
                }
            } else {
                
            }
        }
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
