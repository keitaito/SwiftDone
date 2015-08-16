//
//  AddToDoViewController.swift
//  SwiftDone
//
//  Created by Keita on 8/15/15.
//  Copyright (c) 2015 Keita Ito. All rights reserved.
//

import UIKit
import RealmSwift

class AddToDoViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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

    // MARK: - Actions
    @IBAction func cancel(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func save(sender: AnyObject) {
//        self.dismissViewControllerAnimated(true, completion: nil)
        
        let name: String = textField.text
        
        if name.isEmpty {
            let alertView: UIAlertView = UIAlertView(title: "warning", message: "failed", delegate: nil, cancelButtonTitle: "OK")
            return alertView.show()
        } else {
            let item = Item()
            item.name = name
            item.createdAt = NSDate()
            
            let realm = Realm()
            realm.write {
                realm.add(item)
            }
            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }
}
