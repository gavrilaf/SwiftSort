//
//  RandomGenerator.swift
//  SortPerformance
//
//  Created by Eugen Fedchenko on 8/24/16.
//  Copyright © 2016 Eugen Fedchenko. All rights reserved.
//

import Foundation

protocol SimpleRandomGenerator {
    associatedtype Value
    
    func reset()
    func random() -> Value
}


extension SimpleRandomGenerator  {
    
    func generateArray(size: Int) -> [Self.Value] {
        let a = (0...size-1).map{ _ in random() }
        return a
    }
}


struct RandomIntGenerator : SimpleRandomGenerator {
    
    let maxValue: UInt32
    
    init(maxValue: UInt32) {
        self.maxValue = maxValue
    }
    
    func reset() {
    
    }
    
    func random() -> Int {
        return Int(arc4random_uniform(maxValue))
    }
}
