//
//  Elevator+CoreDataClass.swift
//  TestingElevator
//
//  Created by Duba on 14.07.2018.
//  Copyright © 2018 Duba. All rights reserved.
//
//

import Foundation
import CoreData


public class Elevator: Abstract {
    static public let typeName = "Elevator"
    convenience init() {
        
        self.init(entity: DDCoreDataManager.instance.entityForName(entityName: Elevator.typeName), insertInto: DDCoreDataManager.instance.managedObjectContext)
    }
}
