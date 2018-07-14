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
        maxPassangers = 5
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
            if elevatorIsFull() {
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
        
        if passangerExit == nil && elevatorIsFull() { // elevator is full
            return false
        }
        let floor = CoreDataRequiest.requistWaiterFloor(elevator: self)

        if floor != nil && elevatorIsFull() == false {//waiters on floor
            return true
        }
        if passangerExit != nil {
            return true 
        }
        return false
    }
    //MARK : - Enter passanger in the elevator and remove from the floor
    func enterPassanger(passangersEntered : ([Passanger]) -> ()) {
 
        let passangerEnter = CoreDataRequiest.requistPassanger(byFloorNumber: currentFloor, andDirection: directionUp)
        guard passangerEnter != nil else {
            return
        }
        var passangersShow = [Passanger]()
        let floor = CoreDataRequiest.reguistFloar(by: currentFloor)
        for pas in passangerEnter! {
            if  elevatorIsFull() {
                break
            }
            pas.inElevator = true
            addToPassangers(pas)
            floor?.removeFromPassangers(pas)
            passangersShow.append(pas)
            DDCoreDataManager.instance.saveContext()
        }
        
        passangersEntered(passangersShow)
    }
    
    
    // exit passanger to the required floor and remove passanger from the elevator
    func exitPassanger(passangersLeft : ([Passanger]) -> ()) {
        let passangersExit = CoreDataRequiest.requistExitPassanger(byFloorNumber: currentFloor, withElevator: self)
        guard passangersExit != nil else {
            return //nobody comes out of the elevator
        }
        let floor = CoreDataRequiest.reguistFloar(by: currentFloor)
        for pas in passangersExit! {
            self.removeFromPassangers(pas)
            
            pas.newPassangerChoise(maxFloor: maxFloor) { (passanger) in
                 floor?.addToPassangers(passanger)
            }
            
            DDCoreDataManager.instance.saveContext()
        }
        
        if self.passangers?.count == 0 {
            emptyElevator()
        }
        passangersLeft(passangersExit!)
    }
    func emptyElevator () {
        let choiseDirection = emptyElevatorChoiseDirection()
        // no one on the floor
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
    //If elevator empty and passengers choose where to go by most direction
    func emptyElevatorChoiseDirection() -> Bool? {
        let pas = CoreDataRequiest.requistEnterPassanger(byFloorNumber: currentFloor)
        guard let enterPassangers = pas else {
            return nil
        }
        let passangerUp = enterPassangers.filter { $0.directionUp == true }
        let passangerDown = enterPassangers.filter { $0.directionUp == false}
        
       
        if passangerUp.count > passangerDown.count {
            directionUp = true
        } else {
            directionUp = false
        }
        return true
    }
    func elevatorIsFull() -> Bool {
        if passangers?.count == Int(maxPassangers) {
            return true
        }
        return false
    }
    
    
    
}


