//
//  UpdateToDoViewController.swift
//  SwiftDone
//
//  Created by Keita on 8/16/15.
//  Copyright (c) 2015 Keita Ito. All rights reserved.
//

import UIKit
import RealmSwift

class UpdateToDoViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var textField: UITextField!
    
    var item: Item?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let item = item {
            textField.text = item.name
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

    @IBAction func cancel(sender: AnyObject) {
        navigationController?.popViewControllerAnimated(true)
    }
    
    
    @IBAction func save(sender: AnyObject) {
        navigationController?.popViewControllerAnimated(true)
    }
}
