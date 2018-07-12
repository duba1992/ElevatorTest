//
//  InitCoreData.swift
//  TestingElevator
//
//  Created by Duba on 12.07.2018.
//  Copyright © 2018 Duba. All rights reserved.
//

import Foundation
import CoreData
class InitCoreData {
    func setMaxFloorForElevator() {
        
        var elevator = CoreDataRequiest.reguistElevator()
        if elevator != nil {
            return
        }
        elevator = Elevator()
        let randomMaxFloar = Int32(arc4random_uniform(20 - 5) + 5)
      
        elevator?.maxFloor = randomMaxFloar
        DDCoreDataManager.instance.saveContext()
    }
    func createFloorsWithPassangers()  {
        let elevator = CoreDataRequiest.reguistElevator()
        if let elevator = elevator {
            let maxFlore : Int = Int(elevator.maxFloor)
            
            for j in 0..<maxFlore {
                let floor = Floor()
                 var passangerArray = [Passanger]()
                floor.elevator = elevator
                floor.numberOfFloor = Int32(j + 1)
               
                let passengersCount = Int(arc4random_uniform(UInt32(10)))
                for _ in 0..<passengersCount {
                    let passanger = Passanger()
                    passanger.startFloor = Int32(j + 1)
                    var finishFloor = passanger.startFloor
                    while passanger.startFloor == finishFloor {
                     finishFloor = Int32(arc4random_uniform(UInt32(maxFlore - 1)) + 1)
                     passanger.finishFloor = finishFloor
                        passanger.inElevator = false
                    }
                    
                    // Choice direction
                    if passanger.startFloor < passanger.finishFloor {
                        passanger.directionUp = true
                    } else {
                        passanger.directionUp = false
                    }
                    floor.addToPassangers(passanger)
                    passangerArray.append(passanger)
                }
                DDCoreDataManager.instance.saveContext()
            }
            
        }
        
    }
    
}
