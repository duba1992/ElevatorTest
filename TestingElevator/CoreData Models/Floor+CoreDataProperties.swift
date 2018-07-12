//
//  Floor+CoreDataProperties.swift
//  TestingElevator
//
//  Created by Duba on 12.07.2018.
//  Copyright © 2018 Duba. All rights reserved.
//
//

import Foundation
import CoreData


extension Floor {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Floor> {
        return NSFetchRequest<Floor>(entityName: "Floor")
    }

    @NSManaged public var numberOfFloor: Int32
    @NSManaged public var elevator: Elevator?
    @NSManaged public var passangers: NSSet?

}

// MARK: Generated accessors for passangers
extension Floor {

    @objc(addPassangersObject:)
    @NSManaged public func addToPassangers(_ value: Passanger)

    @objc(removePassangersObject:)
    @NSManaged public func removeFromPassangers(_ value: Passanger)

    @objc(addPassangers:)
    @NSManaged public func addToPassangers(_ values: NSSet)

    @objc(removePassangers:)
    @NSManaged public func removeFromPassangers(_ values: NSSet)

}
