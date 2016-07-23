//
//  AddShipViewController.swift
//  swift-captain-morgans-relationships-lab
//
//  Created by Cenker Demir on 7/23/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit
import CoreData

class AddShipViewController: UIViewController {
    
    var pirateName = ""
    let store = DataStore.sharedDataStore
    var pirates:[Pirate] = []
    
    @IBOutlet weak var newShipNameText: UITextField!
    @IBOutlet weak var PropulsionTypeText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveNewShipTapped(sender: UIButton) {
        let pirateFetchRequest = NSFetchRequest(entityName: Pirate.entityName)
        pirateFetchRequest.predicate = NSPredicate(format:"name == %@", self.pirateName)
        do {
            self.pirates = try self.store.managedObjectContext.executeFetchRequest(pirateFetchRequest) as! [Pirate]
        } catch let nserror as NSError {
            print("There was an an error: \(nserror)")
        }
        
       let shipDescription = NSEntityDescription.entityForName(Ship.entityName, inManagedObjectContext: store.managedObjectContext)
       let engineDescription = NSEntityDescription.entityForName(Engine.entityName, inManagedObjectContext: store.managedObjectContext)
        
        if let shipDescription = shipDescription, let engineDescription = engineDescription {
            let newShip: Ship = Ship(entity: shipDescription, insertIntoManagedObjectContext: store.managedObjectContext)
            let newEngine: Engine = Engine(entity: engineDescription, insertIntoManagedObjectContext: store.managedObjectContext)
            newShip.name = self.newShipNameText.text!
            newShip.engine = newEngine
            newShip.pirate = self.pirates[0]
            newEngine.propulsion = self.PropulsionTypeText.text!
            newEngine.ship = newShip
            self.pirates[0].ship?.insert(newShip)
            
            store.saveContext()
        }
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
}
