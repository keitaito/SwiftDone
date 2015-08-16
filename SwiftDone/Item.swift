//
//  Item.swift
//  SwiftDone
//
//  Created by Keita on 8/15/15.
//  Copyright (c) 2015 Keita Ito. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    dynamic var name: String = ""
    dynamic var createdAt: NSDate = NSDate()
    dynamic var done: Bool = false
}
