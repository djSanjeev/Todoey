//
//  Category.swift
//  Todoey
//
//  Created by Sanjeev Vyas on 14/07/19.
//  Copyright © 2019 Sanjeev Vyas. All rights reserved.
//

import Foundation
import RealmSwift

class Category : Object {
    
    @objc dynamic var name : String = ""
    let items = List<Item> ()
}

