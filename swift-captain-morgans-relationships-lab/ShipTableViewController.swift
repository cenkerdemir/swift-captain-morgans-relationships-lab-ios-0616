//
//  ShipTableViewController.swift
//  swift-captain-morgans-relationships-lab
//
//  Created by Cenker Demir on 7/22/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit
import CoreData

class ShipTableViewController: UITableViewController {
    
    let store = DataStore.sharedDataStore
    var setForShips: Set<Ship> = []
    var arrayForShips: [Ship] = []
    var pirateNameForShipAdd = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        for ship in setForShips {
//            self.arrayForShips.append(ship)
//        }

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        var pirates: [Pirate] = []
        let pirateFetchRequest = NSFetchRequest(entityName: Pirate.entityName)
        pirateFetchRequest.predicate = NSPredicate(format:"name == %@", self.pirateNameForShipAdd)
        do {
            pirates = try self.store.managedObjectContext.executeFetchRequest(pirateFetchRequest) as! [Pirate]
        } catch let nserror as NSError {
            print("There was an an error: \(nserror)")
        }
        if let ships = pirates[0].ship {
            self.setForShips = ships
        }
        self.arrayForShips = []
        for ship in setForShips {
            self.arrayForShips.append(ship)
        }
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.arrayForShips.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("shipCell", forIndexPath: indexPath)

        // Configure the cell...
        cell.textLabel?.text = self.arrayForShips[indexPath.row].name
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "shipDetailSegue" {
            let shipDetailVC = segue.destinationViewController as! ShipDetailViewController
            if let indexPath = tableView.indexPathForSelectedRow {
                if let shipName = arrayForShips[indexPath.row].name {
                    shipDetailVC.shipName = shipName
                }
                if let pirateName = arrayForShips[indexPath.row].pirate?.name {
                    shipDetailVC.pirateName = pirateName
                }
                if let enginePropulsion = arrayForShips[indexPath.row].engine?.propulsion {
                    shipDetailVC.propulsionName = enginePropulsion
                }
            }
        }
        if segue.identifier == "addShipSegue" {
            let addShipDestVC = segue.destinationViewController as! AddShipViewController
            addShipDestVC.pirateName = self.pirateNameForShipAdd
        }
    }
}
