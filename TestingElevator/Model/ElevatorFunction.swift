//
//  ElevatorFunction.swift
//  TestingElevator
//
//  Created by Duba on 12.07.2018.
//  Copyright © 2018 Duba. All rights reserved.
//

import Foundation
import CoreData
extension Elevator {
    func basicSettings() {
        currentFloor = 2 // start on second floor
        var passangersEnter : [Passanger]!
        directionUp = true // choice direction
            while true {
            // Set start passangers for elevator
            passangersEnter = CoreDataRequiest.requistPassanger(byFloorNumber: currentFloor, andDirection: directionUp)

            if passangersEnter != nil {
                //if passengers are on the floor
                break
            }
            // else go to next floor
            moveElevator()

            }
        let floor = CoreDataRequiest.reguistFloar(by: currentFloor)
        guard floor != nil else {
        return
        }
        // enter first passangers
        for pas in passangersEnter {
            if passangers?.count == 5 {
                break
            }
            pas.inElevator = true
            // remove passengers from floor
            floor?.removeFromPassangers(pas)
            addToPassangers(pas)
        }
    }
    
    
    
    
    func roofOrFloor (){
        // Check max flore or first flore and change direction
        if currentFloor == maxFloor {
            directionUp = false
        } else if currentFloor == 1 {
            directionUp = true
        }
        
    }
    
    func moveElevator ()  {
        roofOrFloor()
        if directionUp == true {
            currentFloor =  currentFloor + 1
        } else {
            currentFloor =  currentFloor - 1
        }
        
    }
    //MARK: - Stop the elevetor check
    func elevatorStop() -> Bool {
        
        let passangerExit = CoreDataRequiest.requistExitPassanger(byFloorNumber: currentFloor, withElevator: self)
        
        if passangerExit != nil && passangers?.count == 5 { // elevator is full
            return true
        }
        
        let floor = CoreDataRequiest.requistWaiterFloor(elevator: self)
        
        
        if floor != nil {//waiters on floor
            return true
        }
        if passangerExit != nil {
            return true
        }
        return false
    }
    //MARK : - Enter passanger in the elevator and remove from the floor
    func enterPassanger() {
        
        
        let passangerEnter = CoreDataRequiest.requistPassanger(byFloorNumber: currentFloor, andDirection: directionUp)
        guard passangerEnter != nil else {
            return
        }
        let floor = CoreDataRequiest.reguistFloar(by: currentFloor)
        for pas in passangerEnter! {
            if self.passangers?.count == 5 {
                break
            }
            pas.inElevator = true
            addToPassangers(pas)
            floor?.removeFromPassangers(pas)
            DDCoreDataManager.instance.saveContext()
        }
        
    }
    
    //If elevator empty and passengers choose where to go by most direction
    func emptyElevatorChoiseDirection() -> Bool? {
        let pas = CoreDataRequiest.requistEnterPassanger(byFloorNumber: currentFloor)
        guard let enterPassangers = pas else {
            return nil
        }
        var countUp = 0
        var countDown = 0
        
        for passanger in enterPassangers {
            if currentFloor < passanger.finishFloor {
                countUp = countUp + 1
            } else {
                countDown = countDown + 1
            }
        }
        if countUp > countDown {
            directionUp = true
            return true
        } else {
            directionUp = false
            return true
        }

    }
    // exit passanger to the required floor and remove passanger from the elevator
    func exitPassanger() {
        enterPassanger()
        let passangersExit = CoreDataRequiest.requistExitPassanger(byFloorNumber: currentFloor, withElevator: self)
        guard passangersExit != nil else {
            return //nobody comes out of the elevator
        }
        let floor = CoreDataRequiest.reguistFloar(by: currentFloor)
        for pas in passangersExit! {
            
            
            self.removeFromPassangers(pas)
            pas.startFloor = currentFloor
            var finishFloar = pas.startFloor
            while pas.startFloor == finishFloar {
                finishFloar = Int32(arc4random_uniform(UInt32(maxFloor - 1)) + 1)
                pas.finishFloor = finishFloar
            }
            if pas.startFloor < pas.finishFloor {
                pas.directionUp = true
            } else {
                pas.directionUp = false
            }
            pas.inElevator = false
            floor?.addToPassangers(pas)
            DDCoreDataManager.instance.saveContext()
        }
        
        if self.passangers?.count == 0 {
            // if elevate empty
            let choiseDirection = emptyElevatorChoiseDirection()
            if choiseDirection == nil {
                let floor = CoreDataRequiest.requistWaiterNearestFloor(elevator: self)
                 // if floor empty, find the next flore
                if (floor?.numberOfFloor)! > currentFloor {
                    directionUp = true
                } else {
                    directionUp = false
                }
            
            }
        }
    }
}


