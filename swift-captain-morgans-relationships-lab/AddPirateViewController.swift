//
//  AddPirateViewController.swift
//  swift-captain-morgans-relationships-lab
//
//  Created by Cenker Demir on 7/23/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit
import CoreData

class AddPirateViewController: UIViewController {

    var store = DataStore.sharedDataStore
    
    @IBOutlet weak var newPirateName: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func saveNewPirate(sender: UIButton) {
        
        let name = self.newPirateName.text!
        
        if name != "" {
            let pirateDescription = NSEntityDescription.entityForName(Pirate.entityName, inManagedObjectContext: store.managedObjectContext)
        
            if let pirateDescription = pirateDescription {
                let newPirate = Pirate(entity: pirateDescription, insertIntoManagedObjectContext: store.managedObjectContext)
                newPirate.name = name
                newPirate.ship = Set<Ship>()
                store.saveContext()
            }
        }
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
}
