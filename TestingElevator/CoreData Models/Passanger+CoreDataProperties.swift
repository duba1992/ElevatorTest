//
//  Passanger+CoreDataProperties.swift
//  TestingElevator
//
//  Created by Duba on 14.07.2018.
//  Copyright © 2018 Duba. All rights reserved.
//
//

import Foundation
import CoreData


extension Passanger {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Passanger> {
        return NSFetchRequest<Passanger>(entityName: "Passanger")
    }

    @NSManaged public var directionUp: Bool
    @NSManaged public var finishFloor: Int32
    @NSManaged public var inElevator: Bool
    @NSManaged public var startFloor: Int32
    @NSManaged public var elevator: Elevator?
    @NSManaged public var floors: Floor?

}
