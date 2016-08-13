//
//  Node+CoreDataProperties.swift
//  weToExplore
//
//  Created by Daniel Tan on 8/12/16.
//  Copyright © 2016 Gnodnate. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Node {

    @NSManaged var name: String?
    @NSManaged var title: String?

}
