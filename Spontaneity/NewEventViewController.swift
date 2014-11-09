//
//  NewEventViewController.swift
//  Spontaneity
//
//  Created by Ayush Saraswat on 11/9/14.
//  Copyright (c) 2014 SwatTech, LLC. All rights reserved.
//

import UIKit

class NewEventViewController: UIViewController {

    @IBOutlet var name: UITextField?
    @IBOutlet var currentTime: UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        var formatter: NSDateFormatter = NSDateFormatter()
        formatter.timeStyle = .ShortStyle
        
        var timeStamp: NSDateComponents = NSCalendar.currentCalendar().components(.CalendarUnitHour | .CalendarUnitMinute, fromDate: NSDate())
        var minutes = timeStamp.minute
        var minuteUnit = ceil(Double(minutes) / 5.0)
        minutes = Int(minuteUnit * 5.0)
        timeStamp.minute = minutes
        
        currentTime?.text = formatter.stringFromDate(NSCalendar.currentCalendar().dateFromComponents(timeStamp)!)
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
