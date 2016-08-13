//
//  WENodeCoreData.swift
//  weToExplore
//
//  Created by Daniel Tan on 8/12/16.
//  Copyright © 2016 Gnodnate. All rights reserved.
//

import Foundation
import CoreData

class WENodeCoreData: NSObject {
    
    func saveNode(title:String, name:String) -> Void {
        let fetchRequest = NSFetchRequest(entityName: "Node")
        fetchRequest.predicate = NSPredicate(format: "title=%@", title)
        do {
            let fetchedData = try self.managedObjectContext.executeFetchRequest(fetchRequest)
            let node = fetchedData.last as! Node
            node.name = name
    
        }catch {
            let node = NSEntityDescription.insertNewObjectForEntityForName("Node", inManagedObjectContext: self.managedObjectContext) as! Node
            node.name = name
            node.title = name
        }
    }
    
    func getNodeNameWith(title:String) -> String? {
        var name:String?;
        let fetchRequest = NSFetchRequest(entityName: "Node")
        fetchRequest.predicate = NSPredicate(format: "title=%@", title)
        do {
            let fetchedData = try self.managedObjectContext.executeFetchRequest(fetchRequest)
            let node = fetchedData.last as! Node
            name = node.name!
        }catch {
            fatalError("failed get \(title)");
        }
        return name
    }
    
    // MARK: - Core Data stack
    var managedObjectContext: NSManagedObjectContext
    override init() {
        // This resource is the same name as your xcdatamodeld contained in your project.
        guard let modelURL = NSBundle.mainBundle().URLForResource("node", withExtension:"momd") else {
            fatalError("Error loading model from bundle")
        }
        // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
        guard let mom = NSManagedObjectModel(contentsOfURL: modelURL) else {
            fatalError("Error initializing mom from: \(modelURL)")
        }
        let psc = NSPersistentStoreCoordinator(managedObjectModel: mom)
        managedObjectContext = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = psc
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0)) {
            let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
            let docURL = urls[urls.endIndex-1]
            /* The directory the application uses to store the Core Data store file.
             This code uses a file named "DataModel.sqlite" in the application's documents directory.
             */
            let storeURL = docURL.URLByAppendingPathComponent("AllNodes.sqlite")
            do {
                try psc.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: storeURL, options: nil)
            } catch {
                fatalError("Error migrating store: \(error)")
            }
        }
    }
}
