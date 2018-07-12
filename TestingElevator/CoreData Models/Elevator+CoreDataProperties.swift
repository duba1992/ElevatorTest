//
//  Elevator+CoreDataProperties.swift
//  TestingElevator
//
//  Created by Duba on 12.07.2018.
//  Copyright © 2018 Duba. All rights reserved.
//
//

import Foundation
import CoreData


extension Elevator {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Elevator> {
        return NSFetchRequest<Elevator>(entityName: "Elevator")
    }

    @NSManaged public var currentFloor: Int32
    @NSManaged public var directionUp: Bool
    @NSManaged public var maxFloor: Int32
    @NSManaged public var floors: NSSet?
    @NSManaged public var passangers: NSSet?

}

// MARK: Generated accessors for floors
extension Elevator {

    @objc(addFloorsObject:)
    @NSManaged public func addToFloors(_ value: Floor)

    @objc(removeFloorsObject:)
    @NSManaged public func removeFromFloors(_ value: Floor)

    @objc(addFloors:)
    @NSManaged public func addToFloors(_ values: NSSet)

    @objc(removeFloors:)
    @NSManaged public func removeFromFloors(_ values: NSSet)

}

// MARK: Generated accessors for passangers
extension Elevator {

    @objc(addPassangersObject:)
    @NSManaged public func addToPassangers(_ value: Passanger)

    @objc(removePassangersObject:)
    @NSManaged public func removeFromPassangers(_ value: Passanger)

    @objc(addPassangers:)
    @NSManaged public func addToPassangers(_ values: NSSet)

    @objc(removePassangers:)
    @NSManaged public func removeFromPassangers(_ values: NSSet)

}
