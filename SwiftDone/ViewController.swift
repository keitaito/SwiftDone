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
    // somthing fetch result controller
    var notificationToken: NotificationToken?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        println(realm)
        
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
        
//        let object = array[indexPath.row]
//        cell.textLabel?.text = object.title
//        cell.detailTextLabel?.text = object.date.description
        
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
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
        if segue.identifier == "addToDoViewController" {
            
            let nc: UINavigationController = segue.destinationViewController as! UINavigationController
            let vc: AddToDoViewController = nc.topViewController as! AddToDoViewController
            
            // Configure View Controller
//            [vc setManagedObjectContext:self.managedObjectContext];
            
        }
    }
    
}


//#pragma mark - Helper methods
//
//- (void)configureCell:(TSPToDoCell *)cell atIndexPath:(NSIndexPath *)indexPath {
//    // Fetch Record
//    NSManagedObject *record = [self.fetchedResultsController objectAtIndexPath:indexPath];
//    
//    // Update Cell
//    [cell.nameLabel setText:[record valueForKey:@"name"]];
//    [cell.doneButton setSelected:[[record valueForKey:@"done"] boolValue]];
//}