//
//  CoreDataRequiest.swift
//  TestingElevator
//
//  Created by Duba on 12.07.2018.
//  Copyright © 2018 Duba. All rights reserved.
//

import Foundation
import CoreData
class CoreDataRequiest {
    //MARK:- Elevator Requist
    static func reguistElevator() -> Elevator? {
        
        var elevator = [Elevator]()
        let fetchRequest = DDCoreDataManager.instance.FetchRequest(forEntityName: Elevator.typeName)

        
        do {
            let result = try DDCoreDataManager.instance.managedObjectContext.fetch(fetchRequest)
            if result.count > 0
            {
                
                elevator =  result as! [NSManagedObject] as! [Elevator]
                
            }
            
        } catch {
            let fetchError = error as NSError
            print(fetchError)
        }
        
        return elevator.count > 0 ? elevator[0] : nil
        
        
    }
    //MARK:- Requist Passangers
    
    static func requistPassanger(byFloorNumber number : Int32, andDirection direction : Bool) -> [Passanger]? {
        var passangers = [Passanger]()
        let fetchRequest = DDCoreDataManager.instance.FetchRequest(forEntityName: Passanger.typeName)
        let fetchPredicate = NSPredicate(format: "startFloor = %d AND directionUp == %@ AND inElevator == NO", number, NSNumber(booleanLiteral: direction))
        fetchRequest.predicate = fetchPredicate
        do {
            let result = try DDCoreDataManager.instance.managedObjectContext.fetch(fetchRequest)
            if result.count > 0 {
                passangers =  result as! [NSManagedObject] as! [Passanger]
            }
            
            
        } catch {
            let fetchError = error as NSError
            print(fetchError)
        }
        
        return passangers.count > 0 ? passangers: nil
        
    }
    
    
    static func requistExitPassanger(byFloorNumber number : Int32, withElevator elevator : Elevator) -> [Passanger]? {
        var passangers = [Passanger]()
        
        let fetchRequest = DDCoreDataManager.instance.FetchRequest(forEntityName: Passanger.typeName)
        let fetchPredicate = NSPredicate(format: "finishFloor = %d AND inElevator == YES", number)
        var sortDescriptor : NSSortDescriptor!
        if elevator.directionUp == true {
            
            sortDescriptor = NSSortDescriptor(key: "finishFloor", ascending: true)
            
        } else {
            
            sortDescriptor = NSSortDescriptor(key: "finishFloor", ascending: false)
        }
        fetchRequest.predicate = fetchPredicate
        fetchRequest.sortDescriptors = [sortDescriptor]
        do {
            let result = try DDCoreDataManager.instance.managedObjectContext.fetch(fetchRequest)
            if result.count > 0 {
                passangers =  result as! [NSManagedObject] as! [Passanger]
            }
            
            
        } catch {
            let fetchError = error as NSError
            print(fetchError)
        }
        
        return passangers.count > 0 ? passangers: nil
    }
    static func requistEnterPassanger(byFloorNumber number : Int32) -> [Passanger]? {
        var passangers = [Passanger]()
        let fetchRequest = DDCoreDataManager.instance.FetchRequest(forEntityName: Passanger.typeName)
        let fetchPredicate = NSPredicate(format: "startFloor = %d  AND inElevator == NO", number)
        fetchRequest.predicate = fetchPredicate
        do {
            let result = try DDCoreDataManager.instance.managedObjectContext.fetch(fetchRequest)
            if result.count > 0 {
                passangers =  result as! [NSManagedObject] as! [Passanger]
            }
            
        } catch {
            let fetchError = error as NSError
            print(fetchError)
        }
        
        return passangers.count > 0 ? passangers: nil
    }
    
