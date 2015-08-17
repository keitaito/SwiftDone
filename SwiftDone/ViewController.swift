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
    
    var selection: NSIndexPath?
    
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
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }

    func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        selection = indexPath
        return indexPath
    }

    // MARK: - Helper methods
    
    func configureCell(cell: ToDoCell, atIndexPath indexPath: NSIndexPath) -> Void {
        let item = itemsArray[indexPath.row]
        cell.nameLabel.text = item.name
        cell.doneButton.selected = item.done
        
        cell.doneClousre = {() -> Void in
            var isDone: Bool = item.done
            println(isDone)
            self.realm.write {
                item.done = !isDone
                println(item.done)
            }
        }
        
    }
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

        if segue.identifier == "addToDoViewController" {
            
            let nc: UINavigationController = segue.destinationViewController as! UINavigationController
            let vc: AddToDoViewController = nc.topViewController as! AddToDoViewController
            
            // Configure View Controller
//            [vc setManagedObjectContext:self.managedObjectContext];
            
        } else if segue.identifier == "updateToDoViewController" {
            let vc: UpdateToDoViewController = segue.destinationViewController as! UpdateToDoViewController
            
            if let selection = selection {
                let item: Item = itemsArray[selection.row]
                println(item.name)
                
                vc.item = item
                self.selection = nil
            }
        }
    }
    
}