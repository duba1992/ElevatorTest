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
        _ = InitCoreData()
        elevator = CoreDataRequiest.reguistElevator()
        guard elevator != nil else {
            return
        }
        elevatorWork(elevator: elevator!)
       
        
        
           
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func elevatorWork(elevator : Elevator) {
        
        // set basic floor, direction and passangers
        elevator.basicSettings()
        
        // start
        while true {
            elevator.moveElevator()
            
            let stop = elevator.elevatorStop()
            print("Elevator on floor \(elevator.currentFloor)")
            if stop == true {
                
                print("Elevator stop on floor \(elevator.currentFloor )")
                print("With \(elevator.passangers?.count ?? 0) passangers")
                
                elevator.exitPassanger(passangersLeft: { print ("\($0.count) passangers left")})
                elevator.enterPassanger(passangersEntered: { print ("\($0.count) passangers entered")})
            }
            sleep(3)
        }
       
    }

}

