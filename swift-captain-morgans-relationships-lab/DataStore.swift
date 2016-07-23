//
//  DataStore.swift
//  swift-captain-morgans-relationships-lab
//
//  Created by Cenker Demir on 7/22/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import Foundation
import CoreData

class DataStore {
    var pirates:[Pirate] = []
    var ships: [Ship] = []
    var engines: [Engine] = []
    
    static let sharedDataStore = DataStore()
    
    func saveContext () {
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
                abort()
            }
        }
    }
    
    func fetchData ()
    {
        
        var error:NSError? = nil
        
        let pirateRequest = NSFetchRequest(entityName: Pirate.entityName)
        let shipRequest = NSFetchRequest(entityName: Ship.entityName)
        let engineRequest = NSFetchRequest(entityName: Engine.entityName)
        
        let nameSorter = NSSortDescriptor(key: "name", ascending: true)
        let engineSorter = NSSortDescriptor(key: "propulsion", ascending: true)
        
        pirateRequest.sortDescriptors = [nameSorter]
        shipRequest.sortDescriptors = [nameSorter]
        engineRequest.sortDescriptors = [engineSorter]
        
        do{
            pirates = try managedObjectContext.executeFetchRequest(pirateRequest) as! [Pirate]
            ships = try managedObjectContext.executeFetchRequest(shipRequest) as! [Ship]
            engines = try managedObjectContext.executeFetchRequest(engineRequest) as! [Engine]

        }catch let nserror1 as NSError{
            error = nserror1
            print(error)
            pirates = []
            ships = []
            engines = []
        }
        
        if pirates.count == 0 {
            generateTestData()
        }
        
        ////         perform a fetch request to fill an array property on your datastore
    }
    
    func generateTestData() {
        //Ships
        let ship1 = NSEntityDescription.insertNewObjectForEntityForName(Ship.entityName, inManagedObjectContext: managedObjectContext) as! Ship
        ship1.name = "Beyaz"
        
        let ship2 = NSEntityDescription.insertNewObjectForEntityForName(Ship.entityName, inManagedObjectContext: managedObjectContext) as! Ship
        ship2.name = "Kumru"
        
        let ship3 = NSEntityDescription.insertNewObjectForEntityForName(Ship.entityName, inManagedObjectContext: managedObjectContext) as! Ship
        ship3.name = "Freedom"
        
        let ship4 = NSEntityDescription.insertNewObjectForEntityForName(Ship.entityName, inManagedObjectContext: managedObjectContext) as! Ship
        ship4.name = "Blue"
        
        let ship5 = NSEntityDescription.insertNewObjectForEntityForName(Ship.entityName, inManagedObjectContext: managedObjectContext) as! Ship
        ship5.name = "Dark Sky"
        
        let ship6 = NSEntityDescription.insertNewObjectForEntityForName(Ship.entityName, inManagedObjectContext: managedObjectContext) as! Ship
        ship6.name = "Vodoo"
        
        let ship7 = NSEntityDescription.insertNewObjectForEntityForName(Ship.entityName, inManagedObjectContext: managedObjectContext) as! Ship
        ship7.name = "Swamp"
        
        //Engines
        let engine1 = NSEntityDescription.insertNewObjectForEntityForName(Engine.entityName, inManagedObjectContext: managedObjectContext) as! Engine
        engine1.propulsion = "Nuclear"
        
        let engine2 = NSEntityDescription.insertNewObjectForEntityForName(Engine.entityName, inManagedObjectContext: managedObjectContext) as! Engine
        engine2.propulsion = "Solar"
        
        let engine3 = NSEntityDescription.insertNewObjectForEntityForName(Engine.entityName, inManagedObjectContext: managedObjectContext) as! Engine
        engine3.propulsion = "Wind"
        
        let engine4 = NSEntityDescription.insertNewObjectForEntityForName(Engine.entityName, inManagedObjectContext: managedObjectContext) as! Engine
        engine4.propulsion = "Nuclear"
        
        let engine5 = NSEntityDescription.insertNewObjectForEntityForName(Engine.entityName, inManagedObjectContext: managedObjectContext) as! Engine
        engine5.propulsion = "Solar"
        
        let engine6 = NSEntityDescription.insertNewObjectForEntityForName(Engine.entityName, inManagedObjectContext: managedObjectContext) as! Engine
        engine6.propulsion = "Wind"
        
        let engine7 = NSEntityDescription.insertNewObjectForEntityForName(Engine.entityName, inManagedObjectContext: managedObjectContext) as! Engine
        engine7.propulsion = "Wind"
        
        //Pirates
        let pirate1: Pirate = NSEntityDescription.insertNewObjectForEntityForName(Pirate.entityName, inManagedObjectContext: managedObjectContext) as! Pirate
        pirate1.name = "Barbaros"
        
        let pirate2 = NSEntityDescription.insertNewObjectForEntityForName(Pirate.entityName, inManagedObjectContext: managedObjectContext) as! Pirate
        pirate2.name = "Long John Silver"
        
        
        let pirate3 = NSEntityDescription.insertNewObjectForEntityForName(Pirate.entityName, inManagedObjectContext: managedObjectContext) as! Pirate
        pirate3.name = "Captain Hook"
        
        //Relationships
        ship1.engine = engine1
        ship2.engine = engine2
        ship3.engine = engine3
        ship4.engine = engine4
        ship5.engine = engine5
        ship6.engine = engine6
        ship7.engine = engine7
        
        
        pirate1.ship?.insert(ship1)
        pirate1.ship?.insert(ship2)
        pirate1.ship?.insert(ship3)
        
        pirate2.ship?.insert(ship4)
        pirate2.ship?.insert(ship5)
        
        pirate3.ship?.insert(ship6)
        pirate3.ship?.insert(ship7)
        
        //saving
        saveContext()
        fetchData()
    }

    // MARK: - Core Data stack
    // Managed Object Context property getter. This is where we've dropped our "boilerplate" code.
    // If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
    
    lazy var managedObjectContext: NSManagedObjectContext = {
        // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) This property is optional since there are legitimate error conditions that could cause the creation of the context to fail.
        let coordinator = self.persistentStoreCoordinator
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()
    
    lazy var managedObjectModel: NSManagedObjectModel = {
        // The managed object model for the application. This property is not optional. It is a fatal error for the application not to be able to find and load its model.
        let modelURL = NSBundle.mainBundle().URLForResource("swift_captain_morgans_relationships_lab", withExtension: "momd")!
        return NSManagedObjectModel(contentsOfURL: modelURL)!
    }()
    
    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it. This property is optional since there are legitimate error conditions that could cause the creation of the store to fail.
        // Create the coordinator and store
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.URLByAppendingPathComponent("swift-captain-morgans-relationships-lab.sqlite")
        var failureReason = "There was an error creating or loading the application's saved data."
        do {
            try coordinator.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: url, options: nil)
        } catch {
            // Report any error we got.
            var dict = [String: AnyObject]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data"
            dict[NSLocalizedFailureReasonErrorKey] = failureReason
            
            dict[NSUnderlyingErrorKey] = error as NSError
            let wrappedError = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            // Replace this with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog("Unresolved error \(wrappedError), \(wrappedError.userInfo)")
            abort()
        }
        
        return coordinator
    }()
    
    //MARK: Application's Documents directory
    // Returns the URL to the application's Documents directory.
    
    lazy var applicationDocumentsDirectory: NSURL = {
        // The directory the application uses to store the Core Data store file. This code uses a directory named "com.FlatironSchool.SlapChat" in the application's documents Application Support directory.
        let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        return urls[urls.count-1]
    }()


}