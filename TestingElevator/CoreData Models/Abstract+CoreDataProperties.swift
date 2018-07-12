//
//  Abstract+CoreDataProperties.swift
//  TestingElevator
//
//  Created by Duba on 12.07.2018.
//  Copyright © 2018 Duba. All rights reserved.
//
//

import Foundation
import CoreData


extension Abstract {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Abstract> {
        return NSFetchRequest<Abstract>(entityName: "Abstract")
    }


}
