//
//  Engine+CoreDataProperties.swift
//  swift-captain-morgans-relationships-lab
//
//  Created by Cenker Demir on 7/23/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Engine {

    @NSManaged var propulsion: String?
    @NSManaged var ship: Ship?

}
