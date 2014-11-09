//
//  PeopleViewController.swift
//  Spontaneity
//
//  Created by Ayush Saraswat on 11/8/14.
//  Copyright (c) 2014 SwatTech, LLC. All rights reserved.
//

import UIKit

class PeopleViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var tableView: UITableView?
    
    var personNames: [String] = ["Sagar Punhani", "Ayush Saraswat", "Advith"]
    var subtitlesNames: [String] = ["NIGGA PLEASE", "FUCK THAT BLACK BITCH IN THE FUCKING ASSHOLE", "IDC"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //self.tableView?.registerClass(UITableViewCell.self, forCellReuseIdentifier: "person")
        self.tableView?.estimatedRowHeight = 44.0
        self.tableView?.rowHeight = UITableViewAutomaticDimension
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return personNames.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: UITableViewCell = self.tableView?.dequeueReusableCellWithIdentifier("person") as UITableViewCell
        
        cell.textLabel.text = personNames[indexPath.row]
        cell.detailTextLabel?.text = subtitlesNames[indexPath.row]
        
        cell.imageView.image = UIImage(forName: personNames[indexPath.row], size: CGSize(width: 30, height: 30))
        
        return cell
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
