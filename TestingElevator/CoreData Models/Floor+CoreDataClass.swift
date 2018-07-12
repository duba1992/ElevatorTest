//
//  Floor+CoreDataClass.swift
//  TestingElevator
//
//  Created by Duba on 12.07.2018.
//  Copyright © 2018 Duba. All rights reserved.
//
//

import Foundation
import CoreData


public class Floor: Abstract {
    static public let typeName = "Floor"
    convenience init() {
        
        self.init(entity: DDCoreDataManager.instance.entityForName(entityName: Floor.typeName), insertInto: DDCoreDataManager.instance.managedObjectContext)
    }
}
