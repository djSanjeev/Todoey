//
//  Item.swift
//  Todoey
//
//  Created by Sanjeev Vyas on 14/07/19.
//  Copyright © 2019 Sanjeev Vyas. All rights reserved.
//

import Foundation
import RealmSwift

class Item : Object {
    
    @objc dynamic var title : String = ""
    @objc dynamic var done : Bool = false
    @objc dynamic var dateCreated :Date?
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
