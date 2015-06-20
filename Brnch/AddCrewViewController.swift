//
//  AddCrewViewController.swift
//  Brnch
//
//  Created by MesoLaptop15 on 6/16/15.
//  Copyright (c) 2015 Brnch. All rights reserved.
//

import UIKit
//import FBSDKCoreKit
//import FBSDKShareKit
//import FBSDKLoginKit

class AddCrewViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var invited = ["Amritha Prasad", "Joshua Bisch", "Salih Abdul-Karim"]
    var contacts = ["John Badalamenti", "Deepa Prasad", "Emily Weslosky"]
    
    var sections = ["Invited", "Contacts"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        
        // Do any additional setup after loading the view.
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("AddContactTableViewCell") as! AddContactTableViewCell
        
        switch (indexPath.section) {
        case 0:
            cell.nameLabel?.text = invited[indexPath.row]
            cell.addButton.selected = true
        case 1:
            cell.nameLabel?.text = contacts[indexPath.row]
        default:
            cell.nameLabel?.text = "Other"
        }
        
        
        return cell
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var headerView = UIView(frame: CGRect(x: 0, y:0, width: 320, height: 40))
        
        headerView.backgroundColor = UIColor(white: 0.2, alpha: 0.5)
        
        var label = UILabel(frame: CGRect(x: 10, y:0, width: 300, height: 40))
        
        //label.text = "\(sections[section])"
        label.textColor = UIColor.whiteColor()
        
        switch (section) {
        case 0:
            label.text = "Invited";
            //return sectionHeaderView
        case 1:
            label.text = "Contacts";
            //return sectionHeaderView
                    //return sectionHeaderView
        default:
            label.text = "Other";
        }
        headerView.addSubview(label)
        
            
        
        return headerView
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
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