    static func requistAllPassangers() -> [Passanger]? {
        
        // function for the test
        var passangers = [Passanger]()
        let fetchRequest = DDCoreDataManager.instance.FetchRequest(forEntityName: Passanger.typeName)
        
        do {
            let result = try DDCoreDataManager.instance.managedObjectContext.fetch(fetchRequest)
            if result.count > 0 {
                passangers =  result as! [NSManagedObject] as! [Passanger]
            }
            
            
        } catch {
            let fetchError = error as NSError
            print(fetchError)
        }
        
        return passangers.count > 0 ? passangers: nil
    }
    //MARK:- Requist Floors
    static func reguistFloar(by floorNumber : Int32) -> Floor? {
        
        var floar = [Floor]()
        let fetchRequest = DDCoreDataManager.instance.FetchRequest(forEntityName: Floor.typeName)
        let fetchPredicate = NSPredicate(format: "numberOfFloor = %d", floorNumber)
        fetchRequest.predicate = fetchPredicate
        do {
            let result = try DDCoreDataManager.instance.managedObjectContext.fetch(fetchRequest)
            if result.count > 0 {
                floar =  result as! [NSManagedObject] as! [Floor]
            }
            
            
        } catch {
            let fetchError = error as NSError
            print(fetchError)
        }
        
        return floar.count > 0 ? floar[0]: nil
        
        
    }
    
    
    static func requistWaiterNearestFloor(elevator : Elevator) -> Floor? {
        var floar : [Floor]!
        let fetchRequest = DDCoreDataManager.instance.FetchRequest(forEntityName: Floor.typeName)
        var fetchPredicate : NSPredicate!
        var sortDescriptor : NSSortDescriptor!
        if elevator.directionUp == true {
                fetchPredicate = NSPredicate(format: "numberOfFloor > %d AND passangers.@count > 0 ", elevator.currentFloor)
                sortDescriptor = NSSortDescriptor(key: "numberOfFloor", ascending: true)
            
        } else {
            fetchPredicate = NSPredicate(format: "numberOfFloor < %d AND passangers.@count > 0", elevator.currentFloor)
            sortDescriptor = NSSortDescriptor(key: "numberOfFloor", ascending: false)
        }
        fetchRequest.predicate = fetchPredicate
        fetchRequest.sortDescriptors = [sortDescriptor]
        do {
            let result = try DDCoreDataManager.instance.managedObjectContext.fetch(fetchRequest)
            if result.count > 0 {
                floar =  result as! [NSManagedObject] as! [Floor]
            }
            
            
        } catch {
            let fetchError = error as NSError
            print(fetchError)
        }
        guard floar != nil else {
            return nil
        }
        
        return floar.count > 0 ? floar[0] : nil
        
    }
    static func requistWaiterFloor(elevator : Elevator) -> Floor? {
        var floar = [Floor]()
        let fetchRequest = DDCoreDataManager.instance.FetchRequest(forEntityName: Floor.typeName)
        var fetchPredicate : NSPredicate!
        var sortDescriptor : NSSortDescriptor!
         fetchPredicate = NSPredicate(format: "numberOfFloor = %d AND passangers.@count > 0 ", elevator.currentFloor)
        if elevator.directionUp == true {
           
            sortDescriptor = NSSortDescriptor(key: "numberOfFloor", ascending: true)
        } else {

            sortDescriptor = NSSortDescriptor(key: "numberOfFloor", ascending: false)
        }
        fetchRequest.predicate = fetchPredicate
        fetchRequest.sortDescriptors = [sortDescriptor]
        do {
            let result = try DDCoreDataManager.instance.managedObjectContext.fetch(fetchRequest)
            if result.count > 0 {
                floar =  result as! [NSManagedObject] as! [Floor]
            }
            
            
        } catch {
            let fetchError = error as NSError
            print(fetchError)
        }
        
        return floar.count > 0 ? floar[0] : nil
        
    }
    
    
    //MARK: Delete data by entity
    static  func deleteAllData(entity: String)
    {
        let fetchRequest = DDCoreDataManager.instance.FetchRequest(forEntityName: Passanger.typeName)
    
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do
        {
            _ = try DDCoreDataManager.instance.managedObjectContext.execute(deleteRequest)
            
        } catch let error as NSError {
            print("Detele all data in \(entity) error : \(error) \(error.userInfo)")
        }
    }

}
