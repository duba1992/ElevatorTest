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
    
    private var elevator : Elevator!
    init() {
        
        setMaxFloorForElevator()
        createFloorsWithPassangers(elevator: elevator)
    }
    private func setMaxFloorForElevator() {
        elevator = Elevator()
        
        let randomMaxFloar = Int32(arc4random_uniform(20 - 5) + 5)
        
        elevator?.maxFloor = randomMaxFloar

    }
    private func createFloorsWithPassangers(elevator : Elevator)  {
        
        let maxFlore : Int = Int(elevator.maxFloor)
        
        for j in 0..<maxFlore {
            let floor = Floor()
            var passangerArray = [Passanger]()
            floor.elevator = elevator
            floor.numberOfFloor = Int32(j + 1)
            
            let passengersCount = Int(arc4random_uniform(UInt32(10)))
            for _ in 0..<passengersCount {
                let passanger = Passanger()
                passanger.startFloor = floor.numberOfFloor
                passanger.finishFloor = passanger.startFloor
                passanger.newPassangerChoise(maxFloor: Int32(maxFlore)) { (pas) in
                    floor.addToPassangers(pas)
                    passangerArray.append(pas)
                }
            DDCoreDataManager.instance.saveContext()
            }
        }
      
    }
   
}
