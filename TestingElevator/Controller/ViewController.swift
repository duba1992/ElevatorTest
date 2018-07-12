//
//  ViewController.swift
//  TestingElevator
//
//  Created by Duba on 11.07.2018.
//  Copyright © 2018 Duba. All rights reserved.
//

import UIKit
import CoreData
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
       // Init Core Data
        var elevator = CoreDataRequiest.reguistElevator()
        if elevator != nil {
            // remove data
            CoreDataRequiest.deleteAllData(entity: Elevator.typeName)
            CoreDataRequiest.deleteAllData(entity: Floor.typeName)
            CoreDataRequiest.deleteAllData(entity: Passanger.typeName)
        }
            let c = InitCoreData()
            c.setMaxFloorForElevator()
            c.createFloorsWithPassangers()
            elevator = CoreDataRequiest.reguistElevator()
       
        elevator?.basicSettings() // set basic floor, direction and passangers
     
        
        while true {
            elevator?.moveElevator()

            let stop = elevator?.elevatorStop()
            print("Elevator on floor \(elevator?.currentFloor ?? 0)")
            if stop == true {
                
                print("Elevator stop on floor \(elevator?.currentFloor ?? 0)")
                print("With \(elevator?.passangers?.count ?? 0) passangers")
                
                elevator?.exitPassanger()
                elevator?.enterPassanger()
            
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

