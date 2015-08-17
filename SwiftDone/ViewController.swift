//
//  ViewController.swift
//  SwiftDone
//
//  Created by Keita on 8/15/15.
//  Copyright (c) 2015 Keita Ito. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    let realm: Realm = Realm()
    
    var itemsArray: Results<Item> = Realm().objects(Item).sorted("createdAt", ascending: true)
    
    // to update tableView with updated ItemsArray
    var notificationToken: NotificationToken?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        println(realm)
        
        // get notification when itemsArray is updated, then reload tableView
        notificationToken = Realm().addNotificationBlock { [unowned self] note, realm in
            self.tableView.reloadData()
        }

        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - UITableView Delegate and DataSource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: ToDoCell = tableView.dequeueReusableCellWithIdentifier("ToDoCell", forIndexPath: indexPath) as! ToDoCell
        
        self.configureCell(cell, atIndexPath: indexPath)
        
        return cell
    }


    // MARK: - Helper methods
    
    func configureCell(cell: ToDoCell, atIndexPath indexPath: NSIndexPath) -> Void {
        let item = itemsArray[indexPath.row]
        cell.nameLabel.text = item.name
        cell.doneButton.selected = item.done
    }
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

        if segue.identifier == "addToDoViewController" {
            
            let nc: UINavigationController = segue.destinationViewController as! UINavigationController
            let vc: AddToDoViewController = nc.topViewController as! AddToDoViewController
            
            // Configure View Controller
//            [vc setManagedObjectContext:self.managedObjectContext];
            
        }
    }
    
}