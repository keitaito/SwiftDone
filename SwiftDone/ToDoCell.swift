//
//  ToDoCell.swift
//  SwiftDone
//
//  Created by Keita on 8/15/15.
//  Copyright (c) 2015 Keita Ito. All rights reserved.
//

import UIKit

typealias DoneClosure = () -> Void

class ToDoCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var doneButton: UIButton!
    
    var doneClousre: DoneClosure?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        setupView()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setupView() {
        let imageNormal = UIImage(named: "button-done-normal")
        let imageSelected = UIImage(named: "button-done-selected")
        
        doneButton.setImage(imageNormal, forState: UIControlState.Normal)
        doneButton.setImage(imageNormal, forState: UIControlState.Disabled)
        doneButton.setImage(imageSelected, forState: UIControlState.Selected)
        doneButton.setImage(imageSelected, forState: UIControlState.Highlighted)
        doneButton.addTarget(self, action: Selector("didTapButton:"), forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    func didTapButton(button: UIButton) {
        println("tapped")
        if let dc = doneClousre {
            dc()
        }
        
    }
}
