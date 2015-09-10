//
//  Wish+CoreDataProperties.swift
//  Wishful
//
//  Created by Scott Barlow on 8/24/15.
//  Copyright © 2015 Scott Barlow. All rights reserved.
//
//  Delete this file and regenerate it using "Create NSManagedObject Subclass…"
//  to keep your implementation up to date with your model.
//

import Foundation
import CoreData

extension Wish {

    @NSManaged var desc: String?
    @NSManaged var info: String?
    @NSManaged var image: NSData?

}
