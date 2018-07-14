//
//  PassangerFunction.swift
//  TestingElevator
//
//  Created by Duba on 14.07.2018.
//  Copyright © 2018 Duba. All rights reserved.
//

import Foundation

extension Passanger {

    public func newPassangerChoise(maxFloor : Int32, passenger : (Passanger) -> ()) {
        startFloor = finishFloor // now the passenger is here
        inElevator = false
        randomFinishFloor(withStartFloar: startFloor, andMaxFloor: maxFloor)
        choiseDirection()
        passenger(self)
    }
    
    func randomFinishFloor(withStartFloar number : Int32, andMaxFloor maxFloor : Int32) {
        var choiseFinishFloar = startFloor
        while startFloor == choiseFinishFloar {
            choiseFinishFloar = Int32(arc4random_uniform(UInt32(maxFloor - 1)) + 1)
            finishFloor = choiseFinishFloar
        }
    }
    
    func choiseDirection() {
        if startFloor < finishFloor {
            directionUp = true
        } else {
            directionUp = false
        }
    }
    
    
}
